[#ftl]
[@b.head/]
[@b.toolbar title="报名专业"/]
<div class="search-container">
    <div class="search-panel">
    [@b.form name="signupMajorSearchForm" action="!search" target="signupMajorlist" title="ui.searchForm" theme="search"]
      [@b.textfields names="signupMajor.name;名称"/]
      [@b.select name="signupMajor.institution.id" label="所属院校" items=institutions empty="..." style="width:100px"/]
      <input type="hidden" name="orderBy" value="signupMajor.id"/>
    [/@]
    </div>
    <div class="search-list">
      [@b.div id="signupMajorlist" href="!search?orderBy=signupMajor.id"/]
    </div>
  </div>
[@b.foot/]
