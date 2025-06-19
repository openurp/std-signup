[#ftl]
[@b.head/]
[@b.grid items=signupMajors var="signupMajor"]
  [@b.gridbar]
    bar.addItem("${b.text("action.new")}",action.add());
    bar.addItem("${b.text("action.modify")}",action.edit());
    bar.addItem("${b.text("action.delete")}",action.remove("确认删除?"));
  [/@]
  [@b.row]
    [@b.boxcol /]
    [@b.col width="20%" property="name" title="名称"/]
    [@b.col width="25%" property="institution.name" title="所属院校"/]
    [@b.col width="25%" property="beginOn" title="生效时间"/]
    [@b.col width="25%" property="endOn" title="失效时间"/]
  [/@]
[/@]
[@b.foot/]
