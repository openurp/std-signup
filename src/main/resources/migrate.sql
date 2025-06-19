alter table std.signup_majors add  project_id int4;
alter table std.signup_settings add  project_id int4;
alter table std.signup_settings add  name varchar(256);
update std.signup_settings  set name=grade;

update std.signup_settings set project_id=(select min(id) from base.projects);
update std.signup_majors set project_id=(select min(id) from base.projects);
alter table std.signup_infoes add inside bool default false;

alter table std.signup_infoes alter gpa drop not null;
alter table std.signup_infoes alter category_id drop not null;
alter table std.signup_infoes add photo_path varchar(255);
alter table std.signup_infoes alter squad drop not null;
alter table std.signup_infoes alter address drop not null;

create table std.signup_info_options (option_id bigint not null, info_id bigint not null, id bigint not null, idx integer default 0 not null);
alter table std.signup_info_options add constraint pk_t670hj96rhstedkp33316toh4 primary key (id);
create index idx_1qdhkar2ctkoc0s8sr5av4a5y on std.signup_info_options (info_id);

insert into std.signup_info_options (id,info_id,idx,option_id) select datetime_id(),id,1,first_option_id from std.signup_infoes;
insert into std.signup_info_options (id,info_id,idx,option_id) select datetime_id(),id,2,second_option_id from std.signup_infoes where second_option_id is not null;

alter table std.signup_majors add department_id int4;

alter table std.signup_infoes alter column first_option_id drop not null;
alter table std.signup_infoes alter column second_option_id drop not null;

alter table std.signup_infoes add from_social bool default false;
alter table std.signup_infoes add from_org varchar(100);
