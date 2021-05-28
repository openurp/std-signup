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
package org.openurp.std.signup.web.helper

import org.apache.poi.xwpf.usermodel.XWPFDocument
import org.beangle.commons.collection.Collections
import org.beangle.ems.app.EmsApp
import org.openurp.std.signup.model.SignupInfo

import java.io.ByteArrayOutputStream
import java.net.URL

object DocHelper {

  val ApplicationUrl = "application.docx"

  def toDoc(apply: SignupInfo): Array[Byte] = {
    val data = Collections.newMap[String, String]
    data.put("school", apply.institution.name)
    data.put("code", apply.code)
    data.put("name", apply.name)
    data.put("mobile", apply.mobile)
    data.put("gender", apply.gender.name)
    data.put("address", apply.address.getOrElse(""))
    data.put("birthday", apply.birthday.toString)

    data.put("depart", apply.department)
    data.put("major", apply.major)
    data.put("squad", apply.squad.getOrElse(""))

    data.put("firstMajor", apply.firstOption.major.name)
    data.put("firstMajor", apply.secondOption.map(_.major.name).getOrElse(""))

    import java.text.NumberFormat
    val nf = NumberFormat.getNumberInstance
    nf.setMinimumFractionDigits(2)
    nf.setMaximumFractionDigits(2)
    data.put("gpa", nf.format(apply.gpa))

    val url = EmsApp.getFile(ApplicationUrl).get.toURI.toURL
    DocHelper.toDoc(url, data)
  }

  private def toDoc(url: URL, data: collection.Map[String, String]): Array[Byte] = {
    val templateIs = url.openStream()
    val doc = new XWPFDocument(templateIs)
    import scala.jdk.javaapi.CollectionConverters._

    for (p <- asScala(doc.getParagraphs)) {
      val runs = p.getRuns
      if (runs != null) {
        for (r <- asScala(runs)) {
          var text = r.getText(0)
          if (text != null) {
            data.find { case (k, v) => text.contains("${" + k + "}") } foreach { e =>
              text = text.replace("${" + e._1 + "}", e._2)
              r.setText(text, 0)
            }
          }
        }
      }
    }

    for (tbl <- asScala(doc.getTables)) {
      for (row <- asScala(tbl.getRows)) {
        for (cell <- asScala(row.getTableCells)) {
          for (p <- asScala(cell.getParagraphs)) {
            for (r <- asScala(p.getRuns)) {
              var text = r.getText(0)
              if (text != null) {
                data.find { case (k, v) => text.contains("${" + k + "}") } foreach { e =>
                  text = text.replace("${" + e._1 + "}", e._2)
                  r.setText(text, 0)
                }
              }
            }
          }
        }
      }
    }
    val bos = new ByteArrayOutputStream()
    doc.write(bos)
    templateIs.close()
    bos.toByteArray
  }
}
