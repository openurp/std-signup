[#ftl]
[@b.head/]
[@b.grid items=signupOptions var="signupOption"]
  [@b.gridbar]
    bar.addItem("添加",action.add());
    bar.addItem("${b.text("action.modify")}",action.edit());
    bar.addItem("${b.text("action.delete")}",action.remove("确认删除?"));
  [/@]
  [@b.row]
    <input type="hidden" name="signupSetting.id" value="${signupSettingId!}">
    [@b.boxcol /]
    [@b.col width="25%" property="major.name" title="专业名称"/]
    [@b.col width="25%" property="major.institution.name" title="所属院校"/]
    [@b.col width="15%" property="setting.grade" title="年级"/]
    [@b.col width="15%" property="maxCount" title="计划人数"/]
    [@b.col width="15%" property="curCount" title="报名人数"/]
  [/@]
[/@]
[@b.foot/]
