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
import org.beangle.webmvc.support.action.{ExportSupport, RestfulAction}
import org.openurp.base.model.Project
import org.openurp.code.edu.model.{DisciplineCategory, Institution}
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.{SignupInfo, SignupSetting}

/** 报名记录管理
 */
class SignupInfoAction extends RestfulAction[SignupInfo], ProjectSupport, ExportSupport[SignupInfo] {

  override def indexSetting(): Unit = {
    given project: Project = getProject

    put("institutions", getCodes(classOf[Institution]))
    put("categories", getCodes(classOf[DisciplineCategory]))
    put("settings", entityDao.findBy(classOf[SignupSetting], "project", project))
    super.indexSetting()
  }

  override protected def getQueryBuilder: OqlBuilder[SignupInfo] = {
    val q = super.getQueryBuilder
    val project: Project = getProject
    q.where("signupInfo.setting.project=:project", project)
    q
  }

}
