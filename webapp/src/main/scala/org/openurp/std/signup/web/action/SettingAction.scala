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

import org.beangle.web.action.view.View
import org.beangle.webmvc.support.action.RestfulAction
import org.openurp.starter.edu.helper.ProjectSupport
import org.openurp.std.signup.model.{SignupMajor, SignupOption, SignupSetting}

class SettingAction extends RestfulAction[SignupSetting] with ProjectSupport {

  override def editSetting(entity: SignupSetting): Unit = {
    put("majors", entityDao.getAll(classOf[SignupMajor]))
    super.editSetting(entity)
  }

  override def saveAndRedirect(entity: SignupSetting): View = {
    super.saveAndRedirect(entity)
  }

}
