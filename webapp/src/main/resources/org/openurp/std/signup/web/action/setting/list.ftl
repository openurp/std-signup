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
    bg.form.submit(form,"${b.url('option')}","_blank");
    }
  [/@]
  [@b.row]
    [@b.boxcol /]
    [@b.col width="10%" property="grade" title="年级"/]
    [@b.col width="20%" property="beginAt" title="生效时间"]${(signupSetting.beginAt?string("yyyy-MM-dd HH:mm"))!}[/@]
    [@b.col width="20%" property="endAt" title="失效时间"]${(signupSetting.endAt?string("yyyy-MM-dd HH:mm"))!}[/@]
    [@b.col width="45%" title="可选辅修专业列表"][#list signupSetting.options?sort_by(["major","institution","name"]) as option]${option.major.institution.name!} ${option.major.name!}[#if option_has_next]<br>[/#if][/#list][/@]
  [/@]
[/@]
[@b.form name="signupSettingForm" action=""/]
[@b.foot/]
