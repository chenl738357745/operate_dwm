--------------------------------------------------------
--  文件已创建 - 星期日-四月-18-2021   
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
) AS --关键节点计划监控-当前延误节点
		--作者：陈丽
		--日期：2019/11/13
BEGIN

		IF DATASCOPE = 'thisMonth' THEN
				OPEN CURRENTDELAY FOR
						SELECT DISTINCT A.ORG_NAME AS "orgName",
														B2.PROJECTSTAGE_NAME AS "projName",
														B2.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(B2.COMPANY_ID, '003200000000000000000000000000') ||
														 '&ppid=' || B2.PPID || '&planType=关键节点计划' AS "projOpenUrl",
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
																		 WHERE  A.PLAN_TYPE = '关键节点计划' AND
																						A.APPROVAL_STATUS = '已审核' 	AND
																						A1.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND   
																						TRUNC(SYSDATE, 'dd') -TRUNC(PLAN_END_DATE, 'dd') > 0 AND
																						ACTUAL_END_DATE IS NULL) B
												 ON     A.ID = B.UNIT_ID
												 WHERE  ORG_TYPE = 0
												 START  WITH ID = '' || ORGID || ''
												 CONNECT BY PRIOR A.ID = A.PARENT_ID) B2
						ON     A.ID = B2.ID
						WHERE  NODE_NAME IS NOT NULL AND
									 ACTUAL_END_DATE IS NULL AND
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --分期
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
													 A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000001') ||
														 '&ppid=' || a.PROJ_ID || '&planType=关键节点计划' AS "projOpenUrl",
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
						WHERE  A.PLAN_TYPE = '关键节点计划' AND
									 A.APPROVAL_STATUS = '已审核'   AND
							A1.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')   AND
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
														 '&ppid=' || B2.PPID || '&planType=关键节点计划' AS "projOpenUrl",
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
																		 WHERE  A.PLAN_TYPE = '关键节点计划' AND
																						A.APPROVAL_STATUS = '已审核' --判断季度
																					 --判断季度
																					 
																						AND
																					A1.PLAN_END_DATE BETWEEN
																		 TO_DATE( 			(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')  AND
 TO_DATE((	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')
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
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --分期
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
														 A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000000') ||
														 '&ppid=' || C1.ID || '&planType=关键节点计划' AS "projOpenUrl",
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
						WHERE  A.PLAN_TYPE = '关键节点计划' AND
									 A.APPROVAL_STATUS = '已审核' --判断季度
									
									 AND
									 A1.PLAN_END_DATE  BETWEEN
																										 TO_DATE( 			(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD')  AND
 TO_DATE((	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A),'YYYY-MM-DD') AND
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
														 '&ppid=' || B2.PPID || '&planType=关键节点计划' AS "projOpenUrl",
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
																		 WHERE  A.PLAN_TYPE = '关键节点计划' AND
																						A.APPROVAL_STATUS = '已审核' AND
																						PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)  AND
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
									 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --分期
						UNION ALL
						SELECT DISTINCT '' AS "orgName",
														A.PROJ_NAME AS "projName",
														A1.NODE_NAME AS "nodeName",
														'/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
														 NVL(A.COMPANY_ID,
																 '003200000000000000000000000000') ||
														 '&ppid=' || C1.ID || '&planType=关键节点计划' AS "projOpenUrl",
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
						WHERE  A.PLAN_TYPE = '关键节点计划' AND
									 A.APPROVAL_STATUS = '已审核' AND
									PLAN_END_DATE  BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
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
    ---特殊条件
    companyid IN VARCHAR2,--条件本公司为，公司id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
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
    ---输出
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
-----传入组织下所有部门
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on 主责部门id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门对应公司id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_COMPANY;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_DEPT" (
    ---特殊条件
    deptid IN VARCHAR2,--条件本部门，部门id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
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
    ---输出
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
-----传入组织下所有部门
where_auth_sql:=case when deptid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||deptid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on 主责部门id=wh.orgid' else '' end;

where_auth_c_sql:=case when deptid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_DEPT;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PROJ" (
    ---特殊条件
    companyid IN VARCHAR2,--条件本部门，部门id
    orgid IN VARCHAR2,--条件本公司，部门id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
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
    ---输出
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
-----传入组织下所有部门
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on 主责部门id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
    --orgtype IN VARCHAR2, --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,,本人
    condition IN VARCHAR2, --输入变量：公司id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
--本公司负责任务-tabs
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417
         
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => condition,
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;

END P_POM_SMART_CURRENTCOMPANY_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --输入变量：部门id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR) IS --任务中心tabs任务条数统计数据源
--作者：本部门tab统计
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417
         
P_POM_SMART_CURRENT_DEPT(
     DEPTID => condition,
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
    --orgtype IN VARCHAR2, --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,,本人
    condition IN VARCHAR2, --输入变量：项目id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
    --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07
    v_spid              VARCHAR2(200);
BEGIN
    --调用数据权限验证存储过程
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
												node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
												WHEN f.id IS NOT NULL
												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
												AND f.APPROVAL_STATUS = '未审核' THEN
													node.NODE_NAME || '【完成反馈未发起】'
													WHEN f.id IS NOT NULL
													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
													AND f.APPROVAL_STATUS = '审核中' THEN
														node.NODE_NAME || '【完成反馈审核中】'
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE = 'CARRY_OUT'
														AND f.APPROVAL_STATUS = '已审核' THEN
															node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
									WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '项目主项计划' OR plan.PLAN_TYPE = '关键节点计划' OR plan.PLAN_TYPE = '专项计划')
										AND plan.APPROVAL_STATUS = '已审核'
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
											-- 本月任务
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
															node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																node.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	node.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
													AND p.APPROVAL_STATUS = '已审核'
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
											-- 超期未完成任务
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
															node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																node.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	node.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
													AND p.APPROVAL_STATUS = '已审核'
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
											-- 所有未完成任务
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
															node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																node.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	node.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
													AND p.APPROVAL_STATUS = '已审核'
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
											-- 所有已完成任务
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
															node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																node.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	node.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
													AND p.APPROVAL_STATUS = '已审核'
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
											-- 所有任务
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
															node.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																node.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	node.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		node.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
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
													AND p.APPROVAL_STATUS = '已审核'
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

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" ( condition IN VARCHAR2, --输入变量：当前用户ID
		searchcondition IN VARCHAR2, --模糊查询条件
	item OUT SYS_REFCURSOR ) IS --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07
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
						WHEN '关键节点计划' THEN
						0
						WHEN '项目主项计划' THEN
						1
					END AS PLAN_TYPE_INT,
				CASE

						WHEN f.id IS NULL THEN
						n.NODE_NAME
						WHEN f.id IS NOT NULL
						AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
							n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
							WHEN f.id IS NOT NULL
							AND f.FEEDBACK_TYPE = 'CARRY_OUT'
							AND f.APPROVAL_STATUS = '未审核' THEN
								n.NODE_NAME || '【完成反馈未发起】'
								WHEN f.id IS NOT NULL
								AND f.FEEDBACK_TYPE = 'CARRY_OUT'
								AND f.APPROVAL_STATUS = '审核中' THEN
									n.NODE_NAME || '【完成反馈审核中】'
									WHEN f.id IS NOT NULL
									AND f.FEEDBACK_TYPE = 'CARRY_OUT'
									AND f.APPROVAL_STATUS = '已审核' THEN
										n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
									END AS NODE_NAME,
									p.PLAN_NAME,--计划名称
									n.PLAN_START_DATE,
									n.PLAN_END_DATE,
									n.ACTUAL_END_DATE,
									n.ESTIMATE_END_DATE,--预计完成时间
									p.PROJ_NAME,--所属项目
									p.PLAN_TYPE,--计划类型显示名
									n.DUTY_DEPARTMENT,--主责部门
									person.CHARGE_PERSON,
									n.NODE_LEVEL,--任务等级
									n.STANDARD_SCORE --标准分值

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
									( p.PLAN_TYPE = '项目主项计划' OR p.PLAN_TYPE = '关键节点计划' )
									AND n.IS_DISABLE = 0
									AND p.APPROVAL_STATUS = '已审核'
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
											n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
											WHEN f.id IS NOT NULL
											AND f.FEEDBACK_TYPE = 'CARRY_OUT'
											AND f.APPROVAL_STATUS = '未审核' THEN
												n.NODE_NAME || '【完成反馈未发起】'
												WHEN f.id IS NOT NULL
												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
												AND f.APPROVAL_STATUS = '审核中' THEN
													n.NODE_NAME || '【完成反馈审核中】'
													WHEN f.id IS NOT NULL
													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
													AND f.APPROVAL_STATUS = '已审核' THEN
														n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
													END AS NODE_NAME,
													p.PLAN_NAME,--计划名称
													n.PLAN_START_DATE,
													n.PLAN_END_DATE,
													n.ACTUAL_END_DATE,
													n.PREDICT_END_DATE,
													'所属项目' AS E,
													'专项计划' AS F,
													n.DUTY_DEPARTMENT,
													person.CHARGE_PERSON,
													'专项计划级' AS M,
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
													AND p.APPROVAL_STATUS = '已审核'
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
														WHEN '关键节点计划' THEN
														0
														WHEN '项目主项计划' THEN
														1
													END AS PLAN_TYPE_INT,
												CASE

														WHEN f.id IS NULL THEN
														n.NODE_NAME
														WHEN f.id IS NOT NULL
														AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
															n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
															WHEN f.id IS NOT NULL
															AND f.FEEDBACK_TYPE = 'CARRY_OUT'
															AND f.APPROVAL_STATUS = '未审核' THEN
																n.NODE_NAME || '【完成反馈未发起】'
																WHEN f.id IS NOT NULL
																AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																AND f.APPROVAL_STATUS = '审核中' THEN
																	n.NODE_NAME || '【完成反馈审核中】'
																	WHEN f.id IS NOT NULL
																	AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																	AND f.APPROVAL_STATUS = '已审核' THEN
																		n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
																	END AS NODE_NAME,
																	p.PLAN_NAME,--计划名称
																	n.PLAN_START_DATE,
																	n.PLAN_END_DATE,
																	n.ACTUAL_END_DATE,
																	n.ESTIMATE_END_DATE,--预计完成时间
																	p.PROJ_NAME,--所属项目
																	p.PLAN_TYPE,--计划类型显示名
																	n.DUTY_DEPARTMENT,--主责部门
																	person.CHARGE_PERSON,
																	n.NODE_LEVEL,--任务等级
																	n.STANDARD_SCORE --标准分值

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
																	( p.PLAN_TYPE = '项目主项计划' OR p.PLAN_TYPE = '关键节点计划' )
																	AND n.IS_DISABLE = 0
																	AND p.APPROVAL_STATUS = '已审核'
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
																			n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
																			WHEN f.id IS NOT NULL
																			AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																			AND f.APPROVAL_STATUS = '未审核' THEN
																				n.NODE_NAME || '【完成反馈未发起】'
																				WHEN f.id IS NOT NULL
																				AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																				AND f.APPROVAL_STATUS = '审核中' THEN
																					n.NODE_NAME || '【完成反馈审核中】'
																					WHEN f.id IS NOT NULL
																					AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																					AND f.APPROVAL_STATUS = '已审核' THEN
																						n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
																					END AS NODE_NAME,
																					p.PLAN_NAME,--计划名称
																					n.PLAN_START_DATE,
																					n.PLAN_END_DATE,
																					n.ACTUAL_END_DATE,
																					n.PREDICT_END_DATE,
																					'所属项目' AS E,
																					'专项计划' AS F,
																					n.DUTY_DEPARTMENT,
																					person.CHARGE_PERSON,
																					'专项计划级' AS M,
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
																					AND p.APPROVAL_STATUS = '已审核'
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
																						WHEN '关键节点计划' THEN
																						0
																						WHEN '项目主项计划' THEN
																						1
																					END AS PLAN_TYPE_INT,
																				CASE

																						WHEN f.id IS NULL THEN
																						n.NODE_NAME
																						WHEN f.id IS NOT NULL
																						AND f.FEEDBACK_TYPE <> 'CARRY_OUT' THEN
																							n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
																							WHEN f.id IS NOT NULL
																							AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																							AND f.APPROVAL_STATUS = '未审核' THEN
																								n.NODE_NAME || '【完成反馈未发起】'
																								WHEN f.id IS NOT NULL
																								AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																								AND f.APPROVAL_STATUS = '审核中' THEN
																									n.NODE_NAME || '【完成反馈审核中】'
																									WHEN f.id IS NOT NULL
																									AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																									AND f.APPROVAL_STATUS = '已审核' THEN
																										n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
																									END AS NODE_NAME,
																									p.PLAN_NAME,--计划名称
																									n.PLAN_START_DATE,
																									n.PLAN_END_DATE,
																									n.ACTUAL_END_DATE,
																									n.ESTIMATE_END_DATE,--预计完成时间
																									p.PROJ_NAME,--所属项目
																									p.PLAN_TYPE,--计划类型显示名
																									n.DUTY_DEPARTMENT,--主责部门
																									person.CHARGE_PERSON,
																									n.NODE_LEVEL,--任务等级
																									n.STANDARD_SCORE --标准分值

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
																									( p.PLAN_TYPE = '项目主项计划' OR p.PLAN_TYPE = '关键节点计划' )
																									AND n.IS_DISABLE = 0
																									AND p.APPROVAL_STATUS = '已审核'
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
																											n.NODE_NAME || '【预计完成日期:' || to_char( f.ESTIMATE_END_TIME, 'yyyy-MM-dd' ) || '】'
																											WHEN f.id IS NOT NULL
																											AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																											AND f.APPROVAL_STATUS = '未审核' THEN
																												n.NODE_NAME || '【完成反馈未发起】'
																												WHEN f.id IS NOT NULL
																												AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																												AND f.APPROVAL_STATUS = '审核中' THEN
																													n.NODE_NAME || '【完成反馈审核中】'
																													WHEN f.id IS NOT NULL
																													AND f.FEEDBACK_TYPE = 'CARRY_OUT'
																													AND f.APPROVAL_STATUS = '已审核' THEN
																														n.NODE_NAME || '【实际完成日期:' || to_char( f.ACTUAL_END_TIME, 'yyyy-MM-dd' ) || '】'
																													END AS NODE_NAME,
																													p.PLAN_NAME,--计划名称
																													n.PLAN_START_DATE,
																													n.PLAN_END_DATE,
																													n.ACTUAL_END_DATE,
																													n.PREDICT_END_DATE,
																													'所属项目' AS E,
																													'专项计划' AS F,
																													n.DUTY_DEPARTMENT,
																													person.CHARGE_PERSON,
																													'专项计划级' AS M,
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
																													AND p.APPROVAL_STATUS = '已审核'
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
) AS --关键节点计划监控-当前延误节点
        --作者：陈丽
        --日期：2019/11/13
BEGIN
    title := '当前延误节点';
    --图标库地址 https://element.eleme.cn/#/zh-CN/component/icon
    titleicon := 'el-icon-tickets';
     
																		 
                OPEN CURRENTDELAY FOR
                        SELECT DISTINCT A.ORG_NAME AS "orgName",
                                                        B2.PROJECTSTAGE_NAME AS "projName",
                                                        B2.NODE_NAME|| CASE WHEN ESTIMATE_END_DATE IS NOT NULL THEN   '(预计完成日期：'||TO_CHAR(ESTIMATE_END_DATE,'YYYY-MM-DD ')||')'END  AS "nodeName",
                                                        NODE_ID as "nodeId",
                                                        ORIGINAL_NODE_ID as "nodeOriginId",
                                                        '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
                                                         NVL(B2.COMPANY_ID, '003200000000000000000000000000') ||
                                                         '&ppid=' || B2.PPID || '&planType=关键节点计划' AS "projOpenUrl",
                                                        '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id=' ||
                                                         B2.PLANID || '&feedbackNodeId=' || NODE_ID ||
                                                         '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID ||
                                                         '&nodeSourcePlanType=0' AS "nodeOpenUrl",
                                                          '<span class="right"> 已延误 <span style="display: inline-block;
                                                                width: 40px;
                                                                text-align: center;
                                                                border-radius: 4px;
                                                                margin: 0 4px;
                                                                background-color: rgb(248, 94, 90);
                                                                color: #fff;
                                                                font-weight: 700;">'
                                                                ||TO_CHAR(TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd'))
                                                                ||'</span> 天 </span>'             AS "delayDays"
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
                                                                                        case when  STAGE_NAME like '%无分期%' then  B1.ID else A.PROJ_ID end   AS PPID,--20200427李小聪调整勿修改
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
                                                                         WHERE  A.PLAN_TYPE = '关键节点计划' AND

                                                                                        A.APPROVAL_STATUS = '已审核'
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
																		 --分期
                        UNION ALL
                        SELECT DISTINCT '' AS "orgName",
                                                     A.PROJ_NAME AS "projName",
                                                        A1.NODE_NAME|| CASE WHEN ESTIMATE_END_DATE IS NOT NULL THEN   '(预计完成日期：'||TO_CHAR(ESTIMATE_END_DATE,'YYYY-MM-DD ')||')'END  AS "nodeName",
                                                         A1.ID as "nodeId",
                                                        A1.ORIGINAL_NODE_ID as "nodeOriginId",
                                                        '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||
                                                         NVL(A.COMPANY_ID,
                                                                 '003200000000000000000000000001') ||
                                                         '&ppid=' || C1.ID || '&planType=关键节点计划' AS "projOpenUrl",
                                                        '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id=' || A.ID ||
                                                         '&feedbackNodeId=' || A1.ID ||
                                                         '&feedbackNodeOriginalId=' ||
                                                         A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
                                                          '<span class="right"> 已延误 <span style="display: inline-block;
                                                                width: 40px;
                                                                text-align: center;
                                                                border-radius: 4px;
                                                                margin: 0 4px;
                                                                background-color: rgb(248, 94, 90);
                                                                color: #fff;
                                                                font-weight: 700;">'
                                                                ||TO_CHAR(TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd'))
                                                                ||'</span> 天 </span>'             AS "delayDays"
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
                        WHERE  A.PLAN_TYPE = '关键节点计划' AND
                                     A.APPROVAL_STATUS = '已审核'
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
    ---特殊条件
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql       OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql  OUT   CLOB,
    ---关联反馈脚本 
    fb_sql     OUT   CLOB,
    ---关联权限脚本 
    auth_data_sql    OUT   CLOB,
    ---关注脚本
    watch_sql   OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
  ---数据权限验证spid
    v_spid              VARCHAR2(200);
BEGIN
     ------------------------------------------20210417
    ------数据权限，有权限的部门和项目
    ------关键节点计划、项目主项计划、专项计划
    ------本月任务、超期未完成任务、所有未完成任务、所有已完成任务、所有任务、次月任务、本季度任务、本年任务
--------------------------------------------------------------------------------------------------------字段使用-------------------------------------------------------------------------------------20210417
--1.亮灯规则条件解析---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、plan_type、node_level
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---根据节点类型和计划类型分组取，取最近的一条规则
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---拼接字符串
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --规则大于0拼接完整的case when 语句
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
        ELSE
            --无规则亮灯显示空
            light_up_plan_expression_sql := '''''';
        END IF;
--1.亮灯规则条件解析---完成----------------------------------------------------------------------------------------------20210417
--5.NODE_NAME拼接完成日期和状态---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：反馈id、节点name、反馈类型、反馈预计完成日期、反馈实际完成日期、反馈状态
node_name_filed_sql:='( CASE
                        WHEN 反馈id IS NULL THEN 节点名称
                        WHEN 反馈id IS NOT NULL AND 反馈类型 <> ''CARRY_OUT''
                            THEN 节点名称||''【预计完成日期:''||to_char(反馈预计完成日期,''yyyy-MM-dd'')||''】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''未审核''
                            THEN 节点名称||''【完成反馈未发起】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''审核中''
                            THEN 节点名称||''【完成反馈审核中】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''已审核''
                            THEN 节点名称||''【实际完成日期:''||to_char(反馈实际完成日期,''yyyy-MM-dd'')||''】''
                    END) ';
--5.NODE_NAME拼接完成日期和状态---完成----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id,是否取关,节点实际完成日期
--------提供WACTH、HASTEN、W_Url
watch_filed_sql:='是否取关 as IS_UN_WATCH 
                   ,(case when 是否取关=0 then ''取关'' else ''关注'' end) as WACTH
                   ,(case when 节点实际完成日期 is null then ''催办'' else null end) as HASTEN
                   ,(case when 是否取关=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||节点原始id
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||节点原始id end) as W_Url';
--------------------------------------------------------------------------------------------------------字段使用-------------------------------------------------------------------------------------20210417

--2.权限获取---开始----------------------------------------------------------------------------------------------20210417
     --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
--2.权限获取---完成----------------------------------------------------------------------------------------------20210417
--3.tab条件---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、ACTUAL_END_DATE
 IF currenttype = '本月任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'')
                       and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            tab_where_sql := ' and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有未完成任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            tab_where_sql := ' ';
        ELSIF currenttype = '次月任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_sql := ' and 1=2';
        END IF;


-------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND (节点计划完成日期 >= trunc(SYSDATE, ''month'') AND 节点计划完成日期 <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(节点计划完成日期, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= last_day( trunc( SYSDATE ) ) + 1
								AND 节点计划完成日期 <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (节点计划完成日期>= trunc( SYSDATE, ''Q'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= trunc( SYSDATE, ''yyyy'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--3.tab条件---完成----------------------------------------------------------------------------------------------20210417 
--4.关键字条件---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：NODE_NAME、PLAN_NAME、PROJ_NAME、DUTY_DEPARTMENT、charge_person
-----当输入关键字不为空时
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.节点名称,'''||searchcondition||''')>0 OR instr(node.计划名称,'''||searchcondition||''')>0
              OR instr(node.所属项目,'''||searchcondition||''')>0 OR instr(node.主责部门,'''||searchcondition||''')>0
              OR instr(主责人,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.关键字条件---完成----------------------------------------------------------------------------------------------20210417   


--6.关联主责人---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点id
node_Principal_sql:='                  
                           SELECT node_id as 主责人节点id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS 主责人
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.关联主责人---完成----------------------------------------------------------------------------------------------20210417  
--7.关联反馈---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as 反馈id,a.feedback_node_id as 反馈节点id,a.feedback_node_original_id as 反馈节点原始id
                            ,a.approval_status as 反馈审核状态,a.actual_end_time as 反馈实际完成日期,ESTIMATE_END_TIME as 反馈预计完成日期
                            ,feedback_type as 反馈类型
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.关联反馈---完成----------------------------------------------------------------------------------------------20210417  
--8.关联权限---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：部门id、项目id
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.关联权限---完成----------------------------------------------------------------------------------------------20210417

--9.业务关注---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：节点原始id
watch_sql:='(
            SELECT biz_id as 关注业务id,watcher_id as 关注人,is_un_watch as 是否取关 FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.业务关注---完成----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------内容
proj_noed_sql:=' SELECT
                    n.ID   AS 节点id,
                    p.id as 计划原始id,
                    n.original_node_id   AS 节点原始id,
                    n.PLAN_ID as 计划id,
                    2  as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.PREDICT_END_DATE as 节点预计完成日期,
                    ''所属项目'' AS     所属项目,
                    ''专项计划'' AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    ''专项计划级'' AS 节点等级,
                    0 AS 标准分值
                FROM POM_SPECIAL_PLAN_NODE n
                ---关联计划
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---已审核的计划
                WHERE p.APPROVAL_STATUS=''已审核'' AND (n.IS_DELETE=0 or n.is_DELETE is null) ';
special_noed_sql:='                
                SELECT
                    n.ID  AS 节点id,
                    p.ORIGINAL_PLAN_ID  as 计划原始id,
                    n.ORIGINAL_NODE_ID  AS 节点原始id,
                    n.PROJ_PLAN_ID as 计划id,
                    (CASE p.PLAN_TYPE WHEN ''关键节点计划'' THEN 0 WHEN ''项目主项计划'' THEN 1 END) as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.ESTIMATE_END_DATE as 节点预计完成日期,
                    p.PROJ_NAME AS     所属项目,
                    p.PLAN_TYPE AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    n.NODE_LEVEL AS 节点等级,
                    n.STANDARD_SCORE  AS 标准分值
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
                    AND (n.IS_DELETE=0 or n.is_DELETE is null)  ';
-------   本公司负责任务                 
--join_where_sql:='                        
--            --- 关联人
--            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
--            --- 关联反馈
--            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
--            --- 关联关注
--            left join ('||watch_sql||')  w on 节点原始id=关注业务id
--            --- 关联权限
--            left join ('||auth_data_sql||') tal on 主责部门对应公司id=orgid
--            where 1=1 and tal.orgid is not null
--            --- like条件
--           ' ||v_where_like_sql||'';
END P_POM_SMART_MY_CURRENT_BASE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid IN VARCHAR2,--输入变量：公司id
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    pageindex IN INT,
    pagesizes IN INT,
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    items OUT SYS_REFCURSOR,
    total OUT INT
) IS
--本公司负责任务
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
    
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;
    
    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => COMPANYID,
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_company;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_DEPT" (
    userid        IN            VARCHAR,--用户id，用于过滤关注的任务
    deptid        IN            VARCHAR2,--输入变量：部门
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--    auth          OUT           SYS_REFCURSOR
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
    
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;
    
    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_DEPT(
    DEPTID => deptid,
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_dept;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PERSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PERSON" (
    userid        IN            VARCHAR2,--输入变量：用户ID
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型（所有未完成，超期未完成，所有已完成）
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --我负责的任务  关键节点计划、项目主项计划、专项计划
--作者：陈丽
--日期：2019/11/15
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
        --1.拼接查询语句
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
                            rule_type = '亮灯规则'
                      --AND plan_type != '关键节点计划'
                      AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                    AND s.node_level = vv.node_level
            WHERE
                    vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划' THEN
                    plan_expression := ''' then ('''
                        || item.expression
                        || ''') ';
                ELSE
                    plan_expression := ''' then ('
                        || item.expression
                        || ') ';
                END IF ;
                ---拼接字符串
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type
                           WHEN '项目全景计划' THEN '项目主项计划'
                           ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                || v_sql_content
                || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------内容
        IF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and sysdate>PLAN_END_DATE  and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSE
            v_where := '' ;
        END IF;
        --当输入条件不为空时
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
                            n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
                            n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
                            n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
                            n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.PREDICT_END_DATE,
                    ''所属项目'' AS E,
                    ''专项计划'' AS F,
                    n.DUTY_DEPARTMENT,
                        person.CHARGE_PERSON,
                    ''专项计划级'' AS M,
                    0 AS N
                FROM
                    POM_SPECIAL_PLAN_NODE n
                        LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A) B
                        WHERE RN = 1) f on f.feedback_node_id=n.id
                        where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''已审核''
                        AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || '';
        --专项计划已启用，但是部门月度计划还未启用、需要启用部门月度计划时，取消下面的sql即可
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
--                    ESTIMATE_END_DATE,           --预计完成时间
--                    ''无'' as PROJ_NAME,          --所属项目
--                    ''部门月度计划'' as  PLAN_TYPE,        --计划类型显示名
--                    p.DEPT_NAME,          --主责部门
--                        person.CHARGE_PERSON,
--                    node_Type,           --任务等级
--                    stand_SCORE          --标准分值
--                FROM
--                    pom_dept_monthly_plan_node n
--                    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
--                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
--                    where n.IS_DEL=0 and APPROVE_STATUS=''已审核''
--                        AND CHARGE_PERSON_ID='''||userid||'''  '
--                                      || v_where;
--3.拼接完整语句
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
    case when ACTUAL_END_DATE is null then ''未完成''
    else ''已完成'' end as COMPLETION_STATUS,
    PROJ_NAME,
    PLAN_TYPE,
    DUTY_DEPARTMENT,
    NODE_LEVEL,
		CHARGE_PERSON,
    STANDARD_SCORE ,WACTH,HASTEN,'
            || v_sql
            || ' as NODE_WARNING from (select n.*,''关注'' as WACTH,''催办'' as HASTEN from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    n.ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''关键节点计划''   THEN
            0
        WHEN ''项目主项计划''   THEN
            1
    END AS PLAN_TYPE_INT,
    CASE WHEN f.id IS NULL THEN
        n.NODE_NAME
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
        n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
        n.NODE_NAME||''【完成反馈未发起】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
        n.NODE_NAME||''【完成反馈审核中】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
        n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
    END AS NODE_NAME,
    p.PLAN_NAME,--计划名称
    n.PLAN_START_DATE,
    n.PLAN_END_DATE,

    n.ACTUAL_END_DATE,
    n.ESTIMATE_END_DATE,           --预计完成时间
    p.PROJ_NAME,          --所属项目
    p.PLAN_TYPE,        --计划类型显示名
    n.DUTY_DEPARTMENT,          --主责部门
		person.CHARGE_PERSON,
    n.NODE_LEVEL,           --任务等级
    n.STANDARD_SCORE          --标准分值
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
        FROM POM_NODE_FEEDBACK A) B
        WHERE RN = 1) f on f.feedback_node_id=n.id
		WHERE (p.PLAN_TYPE=''项目主项计划'' OR p.PLAN_TYPE=''关键节点计划'') AND n.IS_DISABLE=0  and p.APPROVAL_STATUS=''已审核''
		AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || spcil_sql
            || ')n '||v_where_like||'
   ORDER BY n.PLAN_END_DATE  ) a  ';-- left join POM_NODE_CHARGE_PERSON cp on n.id=cp.NODE_ID where CHARGE_PERSON_ID='''||userid||'''
-------------------------------------------------------------------------------------------内容
        -- dbms_output.put_line(v_sql_exec);
        v_sql_exec_paging := '
select a.* from ( '
            || v_sql_exec
            || ' where rownum <= '
            || pageindex * pagesizes
            || ' ) a where a.rowno > '
            || pagesizes * ( pageindex - 1 )
            || '';
----获取总条数
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
            OPEN items FOR SELECT '失败咯' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_person;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PROJ" (
    projid        IN            VARCHAR2,--输入变量：项目
    userid        IN 			VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,--模糊查询条件
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2019/11/15
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
    ----------------------------------------------------统一解析
    testmsg := 'projid:'
        || projid
        || '；pageindex:'
        || pageindex
        || '；pagesizes:'
        || pagesizes
        || '；currenttype:'
        || currenttype;

    BEGIN
        total := 1000;
        v_sql_start := ' case ';
        v_sql_content := '';
        v_sql_end := '  else '''' end  ';
        --调用数据权限验证存储过程
        P_AUTH_BLOCK_PROJ_COMPANY(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_SPID_ID => v_spid
            );
        --1.拼接查询语句
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                  -- AND plan_type != '关键节点计划'
                  AND s.is_disable = 0
                GROUP BY  node_level,  plan_type
            ) vv ON s.created_time = vv.t AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划'
                THEN plan_expression := ''' then (''' || item.expression || ''') ';
                ELSE plan_expression := ''' then (' || item.expression || ') ';
                END IF ;
                ---拼接字符串
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type WHEN '项目全景计划' THEN '项目主项计划' ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start || v_sql_content || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------内容
        IF currenttype = '本月任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and sysdate>n.PLAN_END_DATE and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            v_where := ' ';
        ELSIF currenttype = '次月任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1 and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;
        --当输入条件部位空时
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
                                 THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                                 THEN n.NODE_NAME||''【完成反馈未发起】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                                 THEN n.NODE_NAME||''【完成反馈审核中】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                                  THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                         END AS NODE_NAME,
                         p.PLAN_NAME,--计划名称
                         n.PLAN_START_DATE,
                         n.PLAN_END_DATE,
                         n.ACTUAL_END_DATE,
                         n.PREDICT_END_DATE,
                         ''所属项目'' AS PROJ_NAME,
                         ''专项计划'' AS PLAN_TYPE,
                         n.DUTY_DEPARTMENT,
                         ''专项计划级'' AS NODE_LEVEL,
                         0 AS STANDARD_SCORE
                         FROM POM_SPECIAL_PLAN_NODE n
                             LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                             LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                             LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                             ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                             FROM POM_NODE_FEEDBACK A) B
                             WHERE RN = 1) f on f.feedback_node_id=n.id
                             where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''已审核'' AND CHARGE_PERSON_ID='''||userid||'''  '
                    || v_where
                    || '';
        --3.拼接完整语句
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
                         case when ACTUAL_END_DATE is null then ''未完成''
                         else ''已完成'' end as COMPLETION_STATUS,
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
                    ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
                    ,case when n.ACTUAL_END_DATE is null then ''催办''
                    else null end as HASTEN
                    ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=&bizId=''||ORIGINAL_NODE_ID end as w_Url
                from(
                    SELECT
                        n.ID,
                        p.ORIGINAL_PLAN_ID,
                        n.ORIGINAL_NODE_ID,
                        n.PROJ_PLAN_ID,
                        CASE p.PLAN_TYPE
                            WHEN ''关键节点计划'' THEN 0
                            WHEN ''项目主项计划'' THEN 1
                        END AS PLAN_TYPE_INT,
                        f.id as backId,
                    CASE
                        WHEN f.id IS NULL THEN n.NODE_NAME
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                            THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                            THEN n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                            THEN n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                            THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
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
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
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
        -------------------------------------------------------------------------------------------内容
        v_sql_exec_paging :=
                    'select a.*
                     from (
                        ' || v_sql_exec || '
                where rownum <= ' || pageindex * pagesizes || '
             ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

        dbms_output.put_line(v_sql_exec_paging);
				insert into TEST(ID, PROJ_NAME, SQL_STR) values (GET_UUID(), 'CURRENT_PROJ_本项目', v_sql_exec);
        ----获取总条数
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
            || v_sql_exec
            || ') a '
            INTO total;
        OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT '失败咯' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_proj;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_SQL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_SQL" (
    companyid IN VARCHAR2,--输入变量：公司id
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
     ------------------------------------------20210417
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_expression_sql OUT   CLOB,
    
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,

    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
  ---数据权限验证spid
    v_spid              VARCHAR2(200);
     ---关键字条件
    v_where_like_sql         CLOB;
    ---关联主责人表达式
    node_Principal_sql     CLOB;
    ---关联反馈脚本 
    fb_sql     CLOB;
    ---关联权限脚本 
    auth_data_sql     CLOB;
    ---关注脚本
    watch_sql     CLOB;
BEGIN
     ------------------------------------------20210417
    ------数据权限，有权限的部门和项目
    ------关键节点计划、项目主项计划、专项计划
    ------本月任务、超期未完成任务、所有未完成任务、所有已完成任务、所有任务、次月任务、本季度任务、本年任务
--------------------------------------------------------------------------------------------------------字段使用-------------------------------------------------------------------------------------20210417
--1.亮灯规则条件解析---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、plan_type、node_level
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---根据节点类型和计划类型分组取，取最近的一条规则
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---拼接字符串
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --规则大于0拼接完整的case when 语句
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
        ELSE
            --无规则亮灯显示空
            light_up_plan_expression_sql := '''''';
        END IF;
--1.亮灯规则条件解析---完成----------------------------------------------------------------------------------------------20210417
--5.NODE_NAME拼接完成日期和状态---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：反馈id、节点name、反馈类型、反馈预计完成日期、反馈实际完成日期、反馈状态
node_name_filed_sql:='( CASE
                        WHEN 反馈id IS NULL THEN 节点名称
                        WHEN 反馈id IS NOT NULL AND 反馈类型 <> ''CARRY_OUT''
                            THEN 节点名称||''【预计完成日期:''||to_char(反馈预计完成日期,''yyyy-MM-dd'')||''】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''未审核''
                            THEN 节点名称||''【完成反馈未发起】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''审核中''
                            THEN 节点名称||''【完成反馈审核中】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''已审核''
                            THEN 节点名称||''【实际完成日期:''||to_char(反馈实际完成日期,''yyyy-MM-dd'')||''】''
                    END) ';
--5.NODE_NAME拼接完成日期和状态---完成----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id,是否取关,节点实际完成日期
--------提供WACTH、HASTEN、W_Url
watch_filed_sql:='是否取关 as IS_UN_WATCH 
                   ,(case when 是否取关=0 then ''取关'' else ''关注'' end) as WACTH
                   ,(case when 节点实际完成日期 is null then ''催办'' else null end) as HASTEN
                   ,(case when 是否取关=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||节点原始id
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||节点原始id end) as W_Url';
--------------------------------------------------------------------------------------------------------字段使用-------------------------------------------------------------------------------------20210417

--2.权限获取---开始----------------------------------------------------------------------------------------------20210417
     --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
--2.权限获取---完成----------------------------------------------------------------------------------------------20210417
--3.tab条件---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、ACTUAL_END_DATE
 IF currenttype = '本月任务' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'')
                       and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            tab_where_expression_sql := ' and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有未完成任务' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            tab_where_expression_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            tab_where_expression_sql := ' ';
        ELSIF currenttype = '次月任务' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            tab_where_expression_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_expression_sql := ' and 1=2';
        END IF;


-------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND (节点计划完成日期 >= trunc(SYSDATE, ''month'') AND 节点计划完成日期 <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(节点计划完成日期, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= last_day( trunc( SYSDATE ) ) + 1
								AND 节点计划完成日期 <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (节点计划完成日期>= trunc( SYSDATE, ''Q'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= trunc( SYSDATE, ''yyyy'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--3.tab条件---完成----------------------------------------------------------------------------------------------20210417 
--4.关键字条件---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：NODE_NAME、PLAN_NAME、PROJ_NAME、DUTY_DEPARTMENT、charge_person
-----当输入关键字不为空时
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.节点名称,'''||searchcondition||''')>0 OR instr(node.计划名称,'''||searchcondition||''')>0
              OR instr(node.所属项目,'''||searchcondition||''')>0 OR instr(node.主责部门,'''||searchcondition||''')>0
              OR instr(主责人,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.关键字条件---完成----------------------------------------------------------------------------------------------20210417   


--6.关联主责人---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点id
node_Principal_sql:='                  
                           SELECT node_id as 主责人节点id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS 主责人
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.关联主责人---完成----------------------------------------------------------------------------------------------20210417  
--7.关联反馈---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as 反馈id,a.feedback_node_id as 反馈节点id,a.feedback_node_original_id as 反馈节点原始id
                            ,a.approval_status as 反馈审核状态,a.actual_end_time as 反馈实际完成日期,ESTIMATE_END_TIME as 反馈预计完成日期
                            ,feedback_type as 反馈类型
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.关联反馈---完成----------------------------------------------------------------------------------------------20210417  
--8.关联权限---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：部门id、项目id
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.关联权限---完成----------------------------------------------------------------------------------------------20210417

--9.业务关注---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：节点原始id
watch_sql:='(
            SELECT biz_id as 关注业务id,watcher_id as 关注人,is_un_watch as 是否取关 FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.业务关注---完成----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------内容
proj_noed_sql:=' SELECT
                    n.ID   AS 节点id,
                    p.id as 计划原始id,
                    n.original_node_id   AS 节点原始id,
                    n.PLAN_ID as 计划id,
                    2  as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.PREDICT_END_DATE as 节点预计完成日期,
                    ''所属项目'' AS     所属项目,
                    ''专项计划'' AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    ''专项计划级'' AS 节点等级,
                    0 AS 标准分值
                FROM POM_SPECIAL_PLAN_NODE n
                ---关联计划
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---已审核的计划
                WHERE p.APPROVAL_STATUS=''已审核'' AND (n.IS_DELETE=0 or n.is_DELETE is null) ';
special_noed_sql:='                
                SELECT
                    n.ID  AS 节点id,
                    p.ORIGINAL_PLAN_ID  as 计划原始id,
                    n.ORIGINAL_NODE_ID  AS 节点原始id,
                    n.PROJ_PLAN_ID as 计划id,
                    (CASE p.PLAN_TYPE WHEN ''关键节点计划'' THEN 0 WHEN ''项目主项计划'' THEN 1 END) as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.ESTIMATE_END_DATE as 节点预计完成日期,
                    p.PROJ_NAME AS     所属项目,
                    p.PLAN_TYPE AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    n.NODE_LEVEL AS 节点等级,
                    n.STANDARD_SCORE  AS 标准分值
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
                    AND (n.IS_DELETE=0 or n.is_DELETE is null)  ';
-----   本公司负责任务                 
join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门对应公司id=orgid
            where 1=1 and tal.orgid is not null
            --- like条件
           ' ||v_where_like_sql||'';
END P_POM_SMART_MY_CURRENT_SQL;

/
