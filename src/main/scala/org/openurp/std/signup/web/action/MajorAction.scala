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
import org.openurp.base.edu.model.Major
import org.openurp.base.model.Project
import org.openurp.code.edu.model.Institution
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.SignupMajor

import java.time.LocalDate

class MajorAction extends RestfulAction[SignupMajor], ProjectSupport {

  override def indexSetting(): Unit = {
    given project: Project = getProject

    put("institutions", getCodes(classOf[Institution]))
    super.indexSetting()
  }

  override def editSetting(entity: SignupMajor): Unit = {
    given project: Project = getProject

    put("institutions", getCodes(classOf[Institution]))
    put("departments", getDeparts)
    super.editSetting(entity)
  }

  override def saveAndRedirect(entity: SignupMajor): View = {
    entity.project = getProject
    super.saveAndRedirect(entity)
  }

  override def getQueryBuilder: OqlBuilder[SignupMajor] = {
    val query = super.getQueryBuilder
    query.where("signupMajor.project = :project", getProject)
    query
  }

  /** 导入本项目的所有专业
   *
   * @return
   */
  def init(): View = {
    val project = getProject
    val existsMajors = entityDao.findBy(classOf[SignupMajor], "project", project).groupBy(_.name)
    val majors = entityDao.findBy(classOf[Major], "project", project)
    majors foreach { major =>
      if (!existsMajors.contains(major.name) && major.within(LocalDate.now)) {
        val newMajor = new SignupMajor
        newMajor.name = major.name
        newMajor.project = project
        newMajor.beginOn = major.beginOn
        newMajor.department = major.departmentsNow.headOption
        newMajor.institution = project.school.institution
        entityDao.saveOrUpdate(newMajor)
      }
    }
    redirect("search", "导入成功")
  }
}
