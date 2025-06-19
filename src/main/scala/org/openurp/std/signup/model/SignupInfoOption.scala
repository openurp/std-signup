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

/** 报名志愿和专业
 */
class SignupInfoOption extends LongId {
  var idx: Int = _
  var info: SignupInfo = _
  var option: SignupOption = _

  def this(idx: Int, info: SignupInfo, option: SignupOption) = {
    this()
    this.idx = idx
    this.info = info
    this.option = option
  }
}
