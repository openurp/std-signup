[#ftl]
[@b.head/]
[@b.toolbar title="报名专业设置"/]
<div class="search-container">
    <div class="search-panel">
    [@b.form name="signupOptionSearchForm" action="!search" target="signupOptionlist" title="ui.searchForm" theme="search"]
        <input type="hidden" name="signupSetting.id" value="${signupSettingId!}">
      [@b.textfields names="signupOption.major.name;专业名称"/]
      [@b.textfields names="signupOption.setting.grade;年级"/]
      [@b.select name="signupOption.major.institution.id" label="所属院校" items=institutions empty="..." style="width:100px"/]
    [/@]
    </div>
    <div class="search-list">
      [@b.div id="signupOptionlist" href="!search?signupSetting.id=${signupSettingId!}"/]
    </div>
  </div>
[@b.foot/]
