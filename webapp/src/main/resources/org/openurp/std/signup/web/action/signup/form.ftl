[#ftl]
[@b.head/]
[#if setting??]
<div class="container-md" style="margin-top: 100px">
<div class="card card-info card-outline">
 <div class="card-header">
    <i class="fas fa-school"></i>&nbsp;${project.school.name} 辅修专业报名<span style="font-size:0.8em">(${setting.beginAt?string("MM-dd HH:mm")}~${(setting.endAt?string("MM-dd HH:mm"))!})</span>
 </div>
 <div class="card-body">
  [#if setting ??]
    <div style="width: 600px;margin: 0 auto;">
      [@b.form action=b.rest.save(signupInfo) theme="list" onsubmit="syncEditor" title="辅修专业报名" name="signupInfoForm"]
          [@b.textfield name="signupInfo.code" label="学号" value="${signupInfo.code!}" required="true"/]
          [@b.textfield name="signupInfo.name" label="姓名" value="${signupInfo.name!}" required="true"/]
          [@b.select name="signupInfo.gender.id" label="性别" value=signupInfo.gender! style="width:200px;" items=genders option="id,name" empty="..."  required="true"/]
          [@b.date name="signupInfo.birthday" label="出生年月" value=signupInfo.birthday!  required="true"/]
          [@b.textfield name="signupInfo.idcard" label="身份证号" value="${signupInfo.idcard!}" required="true"
             id="signupInfo.idcard" onblur="userAjax(this.value)" maxlength="18" comment='<span id="idcardSpan"></span>'/]
          [@b.textfield id="signupInfo.mobile" name="signupInfo.mobile" label="手机电话" maxlength="11" value="${signupInfo.mobile!}" required="true"/]
          [@b.textfield id="signupInfo.address" name="signupInfo.address" label="联系地址" maxlength="200" style="width:300px" value="${signupInfo.address!}" required="true"/]
          [@b.select name="signupInfo.institution.id" label="所在学校" value=signupInfo.institution!
            style="width:200px;" items=institutions option="id,name" empty="..."  required="true"/]
          [@b.textfield name="signupInfo.department" label="院系" value="${signupInfo.department!}" required="true"/]
          [@b.select name="signupInfo.category.id" label="主修学科门类" value="${(signupInfo.category.id)!}"
          style="width:200px;" items=categories option="id,name" empty="..."  required="true"/]
          [@b.textfield name="signupInfo.major" label="主修专业" value="${signupInfo.major!}" required="true"/]
          [@b.textfield name="signupInfo.squad" label="所在班级" value="${signupInfo.squad!}" required="true"/]
          [@b.textfield name="signupInfo.gpa" id="signupInfo.gpa" label="绩点" value=signupInfo.gpa! required="true"/]

        [#if setting.options?size==1]
          [@b.field label="报名专业"]
             <input type="hidden" id="firstOption" name="institution.id" value="${setting.options?first.major.institution.id}"/>
             <input type="hidden" id="secondOption" name="signupInfo.secondOption.id" value=""/>
             <input type="hidden" name="signupInfo.firstOption.id" value="${setting.options?first.id}"/>
             ${(setting.options?first.major.institution.name)!} ${setting.options?first.major.name}
          [/@]
        [#else]
          [@b.select name="institution.id" id="institution" label="报名院校" value=(signupInfo.firstOption.major.institution)!
             style="width:200px;" items=institutions option="id,name" empty="..."  required="true" onchange="fetchOptions(this)"/]
          [@b.select name="signupInfo.firstOption.id" id="firstOption" label="第一志愿" value="${(signupInfo.firstOption.id)!}"
          style="width:200px;" items=options option=r" ${(item.major.institution.name)} ${(item.major.name)}" empty="..."  required="true"/]
          [@b.select name="signupInfo.secondOption.id" id="secondOption" label="第二志愿" value="${(signupInfo.secondOption.id)!}"
          style="width:200px;" items=options option=r"${(item.major.institution.name)} ${(item.major.name)}" empty="..." comment="可选，如填报须和第一志愿同一院校"/]
        [/#if]
          [@b.formfoot]
              <input type="hidden" name="signupInfo.setting.id" value="${setting.id}"/>
              [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit" /]&nbsp;&nbsp;
              [@b.a class="btn btn-default" href="!index" role="button" style="padding: .25rem .5rem; font-size: .875rem; line-height: 1.5; border-radius: .2rem;background:none;border-color:#000;width: 60px;"]返回[/@]
          [/@]
      [/@]
    </div>
  [#else ]
    <div style="text-align: center;margin-top: 200px">
        <p style="color: red">未到辅修报名时间</p>
        [@b.a class="btn btn-default" href="!index" role="button" style="padding: .25rem .5rem; font-size: .875rem; line-height: 1.5; border-radius: .2rem;background:none;border-color:#000;width: 60px;"]返回[/@]
    </div>
  [/#if]
  </div>
</div>
</div>

<script>
  beangle.load(["chosen", "bui-ajaxchosen"], function () {
    var formObj = $("form[name=signupInfoForm]");
    function fetchOptions(ele) {
      var firstOptionObj = formObj.find("[name='signupInfo.firstOption.id']");
      firstOptionObj.empty();
      var secondOptionObj = formObj.find("[name='signupInfo.secondOption.id']");
      secondOptionObj.empty();

      $.ajax({
        "type": "post",
        "url": "${b.url("signup!optionAjax")}",
        "dataType": "json",
        "data": {
          "institutionId": ele.value,
          "option.setting.id":'${setting.id}'
        },
        "async": false,
        "success": function (data) {
          firstOptionObj.append("<option value=''>请选择</option>");
          for (var i = 0; i < data.majorOptions.length; i++) {
            var optionObj = $("<option>");
            optionObj.val(data.majorOptions[i].id);
            optionObj.text(data.majorOptions[i].name);
            firstOptionObj.append(optionObj);
          }
          secondOptionObj.append("<option value=''>请选择</option>");
          for (var i = 0; i < data.majorOptions.length; i++) {
            var optionObj = $("<option>");
            optionObj.val(data.majorOptions[i].id);
            optionObj.text(data.majorOptions[i].name);
            secondOptionObj.append(optionObj);
          }
        }
      });
    }
    window.fetchOptions=fetchOptions;
  });

  function syncEditor() {
    // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
    var card = document.getElementById("signupInfo.idcard").value;
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    if (reg.test(card) === false) {
      alert("身份证输入不合法");
      return false;
    }
    var  mobile=document.getElementById("signupInfo.mobile").value;
    if(!(/^1[3456789]\d{9}$/.test(mobile))){
      alert("手机格式不合法");
      return false;
    }
    var gpa = document.getElementById("signupInfo.gpa").value;
    if(gpa>4.0){
      alert("绩点不得大于4.0");
      return false;
    }
    var firstOption=document.getElementById("firstOption").value;
    var secondOption=document.getElementById("secondOption").value;
    if(firstOption && secondOption && firstOption==secondOption ){
      alert("第二志愿不得与第一志愿相同");
      return false;
    }
    return true;
  }

  function userAjax(value) {
    if (value != "") {
      $.ajax({
        "type": "post",
        "url": '${b.url("signup!userAjax")}' + '.json',
        "data": {
          "card": value,
          "id": '${signupInfo.id!}'
        },
        "async": false,
        "success": function (data) {
          if (data) {
            $('#idcardSpan').html("该用户辅修信息已存在，请返回查询");
            $('#idcardSpan').css({
              "background-image": "url('${b.static_url('bui','images/arrow.gif')}')",
              "background-position": "left center",
              "padding": "2px",
              "padding-left": "18px",
              "color": "#fff",
              "display": "inline"
            })
          }else{
            $('#idcardSpan').html("");
            $('#idcardSpan').removeAttr("style");
          }
        }
      });
    }
  }
</script>
[#else]
<p>报名尚未开始</p>
[/#if]
[@b.foot/]
