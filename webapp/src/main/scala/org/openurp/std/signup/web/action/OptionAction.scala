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
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.starter.edu.helper.ProjectSupport
import org.openurp.code.edu.model.Institution
import org.openurp.std.signup.model.{SignupMajor, SignupOption, SignupSetting}

class OptionAction extends RestfulAction[SignupOption] with ProjectSupport {

  override def indexSetting(): Unit = {
    get("signupSetting.id").foreach(signupSettingId => {
      put("signupSettingId", signupSettingId)
    })
    put("institutions", getCodes(classOf[Institution]))
    super.indexSetting()
  }

  override def search(): View = {
    get("signupSetting.id").foreach(signupSettingId => {
      put("signupSettingId", signupSettingId)
    })
    super.search()
  }

  override def editSetting(entity: SignupOption): Unit = {
    val settingId = get("signupSetting.id").get
    put("signupSettingId", settingId)
    val query = OqlBuilder.from(classOf[SignupMajor], "sm")
    query.where("not exists(from " + classOf[SignupSetting].getName + " ss join ss.options op where op.major=sm and ss.id=" + settingId + ")")
    var majors = entityDao.search(query).toBuffer
    if (entity.persisted) {
      majors += entity.major
    }
    put("majors", majors)
    super.editSetting(entity)
  }

  override def saveAndRedirect(entity: SignupOption): View = {
    getInt("signupSetting.id").foreach(signupSettingId => {
      val setting = entityDao.get(classOf[SignupSetting], signupSettingId)
      entity.setting = setting
    })
    super.saveAndRedirect(entity)
  }

}
