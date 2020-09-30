----------------------------chenl去化率脚本20200509--开始-----------------------------------------------------------------------------
----------------------------------------------------------定时任务；
delete from SYS_AUTOJOB where id='bc3585fa-8e9c-46ea-a4ca-1aec6d4a6d61';
---项目基本信息定时任务
/
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e9c-46ea-a4ca-1aec6d4a6d61','【去化率】更新项目基本信息','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'DECLARE
  PROJ_BASE_SPID VARCHAR2(200);
BEGIN
  P_DWM_SALE_RATE_PROJ(1,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'刘慧君','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e6c-46ea-a4ca-1aec6d4a6d61';
/
---定时拍照项目颗粒度去化率
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e6c-46ea-a4ca-1aec6d4a6d61','【去化率】拍照项目颗粒度','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'
DECLARE
  PROJ_SPID NVARCHAR2(200);
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(
    1,
    PROJ_SPID => PROJ_SPID
  );
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'刘慧君','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e7c-46ea-a4ca-1aec6d4a6d61';
/
---定时拍照公司颗粒度去化率
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e7c-46ea-a4ca-1aec6d4a6d61','【去化率】拍照公司颗粒度','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'
BEGIN
  P_DWM_SALE_RATE_BY_ORG();
--rollback; 
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'刘慧君','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e8c-46ea-a4ca-1aec6d4a6d61';
/
---定时拍照公司颗粒度去化率
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e8c-46ea-a4ca-1aec6d4a6d61','【去化率】拍照业态面积段颗粒度','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'
DECLARE
  SPID_INFO SYS_REFCURSOR;
  T_ROOM_INFO SYS_REFCURSOR;
  SPID_TREE_INFO SYS_REFCURSOR;
BEGIN

  P_DWM_SALE_RATE_BY_GRANULARITY(
    SPID_INFO => SPID_INFO,
    T_ROOM_INFO => T_ROOM_INFO,
    SPID_TREE_INFO => SPID_TREE_INFO
  );
 END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'刘慧君','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
-----------------------------------------------------------临时表 开始
--------------------------------------------------------
--  文件已创建 - 星期日-四月-12-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TMP_PROJ_BASE
--------------------------------------------------------
DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_PROJ_BASE';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE 'drop  table TMP_PROJ_BASE';
    END IF;
END;
/
CREATE GLOBAL TEMPORARY TABLE "TMP_PROJ_BASE" (
"ID"  VARCHAR2(500 BYTE),
"PROJECT_ID"  VARCHAR2(500 BYTE),
"PROJECT_NAME"  VARCHAR2(500 BYTE),
"ORG_ID"  VARCHAR2(500 BYTE),
"ORG_NAME"  VARCHAR2(500 BYTE),
"FIRST_OPEN_DATE"  DATE,
"OBTAIN_DATE"  DATE,
"COMPLETION_RECORD_DATE"  DATE,
"TAKE_LAND_DATE"  DATE,
"PLAN_FIRST_OPEN_DATE"  DATE,
"FIRST_OPEN_DURATION_BY_TL"  NUMBER(30,0),
"FIRST_OPEN_DURATION_BY_PLAN"  NUMBER(30,0),
"NEW_PLAN_FIRST_OPEN_DATE"  DATE,
"EXHIBITION_AREA_OPEN_DATE"  DATE,
"EXHIBITION_AREA_OPEN_BY_PLAN"  DATE,
"PLAN_APPROVAL_DATE"  DATE,
"PLAN_APPROVAL_DATE_BY_PLAN"  DATE,
"IS_OPERATE"  NUMBER(1,0),
"IS_CONSTRUCTION_BEGAN"  NUMBER(1,0),
"CREATED"  DATE,
"REMARK"  VARCHAR2(500 BYTE)
) ON COMMIT PRESERVE ROWS;
/
DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_PROJ_RELATED_DATE';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE 'drop  table TMP_PROJ_RELATED_DATE';
    END IF;
END;
/
CREATE GLOBAL TEMPORARY TABLE "TMP_PROJ_RELATED_DATE" (
   "ID"                   VARCHAR2(500 BYTE),
"PROJECT_ID"              VARCHAR2(500 BYTE),
"PROJECT_DATE_TYPE"       VARCHAR2(500 BYTE),
"PLAN_END_DATE"           DATE,--计划完成时间
"ACTUAL_END_DATE"         DATE,--实际完成时间
"ESTIMATE_END_DATE"       DATE,--预计完成时间
"REMARK"           VARCHAR2(500 BYTE)
) ON COMMIT PRESERVE ROWS;
/
DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_SALE_RATE_BY_PROJECT';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE 'drop  table TMP_SALE_RATE_BY_PROJECT';
    END IF;
END;
/
CREATE  GLOBAL TEMPORARY TABLE "TMP_SALE_RATE_BY_PROJECT" 
   (	"ID" VARCHAR2(100 BYTE), 
   	"ORG_ID" VARCHAR2(36 BYTE), 
	"ORG_NAME" VARCHAR2(500 BYTE), 
	"PROJECT_ID" VARCHAR2(100 BYTE), 
    "PROJECT_NAME" VARCHAR2(300 BYTE), 
	"FO_SALE_OUT_COUNT" NUMBER(30,0), 
	"FO_SALE_COUNT" NUMBER(30,0), 
	"FO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"FO_SALE_OUT_AREA" NUMBER(30,4), 
	"FO_SALE_AREA" NUMBER(30,4), 
	"FO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"FO_SALE_OUT_MONEY" NUMBER(30,4), 
	"FO_SALE_MONEY" NUMBER(30,4), 
	"FO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"FO_SURPLUS_SALE_MONEY" NUMBER(30,4), 
	"FO_SALE_AVERAGE_MONEY" NUMBER(30,4), 
	"FO_SALE_OUT_AVERAGE_MONEY" NUMBER(30,4), 
	"PO_SALE_OUT_COUNT" NUMBER(30,0), 
	"PO_SALE_COUNT" NUMBER(30,0), 
	"PO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"PO_SALE_OUT_AREA" NUMBER(30,4), 
	"PO_SALE_AREA" NUMBER(30,4), 
	"PO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"PO_SALE_OUT_MONEY" NUMBER(30,4), 
	"PO_SALE_MONEY" NUMBER(30,4), 
	"PO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"PO_SURPLUS_SALE_MONEY" NUMBER(30,4), 
	"PO_SALE_AVERAGE_MONEY" NUMBER(30,4), 
	"PO_SALE_OUT_AVERAGE_MONEY" NUMBER(30,4), 
	"EH_SALE_OUT_COUNT" NUMBER(30,0), 
	"EH_SALE_COUNT" NUMBER(30,0), 
	"EH_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"EH_SALE_OUT_AREA" NUMBER(30,4), 
	"EH_SALE_AREA" NUMBER(30,4), 
	"EH_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"EH_SALE_OUT_MONEY" NUMBER(30,4), 
	"EH_SALE_MONEY" NUMBER(30,4), 
	"EH_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"EH_SURPLUS_SALE_MONEY" NUMBER(30,4), 
	"EH_SALE_AVERAGE_MONEY" NUMBER(30,4), 
	"EH_SALE_OUT_AVERAGE_MONEY" NUMBER(30,4), 
	"SI_SALE_OUT_COUNT" NUMBER(30,0), 
	"SI_SALE_COUNT" NUMBER(30,0), 
	"SI_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"SI_SALE_OUT_AREA" NUMBER(30,4), 
	"SI_SALE_AREA" NUMBER(30,4), 
	"SI_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"SI_SALE_OUT_MONEY" NUMBER(30,4), 
	"SI_SALE_MONEY" NUMBER(30,4), 
	"SI_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"SI_SURPLUS_SALE_MONEY" NUMBER(30,4), 
	"SI_SALE_AVERAGE_MONEY" NUMBER(30,4), 
	"SI_SALE_OUT_AVERAGE_MONEY" NUMBER(30,4), 
	"CREATED" DATE, 
	"REMARK" VARCHAR2(500 BYTE)
   )  ON COMMIT PRESERVE ROWS;
/
DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_ROOM';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE 'drop  table TMP_ROOM';
    END IF;
END;
/
  CREATE  GLOBAL TEMPORARY TABLE "TMP_ROOM" 
   (	"ID" VARCHAR2(36 BYTE), 
    room_id VARCHAR2(36 BYTE), 
    BLD_AREA VARCHAR2(36 BYTE), 
	"ROOM_NAME" VARCHAR2(200 BYTE), 
	"PRODUCT_NAME" VARCHAR2(500 BYTE), 
	"AREA_LEVEL" VARCHAR2(500 BYTE)
	)ON COMMIT PRESERVE ROWS;
/
DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_SALE_RATE_BY_GRANULARITY';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE 'drop  table TMP_SALE_RATE_BY_GRANULARITY';
    END IF;
END;
/
 CREATE  GLOBAL TEMPORARY TABLE "TMP_SALE_RATE_BY_GRANULARITY" 
   (	"ID" VARCHAR2(36 BYTE), 
       "SORT" NUMBER,
    "GRANULARITY_ID" VARCHAR2(100 BYTE), 
	"PROJECT_ID" VARCHAR2(360 BYTE), 
    "PROJECT_NAME" VARCHAR2(300 BYTE), 
	"FO_SALE_OUT_COUNT" NUMBER, 
	"FO_SALE_COUNT" NUMBER, 
	"FO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"FO_SALE_OUT_AREA" NUMBER(30,2), 
	"FO_SALE_AREA" NUMBER(30,2), 
	"FO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"FO_SALE_OUT_MONEY" NUMBER(30,2), 
	"FO_SALE_MONEY" NUMBER(30,2), 
	"FO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"FO_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"FO_SALE_AVERAGE_MONEY" NUMBER(30,2), 
	"FO_SALE_OUT_AVERAGE_MONEY" NUMBER(30,2), 
	"PO_SALE_OUT_COUNT" NUMBER, 
	"PO_SALE_COUNT" NUMBER, 
	"PO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"PO_SALE_OUT_AREA" NUMBER(30,2), 
	"PO_SALE_AREA" NUMBER(30,2), 
	"PO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"PO_SALE_OUT_MONEY" NUMBER(30,2), 
	"PO_SALE_MONEY" NUMBER(30,2), 
	"PO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"PO_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"PO_SALE_AVERAGE_MONEY" NUMBER(30,2), 
	"PO_SALE_OUT_AVERAGE_MONEY" NUMBER(30,2), 
	"EH_SALE_OUT_COUNT" NUMBER, 
	"EH_SALE_COUNT" NUMBER, 
	"EH_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"EH_SALE_OUT_AREA" NUMBER(30,2), 
	"EH_SALE_AREA" NUMBER(30,2), 
	"EH_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"EH_SALE_OUT_MONEY" NUMBER(30,2), 
	"EH_SALE_MONEY" NUMBER(30,2), 
	"EH_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"EH_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"EH_SALE_AVERAGE_MONEY" NUMBER(30,2), 
	"EH_SALE_OUT_AVERAGE_MONEY" NUMBER(30,2), 
	"SI_SALE_OUT_COUNT" NUMBER, 
	"SI_SALE_COUNT" NUMBER, 
	"SI_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"SI_SALE_OUT_AREA" NUMBER(30,2), 
	"SI_SALE_AREA" NUMBER(30,2), 
	"SI_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"SI_SALE_OUT_MONEY" NUMBER(30,2), 
	"SI_SALE_MONEY" NUMBER(30,2), 
	"SI_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"SI_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"SI_SALE_AVERAGE_MONEY" NUMBER(30,2), 
	"SI_SALE_OUT_AVERAGE_MONEY" NUMBER(30,2), 
	"PARENT_ID" VARCHAR2(100 BYTE), 
	"DATA_GRANULARITY" VARCHAR2(500 BYTE), 
    "PRODUCT_NAME" VARCHAR2(500 BYTE), 
	"CREATED" DATE, 
	"REMARK" VARCHAR2(500 BYTE))
    ON COMMIT PRESERVE ROWS;
  / 
  DECLARE 
TABLEEXIST NUMBER;
BEGIN
SELECT COUNT(1) INTO TABLEEXIST FROM USER_TABLES WHERE TABLE_NAME='TMP_SALE_RATE_BY_ORG';
    IF TABLEEXIST=1 THEN
        EXECUTE IMMEDIATE ' drop  table TMP_SALE_RATE_BY_ORG';
    END IF;
END;
/
  CREATE  GLOBAL TEMPORARY TABLE "TMP_SALE_RATE_BY_ORG" 
   (	"ID" VARCHAR2(360 BYTE), 
	"ORG_ID" VARCHAR2(75 BYTE), 
	"ORG_NAME" VARCHAR2(500 BYTE), 
    "PARENT_ID" VARCHAR2(500 BYTE), 
    "IS_COMPANY" NUMBER,
    "LEVEL_RANK" number,
	"FO_SALE_OUT_COUNT" NUMBER, 
	"FO_SALE_COUNT" NUMBER, 
	"FO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"FO_SALE_OUT_AREA" NUMBER(30,2), 
	"FO_SALE_AREA" NUMBER(30,2), 
	"FO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"FO_SALE_OUT_MONEY" NUMBER(30,2), 
	"FO_SALE_MONEY" NUMBER(30,2), 
	"FO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"FO_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"PO_SALE_OUT_COUNT" NUMBER, 
	"PO_SALE_COUNT" NUMBER, 
	"PO_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"PO_SALE_OUT_AREA" NUMBER(30,2), 
	"PO_SALE_AREA" NUMBER(30,2), 
	"PO_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"PO_SALE_OUT_MONEY" NUMBER(30,2), 
	"PO_SALE_MONEY" NUMBER(30,2), 
	"PO_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"PO_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"EH_SALE_OUT_COUNT" NUMBER(30,2), 
	"EH_SALE_COUNT" NUMBER(30,2), 
	"EH_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"EH_SALE_OUT_AREA" NUMBER(30,2), 
	"EH_SALE_AREA" NUMBER(30,2), 
	"EH_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"EH_SALE_OUT_MONEY" NUMBER(30,2), 
	"EH_SALE_MONEY" NUMBER(30,2), 
	"EH_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"EH_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"SI_SALE_OUT_COUNT" NUMBER(30,2), 
	"SI_SALE_COUNT" NUMBER(30,2), 
	"SI_SALE_RATE_BY_COUNT" NUMBER(30,4), 
	"SI_SALE_OUT_AREA" NUMBER(30,2), 
	"SI_SALE_AREA" NUMBER(30,2), 
	"SI_SALE_RATE_BY_AREA" NUMBER(30,4), 
	"SI_SALE_OUT_MONEY" NUMBER(30,2), 
	"SI_SALE_MONEY" NUMBER(30,2), 
	"SI_SALE_RATE_BY_MONEY" NUMBER(30,4), 
	"SI_SURPLUS_SALE_MONEY" NUMBER(30,2), 
	"X_AXIS_PERIOD" VARCHAR2(200 BYTE), 
	"CREATED" DATE, 
	"REMARK" VARCHAR2(500 BYTE)
   )  ON COMMIT PRESERVE ROWS;
/
-----------------------------------------------------------临时表 结束

-----------------------------------------------------------存储过程 开始
CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_PROJ" (
    is_photograph    IN               NUMBER ,
    proj_base_spid   OUT              VARCHAR2
) AS
		--去化率项目基础数据刷新;作用=>去化率数据定时更新。
        --调用范围：P_DWM_SALE_RATE_BY_PROJ,P_DWM_SALE_RATE_BY_GRANULARITY,根据proj_base_spid使用tmp_proj_base数据
		--作者：陈丽
		--日期：2020-04-10
    spid VARCHAR2(36); --使用临时表的批次号
    plan_stage VARCHAR2(360):= '1期,一期,无分期';
node_exhibit_open_type VARCHAR2(50):='node_exhibit_open';
node_plan_approval_type VARCHAR2(50):='node_plan_approval';
node_get_land_type VARCHAR2(50):='node_get_land';
node_start_work_type VARCHAR2(50):='node_start_work';
node_completed_permit_type VARCHAR2(50):='node_completed_permit';
node_project_open_type VARCHAR2(50):='node_project_open';

node_exhibit_open VARCHAR2(50):='988e38a7-77ef-77eb-e053-0100007f3dda';	--备注--展示区开放（含售楼部、样板间）
node_plan_approval VARCHAR2(50):='988e38a7-77fa-77eb-e053-0100007f3dda';	--备注--规划方案批复
node_get_land VARCHAR2(50):='988e38a7-77c3-77eb-e053-0100007f3dda';	--备注--土地获取
node_start_work VARCHAR2(50):='988e38a7-7813-77eb-e053-0100007f3dda';	--备注--首开楼栋基础开工
node_completed_permit VARCHAR2(50):='988e38a7-7878-77eb-e053-0100007f3dda';	--备注--竣工备案
node_project_open VARCHAR2(50):='988e38a7-7827-77eb-e053-0100007f3dda';	--备注--项目开盘
dwm_REMARK VARCHAR2(200):='测试-chenl';
sys_created date:=sysdate;
BEGIN
delete tmp_proj_related_date;
delete tmp_proj_base;
commit;
--------创建临时表批次号
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  

------------------------------------------------备注------------------------------------------------备注--展示区开放（含售楼部、样板间）
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_exhibit_open_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_exhibit_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注
------------------------------------------------备注------------------------------------------------备注--规划方案批复
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_plan_approval_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_plan_approval                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注
------------------------------------------------备注------------------------------------------------备注--土地获取
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_get_land_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_get_land                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注
------------------------------------------------备注------------------------------------------------备注--首开楼栋基础开工
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_start_work_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_start_work                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注
------------------------------------------------备注------------------------------------------------备注--竣工备案
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_completed_permit_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_completed_permit                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注
------------------------------------------------备注------------------------------------------------备注--项目开盘
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_project_open_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------备注




    INSERT INTO tmp_proj_base (
        ID,--主键
        PROJECT_ID,--项目ID
        PROJECT_NAME,--项目名称
        ORG_ID,--所属事业部ID
        ORG_NAME,--所属事业部
        FIRST_OPEN_DATE,--首开日期
        OBTAIN_DATE,--项目获得日期
        COMPLETION_RECORD_DATE,--首次竣备日期
        TAKE_LAND_DATE,--拿地日期
        PLAN_FIRST_OPEN_DATE,--计划首开日期
        FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        PLAN_APPROVAL_DATE,--方案批复日期
        PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        IS_OPERATE,--是否操盘
        IS_CONSTRUCTION_BEGAN,--是否已开工
        CREATED,--创建日期
        REMARK--备注信息
    )
        SELECT
            spid                          AS id,
            project.project_original_id   AS project_id,--项目ID
            project.project_name          AS project_name,--项目名称
            project.company_id            AS org_id,--所属事业部ID
            project.company_name          AS org_name,--所属事业部
            node_project_open1.actual_end_date     AS first_open_date,--实际首开时间----1
            node_get_land1.actual_end_date      AS obtain_date,--项目获取日期
            node_completed_permit1.actual_end_date     AS first_completion_record_date,--首次竣备日期------2
            node_get_land1.actual_end_date     AS take_land_date,--拿地日期----3
            node_project_open1.plan_end_date     AS plan_first_open_date,--计划首开日期-----4
            node_project_open1.plan_end_date - node_get_land1.actual_end_date AS first_open_duration_by_plan,--原计划首开时长
            node_project_open1.actual_end_date - node_get_land1.actual_end_date AS first_open_duration_by_tl,--拿地至首开时间
            node_project_open1.estimate_end_date      AS new_plan_first_open_date,--最新预计首开日期----5
            node_exhibit_open1.actual_end_date     AS exhibition_area_open_date,--实际展示区开放时间---6
            node_exhibit_open1.plan_end_date ,--计划展示区开放时间----7
            node_plan_approval1.actual_end_date     AS plan_approval_date,--方案批复时间----7
            node_plan_approval1.plan_end_date  ,--计划方案批复时间----7 
            CASE
                WHEN project.proj_cooperate = '操盘' THEN
                    1
                ELSE
                    0
            END AS is_operate,--as project.PROJ_COOPERATE 是否操盘
            CASE
                WHEN node_start_work1.actual_end_date is not null THEN
                    1
                ELSE
                    0
            END     AS is_construction_began,--是否开工----7
            sys_created,
            '测试' AS remark
        FROM
            mdm_project             project  
--备注--展示区开放（含售楼部、样板间）	
LEFT JOIN tmp_proj_related_date   node_exhibit_open1 ON project.project_original_id = node_exhibit_open1.project_id AND node_exhibit_open1.project_date_type = node_exhibit_open_type
--备注--规划方案批复	
LEFT JOIN tmp_proj_related_date   node_plan_approval1 ON project.project_original_id = node_plan_approval1.project_id AND node_plan_approval1.project_date_type = node_plan_approval_type
--备注--土地获取	
LEFT JOIN tmp_proj_related_date   node_get_land1 ON project.project_original_id = node_get_land1.project_id AND node_get_land1.project_date_type = node_get_land_type
--备注--首开楼栋基础开工	
LEFT JOIN tmp_proj_related_date   node_start_work1 ON project.project_original_id = node_start_work1.project_id AND node_start_work1.project_date_type = node_start_work_type
--备注--竣工备案	
LEFT JOIN tmp_proj_related_date   node_completed_permit1 ON project.project_original_id = node_completed_permit1.project_id AND node_completed_permit1.project_date_type = node_completed_permit_type
--备注--项目开盘	
LEFT JOIN tmp_proj_related_date   node_project_open1 ON project.project_original_id = node_project_open1.project_id AND node_project_open1.project_date_type = node_project_open_type
WHERE project.approval_status = '已审核';

    IF is_photograph <> 0 THEN
--先删除，历史的项目数据，后插入新的数据
        DELETE FROM dwm_sale_rate_project  where CREATED<sys_created;

        INSERT INTO dwm_sale_rate_project (
            ID,--主键
        PROJECT_ID,--项目ID
        PROJECT_NAME,--项目名称
        ORG_ID,--所属事业部ID
        ORG_NAME,--所属事业部
        FIRST_OPEN_DATE,--首开日期
        OBTAIN_DATE,--项目获得日期
        COMPLETION_RECORD_DATE,--首次竣备日期
        TAKE_LAND_DATE,--拿地日期
        PLAN_FIRST_OPEN_DATE,--计划首开日期
        FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        PLAN_APPROVAL_DATE,--方案批复日期
        PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        IS_OPERATE,--是否操盘
        IS_CONSTRUCTION_BEGAN,--是否已开工
        CREATED,--创建日期
        REMARK--备注信息
        )
            SELECT
        get_uuid,
        PROJECT_ID,--项目ID
        PROJECT_NAME,--项目名称
        ORG_ID,--所属事业部ID
        ORG_NAME,--所属事业部
        FIRST_OPEN_DATE,--首开日期
        OBTAIN_DATE,--项目获得日期
        COMPLETION_RECORD_DATE,--首次竣备日期
        TAKE_LAND_DATE,--拿地日期
        PLAN_FIRST_OPEN_DATE,--计划首开日期
        FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        PLAN_APPROVAL_DATE,--方案批复日期
        PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        IS_OPERATE,--是否操盘
        IS_CONSTRUCTION_BEGAN,--是否已开工
        CREATED,--创建日期
        dwm_REMARK--备注信息
            FROM
                tmp_proj_base
            WHERE
                id = spid;
    commit;
    END IF;


    proj_base_spid := spid;
END P_DWM_SALE_RATE_PROJ;
/
create or replace PROCEDURE "P_DWM_SALE_RATE_BY_PROJ" (
    IS_PHOTOGRAPH in number:=0,
    proj_SPID  out NVARCHAR2
    
) AS
		--项目颗粒度去化率拍照；作用=》定时拍照
        --调用范围=》P_DWM_SALE_RATE_BY_ORG
		--作者：陈丽
		--日期：2020-04-10
  PROJ_BASE_INFO SYS_REFCURSOR;
  PROJ_DATE_INFO SYS_REFCURSOR;
  PROJ_BASE_SPID VARCHAR2(2000);
  sys_created date:=sysdate;
  spid VARCHAR2(360); --使用临时表的批次号
  dwm_REMARK VARCHAR2(200):='测试-chenl';
BEGIN
delete TMP_SALE_RATE_BY_PROJECT;
commit;
--------创建临时表批次号
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
proj_SPID:=spid;
------项目基本信息
BEGIN

  P_DWM_SALE_RATE_PROJ(0,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ----- 
 INSERT INTO TMP_SALE_RATE_BY_PROJECT (ID---【1】主键
,PROJECT_ID---【2】项目ID
,PROJECT_NAME
,ORG_ID
,ORG_NAME
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
)select 
spid as ID---【1】主键
,project_id as PROJECT_ID---【2】项目ID
,project_name
,ORG_ID
,ORG_NAME
-----------------------------------K1、首开去化率开始--------------------
,"首开去化套数" as FO_SALE_OUT_COUNT---【3】首开去化套数
,"首开推售套数" as FO_SALE_COUNT---【4】首开推售套数
,case when 首开推售套数=0 then 0 else round("首开去化套数"/"首开推售套数",4)  end as FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,"首开去化面积" as FO_SALE_OUT_AREA---【6】首开去化面积
,"首开推售面积" as FO_SALE_AREA---【7】首开推售面积
,case when 首开推售面积=0 then 0 else round("首开去化面积"/"首开推售面积",4)  end as FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,"首开去化货值" as FO_SALE_OUT_MONEY---【9】首开去化货值
,"首开推售货值" as FO_SALE_MONEY---【10】首开推售货值
,case when 首开推售货值=0 then 0 else round("首开去化货值"/"首开推售货值",4)  end as FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,"首开推售货值"-"首开去化货值" as FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,case when 首开推售面积=0 then 0 else round("首开推售货值"/"首开推售面积",4)  end  as FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,case when 首开去化面积=0 then 0 else round("首开去化货值"/"首开去化面积",4)  end as FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
-----------------------------------K3、全案去化率 （单位：%）--------------------
,"全案已去化套数" as PO_SALE_OUT_COUNT---【15】全案去化套数
,"全案已领证套数" as PO_SALE_COUNT---【16】全案推售套数
,case when 全案已领证套数=0 then 0 else round("全案已去化套数"/"全案已领证套数",4)  end as PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,"全案已去化面积" as PO_SALE_OUT_AREA---【18】全案去化面积
,"全案已领证面积" as PO_SALE_AREA---【19】全案推售面积
,case when 全案已领证面积=0 then 0 else round("全案已去化面积"/"全案已领证面积",4)  end as PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,"全案已去化货值" as PO_SALE_OUT_MONEY---【21】全案去化货值
,"全案已领证货值" as PO_SALE_MONEY---【22】全案推售货值
,case when 全案已领证货值=0 then 0 else round("全案已去化货值"/"全案已领证货值",4)  end  as PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,"全案已领证货值"-"全案已去化货值" as PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,case when 全案已领证面积=0 then 0 else round("全案已领证货值"/"全案已领证面积",4)  end  as PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,case when 全案已去化面积=0 then 0 else round("全案已去化货值"/"全案已去化面积",4)  end   PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
-----------------------------------K4、现房去化率 （单位：%）--------------------
,"现房去化套数" as EH_SALE_OUT_COUNT---【27】现房去化套数
,"现房推售套数" as EH_SALE_COUNT---【28】现房推售套数
,case when 现房推售套数=0 then 0 else  round("现房去化套数"/"现房推售套数",4) end as EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,"现房去化面积" as EH_SALE_OUT_AREA---【30】现房去化面积
,"现房推售面积" as EH_SALE_AREA---【31】现房推售面积
,case when 现房推售面积=0 then 0 else  round("现房去化面积"/"现房推售面积",4) end as EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,"现房去化金额" as EH_SALE_OUT_MONEY---【33】现房去化货值
,"现房推售金额" as EH_SALE_MONEY---【34】现房推售货值
,case when 现房推售金额=0 then 0 else  round("现房去化金额"/"现房推售金额",4) end as EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,"现房推售金额"-"现房去化金额" as EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,case when 现房推售面积=0 then 0 else  round("现房推售金额"/"现房推售面积",4) end  as EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,case when 现房去化面积=0 then 0 else  round("现房去化金额"/"现房去化面积",4) end  as EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
-----------------------------------K5、顽固性库存去化率 （单位：%）--------------------
,"顽固去化套数" as SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,"顽固推售套数" as SI_SALE_COUNT---【40】顽固性库存推售套数
,case when 顽固推售套数=0 then 0 else  round("顽固去化套数"/"顽固推售套数",4) end as SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,"顽固去化面积" as SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,"顽固推售面积" as SI_SALE_AREA---【43】顽固性库存推售面积
,case when 顽固推售面积=0 then 0 else  round("顽固去化面积"/"顽固推售面积",4) end  as SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,"顽固去化金额" as SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,"顽固推售金额" as SI_SALE_MONEY---【46】顽固性库存推售货值
,case when 顽固推售金额=0 then 0 else  round("顽固去化金额"/"顽固推售金额",4) end as SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,"顽固推售金额"-"顽固去化金额" SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,case when 顽固推售面积=0 then 0 else  round("顽固推售金额"/"顽固推售面积",4) end as SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,case when 顽固推售面积=0 then 0 else  round("顽固去化金额"/"顽固推售面积",4) end as SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,sys_created as CREATED---【51】创建日期
from 
(select 
------首次开盘30天内的签约金额（首开去化货值）: 
---------->房间“合同成交总价”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约
sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "首开去化货值"
------首次开盘已取证货值（首开推售货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.SALE_STATE='签约' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "首开推售货值"
------首次开盘30天内的签约面积（首开去化面积）:
---------->房间“最新建筑面积”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "首开去化面积"
------首次开盘的已取证面积（首开推售面积）:
---------->房间“最新建筑面积”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "首开推售面积"
------首次开盘30天内的签约套数（首开去化套数）:
---------->房间“汇总”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "首开去化套数"
------首次开盘的已取证套数（首开推售套数）:
---------->房间“汇总”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "首开推售套数"

------全案------全案------全案------全案------全案------全案------全案 
------全案（已去化货值）: 
---------->房间“合同成交总价”
---------->房间“销售状态”=签约
,sum(case when room.SALE_STATE='签约' then room.TRADE_TOTAL else 0 end ) as "全案已去化货值"
------全案（已领证货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
,sum(case when room.SALE_STATE='签约'  then room.TRADE_TOTAL  
when room.SALE_STATE<>'签约' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "全案已领证货值"
------全案（已去化面积）:
---------->房间“最新建筑面积”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约'  then room.NEW_BLD_AREA else 0 end ) as "全案已去化面积"
------全案（已领证面积）:
---------->房间“最新建筑面积”
,sum(case when room.SALE_STATE='签约' or build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "全案已领证面积"
------全案（已去化套数):
---------->房间“汇总”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' then 1 else 0 end ) as "全案已去化套数"
------全案（已领证套数):
---------->房间“汇总”
,sum(case when room.SALE_STATE='签约' or build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "全案已领证套数"
------现房------现房------现房------现房------现房------现房------现房------现房------现房
----现房去化面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "现房去化面积" ,
----现房推售面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as 现房推售面积,
----现房去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  现房去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----现房推售金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> '签约'   then room.BZ_TOTAL  when room.SALE_STATE = '签约' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as 现房推售金额,
----现房去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  现房去化套数,
----现房推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or  (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as 现房推售套数
------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存
----顽固推售面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as 顽固去化面积,
----顽固去化面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then room.NEW_BLD_AREA else 0 end) as 顽固推售面积,
----顽固去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  顽固去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----顽固推售金额
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') then room.TRADE_TOTAL  --已经在今年签约的算签约金额
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> '签约' then room.BZ_TOTAL  else 0 end) as 顽固推售金额,  --未签约的算校准总价
----顽固去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  顽固去化套数,
----顽固推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then 1 else 0 end) as 顽固推售套数
,proj.project_id,
proj.project_name,
proj.org_id,
proj.org_name,
proj.first_open_date,
proj.obtain_date,
proj.COMPLETION_RECORD_DATE,
proj.take_land_date,
proj.plan_first_open_date,
proj.first_open_duration_by_tl,
proj.first_open_duration_by_plan,
proj.new_plan_first_open_date,
proj.exhibition_area_open_date,
proj.plan_approval_date,
proj.is_operate,
proj.is_construction_began
from tmp_proj_base proj left join  MDM_ROOM room  
on proj.project_id=room.project_id  and  proj.id = PROJ_BASE_SPID
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
    ,proj.project_name,
    proj.org_id,
    proj.org_name,
    proj.first_open_date,
    proj.obtain_date,
    proj.COMPLETION_RECORD_DATE,
    proj.take_land_date,
    proj.plan_first_open_date,
    proj.first_open_duration_by_tl,
    proj.first_open_duration_by_plan,
    proj.new_plan_first_open_date,
    proj.exhibition_area_open_date,
    proj.plan_approval_date,
    proj.is_operate,
    proj.is_construction_began) result  order by "全案已去化货值" asc
;

-- 
IF is_photograph <> 0 THEN
----先将表数据移入，历史的项目数据，后插入新的数据
------------------------------------------------------数据移入历史表;
INSERT INTO dwm_sale_rate_by_proj_history (
    id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money,
    created,
    remark
)
SELECT
    id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money,
    created,
    remark
FROM
    dwm_sale_rate_by_proj_history;
commit;
------------------------------------------------------删除已移入历史表树；
DELETE FROM DWM_SALE_RATE_BY_PROJECT ;
    --where REMARK=dwm_REMARK;
commit;
--------------------------------------------------------新增拍照数据;
INSERT INTO DWM_SALE_RATE_BY_PROJECT (
ID---【1】主键
,PROJECT_ID---【2】项目ID
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
,REMARK---【52】备注信息
        )
            SELECT
PROJECT_ID      ID---【1】主键
,PROJECT_ID---【2】项目ID
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
,dwm_REMARK---【52】备注信息
            FROM
                TMP_SALE_RATE_BY_PROJECT where id=spid;
commit;
    END IF;
END P_DWM_SALE_RATE_BY_PROJ;
/
CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_BY_ORG"  AS
		--公司颗粒度去化率；作用=》定时任务拍照
		--作者：陈丽
		--日期：2020-04-10

    PROJ_SPID NVARCHAR2(200);
    sys_created       DATE := SYSDATE;
    spid_tree              VARCHAR2(360); --使用临时表的批次号
    spid_sum              VARCHAR2(360); --使用临时表的批次号
    spid_result              VARCHAR2(360); --使用临时表的批次号
    dwm_remark        VARCHAR2(200) := '测试-chenl';
    p_X_AXIS_PERIOD  VARCHAR2(200):=to_char(sysdate, 'yyyy') ||'-'||to_char(sysdate, 'MM' );
BEGIN
delete tmp_sale_rate_by_org;
--------创建临时表批次号
    SELECT
        get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_sum,spid_result
    FROM
        dual;  

------项目基本信息
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(0,
    PROJ_SPID => PROJ_SPID
  );
END;

----组装树
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--【  2】项目ID
        org_name,--【  3】项目名称
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--【  4】首开去化套数
        fo_sale_count,--【  5】首开推售套数
        fo_sale_out_area,--【  7】首开去化面积
        fo_sale_area,--【  8】首开推售面积
        fo_sale_out_money,--【 10】首开去化货值
        fo_sale_money,--【 11】首开推售货值
        fo_surplus_sale_money,--【 13】首开剩余货值
        po_sale_out_count,--【 14】全案去化套数
        po_sale_count,--【 15】全案推售套数
        po_sale_out_area,--【 17】全案去化面积
        po_sale_area,--【 18】全案推售面积
        po_sale_out_money,--【 20】全案去化货值
        po_sale_money,--【 21】全案推售货值
        po_surplus_sale_money,--【 23】全案剩余货值
        eh_sale_out_count,--【 24】现房去化套数
        eh_sale_count,--【 25】现房推售套数
        eh_sale_out_area,--【 27】现房去化面积
        eh_sale_area,--【 28】现房推售面积
        eh_sale_out_money,--【 30】现房去化货值
        eh_sale_money,--【 31】现房推售货值
        eh_surplus_sale_money,--【 33】现房剩余货值
        si_sale_out_count,--【 34】顽固性库存去化套数
        si_sale_count,--【 35】顽固性库存推售套数
        si_sale_out_area,--【 37】顽固性库存去化面积
        si_sale_area,--【 38】顽固性库存推售面积
        si_sale_out_money,--【 40】顽固性库存去化货值
        si_sale_money,--【 41】顽固性库存推售货值
        si_surplus_sale_money--【 43】顽固性库存剩余货值
    )
        SELECT
            spid_tree,
            id AS org_id,
            org_name,
            parent_id,
            IS_COMPANY,
            LEVEL_RANK,
            0 AS fo_sale_out_count,--【  4】首开去化套数
            0 AS fo_sale_count,--【  5】首开推售套数
            0 AS fo_sale_out_area,--【  7】首开去化面积
            0 AS fo_sale_area,--【  8】首开推售面积
            0 AS fo_sale_out_money,--【 10】首开去化货值
            0 AS fo_sale_money,--【 11】首开推售货值
            0 AS fo_surplus_sale_money,--【 13】首开剩余货值
            0 AS po_sale_out_count,--【 14】全案去化套数
            0 AS po_sale_count,--【 15】全案推售套数
            0 AS po_sale_out_area,--【 17】全案去化面积
            0 AS po_sale_area,--【 18】全案推售面积
            0 AS po_sale_out_money,--【 20】全案去化货值
            0 AS po_sale_money,--【 21】全案推售货值
            0 AS po_surplus_sale_money,--【 23】全案剩余货值
            0 AS eh_sale_out_count,--【 24】现房去化套数
            0 AS eh_sale_count,--【 25】现房推售套数
            0 AS eh_sale_out_area,--【 27】现房去化面积
            0 AS eh_sale_area,--【 28】现房推售面积
            0 AS eh_sale_out_money,--【 30】现房去化货值
            0 AS eh_sale_money,--【 31】现房推售货值
            0 AS eh_surplus_sale_money,--【 33】现房剩余货值
            0 AS si_sale_out_count,--【 34】顽固性库存去化套数
            0 AS si_sale_count,--【 35】顽固性库存推售套数
            0 AS si_sale_out_area,--【 37】顽固性库存去化面积
            0 AS si_sale_area,--【 38】顽固性库存推售面积
            0 AS si_sale_out_money,--【 40】顽固性库存去化货值
            0 AS si_sale_money,--【 41】顽固性库存推售货值
            0 AS si_surplus_sale_money--【 43】顽固性库存剩余货值
        FROM
            sys_business_unit where IS_COMPANY=1
        UNION ALL
        SELECT
            spid_tree,
            project_id,
            org_name,
            org_id AS parent_id,
            0,
            null,
            fo_sale_out_count,--【  4】首开去化套数
            fo_sale_count,--【  5】首开推售套数
            fo_sale_out_area,--【  7】首开去化面积
            fo_sale_area,--【  8】首开推售面积
            fo_sale_out_money,--【 10】首开去化货值
            fo_sale_money,--【 11】首开推售货值
            fo_surplus_sale_money,--【 13】首开剩余货值
            po_sale_out_count,--【 14】全案去化套数
            po_sale_count,--【 15】全案推售套数
            po_sale_out_area,--【 17】全案去化面积
            po_sale_area,--【 18】全案推售面积
            po_sale_out_money,--【 20】全案去化货值
            po_sale_money,--【 21】全案推售货值
            po_surplus_sale_money,--【 23】全案剩余货值
            eh_sale_out_count,--【 24】现房去化套数
            eh_sale_count,--【 25】现房推售套数
            eh_sale_out_area,--【 27】现房去化面积
            eh_sale_area,--【 28】现房推售面积
            eh_sale_out_money,--【 30】现房去化货值
            eh_sale_money,--【 31】现房推售货值
            eh_surplus_sale_money,--【 33】现房剩余货值
            si_sale_out_count,--【 34】顽固性库存去化套数
            si_sale_count,--【 35】顽固性库存推售套数
            si_sale_out_area,--【 37】顽固性库存去化面积
            si_sale_area,--【 38】顽固性库存推售面积
            si_sale_out_money,--【 40】顽固性库存去化货值
            si_sale_money,--【 41】顽固性库存推售货值
            si_surplus_sale_money--【 43】顽固性库存剩余货值
        FROM
            tmp_sale_rate_by_project where id=proj_spid;           
----汇总          
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--【  2】项目ID
        org_name,--【  3】项目名称
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--【  4】首开去化套数
        fo_sale_count,--【  5】首开推售套数
        fo_sale_out_area,--【  7】首开去化面积
        fo_sale_area,--【  8】首开推售面积
        fo_sale_out_money,--【 10】首开去化货值
        fo_sale_money,--【 11】首开推售货值
        fo_surplus_sale_money,--【 13】首开剩余货值
        po_sale_out_count,--【 14】全案去化套数
        po_sale_count,--【 15】全案推售套数
        po_sale_out_area,--【 17】全案去化面积
        po_sale_area,--【 18】全案推售面积
        po_sale_out_money,--【 20】全案去化货值
        po_sale_money,--【 21】全案推售货值
        po_surplus_sale_money,--【 23】全案剩余货值
        eh_sale_out_count,--【 24】现房去化套数
        eh_sale_count,--【 25】现房推售套数
        eh_sale_out_area,--【 27】现房去化面积
        eh_sale_area,--【 28】现房推售面积
        eh_sale_out_money,--【 30】现房去化货值
        eh_sale_money,--【 31】现房推售货值
        eh_surplus_sale_money,--【 33】现房剩余货值
        si_sale_out_count,--【 34】顽固性库存去化套数
        si_sale_count,--【 35】顽固性库存推售套数
        si_sale_out_area,--【 37】顽固性库存去化面积
        si_sale_area,--【 38】顽固性库存推售面积
        si_sale_out_money,--【 40】顽固性库存去化货值
        si_sale_money,--【 41】顽固性库存推售货值
        si_surplus_sale_money--【 43】顽固性库存剩余货值
    )
 select spid_sum,org_id,org_name,parent_id,IS_COMPANY,LEVEL_RANK
,(select sum(FO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_COUNT
,(select sum(FO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_COUNT
,(select sum(FO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_AREA
,(select sum(FO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_AREA
,(select sum(FO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_MONEY
,(select sum(FO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_MONEY
,(select sum(FO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SURPLUS_SALE_MONEY
,(select sum(PO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_COUNT
,(select sum(PO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_COUNT
,(select sum(PO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_AREA
,(select sum(PO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_AREA
,(select sum(PO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_MONEY
,(select sum(PO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_MONEY
,(select sum(PO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SURPLUS_SALE_MONEY
,(select sum(EH_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_COUNT
,(select sum(EH_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_COUNT
,(select sum(EH_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_AREA
,(select sum(EH_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_AREA
,(select sum(EH_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_MONEY
,(select sum(EH_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_MONEY
,(select sum(EH_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SURPLUS_SALE_MONEY
,(select sum(SI_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_COUNT
,(select sum(SI_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_COUNT
,(select sum(SI_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_AREA
,(select sum(SI_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_AREA
,(select sum(SI_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_MONEY
,(select sum(SI_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_MONEY
,(select sum(SI_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SURPLUS_SALE_MONEY
from tmp_sale_rate_by_org s where id=spid_tree
order by org_id  ; 
----计算率
INSERT INTO tmp_sale_rate_by_org (
ID,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
LEVEL_RANK,
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK" )
select spid_result,ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
LEVEL_RANK,
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end as  FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end as  FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end as FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SALE_MONEY-FO_SALE_OUT_MONEY as FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
case when FO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end as PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end as PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end as PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SALE_MONEY-PO_SALE_OUT_MONEY as PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end as EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end  as EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end  as EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SALE_MONEY-EH_SALE_OUT_MONEY as EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end  as SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end  as SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end  as SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SALE_MONEY-SI_SALE_OUT_MONEY as SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
p_X_AXIS_PERIOD,--【44】时间（横坐标）
sys_created,--【45】创建时间
dwm_remark--【46】备注信息
from tmp_sale_rate_by_org where IS_COMPANY=1 and id=spid_sum and LEVEL_RANK<=2
;
----插入到目标表

   DELETE FROM dwm_sale_rate_by_org where  X_AXIS_PERIOD=p_X_AXIS_PERIOD;
   --and REMARK=dwm_REMARK;

   INSERT INTO dwm_sale_rate_by_org (
ID,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK" )
select get_uuid,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK"
from tmp_sale_rate_by_org where id=spid_result;
commit;  
END p_dwm_sale_rate_by_org;
/
create or replace PROCEDURE "P_DWM_SALE_RATE_BY_GRANULARITY" (
    spid_info   OUT  SYS_REFCURSOR,
    t_room_info   OUT  SYS_REFCURSOR ,
    spid_tree_info   OUT  SYS_REFCURSOR
) AS
		--业态面积段颗粒度去化率；作用=》定时任务拍照
		--作者：陈丽
		--日期：2020-04-10
  PROJ_BASE_SPID VARCHAR2(2000);
  sys_created date:=sysdate;
  spid VARCHAR2(360); --使用临时表的批次号
  spid_tree VARCHAR2(360); --使用临时表的批次号
  dwm_REMARK VARCHAR2(200):='测试-chenl';
  ----------------------
  v_sql clob;
  v_sql_start VARCHAR2(2000):= ' case ';
  v_sql_content clob:= '';
  v_sql_end VARCHAR2(2000):= '  else ''主数据面积段外'' end  ';
BEGIN
delete TMP_ROOM;
delete TMP_SALE_RATE_BY_GRANULARITY;
---------------------------
--------------------------------------------------------创建临时表批次号
    SELECT
        get_uuid(),get_uuid()
    INTO spid,spid_tree
    FROM
        dual;  
---------------------------------------------计算业态面积段1.拼接查询语句
 FOR item IN (
   select 
    ' when '||l.lower_limit_value||l.lower_limit_type||'room.NEW_BLD_AREA and room.NEW_BLD_AREA '||l.upper_limit_type||l.upper_limit_value
    ||' and (case when room.PRODUCT_NAME<>''住宅'' then ''商铺及其他'' else ''住宅'' end)='''||p.attribute_name||''' then ''' ||l.attribute_name||''' ' as aa,
    l.upper_limit_type,
    l.lower_limit_type,
    l.upper_limit_value,
    p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null
        ) LOOP 
    ---拼接字符串
         v_sql_content := v_sql_content||item.aa;
        END LOOP;
    --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                     || v_sql_content
                     || v_sql_end;
        ELSE
            v_sql := '''''';
        END IF;
        
       v_sql:= 'INSERT INTO TMP_ROOM(id,room_ID,BLD_AREA,ROOM_NAME,PRODUCT_NAME,AREA_LEVEL) select '''||spid||''',id,NEW_BLD_AREA,room_name,case when room.product_name<>''住宅'' then ''商铺及其他'' else ''住宅'' end,'
       ||v_sql|| ' as NODE_WARNING from mdm_room room';
         dbms_output.put_line(v_sql);
       execute immediate v_sql;
        
        OPEN t_room_info FOR select * from TMP_ROOM;  
-----------------------------------------------项目基本信息
BEGIN
  P_DWM_SALE_RATE_PROJ(0,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ------------------------------------------------------------业态面积段树拼接 spid_tree
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
,"SORT"
,GRANULARITY_ID--颗粒度id
,PROJECT_ID---【2】项目ID
,PROJECT_NAME--项目名称
,PARENT_ID---父级id
,DATA_GRANULARITY--颗粒度名称
)
-----业态
select spid_tree
,b.order_code
,proj.PROJECT_ID||b."业态" as GRANULARITY_ID
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,null as parentId 
,b."业态" as text   
 from (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
(select 
   case when l.attribute_name<>'住宅' then '商铺及其他' else '住宅' end  as "业态",order_code  from mdm_attribute_area_level l where parent_id is null) b
   union all
-----面积段
select spid_tree
,a.order_code
,proj.PROJECT_ID||ptype||a.areaStage as GRANULARITY_ID
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,proj.PROJECT_ID||ptype as parentId 
,a.areaStage as text
from  (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
( select 
    l.attribute_name as areaStage,l.order_code,case when p.attribute_name<>'住宅' then '商铺及其他' else '住宅' end  as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null) a;
    
OPEN spid_tree_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid_tree;  
------------------------------------------------------面积段数据 spid

 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
,GRANULARITY_ID
,PROJECT_ID---【2】项目ID
,PROJECT_NAME
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,PARENT_ID  
,DATA_GRANULARITY
,PRODUCT_NAME
,CREATED---【51】创建日期
,REMARK
)select 
spid as ID---【1】主键
,project_id||PRODUCT_NAME||AREA_LEVEL
,project_id as PROJECT_ID---【2】项目ID
,project_name
-----------------------------------K1、首开去化率开始--------------------
,"首开去化套数" as FO_SALE_OUT_COUNT---【3】首开去化套数
,"首开推售套数" as FO_SALE_COUNT---【4】首开推售套数
,case when 首开推售套数=0 then 0 else round("首开去化套数"/"首开推售套数",4)  end as FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,"首开去化面积" as FO_SALE_OUT_AREA---【6】首开去化面积
,"首开推售面积" as FO_SALE_AREA---【7】首开推售面积
,case when 首开推售面积=0 then 0 else round("首开去化面积"/"首开推售面积",4)  end as FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,"首开去化货值" as FO_SALE_OUT_MONEY---【9】首开去化货值
,"首开推售货值" as FO_SALE_MONEY---【10】首开推售货值
,case when 首开推售货值=0 then 0 else round("首开去化货值"/"首开推售货值",4)  end as FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,"首开推售货值"-"首开去化货值" as FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,case when 首开推售面积=0 then 0 else round("首开推售货值"/"首开推售面积",4)  end  as FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,case when 首开去化面积=0 then 0 else round("首开去化货值"/"首开去化面积",4)  end as FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
-----------------------------------K3、全案去化率 （单位：%）--------------------
,"全案已去化套数" as PO_SALE_OUT_COUNT---【15】全案去化套数
,"全案已领证套数" as PO_SALE_COUNT---【16】全案推售套数
,case when 全案已领证套数=0 then 0 else round("全案已去化套数"/"全案已领证套数",4)  end as PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,"全案已去化面积" as PO_SALE_OUT_AREA---【18】全案去化面积
,"全案已领证面积" as PO_SALE_AREA---【19】全案推售面积
,case when 全案已领证面积=0 then 0 else round("全案已去化面积"/"全案已领证面积",4)  end as PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,"全案已去化货值" as PO_SALE_OUT_MONEY---【21】全案去化货值
,"全案已领证货值" as PO_SALE_MONEY---【22】全案推售货值
,case when 全案已领证货值=0 then 0 else round("全案已去化货值"/"全案已领证货值",4)  end  as PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,"全案已领证货值"-"全案已去化货值" as PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,case when 全案已领证面积=0 then 0 else round("全案已领证货值"/"全案已领证面积",4)  end  as PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,case when 全案已去化面积=0 then 0 else round("全案已去化货值"/"全案已去化面积",4)  end   PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
-----------------------------------K4、现房去化率 （单位：%）--------------------
,"现房去化套数" as EH_SALE_OUT_COUNT---【27】现房去化套数
,"现房推售套数" as EH_SALE_COUNT---【28】现房推售套数
,case when 现房推售套数=0 then 0 else  round("现房去化套数"/"现房推售套数",4) end as EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,"现房去化面积" as EH_SALE_OUT_AREA---【30】现房去化面积
,"现房推售面积" as EH_SALE_AREA---【31】现房推售面积
,case when 现房推售面积=0 then 0 else  round("现房去化面积"/"现房推售面积",4) end as EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,"现房去化金额" as EH_SALE_OUT_MONEY---【33】现房去化货值
,"现房推售金额" as EH_SALE_MONEY---【34】现房推售货值
,case when 现房推售金额=0 then 0 else  round("现房去化金额"/"现房推售金额",4) end as EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,"现房推售金额"-"现房去化金额" as EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,case when 现房推售面积=0 then 0 else  round("现房推售金额"/"现房推售面积",4) end  as EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,case when 现房去化面积=0 then 0 else  round("现房去化金额"/"现房去化面积",4) end  as EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
-----------------------------------K5、顽固性库存去化率 （单位：%）--------------------
,"顽固去化套数" as SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,"顽固推售套数" as SI_SALE_COUNT---【40】顽固性库存推售套数
,case when 顽固推售套数=0 then 0 else  round("顽固去化套数"/"顽固推售套数",4) end as SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,"顽固去化面积" as SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,"顽固推售面积" as SI_SALE_AREA---【43】顽固性库存推售面积
,case when 顽固推售面积=0 then 0 else  round("顽固去化面积"/"顽固推售面积",4) end  as SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,"顽固去化金额" as SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,"顽固推售金额" as SI_SALE_MONEY---【46】顽固性库存推售货值
,case when 顽固推售金额=0 then 0 else  round("顽固去化金额"/"顽固推售金额",4) end as SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,"顽固推售金额"-"顽固去化金额" SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,case when 顽固推售面积=0 then 0 else  round("顽固推售金额"/"顽固推售面积",4) end as SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,case when 顽固推售面积=0 then 0 else  round("顽固去化金额"/"顽固推售面积",4) end as SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
-------------------- 业态面积段特有 start
,project_id||PRODUCT_NAME  as PARENT_ID  
,AREA_LEVEL as DATA_GRANULARITY
,PRODUCT_NAME    
,sys_created as CREATED---【51】创建日期
,dwm_REMARK
-------------------- 业态面积段特有 end
from 
(select 
------首次开盘30天内的签约金额（首开去化货值）: 
---------->房间“合同成交总价”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约
sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "首开去化货值"
------首次开盘已取证货值（首开推售货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.SALE_STATE='签约' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "首开推售货值"
------首次开盘30天内的签约面积（首开去化面积）:
---------->房间“最新建筑面积”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "首开去化面积"
------首次开盘的已取证面积（首开推售面积）:
---------->房间“最新建筑面积”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "首开推售面积"
------首次开盘30天内的签约套数（首开去化套数）:
---------->房间“汇总”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "首开去化套数"
------首次开盘的已取证套数（首开推售套数）:
---------->房间“汇总”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "首开推售套数"

------全案------全案------全案------全案------全案------全案------全案 
------全案（已去化货值）: 
---------->房间“合同成交总价”
---------->房间“销售状态”=签约
,sum(case when room.SALE_STATE='签约' then room.TRADE_TOTAL else 0 end ) as "全案已去化货值"
------全案（已领证货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
,sum(case when room.SALE_STATE='签约'  then room.TRADE_TOTAL  
when room.SALE_STATE<>'签约' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "全案已领证货值"
------全案（已去化面积）:
---------->房间“最新建筑面积”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约'  then room.NEW_BLD_AREA else 0 end ) as "全案已去化面积"
------全案（已领证面积）:
---------->房间“最新建筑面积”
,sum(case when room.SALE_STATE='签约' or build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "全案已领证面积"
------全案（已去化套数):
---------->房间“汇总”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' then 1 else 0 end ) as "全案已去化套数"
------全案（已领证套数):
---------->房间“汇总”
,sum(case when room.SALE_STATE='签约' or build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "全案已领证套数"
------现房------现房------现房------现房------现房------现房------现房------现房------现房
----现房去化面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "现房去化面积" ,
----现房推售面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as 现房推售面积,
----现房去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  现房去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----现房推售金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> '签约'   then room.BZ_TOTAL  when room.SALE_STATE = '签约' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as 现房推售金额,
----现房去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  现房去化套数,
----现房推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or  (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as 现房推售套数
------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存
----顽固推售面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as 顽固去化面积,
----顽固去化面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then room.NEW_BLD_AREA else 0 end) as 顽固推售面积,
----顽固去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  顽固去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----顽固推售金额
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') then room.TRADE_TOTAL  --已经在今年签约的算签约金额
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> '签约' then room.BZ_TOTAL  else 0 end) as 顽固推售金额,  --未签约的算校准总价
----顽固去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  顽固去化套数,
----顽固推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then 1 else 0 end) as 顽固推售套数
,proj.project_id,
proj.project_name,
proj.org_id,
proj.org_name,
proj.first_open_date,
proj.obtain_date,
proj.COMPLETION_RECORD_DATE,
proj.take_land_date,
proj.plan_first_open_date,
proj.first_open_duration_by_tl,
proj.first_open_duration_by_plan,
proj.new_plan_first_open_date,
proj.exhibition_area_open_date,
proj.plan_approval_date,
proj.is_operate,
proj.is_construction_began
,t_room.AREA_LEVEL
,t_room.PRODUCT_NAME 
from tmp_proj_base proj
left join MDM_ROOM room  on proj.project_id=room.project_id  and  proj.id = PROJ_BASE_SPID
left join TMP_ROOM t_room on  room.id=t_room.room_id
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
-------------------- 业态面积段特有 start
    ,t_room.AREA_LEVEL
    ,t_room.PRODUCT_NAME
----------------------业态面积段特有 end
    ,proj.project_name,
    proj.org_id,
    proj.org_name,
    proj.first_open_date,
    proj.obtain_date,
    proj.COMPLETION_RECORD_DATE,
    proj.take_land_date,
    proj.plan_first_open_date,
    proj.first_open_duration_by_tl,
    proj.first_open_duration_by_plan,
    proj.new_plan_first_open_date,
    proj.exhibition_area_open_date,
    proj.plan_approval_date,
    proj.is_operate,
    proj.is_construction_began
    ) result 
-------------------- 业态面积段特有 start
   where  PRODUCT_NAME  is not null
----------------------业态面积段特有 end
;
   
OPEN spid_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid;  
------------------------------------------------------数据移入历史表;
INSERT INTO  dwm_sale_rate_gran_history (
    id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money,
    parent_id,
    data_granularity,
    created,
    remark,
    sort
)
SELECT
    id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money,
    parent_id,
    data_granularity,
    created,
    remark,
    sort
FROM
    dwm_sale_rate_by_granularity;
commit;
------------------------------------------------------删除已移入历史表树；
DELETE FROM DWM_SALE_RATE_BY_GRANULARITY ;--where REMARK=dwm_REMARK;
commit;
--------------------------------------------------------新增拍照数据;
INSERT INTO DWM_SALE_RATE_BY_GRANULARITY (
ID---【1】主键
,sort
,PROJECT_ID---【2】项目ID
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,PARENT_ID  
,DATA_GRANULARITY 
,CREATED---【51】创建日期
,REMARK---【52】备注信息
        )
   select  tree.GRANULARITY_ID--颗粒度id---【1】主键
   ,tree.sort
,tree.PROJECT_ID,---【2】项目ID
nvl(apdata.fo_sale_out_count,0),
nvl(apdata.fo_sale_count,0),
nvl(apdata.fo_sale_rate_by_count,0),
nvl(apdata.fo_sale_out_area,0),
nvl(apdata.fo_sale_area,0),
nvl(apdata.fo_sale_rate_by_area,0),
nvl(apdata.fo_sale_out_money,0),
nvl(apdata.fo_sale_money,0),
nvl(apdata.fo_sale_rate_by_money,0),
nvl(apdata.fo_surplus_sale_money,0),
nvl(apdata.fo_sale_average_money,0),
nvl(apdata.fo_sale_out_average_money,0),
nvl(apdata.po_sale_out_count,0),
nvl(apdata.po_sale_count,0),
nvl(apdata.po_sale_rate_by_count,0),
nvl(apdata.po_sale_out_area,0),
nvl(apdata.po_sale_area,0),
nvl(apdata.po_sale_rate_by_area,0),
nvl(apdata.po_sale_out_money,0),
nvl(apdata.po_sale_money,0),
nvl(apdata.po_sale_rate_by_money,0),
nvl(apdata.po_surplus_sale_money,0),
nvl(apdata.po_sale_average_money,0),
nvl(apdata.po_sale_out_average_money,0),
nvl(apdata.eh_sale_out_count,0),
nvl(apdata.eh_sale_count,0),
nvl(apdata.eh_sale_rate_by_count,0),
nvl(apdata.eh_sale_out_area,0),
nvl(apdata.eh_sale_area,0),
nvl(apdata.eh_sale_rate_by_area,0),
nvl(apdata.eh_sale_out_money,0),
nvl(apdata.eh_sale_money,0),
nvl(apdata.eh_sale_rate_by_money,0),
nvl(apdata.eh_surplus_sale_money,0),
nvl(apdata.eh_sale_average_money,0),
nvl(apdata.eh_sale_out_average_money,0),
nvl(apdata.si_sale_out_count,0),
nvl(apdata.si_sale_count,0),
nvl(apdata.si_sale_rate_by_count,0),
nvl(apdata.si_sale_out_area,0),
nvl(apdata.si_sale_area,0),
nvl(apdata.si_sale_rate_by_area,0),
nvl(apdata.si_sale_out_money,0),
nvl(apdata.si_sale_money,0),
nvl(apdata.si_sale_rate_by_money,0),
nvl(apdata.si_surplus_sale_money,0),
nvl(apdata.si_sale_average_money,0),
nvl(apdata.si_sale_out_average_money,0)
,tree.PARENT_ID---父级id
,tree.DATA_GRANULARITY--颗粒度名称
,sys_created
,dwm_REMARK
from 
( select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid_tree) tree
left join 
( 
    select  parent_id||data_granularity as id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money
 from  TMP_SALE_RATE_BY_GRANULARITY where id=spid
union all 
select  project_id||PRODUCT_NAME
,project_id,
sum(FO_SALE_OUT_COUNT),--【3】首开去化套数
sum(FO_SALE_COUNT),--【4】首开推售套数 
case when sum(FO_SALE_COUNT)=0 then 0 else  round(sum(FO_SALE_OUT_COUNT)/sum(FO_SALE_COUNT),4) end,--【5】首开去化率(按套数)（3/4）
sum(FO_SALE_OUT_AREA),--【6】首开去化面积
sum(FO_SALE_AREA),--【7】首开推售面积
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_AREA)/sum(FO_SALE_AREA),4) end,--【8】首开去化率(按面积)（6/7）
sum(FO_SALE_OUT_MONEY),--【9】首开去化货值
sum(FO_SALE_MONEY),--【10】首开推售货值
case when sum(FO_SALE_MONEY)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_MONEY),4) end,--【11】首开去化率(按货值)（9/10）
sum(FO_SURPLUS_SALE_MONEY),--【12】首开剩余货值(10-9)
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_MONEY)/sum(FO_SALE_AREA),4) end,--【13】首开标准均价(10/7)
case when sum(FO_SALE_OUT_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_OUT_AREA),4) end,--【14】首开签约均价(9/6)
sum(PO_SALE_OUT_COUNT),--【15】全案去化套数
sum(PO_SALE_COUNT),--【16】全案推售套数
case when sum(PO_SALE_COUNT)=0 then 0 else  round(sum(PO_SALE_OUT_COUNT)/sum(PO_SALE_COUNT),4) end,--【17】全案去化率(按套数)(15/16)
sum(PO_SALE_OUT_AREA),--【18】全案去化面积
sum(PO_SALE_AREA),--【19】全案推售面积
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_AREA)/sum(PO_SALE_AREA),4) end,--【20】全案去化率(按面积)(18/19)
sum(PO_SALE_OUT_MONEY),--【21】全案去化货值
sum(PO_SALE_MONEY),--【22】全案推售货值
case when sum(PO_SALE_MONEY)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_MONEY),4) end,--【23】全案去化率(按货值)(21/22)
sum(PO_SURPLUS_SALE_MONEY),--【24】全案剩余货值(22-21)
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_MONEY)/sum(PO_SALE_AREA),4) end,--【25】全案标准均价(22/19)
case when sum(PO_SALE_OUT_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_OUT_AREA),4) end,--【26】全案签约均价(21/18)
sum(EH_SALE_OUT_COUNT),--【27】现房去化套数
sum(EH_SALE_COUNT),--【28】现房推售套数
case when sum(EH_SALE_COUNT)=0 then 0 else  round(sum(EH_SALE_OUT_COUNT)/sum(EH_SALE_COUNT),4) end,--【29】现房去化率(按套数)(27/28)
sum(EH_SALE_OUT_AREA),--【30】现房去化面积
sum(EH_SALE_AREA),--【31】现房推售面积
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_AREA)/sum(EH_SALE_AREA),4) end,--【32】现房去化率(按面积)(30/31)
sum(EH_SALE_OUT_MONEY),--【33】现房去化货值
sum(EH_SALE_MONEY),--【34】现房推售货值
case when sum(EH_SALE_MONEY)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_MONEY),4) end,--【35】现房去化率(按货值)(33/34)
sum(EH_SURPLUS_SALE_MONEY),--【36】现房剩余货值(34-33)
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_MONEY)/sum(EH_SALE_AREA),4) end,--【37】现房标准均价(34/31)
case when sum(EH_SALE_OUT_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_OUT_AREA),4) end,--【38】现房签约均价(33/30)
sum(SI_SALE_OUT_COUNT),--【39】顽固性库存去化套数
sum(SI_SALE_COUNT),--【40】顽固性库存推售套数
case when sum(SI_SALE_COUNT)=0 then 0 else  round(sum(SI_SALE_OUT_COUNT)/sum(SI_SALE_COUNT),4) end,--【41】顽固性库存去化率(按套数)(39/40)
sum(SI_SALE_OUT_AREA),--【42】顽固性库存去化面积
sum(SI_SALE_AREA),--【43】顽固性库存推售面积
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_AREA)/sum(SI_SALE_AREA),4) end,--【44】顽固性库存去化率(按面积)(42/43)
sum(SI_SALE_OUT_MONEY),--【45】顽固性库存去化货值
sum(SI_SALE_MONEY),--【46】顽固性库存推售货值
case when sum(SI_SALE_MONEY)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_MONEY),4) end,--【47】顽固性库存去化率(按货值)(45/46)
sum(SI_SURPLUS_SALE_MONEY),--【48】顽固性库存剩余货值(46-45)
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_MONEY)/sum(SI_SALE_AREA),4) end,--【49】顽固性库存标准均价(46/43)
case when sum(SI_SALE_OUT_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_OUT_AREA),4) end--【50】顽固性库存签约均价(45/42)
 from  TMP_SALE_RATE_BY_GRANULARITY where id=spid group by project_id,
 parent_id,PRODUCT_NAME) apdata  
on tree.GRANULARITY_ID=apdata.id order by apdata.project_id;
commit;

END P_DWM_SALE_RATE_BY_GRANULARITY;
-----------------------------------------------------------存储过程 结束
----------------------------chenl去化率脚本20200509--结束-----------------------------------------------------------------------------

