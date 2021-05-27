[#ftl]
[@b.head/]
[@b.toolbar  title="配置开关"]bar.addBack();[/@]
[@b.tabs]
  [@b.form action=b.rest.save(signupSetting) theme="list" ]
    [@b.textfield name="signupSetting.grade" label="年级" value="${signupSetting.grade!}" required="true"/]
    [@b.startend label="有效期限"
      name="signupSetting.beginAt,signupSetting.endAt" required="true,true"
      start=signupSetting.beginAt end=signupSetting.endAt format="yyyy-MM-dd HH:mm"/]
    [@b.formfoot]
      [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit"/]
    [/@]
  [/@]
[/@]
[@b.foot/]
