package org.openurp.std.signup.model

import org.beangle.data.model.LongId

/** 报名专业设置
 * */
class SignupOption extends LongId {

  var setting: SignupSetting = _

  var major: SignupMajor = _

  var maxCount: Option[Int] = _

  var curCount: Int = _
}
