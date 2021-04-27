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

import java.time.{Instant, LocalDate}
import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.annotation.response
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.boot.edu.helper.ProjectSupport
import org.openurp.code.Code
import org.openurp.code.edu.model.{DisciplineCategory, Institution}
import org.openurp.std.signup.model.{SignupInfo, SignupSetting}

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


	override def editSetting(entity: SignupInfo): Unit = {
		put("institutions", getCodes(classOf[Institution]))
		put("categories", getCodes(classOf[DisciplineCategory]))
		val query = OqlBuilder.from(classOf[SignupSetting], "c")
		query.where("c.endAt is null or :now between c.beginAt and c.endAt", Instant.now)
		val settings = entityDao.search(query)
		settings.foreach(setting => {
			put("minors", setting.minors)
			put("setting", settings.head)
		})
		super.editSetting(entity)
	}

	override def saveAndRedirect(entity: SignupInfo): View = {
		saveOrUpdate(entity)
		redirect("info", s"&id=${entity.id}", "info.save.success")
	}

}
