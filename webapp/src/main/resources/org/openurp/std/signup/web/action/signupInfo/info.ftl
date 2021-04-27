[#ftl]
[@b.head/]
[@b.toolbar title="辅修信息"]
	bar.addBack("${b.text("action.back")}");
[/@]
<table class="infoTable">
		<tr>
			<td class="title" width="30%">学号:</td>
			<td class="content">${(signupInfo.code)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">姓名:</td>
			<td class="content">${(signupInfo.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">身份证号:</td>
			<td class="content">${(signupInfo.idcard)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">电话:</td>
			<td class="content">${(signupInfo.mobile)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">学校:</td>
			<td class="content">${(signupInfo.institution.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">院系:</td>
			<td class="content">${(signupInfo.department)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">主修专业:</td>
			<td class="content">${(signupInfo.major)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">绩点:</td>
			<td class="content">${(signupInfo.gp)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">学科门类:</td>
			<td class="content">${(signupInfo.category.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">第一志愿:</td>
			<td class="content">${(signupInfo.firstOption.major.name)!} ${(signupInfo.firstOption.major.institution.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">第二志愿:</td>
			<td class="content">${(signupInfo.secondOption.major.name)!} ${(signupInfo.firstOption.major.institution.name)!}</td>
		</tr>
	</table>
[@b.foot/]
