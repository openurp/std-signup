[#ftl]
[@b.head/]
[@b.grid items=signupSettings var="signupSetting"]
  [@b.gridbar]
    bar.addItem("${b.text("action.new")}",action.add());
    bar.addItem("${b.text("action.modify")}",action.edit());
    bar.addItem("${b.text("action.delete")}",action.remove("确认删除?"));
    bar.addItem("报名专业设置",'major()');

    function major(){
      var form = document.signupSettingForm;
      var signupSettingId = bg.input.getCheckBoxValues("signupSetting.id");
      if(signupSettingId == ""||signupSettingId.indexOf(',') != -1){
        alert("请选择一条记录");
        return ;
      }
      bg.form.addInput(form,"signupSetting.id",signupSettingId);
      bg.form.addInput(form,"signupOption.setting.id",signupSettingId);
      bg.form.submit(form,"${b.url('option!search')}","_blank");
    }
  [/@]
  [@b.row]
    [@b.boxcol /]
    [@b.col width="8%" property="grade" title="年级"/]
    [@b.col width="15%" property="beginAt" title="生效时间"]${(signupSetting.beginAt?string("yyyy-MM-dd HH:mm"))!}~${(signupSetting.endAt?string("yyyy-MM-dd HH:mm"))!}[/@]
    [@b.col title="可选辅修专业列表"]
      [#assign preSchool='--'/]
      [#list signupSetting.options?sort_by(["major","institution","name"]) as option]
         [#if option.major.institution.name != preSchool]
           [#if preSchool != '--']<br>[/#if]
           [#assign preSchool=option.major.institution.name/]${preSchool} ${option.major.name!}
         [#else]
           ${option.major.name!}
         [/#if]
         [#if option_has_next]&nbsp;[/#if]
      [/#list]
    [/@]
  [/@]
[/@]
[@b.form name="signupSettingForm" action=""/]
[@b.foot/]
