[#ftl]
[@b.head/]
[@b.grid items=signupSettings var="signupSetting"]
  [@b.gridbar]
    bar.addItem("${b.text("action.new")}",action.add());
    bar.addItem("${b.text("action.modify")}",action.edit());
    bar.addItem("${b.text("action.delete")}",action.remove("确认删除?"));
  [/@]
  [@b.row]
    [@b.boxcol /]
    [@b.col width="10%" property="grade" title="年级"/]
    [@b.col width="20%" property="beginAt" title="生效时间"]${signupSetting.beginAt!}[/@]
    [@b.col width="20%" property="endAt" title="失效时间"]${signupSetting.endAt!}[/@]
    [@b.col width="45%" title="可选辅修专业列表"][#list signupSetting.minors! as minor]${minor.name!}[#if minor_has_next],[/#if][/#list][/@]
  [/@]
[/@]
[@b.foot/]
