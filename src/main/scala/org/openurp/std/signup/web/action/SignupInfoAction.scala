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
import org.beangle.commons.file.zip.Zipper
import org.beangle.commons.io.Files
import org.beangle.commons.lang.Strings
import org.beangle.commons.net.http.HttpUtils
import org.beangle.data.dao.OqlBuilder
import org.beangle.ems.app.EmsApp
import org.beangle.webmvc.annotation.mapping
import org.beangle.webmvc.support.action.{ExportSupport, RestfulAction}
import org.beangle.webmvc.view.{Stream, View}
import org.openurp.base.model.Project
import org.openurp.code.edu.model.{DisciplineCategory, Institution}
import org.openurp.starter.web.support.ProjectSupport
import org.openurp.std.signup.model.{SignupInfo, SignupSetting}
import org.openurp.std.signup.web.helper.{DocHelper, PhotoHelper}

import java.io.{ByteArrayInputStream, File}

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

  def download(): View = {
    val signupInfo = entityDao.get(classOf[SignupInfo], getLongId("signupInfo"))
    val bytes = DocHelper.toDoc(signupInfo)
    val contentType = MediaTypes.ApplicationDocx
    Stream(new ByteArrayInputStream(bytes), contentType, signupInfo.code + "_" + signupInfo.name + "_专业报名表.docx")
  }

  /** 批量下载照片
   *
   * @return
   */
  def downloadPhotos(): View = {
    val setting = entityDao.get(classOf[SignupSetting], getIntId("signupInfo.setting"))

    val q = OqlBuilder.from(classOf[SignupInfo], "signupInfo")
    populateConditions(q)
    //    q.where("signupInfo.setting=:setting", setting)
    q.where("signupInfo.photoPath is not null")

    val ids = getLongIds("signupInfo")
    if (ids.nonEmpty) q.where("signupInfo.id in(:ids)", ids)

    val signupInfoes = entityDao.search(q)
    val targetZip = PhotoHelper.download(signupInfoes)
    Stream(targetZip).cleanup(() =>
      targetZip.delete()
    )
  }

  override protected def getQueryBuilder: OqlBuilder[SignupInfo] = {
    val q = super.getQueryBuilder
    val project: Project = getProject
    q.where("signupInfo.setting.project=:project", project)
    q
  }

}
