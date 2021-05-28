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
package org.openurp.std.signup.model

import org.beangle.data.model.LongId
import org.beangle.data.model.pojo.{Coded, Named, Updated}
import org.openurp.code.edu.model.{DisciplineCategory, Institution}
import org.openurp.code.person.model.Gender

import java.time.LocalDate

class SignupInfo extends LongId with Coded with Named with Updated {

  var setting: SignupSetting = _
  /** 性别 */
  var gender: Gender = _

  /** 出生日期 */
  var birthday: LocalDate = _
  /** 身份证号 */
  var idcard: String = _
  /** 电话 */
  var mobile: String = _
  /** 学校 */
  var institution: Institution = _
  /** 院系 */
  var department: String = _
  /** 主修专业 */
  var major: String = _
  /** 班级 */
  var squad: Option[String] = None
  /** 地址 */
  var address: Option[String] = None
  /** 绩点 */
  var gpa: Float = _
  /** 学科门类 */
  var category: DisciplineCategory = _
  /** 辅修专业第一志愿 */
  var firstOption: SignupOption = _
  /** 辅修专业第二志愿 */
  var secondOption: Option[SignupOption] = _

}
