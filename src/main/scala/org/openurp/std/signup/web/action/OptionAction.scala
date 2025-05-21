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

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.support.action.RestfulAction
import org.beangle.webmvc.view.View
import org.openurp.base.model.Project
import org.openurp.code.edu.model.Institution
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.{SignupMajor, SignupOption, SignupSetting}

class OptionAction extends RestfulAction[SignupOption], ProjectSupport {

  override def indexSetting(): Unit = {
    given project: Project = getProject

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
    val project = getProject
    val settingId = get("signupSetting.id").get
    put("signupSettingId", settingId)
    val query = OqlBuilder.from(classOf[SignupMajor], "sm")
    query.where("sm.project=:project", project)
    query.where("not exists(from " + classOf[SignupSetting].getName + " ss join ss.options op where op.major=sm and ss.id=" + settingId + ")")
    val majors = entityDao.search(query).toBuffer
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
    if (null == entity.major) {
      val options = getLongIds("major").map { majorId =>
        var option = new SignupOption(entity.setting, entityDao.get(classOf[SignupMajor], majorId))
        option.maxCount = entity.maxCount
        option
      }
      entityDao.saveOrUpdate(options)
      redirect("search", "info.save.success")
    } else {
      super.saveAndRedirect(entity)
    }

  }

}
