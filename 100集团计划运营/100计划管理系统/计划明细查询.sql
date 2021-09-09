create or replace PROCEDURE P_POM_plan_dtl_conditions (
    o_conditions out  SYS_REFCURSOR,---����
    o_second_company out  SYS_REFCURSOR,---������λ
    o_cp_proj out  SYS_REFCURSOR,---�Ƿ����
    o_plan_type out  SYS_REFCURSOR,---�ƻ�����
    o_node_level out  SYS_REFCURSOR,---���񼶱�
    o_node_status out  SYS_REFCURSOR,---���״̬
    o_node_overdue out  SYS_REFCURSOR,---�Ƿ���
    o_node_plan_end out  SYS_REFCURSOR,---�ƻ��������
    o_node_actual_end out  SYS_REFCURSOR,---ʵ���������
    
--    o_licence_Type out  SYS_REFCURSOR---֤������
    o_licence_node out  SYS_REFCURSOR---֤�սڵ�
) AS
	--�ƻ���ϸ��ѯ����
	--���ߣ�����
	--���ڣ�2020-07-21
second_company	varchar2(50):='second_company';---������λ
--three_company	varchar2(51):='three_company';---������λ
--plan_proj	varchar2(52):='plan_proj';---������Ŀ
cp_proj	varchar2(53):='cp_proj';---�Ƿ����

plan_type	varchar2(55):='plan_type';---�ƻ�����
node_level	varchar2(56):='node_level';---���񼶱�
node_status	varchar2(57):='node_status';---���״̬
node_overdue	varchar2(58):='node_overdue';---�Ƿ���
--node_plan_end	varchar2(59):='node_plan_end';---�ƻ��������
--node_actual_end	varchar2(60):='node_actual_end';---ʵ���������

--licence_Type	varchar2(62):='licence_Type';---֤������
licence_node	varchar2(63):='licence_node';---֤�սڵ�

    
BEGIN
---����
open o_conditions for
select second_company as  "conditionCode",'����������λ' as "conditionText",'check' as "type"  from dual 
union all
select three_company as  "conditionCode",'����������λ' as "conditionText",radio as "type"  from dual 
union all
select plan_proj as  "conditionCode",'������Ŀ' as "conditionText",radio as "type"  from dual 
union all
select cp_proj as  "conditionCode",'�Ƿ����' as "conditionText",'' as "type"  from dual 
union all
select plan_type as  "conditionCode",'�ƻ�����' as "conditionText",'check' as "type"  from dual 
union all
select node_level as  "conditionCode",'���񼶱�' as "conditionText",'check' as "type"  from dual 
union all
select node_status as  "conditionCode",'���״̬' as "conditionText",'check' as "type"  from dual 
union all
select node_overdue as  "conditionCode",'�Ƿ���' as "conditionText",'check' as "type"  from dual 
union all
select node_plan_end as  "conditionCode",'�ƻ��������' as "conditionText",'radio' as "type"  from dual 
union all
select node_actual_end as  "conditionCode",'ʵ���������' as "conditionText",'radio' as "type"  from dual 
union all
select licence_Type as  "conditionCode",'֤������' as "conditionText",'radio' as "type"  from dual 
union all
select licence_node as  "conditionCode",'֤�սڵ�' as "conditionText",'radio' as "type"  from dual 
;
---������λ
open o_second_company for
select  'org-'||tab."value" as id,tab."value",tab."lable",ROWNUM as "sort",tab."isChecked" from (select id "value" ,org_name  "lable",'org' as "ParentId",ORDER_HIERARCHY_CODE as "sort",0 as "isChecked"  from (select ID,org_name,order_hierarchy_code from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK=2
        union 
        select ID,org_name,order_hierarchy_code from  (select parent_id  from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK=3) orgids 
        left join SYS_BUSINESS_UNIT on orgids.parent_id=SYS_BUSINESS_UNIT.id
        union
        select ID,org_name,order_hierarchy_code from(select * from SYS_BUSINESS_UNIT m start with m.id in (
        select sys_business_unit.ID from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK>3
        ) connect by prior m.parent_id=m.id)tab where tab.LEVEL_RANK=2 ) orgs order by orgs.order_hierarchy_code)tab;


     
    o_cp_proj out  SYS_REFCURSOR,---�Ƿ����
    
    o_plan_type out  SYS_REFCURSOR,---�ƻ�����
    o_node_level out  SYS_REFCURSOR,---���񼶱�
    o_node_status out  SYS_REFCURSOR,---���״̬
    o_node_overdue out  SYS_REFCURSOR,---�Ƿ���
    o_node_plan_end out  SYS_REFCURSOR,---�ƻ��������
    o_node_actual_end out  SYS_REFCURSOR,---ʵ���������
    
    o_licence_Type out  SYS_REFCURSOR,---֤������
    o_licence_node out  SYS_REFCURSOR---֤�սڵ�

END P_POM_plan_dtl_conditions;
----------------------------------------------chenl20200621����------��������ˢ��Ŀ���ֵ�洢����


----------------------------------------------chenl20200621��ʼ------��������ˢ��Ŀ���ֵ�洢����ע��
/
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'aaeef0a1-10fb-5b3f-e053-0100007fdd37';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'aa2ef0a1-10fb-5b3f-e053-0100007fdd37';
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
	commit;-->�ύ����
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---����Դע��
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'DWM_TARGET_WORTH_REF', 'procedure', '','', 'roleCode', '', d_createName );
---�洢����ע��
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
	commit;-->�ύ����
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---����Դע��
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'SYS_ROLE_ORG', 'procedure', '','', 'id', '', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_SYS_ROLE_ORG','SYS_ROLE_ORG',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'userInfo','userInfo','',d_createName);
end;

