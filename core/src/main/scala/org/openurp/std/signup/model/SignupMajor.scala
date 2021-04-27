package org.openurp.std.signup.model

import org.beangle.data.model.LongId
import org.beangle.data.model.pojo.{Named, TemporalOn}
import org.openurp.code.edu.model.Institution

/**
 * 可报名专业
 */
class SignupMajor extends LongId with Named with TemporalOn {

  var institution: Institution = _
}
