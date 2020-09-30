--SET DEFINE OFF;
--
--DECLARE --functionguid  select get_uuid() from dual;
--d_table_dataSource VARCHAR2 ( 100 ) := 'a6c9333d-869b-261e-e053-0100007f233d';
--d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'a6c9333d-869b-261e-e053-0100007f233d';
--d_createName  VARCHAR2 ( 100 ) := 'chenl'||d_table_dataSource;
--begin
--	DELETE
--	FROM
--udp_component_data_source
--	WHERE
--CREATOR = d_createName;
--commit;
--DELETE
--	FROM
--udp_procedure_registration
--	WHERE
--CREATOR = d_createName;
--	commit;-->�ύ����
--	DELETE
--	FROM
--udp_procedure_parameter
--	WHERE
--CREATOR = d_createName;
--
-----����Դע��
--	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
--	VALUES
--( d_table_dataSource, 'POM_PROJ_BY_KEY_NODE_PLAN', 'procedure', 'PARENT_ID','ID', 'ID', 'NAME', d_createName );
-----�洢����ע��
--INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
--VALUES (d_table_dataSource_procedure,'P_POM_PROJ_BY_KEY_NODE_PLAN','POM_PROJ_BY_KEY_NODE_PLAN',1,d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'companyGUID','companyGUID','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'USERID','����','',d_createName);
--
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'STATIONID','����λ','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'DEPTID','������','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'COMPANYID','����˾','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'items','','',d_createName);
--end;
--/
create or replace PROCEDURE  P_POM_PROJ_BY_KEY_NODE_PLAN
(
    companyGUID IN VARCHAR2,
    USERID VARCHAR2,
    STATIONID VARCHAR2,
    DEPTID VARCHAR2,
    COMPANYID VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id varchar2(100);
    --��ǰ����
    nowdate date:=trunc(sysdate);
    BIZCODE VARCHAR2(200):='POM.JHJKYKHPH.01';
    DATA_AUTH_SPID VARCHAR2(200);
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '003200000000000000000000000000';
    ELSE
        v_id := companyGUID;
    END IF;

    DECLARE


BEGIN
  P_SYS_GET_COMPANY_PROJ_SPID(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPTID => DEPTID,
    COMPANYID => COMPANYID,
    BIZCODE => BIZCODE,
    DATA_AUTH_SPID => DATA_AUTH_SPID
  );
END;

     open items for   
    WITH
     ���� as(
     select  case when �ܷ�������=0 then get_uuid else ps.id end as id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,to_char(ps.sn,'0.0') as sn
     ,case when �޷�������=1 and �ܷ�������=1 then 1 else 0 end ���޷��� 
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     left join (select PROJECT_ID,sum(case when STAGE_NAME='�޷���' then 1 else 0 end) as �޷�������,count(PROJECT_ID) as �ܷ������� from SYS_PROJECT_STAGE group by PROJECT_ID)  pcount
     on proj.id=pcount.PROJECT_ID
     )
    ,basedata AS(
    ---��ѯ����˵ķ��� �ؼ��ڵ�ƻ� ������Ϣ
   select 
   plan.PROJ_ID
   from  POM_PROJ_PLAN_NODE node
   left join POM_PROJ_PLAN plan on node.PROJ_PLAN_ID=plan.id
   --- δ����һ���ڵ��ظ��������
   left join POM_NODE_EXAMINATION nodee on node.ORIGINAL_NODE_ID=nodee.ORIGINAL_NODE_ID

   ---����ˡ��ؼ��ڵ�ƻ���δ���ýڵ�
   where plan.APPROVAL_STATUS='�����' 
   and plan.PLAN_TYPE='�ؼ��ڵ�ƻ�'
   and node.id is not null
   and node.IS_DISABLE=0
   and node.IS_DELETE=0
   group by plan.PROJ_ID )


   ,��Ŀ_���� as(
   select case when ����.���޷���=1 then ����.PROJECT_ID else ����.id end as id
   ,case when ����.���޷���=1 then ����.PROJECT_NAME else ����.PROJECT_NAME||'-'||����.STAGE_NAME end as name 
    --ͳ�Ƶĸ����ֶδ����޷�����Ŀ�����ǹ�˾���з�����Ŀ��������Ŀ
   ,case when ����.���޷���=1 then ����.UNIT_ID else PROJECT_ID end parent_id
   ,����.UNIT_ID
   ,����.sn
   from basedata
   left join ���� on basedata.PROJ_ID=����.id
   union all 
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,proj.UNIT_ID
   ,proj.sn
   from sys_project proj
   left join (select * from ���� where ���޷���=1) s on proj.id=s.project_id
   where s.id is null
   )
   
    select Id
   ,NAME
   ,PARENT_ID
   ,UNIT_ID
   ,sn FROM ��Ŀ_����
  where UNIT_ID=v_id
  order by sn
   ;

END P_POM_PROJ_BY_KEY_NODE_PLAN;

--c9c30ef2-a519-4f7b-919f-cb166525d6b9	���ݰٻ����ϳ�	585090ff-2aff-4b78-97cb-3629b06f04db		####