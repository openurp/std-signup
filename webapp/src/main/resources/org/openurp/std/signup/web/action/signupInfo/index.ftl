[#ftl]
[@b.head/]
<div class="search-container">
  <div class="search-panel">
      [@b.form name="signupInfoSearchForm" action="!search" target="signupInfolist" title="ui.searchForm" theme="search"]
          [@b.textfields names="signupInfo.code;学号"/]
          [@b.textfields names="signupInfo.name;姓名"/]
          [@b.select name="signupInfo.institution.id" label="学校" items=institutions?sort_by("code") empty="..."/]
          [@b.textfields names="signupInfo.department;院系"/]
          [@b.textfields names="signupInfo.major;主修专业"/]
          [@b.select name="signupInfo.category.id" label="学科门类" items=categories?sort_by("code") empty="..."/]
        <input type="hidden" name="orderBy" value="signupInfo.updatedAt desc"/>
      [/@]
  </div>
  <div class="search-list">[@b.div id="signupInfolist" href="!search?orderBy=signupInfo.updatedAt desc"/]
  </div>
</div>
[@b.foot/]
