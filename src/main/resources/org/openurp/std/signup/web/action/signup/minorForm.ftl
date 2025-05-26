[#ftl]
[@b.head/]
<div class="container-md" style="margin-top: 10px">
  <div class="card card-info card-outline">
    <div class="card-header">
      <i class="fas fa-school"></i>&nbsp;${project.school.name} ${project.name}报名<span style="font-size:0.8em">(${setting.beginAt?string("MM-dd HH:mm")}~${(setting.endAt?string("MM-dd HH:mm"))!})</span>
    </div>
    <div class="card-body">
      <div style="width: 600px;margin: 0 auto;">
        [@b.form action=b.rest.save(signupInfo) theme="list" onsubmit="syncEditor" title=project.name+"报名" name="signupInfoForm"]
            [#assign comment=""/]
            [#if queryStdEnabled][#assign comment="输入学号和身份证号后,系统自动查找修读信息"/][/#if]
            [@b.textfield name="signupInfo.code" label="学号" value="${signupInfo.code!}" required="true"  onchange="queryStudent(this.form)" comment=comment/]
            [@b.textfield name="signupInfo.idcard" label="身份证号" value="${signupInfo.idcard!}" required="true"  onchange="queryStudent(this.form)"
               id="signupInfo.idcard" maxlength="18" comment='<span id="idcardSpan"></span>'/]
            [@b.textfield name="signupInfo.name" label="姓名" value="${signupInfo.name!}" required="true"/]
            [@b.select name="signupInfo.gender.id" label="性别" value=signupInfo.gender! style="width:200px;" items=genders option="id,name" empty="..."  required="true"/]
            [@b.date name="signupInfo.birthday" label="出生年月" value=signupInfo.birthday!  required="true"/]
            [@b.textfield id="signupInfo.mobile" name="signupInfo.mobile" label="手机电话" maxlength="11" value="${signupInfo.mobile!}" required="true"/]
            [@b.textfield id="signupInfo.address" name="signupInfo.address" label="联系地址" maxlength="200" style="width:300px" value="${signupInfo.address!}" required="true"/]
            [@b.textfield name="signupInfo.department" label="主修院系" value="${signupInfo.department!}" required="true"/]
            [@b.select name="signupInfo.category.id" label="主修学科门类" value="${(signupInfo.category.id)!}"
            style="width:200px;" items=categories option="id,name" empty="..."  required="true"/]
            [@b.textfield name="signupInfo.major" label="主修专业" value="${signupInfo.major!}" required="true"/]
            [@b.textfield name="signupInfo.squad" label="所在班级" value="${signupInfo.squad!}" required="true"/]
            [@b.textfield name="signupInfo.gpa" id="signupInfo.gpa" label="绩点" value=signupInfo.gpa! required="true"/]

          [#if setting.options?size==1]
            [@b.field label="报名专业"]
               <input type="hidden" name="signupInfo.institution.id" value="${setting.options?first.major.institution.id}"/>
               <input type="hidden" id="firstOption" name="firstOption.id" value="${setting.options?first.id}"/>
               <input type="hidden" id="secondOption" name="secondOption.id" value=""/>
               ${(setting.options?first.major.institution.name)!} ${setting.options?first.major.name}
            [/@]
          [#else]
            [@b.select name="signupInfo.institution.id" id="institution" label="报名院校" value=institutions?first
               style="width:200px;" items=institutions option="id,name" empty="..."  required="true" onchange="fetchOptions(this)"/]
            [@b.select name="firstOption.id" id="firstOption" label="专业一" value="${(firstOption.id)!}"
                       style="width:200px;" items=options option=r" ${(item.major.institution.name)} ${(item.major.name)}" empty="..."  required="true"/]
            [@b.select name="secondOption.id" id="secondOption" label="专业二" value="${(secondOption.id)!}"
                       style="width:200px;" items=options option=r"${(item.major.institution.name)} ${(item.major.name)}" empty="..."/]
          [/#if]
            [@b.formfoot]
                <input type="hidden" name="signupInfo.setting.id" value="${setting.id}"/>
                <input type="hidden" name="signupInfo.inside" value="1"/>
                [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit" /]&nbsp;&nbsp;
                [@b.a class="btn btn-default" href="!index" role="button" style="padding: .25rem .5rem; font-size: .875rem; line-height: 1.5; border-radius: .2rem;background:none;border-color:#000;width: 60px;"]返回[/@]
            [/@]
        [/@]
      </div>
    </div>
  </div>
</div>
[#include "formScript.ftl"/]
[@b.foot/]
