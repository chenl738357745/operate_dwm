
create or replace PROCEDURE P_SYS_ROLE_PROJ (
   userInfo out  SYS_REFCURSOR,
   o_result out varchar2
) AS
	--项目级角色数据源
	--作者：陈丽
	--日期：2020-07-16
BEGIN
o_result:='';
open userInfo for
select ROLE_CODE as  "roleCode",
ROLE_NAME as  "roleName" 
from SYS_ROLE_USER_RELATION_RESULT where ROLE_TYPE=30 group by ROLE_NAME,ROLE_CODE
order by ROLE_CODE desc
;
END P_SYS_ROLE_PROJ  ;
/
create or replace PROCEDURE P_SYS_ROLE_ORG (
   userInfo out  SYS_REFCURSOR
) AS
	--虚拟组角色数据源
	--作者：陈丽
	--日期：2020-07-16
BEGIN
open userInfo for
select null as "createtime"
,null "nodetype"
,null "pguid"
,null "isparent"
,null "display"
,VIRTUAL_GROUP_NAME as  "name"
,null "guid"
,null "pid"
,null "ordernum"
,VIRTUAL_GROUP_ID as "id"
,VIRTUAL_GROUP_NAME as  "title"
from SYS_ROLE_USER_RELATION_RESULT where ROLE_TYPE=40 group by VIRTUAL_GROUP_ID,VIRTUAL_GROUP_NAME
order by VIRTUAL_GROUP_NAME
;
END P_SYS_ROLE_ORG;
----------------------------------------------chenl20200621结束------从主数据刷新目标货值存储过程


----------------------------------------------chenl20200621开始------从主数据刷新目标货值存储过程注册
/
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'aa8b1d0a-0f83-321f-e053-0100007fc6a3';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'aa8b1d0a-0f83-321f-e053-0100007fc6a3';
d_createName  VARCHAR2 ( 100 ) := 'chenl'||d_table_dataSource;
begin
	DELETE
	FROM
udp_component_data_source
	WHERE
CREATOR = d_createName;
commit;
DELETE
	FROM
udp_procedure_registration
	WHERE
CREATOR = d_createName;
	commit;-->提交数据
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---数据源注册
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'DWM_TARGET_WORTH_REF', 'procedure', '','', 'roleCode', '', d_createName );
---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_SYS_ROLE_PROJ','ROLE_PROJ',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'userInfo','userInfo','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'o_result','o_result','',d_createName);
end;
/
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'aa8c1980-cd22-1cb0-e053-0100007f7a8c';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'aa8c1980-cd22-1cb0-e053-0100007f7a8c';
d_createName  VARCHAR2 ( 100 ) := 'chenl'||d_table_dataSource;
begin
	DELETE
	FROM
udp_component_data_source
	WHERE
CREATOR = d_createName;
commit;
DELETE
	FROM
udp_procedure_registration
	WHERE
CREATOR = d_createName;
	commit;-->提交数据
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---数据源注册
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'SYS_ROLE_ORG', 'procedure', '','', 'id', '', d_createName );
---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_SYS_ROLE_ORG','SYS_ROLE_ORG',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'userInfo','userInfo','',d_createName);
end;

