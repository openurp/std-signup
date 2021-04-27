package org.openurp.std.signup.web.action

import org.beangle.data.dao.OqlBuilder
import org.beangle.webmvc.api.view.View
import org.beangle.webmvc.entity.action.RestfulAction
import org.openurp.boot.edu.helper.ProjectSupport
import org.openurp.code.edu.model.Institution
import org.openurp.std.signup.model.{SignupMajor, SignupOption, SignupSetting}

class OptionAction extends RestfulAction[SignupOption] with ProjectSupport {

	override def indexSetting(): Unit = {
		get("signupSetting.id").foreach(signupSettingId => {
			put("signupSettingId", signupSettingId)
		})
		put("institutions", getCodes(classOf[Institution]))
		super.indexSetting()
	}

	override def search(): View = {
		get("signupSetting.id").foreach(signupSettingId => {
			put("signupSettingId", signupSettingId)
		})
		super.search()
	}

	override def editSetting(entity: SignupOption): Unit = {
		get("signupSetting.id").foreach(signupSettingId => {
			put("signupSettingId", signupSettingId)
		})
		put("majors", entityDao.getAll(classOf[SignupMajor]))
		super.editSetting(entity)
	}

	override def saveAndRedirect(entity: SignupOption): View = {
		getInt("signupSetting.id").foreach(signupSettingId => {
			val setting = entityDao.get(classOf[SignupSetting], signupSettingId)
			entity.setting = setting
		})
		super.saveAndRedirect(entity)
	}

}
