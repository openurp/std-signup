[#ftl]
[@b.head/]
[@b.toolbar title="修改报名专业"]bar.addBack();[/@]
[@b.tabs]
  [#assign sa][#if signupMajor.persisted]!update?id=${signupMajor.id!}[#else]!save[/#if][/#assign]
  [@b.form action=sa theme="list"]
    [@b.textfield name="signupMajor.name" label="名称" value="${signupMajor.name!}" required="true" maxlength="80"/]
    [@b.select name="signupMajor.institution.id" label="所属院校" value="${(signupMajor.institution.id)!}"
               style="width:200px;" items=institutions empty="..." required="true"/]
    [@b.select name="signupMajor.department.id" label="所属院系" items=departments empty="..." required="false"/]
    [@b.startend label="有效期限"
      name="signupMajor.beginOn,signupMajor.endOn" required="true,false"
      start=signupMajor.beginOn end=signupMajor.endOn format="date"/]
    [@b.formfoot]
      [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit"/]
    [/@]
  [/@]
  <div style="height:300px"></div>
[/@]
[@b.foot/]
