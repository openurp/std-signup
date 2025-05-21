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

package org.openurp.std.signup.model

import org.beangle.data.model.LongId
import org.beangle.data.model.pojo.{Named, TemporalOn}
import org.openurp.base.model.{Department, Project}
import org.openurp.code.edu.model.Institution

/**
 * 可报名专业
 */
class SignupMajor extends LongId, Named, TemporalOn {
  var project: Project = _
  var institution: Institution = _
  /** 所在院系 */
  var department: Option[Department] = None
}
