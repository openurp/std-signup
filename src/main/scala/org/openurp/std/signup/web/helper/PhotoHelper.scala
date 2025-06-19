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

package org.openurp.std.signup.web.helper

import org.beangle.commons.file.zip.Zipper
import org.beangle.commons.io.Files
import org.beangle.commons.lang.Strings
import org.beangle.commons.net.http.HttpUtils
import org.beangle.ems.app.EmsApp
import org.openurp.std.signup.model.SignupInfo

import java.io.File

object PhotoHelper {

  def download(infoes: Iterable[SignupInfo]): File = {
    val blob = EmsApp.getBlobRepository(true)

    val setting = infoes.head.setting
    val signupInfoes = infoes.filter(_.photoPath.nonEmpty)
    val dir = new File(System.getProperty("java.io.tmpdir") + s"setting${setting.id}" + Files./ + "batch")
    dir.mkdirs()
    var photoCount = 0
    signupInfoes foreach { si =>
      var fileName = purify(si.name) + " " + si.idcard + "." + Strings.substringAfterLast(si.photoPath.get, ".")
      if (si.code != "--")
        fileName = si.code + " " + fileName

      val photoFile = new File(dir.getAbsolutePath + Files./ + fileName)
      val url = blob.url(si.photoPath.get).get
      HttpUtils.download(url.openConnection(), photoFile)
      photoCount += 1
    }
    val fileName =
      if (photoCount == 1) {
        setting.name + "_" + signupInfoes.head.name + s"的照片.zip"
      } else {
        setting.name + "_" + signupInfoes.head.name + s"等${photoCount}照片.zip"
      }
    val targetZip = new File(System.getProperty("java.io.tmpdir") + s"setting${setting.id}" + Files./ + s"${fileName}.zip")
    Zipper.zip(dir, targetZip)
    Files.travel(dir, f => f.delete())
    targetZip
  }

  private def purify(name: String): String = {
    var n = Strings.replace(name, "（", "(")
    if (n.contains("(")) {
      n = Strings.substringBefore(n, "(")
    }
    n = Strings.replace(n, ")", "")
    n = Strings.replace(n, ".", "")
    n
  }
}
