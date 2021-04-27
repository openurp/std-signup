[#ftl]
{
  "majorOptions" : [
                [#list options! as option]{ "id" : "${option.id}", "name" : "${option.major.name?js_string}" ,"code" : "${course.code?js_string}"}[#if option_has_next],[/#if][/#list]
              ]
}
