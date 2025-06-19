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
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.{SignupMajor, SignupSetting}

class SettingAction extends RestfulAction[SignupSetting], ProjectSupport {

  override def editSetting(entity: SignupSetting): Unit = {
    put("majors", entityDao.getAll(classOf[SignupMajor]))
    super.editSetting(entity)
  }

  override def saveAndRedirect(setting: SignupSetting): View = {
    setting.project = getProject
    super.saveAndRedirect(setting)
  }

  override def getQueryBuilder: OqlBuilder[SignupSetting] = {
    val query = super.getQueryBuilder
    query.where("signupSetting.project = :project", getProject)
    query
  }

}
