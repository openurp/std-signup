[#ftl/]
[@b.head/]
<div class="container-md" style="margin-top: 100px">
<div class="card card-info card-outline">
 <div class="card-header">
    <i class="fas fa-school"></i>&nbsp;辅修专业报名信息</span>
 </div>
 <div class="card-body">
  <table class="infoTable">
    <tr>
      <td class="title" width="20%">学号:</td>
      <td class="content">${(signupInfo.code)!}</td>
      <td class="title" width="20%" >姓名:</td>
      <td class="content">${(signupInfo.name)!}</td>
    </tr>
    <tr>
      <td class="title" >性别:</td>
      <td class="content">${(signupInfo.gender.name)!}</td>
      <td class="title" >出生年月:</td>
      <td class="content">${(signupInfo.birthday?string('yyyy-MM-dd'))!}</td>
    </tr>
    <tr>
      <td class="title" >身份证号:</td>
      <td class="content">${(signupInfo.idcard)!}</td>
      <td class="title" >电话:</td>
      <td class="content">${(signupInfo.mobile)!}</td>
    </tr>
    <tr>
      <td class="title" >联系地址:</td>
      <td class="content" colspan="3">${(signupInfo.address)!}</td>
    </tr>
    <tr>
      <td class="title" >所在学校:</td>
      <td class="content">${(signupInfo.institution.name)!}</td>
      <td class="title" >院系:</td>
      <td class="content">${(signupInfo.department)!}</td>
    </tr>
    <tr>
      <td class="title" >学科门类:</td>
      <td class="content">${(signupInfo.category.name)!}</td>
      <td class="title" >主修专业:</td>
      <td class="content">${(signupInfo.major)!}</td>
    </tr>
    <tr>
      <td class="title" >班级:</td>
      <td class="content">${(signupInfo.squad)!}</td>
      <td class="title" >绩点:</td>
      <td class="content">${(signupInfo.gpa)!}</td>
    </tr>
    <tr>
      <td class="title" >[#if signupInfo.secondOption??]第一志愿:[#else]报名专业[/#if]</td>
      <td class="content" [#if !signupInfo.secondOption??]colspan="3"[/#if]>${(signupInfo.firstOption.major.institution.name)!} ${(signupInfo.firstOption.major.name)!} </td>
    [#if signupInfo.secondOption??]
      <td class="title" >第二志愿:</td>
      <td class="content">${(signupInfo.firstOption.major.institution.name)!} ${(signupInfo.secondOption.major.name)!}</td>
    </tr>
    [/#if]
  </table>
  <div style="text-align:center;margin-top: 20px">
      [#if downloadApplication]
        [@b.a class="btn btn-success" href="!download?signupInfo.id=" +signupInfo.id role="button"]下载申请表[/@]
      [/#if]
      [@b.a class="btn btn-primary" href="!edit?id=" +signupInfo.id role="button"]修改[/@]
      [@b.a class="btn btn-default" href="!index" role="button"]返回[/@]
  </div>
 </div>
  </div>
 </div>
[@b.foot/]
