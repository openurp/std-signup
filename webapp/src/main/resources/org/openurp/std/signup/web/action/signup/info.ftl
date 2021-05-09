[#ftl/]
[@b.head/]
<div class="xq_list m_t_20">
	<table style="width: 500px;margin: 0 auto;">
		<tr>
			<td class="title" width="30%">学号:</td>
			<td class="content">${(signupInfo.code)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">姓名:</td>
			<td class="content">${(signupInfo.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">性别:</td>
			<td class="content">${(signupInfo.gender.name)!}</td>
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
			<td class="title" width="30%">所在学校:</td>
			<td class="content">${(signupInfo.institution.name)!}</td>
		</tr>
		<tr>
			<td class="title" width="30%">学科门类:</td>
			<td class="content">${(signupInfo.category.name)!}</td>
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
			<td class="title" width="30%">第一志愿:</td>
			<td class="content">${(signupInfo.firstOption.major.institution.name)!} ${(signupInfo.firstOption.major.name)!} </td>
		</tr>
		<tr>
			<td class="title" width="30%">第二志愿:</td>
			<td class="content">${(signupInfo.firstOption.major.institution.name)!} ${(signupInfo.secondOption.major.name)!}</td>
		</tr>
	</table>
	<div style="text-align:center;margin-top: 20px">
			[@b.a class="btn btn-default" href="!edit?id=" +signupInfo.id role="button"]修改[/@]
			[@b.a class="btn btn-default" href="!index" role="button"]返回[/@]
	</div>
</div>

<style>
	.xq_list{ padding:30px 30px;}
	.xq_list table{ border:1px solid #e1e1e1; background:#fff;}
	.xq_list table tr td{ padding:5px; color:#826d4c; line-height:24px; word-break: break-all}
	.xq_list table tr td:first-child{ background:#faf4eb; color:#333; font-weight:bold;}
	.xq_list table tr{ border-bottom:1px solid #e1e1e1;}
	.xq_list table tr td p {color: #826d4c;}
	.m_t_20{ margin-top:100px;}
</style>
[@b.foot/]
