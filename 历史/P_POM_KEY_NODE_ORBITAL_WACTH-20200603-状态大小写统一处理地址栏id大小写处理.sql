create or replace type VARCHAR2_LIST as varray(100) of varchar2(36);
/
create or replace PROCEDURE "P_POM_KEY_NODE_ORBITAL_WACTH"
(
		PROJECTID       IN VARCHAR2
	 ,PROJECTPERIODID IN VARCHAR2
	 ,PLANTYPE        IN VARCHAR2_LIST
	 ,DESCRIPTION     OUT VARCHAR2
	 ,STATES          OUT SYS_REFCURSOR
	 ,ORBITALNODE     OUT SYS_REFCURSOR
) AS
		--关键节点计划监控-轨道图
		--作者：陈丽
		--日期：2019/11/13

		V_SQL CLOB := ''; --拼接SQL字符串
		/*    V_CON    NUMBER(2, 0);*/
		V_PROJECTID VARCHAR2(36);
		V_FLAG      VARCHAR2(10);
		V_PERIODID  VARCHAR2(36);

BEGIN
		OPEN STATES FOR
				SELECT '按时完成' AS "stateDescription", '#60955a' AS "stateColor", 'punctualityComplete' AS "state"
				FROM   DUAL
				UNION ALL
				SELECT '超期5天内完成' AS "stateDescription", '#ff9933' AS "stateColor", 'beyondComplete' AS "state"
				FROM   DUAL
				UNION ALL
				SELECT '超期5天' AS "stateDescription", '#f00' AS "stateColor", 'beyonduncomplete' AS "state"
				FROM   DUAL
				UNION ALL
				SELECT '未开始' AS "stateDescription", '#ccc' AS "stateColor", 'uncomplete' AS "state"
				FROM   DUAL;

		/*  OPEN ORBITALNODE FOR
    SELECT CASE
             WHEN PLAN_END_DATE < SYSDATE THEN
              'punctualityComplete'
             WHEN PLAN_END_DATE > SYSDATE THEN
              'beyondComplete'
             ELSE
              'uncomplete'
           END AS "nodeState", NODE_NAME AS "nodeName",
           NODE_CODE AS "nodeContent",
           PLAN_END_DATE || '<br/>' || PLAN_END_DATE AS "nodeTime",
           '计划完成日期' || PLAN_END_DATE || '<br/>实际完成日期' || ACTUAL_END_DATE ||
            '<br/>相差天数0' AS "nodeDescription",
           '/basic-settings/standard-node/standard-node?action=Create' "nodeUrl"
    FROM   POM_PROJ_PLAN_NODE;*/

		/*
        遍历PLANTYPE数组
    */
		SELECT P.FLAG INTO V_FLAG FROM (SELECT '项目' AS FLAG FROM SYS_PROJECT_STAGE A WHERE A.PROJECT_ID = PROJECTPERIODID UNION ALL SELECT DISTINCT '分期' FROM SYS_PROJECT_STAGE B WHERE B.ID = PROJECTPERIODID) P;

		IF V_FLAG = '项目' THEN
				SELECT Q.ID
				INTO   V_PERIODID
				FROM   MDM_PROJECT P
				INNER  JOIN MDM_PERIOD_VERSION O
				ON     O.PROJECT_ORIGINAL_ID = P.PROJECT_ORIGINAL_ID AND
							 O.APPROVAL_STATUS = '已审核' AND
							 O.PERIOD_VERSION = (SELECT MAX(PERIOD_VERSION)
																	 FROM   MDM_PERIOD_VERSION
																	 WHERE  PROJECT_ORIGINAL_ID = O.PROJECT_ORIGINAL_ID AND
																					APPROVAL_STATUS = '已审核'
																	 GROUP  BY PROJECT_ORIGINAL_ID)
				INNER  JOIN MDM_PERIOD Q
				ON     O.ID = Q.PERIOD_VERSION_ID
				WHERE  P.PROJECT_ORIGINAL_ID = PROJECTPERIODID AND p.APPROVAL_STATUS = '已审核';
		
		ELSIF V_FLAG = '分期' THEN
				V_PERIODID := PROJECTPERIODID;
		END IF;

		IF V_FLAG = '项目' THEN
		
				V_PROJECTID := PROJECTPERIODID;
		
		ELSIF V_FLAG = '分期' THEN
				SELECT B.PROJECT_ORIGINAL_ID
				INTO   V_PROJECTID
				FROM   MDM_PERIOD A
				INNER  JOIN MDM_PERIOD_VERSION B
				ON     A.PERIOD_VERSION_ID = B.ID AND
							 B.PERIOD_VERSION = (SELECT MAX(PERIOD_VERSION)
																	 FROM   MDM_PERIOD_VERSION
																	 WHERE  PROJECT_ORIGINAL_ID = B.PROJECT_ORIGINAL_ID AND
																					APPROVAL_STATUS = '已审核'
																	 GROUP  BY PROJECT_ORIGINAL_ID)
				WHERE  A.ID = PROJECTPERIODID AND
							 B.APPROVAL_STATUS = '已审核';
		END IF;

		FOR I IN 1 .. PLANTYPE.COUNT
		LOOP
				IF PLANTYPE(I) = '可研计划' THEN
						V_SQL := V_SQL || '
SELECT CASE
					 WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
						(CASE
								WHEN B.ACTUAL_END_DATE - B.PLAN_END_DATE > 5 THEN
								 ''beyonduncomplete''
								 WHEN  B.ACTUAL_END_DATE - B.PLAN_END_DATE <= 5 and B.ACTUAL_END_DATE - B.PLAN_END_DATE > 0 THEN
								 ''beyondComplete''
								ELSE
								 ''punctualityComplete''
						END)
					 WHEN B.ACTUAL_END_DATE IS NULL THEN
						(CASE
								WHEN SYSDATE - B.PLAN_END_DATE > 5 THEN
								 ''beyonduncomplete''
								ELSE
								 ''uncomplete''
						END)
			 END AS "nodeState", B.NODE_NAME AS "nodeName",
			 B.NODE_CODE AS "nodeContent",
			 ''<div style="
    color: #696969;
">计划完成日期''||''    ''||TO_CHAR(B.PLAN_END_DATE,''YYYY-MM-DD'') || ''<br/>'' ||''实际完成日期''||''    ''||TO_CHAR(NVL(B.ACTUAL_END_DATE, ''''),''YYYY-MM-DD'')|| ''<br/>'' || NVL(''审核完成日期''||''    ''||TO_CHAR(nvl(C.APPROVAL_TIME,B.ACTUAL_END_DATE),''YYYY-MM-DD''), '''')||''</div>'' AS "nodeTime",
			 ''计划完成日期'' ||TO_CHAR( NVL(B.PLAN_END_DATE, SYSDATE),''YYYY-MM-DD'') || ''<br/>实际完成日期'' ||
				NVL(B.ACTUAL_END_DATE, '''') || ''<br/>相差天数'' ||
				NVL(TO_DATE(B.PLAN_END_DATE) - TO_DATE(B.ACTUAL_END_DATE), '''') AS "nodeDescription",
			 ''/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0''||CHR(38)||''id='' || A.ID ||
				CHR(38) || ''feedbackNodeid=''||B.ID||CHR(38)||''feedbackNodeOriginalId=''||B.ORIGINAL_NODE_ID||CHR(38)||''nodeSourcePlanType=0''  AS "nodeUrl", B.ID AS "nodeId",
			 B.ORIGINAL_NODE_ID AS "originalNodeId"
				FROM   POM_PROJ_PLAN A, POM_PROJ_PLAN_NODE B
				WHERE  A.ID = B.PROJ_PLAN_ID AND B.FISSION_SOURCE_ORIGINAL_ID IS NULL AND
							 A.PROJ_ID = ''' || PROJECTID || '''AND
							 A.PLAN_TYPE = ''' || PLANTYPE(I) || ''' UNION ALL ';
				ELSE
						V_SQL := V_SQL || 'SELECT CASE
					 WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
						(CASE
								WHEN B.ACTUAL_END_DATE - B.PLAN_END_DATE > 5 THEN
								 ''beyonduncomplete''
								 WHEN  B.ACTUAL_END_DATE - B.PLAN_END_DATE <= 5 and B.ACTUAL_END_DATE - B.PLAN_END_DATE > 0 THEN
								 ''beyondComplete''
								ELSE
								 ''punctualityComplete''
						END)
					 WHEN B.ACTUAL_END_DATE IS NULL THEN
						(CASE
								WHEN SYSDATE - B.PLAN_END_DATE > 5 THEN
								 ''beyonduncomplete''
								 WHEN SYSDATE - B.PLAN_END_DATE <= 5 and SYSDATE - B.PLAN_END_DATE >0  THEN
								 ''beyondComplete''
								ELSE
								 ''uncomplete''
						END)
			 END AS "nodeState", B.NODE_NAME AS "nodeName",
			 B.NODE_CODE AS "nodeContent",
			 ''<div style="
    color: #696969;
">计划完成日期''||''    ''||TO_CHAR(B.PLAN_END_DATE,''YYYY-MM-DD'') || ''<br/>'' || NVL(''实际完成日期''||''    ''||TO_CHAR(B.ACTUAL_END_DATE,''YYYY-MM-DD''), '''')|| ''<br/>'' || NVL(''审核完成日期''||''    ''||TO_CHAR(nvl(C.APPROVAL_TIME,B.ACTUAL_END_DATE),''YYYY-MM-DD''), '''')||''</div>'' AS "nodeTime",
			 ''计划完成日期'' || to_char(NVL(B.PLAN_END_DATE, SYSDATE),''yyyy-mm-dd'') || ''<br/>实际完成日期'' ||
				to_char(NVL(B.ACTUAL_END_DATE, ''''),''yyyy-mm-dd'') || ''<br/>相差天数'' ||
				NVL(TO_DATE(B.PLAN_END_DATE) - TO_DATE(B.ACTUAL_END_DATE), '''') AS "nodeDescription",
			 ''/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0''||CHR(38)||''id='' || A.ID ||
				CHR(38) || ''feedbackNodeId=''||B.ID||CHR(38)||''feedbackNodeOriginalId=''||B.ORIGINAL_NODE_ID||CHR(38)||''nodeSourcePlanType=0'' AS "nodeUrl", B.ID AS "nodeId",
			 B.ORIGINAL_NODE_ID AS "originalNodeId"
				FROM   POM_PROJ_PLAN A
				INNER JOIN POM_PROJ_PLAN_NODE B ON A.ID = B.PROJ_PLAN_ID 
				LEFT JOIN POM_NODE_FEEDBACK c ON b.ID = c.FEEDBACK_NODE_ID AND c.FEEDBACK_TYPE = ''CARRY_OUT'' AND c.APPROVAL_STATUS = ''已审核''
        WHERE  b.is_disable = 0 and 
							 A.PROJ_ID = ''' || V_PERIODID || '''AND B.FISSION_SOURCE_ORIGINAL_ID IS NULL AND
							 A.PLAN_TYPE = ''' || PLANTYPE(I) || ''' UNION ALL ';
				END IF;
		END LOOP;

		V_SQL := RTRIM(V_SQL, 'UNION ALL') || ' ORDER BY 3';

		DBMS_OUTPUT.PUT_LINE(V_SQL);

		OPEN ORBITALNODE FOR V_SQL;

		DESCRIPTION := '';
END P_POM_KEY_NODE_ORBITAL_WACTH;