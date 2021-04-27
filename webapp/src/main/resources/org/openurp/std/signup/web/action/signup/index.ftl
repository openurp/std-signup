[#ftl]
[@b.head/]
<div style="text-align: center;margin-top: 200px">
  [#if alert??]<div style="margin-bottom: 20px"><p style="color: red">未找到辅修报名信息，请报名</p></div>[/#if]
  <div style="margin-bottom: 20px;">
   <p style="font-size:20px">辅修报名信息报名与查询</p>
  </div>
  <div style="margin-bottom: 20px">[#list 0..60 as i]-[/#list]</div>
  <div>
    [@b.form name="signupInfoForm" action="!checkInfo" ]
      <div style="line-height: 30px;"> 学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：<input name="signupInfo.code" id="signupInfo.code" type="text" placeholder="请输入学号"></div>
      <div style="line-height: 30px;margin-top: 10px;"> 身份证号：<input name="signupInfo.idcard" id="signupInfo.idcard" type="text" placeholder="请输入身份证号"></div>
    [/@]
  </div>
  <div style="margin-top: 20px;">
    <button class="btn btn-default" onclick="checkInfo(this.form)" >查询</button>
     [@b.a class="btn btn-default" href="!editNew"]直接报名[/@]
  </div>
</div>

[@b.foot/]
<script>
  function checkInfo(form) {
    var form  = document.signupInfoForm;
    if (!form['signupInfo.code'].value) {
      alert("学号不能为空");
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