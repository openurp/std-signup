[#ftl/]
[@b.head/]
<div class="container-md" style="margin-top: 10px">
<div class="card card-info card-outline">
 <div class="card-header">
    <i class="fas fa-school"></i>${signupInfo.setting.project.school.name}&nbsp;${signupInfo.setting.project.name} 报名信息</span>
 </div>
 <style>
   .title{
     text-align:right;
   }
 </style>
 <div class="card-body" style="padding-top:0px;">
  <table class="table table-sm">
    [#if photoUrl??]
      <tr>
        <td class="title" width="20%">姓名:</td>
        <td>${(signupInfo.code)!} ${(signupInfo.name)!}</td>
        <td class="title" rowspan="5">照片:</td>
        <td rowspan="5"><img height="110px" src="${photoUrl}"/></td>
      </tr>
      <tr>
        <td class="title" >性别:</td>
        <td>${(signupInfo.gender.name)!}</td>
      </tr>
      <tr>
        <td class="title" >出生日期:</td>
        <td>${(signupInfo.birthday?string('yyyy-MM-dd'))!}</td>
      </tr>
      <tr>
        <td class="title" >身份证号:</td>
        <td>${(signupInfo.idcard)!}</td>
      </tr>
      <tr>
        <td class="title" >电话:</td>
        <td>${(signupInfo.mobile)!}</td>
      </tr>
    [#else]
      <tr>
        <td class="title" width="20%">学号:</td>
        <td>${(signupInfo.code)!}</td>
        <td class="title" width="20%" >姓名:</td>
        <td>${(signupInfo.name)!}</td>
      </tr>
      <tr>
        <td class="title" >性别:</td>
        <td>${(signupInfo.gender.name)!}</td>
        <td class="title" >出生日期:</td>
        <td>${(signupInfo.birthday?string('yyyy-MM-dd'))!}</td>
      </tr>
      <tr>
        <td class="title" >身份证号:</td>
        <td>${(signupInfo.idcard)!}</td>
        <td class="title" >电话:</td>
        <td>${(signupInfo.mobile)!}</td>
      </tr>
    [/#if]

    <tr>
      <td class="title" >联系地址:</td>
      <td colspan="3">${(signupInfo.address)!}</td>
    </tr>
    [#if signupInfo.inside]
    <tr>
      <td class="title" >学校:</td>
      <td>${(signupInfo.institution.name)!}</td>
      <td class="title" >主修院系:</td>
      <td>${(signupInfo.department)!}</td>
    </tr>
    <tr>
      <td class="title" >学科门类:</td>
      <td>${(signupInfo.category.name)!}</td>
      <td class="title" >主修专业:</td>
      <td>${(signupInfo.major)!}</td>
    </tr>
    <tr>
      <td class="title" >班级:</td>
      <td>${(signupInfo.squad)!}</td>
      <td class="title" >绩点:</td>
      <td>${(signupInfo.gpa)!}</td>
    </tr>
    [#else]
    <tr>
      <td class="title" >学员身份:</td>
      <td>${(signupInfo.fromSocial)?string('社会学员','全日制高校在读学生')}</td>
      <td class="title" >所在高校/单位:</td>
      <td>${(signupInfo.fromOrg)!}</td>
    </tr>
    [/#if]
    <tr>
      <td class="title" >[#if signupInfo.secondMajor??]专业一:[#else]报名专业[/#if]</td>
      <td [#if !signupInfo.secondMajor??]colspan="3"[/#if]>${(signupInfo.firstMajor.institution.name)!} ${(signupInfo.firstMajor.name)!} </td>
    [#if signupInfo.secondMajor??]
      <td class="title" >专业二:</td>
      <td>${(signupInfo.secondMajor.institution.name)!} ${(signupInfo.secondMajor.name)!}</td>
    [/#if]
    </tr>
  </table>
  <div style="text-align:center;margin-top: 20px">
      [#if downloadApplication]
        [@b.a class="btn btn-outline-success" href="!download?signupInfo.id=" +signupInfo.id role="button" target="_blank"]<i class="fas fa-download"></i>下载申请表[/@]&nbsp;
      [/#if]
      [@b.a class="btn btn-outline-primary" href="!edit?id=" +signupInfo.id role="button"]<i class="fas fa-edit"></i>修改[/@]&nbsp;
      [#if signupInfo.setting.project.minor]
        [@b.a class="btn btn-default" href="!index" role="button"]<i class="fas fa-backward"></i>返回[/@]
      [#else]
        [@b.a class="btn btn-default" href="!microIndex" role="button"]<i class="fas fa-backward"></i>返回[/@]
      [/#if]
  </div>
 </div>
  </div>
 </div>
[@b.foot/]
