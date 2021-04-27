[#ftl]
[@b.head/]
[@b.grid items=signupInfoes var="signupInfo"]
  [@b.gridbar]
    bar.addItem("${b.text("action.export")}",action.exportData("code:学号,name:姓名,idcard:身份证号,mobile:电话,institution.name:学校,department:院系,major:主修专业,category.name:学科门类,minor.name:辅修专业",
    null,'fileName=学生辅修报名信息一览表'));
  [/@]
  [@b.row]
    [@b.boxcol /]
    [@b.col width="10%" property="code" title="学号"/]
    [@b.col width="6%" property="name" title="姓名"/]
    [@b.col width="13%" property="idcard" title="身份证号"/]
    [@b.col width="10%" property="mobile" title="电话"/]
    [@b.col width="14%" property="institution.name" title="学校"/]
    [@b.col width="12%" property="department" title="院系"/]
    [@b.col width="10%" property="major" title="主修专业"/]
    [@b.col width="5%" property="category.name" title="学科门类"/]
    [@b.col width="10%" property="minor.name" title="辅修专业"/]
    [@b.col width="6%" property="updatedAt" title="报名时间"]${signupInfo.updatedAt?string("yy-MM-dd")}[/@]
  [/@]
[/@]
[@b.foot/]
