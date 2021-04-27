[#ftl]
[@b.head/]
[@b.toolbar title="报名专业设置"]bar.addBack();[/@]
[@b.tabs]
  [#assign sa][#if signupOption.persisted]!update?id=${signupOption.id!}[#else]!save[/#if][/#assign]
  [@b.form action=sa theme="list"]
    <input type="hidden" name="signupSetting.id" value="${signupSettingId!}">
    [@b.select name="signupOption.major.id" label="报名专业" value="${(signupOption.major.id)!}"
    style="width:200px;" items=majors empty="..." required="true"/]
    [@b.textfield name="signupOption.maxCount" label="计划人数" value="${signupOption.maxCount!}" maxlength="80"/]
    [@b.formfoot]
      [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit"/]
    [/@]
  [/@]
[/@]
[@b.foot/]