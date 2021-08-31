--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-18-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_POM_DELAY_NODE_CURRENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_DELAY_NODE_CURRENT" 
(
		PLANTYPE     IN VARCHAR2
	 ,DATASCOPE    IN VARCHAR2
	 ,SEARCHKEY    IN VARCHAR2
	 ,ORGID        IN VARCHAR2
	 ,CURRENTDELAY OUT SYS_REFCURSOR
) AS --�ؼ��ڵ�ƻ����-��ǰ����ڵ�
		--���ߣ�����
		--���ڣ�2019/11/13
BEGIN

		IF DATASCOPE = 'thisMonth' THEN
				OPEN CURRENTDELAY FOR
						SELECT DISTINCT A.ORG_NAME AS "orgName",
														B2.PROJECTSTAGE_NAME AS "projName",
														B2.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(B2.COMPANY_ID, '003200000000000000000000000000') ||
														 '&ppid=' || B2.PPID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' ||
														 B2.PLANID || '&feedbackNodeId=' || NODE_ID ||
														 '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID ||
														 '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   SYS_BUSINESS_UNIT A
						LEFT   JOIN (SELECT LEVEL, ORG_NAME, CONNECT_BY_ROOT ID AS ID,
																CONNECT_BY_ROOT PARENT_ID AS PARENT_ID,
																B.UNIT_ID, B.NODE_NAME, B.NODE_ID,
																B.ACTUAL_END_DATE, B.PLAN_END_DATE,
																B.PROJECTSTAGE_NAME, B.PPID, B.PID,
																'TYPE_ORG' AS CTYPE, B.ESTIMATE_END_DATE,
																B.PLANID, ORIGINAL_NODE_ID,B.COMPANY_ID
												 FROM   SYS_BUSINESS_UNIT A
												 LEFT   JOIN (SELECT B1.UNIT_ID, A.ID AS PLANID,A.COMPANY_ID,
																						A.PROJ_ID AS PPID, B1.ID AS PID,
																						A1.ORIGINAL_NODE_ID,
																				
																						 A.PROJ_NAME AS PROJECTSTAGE_NAME,
																						A1.NODE_NAME, A1.ID AS NODE_ID,
																						A1.ACTUAL_END_DATE,
																						A1.PLAN_END_DATE,
																						A1.ESTIMATE_END_DATE
																		 FROM   POM_PROJ_PLAN A
																		 INNER  JOIN POM_PROJ_PLAN_NODE A1
																		 ON     A.ID = A1.PROJ_PLAN_ID
																		 INNER  JOIN SYS_PROJECT_STAGE C1
																		 ON     A.PROJ_ID = C1.ID
																		 INNER  JOIN SYS_PROJECT B1
																		 ON     C1.PROJECT_ID = B1.ID
																		 WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
																						A.APPROVAL_STATUS = '�����' 	AND
																						A1.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when  TO_NUMBER(����_����) >1 then     TO_CHAR( A.����_����)  else   TO_CHAR( A.����_����-1) end   ||'-'||case when  TO_NUMBER(����_����) >1 then  TO_CHAR( TO_NUMBER(����_����)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.����_����||'-'||����_����||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND   
																						TRUNC(SYSDATE, 'dd') -TRUNC(PLAN_END_DATE, 'dd') > 0 AND
																						ACTUAL_END_DATE IS NULL) B
												 ON     A.ID = B.UNIT_ID
												 WHERE  ORG_TYPE = 0
												 START  WITH ID = '' || ORGID || ''
												 CONNECT BY PRIOR A.ID = A.PARENT_ID) B2
						ON     A.ID = B2.ID
						WHERE  NODE_NAME IS NOT NULL AND
									 ACTUAL_END_DATE IS NULL AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --����
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
													 A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000001') ||
														 '&ppid=' || a.PROJ_ID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || A.ID ||
														 '&feedbackNodeId=' || A1.ID ||
														 '&feedbackNodeOriginalId=' ||
														 A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   POM_PROJ_PLAN A
						INNER  JOIN POM_PROJ_PLAN_NODE A1
						ON     A.ID = A1.PROJ_PLAN_ID
						INNER  JOIN SYS_PROJECT_STAGE C1
						ON     A.PROJ_ID = C1.ID
						INNER  JOIN SYS_PROJECT B1
						ON     C1.PROJECT_ID = B1.ID
						WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
									 A.APPROVAL_STATUS = '�����'   AND
							A1.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when  TO_NUMBER(����_����) >1 then     TO_CHAR( A.����_����)  else   TO_CHAR( A.����_����-1) end   ||'-'||case when  TO_NUMBER(����_����) >1 then  TO_CHAR( TO_NUMBER(����_����)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.����_����||'-'||����_����||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')   AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 AND
									 ACTUAL_END_DATE IS NULL AND
									 C1.PROJECT_ID = '' || ORGID || ''
						ORDER  BY 6 DESC;
		
		ELSIF DATASCOPE = 'thisQuarter' THEN
				OPEN CURRENTDELAY FOR
						SELECT DISTINCT A.ORG_NAME AS "orgName",
														B2.PROJECTSTAGE_NAME AS "projName",
														B2.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(B2.COMPANY_ID,
																 '003200000000000000000000000002') ||
														 '&ppid=' || B2.PPID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' ||
														 B2.PLANID || '&feedbackNodeId=' || NODE_ID ||
														 '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID ||
														 '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   SYS_BUSINESS_UNIT A
						LEFT   JOIN (SELECT LEVEL, ORG_NAME, CONNECT_BY_ROOT ID AS ID,
																CONNECT_BY_ROOT PARENT_ID AS PARENT_ID,
																B.UNIT_ID, B.NODE_NAME, B.NODE_ID,
																B.ACTUAL_END_DATE, B.PLAN_END_DATE,
																B.PROJECTSTAGE_NAME, B.PPID, B.PID,
																'TYPE_ORG' AS CTYPE, B.ESTIMATE_END_DATE,
																B.PLANID, ORIGINAL_NODE_ID,B.COMPANY_ID
												 FROM   SYS_BUSINESS_UNIT A
												 LEFT   JOIN (SELECT B1.UNIT_ID, A.ID AS PLANID,A.COMPANY_ID,
																						A.PROJ_ID AS PPID, B1.ID AS PID,
																						A1.ORIGINAL_NODE_ID,
																						
																						 A.PROJ_NAME AS PROJECTSTAGE_NAME,
																						A1.NODE_NAME, A1.ID AS NODE_ID,
																						A1.ACTUAL_END_DATE,
																						A1.PLAN_END_DATE,
																						A1.ESTIMATE_END_DATE
																		 FROM   POM_PROJ_PLAN A
																		 INNER  JOIN POM_PROJ_PLAN_NODE A1
																		 ON     A.ID = A1.PROJ_PLAN_ID
																		 INNER  JOIN SYS_PROJECT_STAGE C1
																		 ON     A.PROJ_ID = C1.ID
																		 INNER  JOIN SYS_PROJECT B1
																		 ON     C1.PROJECT_ID = B1.ID
																		 WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
																						A.APPROVAL_STATUS = '�����' --�жϼ���
																					 --�жϼ���
																					 
																						AND
																					A1.PLAN_END_DATE BETWEEN
																		 TO_DATE( 			(	SELECT A.��ʼ���||'-'||A.��ʼ�·�||'-26'   FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')  AND
 TO_DATE((	SELECT A.�������||'-'||A.�����·�||'-25' FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')
							AND
																						TRUNC(SYSDATE, 'dd') -
																						TRUNC(PLAN_END_DATE, 'dd') > 0 AND
																						ACTUAL_END_DATE IS NULL) B
												 ON     A.ID = B.UNIT_ID
												 WHERE  ORG_TYPE = 0
												 START  WITH ID = '' || ORGID || ''
												 CONNECT BY PRIOR A.ID = A.PARENT_ID) B2
						ON     A.ID = B2.ID
						WHERE  NODE_NAME IS NOT NULL AND
									 ACTUAL_END_DATE IS NULL AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --����
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
														 A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000000') ||
														 '&ppid=' || C1.ID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || A.ID ||
														 '&feedbackNodeId=' || A1.ID ||
														 '&feedbackNodeOriginalId=' ||
														 A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   POM_PROJ_PLAN A
						INNER  JOIN POM_PROJ_PLAN_NODE A1
						ON     A.ID = A1.PROJ_PLAN_ID
						INNER  JOIN SYS_PROJECT_STAGE C1
						ON     A.PROJ_ID = C1.ID
						INNER  JOIN SYS_PROJECT B1
						ON     C1.PROJECT_ID = B1.ID
						WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
									 A.APPROVAL_STATUS = '�����' --�жϼ���
									
									 AND
									 A1.PLAN_END_DATE  BETWEEN
																										 TO_DATE( 			(	SELECT A.��ʼ���||'-'||A.��ʼ�·�||'-26'   FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')  AND
 TO_DATE((	SELECT A.�������||'-'||A.�����·�||'-25' FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD') AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 AND
									 ACTUAL_END_DATE IS NULL AND
									 C1.PROJECT_ID = '' || ORGID || ''
						ORDER  BY 6 DESC;
		ELSIF DATASCOPE = 'thisYear' THEN
				OPEN CURRENTDELAY FOR
						SELECT DISTINCT A.ORG_NAME AS "orgName",
														B2.PROJECTSTAGE_NAME AS "projName",
														B2.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(B2.COMPANY_ID,
																 '003200000000000000000000000000') ||
														 '&ppid=' || B2.PPID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' ||
														 B2.PLANID || '&feedbackNodeId=' || NODE_ID ||
														 '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID ||
														 '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   SYS_BUSINESS_UNIT A
						LEFT   JOIN (SELECT LEVEL, ORG_NAME, CONNECT_BY_ROOT ID AS ID,
																CONNECT_BY_ROOT PARENT_ID AS PARENT_ID,
																B.UNIT_ID, B.NODE_NAME, B.NODE_ID,
																B.ACTUAL_END_DATE, B.PLAN_END_DATE,
																B.PROJECTSTAGE_NAME, B.PPID, B.PID,
																'TYPE_ORG' AS CTYPE, B.ESTIMATE_END_DATE,
																B.PLANID, ORIGINAL_NODE_ID,B.COMPANY_ID
												 FROM   SYS_BUSINESS_UNIT A
												 LEFT   JOIN (SELECT B1.UNIT_ID, A.ID AS PLANID,A.COMPANY_ID,
																						A.PROJ_ID AS PPID, B1.ID AS PID,
																						A1.ORIGINAL_NODE_ID,
																						
																						 A.PROJ_NAME AS PROJECTSTAGE_NAME,
																						A1.NODE_NAME, A1.ID AS NODE_ID,
																						A1.ACTUAL_END_DATE,
																						A1.PLAN_END_DATE,
																						A1.ESTIMATE_END_DATE
																		 FROM   POM_PROJ_PLAN A
																		 INNER  JOIN POM_PROJ_PLAN_NODE A1
																		 ON     A.ID = A1.PROJ_PLAN_ID
																		 INNER  JOIN SYS_PROJECT_STAGE C1
																		 ON     A.PROJ_ID = C1.ID
																		 INNER  JOIN SYS_PROJECT B1
																		 ON     C1.PROJECT_ID = B1.ID
																		 WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
																						A.APPROVAL_STATUS = '�����' AND
																						PLAN_END_DATE BETWEEN (SELECT TO_DATE( "����_����"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "����_����"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)  AND
																						TRUNC(SYSDATE, 'dd') -
																						TRUNC(PLAN_END_DATE, 'dd') > 0 AND
																						ACTUAL_END_DATE IS NULL) B
												 ON     A.ID = B.UNIT_ID
												 WHERE  ORG_TYPE = 0
												 START  WITH ID = '' || ORGID || ''
												 CONNECT BY PRIOR A.ID = A.PARENT_ID) B2
						ON     A.ID = B2.ID
						WHERE  NODE_NAME IS NOT NULL AND
									 ACTUAL_END_DATE IS NULL AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --����
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
														A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000000') ||
														 '&ppid=' || C1.ID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
														'/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || A.ID ||
														 '&feedbackNodeId=' || A1.ID ||
														 '&feedbackNodeOriginalId=' ||
														 A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
														TRUNC(SYSDATE, 'dd') -
														 TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
						FROM   POM_PROJ_PLAN A
						INNER  JOIN POM_PROJ_PLAN_NODE A1
						ON     A.ID = A1.PROJ_PLAN_ID
						INNER  JOIN SYS_PROJECT_STAGE C1
						ON     A.PROJ_ID = C1.ID
						INNER  JOIN SYS_PROJECT B1
						ON     C1.PROJECT_ID = B1.ID
						WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
									 A.APPROVAL_STATUS = '�����' AND
									PLAN_END_DATE  BETWEEN (SELECT TO_DATE( "����_����"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "����_����"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
										AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 AND
									 ACTUAL_END_DATE IS NULL AND
									 C1.PROJECT_ID = '' || ORGID || ''
						ORDER  BY 6 DESC;
		END IF;

END P_POM_DELAY_NODE_CURRENT;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_COMPANY" (
    ---��������
    companyid IN VARCHAR2,--��������˾Ϊ����˾id
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----������֯�����в���
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on ������id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on �����Ŷ�Ӧ��˾id=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_COMPANY;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_DEPT" (
    ---��������
    deptid IN VARCHAR2,--���������ţ�����id
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----������֯�����в���
where_auth_sql:=case when deptid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||deptid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on ������id=wh.orgid' else '' end;

where_auth_c_sql:=case when deptid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on ������id=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_DEPT;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PROJ" (
    ---��������
    companyid IN VARCHAR2,--���������ţ�����id
    orgid IN VARCHAR2,--��������˾������id
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----������֯�����в���
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on ������id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on ������id=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
    --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
    condition IN VARCHAR2, --�����������˾id
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR
) IS
--����˾��������-tabs
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417
         
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => condition,
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;

END P_POM_SMART_CURRENTCOMPANY_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --�������������id
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR) IS --��������tabs��������ͳ������Դ
--���ߣ�������tabͳ��
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417
         
P_POM_SMART_CURRENT_DEPT(
     DEPTID => condition,
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
    --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
    condition IN VARCHAR2, --�����������Ŀid
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR
) IS
    --��������tabs��������ͳ������Դ
--���ߣ�yedr
--���ڣ�2020/04/07
    v_spid              VARCHAR2(200);
BEGIN
    --��������Ȩ����֤�洢����
    P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    OPEN item FOR
        SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
        FROM(
							SELECT
								NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
																 ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
																THEN  1 ELSE 0 END), 0)AS ACOUNT,
								NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
								NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
								NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
								COUNT(node.id) AS ECOUNT,
								NVL(SUM(CASE WHEN (
													 node.PLAN_END_DATE >= last_day( trunc( SYSDATE ) ) + 1
											 AND node.PLAN_END_DATE <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
									 ) THEN 1 ELSE 0 END),0) AS FCOUNT,
								NVL(SUM(CASE WHEN  (
													 node.PLAN_END_DATE >= trunc( SYSDATE, 'Q' )
											 AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
									 ) THEN 1 ELSE 0 END),0) AS GCOUNT,
								NVL(SUM(CASE WHEN (
													 node.PLAN_END_DATE >= trunc( SYSDATE, 'yyyy' )
											 AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
									 ) THEN 1 ELSE 0 END),0) AS HCOUNT
							 FROM
								(
									SELECT
										node.ACTUAL_END_DATE,
										node.PLAN_END_DATE,
										node.ID,
										node.ORIGINAL_NODE_ID,
										node.DUTY_DEPARTMENT,
										plan.PROJ_NAME,
										plan.PLAN_NAME,
										CASE
											WHEN f.id IS NULL THEN
											node.NODE_NAME
											WHEN f.id IS NOT NULL
											AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
												node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
												WHEN f.id IS NOT NULL
												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
												AND f.APPROVAL_STATUS = 'δ���' THEN
													node.NODE_NAME || '����ɷ���δ����'
													WHEN f.id IS NOT NULL
													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
													AND f.APPROVAL_STATUS = '�����' THEN
														node.NODE_NAME || '����ɷ�������С�'
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE = 'CARRY_OUT'
														AND f.APPROVAL_STATUS = '�����' THEN
															node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
														END AS NODE_NAME
									FROM
											POM_PROJ_PLAN_NODE node
											LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
											LEFT JOIN (
													SELECT  listagg(CHARGE_PERSON,',') within GROUP(order by CHARGE_PERSON ) CHARGE_PERSON,NODE_ID
													FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID
											)  person ON node.ID=person.NODE_ID
											LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
											LEFT JOIN (
												SELECT
													B.*
												FROM
													(
													SELECT
														A.*,
														ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
													FROM
														POM_NODE_FEEDBACK A
													) B
												WHERE
													RN = 1
												) f ON f.feedback_node_id = node.id
											LEFT JOIN (
													select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||''
											) tal ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
									WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' OR plan.PLAN_TYPE = 'ר��ƻ�')
										AND plan.APPROVAL_STATUS = '�����'
										AND node.IS_DISABLE=0

										AND (condition is null or (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN(
											SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||'')))
									) node
										LEFT JOIN ( SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID = '832f8d02-8ad5-4ea6-8b79-35ccef64d2e0' ) w ON node.ORIGINAL_NODE_ID = w.BIZ_ID
										LEFT JOIN (
										SELECT
											node_id,
											LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
										FROM
											POM_NODE_CHARGE_PERSON
										GROUP BY
											node_id
										) cp ON node.id = cp.NODE_ID
									 WHERE
											(node.node_name like '%'||searchcondition||'%'
											OR node.plan_name like '%'||searchcondition||'%'
											OR node.PROJ_NAME like '%'||searchcondition||'%'
											OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
											OR cp.CHARGE_PERSON like '%'||searchcondition||'%')
											-- ��������
											UNION ALL
											SELECT
												 NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
																					 ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
																					THEN  1 ELSE 0 END), 0)AS ACOUNT,
												 0 AS BCOUNT,
												 0 AS CCOUNT,
												 0 AS DCOUNT,
												 0 AS ECOUNT,
												 0 AS FCOUNT,
												 0 AS GCOUNT,
												 0 AS HCOUNT
											FROM (
												SELECT
													node.ACTUAL_END_DATE,
													node.PLAN_END_DATE,
													node.ID,
													node.ORIGINAL_NODE_ID,
													node.DUTY_DEPARTMENT,
													null PROJ_NAME,
													p.PLAN_NAME,
													CASE
														WHEN f.id IS NULL THEN
														node.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																node.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	node.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME
													FROM
														POM_SPECIAL_PLAN_NODE node
														LEFT JOIN POM_SPECIAL_PLAN p ON node.PLAN_ID = p.ID
														LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.NODE_ID
														LEFT JOIN (
															SELECT
																B.*
															FROM
																(
																SELECT
																	A.*,
																	ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																FROM
																	POM_NODE_FEEDBACK A
																) B
															WHERE
																RN = 1
															) f ON f.feedback_node_id = node.id
													WHERE
													node.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = ''||currentuserid||''
													and node.ACTUAL_END_DATE is null and (node.PLAN_END_DATE>=trunc(sysdate, 'month') and node.PLAN_END_DATE<=trunc(last_day(sysdate)))
												) node
												LEFT JOIN (
													SELECT
														node_id,
														LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
													FROM
														POM_NODE_CHARGE_PERSON
													GROUP BY
														node_id
													) cp ON node.id = cp.NODE_ID
											WHERE
												(node.node_name like '%'||searchcondition||'%'
												OR node.plan_name like '%'||searchcondition||'%'
												OR node.PROJ_NAME like '%'||searchcondition||'%'
												OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
												OR cp.CHARGE_PERSON like '%'||searchcondition||'%')
											-- ����δ�������
											UNION ALL
											SELECT
												 0 AS ACOUNT,
												 NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
												 0 AS CCOUNT,
												 0 AS DCOUNT,
												 0 AS ECOUNT,
												 0 AS FCOUNT,
												 0 AS GCOUNT,
												 0 AS HCOUNT
											FROM (
												SELECT
													node.ACTUAL_END_DATE,
													node.PLAN_END_DATE,
													node.ID,
													node.ORIGINAL_NODE_ID,
													node.DUTY_DEPARTMENT,
													null PROJ_NAME,
													p.PLAN_NAME,
													CASE
														WHEN f.id IS NULL THEN
														node.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																node.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	node.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME
													FROM
														POM_SPECIAL_PLAN_NODE node
														LEFT JOIN POM_SPECIAL_PLAN p ON node.PLAN_ID = p.ID
														LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.NODE_ID
														LEFT JOIN (
															SELECT
																B.*
															FROM
																(
																SELECT
																	A.*,
																	ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																FROM
																	POM_NODE_FEEDBACK A
																) B
															WHERE
																RN = 1
															) f ON f.feedback_node_id = node.id
													WHERE
													node.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = ''||currentuserid||''
													and sysdate>node.PLAN_END_DATE and node.ACTUAL_END_DATE is null
												) node
												LEFT JOIN (
													SELECT
														node_id,
														LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
													FROM
														POM_NODE_CHARGE_PERSON
													GROUP BY
														node_id
													) cp ON node.id = cp.NODE_ID
											WHERE
												(node.node_name like '%'||searchcondition||'%'
												OR node.plan_name like '%'||searchcondition||'%'
												OR node.PROJ_NAME like '%'||searchcondition||'%'
												OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
												OR cp.CHARGE_PERSON like '%'||searchcondition||'%')
											-- ����δ�������
											UNION ALL
											SELECT
												 0 AS ACOUNT,
												 0 AS BCOUNT,
												 NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
												 0 AS DCOUNT,
												 0 AS ECOUNT,
												 0 AS FCOUNT,
												 0 AS GCOUNT,
												 0 AS HCOUNT
											FROM (
												SELECT
													node.ACTUAL_END_DATE,
													node.PLAN_END_DATE,
													node.ID,
													node.ORIGINAL_NODE_ID,
													node.DUTY_DEPARTMENT,
													null PROJ_NAME,
													p.PLAN_NAME,
													CASE
														WHEN f.id IS NULL THEN
														node.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																node.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	node.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME
													FROM
														POM_SPECIAL_PLAN_NODE node
														LEFT JOIN POM_SPECIAL_PLAN p ON node.PLAN_ID = p.ID
														LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.NODE_ID
														LEFT JOIN (
															SELECT
																B.*
															FROM
																(
																SELECT
																	A.*,
																	ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																FROM
																	POM_NODE_FEEDBACK A
																) B
															WHERE
																RN = 1
															) f ON f.feedback_node_id = node.id
													WHERE
													node.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = ''||currentuserid||''
													and node.ACTUAL_END_DATE is null
												) node
												LEFT JOIN (
													SELECT
														node_id,
														LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
													FROM
														POM_NODE_CHARGE_PERSON
													GROUP BY
														node_id
													) cp ON node.id = cp.NODE_ID
											WHERE
												(node.node_name like '%'||searchcondition||'%'
												OR node.plan_name like '%'||searchcondition||'%'
												OR node.PROJ_NAME like '%'||searchcondition||'%'
												OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
												OR cp.CHARGE_PERSON like '%'||searchcondition||'%')
											-- �������������
											UNION ALL
											SELECT
												 0 AS ACOUNT,
												 0 AS BCOUNT,
												 0 AS CCOUNT,
												 NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
												 0 AS ECOUNT,
												 0 AS FCOUNT,
												 0 AS GCOUNT,
												 0 AS HCOUNT
											FROM (
												SELECT
													node.ACTUAL_END_DATE,
													node.PLAN_END_DATE,
													node.ID,
													node.ORIGINAL_NODE_ID,
													node.DUTY_DEPARTMENT,
													null PROJ_NAME,
													p.PLAN_NAME,
													CASE
														WHEN f.id IS NULL THEN
														node.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																node.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	node.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME
													FROM
														POM_SPECIAL_PLAN_NODE node
														LEFT JOIN POM_SPECIAL_PLAN p ON node.PLAN_ID = p.ID
														LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.NODE_ID
														LEFT JOIN (
															SELECT
																B.*
															FROM
																(
																SELECT
																	A.*,
																	ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																FROM
																	POM_NODE_FEEDBACK A
																) B
															WHERE
																RN = 1
															) f ON f.feedback_node_id = node.id
													WHERE
													node.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = ''||currentuserid||''
													and node.ACTUAL_END_DATE is not null
												) node
												LEFT JOIN (
													SELECT
														node_id,
														LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
													FROM
														POM_NODE_CHARGE_PERSON
													GROUP BY
														node_id
													) cp ON node.id = cp.NODE_ID
											WHERE
												(node.node_name like '%'||searchcondition||'%'
												OR node.plan_name like '%'||searchcondition||'%'
												OR node.PROJ_NAME like '%'||searchcondition||'%'
												OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
												OR cp.CHARGE_PERSON like '%'||searchcondition||'%')
											-- ��������
											UNION ALL
											SELECT
												 0 AS ACOUNT,
												 0 AS BCOUNT,
												 0 AS CCOUNT,
												 0 AS DCOUNT,
												 COUNT(node.id) AS ECOUNT,
												 0 AS FCOUNT,
												 0 AS GCOUNT,
												 0 AS HCOUNT
											FROM (
												SELECT
													node.ACTUAL_END_DATE,
													node.PLAN_END_DATE,
													node.ID,
													node.ORIGINAL_NODE_ID,
													node.DUTY_DEPARTMENT,
													null PROJ_NAME,
													p.PLAN_NAME,
													CASE
														WHEN f.id IS NULL THEN
														node.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															node.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																node.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	node.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		node.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME
													FROM
														POM_SPECIAL_PLAN_NODE node
														LEFT JOIN POM_SPECIAL_PLAN p ON node.PLAN_ID = p.ID
														LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.NODE_ID
														LEFT JOIN (
															SELECT
																B.*
															FROM
																(
																SELECT
																	A.*,
																	ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																FROM
																	POM_NODE_FEEDBACK A
																) B
															WHERE
																RN = 1
															) f ON f.feedback_node_id = node.id
													WHERE
													node.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = ''||currentuserid||''
												) node
												LEFT JOIN (
													SELECT
														node_id,
														LISTAGG ( to_char( charge_person ), ',' ) WITHIN GROUP ( ORDER BY charge_person ) AS charge_person
													FROM
														POM_NODE_CHARGE_PERSON
													GROUP BY
														node_id
													) cp ON node.id = cp.NODE_ID
											WHERE
												(node.node_name like '%'||searchcondition||'%'
												OR node.plan_name like '%'||searchcondition||'%'
												OR node.PROJ_NAME like '%'||searchcondition||'%'
												OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
												OR cp.CHARGE_PERSON like '%'||searchcondition||'%')

        );
END P_POM_SMART_CURRENTPROJ_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPSRSON_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" ( condition IN VARCHAR2, --�����������ǰ�û�ID
		searchcondition IN VARCHAR2, --ģ����ѯ����
	item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
--���ߣ�yedr
--���ڣ�2020/04/07
	v_spid VARCHAR2 ( 200 );
BEGIN
		OPEN item FOR SELECT
		NVL( SUM( ACOUNT ), 0 ) AS ACOUNT,
		NVL( SUM( BCOUNT ), 0 ) AS BCOUNT,
		NVL( SUM( CCOUNT ), 0 ) AS CCOUNT
	FROM
		(
		SELECT
			NVL( SUM( ACOUNT ), 0 ) AS ACOUNT,
			NVL( SUM( BCOUNT ), 0 ) AS BCOUNT,
			NVL( SUM( CCOUNT ), 0 ) AS CCOUNT
		FROM
			(
			SELECT
				COUNT( 1 ) ACOUNT,
				0 BCOUNT,
				0 CCOUNT
			FROM
				(
				SELECT
					n.ID,
					p.ORIGINAL_PLAN_ID,
					n.ORIGINAL_NODE_ID,
					n.PROJ_PLAN_ID,
				CASE
						p.PLAN_TYPE
						WHEN '�ؼ��ڵ�ƻ�' THEN
						0
						WHEN '��Ŀ����ƻ�' THEN
						1
					END AS PLAN_TYPE_INT,
				CASE

						WHEN f.id IS NULL THEN
						n.NODE_NAME
						WHEN f.id IS NOT NULL
						AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
							n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
							WHEN f.id IS NOT NULL
							AND f.FEEDBACK_TYPE = 'CARRY_OUT'
							AND f.APPROVAL_STATUS = 'δ���' THEN
								n.NODE_NAME || '����ɷ���δ����'
								WHEN f.id IS NOT NULL
								AND f.FEEDBACK_TYPE = 'CARRY_OUT'
								AND f.APPROVAL_STATUS = '�����' THEN
									n.NODE_NAME || '����ɷ�������С�'
									WHEN f.id IS NOT NULL
									AND f.FEEDBACK_TYPE = 'CARRY_OUT'
									AND f.APPROVAL_STATUS = '�����' THEN
										n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
									END AS NODE_NAME,
									p.PLAN_NAME,--�ƻ�����
									n.PLAN_START_DATE,
									n.PLAN_END_DATE,
									n.ACTUAL_END_DATE,
									n.ESTIMATE_END_DATE,--Ԥ�����ʱ��
									p.PROJ_NAME,--������Ŀ
									p.PLAN_TYPE,--�ƻ�������ʾ��
									n.DUTY_DEPARTMENT,--������
									person.CHARGE_PERSON,
									n.NODE_LEVEL,--����ȼ�
									n.STANDARD_SCORE --��׼��ֵ

								FROM
									POM_PROJ_PLAN_NODE n
									LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
									LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
									LEFT JOIN (
									SELECT
										B.*
									FROM
										(
										SELECT
											A.*,
											ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
										FROM
											POM_NODE_FEEDBACK A
										) B
									WHERE
										RN = 1
									) f ON f.feedback_node_id = n.id
								WHERE
									( p.PLAN_TYPE = '��Ŀ����ƻ�' OR p.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
									AND n.IS_DISABLE = 0
									AND p.APPROVAL_STATUS = '�����'
									AND CHARGE_PERSON_ID = '' || condition || ''
									AND n.ACTUAL_END_DATE IS NULL UNION ALL
								SELECT
									n.ID AS id,
									p.id AS ORIGINAL_PLAN_ID,
									n.ID AS ORIGINAL_NODE_ID,
									n.PLAN_ID,
									2 AS PLAN_TYPE_INT,
								CASE

										WHEN f.id IS NULL THEN
										n.NODE_NAME
										WHEN f.id IS NOT NULL
										AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
											n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
											WHEN f.id IS NOT NULL
											AND f.FEEDBACK_TYPE = 'CARRY_OUT'
											AND f.APPROVAL_STATUS = 'δ���' THEN
												n.NODE_NAME || '����ɷ���δ����'
												WHEN f.id IS NOT NULL
												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
												AND f.APPROVAL_STATUS = '�����' THEN
													n.NODE_NAME || '����ɷ�������С�'
													WHEN f.id IS NOT NULL
													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
													AND f.APPROVAL_STATUS = '�����' THEN
														n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
													END AS NODE_NAME,
													p.PLAN_NAME,--�ƻ�����
													n.PLAN_START_DATE,
													n.PLAN_END_DATE,
													n.ACTUAL_END_DATE,
													n.PREDICT_END_DATE,
													'������Ŀ' AS E,
													'ר��ƻ�' AS F,
													n.DUTY_DEPARTMENT,
													person.CHARGE_PERSON,
													'ר��ƻ���' AS M,
													0 AS N
												FROM
													POM_SPECIAL_PLAN_NODE n
													LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
													LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
													LEFT JOIN (
													SELECT
														B.*
													FROM
														(
														SELECT
															A.*,
															ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
														FROM
															POM_NODE_FEEDBACK A
														) B
													WHERE
														RN = 1
													) f ON f.feedback_node_id = n.id
												WHERE
													n.IS_DELETE = 0
													AND p.APPROVAL_STATUS = '�����'
													AND CHARGE_PERSON_ID = '' || condition || ''
													AND n.ACTUAL_END_DATE IS NULL
												) n
											WHERE
												(
													n.NODE_NAME LIKE '%' || searchcondition || '%'
													OR n.PLAN_NAME LIKE '%' || searchcondition || '%'
													OR n.PROJ_NAME LIKE '%' || searchcondition || '%'
													OR n.DUTY_DEPARTMENT LIKE '%' || searchcondition || '%'
													OR n.charge_person LIKE '%' || searchcondition || '%'
												)
											ORDER BY
												n.PLAN_END_DATE
											) UNION ALL
										SELECT
											SUM( ACOUNT ) AS ACOUNT,
											SUM( BCOUNT ) AS BCOUNT,
											SUM( CCOUNT ) AS CCOUNT
										FROM
											(
											SELECT
												0 ACOUNT,
												COUNT( 1 ) BCOUNT,
												0 CCOUNT
											FROM
												(
												SELECT
													n.ID,
													p.ORIGINAL_PLAN_ID,
													n.ORIGINAL_NODE_ID,
													n.PROJ_PLAN_ID,
												CASE
														p.PLAN_TYPE
														WHEN '�ؼ��ڵ�ƻ�' THEN
														0
														WHEN '��Ŀ����ƻ�' THEN
														1
													END AS PLAN_TYPE_INT,
												CASE

														WHEN f.id IS NULL THEN
														n.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = 'δ���' THEN
																n.NODE_NAME || '����ɷ���δ����'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '�����' THEN
																	n.NODE_NAME || '����ɷ�������С�'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '�����' THEN
																		n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																	END AS NODE_NAME,
																	p.PLAN_NAME,--�ƻ�����
																	n.PLAN_START_DATE,
																	n.PLAN_END_DATE,
																	n.ACTUAL_END_DATE,
																	n.ESTIMATE_END_DATE,--Ԥ�����ʱ��
																	p.PROJ_NAME,--������Ŀ
																	p.PLAN_TYPE,--�ƻ�������ʾ��
																	n.DUTY_DEPARTMENT,--������
																	person.CHARGE_PERSON,
																	n.NODE_LEVEL,--����ȼ�
																	n.STANDARD_SCORE --��׼��ֵ

																FROM
																	POM_PROJ_PLAN_NODE n
																	LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
																	LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
																	LEFT JOIN (
																	SELECT
																		B.*
																	FROM
																		(
																		SELECT
																			A.*,
																			ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																		FROM
																			POM_NODE_FEEDBACK A
																		) B
																	WHERE
																		RN = 1
																	) f ON f.feedback_node_id = n.id
																WHERE
																	( p.PLAN_TYPE = '��Ŀ����ƻ�' OR p.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
																	AND n.IS_DISABLE = 0
																	AND p.APPROVAL_STATUS = '�����'
																	AND CHARGE_PERSON_ID = '' || condition || ''
																	AND SYSDATE > PLAN_END_DATE
																	AND n.ACTUAL_END_DATE IS NULL UNION ALL
																SELECT
																	n.ID AS id,
																	p.id AS ORIGINAL_PLAN_ID,
																	n.ID AS ORIGINAL_NODE_ID,
																	n.PLAN_ID,
																	2 AS PLAN_TYPE_INT,
																CASE

																		WHEN f.id IS NULL THEN
																		n.NODE_NAME
																		WHEN f.id IS NOT NULL
																		AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
																			n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
																			WHEN f.id IS NOT NULL
																			AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																			AND f.APPROVAL_STATUS = 'δ���' THEN
																				n.NODE_NAME || '����ɷ���δ����'
																				WHEN f.id IS NOT NULL
																				AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																				AND f.APPROVAL_STATUS = '�����' THEN
																					n.NODE_NAME || '����ɷ�������С�'
																					WHEN f.id IS NOT NULL
																					AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																					AND f.APPROVAL_STATUS = '�����' THEN
																						n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																					END AS NODE_NAME,
																					p.PLAN_NAME,--�ƻ�����
																					n.PLAN_START_DATE,
																					n.PLAN_END_DATE,
																					n.ACTUAL_END_DATE,
																					n.PREDICT_END_DATE,
																					'������Ŀ' AS E,
																					'ר��ƻ�' AS F,
																					n.DUTY_DEPARTMENT,
																					person.CHARGE_PERSON,
																					'ר��ƻ���' AS M,
																					0 AS N
																				FROM
																					POM_SPECIAL_PLAN_NODE n
																					LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
																					LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
																					LEFT JOIN (
																					SELECT
																						B.*
																					FROM
																						(
																						SELECT
																							A.*,
																							ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																						FROM
																							POM_NODE_FEEDBACK A
																						) B
																					WHERE
																						RN = 1
																					) f ON f.feedback_node_id = n.id
																				WHERE
																					n.IS_DELETE = 0
																					AND p.APPROVAL_STATUS = '�����'
																					AND CHARGE_PERSON_ID = '' || condition || ''
																					AND SYSDATE > PLAN_END_DATE
																					AND n.ACTUAL_END_DATE IS NULL
																				) n
																			WHERE
																				(
																					n.NODE_NAME LIKE '%' || searchcondition || '%'
																					OR n.PLAN_NAME LIKE '%' || searchcondition || '%'
																					OR n.PROJ_NAME LIKE '%' || searchcondition || '%'
																					OR n.DUTY_DEPARTMENT LIKE '%' || searchcondition || '%'
																					OR n.charge_person LIKE '%' || searchcondition || '%'
																				)
																			ORDER BY
																				n.PLAN_END_DATE
																			) UNION ALL
																		SELECT
																			SUM( ACOUNT ) AS ACOUNT,
																			SUM( BCOUNT ) AS BCOUNT,
																			SUM( CCOUNT ) AS CCOUNT
																		FROM
																			(
																			SELECT
																				0 ACOUNT,
																				0 BCOUNT,
																				COUNT( 1 ) CCOUNT
																			FROM
																				(
																				SELECT
																					n.ID,
																					p.ORIGINAL_PLAN_ID,
																					n.ORIGINAL_NODE_ID,
																					n.PROJ_PLAN_ID,
																				CASE
																						p.PLAN_TYPE
																						WHEN '�ؼ��ڵ�ƻ�' THEN
																						0
																						WHEN '��Ŀ����ƻ�' THEN
																						1
																					END AS PLAN_TYPE_INT,
																				CASE

																						WHEN f.id IS NULL THEN
																						n.NODE_NAME
																						WHEN f.id IS NOT NULL
																						AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
																							n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
																							WHEN f.id IS NOT NULL
																							AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																							AND f.APPROVAL_STATUS = 'δ���' THEN
																								n.NODE_NAME || '����ɷ���δ����'
																								WHEN f.id IS NOT NULL
																								AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																								AND f.APPROVAL_STATUS = '�����' THEN
																									n.NODE_NAME || '����ɷ�������С�'
																									WHEN f.id IS NOT NULL
																									AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																									AND f.APPROVAL_STATUS = '�����' THEN
																										n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																									END AS NODE_NAME,
																									p.PLAN_NAME,--�ƻ�����
																									n.PLAN_START_DATE,
																									n.PLAN_END_DATE,
																									n.ACTUAL_END_DATE,
																									n.ESTIMATE_END_DATE,--Ԥ�����ʱ��
																									p.PROJ_NAME,--������Ŀ
																									p.PLAN_TYPE,--�ƻ�������ʾ��
																									n.DUTY_DEPARTMENT,--������
																									person.CHARGE_PERSON,
																									n.NODE_LEVEL,--����ȼ�
																									n.STANDARD_SCORE --��׼��ֵ

																								FROM
																									POM_PROJ_PLAN_NODE n
																									LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
																									LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
																									LEFT JOIN (
																									SELECT
																										B.*
																									FROM
																										(
																										SELECT
																											A.*,
																											ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																										FROM
																											POM_NODE_FEEDBACK A
																										) B
																									WHERE
																										RN = 1
																									) f ON f.feedback_node_id = n.id
																								WHERE
																									( p.PLAN_TYPE = '��Ŀ����ƻ�' OR p.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
																									AND n.IS_DISABLE = 0
																									AND p.APPROVAL_STATUS = '�����'
																									AND CHARGE_PERSON_ID = '' || condition || ''
																									AND n.ACTUAL_END_DATE IS NOT NULL UNION ALL
																								SELECT
																									n.ID AS id,
																									p.id AS ORIGINAL_PLAN_ID,
																									n.ID AS ORIGINAL_NODE_ID,
																									n.PLAN_ID,
																									2 AS PLAN_TYPE_INT,
																								CASE

																										WHEN f.id IS NULL THEN
																										n.NODE_NAME
																										WHEN f.id IS NOT NULL
																										AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
																											n.NODE_NAME || '��Ԥ���������:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '��'
																											WHEN f.id IS NOT NULL
																											AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																											AND f.APPROVAL_STATUS = 'δ���' THEN
																												n.NODE_NAME || '����ɷ���δ����'
																												WHEN f.id IS NOT NULL
																												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																												AND f.APPROVAL_STATUS = '�����' THEN
																													n.NODE_NAME || '����ɷ�������С�'
																													WHEN f.id IS NOT NULL
																													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																													AND f.APPROVAL_STATUS = '�����' THEN
																														n.NODE_NAME || '��ʵ���������:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '��'
																													END AS NODE_NAME,
																													p.PLAN_NAME,--�ƻ�����
																													n.PLAN_START_DATE,
																													n.PLAN_END_DATE,
																													n.ACTUAL_END_DATE,
																													n.PREDICT_END_DATE,
																													'������Ŀ' AS E,
																													'ר��ƻ�' AS F,
																													n.DUTY_DEPARTMENT,
																													person.CHARGE_PERSON,
																													'ר��ƻ���' AS M,
																													0 AS N
																												FROM
																													POM_SPECIAL_PLAN_NODE n
																													LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
																													LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID = person.NODE_ID
																													LEFT JOIN (
																													SELECT
																														B.*
																													FROM
																														(
																														SELECT
																															A.*,
																															ROW_NUMBER () OVER ( partition BY a.feedback_node_id ORDER BY A.CREATED DESC nulls last ) rn
																														FROM
																															POM_NODE_FEEDBACK A
																														) B
																													WHERE
																														RN = 1
																													) f ON f.feedback_node_id = n.id
																												WHERE
																													n.IS_DELETE = 0
																													AND p.APPROVAL_STATUS = '�����'
																													AND CHARGE_PERSON_ID = '' || condition || ''
																													AND n.ACTUAL_END_DATE IS NOT NULL
																												) n
																											WHERE
																												(
																													n.NODE_NAME LIKE '%' || searchcondition || '%'
																													OR n.PLAN_NAME LIKE '%' || searchcondition || '%'
																													OR n.PROJ_NAME LIKE '%' || searchcondition || '%'
																													OR n.DUTY_DEPARTMENT LIKE '%' || searchcondition || '%'
																													OR n.charge_person LIKE '%' || searchcondition || '%'
																												)
																											ORDER BY
																												n.PLAN_END_DATE
																											)
																										);

END P_POM_SMART_CURRENTPSRSON_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_DELAY_NODE_CURRENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_DELAY_NODE_CURRENT" (
    plantype       IN             VARCHAR2,
    datascope      IN             VARCHAR2,
    orgid          IN             VARCHAR2,
    title          OUT            VARCHAR2,
    titleicon      OUT            VARCHAR2,
    currentdelay   OUT            SYS_REFCURSOR
) AS --�ؼ��ڵ�ƻ����-��ǰ����ڵ�
        --���ߣ�����
        --���ڣ�2019/11/13
BEGIN
    title := '��ǰ����ڵ�';
    --ͼ����ַ https://element.eleme.cn/#/zh-CN/component/icon
    titleicon := 'el-icon-tickets';
     
																		 
                OPEN CURRENTDELAY FOR
                        SELECT DISTINCT A.ORG_NAME AS "orgName",
                                                        B2.PROJECTSTAGE_NAME AS "projName",
                                                        B2.NODE_NAME|| CASE WHEN ESTIMATE_END_DATE IS NOT NULL THEN   '(Ԥ��������ڣ�'||TO_CHAR(ESTIMATE_END_DATE,'YYYY-MM-DD ')||')'END  AS "nodeName",
                                                        NODE_ID as "nodeId",
                                                        ORIGINAL_NODE_ID as "nodeOriginId",
                                                        '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
                                                         NVL(B2.COMPANY_ID, '003200000000000000000000000000') ||
                                                         '&ppid=' || B2.PPID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
                                                        '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id=' ||
                                                         B2.PLANID || '&feedbackNodeId=' || NODE_ID ||
                                                         '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID ||
                                                         '&nodeSourcePlanType=0' AS "nodeOpenUrl",
                                                          '<span class="right"> ������ <span style="display: inline-block;
                                                                width: 40px;
                                                                text-align: center;
                                                                border-radius: 4px;
                                                                margin: 0 4px;
                                                                background-color: rgb(248, 94, 90);
                                                                color: #fff;
                                                                font-weight: 700;">'
                                                                ||TO_CHAR(TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd'))
                                                                ||'</span> �� </span>'             AS "delayDays"
																																,TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') as "DelayDAYsRUNK"
                        FROM   SYS_BUSINESS_UNIT A

                        LEFT   JOIN (SELECT LEVEL, ORG_NAME, CONNECT_BY_ROOT ID AS ID,
                                                                CONNECT_BY_ROOT PARENT_ID AS PARENT_ID,
                                                                B.UNIT_ID, B.NODE_NAME, B.NODE_ID,
                                                                B.ACTUAL_END_DATE, B.PLAN_END_DATE,
                                                                B.PROJECTSTAGE_NAME, B.PPID, B.PID,
                                                                'TYPE_ORG' AS CTYPE, B.ESTIMATE_END_DATE,
                                                                B.PLANID, ORIGINAL_NODE_ID,B.COMPANY_ID
                                                 FROM   SYS_BUSINESS_UNIT A
                                                 LEFT   JOIN (SELECT B1.UNIT_ID, A.ID AS PLANID,A.COMPANY_ID,
                                                                                        case when  STAGE_NAME like '%�޷���%' then  B1.ID else A.PROJ_ID end   AS PPID,--20200427��С�ϵ������޸�
																																												B1.ID AS PID,
                                                                                        A1.ORIGINAL_NODE_ID,

                                                                                         A.PROJ_NAME AS PROJECTSTAGE_NAME,
                                                                                        A1.NODE_NAME, A1.ID AS NODE_ID,
                                                                                        A1.ACTUAL_END_DATE,
                                                                                        A1.PLAN_END_DATE,
                                                                                        A1.ESTIMATE_END_DATE
                                                                         FROM   POM_PROJ_PLAN A
                                                                         INNER  JOIN POM_PROJ_PLAN_NODE A1
                                                                         ON     A.ID = A1.PROJ_PLAN_ID
                                                                         INNER  JOIN SYS_PROJECT_STAGE C1
                                                                         ON     A.PROJ_ID = C1.ID
                                                                         INNER  JOIN SYS_PROJECT B1
                                                                         ON     C1.PROJECT_ID = B1.ID
                                                                         WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND

                                                                                        A.APPROVAL_STATUS = '�����'
																																									and  A1.IS_DISABLE=0
																																									AND

                                                                                        TRUNC(SYSDATE, 'dd') -TRUNC(PLAN_END_DATE, 'dd') > 0 AND
                                                                                        ACTUAL_END_DATE IS NULL) B
                                                 ON     A.ID = B.UNIT_ID
                                                 WHERE  ORG_TYPE = 0
                                                 START  WITH ID = '' || ORGID || ''
                                                 CONNECT BY PRIOR A.ID = A.PARENT_ID) B2
                        ON     A.ID = B2.ID
                        WHERE  NODE_NAME IS NOT NULL AND
                                     ACTUAL_END_DATE IS NULL AND
                                     TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 
																		 --����
                        UNION ALL
                        SELECT DISTINCT '' AS "orgName",
                                                     A.PROJ_NAME AS "projName",
                                                        A1.NODE_NAME|| CASE WHEN ESTIMATE_END_DATE IS NOT NULL THEN   '(Ԥ��������ڣ�'||TO_CHAR(ESTIMATE_END_DATE,'YYYY-MM-DD ')||')'END  AS "nodeName",
                                                         A1.ID as "nodeId",
                                                        A1.ORIGINAL_NODE_ID as "nodeOriginId",
                                                        '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
                                                         NVL(A.COMPANY_ID,
                                                                 '003200000000000000000000000001') ||
                                                         '&ppid=' || C1.ID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
                                                        '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id=' || A.ID ||
                                                         '&feedbackNodeId=' || A1.ID ||
                                                         '&feedbackNodeOriginalId=' ||
                                                         A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
                                                          '<span class="right"> ������ <span style="display: inline-block;
                                                                width: 40px;
                                                                text-align: center;
                                                                border-radius: 4px;
                                                                margin: 0 4px;
                                                                background-color: rgb(248, 94, 90);
                                                                color: #fff;
                                                                font-weight: 700;">'
                                                                ||TO_CHAR(TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd'))
                                                                ||'</span> �� </span>'             AS "delayDays"
--                                                        TRUNC(SYSDATE, 'dd') -
--                                                         TRUNC(PLAN_END_DATE, 'dd') AS "delayDays"
,TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') as "DelayDAYsRUNK"

                        FROM   POM_PROJ_PLAN A
                        INNER  JOIN POM_PROJ_PLAN_NODE A1
                        ON     A.ID = A1.PROJ_PLAN_ID
                        INNER  JOIN SYS_PROJECT_STAGE C1
                        ON     A.PROJ_ID = C1.ID
                        INNER  JOIN SYS_PROJECT B1
                        ON     C1.PROJECT_ID = B1.ID
                        WHERE  A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
                                     A.APPROVAL_STATUS = '�����'
																		 and  A1.IS_DISABLE=0
																		 AND

                                     TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 AND
                                     ACTUAL_END_DATE IS NULL AND
                                     C1.PROJECT_ID = '' || ORGID || ''
                        ORDER  BY 9 DESC,2;							 
																		 
END p_pom_smart_delay_node_current;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_BASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_BASE" (
    ---��������
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ---------------------------------����sql
    ---�ؼ�������
    v_where_like_sql       OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql  OUT   CLOB,
    ---���������ű� 
    fb_sql     OUT   CLOB,
    ---����Ȩ�޽ű� 
    auth_data_sql    OUT   CLOB,
    ---��ע�ű�
    watch_sql   OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
  ---����Ȩ����֤spid
    v_spid              VARCHAR2(200);
BEGIN
     ------------------------------------------20210417
    ------����Ȩ�ޣ���Ȩ�޵Ĳ��ź���Ŀ
    ------�ؼ��ڵ�ƻ�����Ŀ����ƻ���ר��ƻ�
    ------�������񡢳���δ�����������δ���������������������������񡢴������񡢱��������񡢱�������
--------------------------------------------------------------------------------------------------------�ֶ�ʹ��-------------------------------------------------------------------------------------20210417
--1.���ƹ�����������---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��plan_type��node_level
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---���ݽڵ����ͺͼƻ����ͷ���ȡ��ȡ�����һ������
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '���ƹ���'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---ƴ���ַ���
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --�������0ƴ��������case when ���
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
        ELSE
            --�޹���������ʾ��
            light_up_plan_expression_sql := '''''';
        END IF;
--1.���ƹ�����������---���----------------------------------------------------------------------------------------------20210417
--5.NODE_NAMEƴ��������ں�״̬---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�����id���ڵ�name���������͡�����Ԥ��������ڡ�����ʵ��������ڡ�����״̬
node_name_filed_sql:='( CASE
                        WHEN ����id IS NULL THEN �ڵ�����
                        WHEN ����id IS NOT NULL AND �������� <> ''CARRY_OUT''
                            THEN �ڵ�����||''��Ԥ���������:''||to_char(����Ԥ���������,''yyyy-MM-dd'')||''��''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''δ���''
                            THEN �ڵ�����||''����ɷ���δ����''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''����ɷ�������С�''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''��ʵ���������:''||to_char(����ʵ���������,''yyyy-MM-dd'')||''��''
                    END) ';
--5.NODE_NAMEƴ��������ں�״̬---���----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid,�Ƿ�ȡ��,�ڵ�ʵ���������
--------�ṩWACTH��HASTEN��W_Url
watch_filed_sql:='�Ƿ�ȡ�� as IS_UN_WATCH 
                   ,(case when �Ƿ�ȡ��=0 then ''ȡ��'' else ''��ע'' end) as WACTH
                   ,(case when �ڵ�ʵ��������� is null then ''�߰�'' else null end) as HASTEN
                   ,(case when �Ƿ�ȡ��=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||�ڵ�ԭʼid
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||�ڵ�ԭʼid end) as W_Url';
--------------------------------------------------------------------------------------------------------�ֶ�ʹ��-------------------------------------------------------------------------------------20210417

--2.Ȩ�޻�ȡ---��ʼ----------------------------------------------------------------------------------------------20210417
     --��������Ȩ����֤�洢����
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
--2.Ȩ�޻�ȡ---���----------------------------------------------------------------------------------------------20210417
--3.tab����---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��ACTUAL_END_DATE
 IF currenttype = '��������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'')
                       and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_sql := ' and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_sql := ' and 1=2';
        END IF;


-------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND (�ڵ�ƻ�������� >= trunc(SYSDATE, ''month'') AND �ڵ�ƻ�������� <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(�ڵ�ƻ��������, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= last_day( trunc( SYSDATE ) ) + 1
								AND �ڵ�ƻ�������� <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (�ڵ�ƻ��������>= trunc( SYSDATE, ''Q'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= trunc( SYSDATE, ''yyyy'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--3.tab����---���----------------------------------------------------------------------------------------------20210417 
--4.�ؼ�������---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�NODE_NAME��PLAN_NAME��PROJ_NAME��DUTY_DEPARTMENT��charge_person
-----������ؼ��ֲ�Ϊ��ʱ
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.�ڵ�����,'''||searchcondition||''')>0 OR instr(node.�ƻ�����,'''||searchcondition||''')>0
              OR instr(node.������Ŀ,'''||searchcondition||''')>0 OR instr(node.������,'''||searchcondition||''')>0
              OR instr(������,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.�ؼ�������---���----------------------------------------------------------------------------------------------20210417   


--6.����������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�id
node_Principal_sql:='                  
                           SELECT node_id as �����˽ڵ�id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS ������
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.����������---���----------------------------------------------------------------------------------------------20210417  
--7.��������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as ����id,a.feedback_node_id as �����ڵ�id,a.feedback_node_original_id as �����ڵ�ԭʼid
                            ,a.approval_status as �������״̬,a.actual_end_time as ����ʵ���������,ESTIMATE_END_TIME as ����Ԥ���������
                            ,feedback_type as ��������
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.��������---���----------------------------------------------------------------------------------------------20210417  
--8.����Ȩ��---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣�����id����Ŀid
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.����Ȩ��---���----------------------------------------------------------------------------------------------20210417

--9.ҵ���ע---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
watch_sql:='(
            SELECT biz_id as ��עҵ��id,watcher_id as ��ע��,is_un_watch as �Ƿ�ȡ�� FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.ҵ���ע---���----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------����
proj_noed_sql:=' SELECT
                    n.ID   AS �ڵ�id,
                    p.id as �ƻ�ԭʼid,
                    n.original_node_id   AS �ڵ�ԭʼid,
                    n.PLAN_ID as �ƻ�id,
                    2  as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.PREDICT_END_DATE as �ڵ�Ԥ���������,
                    ''������Ŀ'' AS     ������Ŀ,
                    ''ר��ƻ�'' AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    ''ר��ƻ���'' AS �ڵ�ȼ�,
                    0 AS ��׼��ֵ
                FROM POM_SPECIAL_PLAN_NODE n
                ---�����ƻ�
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---����˵ļƻ�
                WHERE p.APPROVAL_STATUS=''�����'' AND (n.IS_DELETE=0 or n.is_DELETE is null) ';
special_noed_sql:='                
                SELECT
                    n.ID  AS �ڵ�id,
                    p.ORIGINAL_PLAN_ID  as �ƻ�ԭʼid,
                    n.ORIGINAL_NODE_ID  AS �ڵ�ԭʼid,
                    n.PROJ_PLAN_ID as �ƻ�id,
                    (CASE p.PLAN_TYPE WHEN ''�ؼ��ڵ�ƻ�'' THEN 0 WHEN ''��Ŀ����ƻ�'' THEN 1 END) as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.ESTIMATE_END_DATE as �ڵ�Ԥ���������,
                    p.PROJ_NAME AS     ������Ŀ,
                    p.PLAN_TYPE AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    n.NODE_LEVEL AS �ڵ�ȼ�,
                    n.STANDARD_SCORE  AS ��׼��ֵ
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and p.APPROVAL_STATUS=''�����''
                    AND (n.IS_DELETE=0 or n.is_DELETE is null)  ';
-------   ����˾��������                 
--join_where_sql:='                        
--            --- ������
--            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
--            --- ��������
--            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
--            --- ������ע
--            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
--            --- ����Ȩ��
--            left join ('||auth_data_sql||') tal on �����Ŷ�Ӧ��˾id=orgid
--            where 1=1 and tal.orgid is not null
--            --- like����
--           ' ||v_where_like_sql||'';
END P_POM_SMART_MY_CURRENT_BASE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid IN VARCHAR2,--�����������˾id
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    pageindex IN INT,
    pagesizes IN INT,
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    items OUT SYS_REFCURSOR,
    total OUT INT
) IS
--����˾��������
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
    
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;
    
    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => COMPANYID,
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_company;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_DEPT" (
    userid        IN            VARCHAR,--�û�id�����ڹ��˹�ע������
    deptid        IN            VARCHAR2,--�������������
    currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
    currentdeptid        IN            VARCHAR2,--��ǰ�û�����
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode       IN            VARCHAR2,---Ȩ��code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--    auth          OUT           SYS_REFCURSOR
) IS
    --�����Ÿ��������
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
    
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;
    
    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_DEPT(
    DEPTID => deptid,
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_dept;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PERSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PERSON" (
    userid        IN            VARCHAR2,--����������û�ID
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ����ͣ�����δ��ɣ�����δ��ɣ���������ɣ�
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --�Ҹ��������  �ؼ��ڵ�ƻ�����Ŀ����ƻ���ר��ƻ�
--���ߣ�����
--���ڣ�2019/11/15
    v_sql_start          CLOB;
    v_sql_end           CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    testmsg             CLOB;
    v_where_like       CLOB;
    spcil_sql           CLOB;
    plan_expression     varchar2(4000);
BEGIN
    total := 1000;
    v_sql_start := ' case ';
    v_sql_content := '';
    v_sql_end := '  else '''' end  ';
    BEGIN
        --1.ƴ�Ӳ�ѯ���
        FOR item IN (
            SELECT
                s.expression,
                vv.node_level,
                vv.plan_type
            FROM
                pom_rule_set s
                    LEFT JOIN (
                    SELECT
                        MAX(s.created_time) AS t,
                        node_level,
                        plan_type
                    FROM
                        pom_rule_set             s
                            LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                    WHERE
                            rule_type = '���ƹ���'
                      --AND plan_type != '�ؼ��ڵ�ƻ�'
                      AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                    AND s.node_level = vv.node_level
            WHERE
                    vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = 'ר��ƻ�' THEN
                    plan_expression := ''' then ('''
                        || item.expression
                        || ''') ';
                ELSE
                    plan_expression := ''' then ('
                        || item.expression
                        || ') ';
                END IF ;
                ---ƴ���ַ���
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type
                           WHEN '��Ŀȫ���ƻ�' THEN '��Ŀ����ƻ�'
                           ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --�������ݴ���0��ƴ�������
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                || v_sql_content
                || v_sql_end;
        ELSE
            --�޹���������ʾ��
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------����
        IF currenttype = '����δ�������' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>PLAN_END_DATE  and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSE
            v_where := '' ;
        END IF;
        --������������Ϊ��ʱ
        IF searchcondition is not null THEN
            v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(n.charge_person,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like := '' ;
        END IF;
        spcil_sql := ' UNION ALL
                SELECT
                    n.ID   AS id,
                     p.id as ORIGINAL_PLAN_ID,
                    n.ID   AS ORIGINAL_NODE_ID,
                    n.PLAN_ID,
                    2 AS PLAN_TYPE_INT,
                    CASE WHEN f.id IS NULL THEN
                            n.NODE_NAME
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
                            n.NODE_NAME||''��Ԥ���������:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''��''
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''δ���'' THEN
                            n.NODE_NAME||''����ɷ���δ����''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����'' THEN
                            n.NODE_NAME||''����ɷ�������С�''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����'' THEN
                            n.NODE_NAME||''��ʵ���������:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''��''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--�ƻ�����
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.PREDICT_END_DATE,
                    ''������Ŀ'' AS E,
                    ''ר��ƻ�'' AS F,
                    n.DUTY_DEPARTMENT,
                        person.CHARGE_PERSON,
                    ''ר��ƻ���'' AS M,
                    0 AS N
                FROM
                    POM_SPECIAL_PLAN_NODE n
                        LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A) B
                        WHERE RN = 1) f on f.feedback_node_id=n.id
                        where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''�����''
                        AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || '';
        --ר��ƻ������ã����ǲ����¶ȼƻ���δ���á���Ҫ���ò����¶ȼƻ�ʱ��ȡ�������sql����
--                UNION ALL
--                    SELECT    n.id,
--                    p.ORIGINAL_PLAN_ID,
--                    n.original_node_id,
--                    dept_monthly_plan_id,
--                    3 as  PLAN_TYPE_INT,
--
--                    n.node_name,
--                    p.PLAN_NAME,
--                    PLAN_START_DATE,
--                    PLAN_END_DATE,
--
--                    ACTUAL_END_DATE,
--                    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
--                    ''��'' as PROJ_NAME,          --������Ŀ
--                    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
--                    p.DEPT_NAME,          --������
--                        person.CHARGE_PERSON,
--                    node_Type,           --����ȼ�
--                    stand_SCORE          --��׼��ֵ
--                FROM
--                    pom_dept_monthly_plan_node n
--                    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
--                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
--                    where n.IS_DEL=0 and APPROVE_STATUS=''�����''
--                        AND CHARGE_PERSON_ID='''||userid||'''  '
--                                      || v_where;
--3.ƴ���������
        v_sql_exec := ' select  rownum as rowno,ID,
    ORIGINAL_NODE_ID,
    ORIGINAL_PLAN_ID,
    PROJ_PLAN_ID as PLAN_ID,
    PLAN_TYPE_INT,
    NODE_NAME,
    PLAN_NAME,
    TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
    case when ACTUAL_END_DATE is null then ''δ���''
    else ''�����'' end as COMPLETION_STATUS,
    PROJ_NAME,
    PLAN_TYPE,
    DUTY_DEPARTMENT,
    NODE_LEVEL,
		CHARGE_PERSON,
    STANDARD_SCORE ,WACTH,HASTEN,'
            || v_sql
            || ' as NODE_WARNING from (select n.*,''��ע'' as WACTH,''�߰�'' as HASTEN from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    n.ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''�ؼ��ڵ�ƻ�''   THEN
            0
        WHEN ''��Ŀ����ƻ�''   THEN
            1
    END AS PLAN_TYPE_INT,
    CASE WHEN f.id IS NULL THEN
        n.NODE_NAME
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
        n.NODE_NAME||''��Ԥ���������:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''��''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''δ���'' THEN
        n.NODE_NAME||''����ɷ���δ����''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����'' THEN
        n.NODE_NAME||''����ɷ�������С�''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����'' THEN
        n.NODE_NAME||''��ʵ���������:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''��''
    END AS NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    n.PLAN_START_DATE,
    n.PLAN_END_DATE,

    n.ACTUAL_END_DATE,
    n.ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    n.DUTY_DEPARTMENT,          --������
		person.CHARGE_PERSON,
    n.NODE_LEVEL,           --����ȼ�
    n.STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
        FROM POM_NODE_FEEDBACK A) B
        WHERE RN = 1) f on f.feedback_node_id=n.id
		WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' OR p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') AND n.IS_DISABLE=0  and p.APPROVAL_STATUS=''�����''
		AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || spcil_sql
            || ')n '||v_where_like||'
   ORDER BY n.PLAN_END_DATE  ) a  ';-- left join POM_NODE_CHARGE_PERSON cp on n.id=cp.NODE_ID where CHARGE_PERSON_ID='''||userid||'''
-------------------------------------------------------------------------------------------����
        -- dbms_output.put_line(v_sql_exec);
        v_sql_exec_paging := '
select a.* from ( '
            || v_sql_exec
            || ' where rownum <= '
            || pageindex * pagesizes
            || ' ) a where a.rowno > '
            || pagesizes * ( pageindex - 1 )
            || '';
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
            || v_sql_exec
            || ') a '
            INTO total;
        dbms_output.put_line(v_sql_exec_paging);
-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec_paging;
--SELECT '' A FROM DUAL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN items FOR SELECT 'ʧ�ܿ�' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_person;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PROJ" (
    projid        IN            VARCHAR2,--�����������Ŀ
    userid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
    currentdeptid        IN            VARCHAR2,--��ǰ�û�����
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode       IN            VARCHAR2,---Ȩ��code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --�����Ÿ��������
--���ߣ�����
--���ڣ�2019/11/15
    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    v_spid              CLOB;
    spcil_sql              CLOB;
    testmsg              CLOB;
    v_where_like       CLOB;
    plan_expression     varchar2(4000);
BEGIN
    ----------------------------------------------------ͳһ����
    testmsg := 'projid:'
        || projid
        || '��pageindex:'
        || pageindex
        || '��pagesizes:'
        || pagesizes
        || '��currenttype:'
        || currenttype;

    BEGIN
        total := 1000;
        v_sql_start := ' case ';
        v_sql_content := '';
        v_sql_end := '  else '''' end  ';
        --��������Ȩ����֤�洢����
        P_AUTH_BLOCK_PROJ_COMPANY(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_SPID_ID => v_spid
            );
        --1.ƴ�Ӳ�ѯ���
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '���ƹ���'
                  -- AND plan_type != '�ؼ��ڵ�ƻ�'
                  AND s.is_disable = 0
                GROUP BY  node_level,  plan_type
            ) vv ON s.created_time = vv.t AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = 'ר��ƻ�'
                THEN plan_expression := ''' then (''' || item.expression || ''') ';
                ELSE plan_expression := ''' then (' || item.expression || ') ';
                END IF ;
                ---ƴ���ַ���
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type WHEN '��Ŀȫ���ƻ�' THEN '��Ŀ����ƻ�' ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --�������ݴ���0��ƴ�������
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start || v_sql_content || v_sql_end;
        ELSE
            --�޹���������ʾ��
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------����
        IF currenttype = '��������' THEN
            v_where := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>n.PLAN_END_DATE and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            v_where := ' ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1 and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;
        --������������λ��ʱ
        IF searchcondition is not null THEN
            v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(cp.charge_person,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like := '';
        END IF;
        spcil_sql :=
                    'UNION ALL
                     SELECT
                         n.ID   AS id,
                         p.id as ORIGINAL_PLAN_ID,
                         n.ID   AS ORIGINAL_NODE_ID,
                         n.PLAN_ID,
                         2 AS PLAN_TYPE_INT,
                         ''backid'' backid,
                         CASE
                             WHEN f.id IS NULL THEN n.NODE_NAME
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                                 THEN n.NODE_NAME||''��Ԥ���������:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''��''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''δ���''
                                 THEN n.NODE_NAME||''����ɷ���δ����''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����''
                                 THEN n.NODE_NAME||''����ɷ�������С�''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����''
                                  THEN n.NODE_NAME||''��ʵ���������:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''��''
                         END AS NODE_NAME,
                         p.PLAN_NAME,--�ƻ�����
                         n.PLAN_START_DATE,
                         n.PLAN_END_DATE,
                         n.ACTUAL_END_DATE,
                         n.PREDICT_END_DATE,
                         ''������Ŀ'' AS PROJ_NAME,
                         ''ר��ƻ�'' AS PLAN_TYPE,
                         n.DUTY_DEPARTMENT,
                         ''ר��ƻ���'' AS NODE_LEVEL,
                         0 AS STANDARD_SCORE
                         FROM POM_SPECIAL_PLAN_NODE n
                             LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                             LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                             LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                             ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                             FROM POM_NODE_FEEDBACK A) B
                             WHERE RN = 1) f on f.feedback_node_id=n.id
                             where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''�����'' AND CHARGE_PERSON_ID='''||userid||'''  '
                    || v_where
                    || '';
        --3.ƴ���������
        --         if projid <> '111' then
        v_sql_exec :=
                    'select
                         rownum as rowno,ID,
                         ORIGINAL_NODE_ID,
                         ORIGINAL_PLAN_ID,
                         PROJ_PLAN_ID as PLAN_ID,
                         PLAN_TYPE_INT,
                         NODE_NAME,
                         PLAN_NAME,
                         TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when ACTUAL_END_DATE is null then ''δ���''
                         else ''�����'' end as COMPLETION_STATUS,
                         PROJ_NAME,
                         PLAN_TYPE,
                         DUTY_DEPARTMENT,
                         CHARGE_PERSON,
                         NODE_LEVEL,
                         STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                    || v_sql
                    || ' as NODE_WARNING
            from (
                select
                    n.*,charge_person,w.IS_UN_WATCH
                    ,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
                    ,case when n.ACTUAL_END_DATE is null then ''�߰�''
                    else null end as HASTEN
                    ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=&bizId=''||ORIGINAL_NODE_ID end as w_Url
                from(
                    SELECT
                        n.ID,
                        p.ORIGINAL_PLAN_ID,
                        n.ORIGINAL_NODE_ID,
                        n.PROJ_PLAN_ID,
                        CASE p.PLAN_TYPE
                            WHEN ''�ؼ��ڵ�ƻ�'' THEN 0
                            WHEN ''��Ŀ����ƻ�'' THEN 1
                        END AS PLAN_TYPE_INT,
                        f.id as backId,
                    CASE
                        WHEN f.id IS NULL THEN n.NODE_NAME
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                            THEN n.NODE_NAME||''��Ԥ���������:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''��''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''δ���''
                            THEN n.NODE_NAME||''����ɷ���δ����''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����''
                            THEN n.NODE_NAME||''����ɷ�������С�''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''�����''
                            THEN n.NODE_NAME||''��ʵ���������:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''��''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--�ƻ�����
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --Ԥ�����ʱ��
                    p.PROJ_NAME,          --������Ŀ
                    p.PLAN_TYPE,        --�ƻ�������ʾ��
                    n.DUTY_DEPARTMENT,          --������
                    n.NODE_LEVEL,           --����ȼ�
                    n.STANDARD_SCORE          --��׼��ֵ
                FROM POM_PROJ_PLAN_NODE n
		        LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                LEFT JOIN (
                    SELECT B.*
                    FROM (
                        SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A
                    ) B WHERE RN = 1
                ) f on f.feedback_node_id=n.id
                inner JOIN (
                    select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
                ) tal on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and p.APPROVAL_STATUS=''�����''
		        AND n.IS_DISABLE=0
						AND n.Is_DELETE=0
		        AND ('''||projid||''' is null or (p.PROJ_ID='''||projid||''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID='''
                    ||projid||''')))  '||v_where|| spcil_sql ||'
            )n left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
            left join (
                SELECT node_id,
                LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                FROM POM_NODE_CHARGE_PERSON group by node_id
            ) cp on n.id=cp.NODE_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
        -------------------------------------------------------------------------------------------����
        v_sql_exec_paging :=
                    'select a.*
                     from (
                        ' || v_sql_exec || '
                where rownum <= ' || pageindex * pagesizes || '
             ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

        dbms_output.put_line(v_sql_exec_paging);
				insert into TEST(ID, PROJ_NAME, SQL_STR) values (GET_UUID(), 'CURRENT_PROJ_����Ŀ', v_sql_exec);
        ----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
            || v_sql_exec
            || ') a '
            INTO total;
        OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT 'ʧ�ܿ�' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_proj;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_SQL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_SQL" (
    companyid IN VARCHAR2,--�����������˾id
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
     ------------------------------------------20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_expression_sql OUT   CLOB,
    
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,

    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
  ---����Ȩ����֤spid
    v_spid              VARCHAR2(200);
     ---�ؼ�������
    v_where_like_sql         CLOB;
    ---���������˱��ʽ
    node_Principal_sql     CLOB;
    ---���������ű� 
    fb_sql     CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql     CLOB;
    ---��ע�ű�
    watch_sql     CLOB;
BEGIN
     ------------------------------------------20210417
    ------����Ȩ�ޣ���Ȩ�޵Ĳ��ź���Ŀ
    ------�ؼ��ڵ�ƻ�����Ŀ����ƻ���ר��ƻ�
    ------�������񡢳���δ�����������δ���������������������������񡢴������񡢱��������񡢱�������
--------------------------------------------------------------------------------------------------------�ֶ�ʹ��-------------------------------------------------------------------------------------20210417
--1.���ƹ�����������---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��plan_type��node_level
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---���ݽڵ����ͺͼƻ����ͷ���ȡ��ȡ�����һ������
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '���ƹ���'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---ƴ���ַ���
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --�������0ƴ��������case when ���
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
        ELSE
            --�޹���������ʾ��
            light_up_plan_expression_sql := '''''';
        END IF;
--1.���ƹ�����������---���----------------------------------------------------------------------------------------------20210417
--5.NODE_NAMEƴ��������ں�״̬---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�����id���ڵ�name���������͡�����Ԥ��������ڡ�����ʵ��������ڡ�����״̬
node_name_filed_sql:='( CASE
                        WHEN ����id IS NULL THEN �ڵ�����
                        WHEN ����id IS NOT NULL AND �������� <> ''CARRY_OUT''
                            THEN �ڵ�����||''��Ԥ���������:''||to_char(����Ԥ���������,''yyyy-MM-dd'')||''��''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''δ���''
                            THEN �ڵ�����||''����ɷ���δ����''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''����ɷ�������С�''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''��ʵ���������:''||to_char(����ʵ���������,''yyyy-MM-dd'')||''��''
                    END) ';
--5.NODE_NAMEƴ��������ں�״̬---���----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid,�Ƿ�ȡ��,�ڵ�ʵ���������
--------�ṩWACTH��HASTEN��W_Url
watch_filed_sql:='�Ƿ�ȡ�� as IS_UN_WATCH 
                   ,(case when �Ƿ�ȡ��=0 then ''ȡ��'' else ''��ע'' end) as WACTH
                   ,(case when �ڵ�ʵ��������� is null then ''�߰�'' else null end) as HASTEN
                   ,(case when �Ƿ�ȡ��=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||�ڵ�ԭʼid
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||�ڵ�ԭʼid end) as W_Url';
--------------------------------------------------------------------------------------------------------�ֶ�ʹ��-------------------------------------------------------------------------------------20210417

--2.Ȩ�޻�ȡ---��ʼ----------------------------------------------------------------------------------------------20210417
     --��������Ȩ����֤�洢����
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
--2.Ȩ�޻�ȡ---���----------------------------------------------------------------------------------------------20210417
--3.tab����---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��ACTUAL_END_DATE
 IF currenttype = '��������' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'')
                       and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_expression_sql := ' and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            tab_where_expression_sql := ' ';
        ELSIF currenttype = '��������' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_expression_sql := ' and 1=2';
        END IF;


-------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND (�ڵ�ƻ�������� >= trunc(SYSDATE, ''month'') AND �ڵ�ƻ�������� <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(�ڵ�ƻ��������, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= last_day( trunc( SYSDATE ) ) + 1
								AND �ڵ�ƻ�������� <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (�ڵ�ƻ��������>= trunc( SYSDATE, ''Q'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= trunc( SYSDATE, ''yyyy'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--3.tab����---���----------------------------------------------------------------------------------------------20210417 
--4.�ؼ�������---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�NODE_NAME��PLAN_NAME��PROJ_NAME��DUTY_DEPARTMENT��charge_person
-----������ؼ��ֲ�Ϊ��ʱ
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.�ڵ�����,'''||searchcondition||''')>0 OR instr(node.�ƻ�����,'''||searchcondition||''')>0
              OR instr(node.������Ŀ,'''||searchcondition||''')>0 OR instr(node.������,'''||searchcondition||''')>0
              OR instr(������,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.�ؼ�������---���----------------------------------------------------------------------------------------------20210417   


--6.����������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�id
node_Principal_sql:='                  
                           SELECT node_id as �����˽ڵ�id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS ������
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.����������---���----------------------------------------------------------------------------------------------20210417  
--7.��������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as ����id,a.feedback_node_id as �����ڵ�id,a.feedback_node_original_id as �����ڵ�ԭʼid
                            ,a.approval_status as �������״̬,a.actual_end_time as ����ʵ���������,ESTIMATE_END_TIME as ����Ԥ���������
                            ,feedback_type as ��������
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.��������---���----------------------------------------------------------------------------------------------20210417  
--8.����Ȩ��---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣�����id����Ŀid
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.����Ȩ��---���----------------------------------------------------------------------------------------------20210417

--9.ҵ���ע---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
watch_sql:='(
            SELECT biz_id as ��עҵ��id,watcher_id as ��ע��,is_un_watch as �Ƿ�ȡ�� FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.ҵ���ע---���----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------����
proj_noed_sql:=' SELECT
                    n.ID   AS �ڵ�id,
                    p.id as �ƻ�ԭʼid,
                    n.original_node_id   AS �ڵ�ԭʼid,
                    n.PLAN_ID as �ƻ�id,
                    2  as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.PREDICT_END_DATE as �ڵ�Ԥ���������,
                    ''������Ŀ'' AS     ������Ŀ,
                    ''ר��ƻ�'' AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    ''ר��ƻ���'' AS �ڵ�ȼ�,
                    0 AS ��׼��ֵ
                FROM POM_SPECIAL_PLAN_NODE n
                ---�����ƻ�
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---����˵ļƻ�
                WHERE p.APPROVAL_STATUS=''�����'' AND (n.IS_DELETE=0 or n.is_DELETE is null) ';
special_noed_sql:='                
                SELECT
                    n.ID  AS �ڵ�id,
                    p.ORIGINAL_PLAN_ID  as �ƻ�ԭʼid,
                    n.ORIGINAL_NODE_ID  AS �ڵ�ԭʼid,
                    n.PROJ_PLAN_ID as �ƻ�id,
                    (CASE p.PLAN_TYPE WHEN ''�ؼ��ڵ�ƻ�'' THEN 0 WHEN ''��Ŀ����ƻ�'' THEN 1 END) as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.ESTIMATE_END_DATE as �ڵ�Ԥ���������,
                    p.PROJ_NAME AS     ������Ŀ,
                    p.PLAN_TYPE AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    n.NODE_LEVEL AS �ڵ�ȼ�,
                    n.STANDARD_SCORE  AS ��׼��ֵ
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and p.APPROVAL_STATUS=''�����''
                    AND (n.IS_DELETE=0 or n.is_DELETE is null)  ';
-----   ����˾��������                 
join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on �����Ŷ�Ӧ��˾id=orgid
            where 1=1 and tal.orgid is not null
            --- like����
           ' ||v_where_like_sql||'';
END P_POM_SMART_MY_CURRENT_SQL;

/
