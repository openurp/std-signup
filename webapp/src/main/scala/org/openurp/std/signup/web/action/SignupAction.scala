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

import org.beangle.commons.activation.MediaTypes
import org.beangle.data.dao.OqlBuilder
import org.beangle.web.action.annotation.{mapping, response}
import org.beangle.web.action.view.{Stream, View}
import org.beangle.webmvc.support.action.RestfulAction
import org.openurp.base.model.Project
import org.openurp.code.edu.model.DisciplineCategory
import org.openurp.code.person.model.Gender
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.{SignupInfo, SignupOption, SignupSetting}
import org.openurp.std.signup.web.helper.DocHelper

import java.io.ByteArrayInputStream
import java.time.Instant

class SignupAction extends RestfulAction[SignupInfo] with ProjectSupport {

  override def indexSetting(): Unit = {
    get("alert").foreach(alert => {
      put("alert", alert)
    })
    getSetting foreach { s =>
      put("setting", s)
    }
    super.indexSetting()
  }

  def checkInfo(): View = {
    val signupInfos = entityDao.search(getQueryBuilder)
    if (signupInfos.isEmpty) {
      redirect("index", s"&alert=" + true, null)
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
    query.limit(getPageLimit)
    put("options", entityDao.search(query))
    forward("optionsJSON")
  }

  override def editSetting(entity: SignupInfo): Unit = {
    given project:Project = getProject

    put("categories", getCodes(classOf[DisciplineCategory]))
    getSetting foreach { setting =>
      put("institutions", setting.options.map(_.major.institution).distinct)
      if (null != entity.firstOption) {
        val options = setting.options.filter(x => x.major.institution == entity.firstOption.major.institution)
        put("options", options)
      } else {
        put("options", List.empty)
      }
      put("genders", getCodes(classOf[Gender]))
      put("setting", setting)
    }
    put("project", entityDao.getAll(classOf[Project]).head)
    super.editSetting(entity)
  }

  private def getSetting: Option[SignupSetting] = {
    val query = OqlBuilder.from(classOf[SignupSetting], "c")
    query.where("c.endAt is null or :now between c.beginAt and c.endAt", Instant.now)
    entityDao.search(query).headOption
  }

  def download(): View = {
    val signupInfo = entityDao.get(classOf[SignupInfo], longId("signupInfo"))
    val bytes = DocHelper.toDoc(signupInfo)
    val contentType = MediaTypes.get("docx", MediaTypes.ApplicationOctetStream).toString
    Stream(new ByteArrayInputStream(bytes), contentType, signupInfo.code + "_" + signupInfo.name + "_辅修专业申请表.docx")
  }

  override def saveAndRedirect(entity: SignupInfo): View = {
    saveOrUpdate(entity)
    if (entity.secondOption != null && entity.secondOption.nonEmpty) {
      val f = entityDao.get(classOf[SignupOption], entity.firstOption.id)
      val s = entityDao.get(classOf[SignupOption], entity.secondOption.get.id)
      if (f.major.institution != s.major.institution) {
        return forward("edit", "两个志愿的学校不一致")
      }
    }
    redirect("info", s"&id=${entity.id}", "info.save.success")
  }

}
