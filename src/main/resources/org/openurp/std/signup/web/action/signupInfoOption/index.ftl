[#ftl]
[@b.head/]
[#assign settingList= settings?sort_by("grade")?reverse/]
<div class="search-container">
  <div class="search-panel">
      [@b.form name="signupInfoSearchForm" action="!search" target="signupInfolist" title="ui.searchForm" theme="search"]
          [@b.select name="signupInfoOption.info.setting.id" label="年级" items=settingList value=settingList?first required="true"/]
          [@b.textfields names="signupInfoOption.info.code;学号"/]
          [@b.textfields names="signupInfoOption.info.name;姓名"/]
          [@b.select name="signupInfoOption.info.institution.id" label="学校" items=institutions?sort_by("code") empty="..."/]
          [@b.textfields names="signupInfoOption.info.department;主修院系"/]
          [@b.textfields names="signupInfoOption.info.major;主修专业"/]
          [@b.select name="signupInfoOption.option.major.department.id" label="报名院系" items=departs?sort_by("code") empty="..."/]
          [@b.textfields names="signupInfoOption.option.major.name;报名专业"/]
        <input type="hidden" name="orderBy" value="signupInfoOption.info.updatedAt desc"/>
      [/@]
  </div>
  <div class="search-list">[@b.div id="signupInfolist" href="!search?signupInfoOption.info.setting.id="+ settingList?first.id+"&orderBy=signupInfoOption.info.updatedAt desc"/]
  </div>
</div>
[@b.foot/]
