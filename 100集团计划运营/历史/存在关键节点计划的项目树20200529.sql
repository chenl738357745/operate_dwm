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
--	commit;-->提交数据
--	DELETE
--	FROM
--udp_procedure_parameter
--	WHERE
--CREATOR = d_createName;
--
-----数据源注册
--	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
--	VALUES
--( d_table_dataSource, 'POM_PROJ_BY_KEY_NODE_PLAN', 'procedure', 'PARENT_ID','ID', 'ID', 'NAME', d_createName );
-----存储过程注册
--INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
--VALUES (d_table_dataSource_procedure,'P_POM_PROJ_BY_KEY_NODE_PLAN','POM_PROJ_BY_KEY_NODE_PLAN',1,d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'companyGUID','companyGUID','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'USERID','本人','',d_createName);
--
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'STATIONID','本岗位','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'DEPTID','本部门','',d_createName);
--INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
--VALUES (d_table_dataSource_procedure,'COMPANYID','本公司','',d_createName);
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
    --当前日期
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
     分期 as(
     select  case when 总分期数量=0 then get_uuid else ps.id end as id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,to_char(ps.sn,'0.0') as sn
     ,case when 无分期数量=1 and 总分期数量=1 then 1 else 0 end 是无分期 
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     left join (select PROJECT_ID,sum(case when STAGE_NAME='无分期' then 1 else 0 end) as 无分期数量,count(PROJECT_ID) as 总分期数量 from SYS_PROJECT_STAGE group by PROJECT_ID)  pcount
     on proj.id=pcount.PROJECT_ID
     )
    ,basedata AS(
    ---查询已审核的分期 关键节点计划 基础信息
   select 
   plan.PROJ_ID
   from  POM_PROJ_PLAN_NODE node
   left join POM_PROJ_PLAN plan on node.PROJ_PLAN_ID=plan.id
   --- 未考虑一个节点重复考核情况
   left join POM_NODE_EXAMINATION nodee on node.ORIGINAL_NODE_ID=nodee.ORIGINAL_NODE_ID

   ---已审核、关键节点计划、未禁用节点
   where plan.APPROVAL_STATUS='已审核' 
   and plan.PLAN_TYPE='关键节点计划'
   and node.id is not null
   and node.IS_DISABLE=0
   and node.IS_DELETE=0
   group by plan.PROJ_ID )


   ,项目_分期 as(
   select case when 分期.是无分期=1 then 分期.PROJECT_ID else 分期.id end as id
   ,case when 分期.是无分期=1 then 分期.PROJECT_NAME else 分期.PROJECT_NAME||'-'||分期.STAGE_NAME end as name 
    --统计的父级字段处理，无分期项目父级是公司，有分期项目父级是项目
   ,case when 分期.是无分期=1 then 分期.UNIT_ID else PROJECT_ID end parent_id
   ,分期.UNIT_ID
   ,分期.sn
   from basedata
   left join 分期 on basedata.PROJ_ID=分期.id
   union all 
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,proj.UNIT_ID
   ,proj.sn
   from sys_project proj
   left join (select * from 分期 where 是无分期=1) s on proj.id=s.project_id
   where s.id is null
   )
   
    select Id
   ,NAME
   ,PARENT_ID
   ,UNIT_ID
   ,sn FROM 项目_分期
  where UNIT_ID=v_id
  order by sn
   ;

END P_POM_PROJ_BY_KEY_NODE_PLAN;

--c9c30ef2-a519-4f7b-919f-cb166525d6b9	广州百花香料厂	585090ff-2aff-4b78-97cb-3629b06f04db		####