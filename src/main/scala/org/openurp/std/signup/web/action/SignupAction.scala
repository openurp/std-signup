/*
 * Copyright (C) 2014, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.openurp.std.signup.web.action

import jakarta.servlet.http.Part
import org.beangle.commons.activation.MediaTypes
import org.beangle.data.dao.OqlBuilder
import org.beangle.ems.app.EmsApp
import org.beangle.webmvc.annotation.{mapping, response}
import org.beangle.webmvc.support.action.RestfulAction
import org.beangle.webmvc.view.{Stream, View}
import org.openurp.base.model.{Department, Project}
import org.openurp.code.edu.model.DisciplineCategory
import org.openurp.code.person.model.Gender
import org.openurp.std.signup.model.{SignupInfo, SignupMajor, SignupOption, SignupSetting}
import org.openurp.std.signup.web.helper.DocHelper

import java.io.ByteArrayInputStream
import java.time.Instant

/** 学生报名
 */
class SignupAction extends RestfulAction[SignupInfo] {

  override def indexSetting(): Unit = {
    get("alert").foreach(alert => {
      put("alert", alert)
    })
    getSetting(true) foreach { s =>
      put("setting", s)
    }
    super.indexSetting()
  }

  def microIndex(): View = {
    get("alert").foreach(alert => {
      put("alert", alert)
    })
    getSetting(false) foreach { s =>
      put("setting", s)
    }
    forward()
  }

  def checkInfo(): View = {
    val q = OqlBuilder.from(classOf[SignupInfo], "s")
    q.where("s.idcard=:idcard", get("signupInfo.idcard").get.trim)
    get("signupInfo.name") foreach { name =>
      q.where("s.name=:name", name.trim)
    }
    get("signupInfo.code") foreach { code =>
      q.where("s.code=:code", code.trim)
    }

    val signupInfos = entityDao.search(q)
    if (signupInfos.size != 1) {
      val indexName = if get("signupInfo.name").nonEmpty then "microIndex" else "index"
      redirect(indexName, s"&alert=" + true, null)
    } else {
      redirect("info", s"&id=${signupInfos.head.id}", null)
    }
  }

  @response
  def userAjax(): Boolean = {
    val id = getLong("id")
    val card = get("card").orNull
    if (card != null && card != "") {
      val signupInfos = entityDao.findBy(classOf[SignupInfo], "idcard", List(card))
      if (id.isEmpty) {
        if (signupInfos.isEmpty) false else true
      } else {
        val newSignupInfos = signupInfos.filter(e => e.id != id.get)
        if (newSignupInfos.isEmpty) false else true
      }
    } else {
      false
    }
  }

  @mapping(value = "{id}")
  override def info(id: String): View = {
    val info = entityDao.get(classOf[SignupInfo], id.toLong)
    info.photoPath foreach { p =>
      val blob = EmsApp.getBlobRepository(true)
      put("photoUrl", blob.url(p).get.toString)
    }

    put("downloadApplication", DocHelper.getApplicationFile.nonEmpty)
    super.info(id)
  }

  def optionAjax(): View = {
    val query = OqlBuilder.from(classOf[SignupOption], "option")
    query.orderBy("option.major.name")
    getInt("institutionId") match {
      case Some(institutionId) => query.where("option.major.institution.id=:id", institutionId)
      case None => query.where("option.major is null")
    }
    populateConditions(query)
    put("options", entityDao.search(query))
    forward("optionsJSON")
  }

  override def editSetting(info: SignupInfo): Unit = {
    val setting = if info.persisted then info.setting else entityDao.get(classOf[SignupSetting], getIntId("setting"))

    given project: Project = setting.project

    put("categories", entityDao.getAll(classOf[DisciplineCategory]))
    put("institutions", setting.options.map(_.major.institution).distinct)
    if (null != info.firstMajor) {
      val firstMajor = entityDao.get(classOf[SignupMajor], info.firstMajor.id)
      val institution = firstMajor.institution
      val options = setting.options.filter(x => x.major.institution == institution)
      put("options", options)
    } else {
      put("options", List.empty)
    }
    if (info.inside) {
      put("departments", entityDao.findBy(classOf[Department], "school", project.school).filter(_.teaching))
    }
    put("genders", entityDao.getAll(classOf[Gender]))
    put("setting", setting)
    put("project", project)
    super.editSetting(info)
  }

  private def getSetting(minor: Boolean): Option[SignupSetting] = {
    val query = OqlBuilder.from(classOf[SignupSetting], "c")
    query.where("c.project.minor = :minor", minor)
    query.where("c.endAt is null or :now between c.beginAt and c.endAt", Instant.now)
    entityDao.search(query).headOption
  }

  def download(): View = {
    val signupInfo = entityDao.get(classOf[SignupInfo], getLongId("signupInfo"))
    val bytes = DocHelper.toDoc(signupInfo)
    val contentType = MediaTypes.ApplicationDocx
    Stream(new ByteArrayInputStream(bytes), contentType, signupInfo.code + "_" + signupInfo.name + "_辅修专业申请表.docx")
  }

  override def saveAndRedirect(info: SignupInfo): View = {
    if (!info.inside) {
      info.department = "校外"
      info.major = "--"
      info.code = "--"
    }
    getLong("firstOption.id") foreach { optionId =>
      val f = entityDao.get(classOf[SignupOption], optionId)
      info.updateOption(1, f)
    }
    getLong("secondOption.id") match {
      case Some(optionId) =>
        val s = entityDao.get(classOf[SignupOption], optionId)
        info.updateOption(2, s)
      case None => info.removeOption(2)
    }
    if (info.options.map(_.option.major.institution).toSet.size > 1) {
      return forward("edit", "两个专业的学校不一致")
    }
    saveOrUpdate(info)

    val parts = getAll("photoImg", classOf[Part])
    if (parts.nonEmpty && parts.head.getSize > 0) {
      val part = parts.head
      val blob = EmsApp.getBlobRepository(true)
      val meta = blob.upload(s"/signup/${info.id}/",
        part.getInputStream, s"${info.name}.jpg", info.name)
      info.photoPath = Some(meta.filePath)
      entityDao.saveOrUpdate(info)
    }
    redirect("info", s"&id=${info.id}", "info.save.success")
  }

}
