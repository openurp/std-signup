[#ftl]
[@b.head/]
<div style="text-align: center;margin-top: 150px">
  [#if alert??]<div style="margin-bottom: 20px"><p style="color: red">未找到微专业报名信息，请报名</p></div>[/#if]
  <div style="margin-bottom: 20px;">
   <p style="font-size:20px">微专业报名与查询</p>
  </div>
  <div style="margin-bottom: 20px">[#list 0..60 as i]-[/#list]</div>
  <div>
    [@b.form name="signupInfoForm" action="!checkInfo" ]
      <div style="line-height: 30px;"> 姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<input name="signupInfo.name" id="signupInfo.name" type="text" placeholder="请输入姓名"></div>
      <div style="line-height: 30px;margin-top: 10px;"> 身份证号：<input name="signupInfo.idcard" id="signupInfo.idcard" type="text" placeholder="请输入身份证号"></div>
    [/@]
  </div>
  <div style="margin-top: 20px;">
    <button class="btn btn-default" onclick="checkInfo(this.form)">查询</button>
     [#if setting??]
       [@b.a class="btn btn-default" href="!editNew?signupInfo.inside=1&setting.id="+setting.id title="${setting.project.school.name}学生"]校内学生报名[/@]
       [@b.a class="btn btn-default" href="!editNew?signupInfo.inside=0&setting.id="+setting.id]其他人员报名[/@]
     [/#if]
  </div>
</div>

[@b.foot/]
<script>
  function checkInfo(form) {
    var form  = document.signupInfoForm;
    if (!form['signupInfo.name'].value) {
      alert("姓名不能为空");
      return;
    }
    if (!form['signupInfo.idcard'].value) {
      alert("身份证号不能为空");
      return;
    }
    setSearchParams(form);
    bg.form.submit(form);
  };

  function setSearchParams(form) {
    jQuery('input[name=params]', form).remove();
    var params = jQuery(form).serialize();
    bg.form.addInput(form, 'params', params);
  };
</script>
