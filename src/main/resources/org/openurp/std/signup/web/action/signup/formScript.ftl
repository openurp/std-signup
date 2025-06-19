<script>
  function fetchOptions(ele) {
    var formObj = $("form[name=signupInfoForm]");
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

  beangle.load(["chosen", "bui-ajaxchosen"], function () {
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
    var  mobile=document.getElementById("signupInfo.mobile").value;
    if(!(/^1[3456789]\d{9}$/.test(mobile))){
      alert("手机格式不合法");
      return false;
    }
    if(null!=document.getElementById("signupInfo.gpa")){
      var gpa = document.getElementById("signupInfo.gpa").value;
      if(gpa.length>0 && gpa>4.0){
        alert("绩点不得大于4.0");
        return false;
      }
    }
    var firstOption=document.getElementById("firstOption").value;
    var secondOption=document.getElementById("secondOption").value;
    if(firstOption && secondOption && firstOption==secondOption ){
      alert("第二专业不得与第一专业相同");
      return false;
    }
    return true;
  }

  function checkSignup(value) {
    if (value != "") {
      $.ajax({
        "type": "post",
        "url": '${b.url("signup!check")}' + '.json',
        "data": {
          "card": value,
          "setting.id":'${setting.id}',
          "id": '${signupInfo.id!}'
        },
        "async": false,
        "success": function (data) {
          if (data) {
            displayStdError("该用户报名信息已存在，请返回查询");
          }else{
            clearStdError();
          }
        }
      });
    }
  }

  function clearStdError(){
    $('#idcardSpan').html("");
    $('#idcardSpan').removeAttr("style");
  }

  function displayStdError(msg){
    $('#idcardSpan').html(msg);
    $('#idcardSpan').css({
      "background-image": "url('${b.static_url('bui','images/arrow.gif')}')",
      "background-position": "left center",
      "padding": "2px",
      "padding-left": "18px",
      "color": "#fff",
      "display": "inline"
    })
  }

  function queryStudent(form) {
    var code = form['signupInfo.code'].value
    var idcard = form['signupInfo.idcard'].value
    if (code != "" && idcard != "" && idcard.length==18) {
      checkSignup(idcard);
      [#if queryStdEnabled]
      $.ajax({
        "type": "post",
        "url": '${b.url("signup!queryStd")}' + '.json',
        "data": {
          "setting.id":'${setting.id}',
          "code": code,
          "idcard": idcard
        },
        "async": true,
        "success": function (data) {
          if (data.success) {
            var std = data.data;
            form['signupInfo.name'].value=std.name;
            $(form['signupInfo.gender.id']).find("option:contains('"+std.gender+"')").attr("selected", true);
            form['signupInfo.birthday'].value = std.birthday;
            var depart = form['signupInfo.department'];
            if(depart.tagName=='INPUT'){
              depart.value=std.department;
            }else{
              var matchedDeparts = $(form['signupInfo.department']).find("option:contains('"+std.department+"')");
              if(matchedDeparts.length>0){
                matchedDeparts.attr("selected", true);
              }
            }
            form['signupInfo.major'].value = std.major;
            form['signupInfo.squad'].value = std.squad||'--';
            if(std.gpa){
              form['signupInfo.gpa'].value=std.gpa;
            }
            clearStdError();
          }else{
            displayStdError(data.msg||"查不到该学生");
          }
        }
      });
      [/#if]
    }
  }
</script>
