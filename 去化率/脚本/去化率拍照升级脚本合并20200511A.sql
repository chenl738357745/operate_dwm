----------------------------chenlȥ���ʽű�20200509--��ʼ-----------------------------------------------------------------------------
----------------------------------------------------------��ʱ����
delete from SYS_AUTOJOB where id='bc3585fa-8e9c-46ea-a4ca-1aec6d4a6d61';
---��Ŀ������Ϣ��ʱ����
/
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e9c-46ea-a4ca-1aec6d4a6d61','��ȥ���ʡ�������Ŀ������Ϣ','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'DECLARE
  PROJ_BASE_SPID VARCHAR2(200);
BEGIN
  P_DWM_SALE_RATE_PROJ(1,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'���۾�','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e6c-46ea-a4ca-1aec6d4a6d61';
/
---��ʱ������Ŀ������ȥ����
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e6c-46ea-a4ca-1aec6d4a6d61','��ȥ���ʡ�������Ŀ������','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'
DECLARE
  PROJ_SPID NVARCHAR2(200);
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(
    1,
    PROJ_SPID => PROJ_SPID
  );
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'���۾�','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e7c-46ea-a4ca-1aec6d4a6d61';
/
---��ʱ���չ�˾������ȥ����
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e7c-46ea-a4ca-1aec6d4a6d61','��ȥ���ʡ����չ�˾������','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
,'
BEGIN
  P_DWM_SALE_RATE_BY_ORG();
--rollback; 
END;
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'���۾�','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
delete from SYS_AUTOJOB where id='bc3585fa-8e8c-46ea-a4ca-1aec6d4a6d61';
/
---��ʱ���չ�˾������ȥ����
Insert into SYS_AUTOJOB (ID,JOB_NAME,CREATED_BY,CREATED_ON,REMARK,EXECUTE_SQL_PROCESS,WEB_API_URL,HTTP_METHOD,JOB_DESCRIPTION,JOB_TYPE,START_TIME,END_TIME,NEXT_EXECUTE_TIME,CREATED,JOB_STATUS,CRON_EXPRESSION,JOB_GROUP,PARAM_DICT,METHOD_NAME,CLASS_NAME)
values ('bc3585fa-8e8c-46ea-a4ca-1aec6d4a6d61','��ȥ���ʡ�����ҵ̬����ο�����','832f8d02-8ad5-4ea6-8b79-35ccef64d2e0',to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),null
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
',null,null,null,1,to_date('2020-04-23 00:00:00','YYYY-MM-DD HH24:MI:SS'),to_date('2049-12-31 00:00:00','YYYY-MM-DD HH24:MI:SS'),null,'���۾�','OPEN','0 0 02 1/1 * ?','zhkf_group1587628066288',null,null,null);
/
-----------------------------------------------------------��ʱ�� ��ʼ
--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-12-2020   
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
"PLAN_END_DATE"           DATE,--�ƻ����ʱ��
"ACTUAL_END_DATE"         DATE,--ʵ�����ʱ��
"ESTIMATE_END_DATE"       DATE,--Ԥ�����ʱ��
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
-----------------------------------------------------------��ʱ�� ����

-----------------------------------------------------------�洢���� ��ʼ
CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_PROJ" (
    is_photograph    IN               NUMBER ,
    proj_base_spid   OUT              VARCHAR2
) AS
		--ȥ������Ŀ��������ˢ��;����=>ȥ�������ݶ�ʱ���¡�
        --���÷�Χ��P_DWM_SALE_RATE_BY_PROJ,P_DWM_SALE_RATE_BY_GRANULARITY,����proj_base_spidʹ��tmp_proj_base����
		--���ߣ�����
		--���ڣ�2020-04-10
    spid VARCHAR2(36); --ʹ����ʱ������κ�
    plan_stage VARCHAR2(360):= '1��,һ��,�޷���';
node_exhibit_open_type VARCHAR2(50):='node_exhibit_open';
node_plan_approval_type VARCHAR2(50):='node_plan_approval';
node_get_land_type VARCHAR2(50):='node_get_land';
node_start_work_type VARCHAR2(50):='node_start_work';
node_completed_permit_type VARCHAR2(50):='node_completed_permit';
node_project_open_type VARCHAR2(50):='node_project_open';

node_exhibit_open VARCHAR2(50):='988e38a7-77ef-77eb-e053-0100007f3dda';	--��ע--չʾ�����ţ�����¥��������䣩
node_plan_approval VARCHAR2(50):='988e38a7-77fa-77eb-e053-0100007f3dda';	--��ע--�滮��������
node_get_land VARCHAR2(50):='988e38a7-77c3-77eb-e053-0100007f3dda';	--��ע--���ػ�ȡ
node_start_work VARCHAR2(50):='988e38a7-7813-77eb-e053-0100007f3dda';	--��ע--�׿�¥����������
node_completed_permit VARCHAR2(50):='988e38a7-7878-77eb-e053-0100007f3dda';	--��ע--��������
node_project_open VARCHAR2(50):='988e38a7-7827-77eb-e053-0100007f3dda';	--��ע--��Ŀ����
dwm_REMARK VARCHAR2(200):='����-chenl';
sys_created date:=sysdate;
BEGIN
delete tmp_proj_related_date;
delete tmp_proj_base;
commit;
--------������ʱ�����κ�
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  

------------------------------------------------��ע------------------------------------------------��ע--չʾ�����ţ�����¥��������䣩
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_exhibit_open_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_exhibit_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע
------------------------------------------------��ע------------------------------------------------��ע--�滮��������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_plan_approval_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_plan_approval                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע
------------------------------------------------��ע------------------------------------------------��ע--���ػ�ȡ
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_get_land_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_get_land                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע
------------------------------------------------��ע------------------------------------------------��ע--�׿�¥����������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_start_work_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_start_work                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע
------------------------------------------------��ע------------------------------------------------��ע--��������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_completed_permit_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_completed_permit                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע
------------------------------------------------��ע------------------------------------------------��ע--��Ŀ����
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,node_project_open_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ------------------------------------------------��ע




    INSERT INTO tmp_proj_base (
        ID,--����
        PROJECT_ID,--��ĿID
        PROJECT_NAME,--��Ŀ����
        ORG_ID,--������ҵ��ID
        ORG_NAME,--������ҵ��
        FIRST_OPEN_DATE,--�׿�����
        OBTAIN_DATE,--��Ŀ�������
        COMPLETION_RECORD_DATE,--�״ο�������
        TAKE_LAND_DATE,--�õ�����
        PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        PLAN_APPROVAL_DATE,--������������
        PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        IS_OPERATE,--�Ƿ����
        IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���
        CREATED,--��������
        REMARK--��ע��Ϣ
    )
        SELECT
            spid                          AS id,
            project.project_original_id   AS project_id,--��ĿID
            project.project_name          AS project_name,--��Ŀ����
            project.company_id            AS org_id,--������ҵ��ID
            project.company_name          AS org_name,--������ҵ��
            node_project_open1.actual_end_date     AS first_open_date,--ʵ���׿�ʱ��----1
            node_get_land1.actual_end_date      AS obtain_date,--��Ŀ��ȡ����
            node_completed_permit1.actual_end_date     AS first_completion_record_date,--�״ο�������------2
            node_get_land1.actual_end_date     AS take_land_date,--�õ�����----3
            node_project_open1.plan_end_date     AS plan_first_open_date,--�ƻ��׿�����-----4
            node_project_open1.plan_end_date - node_get_land1.actual_end_date AS first_open_duration_by_plan,--ԭ�ƻ��׿�ʱ��
            node_project_open1.actual_end_date - node_get_land1.actual_end_date AS first_open_duration_by_tl,--�õ����׿�ʱ��
            node_project_open1.estimate_end_date      AS new_plan_first_open_date,--����Ԥ���׿�����----5
            node_exhibit_open1.actual_end_date     AS exhibition_area_open_date,--ʵ��չʾ������ʱ��---6
            node_exhibit_open1.plan_end_date ,--�ƻ�չʾ������ʱ��----7
            node_plan_approval1.actual_end_date     AS plan_approval_date,--��������ʱ��----7
            node_plan_approval1.plan_end_date  ,--�ƻ���������ʱ��----7 
            CASE
                WHEN project.proj_cooperate = '����' THEN
                    1
                ELSE
                    0
            END AS is_operate,--as project.PROJ_COOPERATE �Ƿ����
            CASE
                WHEN node_start_work1.actual_end_date is not null THEN
                    1
                ELSE
                    0
            END     AS is_construction_began,--�Ƿ񿪹�----7
            sys_created,
            '����' AS remark
        FROM
            mdm_project             project  
--��ע--չʾ�����ţ�����¥��������䣩	
LEFT JOIN tmp_proj_related_date   node_exhibit_open1 ON project.project_original_id = node_exhibit_open1.project_id AND node_exhibit_open1.project_date_type = node_exhibit_open_type
--��ע--�滮��������	
LEFT JOIN tmp_proj_related_date   node_plan_approval1 ON project.project_original_id = node_plan_approval1.project_id AND node_plan_approval1.project_date_type = node_plan_approval_type
--��ע--���ػ�ȡ	
LEFT JOIN tmp_proj_related_date   node_get_land1 ON project.project_original_id = node_get_land1.project_id AND node_get_land1.project_date_type = node_get_land_type
--��ע--�׿�¥����������	
LEFT JOIN tmp_proj_related_date   node_start_work1 ON project.project_original_id = node_start_work1.project_id AND node_start_work1.project_date_type = node_start_work_type
--��ע--��������	
LEFT JOIN tmp_proj_related_date   node_completed_permit1 ON project.project_original_id = node_completed_permit1.project_id AND node_completed_permit1.project_date_type = node_completed_permit_type
--��ע--��Ŀ����	
LEFT JOIN tmp_proj_related_date   node_project_open1 ON project.project_original_id = node_project_open1.project_id AND node_project_open1.project_date_type = node_project_open_type
WHERE project.approval_status = '�����';

    IF is_photograph <> 0 THEN
--��ɾ������ʷ����Ŀ���ݣ�������µ�����
        DELETE FROM dwm_sale_rate_project  where CREATED<sys_created;

        INSERT INTO dwm_sale_rate_project (
            ID,--����
        PROJECT_ID,--��ĿID
        PROJECT_NAME,--��Ŀ����
        ORG_ID,--������ҵ��ID
        ORG_NAME,--������ҵ��
        FIRST_OPEN_DATE,--�׿�����
        OBTAIN_DATE,--��Ŀ�������
        COMPLETION_RECORD_DATE,--�״ο�������
        TAKE_LAND_DATE,--�õ�����
        PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        PLAN_APPROVAL_DATE,--������������
        PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        IS_OPERATE,--�Ƿ����
        IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���
        CREATED,--��������
        REMARK--��ע��Ϣ
        )
            SELECT
        get_uuid,
        PROJECT_ID,--��ĿID
        PROJECT_NAME,--��Ŀ����
        ORG_ID,--������ҵ��ID
        ORG_NAME,--������ҵ��
        FIRST_OPEN_DATE,--�׿�����
        OBTAIN_DATE,--��Ŀ�������
        COMPLETION_RECORD_DATE,--�״ο�������
        TAKE_LAND_DATE,--�õ�����
        PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        PLAN_APPROVAL_DATE,--������������
        PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        IS_OPERATE,--�Ƿ����
        IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���
        CREATED,--��������
        dwm_REMARK--��ע��Ϣ
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
		--��Ŀ������ȥ�������գ�����=����ʱ����
        --���÷�Χ=��P_DWM_SALE_RATE_BY_ORG
		--���ߣ�����
		--���ڣ�2020-04-10
  PROJ_BASE_INFO SYS_REFCURSOR;
  PROJ_DATE_INFO SYS_REFCURSOR;
  PROJ_BASE_SPID VARCHAR2(2000);
  sys_created date:=sysdate;
  spid VARCHAR2(360); --ʹ����ʱ������κ�
  dwm_REMARK VARCHAR2(200):='����-chenl';
BEGIN
delete TMP_SALE_RATE_BY_PROJECT;
commit;
--------������ʱ�����κ�
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
proj_SPID:=spid;
------��Ŀ������Ϣ
BEGIN

  P_DWM_SALE_RATE_PROJ(0,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ----- 
 INSERT INTO TMP_SALE_RATE_BY_PROJECT (ID---��1������
,PROJECT_ID---��2����ĿID
,PROJECT_NAME
,ORG_ID
,ORG_NAME
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,CREATED---��51����������
)select 
spid as ID---��1������
,project_id as PROJECT_ID---��2����ĿID
,project_name
,ORG_ID
,ORG_NAME
-----------------------------------K1���׿�ȥ���ʿ�ʼ--------------------
,"�׿�ȥ������" as FO_SALE_OUT_COUNT---��3���׿�ȥ������
,"�׿���������" as FO_SALE_COUNT---��4���׿���������
,case when �׿���������=0 then 0 else round("�׿�ȥ������"/"�׿���������",4)  end as FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,"�׿�ȥ�����" as FO_SALE_OUT_AREA---��6���׿�ȥ�����
,"�׿��������" as FO_SALE_AREA---��7���׿��������
,case when �׿��������=0 then 0 else round("�׿�ȥ�����"/"�׿��������",4)  end as FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,"�׿�ȥ����ֵ" as FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,"�׿����ۻ�ֵ" as FO_SALE_MONEY---��10���׿����ۻ�ֵ
,case when �׿����ۻ�ֵ=0 then 0 else round("�׿�ȥ����ֵ"/"�׿����ۻ�ֵ",4)  end as FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,"�׿����ۻ�ֵ"-"�׿�ȥ����ֵ" as FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,case when �׿��������=0 then 0 else round("�׿����ۻ�ֵ"/"�׿��������",4)  end  as FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,case when �׿�ȥ�����=0 then 0 else round("�׿�ȥ����ֵ"/"�׿�ȥ�����",4)  end as FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
-----------------------------------K3��ȫ��ȥ���� ����λ��%��--------------------
,"ȫ����ȥ������" as PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,"ȫ������֤����" as PO_SALE_COUNT---��16��ȫ����������
,case when ȫ������֤����=0 then 0 else round("ȫ����ȥ������"/"ȫ������֤����",4)  end as PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,"ȫ����ȥ�����" as PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,"ȫ������֤���" as PO_SALE_AREA---��19��ȫ���������
,case when ȫ������֤���=0 then 0 else round("ȫ����ȥ�����"/"ȫ������֤���",4)  end as PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,"ȫ����ȥ����ֵ" as PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,"ȫ������֤��ֵ" as PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,case when ȫ������֤��ֵ=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ������֤��ֵ",4)  end  as PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,"ȫ������֤��ֵ"-"ȫ����ȥ����ֵ" as PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,case when ȫ������֤���=0 then 0 else round("ȫ������֤��ֵ"/"ȫ������֤���",4)  end  as PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,case when ȫ����ȥ�����=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ����ȥ�����",4)  end   PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
-----------------------------------K4���ַ�ȥ���� ����λ��%��--------------------
,"�ַ�ȥ������" as EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,"�ַ���������" as EH_SALE_COUNT---��28���ַ���������
,case when �ַ���������=0 then 0 else  round("�ַ�ȥ������"/"�ַ���������",4) end as EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,"�ַ�ȥ�����" as EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,"�ַ��������" as EH_SALE_AREA---��31���ַ��������
,case when �ַ��������=0 then 0 else  round("�ַ�ȥ�����"/"�ַ��������",4) end as EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,"�ַ�ȥ�����" as EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,"�ַ����۽��" as EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,case when �ַ����۽��=0 then 0 else  round("�ַ�ȥ�����"/"�ַ����۽��",4) end as EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,"�ַ����۽��"-"�ַ�ȥ�����" as EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,case when �ַ��������=0 then 0 else  round("�ַ����۽��"/"�ַ��������",4) end  as EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,case when �ַ�ȥ�����=0 then 0 else  round("�ַ�ȥ�����"/"�ַ�ȥ�����",4) end  as EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
-----------------------------------K5������Կ��ȥ���� ����λ��%��--------------------
,"���ȥ������" as SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,"�����������" as SI_SALE_COUNT---��40������Կ����������
,case when �����������=0 then 0 else  round("���ȥ������"/"�����������",4) end as SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,"���ȥ�����" as SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,"����������" as SI_SALE_AREA---��43������Կ���������
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end  as SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,"���ȥ�����" as SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,"������۽��" as SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,case when ������۽��=0 then 0 else  round("���ȥ�����"/"������۽��",4) end as SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,"������۽��"-"���ȥ�����" SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,case when ����������=0 then 0 else  round("������۽��"/"����������",4) end as SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end as SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,sys_created as CREATED---��51����������
from 
(select 
------�״ο���30���ڵ�ǩԼ���׿�ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ
sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "�׿�ȥ����ֵ"
------�״ο�����ȡ֤��ֵ���׿����ۻ�ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.SALE_STATE='ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "�׿����ۻ�ֵ"
------�״ο���30���ڵ�ǩԼ������׿�ȥ�������:
---------->���䡰���½��������
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "�׿�ȥ�����"
------�״ο��̵���ȡ֤������׿����������:
---------->���䡰���½��������
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "�׿��������"
------�״ο���30���ڵ�ǩԼ�������׿�ȥ��������:
---------->���䡰���ܡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "�׿�ȥ������"
------�״ο��̵���ȡ֤�������׿�����������:
---------->���䡰���ܡ�
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "�׿���������"

------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ�� 
------ȫ������ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->���䡰����״̬��=ǩԼ
,sum(case when room.SALE_STATE='ǩԼ' then room.TRADE_TOTAL else 0 end ) as "ȫ����ȥ����ֵ"
------ȫ��������֤��ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
,sum(case when room.SALE_STATE='ǩԼ'  then room.TRADE_TOTAL  
when room.SALE_STATE<>'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "ȫ������֤��ֵ"
------ȫ������ȥ�������:
---------->���䡰���½��������
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ'  then room.NEW_BLD_AREA else 0 end ) as "ȫ����ȥ�����"
------ȫ��������֤�����:
---------->���䡰���½��������
,sum(case when room.SALE_STATE='ǩԼ' or build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "ȫ������֤���"
------ȫ������ȥ������):
---------->���䡰���ܡ�
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' then 1 else 0 end ) as "ȫ����ȥ������"
------ȫ��������֤����):
---------->���䡰���ܡ�
,sum(case when room.SALE_STATE='ǩԼ' or build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "ȫ������֤����"
------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�
----�ַ�ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "�ַ�ȥ�����" ,
----�ַ��������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as �ַ��������,
----�ַ�ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  �ַ�ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----�ַ����۽��
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> 'ǩԼ'   then room.BZ_TOTAL  when room.SALE_STATE = 'ǩԼ' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as �ַ����۽��,
----�ַ�ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  �ַ�ȥ������,
----�ַ���������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or  (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as �ַ���������
------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��
----����������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as ���ȥ�����,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then room.NEW_BLD_AREA else 0 end) as ����������,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  ���ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----������۽��
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') then room.TRADE_TOTAL  --�Ѿ��ڽ���ǩԼ����ǩԼ���
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> 'ǩԼ' then room.BZ_TOTAL  else 0 end) as ������۽��,  --δǩԼ����У׼�ܼ�
----���ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  ���ȥ������,
----�����������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then 1 else 0 end) as �����������
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
    proj.is_construction_began) result  order by "ȫ����ȥ����ֵ" asc
;

-- 
IF is_photograph <> 0 THEN
----�Ƚ����������룬��ʷ����Ŀ���ݣ�������µ�����
------------------------------------------------------����������ʷ��;
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
------------------------------------------------------ɾ����������ʷ������
DELETE FROM DWM_SALE_RATE_BY_PROJECT ;
    --where REMARK=dwm_REMARK;
commit;
--------------------------------------------------------������������;
INSERT INTO DWM_SALE_RATE_BY_PROJECT (
ID---��1������
,PROJECT_ID---��2����ĿID
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,CREATED---��51����������
,REMARK---��52����ע��Ϣ
        )
            SELECT
PROJECT_ID      ID---��1������
,PROJECT_ID---��2����ĿID
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,CREATED---��51����������
,dwm_REMARK---��52����ע��Ϣ
            FROM
                TMP_SALE_RATE_BY_PROJECT where id=spid;
commit;
    END IF;
END P_DWM_SALE_RATE_BY_PROJ;
/
CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_BY_ORG"  AS
		--��˾������ȥ���ʣ�����=����ʱ��������
		--���ߣ�����
		--���ڣ�2020-04-10

    PROJ_SPID NVARCHAR2(200);
    sys_created       DATE := SYSDATE;
    spid_tree              VARCHAR2(360); --ʹ����ʱ������κ�
    spid_sum              VARCHAR2(360); --ʹ����ʱ������κ�
    spid_result              VARCHAR2(360); --ʹ����ʱ������κ�
    dwm_remark        VARCHAR2(200) := '����-chenl';
    p_X_AXIS_PERIOD  VARCHAR2(200):=to_char(sysdate, 'yyyy') ||'-'||to_char(sysdate, 'MM' );
BEGIN
delete tmp_sale_rate_by_org;
--------������ʱ�����κ�
    SELECT
        get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_sum,spid_result
    FROM
        dual;  

------��Ŀ������Ϣ
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(0,
    PROJ_SPID => PROJ_SPID
  );
END;

----��װ��
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--��  2����ĿID
        org_name,--��  3����Ŀ����
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--��  4���׿�ȥ������
        fo_sale_count,--��  5���׿���������
        fo_sale_out_area,--��  7���׿�ȥ�����
        fo_sale_area,--��  8���׿��������
        fo_sale_out_money,--�� 10���׿�ȥ����ֵ
        fo_sale_money,--�� 11���׿����ۻ�ֵ
        fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
        po_sale_out_count,--�� 14��ȫ��ȥ������
        po_sale_count,--�� 15��ȫ����������
        po_sale_out_area,--�� 17��ȫ��ȥ�����
        po_sale_area,--�� 18��ȫ���������
        po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
        po_sale_money,--�� 21��ȫ�����ۻ�ֵ
        po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
        eh_sale_out_count,--�� 24���ַ�ȥ������
        eh_sale_count,--�� 25���ַ���������
        eh_sale_out_area,--�� 27���ַ�ȥ�����
        eh_sale_area,--�� 28���ַ��������
        eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
        eh_sale_money,--�� 31���ַ����ۻ�ֵ
        eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
        si_sale_out_count,--�� 34������Կ��ȥ������
        si_sale_count,--�� 35������Կ����������
        si_sale_out_area,--�� 37������Կ��ȥ�����
        si_sale_area,--�� 38������Կ���������
        si_sale_out_money,--�� 40������Կ��ȥ����ֵ
        si_sale_money,--�� 41������Կ�����ۻ�ֵ
        si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
    )
        SELECT
            spid_tree,
            id AS org_id,
            org_name,
            parent_id,
            IS_COMPANY,
            LEVEL_RANK,
            0 AS fo_sale_out_count,--��  4���׿�ȥ������
            0 AS fo_sale_count,--��  5���׿���������
            0 AS fo_sale_out_area,--��  7���׿�ȥ�����
            0 AS fo_sale_area,--��  8���׿��������
            0 AS fo_sale_out_money,--�� 10���׿�ȥ����ֵ
            0 AS fo_sale_money,--�� 11���׿����ۻ�ֵ
            0 AS fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
            0 AS po_sale_out_count,--�� 14��ȫ��ȥ������
            0 AS po_sale_count,--�� 15��ȫ����������
            0 AS po_sale_out_area,--�� 17��ȫ��ȥ�����
            0 AS po_sale_area,--�� 18��ȫ���������
            0 AS po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
            0 AS po_sale_money,--�� 21��ȫ�����ۻ�ֵ
            0 AS po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
            0 AS eh_sale_out_count,--�� 24���ַ�ȥ������
            0 AS eh_sale_count,--�� 25���ַ���������
            0 AS eh_sale_out_area,--�� 27���ַ�ȥ�����
            0 AS eh_sale_area,--�� 28���ַ��������
            0 AS eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
            0 AS eh_sale_money,--�� 31���ַ����ۻ�ֵ
            0 AS eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
            0 AS si_sale_out_count,--�� 34������Կ��ȥ������
            0 AS si_sale_count,--�� 35������Կ����������
            0 AS si_sale_out_area,--�� 37������Կ��ȥ�����
            0 AS si_sale_area,--�� 38������Կ���������
            0 AS si_sale_out_money,--�� 40������Կ��ȥ����ֵ
            0 AS si_sale_money,--�� 41������Կ�����ۻ�ֵ
            0 AS si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
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
            fo_sale_out_count,--��  4���׿�ȥ������
            fo_sale_count,--��  5���׿���������
            fo_sale_out_area,--��  7���׿�ȥ�����
            fo_sale_area,--��  8���׿��������
            fo_sale_out_money,--�� 10���׿�ȥ����ֵ
            fo_sale_money,--�� 11���׿����ۻ�ֵ
            fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
            po_sale_out_count,--�� 14��ȫ��ȥ������
            po_sale_count,--�� 15��ȫ����������
            po_sale_out_area,--�� 17��ȫ��ȥ�����
            po_sale_area,--�� 18��ȫ���������
            po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
            po_sale_money,--�� 21��ȫ�����ۻ�ֵ
            po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
            eh_sale_out_count,--�� 24���ַ�ȥ������
            eh_sale_count,--�� 25���ַ���������
            eh_sale_out_area,--�� 27���ַ�ȥ�����
            eh_sale_area,--�� 28���ַ��������
            eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
            eh_sale_money,--�� 31���ַ����ۻ�ֵ
            eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
            si_sale_out_count,--�� 34������Կ��ȥ������
            si_sale_count,--�� 35������Կ����������
            si_sale_out_area,--�� 37������Կ��ȥ�����
            si_sale_area,--�� 38������Կ���������
            si_sale_out_money,--�� 40������Կ��ȥ����ֵ
            si_sale_money,--�� 41������Կ�����ۻ�ֵ
            si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
        FROM
            tmp_sale_rate_by_project where id=proj_spid;           
----����          
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--��  2����ĿID
        org_name,--��  3����Ŀ����
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--��  4���׿�ȥ������
        fo_sale_count,--��  5���׿���������
        fo_sale_out_area,--��  7���׿�ȥ�����
        fo_sale_area,--��  8���׿��������
        fo_sale_out_money,--�� 10���׿�ȥ����ֵ
        fo_sale_money,--�� 11���׿����ۻ�ֵ
        fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
        po_sale_out_count,--�� 14��ȫ��ȥ������
        po_sale_count,--�� 15��ȫ����������
        po_sale_out_area,--�� 17��ȫ��ȥ�����
        po_sale_area,--�� 18��ȫ���������
        po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
        po_sale_money,--�� 21��ȫ�����ۻ�ֵ
        po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
        eh_sale_out_count,--�� 24���ַ�ȥ������
        eh_sale_count,--�� 25���ַ���������
        eh_sale_out_area,--�� 27���ַ�ȥ�����
        eh_sale_area,--�� 28���ַ��������
        eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
        eh_sale_money,--�� 31���ַ����ۻ�ֵ
        eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
        si_sale_out_count,--�� 34������Կ��ȥ������
        si_sale_count,--�� 35������Կ����������
        si_sale_out_area,--�� 37������Կ��ȥ�����
        si_sale_area,--�� 38������Կ���������
        si_sale_out_money,--�� 40������Կ��ȥ����ֵ
        si_sale_money,--�� 41������Կ�����ۻ�ֵ
        si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
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
----������
INSERT INTO tmp_sale_rate_by_org (
ID,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
LEVEL_RANK,
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
"REMARK" )
select spid_result,ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
LEVEL_RANK,
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end as  FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end as  FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end as FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SALE_MONEY-FO_SALE_OUT_MONEY as FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
case when FO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end as PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end as PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end as PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SALE_MONEY-PO_SALE_OUT_MONEY as PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end as EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end  as EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end  as EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SALE_MONEY-EH_SALE_OUT_MONEY as EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end  as SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end  as SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end  as SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SALE_MONEY-SI_SALE_OUT_MONEY as SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
p_X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
sys_created,--��45������ʱ��
dwm_remark--��46����ע��Ϣ
from tmp_sale_rate_by_org where IS_COMPANY=1 and id=spid_sum and LEVEL_RANK<=2
;
----���뵽Ŀ���

   DELETE FROM dwm_sale_rate_by_org where  X_AXIS_PERIOD=p_X_AXIS_PERIOD;
   --and REMARK=dwm_REMARK;

   INSERT INTO dwm_sale_rate_by_org (
ID,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
"REMARK" )
select get_uuid,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
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
		--ҵ̬����ο�����ȥ���ʣ�����=����ʱ��������
		--���ߣ�����
		--���ڣ�2020-04-10
  PROJ_BASE_SPID VARCHAR2(2000);
  sys_created date:=sysdate;
  spid VARCHAR2(360); --ʹ����ʱ������κ�
  spid_tree VARCHAR2(360); --ʹ����ʱ������κ�
  dwm_REMARK VARCHAR2(200):='����-chenl';
  ----------------------
  v_sql clob;
  v_sql_start VARCHAR2(2000):= ' case ';
  v_sql_content clob:= '';
  v_sql_end VARCHAR2(2000):= '  else ''�������������'' end  ';
BEGIN
delete TMP_ROOM;
delete TMP_SALE_RATE_BY_GRANULARITY;
---------------------------
--------------------------------------------------------������ʱ�����κ�
    SELECT
        get_uuid(),get_uuid()
    INTO spid,spid_tree
    FROM
        dual;  
---------------------------------------------����ҵ̬�����1.ƴ�Ӳ�ѯ���
 FOR item IN (
   select 
    ' when '||l.lower_limit_value||l.lower_limit_type||'room.NEW_BLD_AREA and room.NEW_BLD_AREA '||l.upper_limit_type||l.upper_limit_value
    ||' and (case when room.PRODUCT_NAME<>''סլ'' then ''���̼�����'' else ''סլ'' end)='''||p.attribute_name||''' then ''' ||l.attribute_name||''' ' as aa,
    l.upper_limit_type,
    l.lower_limit_type,
    l.upper_limit_value,
    p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null
        ) LOOP 
    ---ƴ���ַ���
         v_sql_content := v_sql_content||item.aa;
        END LOOP;
    --�������ݴ���0��ƴ�������
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                     || v_sql_content
                     || v_sql_end;
        ELSE
            v_sql := '''''';
        END IF;
        
       v_sql:= 'INSERT INTO TMP_ROOM(id,room_ID,BLD_AREA,ROOM_NAME,PRODUCT_NAME,AREA_LEVEL) select '''||spid||''',id,NEW_BLD_AREA,room_name,case when room.product_name<>''סլ'' then ''���̼�����'' else ''סլ'' end,'
       ||v_sql|| ' as NODE_WARNING from mdm_room room';
         dbms_output.put_line(v_sql);
       execute immediate v_sql;
        
        OPEN t_room_info FOR select * from TMP_ROOM;  
-----------------------------------------------��Ŀ������Ϣ
BEGIN
  P_DWM_SALE_RATE_PROJ(0,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ------------------------------------------------------------ҵ̬�������ƴ�� spid_tree
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
,"SORT"
,GRANULARITY_ID--������id
,PROJECT_ID---��2����ĿID
,PROJECT_NAME--��Ŀ����
,PARENT_ID---����id
,DATA_GRANULARITY--����������
)
-----ҵ̬
select spid_tree
,b.order_code
,proj.PROJECT_ID||b."ҵ̬" as GRANULARITY_ID
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,null as parentId 
,b."ҵ̬" as text   
 from (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
(select 
   case when l.attribute_name<>'סլ' then '���̼�����' else 'סլ' end  as "ҵ̬",order_code  from mdm_attribute_area_level l where parent_id is null) b
   union all
-----�����
select spid_tree
,a.order_code
,proj.PROJECT_ID||ptype||a.areaStage as GRANULARITY_ID
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,proj.PROJECT_ID||ptype as parentId 
,a.areaStage as text
from  (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
( select 
    l.attribute_name as areaStage,l.order_code,case when p.attribute_name<>'סլ' then '���̼�����' else 'סլ' end  as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null) a;
    
OPEN spid_tree_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid_tree;  
------------------------------------------------------��������� spid

 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
,GRANULARITY_ID
,PROJECT_ID---��2����ĿID
,PROJECT_NAME
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,PARENT_ID  
,DATA_GRANULARITY
,PRODUCT_NAME
,CREATED---��51����������
,REMARK
)select 
spid as ID---��1������
,project_id||PRODUCT_NAME||AREA_LEVEL
,project_id as PROJECT_ID---��2����ĿID
,project_name
-----------------------------------K1���׿�ȥ���ʿ�ʼ--------------------
,"�׿�ȥ������" as FO_SALE_OUT_COUNT---��3���׿�ȥ������
,"�׿���������" as FO_SALE_COUNT---��4���׿���������
,case when �׿���������=0 then 0 else round("�׿�ȥ������"/"�׿���������",4)  end as FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,"�׿�ȥ�����" as FO_SALE_OUT_AREA---��6���׿�ȥ�����
,"�׿��������" as FO_SALE_AREA---��7���׿��������
,case when �׿��������=0 then 0 else round("�׿�ȥ�����"/"�׿��������",4)  end as FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,"�׿�ȥ����ֵ" as FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,"�׿����ۻ�ֵ" as FO_SALE_MONEY---��10���׿����ۻ�ֵ
,case when �׿����ۻ�ֵ=0 then 0 else round("�׿�ȥ����ֵ"/"�׿����ۻ�ֵ",4)  end as FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,"�׿����ۻ�ֵ"-"�׿�ȥ����ֵ" as FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,case when �׿��������=0 then 0 else round("�׿����ۻ�ֵ"/"�׿��������",4)  end  as FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,case when �׿�ȥ�����=0 then 0 else round("�׿�ȥ����ֵ"/"�׿�ȥ�����",4)  end as FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
-----------------------------------K3��ȫ��ȥ���� ����λ��%��--------------------
,"ȫ����ȥ������" as PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,"ȫ������֤����" as PO_SALE_COUNT---��16��ȫ����������
,case when ȫ������֤����=0 then 0 else round("ȫ����ȥ������"/"ȫ������֤����",4)  end as PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,"ȫ����ȥ�����" as PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,"ȫ������֤���" as PO_SALE_AREA---��19��ȫ���������
,case when ȫ������֤���=0 then 0 else round("ȫ����ȥ�����"/"ȫ������֤���",4)  end as PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,"ȫ����ȥ����ֵ" as PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,"ȫ������֤��ֵ" as PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,case when ȫ������֤��ֵ=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ������֤��ֵ",4)  end  as PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,"ȫ������֤��ֵ"-"ȫ����ȥ����ֵ" as PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,case when ȫ������֤���=0 then 0 else round("ȫ������֤��ֵ"/"ȫ������֤���",4)  end  as PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,case when ȫ����ȥ�����=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ����ȥ�����",4)  end   PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
-----------------------------------K4���ַ�ȥ���� ����λ��%��--------------------
,"�ַ�ȥ������" as EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,"�ַ���������" as EH_SALE_COUNT---��28���ַ���������
,case when �ַ���������=0 then 0 else  round("�ַ�ȥ������"/"�ַ���������",4) end as EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,"�ַ�ȥ�����" as EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,"�ַ��������" as EH_SALE_AREA---��31���ַ��������
,case when �ַ��������=0 then 0 else  round("�ַ�ȥ�����"/"�ַ��������",4) end as EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,"�ַ�ȥ�����" as EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,"�ַ����۽��" as EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,case when �ַ����۽��=0 then 0 else  round("�ַ�ȥ�����"/"�ַ����۽��",4) end as EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,"�ַ����۽��"-"�ַ�ȥ�����" as EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,case when �ַ��������=0 then 0 else  round("�ַ����۽��"/"�ַ��������",4) end  as EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,case when �ַ�ȥ�����=0 then 0 else  round("�ַ�ȥ�����"/"�ַ�ȥ�����",4) end  as EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
-----------------------------------K5������Կ��ȥ���� ����λ��%��--------------------
,"���ȥ������" as SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,"�����������" as SI_SALE_COUNT---��40������Կ����������
,case when �����������=0 then 0 else  round("���ȥ������"/"�����������",4) end as SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,"���ȥ�����" as SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,"����������" as SI_SALE_AREA---��43������Կ���������
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end  as SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,"���ȥ�����" as SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,"������۽��" as SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,case when ������۽��=0 then 0 else  round("���ȥ�����"/"������۽��",4) end as SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,"������۽��"-"���ȥ�����" SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,case when ����������=0 then 0 else  round("������۽��"/"����������",4) end as SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end as SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
-------------------- ҵ̬��������� start
,project_id||PRODUCT_NAME  as PARENT_ID  
,AREA_LEVEL as DATA_GRANULARITY
,PRODUCT_NAME    
,sys_created as CREATED---��51����������
,dwm_REMARK
-------------------- ҵ̬��������� end
from 
(select 
------�״ο���30���ڵ�ǩԼ���׿�ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ
sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "�׿�ȥ����ֵ"
------�״ο�����ȡ֤��ֵ���׿����ۻ�ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.SALE_STATE='ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "�׿����ۻ�ֵ"
------�״ο���30���ڵ�ǩԼ������׿�ȥ�������:
---------->���䡰���½��������
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "�׿�ȥ�����"
------�״ο��̵���ȡ֤������׿����������:
---------->���䡰���½��������
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "�׿��������"
------�״ο���30���ڵ�ǩԼ�������׿�ȥ��������:
---------->���䡰���ܡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "�׿�ȥ������"
------�״ο��̵���ȡ֤�������׿�����������:
---------->���䡰���ܡ�
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "�׿���������"

------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ�� 
------ȫ������ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->���䡰����״̬��=ǩԼ
,sum(case when room.SALE_STATE='ǩԼ' then room.TRADE_TOTAL else 0 end ) as "ȫ����ȥ����ֵ"
------ȫ��������֤��ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
,sum(case when room.SALE_STATE='ǩԼ'  then room.TRADE_TOTAL  
when room.SALE_STATE<>'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "ȫ������֤��ֵ"
------ȫ������ȥ�������:
---------->���䡰���½��������
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ'  then room.NEW_BLD_AREA else 0 end ) as "ȫ����ȥ�����"
------ȫ��������֤�����:
---------->���䡰���½��������
,sum(case when room.SALE_STATE='ǩԼ' or build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "ȫ������֤���"
------ȫ������ȥ������):
---------->���䡰���ܡ�
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' then 1 else 0 end ) as "ȫ����ȥ������"
------ȫ��������֤����):
---------->���䡰���ܡ�
,sum(case when room.SALE_STATE='ǩԼ' or build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "ȫ������֤����"
------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�
----�ַ�ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "�ַ�ȥ�����" ,
----�ַ��������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as �ַ��������,
----�ַ�ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  �ַ�ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----�ַ����۽��
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> 'ǩԼ'   then room.BZ_TOTAL  when room.SALE_STATE = 'ǩԼ' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as �ַ����۽��,
----�ַ�ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  �ַ�ȥ������,
----�ַ���������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or  (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as �ַ���������
------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��
----����������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as ���ȥ�����,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then room.NEW_BLD_AREA else 0 end) as ����������,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  ���ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----������۽��
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') then room.TRADE_TOTAL  --�Ѿ��ڽ���ǩԼ����ǩԼ���
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> 'ǩԼ' then room.BZ_TOTAL  else 0 end) as ������۽��,  --δǩԼ����У׼�ܼ�
----���ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  ���ȥ������,
----�����������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then 1 else 0 end) as �����������
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
-------------------- ҵ̬��������� start
    ,t_room.AREA_LEVEL
    ,t_room.PRODUCT_NAME
----------------------ҵ̬��������� end
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
-------------------- ҵ̬��������� start
   where  PRODUCT_NAME  is not null
----------------------ҵ̬��������� end
;
   
OPEN spid_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid;  
------------------------------------------------------����������ʷ��;
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
------------------------------------------------------ɾ����������ʷ������
DELETE FROM DWM_SALE_RATE_BY_GRANULARITY ;--where REMARK=dwm_REMARK;
commit;
--------------------------------------------------------������������;
INSERT INTO DWM_SALE_RATE_BY_GRANULARITY (
ID---��1������
,sort
,PROJECT_ID---��2����ĿID
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,PARENT_ID  
,DATA_GRANULARITY 
,CREATED---��51����������
,REMARK---��52����ע��Ϣ
        )
   select  tree.GRANULARITY_ID--������id---��1������
   ,tree.sort
,tree.PROJECT_ID,---��2����ĿID
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
,tree.PARENT_ID---����id
,tree.DATA_GRANULARITY--����������
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
sum(FO_SALE_OUT_COUNT),--��3���׿�ȥ������
sum(FO_SALE_COUNT),--��4���׿��������� 
case when sum(FO_SALE_COUNT)=0 then 0 else  round(sum(FO_SALE_OUT_COUNT)/sum(FO_SALE_COUNT),4) end,--��5���׿�ȥ����(������)��3/4��
sum(FO_SALE_OUT_AREA),--��6���׿�ȥ�����
sum(FO_SALE_AREA),--��7���׿��������
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_AREA)/sum(FO_SALE_AREA),4) end,--��8���׿�ȥ����(�����)��6/7��
sum(FO_SALE_OUT_MONEY),--��9���׿�ȥ����ֵ
sum(FO_SALE_MONEY),--��10���׿����ۻ�ֵ
case when sum(FO_SALE_MONEY)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_MONEY),4) end,--��11���׿�ȥ����(����ֵ)��9/10��
sum(FO_SURPLUS_SALE_MONEY),--��12���׿�ʣ���ֵ(10-9)
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_MONEY)/sum(FO_SALE_AREA),4) end,--��13���׿���׼����(10/7)
case when sum(FO_SALE_OUT_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_OUT_AREA),4) end,--��14���׿�ǩԼ����(9/6)
sum(PO_SALE_OUT_COUNT),--��15��ȫ��ȥ������
sum(PO_SALE_COUNT),--��16��ȫ����������
case when sum(PO_SALE_COUNT)=0 then 0 else  round(sum(PO_SALE_OUT_COUNT)/sum(PO_SALE_COUNT),4) end,--��17��ȫ��ȥ����(������)(15/16)
sum(PO_SALE_OUT_AREA),--��18��ȫ��ȥ�����
sum(PO_SALE_AREA),--��19��ȫ���������
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_AREA)/sum(PO_SALE_AREA),4) end,--��20��ȫ��ȥ����(�����)(18/19)
sum(PO_SALE_OUT_MONEY),--��21��ȫ��ȥ����ֵ
sum(PO_SALE_MONEY),--��22��ȫ�����ۻ�ֵ
case when sum(PO_SALE_MONEY)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_MONEY),4) end,--��23��ȫ��ȥ����(����ֵ)(21/22)
sum(PO_SURPLUS_SALE_MONEY),--��24��ȫ��ʣ���ֵ(22-21)
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_MONEY)/sum(PO_SALE_AREA),4) end,--��25��ȫ����׼����(22/19)
case when sum(PO_SALE_OUT_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_OUT_AREA),4) end,--��26��ȫ��ǩԼ����(21/18)
sum(EH_SALE_OUT_COUNT),--��27���ַ�ȥ������
sum(EH_SALE_COUNT),--��28���ַ���������
case when sum(EH_SALE_COUNT)=0 then 0 else  round(sum(EH_SALE_OUT_COUNT)/sum(EH_SALE_COUNT),4) end,--��29���ַ�ȥ����(������)(27/28)
sum(EH_SALE_OUT_AREA),--��30���ַ�ȥ�����
sum(EH_SALE_AREA),--��31���ַ��������
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_AREA)/sum(EH_SALE_AREA),4) end,--��32���ַ�ȥ����(�����)(30/31)
sum(EH_SALE_OUT_MONEY),--��33���ַ�ȥ����ֵ
sum(EH_SALE_MONEY),--��34���ַ����ۻ�ֵ
case when sum(EH_SALE_MONEY)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_MONEY),4) end,--��35���ַ�ȥ����(����ֵ)(33/34)
sum(EH_SURPLUS_SALE_MONEY),--��36���ַ�ʣ���ֵ(34-33)
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_MONEY)/sum(EH_SALE_AREA),4) end,--��37���ַ���׼����(34/31)
case when sum(EH_SALE_OUT_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_OUT_AREA),4) end,--��38���ַ�ǩԼ����(33/30)
sum(SI_SALE_OUT_COUNT),--��39������Կ��ȥ������
sum(SI_SALE_COUNT),--��40������Կ����������
case when sum(SI_SALE_COUNT)=0 then 0 else  round(sum(SI_SALE_OUT_COUNT)/sum(SI_SALE_COUNT),4) end,--��41������Կ��ȥ����(������)(39/40)
sum(SI_SALE_OUT_AREA),--��42������Կ��ȥ�����
sum(SI_SALE_AREA),--��43������Կ���������
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_AREA)/sum(SI_SALE_AREA),4) end,--��44������Կ��ȥ����(�����)(42/43)
sum(SI_SALE_OUT_MONEY),--��45������Կ��ȥ����ֵ
sum(SI_SALE_MONEY),--��46������Կ�����ۻ�ֵ
case when sum(SI_SALE_MONEY)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_MONEY),4) end,--��47������Կ��ȥ����(����ֵ)(45/46)
sum(SI_SURPLUS_SALE_MONEY),--��48������Կ��ʣ���ֵ(46-45)
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_MONEY)/sum(SI_SALE_AREA),4) end,--��49������Կ���׼����(46/43)
case when sum(SI_SALE_OUT_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_OUT_AREA),4) end--��50������Կ��ǩԼ����(45/42)
 from  TMP_SALE_RATE_BY_GRANULARITY where id=spid group by project_id,
 parent_id,PRODUCT_NAME) apdata  
on tree.GRANULARITY_ID=apdata.id order by apdata.project_id;
commit;

END P_DWM_SALE_RATE_BY_GRANULARITY;
-----------------------------------------------------------�洢���� ����
----------------------------chenlȥ���ʽű�20200509--����-----------------------------------------------------------------------------

