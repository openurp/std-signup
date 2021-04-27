[#ftl]
[@b.head/]
<div style="margin-top: 100px">
	[#if setting ??]
		<div style="width: 600px;margin: 0 auto;">
      [@b.form action=b.rest.save(signupInfo) theme="list" onsubmit="syncEditor" title="辅修专业报名" name="signupInfoForm"]
          [@b.textfield name="signupInfo.code" label="学号" value="${signupInfo.code!}" required="true"/]
          [@b.textfield name="signupInfo.name" label="姓名" value="${signupInfo.name!}" required="true"/]
          [@b.textfield name="signupInfo.idcard" label="身份证号" value="${signupInfo.idcard!}" required="true"
             id="signupInfo.idcard" onblur="userAjax(this.value)" maxlength="18" comment='<span id="idcardSpan"></span>'/]
          [@b.textfield id="signupInfo.mobile" name="signupInfo.mobile" label="手机电话" maxlength="11" value="${signupInfo.mobile!}" required="true"/]
          [@b.select name="signupInfo.institution.id" label="所在学校" value=signupInfo.institution!
            style="width:200px;" items=institutions option="id,name" empty="..."  required="true"/]
          [@b.textfield name="signupInfo.department" label="院系" value="${signupInfo.department!}" required="true"/]
          [@b.textfield name="signupInfo.major" label="主修专业" value="${signupInfo.major!}" required="true"/]
          [@b.textfield name="signupInfo.gp" id="signupInfo.gp" label="绩点" value="${signupInfo.gp!}" required="true"/]
          [@b.select name="signupInfo.category.id" label="学科门类" value="${(signupInfo.category.id)!}"
          style="width:200px;" items=categories option="id,name" empty="..."  required="true"/]
[#--          [@b.select name="signupInfo.firstOption.major.institution.id" id="institution" label="辅修专业所在院校" value="${(signupInfo.firstOption.major.institution.id)!}"--]
[#--          style="width:200px;" items=institutions option="id,name" empty="..."  required="true" /]--]
[#--          [@b.select style="width:200px" id="firstOption" name="signupInfo.firstOption.id" items={} empty="..." label="第一志愿" value="${(signupInfo.firstOption.id)!}"/]--]
[#--          [@b.select style="width:200px" id="secondOption" name="signupInfo.secondOption.id" items={} empty="..." label="第二志愿" value="${(signupInfo.secondOption.id)!}"/]--]
          [@b.select name="signupInfo.firstOption.id" id="firstOption" label="第一志愿" value="${(signupInfo.firstOption.id)!}"
          style="width:200px;" items=options option=r"${(item.major.name)} ${(item.major.institution.name)}" empty="..."  required="true"/]
					[@b.select name="signupInfo.secondOption.id" id="secondOption" label="第二志愿" value="${(signupInfo.secondOption.id)!}"
					style="width:200px;" items=options option=r"${(item.major.name)} ${(item.major.institution.name)}" empty="..." /]
          [@b.formfoot]
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
[@b.foot/]

<script>

	beangle.load(["chosen", "bui-ajaxchosen"], function () {
		var formObj = $("form[name=signupInfoForm]");
		formObj.find("select[name='signupInfo.firstOption.major.institution.id']").children("option").click(function () {
			var firstOptionObj = formObj.find("[name='signupInfo.firstOption.id']");
			firstOptionObj.empty();
			var secondOptionObj = formObj.find("[name='signupInfo.secondOption.id']");
			secondOptionObj.empty();

			$.ajax({
				"type": "post",
				"url": "${b.url("signup!optionAjax")}",
				"dataType": "json",
				"data": {
					"institutionId": $(this).val()
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
		});
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
		var gp = document.getElementById("signupInfo.gp").value;
		if(gp>4.0){
			alert("绩点不得大于4.0");
			return false;
		}
		var firstOption=document.getElementById("firstOption").value;
		var secondOption=document.getElementById("secondOption").value;
		if( firstOption==secondOption ){
			alert("第二志愿不得与第一志愿相同");
			return false;
		}
		[#--alert( firstOption)--]
		[#--alert(${optionMap}.get(firstOption))--]
		[#--alert(${optionMap}.get(firstOption))--]
		[#--if( ${optionMap.get(firstOption)}!=${optionMap.get(secondOption)} ){--]
		[#--	alert("两个志愿需所属相同院校");--]
		[#--	return false;--]
		[#--}--]
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

