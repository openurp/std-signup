package org.openurp.std.signup.web.action

import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.boot.edu.helper.ProjectSupport
import org.openurp.code.edu.model.Institution
import org.openurp.std.signup.model.SignupMajor

class MajorAction extends RestfulAction[SignupMajor] with ProjectSupport{

	override def indexSetting(): Unit = {
		put("institutions",getCodes(classOf[Institution]))
		super.indexSetting()
	}

	override def editSetting(entity: SignupMajor): Unit = {
		put("institutions",getCodes(classOf[Institution]))
		super.editSetting(entity)
	}

}
