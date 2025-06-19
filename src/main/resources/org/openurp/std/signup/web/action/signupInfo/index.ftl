[#ftl]
[@b.head/]
[#assign settingList= settings?sort_by("grade")?reverse/]
<div class="search-container">
  <div class="search-panel">
      [@b.form name="signupInfoSearchForm" action="!search" target="signupInfolist" title="ui.searchForm" theme="search"]
          [@b.select name="signupInfo.setting.id" label="批次" items=settingList value=settingList?first required="true"/]
          [@b.textfields names="signupInfo.code;学号"/]
          [@b.textfields names="signupInfo.name;姓名"/]
          [@b.select name="signupInfo.institution.id" label="学校" items=institutions?sort_by("code") empty="..."/]
          [@b.textfields names="signupInfo.department;院系"/]
          [@b.textfields names="signupInfo.major;主修专业"/]
          [@b.select name="signupInfo.category.id" label="学科门类" items=categories?sort_by("code") empty="..."/]
        <input type="hidden" name="orderBy" value="signupInfo.updatedAt desc"/>
      [/@]
  </div>
  <div class="search-list">[@b.div id="signupInfolist" href="!search?signupInfo.setting.id="+ settingList?first.id+"&orderBy=signupInfo.updatedAt desc"/]
  </div>
</div>
[@b.foot/]
