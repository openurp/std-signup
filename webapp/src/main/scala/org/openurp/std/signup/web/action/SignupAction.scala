/*
 * OpenURP, Agile University Resource Planning Solution.
 *
 * Copyright © 2014, The OpenURP Software.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful.
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.openurp.std.signup.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.annotation.response
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.base.edu.model.Project
import org.openurp.starter.edu.helper.ProjectSupport
import org.openurp.code.edu.model.DisciplineCategory
import org.openurp.code.person.model.Gender
import org.openurp.std.signup.model.{SignupInfo, SignupOption, SignupSetting}

import java.time.Instant

class SignupAction extends RestfulAction[SignupInfo] with ProjectSupport {

  override def indexSetting(): Unit = {
    get("alert").foreach(alert => {
      put("alert", alert)
    })
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

  def optionAjax(): View = {
    val query = OqlBuilder.from(classOf[SignupOption], "option")
    query.orderBy("option.major.name")
    getInt("institutionId").foreach(institutionId => {
      query.where("option.major.institution.id=:id", institutionId)
    })
    populateConditions(query)
    query.limit(getPageLimit)
    put("options", entityDao.search(query))
    forward("optionsJSON")
  }


  override def editSetting(entity: SignupInfo): Unit = {
    put("categories", getCodes(classOf[DisciplineCategory]))
    val query = OqlBuilder.from(classOf[SignupSetting], "c")
    query.where("c.endAt is null or :now between c.beginAt and c.endAt", Instant.now)
    val settings = entityDao.search(query)
    settings.foreach { setting =>
      put("institutions", setting.options.map(_.major.institution).distinct)
      put("options", setting.options)
      put("genders", getCodes(classOf[Gender]))
      put("setting", setting)
    }
    put("project",entityDao.getAll(classOf[Project]).head)
    super.editSetting(entity)
  }

  override def saveAndRedirect(entity: SignupInfo): View = {
    saveOrUpdate(entity)
    redirect("info", s"&id=${entity.id}", "info.save.success")
  }

}
