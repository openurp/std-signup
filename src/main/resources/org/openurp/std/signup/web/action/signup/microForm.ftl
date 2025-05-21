[#ftl]
[@b.head/]
<div class="container-md" style="margin-top: 10px">
<div class="card card-info card-outline">
  <div class="card-header">
    <i class="fas fa-school"></i>&nbsp;${project.school.name} ${project.name}报名<span style="font-size:0.8em">(${setting.beginAt?string("MM-dd HH:mm")}~${(setting.endAt?string("MM-dd HH:mm"))!})</span>
    <div class="card-tools">
     [#if signupInfo.inside]
       [@b.a href="!editNew?signupInfo.inside=0&setting.id="+setting.id target="_self"]<i class="fa-solid fa-arrow-up-right-from-square"></i>其他人员报名[/@]
     [#else]
       [@b.a href="!editNew?signupInfo.inside=1&setting.id="+setting.id target="_self"]<i class="fa-solid fa-arrow-up-right-from-square"></i>校内学生报名[/@]
     [/#if]
   </div>
  </div>
  <div class="card-body">
    <div style="width: 600px;margin: 0 auto;">
          [#assign title ="校外人员微专业报名"/]
          [#if signupInfo.inside] [#assign title ="校内学生微专业报名"/][/#if]
      [@b.form action=b.rest.save(signupInfo) theme="list" onsubmit="syncEditor" title=title name="signupInfoForm"]
          [@b.textfield name="signupInfo.name" label="姓名" value="${signupInfo.name!}" required="true"/]
          [@b.select name="signupInfo.gender.id" label="性别" value=signupInfo.gender! style="width:200px;" items=genders option="id,name" empty="..."  required="true"/]
          [@b.date name="signupInfo.birthday" label="出生年月" value=signupInfo.birthday!  required="true"/]
          [@b.textfield name="signupInfo.idcard" label="身份证号" value="${signupInfo.idcard!}" required="true"
             id="signupInfo.idcard" onblur="userAjax(this.value)" maxlength="18" comment='<span id="idcardSpan"></span>'/]
          [@b.cellphone id="signupInfo.mobile" name="signupInfo.mobile" label="手机电话" maxlength="11" value="${signupInfo.mobile!}" required="true"/]

          [#if signupInfo.inside]
            [@b.textfield name="signupInfo.code" label="学号" value="${signupInfo.code!}" required="true"/]
            [@b.select name="signupInfo.department" label="主修院系" value=signupInfo.department! option="name,name" items=departments?sort_by('code') required="true"/]
            [@b.select name="signupInfo.category.id" label="主修学科门类" value="${(signupInfo.category.id)!}"
                       style="width:200px;" items=categories option="id,name" empty="..."  required="true"/]
            [@b.textfield name="signupInfo.major" label="主修专业" value="${signupInfo.major!}" required="true"/]
            [@b.textfield name="signupInfo.squad" label="所在班级" value="${signupInfo.squad!}" required="true"/]
            [@b.textfield name="signupInfo.gpa" id="signupInfo.gpa" label="平均绩点" value=signupInfo.gpa! required="true"/]
          [#else]
            [@b.radios label="学员身份"  name="signupInfo.fromSocial" value=signupInfo.fromSocial items="1:全日制高校在读学生,0:社会学员" required="true"/]
            [@b.textfield name="signupInfo.fromOrg" label="所在高校/单位" value=signupInfo.fromOrg! maxlength="100" required="true"/]
          [/#if]

        [#if setting.options?size==1]
          [@b.field label="报名专业"]
             <input type="hidden" id="firstOption" name="signupInfo.institution.id" value="${setting.options?first.major.institution.id}"/>
             <input type="hidden" id="secondOption" name="secondOption.id" value=""/>
             <input type="hidden" name="firstOption.id" value="${setting.options?first.id}"/>
             ${(setting.options?first.major.institution.name)!} ${setting.options?first.major.name}
          [/@]
        [#else]
          [@b.select name="signupInfo.institution.id" id="institution" label="报名院校" value=institutions?first
             style="width:200px;" items=institutions option="id,name" empty="..."  required="true" onchange="fetchOptions(this)"/]
          [@b.select name="firstOption.id" id="firstOption" label="专业一" value="${(firstOption.id)!}"
                     style="width:200px;" items=options option=r" ${(item.major.institution.name)} ${(item.major.name)}" empty="..."  required="true"/]
          [@b.select name="secondOption.id" id="secondOption" label="专业二" value="${(secondOption.id)!}"
                     style="width:200px;" items=options option=r"${(item.major.institution.name)} ${(item.major.name)}" empty="..."/]
        [/#if]
          [@b.file name="photoImg" required="true" extensions="jpg" label="照片" comment="480*640，蓝底，不超过40kb" maxSize="40K"/]
          [@b.formfoot]
              <input type="hidden" name="signupInfo.setting.id" value="${setting.id}"/>
              <input type="hidden" name="signupInfo.inside" value="${signupInfo.inside?c}"/>
              [@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit" /]&nbsp;&nbsp;
              [@b.a class="btn btn-default" href="!index"
                    role="button" style="padding: .25rem .5rem; font-size: .875rem; line-height: 1.5; border-radius: .2rem;background:none;border-color:#000;width: 60px;"]
                    <i class="fa-solid fa-arrow-left"></i>返回
              [/@]
          [/@]
      [/@]
    </div>
  </div>
</div>
</div>

<script>
  beangle.load(["chosen", "bui-ajaxchosen"], function () {
    var formObj = $("form[name=signupInfoForm]");
    function fetchOptions(ele) {
      var firstOptionObj = formObj.find("[name='firstOption.id']");
      firstOptionObj.empty();
      var secondOptionObj = formObj.find("[name='secondOption.id']");
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
    fetchOptions(document.getElementById("institution"));
    [#if institutions?size==1]
    document.getElementById("institution").parentElement.style.display="none";
    [/#if]
  });

  function syncEditor() {
    // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
    var card = document.getElementById("signupInfo.idcard").value;
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    if (reg.test(card) === false) {
      alert("身份证输入不合法");
      return false;
    }
    var firstOption=document.getElementById("firstOption").value;
    var secondOption=document.getElementById("secondOption").value;
    if(firstOption && secondOption && firstOption==secondOption ){
      alert("第二专业不得与第一专业相同");
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
            $('#idcardSpan').html("该用户报名信息已存在，请返回查询");
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
[@b.foot/]
