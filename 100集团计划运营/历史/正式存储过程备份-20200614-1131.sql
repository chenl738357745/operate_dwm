--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-14-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_POM_MSGTYPE_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_MSGTYPE_LIST" ( systemId IN VARCHAR2, msgTypeList OUT SYS_REFCURSOR, unreadCount OUT VARCHAR2 ) AS 
--�ƶ�����Ϣ�����б�
--���ߣ�Ҷ����
--���ڣ�2019/12/12
	v_COUNT NUMBER;
BEGIN
		OPEN msgTypeList FOR SELECT
		'57b55283-ce3a-4fc4-a70d-8240e66a1254' AS id,
		'������Ϣ' AS msg_type,
		(
		SELECT
			* 
		FROM
			(
			SELECT
				wechat.TITLE 
			FROM
				SYS_MSG_RECORD_BIZ biz
				LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
				LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
			WHERE
				biz.BIZ_MSG_CATEGORY = '������Ϣ' 
			AND biz.SYSTEM_ID=''||systemId||''
			ORDER BY
				biz.CREATED_TIME DESC 
			) 
		WHERE
			ROWNUM = 1 
		) AS frist_msg,
		(
		SELECT
			COUNT( * ) 
		FROM
			SYS_MSG_RECORD_BIZ biz
			LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
			LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
		WHERE
			biz.BIZ_MSG_CATEGORY = '������Ϣ' 
			AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) 
			AND biz.SYSTEM_ID=''||systemId||''
		) AS msg_type_unreadcount 
	FROM
		dual UNION ALL
	SELECT
		'58055283-ce3a-4fc4-a70d-8240e66a1254' AS id,
		'Ԥ����Ϣ' AS msg_type,
		(
		SELECT
			* 
		FROM
			(
			SELECT
				wechat.TITLE 
			FROM
				SYS_MSG_RECORD_BIZ biz
				LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
				LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
			WHERE
				biz.BIZ_MSG_CATEGORY = 'Ԥ����Ϣ' 
				AND biz.SYSTEM_ID=''||systemId||''
			ORDER BY
				biz.CREATED_TIME DESC 
			) 
		WHERE
			ROWNUM = 1 
		) AS frist_msg,
		(
		SELECT
			COUNT( * ) 
		FROM
			SYS_MSG_RECORD_BIZ biz
			LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
			LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
		WHERE
			biz.BIZ_MSG_CATEGORY = 'Ԥ����Ϣ' 
			AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) 
			AND biz.SYSTEM_ID=''||systemId||''
		) AS msg_type_unreadcount 
	FROM
		dual UNION ALL
	SELECT
		'58055283-ce3a-4fc4-a70d-8240e66a1254' AS id,
		'�߰���Ϣ' AS msg_type,
		(
		SELECT
			* 
		FROM
			(
			SELECT
				wechat.TITLE 
			FROM
				SYS_MSG_RECORD_BIZ biz
				LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
				LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
			WHERE
				biz.BIZ_MSG_CATEGORY = '�߰���Ϣ' 
				AND biz.SYSTEM_ID=''||systemId||''
			ORDER BY
				biz.CREATED_TIME DESC 
			) 
		WHERE
			ROWNUM = 1 
		) AS frist_msg,
		(
		SELECT
			COUNT( * ) 
		FROM
			SYS_MSG_RECORD_BIZ biz
			LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
			LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
		WHERE
			biz.BIZ_MSG_CATEGORY = '�߰���Ϣ' 
			AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) 
			AND biz.SYSTEM_ID=''||systemId||''
		) AS msg_type_unreadcount 
	FROM
		dual;


		SELECT
	(
	SELECT
		COUNT( * ) 
	FROM
		SYS_MSG_RECORD_BIZ biz
		LEFT JOIN SYS_MSG_RECORD_WECHAT wechat ON biz.ID = wechat.MSG_RECORD_BIZ_ID
		LEFT JOIN SYS_MSG_RECORD_SMS sms ON biz.ID = sms.MSG_RECORD_BIZ_ID 
	WHERE
		( biz.BIZ_MSG_CATEGORY = '������Ϣ' OR biz.BIZ_MSG_CATEGORY = 'Ԥ����Ϣ' OR biz.BIZ_MSG_CATEGORY = '�߰���Ϣ' ) 
		AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) -- 			AND biz.SYSTEM_ID=''||systemId||''

	)  INTO v_COUNT 
FROM
	dual;



	unreadCount := v_COUNT;

END p_pom_msgType_list;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_MY_DUTY_NODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_MY_DUTY_NODE" 
(
	USERID               IN VARCHAR2 --��ǰ�û�ID
 ,STATISTICALBEGINDATA IN DATE -- ��ʼ����
 ,STATISTICALENDDATA   IN DATE --��������
 ,CURRENTDATE          IN DATE --��ǰ����
 ,CALENDARSCOPETYPE    IN NVARCHAR2 -- �鿴��Χ�����µ���OR���ܵ��ڣ��������ֵΪ��currentWeek�����ܵ��ڡ�currentMonth�����µ���
 ,ISONLYLOOKME         IN VARCHAR2 --�Ƿ�ֻ������
 ,NODEINFO             OUT SYS_REFCURSOR --���ص�������Ϣ
) AS
	--�ƻ���ҳ-�ҵ�����ڵ�
	--���ߣ�����
	--���ڣ�2019/11/15
BEGIN
	--/pom/mission-center-feedback/my-responsible-task?id=xxx&nodeSourcePlanType=XXX&feedbackNodeOriginalId=XXX&feedbackNodeId=XXX
--	IF CALENDARSCOPETYPE = 'currentWeek' THEN
--		OPEN NODEINFO FOR
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 B.NODE_LEVEL AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=' || CASE
--								WHEN A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
--								 '0'
--								WHEN A.PLAN_TYPE = '��Ŀ����ƻ�' THEN
--								 '1'
--								WHEN A.PLAN_TYPE = 'ר��ƻ�' THEN
--								 '2'
--							END || CHR(38) || 'feedbackNodeOriginalId=' ||
--							B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_PROJ_PLAN A
--			INNER  JOIN POM_PROJ_PLAN_NODE B
--			ON     A.ID = B.PROJ_PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||''
--
--						  AND TRUNC(CURRENTDATE, 'WW') = TRUNC(B.PLAN_END_DATE, 'WW')
--			UNION ALL
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 '' AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=2' || CHR(38) ||
--							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
--							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_SPECIAL_PLAN A
--			INNER  JOIN POM_SPECIAL_PLAN_NODE B
--			ON     A.ID = B.PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||''  AND
--						 TRUNC(CURRENTDATE, 'WW') = TRUNC(B.PLAN_END_DATE, 'WW')
--			UNION ALL
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 B.NODE_TYPE AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=3' || CHR(38) ||
--							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
--							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_DEPT_MONTHLY_PLAN A
--			INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
--			ON     A.ID = B.DEPT_MONTHLY_PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  B.SOURCE_PLAN_ID IS NULL AND
--						 C.CHARGE_PERSON_ID = ''|| USERID||''  AND
--						 TRUNC(CURRENTDATE, 'WW') = TRUNC(B.PLAN_END_DATE, 'WW');
--
--	ELSIF CALENDARSCOPETYPE = 'currentMonth' THEN
--		OPEN NODEINFO FOR
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 B.NODE_LEVEL AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=' || CASE
--								WHEN A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
--								 '0'
--								WHEN A.PLAN_TYPE = '��Ŀ����ƻ�' THEN
--								 '1'
--								WHEN A.PLAN_TYPE = 'ר��ƻ�' THEN
--								 '2'
--							END || CHR(38) || 'feedbackNodeOriginalId=' ||
--							B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_PROJ_PLAN A
--			INNER  JOIN POM_PROJ_PLAN_NODE B
--			ON     A.ID = B.PROJ_PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||'' AND
--						 TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm')
--			UNION ALL
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 '' AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=2' || CHR(38) ||
--							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
--							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_SPECIAL_PLAN A
--			INNER  JOIN POM_SPECIAL_PLAN_NODE B
--			ON     A.ID = B.PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||''  AND
--						 TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm')
--			UNION ALL
--			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--						 B.NODE_TYPE AS NODELEVEL,
--						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
--							CHR(38) || 'nodeSourcePlanType=3' || CHR(38) ||
--							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
--							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--						 B.PLAN_END_DATE AS PLANENDDATE
--			FROM   POM_DEPT_MONTHLY_PLAN A
--			INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
--			ON     A.ID = B.DEPT_MONTHLY_PLAN_ID
--			LEFT   JOIN POM_NODE_CHARGE_PERSON C
--			ON     B.ID = C.NODE_ID
--			WHERE  B.SOURCE_PLAN_ID IS NULL AND
--						 C.CHARGE_PERSON_ID = ''|| USERID||''  AND
--						 TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm');

--	ELSE  --��û�й�ѡ����/����ʱ�䷶Χ��ʱ��Ĭ��ȫ����ѯBy Yedr//2020-01-07
		OPEN NODEINFO FOR
			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
						 B.NODE_LEVEL AS NODELEVEL,
						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
							CHR(38) || 'nodeSourcePlanType=' || CASE
								WHEN A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
								 '0'
								WHEN A.PLAN_TYPE = '��Ŀ����ƻ�' THEN
								 '1'
								WHEN A.PLAN_TYPE = 'ר��ƻ�' THEN
								 '2'
							END || CHR(38) || 'feedbackNodeOriginalId=' ||
							B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
						 B.PLAN_END_DATE AS PLANENDDATE
			FROM   POM_PROJ_PLAN A
			INNER  JOIN POM_PROJ_PLAN_NODE B
			ON     A.ID = B.PROJ_PLAN_ID
			LEFT   JOIN POM_NODE_CHARGE_PERSON C
			ON     B.ID = C.NODE_ID
			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||''
 						  AND CURRENTDATE = B.PLAN_END_DATE
			UNION ALL
			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
						 '' AS NODELEVEL,
						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
							CHR(38) || 'nodeSourcePlanType=2' || CHR(38) ||
							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
						 B.PLAN_END_DATE AS PLANENDDATE
			FROM   POM_SPECIAL_PLAN A
			INNER  JOIN POM_SPECIAL_PLAN_NODE B
			ON     A.ID = B.PLAN_ID
			LEFT   JOIN POM_NODE_CHARGE_PERSON C
			ON     B.ID = C.NODE_ID
			WHERE  C.CHARGE_PERSON_ID = ''|| USERID||''
 						 AND CURRENTDATE = B.PLAN_END_DATE
			UNION ALL
			SELECT A.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
						 B.NODE_TYPE AS NODELEVEL,
						 '/pom/mission-center-feedback/my-responsible-task?id=' || B.ID ||
							CHR(38) || 'nodeSourcePlanType=3' || CHR(38) ||
							'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID || CHR(38) ||
							'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
						 B.PLAN_END_DATE AS PLANENDDATE
			FROM   POM_DEPT_MONTHLY_PLAN A
			INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
			ON     A.ID = B.DEPT_MONTHLY_PLAN_ID
			LEFT   JOIN POM_NODE_CHARGE_PERSON C
			ON     B.ID = C.NODE_ID
			WHERE  B.SOURCE_PLAN_ID IS NULL AND
						 C.CHARGE_PERSON_ID = ''|| USERID||''
 						  AND CURRENTDATE = B.PLAN_END_DATE;
--	END IF;

END P_POM_MY_DUTY_NODE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_MY_MESSAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_MY_MESSAGE" 
(
    USERID      IN VARCHAR2
   ,MESSAGETYPE IN VARCHAR2
   ,TOTAL       OUT INT
   , --��Ϣ����
    MESSAGEINFO OUT SYS_REFCURSOR
) AS
    --�ƻ���ҳ-�ҵ���Ϣ
    --���ߣ�����
    --���ڣ�2019/11/15
BEGIN
    TOTAL := -1;
    OPEN MESSAGEINFO FOR
         SELECT  *  FROM (  SELECT
           plan.PLAN_NAME AS "messageContent",
           node.NODE_LEVEL AS "nodeLevel",
           msg.ACTUAL_CREATED AS "messageArrivalTime", 
           msg.pc_url AS "openUrl",
           CASE
            WHEN node.PLAN_END_DATE - SYSDATE < 0 THEN
                '����'
            WHEN node.PLAN_END_DATE - SYSDATE > 0 THEN
                '����'
           END AS  "nodeState",
           node.PLAN_END_DATE AS "planEndDate"
           FROM          
           POM_PROJ_PLAN_NODE node
           LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID 
           LEFT JOIN SYS_MESSAGE_CENTER msg ON msg.TASK_ID = node.ID
           LEFT JOIN SYS_USER u ON msg.owner_name=u.user_code where msg.TASK_ID = node.ID and  msg.TASK_STATE = 0 AND u.ID=''||USERID||''
           AND msg.biz_msg_category=''||MESSAGETYPE||'' ORDER BY "messageArrivalTime" DESC) WHERE ROWNUM <= 20 ;
END P_POM_MY_MESSAGE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_MY_NODE_CALENDAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_MY_NODE_CALENDAR" 
(
      USERID               IN VARCHAR2 --�����û�ID
	 ,STATISTICALBEGINDATA IN DATE --������ÿ�¿�ʼ����
	 ,STATISTICALENDDATA   IN DATE --������ÿ�½�������
--	 ,CURRENTDATE          IN DATE --�����е�ǰѡ������
--	 ,CALENDARSCOPETYPE    IN VARCHAR2 --�鿴��Χ�����µ���OR���ܵ��ڣ��������ֵΪ��0�����ܵ��ڡ�1�����µ���
--	 ,ISONLYLOOKME         IN VARCHAR2 --�Ƿ�ֻ���Լ�
	 ,STATISTICALINFO      OUT SYS_REFCURSOR --����ֵ
) AS
		--�ƻ���ҳ-��ҳ����
		--���ߣ�����
    --���ڣ�2019/11/15
BEGIN
    /*    OPEN STATISTICALINFO FOR
    SELECT PLAN_END_DATE AS "date", COUNT(PLAN_END_DATE) "total"
    FROM   POM_PROJ_PLAN_NODE
    GROUP  BY PLAN_END_DATE;*/
    OPEN STATISTICALINFO FOR
        SELECT to_char(PLAN_END_DATE,'yyyy-mm-dd') AS nodeDate, COUNT(NODE_NAME) AS total
        FROM   (SELECT A.PLAN_TYPE, B.NODE_NAME, B.PLAN_END_DATE
                 FROM   POM_PROJ_PLAN A
                 INNER  JOIN POM_PROJ_PLAN_NODE B
                 ON     A.ID = B.PROJ_PLAN_ID
                 INNER  JOIN POM_NODE_CHARGE_PERSON C
                 ON     B.ID = C.NODE_ID
                 WHERE  B.ACTUAL_END_DATE IS NULL AND
                        C.CHARGE_PERSON_ID = USERID AND
                        B.PLAN_END_DATE BETWEEN STATISTICALBEGINDATA AND
                        STATISTICALENDDATA
                 UNION ALL
                 SELECT 'ר��ƻ�', B.NODE_NAME, B.PLAN_END_DATE
                 FROM   POM_SPECIAL_PLAN A
                 INNER  JOIN POM_SPECIAL_PLAN_NODE B
                 ON     A.ID = B.PLAN_ID
                 INNER  JOIN POM_NODE_CHARGE_PERSON C
                 ON     B.ID = C.NODE_ID
                 WHERE  B.ACTUAL_END_DATE IS NULL AND
                        C.CHARGE_PERSON_ID = USERID AND
                        B.PLAN_END_DATE BETWEEN STATISTICALBEGINDATA AND
                        STATISTICALENDDATA
                 UNION ALL
                 SELECT '�����¶ȼƻ�', B.NODE_NAME, B.PLAN_END_DATE
                 FROM   POM_DEPT_MONTHLY_PLAN A
                 INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
                 ON     A.ID = B.DEPT_MONTHLY_PLAN_ID
                 INNER  JOIN POM_NODE_CHARGE_PERSON C
                 ON     B.ID = C.NODE_ID
                 WHERE  B.ACTUAL_END_DATE IS NULL AND
                        B.SOURCE_PLAN_ID IS NULL AND
                        C.CHARGE_PERSON_ID = USERID AND
                        B.PLAN_END_DATE BETWEEN STATISTICALBEGINDATA AND
                        STATISTICALENDDATA)
        GROUP  BY PLAN_END_DATE;

END P_POM_MY_NODE_CALENDAR;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_MY_WACTH_NODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_MY_WACTH_NODE" 
(
		USERID               IN NVARCHAR2 --��ǰ�û�ID
	 ,STATISTICALBEGINDATA IN DATE --������ѡ�����ڶ�Ӧ���¿�ʼ����
	 ,STATISTICALENDDATA   IN DATE --������ѡ�����ڶ�Ӧ���½�������
	 ,CURRENTDATE          IN DATE --�����е�ǰѡ������
	 ,CALENDARSCOPETYPE    IN VARCHAR2 --�鿴��Χ��currentWeek�����ܣ�currentMonth������
	 ,ISONLYLOOKME         IN VARCHAR2 --�Ƿ�ֻ�鿴�ҵģ�0����1����
	 ,NODEINFO             OUT SYS_REFCURSOR --����ֵ
) AS
		--�ƻ���ҳ-��ע�Ľڵ�
		--���ߣ�����
		--���ڣ�2019/11/15
		--�����洢����Ϊ����CALENDARSCOPETYPE�����ڷ�Χ���жϲ�ѯ���ݡ�Ĭ��ȫ����ѯ��ǰ�˹�ѡ�����ڷ�Χ�ڸ���ǰ�˴������ڷ�Χ��ѯ  By Yedr 2020-01-07
BEGIN
		/*OPEN NODEINFO FOR
    SELECT POM_PROJ_PLAN.PLAN_NAME AS "planName",
           POM_PROJ_PLAN_NODE.NODE_NAME AS "nodeName",
           POM_PROJ_PLAN_NODE.NODE_LEVEL AS "nodeLevel", '' AS "openUrl",
           PLAN_END_DATE "planEndDate", '����' "nodeState"
    FROM   POM_PROJ_PLAN_NODE
    LEFT   JOIN POM_PROJ_PLAN
    ON     POM_PROJ_PLAN_NODE.PROJ_PLAN_ID = POM_PROJ_PLAN.ID;*/

--		IF ISONLYLOOKME = 1 THEN
--				RETURN;
--		ELSE
--			IF CALENDARSCOPETYPE='currentWeek' THEN
				OPEN NODEINFO FOR
				--�ؼ��ڵ�ƻ�����Ŀ����ƻ�
						SELECT C.PLAN_NAME AS "planName", B.NODE_NAME AS "nodeName",
									 B.NODE_LEVEL AS "nodeLevel",
									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
									 CHR(38) || 'nodeSourcePlanType=' || CASE
											 WHEN C.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
												'0'
											 WHEN C.PLAN_TYPE = '��Ŀ����ƻ�' THEN
												'1'
											 WHEN C.PLAN_TYPE = 'ר��ƻ�' THEN
												'2'
											 ELSE
												NULL
									 END || CHR(38) || 'feedbackNodeOriginalId=' ||
									 B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS "openUrl",
									 B.PLAN_END_DATE AS "planEndDate",
									 CASE
											 WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
												'����'
											 WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
												'�ѳ���'
											 ELSE
												NULL
									 END AS "nodeState"
						FROM   SYS_BIZ_WATCH A
						INNER  JOIN POM_PROJ_PLAN_NODE B
						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
						INNER  JOIN POM_PROJ_PLAN C
						ON     B.PROJ_PLAN_ID = C.ID
						WHERE  A.WATCHER_ID =''|| USERID||''
                   AND c.APPROVAL_STATUS='�����'
									 AND CURRENTDATE = B.PLAN_END_DATE
									 --AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
						UNION ALL
						--ר��ƻ�
						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
									 '' AS NODELEVEL,
									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
										CHR(38) || 'nodeSourcePlanType=' || '2' || CHR(38) ||
										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
									 B.PLAN_END_DATE AS PLANENDDATE,
									 CASE
												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
												 '����'
												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
												 '�ѳ���'
												ELSE
												 NULL
										END AS NODESTATE
						FROM   SYS_BIZ_WATCH A
						INNER  JOIN POM_SPECIAL_PLAN_NODE B
						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
						INNER  JOIN POM_SPECIAL_PLAN C
						ON     B.PLAN_ID = C.ID
						WHERE  A.WATCHER_ID = ''|| USERID||''
									 and c.APPROVAL_STATUS='�����'
									 AND CURRENTDATE = B.PLAN_END_DATE
									-- AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
						UNION ALL
						--�����¶ȼƻ�
						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
									 B.NODE_TYPE AS NODELEVEL,
									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
										CHR(38) || 'nodeSourcePlanType=' || '3' || CHR(38) ||
										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
									 B.PLAN_END_DATE AS PLANENDDATE,
									 CASE
												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
												 '����'
												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
												 '�ѳ���'
												ELSE
												 NULL
										END AS NODESTATE
						FROM   SYS_BIZ_WATCH A
						INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
						ON     A.BIZ_ID =  B.ORIGINAL_NODE_ID
						INNER  JOIN POM_DEPT_MONTHLY_PLAN C
						ON     B.DEPT_MONTHLY_PLAN_ID = C.ID
						WHERE  A.WATCHER_ID = ''|| USERID||''
									 AND CURRENTDATE = B.PLAN_END_DATE;
-- 									 AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')   ;

--			ELSIF CALENDARSCOPETYPE='currentMonth' THEN
--				OPEN NODEINFO FOR
--				--�ؼ��ڵ�ƻ�����Ŀ����ƻ�
--						SELECT C.PLAN_NAME AS "planName", B.NODE_NAME AS "nodeName",
--									 B.NODE_LEVEL AS "nodeLevel",
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--									 CHR(38) || 'nodeSourcePlanType=' || CASE
--											 WHEN C.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
--												'0'
--											 WHEN C.PLAN_TYPE = '��Ŀ����ƻ�' THEN
--												'1'
--											 WHEN C.PLAN_TYPE = 'ר��ƻ�' THEN
--												'2'
--											 ELSE
--												NULL
--									 END || CHR(38) || 'feedbackNodeOriginalId=' ||
--									 B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS "openUrl",
--									 B.PLAN_END_DATE AS "planEndDate",
--									 CASE
--											 WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												'����'
--											 WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												'�ѳ���'
--											 ELSE
--												NULL
--									 END AS "nodeState"
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_PROJ_PLAN_NODE B
--						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_PROJ_PLAN C
--						ON     B.PROJ_PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID =''|| USERID||''
--                   AND c.APPROVAL_STATUS='�����'
--									 AND TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm')
--									  --AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
--						UNION ALL
--						--ר��ƻ�
--						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--									 '' AS NODELEVEL,
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--										CHR(38) || 'nodeSourcePlanType=' || '2' || CHR(38) ||
--										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
--										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--									 B.PLAN_END_DATE AS PLANENDDATE,
--									 CASE
--												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												 '����'
--												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												 '�ѳ���'
--												ELSE
--												 NULL
--										END AS NODESTATE
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_SPECIAL_PLAN_NODE B
--						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_SPECIAL_PLAN C
--						ON     B.PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID = ''|| USERID||''
--									 AND c.APPROVAL_STATUS='�����'
--									 AND TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm')
--									  --AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
--						UNION ALL
--						--�����¶ȼƻ�
--						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--									 B.NODE_TYPE AS NODELEVEL,
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--										CHR(38) || 'nodeSourcePlanType=' || '3' || CHR(38) ||
--										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
--										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--									 B.PLAN_END_DATE AS PLANENDDATE,
--									 CASE
--												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												 '����'
--												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												 '�ѳ���'
--												ELSE
--												 NULL
--										END AS NODESTATE
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
--						ON     A.BIZ_ID =  B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_DEPT_MONTHLY_PLAN C
--						ON     B.DEPT_MONTHLY_PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID = ''|| USERID||''
--									 AND TRUNC(CURRENTDATE, 'mm') = TRUNC(B.PLAN_END_DATE, 'mm');
--									-- AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')   ;
--			ELSE
--				OPEN NODEINFO FOR
--				--�ؼ��ڵ�ƻ�����Ŀ����ƻ�
--						SELECT C.PLAN_NAME AS "planName", B.NODE_NAME AS "nodeName",
--									 B.NODE_LEVEL AS "nodeLevel",
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--									 CHR(38) || 'nodeSourcePlanType=' || CASE
--											 WHEN C.PLAN_TYPE = '�ؼ��ڵ�ƻ�' THEN
--												'0'
--											 WHEN C.PLAN_TYPE = '��Ŀ����ƻ�' THEN
--												'1'
--											 WHEN C.PLAN_TYPE = 'ר��ƻ�' THEN
--												'2'
--											 ELSE
--												NULL
--									 END || CHR(38) || 'feedbackNodeOriginalId=' ||
--									 B.ORIGINAL_NODE_ID || CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS "openUrl",
--									 B.PLAN_END_DATE AS "planEndDate",
--									 CASE
--											 WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												'����'
--											 WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												'�ѳ���'
--											 ELSE
--												NULL
--									 END AS "nodeState"
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_PROJ_PLAN_NODE B
--						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_PROJ_PLAN C
--						ON     B.PROJ_PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID =''|| USERID||''
--									 --AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
--                                    and c.APPROVAL_STATUS='�����'
--						UNION ALL
--						--ר��ƻ�
--						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--									 '' AS NODELEVEL,
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--										CHR(38) || 'nodeSourcePlanType=' || '2' || CHR(38) ||
--										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
--										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--									 B.PLAN_END_DATE AS PLANENDDATE,
--									 CASE
--												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												 '����'
--												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												 '�ѳ���'
--												ELSE
--												 NULL
--										END AS NODESTATE
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_SPECIAL_PLAN_NODE B
--						ON     A.BIZ_ID = B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_SPECIAL_PLAN C
--						ON     B.PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID = ''|| USERID||''
--									 --AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')
--                                     and c.APPROVAL_STATUS='�����'
--						UNION ALL
--						--�����¶ȼƻ�
--						SELECT C.PLAN_NAME AS PLANNAME, B.NODE_NAME AS NODENAME,
--									 B.NODE_TYPE AS NODELEVEL,
--									 '/pom/mission-center-feedback/my-responsible-task/view-task-information?planId=' || C.ID ||
--										CHR(38) || 'nodeSourcePlanType=' || '3' || CHR(38) ||
--										'feedbackNodeOriginalId=' || B.ORIGINAL_NODE_ID ||
--										CHR(38) || 'feedbackNodeId=' || B.ID||'&cancelType=0' AS OPENURL,
--									 B.PLAN_END_DATE AS PLANENDDATE,
--									 CASE
--												WHEN B.PLAN_END_DATE - SYSDATE > 0 THEN
--												 '����'
--												WHEN B.PLAN_END_DATE - SYSDATE < 0 THEN
--												 '�ѳ���'
--												ELSE
--												 NULL
--										END AS NODESTATE
--						FROM   SYS_BIZ_WATCH A
--						INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
--						ON     A.BIZ_ID =  B.ORIGINAL_NODE_ID
--						INNER  JOIN POM_DEPT_MONTHLY_PLAN C
--						ON     B.DEPT_MONTHLY_PLAN_ID = C.ID
--						WHERE  A.WATCHER_ID = ''|| USERID||'';
--									-- AND to_char(B.PLAN_END_DATE,'YYYY/MM/DD')=to_char(CURRENTDATE,'YYYY/MM/DD')   ;
--			END IF;

--		END IF;
		/*/pom/mission-center-feedback/my-responsible-task/view-task-information;

		�������:{

		planId: String, //�ƻ�id
		nodeSourcePlanType: String, //�ƻ�����
		feedbackNodeOriginalId: String, //����ԭʼid
		feedbackNodeId: String //����id

		}*/
END P_POM_MY_WACTH_NODE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_EXAMINATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_EXAMINATION" 
(
		ORIGINALNODEID  IN VARCHAR2
	 ,EXAMINATIONINFO OUT SYS_REFCURSOR
) AS
		--�鿴������������Ϣ�鿴�б�
		--���ߣ�����
		--���ڣ�2019/11/15
BEGIN
		OPEN EXAMINATIONINFO FOR
				SELECT C.PROJ_NAME AS "projName",
							 --��Ŀ����
							 A.NODE_NAME AS "nodeName",
							 --��������
							 A.NODE_LEVEL AS "nodeLevel",
							 --���񼶱�
							 A.DUTY_DEPT AS "dutyDepartment",
							 --������
							 NULL AS "dutyPerson",
							 --������
							 A.PLAN_END_DATE AS "planEndDate",
								--�ƻ��������
							 A.ACTUAL_END_DATE AS "actualEndDate",
								--ʵ���������
							 A.NEW_EXAMINATION_SCORE AS "examinationScore",
								--���˵÷�
							 A.PLAN_START_DATE AS "planStartDate",
								--�ƻ���ʼ����
--							 A. AS "estimateEndDate",
--								--Ԥ���������
							 A.STANDARD_SCORE AS "standardScore" ---����׼��ֵ
				FROM   POM_NODE_EXAMINATION A LEFT JOIN 
                POM_PROJ_PLAN_NODE B ON A.NODE_ID=B.ID LEFT JOIN 
                POM_PROJ_PLAN C ON C.ID=B.PROJ_PLAN_ID
				WHERE a.ORIGINAL_NODE_ID = ORIGINALNODEID;

END P_POM_NODE_EXAMINATION;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_EXAMINATION_CREATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_EXAMINATION_CREATE" 
AS
--������������ 1���������õķ�Χ���������˷�Χ���ݡ�2���Ѿ����ı��ο��˷�Χ���ݣ�ֻ�����޸�ʱ��
--���ߣ�����
--���ڣ�2019/11/13
BEGIN
null;
END p_pom_node_examination_create;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_FEEDBACK_RESULTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_FEEDBACK_RESULTS" (
    unitid         IN             VARCHAR2,--������˾
    projectid      IN             VARCHAR2,--������Ŀ
    filename       IN             VARCHAR2,--�ļ�����
    nodename       IN             VARCHAR2,--�ƻ��ڵ�
    filecreator    IN             VARCHAR2,---�ϴ���
    begindate      IN             VARCHAR2,--��Χ��ʼʱ��
    beginend       IN             VARCHAR2,----��Χ��������
    userid         IN             VARCHAR2,--�û�id(�û���ǰ��
    stationid      IN             VARCHAR2,--��λid(�û���ǰ��
    departmentid   IN             VARCHAR2,--����id(�û���ǰ��
    companyid      IN             VARCHAR2,--��˾id(�û����ڹ�˾)
    bizcode        IN             VARCHAR2,-- Ȩ�ޱ���
    pageindex      IN             INT,--ҳ��
    pagesizes      IN             INT,--ÿҳ����
    total          OUT            INT,--����
    items          OUT            SYS_REFCURSOR--��
)
	--����ɹ���ѯ//�����¸���ʵ��
	--���ߣ�����
	--���ڣ�2019/12/08

	--�޸ģ�������
	--���ڣ�2020/06/05
 AS
    v_sql        CLOB;
    v_sql_exec   CLOB;
    v_where      VARCHAR2(500) := ' and 1=1 ';
    testmsg             NVARCHAR2(4000);
    v_spid      NVARCHAR2(4000);
    v_auth_sql         VARCHAR2(4000) :=' ';
    v_pcount int;
    v_proj  VARCHAR2(4000) :=' ';
BEGIN


    BEGIN
        total := 1000;

            --ִ������Ȩ�޴洢���̡��õ���ʱ��id �û�����ʱ���Ȩ
 --���ò�ѯ����Ȩ�޵Ĵ洢����,����spid
--        P_SYS_AUTH_DATA_RULE_SPID(
--            USERID => userid,
--            STATIONID => stationid,
--            DEPTID => departmentid,
--            COMPANYID => companyid,
--            BIZCODE => bizcode,
--            DATA_AUTH_SPID => v_spid
--        );
         --V_AUTH_SQL:='left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||V_SPID||''') ta on ta.orgid=pp.company_id or ta.orgid=pp.proj_id  where ta.orgid is not null ';
       --չʾȥ��Ȩ��ȡ�� chenl
        V_AUTH_SQL:=' where 1=1';
        --�����ѯ������Ŀ���Ƿ��ڣ���ʱ����������������
                dbms_output.put_line(11111);
select count(proj_id) into v_pcount from POM_PROJ_PLAN where proj_id=projectid;
if v_pcount=0  then
select wm_concat(id) into v_proj from SYS_PROJECT_STAGE where PROJECT_ID=projectid;
else
v_proj:=projectid;
end if;


testmsg := 'unitid:'
               || unitid
               || '��pageindex:'
               || pageindex
               || '��pagesizes:'
               || pagesizes
               || '��projectid:'
               || projectid
               || '��begindate:'
               || begindate
               || '��beginend:'
               || beginend;
        -------------------------------------------����

        IF ( begindate <> NULL ) THEN
            v_where := v_where
                       || 'and  to_char(sa.created,''yyyy-MM-dd'')>='
                       || begindate
                       || '';
        END IF;

        IF ( beginend <> NULL ) THEN
            v_where := v_where
                       || ' and  to_char(sa.created,''yyyy-MM-dd'')<='
                       || beginend
                       || '';
        END IF;

    --------------------------------------ƴ��������sql

        v_sql := '
    SELECT
    rownum as rowno,
    pf.id             as "bizId",
    pn.node_name      AS "nodeName",
    sa.id             AS "attachmentId",
    sa.file_origin_name as "fileName",
    TO_CHAR(sa.file_size/(1024*1024),''FM99990.99'')||''M'' as "fileSize",
    1 AS "isAllowDownload",--�Ƿ��������أ�1����0������
    to_char(sa.created ,''yyyy-MM-dd'') as "created",
    sa.creator        AS "fileCreator",
    pp.plan_name      AS "planName",
    pp.company_id     AS "companyId",
    pp.proj_id        as "projId",
    pp.plan_type      AS "planType"
FROM
    pom_node_feedback    pf
    LEFT JOIN pom_proj_plan_node   pn ON pf.FEEDBACK_NODE_ORIGINAL_ID = pn.original_node_id
    LEFT JOIN pom_proj_plan        pp ON pn.proj_plan_id = pp.id
    LEFT JOIN sys_attachment       sa ON sa.biz_id = pf.id
    '||v_auth_sql||'
    --AND
    --pn.actual_end_date IS NOT NULL
    AND sa.file_origin_name is not null
    AND pp.approval_status = ''�����''
    AND instr('''||v_proj||''', pp.proj_id) > 0
    and pp.company_id='''||unitid||'''
    and (file_origin_name like ''%'
                 || filename
                 || '%'' and node_name like ''%'
                 || nodename
                 || '%'' and sa.creator like ''%'
                 || filecreator
                 || '%'')'
                 || v_where;


    ----------------------------------------��ҳ

        v_sql_exec := '
select a.* from ( '
                      || v_sql
                      || ' AND rownum <= '
                      || pageindex * pagesizes
                      || ' ) a where a.rowno >= '
                      || pagesizes * ( pageindex - 1 )
                      || '';

        dbms_output.put_line(v_sql_exec);
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                          || v_sql
                          || ') a '
        INTO total;
-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg := sqlerrm || testmsg;
            OPEN items FOR SELECT
                               'ʧ�ܿ�'
                           FROM
                               dual;

            dbms_output.put_line(sqlerrm);
    END;

END p_pom_node_feedback_results;
--=================================����˾���������Start=========================

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_FEEDBACK_RESULTS_C
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_FEEDBACK_RESULTS_C" (
    unitid         IN             VARCHAR2,--������˾
    projectid      IN             VARCHAR2,--������Ŀ
    filename       IN             VARCHAR2,--�ļ�����
    nodename       IN             VARCHAR2,--�ƻ��ڵ�
    filecreator    IN             VARCHAR2,---�ϴ���
    begindate      IN             VARCHAR2,--��Χ��ʼʱ��
    beginend       IN             VARCHAR2,----��Χ��������
    userid         IN             VARCHAR2,--�û�id(�û���ǰ��
    stationid      IN             VARCHAR2,--��λid(�û���ǰ��
    departmentid   IN             VARCHAR2,--����id(�û���ǰ��
    companyid      IN             VARCHAR2,--��˾id(�û����ڹ�˾)
    bizcode        IN             VARCHAR2,-- Ȩ�ޱ���
    pageindex      IN             INT,--ҳ��
    pagesizes      IN             INT,--ÿҳ����
    total          OUT            INT,--����
    items_test          OUT            SYS_REFCURSOR,--��
    items          OUT            SYS_REFCURSOR--��
) 
	--����ɹ���ѯ//�����¸���ʵ��
	--���ߣ�����
	--���ڣ�2019/12/08	
 AS
    v_sql        CLOB;
    v_sql_exec   CLOB;
    v_where      VARCHAR2(500) := ' and 1=1 ';
    testmsg             NVARCHAR2(4000);
    v_spid      NVARCHAR2(4000);
    v_auth_sql         VARCHAR2(4000) :=' ';
    v_pcount int;
    v_proj  VARCHAR2(4000) :=' ';
     v_unitid               VARCHAR2(4000) :=' ';--������˾
BEGIN


    BEGIN
        total := 1000;

            --ִ������Ȩ�޴洢���̡��õ���ʱ��id �û�����ʱ���Ȩ
 --���ò�ѯ����Ȩ�޵Ĵ洢����,����spid 
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => stationid,
            DEPTID => departmentid,
            COMPANYID => companyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
        V_AUTH_SQL:='left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||V_SPID||''') ta on ta.orgid=pp.company_id or ta.orgid=p.id  where ta.orgid is not null ';        
       --չʾȥ��Ȩ��ȡ�� chenl 
        --V_AUTH_SQL:=' where 1=1';
        --�����ѯ������Ŀ���Ƿ��ڣ���ʱ����������������
                dbms_output.put_line(11111);
  OPEN items_test FOR select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = V_SPID;
 ---������Ŀ�ķ���
       if projectid is null then
            v_proj:=''' or ''1''=''1';
        else
          select id into v_proj from SYS_PROJECT_STAGE where PROJECT_ID=projectid;
        end if;

  ---������Ŀ�ķ���
       if unitid is null then
            v_unitid:=''' or ''1''=''1';
        else
          v_unitid:=unitid;
        end if;


testmsg := 'unitid:'
               || unitid
               || '��pageindex:'
               || pageindex
               || '��pagesizes:'
               || pagesizes
               || '��projectid:'
               || projectid
               || '��begindate:'
               || begindate
               || '��beginend:'
               || beginend;
        -------------------------------------------����

        IF ( begindate <> NULL ) THEN
            v_where := v_where
                       || 'and  to_char(sa.created,''yyyy-MM-dd'')>='
                       || begindate
                       || '';
        END IF;

        IF ( beginend <> NULL ) THEN
            v_where := v_where
                       || ' and  to_char(sa.created,''yyyy-MM-dd'')<='
                       || beginend
                       || '';
        END IF;

    --------------------------------------ƴ��������sql

        v_sql := '
    SELECT
    rownum as rowno,
    pf.id             as "bizId",
    pn.node_name      AS "nodeName",
    sa.id             AS "attachmentId",
    sa.file_origin_name as "fileName",
    TO_CHAR(sa.file_size/(1024*1024),''FM99990.99'')||''M'' as "fileSize",
    1 AS "isAllowDownload",--�Ƿ��������أ�1����0������
    to_char(sa.created ,''yyyy-MM-dd'') as "created",
    sa.creator        AS "fileCreator",
    pp.plan_name      AS "planName",
    pp.company_id     AS "companyId",
    pp.proj_id        as "projId",
    pp.plan_type      AS "planType",
p.PROJECT_NAME,
ta.orgid
FROM
    pom_node_feedback    pf
    LEFT JOIN pom_proj_plan_node   pn ON pf.FEEDBACK_NODE_ORIGINAL_ID = pn.original_node_id
    LEFT JOIN pom_proj_plan        pp ON pn.proj_plan_id = pp.id
    LEFT JOIN sys_attachment       sa ON sa.biz_id = pf.id 
      left join SYS_PROJECT_STAGE ps on ps.id=pp.proj_id
      left join sys_project p on ps.PROJECT_ID=p.id

    '||v_auth_sql||'
    AND
    pn.actual_end_date IS NOT NULL 
    AND sa.file_origin_name is not null 
    AND pp.approval_status = ''�����''
    AND (pp.proj_id='''||v_proj||''')
    and (pp.company_id='''||v_unitid||''')
    and (file_origin_name like ''%'
                 || filename
                 || '%'' and node_name like ''%'
                 || nodename
                 || '%'' and sa.creator like ''%'
                 || filecreator
                 || '%'')'
                 || v_where;


    ----------------------------------------��ҳ

        v_sql_exec := '
select a.* from ( '
                      || v_sql
                      || ' AND rownum <= '
                      || pageindex * pagesizes
                      || ' ) a where a.rowno >= '
                      || pagesizes * ( pageindex - 1 )
                      || '';

        dbms_output.put_line(v_sql_exec);
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                          || v_sql
                          || ') a '
        INTO total;

-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg := sqlerrm || testmsg;
            OPEN items FOR SELECT
                               testmsg
                           FROM
                               dual;

            dbms_output.put_line(sqlerrm);
    END;

END p_pom_node_feedback_results_c;
--=================================����˾���������Start=========================

--=================================����˾���������Start=========================

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_MESSAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_MESSAGE" 
(
  originalNodeId IN VARCHAR2,
  messageInfo OUT sys_refcursor
) AS 
--�鿴���������������Ϣ�б��ѯ
--���ߣ�����
--���ڣ�2019/11/15
BEGIN
 open messageInfo for
  select * from(    
  SELECT 
  biz.BIZ_SOURCE_CATEGORY  AS    "title"--��Ϣ����
  ,node.NODE_NAME ||'-'|| node.NODE_LEVEL  AS  "nodeInfo"--������Ϣ
  ,nvl(UR.USER_NAME,URS.USER_NAME) AS "recipient"
  ,cast(nvl(MSG.SEND_DATE,msgs.SEND_DATE) as timestamp)   AS   "executionTime"
  --,to_timestamp(nvl(MSG.SEND_DATE,msgs.SEND_DATE),'yyyy-mm-dd hh24:mi:ss') AS   "executionTime"
  ,nvl(BIZ_MSG_CATEGORY,BIZ_SOURCE_CATEGORY)   AS  "msgType"
      FROM
      POM_PROJ_PLAN_NODE node  
      LEFT JOIN SYS_MSG_RECORD_BIZ biz ON node.ID = biz.BIZ_KEY
      LEFT JOIN SYS_MSG_RECORD_WECHAT msg ON biz.id = msg.MSG_RECORD_BIZ_ID 
      left join SYS_MSG_RECORD_SMS msgs on biz.id = msgs.MSG_RECORD_BIZ_ID 
      LEFT JOIN  SYS_USER UR ON UR.user_code=MSG.RECEIVER_ID
      LEFT JOIN  SYS_USER URS ON URS.user_code=msgs.RECEIVER_ID
    WHERE
      node.id = biz.biz_key  and  node.id=''||originalNodeId||''
      AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) ) a order by "executionTime" desc;
    
--  SELECT 
--  MSG.TITLE  AS    "title"--��Ϣ����
--  ,node.NODE_NAME ||'-'|| node.NODE_LEVEL  AS  "nodeInfo"--������Ϣ
--  ,UR.USER_NAME AS "recipient"
--  ,MSG.SEND_DATE  AS   "executionTime"
--  ,MSG.ACTUAL_EXECUTE_TYPE   AS  "msgType"
--      FROM
--      POM_PROJ_PLAN_NODE node  
--      LEFT JOIN SYS_MSG_RECORD_BIZ biz ON node.ID = biz.BIZ_KEY
--      LEFT JOIN SYS_MSG_RECORD_WECHAT msg ON biz.id = msg.MSG_RECORD_BIZ_ID 
--      LEFT JOIN  SYS_USER UR ON UR.ID=MSG.RECEIVER_ID
--    WHERE
--      node.id = biz.biz_key  and  node.id=''||originalNodeId||''
--      AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD ) ;
      
        
END p_pom_node_message;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_NODE_MESSAGE_ADJUSTMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_NODE_MESSAGE_ADJUSTMENT" 
(
  originalNodeId IN VARCHAR2,
  messageInfo OUT sys_refcursor
) AS 
--�鿴���������������Ϣ�б��ѯ
--���ߣ�л�ɺ�
--���ڣ�2020/03/13
BEGIN
 open messageInfo for
Select * from (
select 
	nvl(MSG.TITLE, biz.BIZ_SOURCE_CATEGORY)  AS    "title"--��Ϣ����
	,node.NODE_NAME ||'-'|| node.NODE_LEVEL  AS  "nodeInfo"--������Ϣ
	,nvl(UR.USER_NAME,URS.USER_NAME) AS "recipient"
	,nvl(MSG.SEND_DATE, sms.SEND_DATE)  AS   "executionTime"
    ,to_char(nvl(MSG.SEND_DATE, sms.SEND_DATE), 'yyyy-MM-dd hh24:mi:ss') AS "executionTimeString" --���һ�������ֶ����ڽ�����ʱ��ת��Ϊ�ַ�����ʽ��
	,nvl(msg.WECHAT_MSG_TYPE, BIZ.BIZ_MSG_CATEGORY) AS  "msgType"
 from 
(select * from POM_PROJ_PLAN_NODE where  proj_plan_id = (select id from (select * from POM_PROJ_PLAN plan where plan.id in (select proj_plan_id from POM_PROJ_PLAN_NODE where original_node_id=''||originalNodeId||'') and approval_status='�����'))) node 
LEFT JOIN SYS_MSG_RECORD_BIZ biz ON node.ID = biz.BIZ_KEY
LEFT JOIN SYS_MSG_RECORD_WECHAT msg ON biz.id = msg.MSG_RECORD_BIZ_ID 
LEFT JOIN SYS_MSG_RECORD_SMS sms on biz.id = sms.MSG_RECORD_BIZ_ID
LEFT JOIN  SYS_USER UR ON UR.ID=msg.RECEIVER_ID
LEFT JOIN  SYS_USER URS ON URS.user_code=sms.RECEIVER_ID
where 
node.id = biz.biz_key  and
original_node_id = ''||originalNodeId||''
AND biz.ID NOT IN ( SELECT MSG_RECORD_BIZ_GUID FROM SYS_MSG_READ_RECORD )) order by "executionTime" desc;

END p_pom_node_message_adjustment;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_OUT_EXCEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_OUT_EXCEL" 
(
    PROJID      IN VARCHAR2
   , -- �����������Ŀ
    CURRENTTYPE IN VARCHAR2
   , --��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    ITEMS       OUT SYS_REFCURSOR
   ,TOTAL       OUT INT
) IS

    V_SQL_START       CLOB;
    V_SQL_END         CLOB;
    V_SQL_CONTENT     CLOB;
    V_SQL             CLOB;
    V_SQL_EXEC        CLOB;
    V_SQL_EXEC_PAGING CLOB;
    V_WHERE           VARCHAR2(500);
    TESTMSG           NVARCHAR2(200);
BEGIN
    ----------------------------------------------------ͳһ����
    TESTMSG := 'projid:' || PROJID || '��currenttype:' || CURRENTTYPE;

    BEGIN
        TOTAL         := 1000;
        V_SQL_START   := ' case ';
        V_SQL_CONTENT := '';
        V_SQL_END     := '  else '''' end  ';


        --1.ƴ�Ӳ�ѯ���
        FOR ITEM IN (SELECT S.EXPRESSION, VV.NODE_LEVEL, VV.PLAN_TYPE
                     FROM   POM_RULE_SET S
                     LEFT   JOIN (SELECT MAX(S.CREATED_TIME) AS T, NODE_LEVEL, PLAN_TYPE
                                 FROM   POM_RULE_SET S
                                 LEFT   JOIN POM_RULE_SET_PLAN_TYPE PT
                                 ON     S.ID = PT.RULE_ID
                                 WHERE  RULE_TYPE = '���ƹ���'
                                       -- AND plan_type != '�ؼ��ڵ�ƻ�'
                                        AND
                                        S.IS_DISABLE = 0
                                 GROUP  BY NODE_LEVEL, PLAN_TYPE) VV
                     ON     S.CREATED_TIME = VV.T AND
                            S.NODE_LEVEL = VV.NODE_LEVEL
                     WHERE  VV.T IS NOT NULL)
        LOOP
            ---ƴ���ַ���
            V_SQL_CONTENT := V_SQL_CONTENT || '  when plan_type=''' || CASE ITEM.PLAN_TYPE
                                 WHEN '��Ŀȫ���ƻ�' THEN
                                  '��Ŀ����ƻ�'
                                 ELSE
                                  ITEM.PLAN_TYPE
                             END || ''' and node_level=''' || ITEM.NODE_LEVEL || ''' then (' || ITEM.EXPRESSION || ')';
        END LOOP;

        --dbms_output.put_line('123333');
        --dbms_output.put_line(v_sql_content);
        --�������ݴ���0��ƴ�������

        IF LENGTH(V_SQL_CONTENT) > 0
        THEN
            V_SQL := V_SQL_START || V_SQL_CONTENT || V_SQL_END;
        ELSE
            --�޹���������ʾ��
            V_SQL := '''''';
        END IF;

        -------------------------------------------------------------------------------------------����


        IF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is null and (PLAN_END_DATE>=trunc(sysdate, ''month'') and PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF CURRENTTYPE = '����δ�������'
        THEN
            V_WHERE := ' and TRUNC(SYSDATE) > PLAN_END_DATE and ACTUAL_END_DATE is null';
        ELSIF CURRENTTYPE = '����δ�������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is null ';
        ELSIF CURRENTTYPE = '�������������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is not null ';
        ELSIF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' ';
        ELSIF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' and (PLAN_END_DATE>last_day(trunc(sysdate))+1 and PLAN_END_DATE<last_day(last_day(trunc(sysdate))+1))';
        ELSIF CURRENTTYPE = '����������'
        THEN
            V_WHERE := ' and (PLAN_END_DATE>trunc(sysdate, ''Q'') and PLAN_END_DATE<add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' and (PLAN_END_DATE>trunc(sysdate, ''yyyy'') and PLAN_END_DATE<add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            V_WHERE := ' and 1=2';
        END IF;

        --3.ƴ���������
        V_SQL_EXEC := ' select  rownum as rowno,ID,
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
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,' || V_SQL || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE IS NOT NULL THEN NULL 
ELSE ''�߰�'' END as HASTEN
,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0=724=300=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300==''||ORIGINAL_NODE_ID end as w_Url

                      from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''�ؼ��ڵ�ƻ�''   THEN
            0
        WHEN ''��Ŀ����ƻ�''   THEN
            1
    END AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������

    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n LEFT
    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID WHERE   p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'' AND NVL(n.IS_DISABLE,0) <> 1 and APPROVAL_STATUS=''�����''
    AND (p.PROJ_ID=''' || PROJID || ''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''' || PROJID || '''))  ' || V_WHERE || '
)n
    left join SYS_BIZ_WATCH w on n.ORIGINAL_NODE_ID=w.BIZ_ID  ) a ';
        -------------------------------------------------------------------------------------------����

        V_SQL_EXEC_PAGING := '
select a.* from ( ' || V_SQL_EXEC || ')a';

        DBMS_OUTPUT.PUT_LINE(V_SQL_EXEC_PAGING);
        ----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from(' || V_SQL_EXEC || ') a '
            INTO TOTAL;

        -- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN ITEMS FOR V_SQL_EXEC_PAGING;
        --SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
            TESTMSG := SQLERRM || TESTMSG;
            OPEN ITEMS FOR
                SELECT 'ʧ�ܿ�' || TESTMSG PLAN_NAME FROM DUAL;

            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

END p_pom_out_excel;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PERMIT_ID_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PERMIT_ID_LIST" (
    info out SYS_REFCURSOR,
    originNodeId in varchar2
) is
--�����ѱ�ԭʼ�ڵ�Id��ѯ���нڵ���������֤��id
--���ߣ�������
--���ڣ�2010/02/28
--����������ѱ�ԭʼ�ڵ�Id
begin
    open info for
        select fb.PERMIT_ID
        from POM_NODE_FEEDBACK fb
        left join POM_PROJ_PLAN_NODE node on fb.id = node.FISSION_SOURCE_ORIGINAL_ID
        left join POM_PROJ_PLAN plan on node.PROJ_PLAN_ID = plan.id
        where plan.ORIGINAL_PLAN_ID = originNodeId;
    -- ��ԭʼ�ڵ�id����POM_PROJ_PLAN��ѯ�����ѱ�ƻ�
    -- �����ƻ��ڵ�id
end P_POM_PERMIT_ID_LIST;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PLAN_COMPLETIONRANKING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PLAN_COMPLETIONRANKING" (
    companyid          IN                 VARCHAR2,--��˾id
    currentcompanyid   IN                 VARCHAR2,--��ǰ�û��Ĺ�˾
    userid             IN                 VARCHAR2,--�û�id���ڹ��˹�ע������
    currentstationid   IN                 VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid      IN                 VARCHAR2,---��ǰ�û��Ĳ���
    bizcode            IN                 VARCHAR2,---Ȩ��code
    authdata           OUT                SYS_REFCURSOR,--��Ȩ�����ݵ�ID����
    datasource              OUT                SYS_REFCURSOR --������Ϣ
) AS
--��Ŀ����ƻ������Ŀ�����ǰ���а�
--���ߣ�Ҷ����
--���ڣ�2020/03/20
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN
--��������Ȩ����֤�洢����
    p_sys_auth_data_rule_spid(userid => userid, stationid => currentstationid, deptid => currentdeptid, companyid => currentcompanyid
    , bizcode => bizcode, data_auth_spid => v_spid);

    OPEN datasource FOR SELECT
                      ROWNUM,
                      b1."fullName",
                      b1."competationRate",
                      b1."projtId"
                  FROM
                      sys_business_unit a1
                      LEFT JOIN (
                          SELECT
                              '��'
                              || a.company_name
                              || '��'
                              || d.project_name
                              ||
                                  CASE
                                      WHEN c.stage_name NOT LIKE '%�޷���%' THEN
                                          '_' || c.stage_name
                                      ELSE
                                          NULL
                                  END
                              AS "fullName",
                              c.id   AS "projtId",
                              a.company_id,
                              COUNT(b.id) AS "TOTALNODECOUNT",
                              SUM(
                                  CASE
                                      WHEN b.actual_end_date IS NOT NULL THEN
                                          1
                                      ELSE
                                          0
                                  END
                              ) AS "actualEndNodeCount",
                              round(SUM(
                                  CASE
                                      WHEN b.actual_end_date IS NOT NULL THEN
                                          1
                                      ELSE
                                          0
                                  END
                              ) /(

                                   CASE
                                      WHEN COUNT(b.id) = 0 THEN
                                          1
                                      ELSE
                                          COUNT(b.id)
                                  END

                              ),4) AS "competationRate"
--�����˵������ֹ��ǰ��ɽڵ�����/��ֹ��ǰӦ�����������    ���ƹ���˵����1���̵ƣ�����ʡ�95% 2���Ƶƣ�95%>����ʡ�90% 3����ƣ�����ʣ�90%
                          FROM
                              pom_proj_plan        a
                              INNER JOIN pom_proj_plan_node   b ON a.id = b.proj_plan_id
                              INNER JOIN sys_project_stage    c ON c.id = proj_id
                              INNER JOIN sys_project          d ON d.id = c.project_id
                          WHERE
                              a.plan_type = '��Ŀ����ƻ�'
                              AND a.approval_status = '�����'
                              AND b.is_disable = 0
                              AND b.plan_end_date is not null
                              AND b.plan_end_date <= SYSDATE
                          GROUP BY
                              '��'
                              || a.company_name
                              || '��'
                              || d.project_name
                              ||
                                  CASE
                                      WHEN c.stage_name NOT LIKE '%�޷���%' THEN
                                          '_' || c.stage_name
                                      ELSE
                                          NULL
                                  END,
                              a.company_id,
                              a.company_name,
                              c.id
                      ) b1 ON b1.company_id = a1.id
                      LEFT JOIN (
                          SELECT
                              wm_concat(user_name) AS user_name,
                              project_id
                          FROM
                              sys_role_user_relation_result
                          WHERE
                              role_code = 'pom_project_plan_manager'
                          GROUP BY
                              project_id
                      ) c1 ON c1.project_id = b1."projtId"
                  WHERE
                      nvl(b1.totalnodecount, 0) > 0
                      AND ROWNUM <= 10
                      AND CONNECT_BY_ROOT id = ''
                                               || companyid
                                               || ''
                  CONNECT BY
                      PRIOR a1.id = a1.parent_id
                  ORDER BY
                      b1."competationRate" DESC;

    OPEN authdata FOR SELECT
                      b1."projtId"
                  FROM
                      sys_business_unit a1
                      LEFT JOIN (
                          SELECT
                              c.id   AS "projtId",
                              a.company_id
                          FROM
                              pom_proj_plan        a
                              INNER JOIN pom_proj_plan_node   b ON a.id = b.proj_plan_id
                              INNER JOIN sys_project_stage    c ON c.id = proj_id
                              INNER JOIN sys_project          d ON d.id = c.project_id
                              LEFT  JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                              on (case when c.id is not null then c.PROJECT_ID else a.proj_id end)=tal.orgId
                            WHERE
                              a.plan_type = '��Ŀ����ƻ�'
                              AND a.approval_status = '�����'
                              AND b.is_disable = 0
                          GROUP BY
                              a.company_id,
                              a.company_name,
                              c.id
                      ) b1 ON b1.company_id = a1.id
                      LEFT JOIN (
                          SELECT
                              wm_concat(user_name) AS user_name,
                              project_id
                          FROM
                              sys_role_user_relation_result
                          WHERE
                              role_code = 'pom_project_plan_manager'
                          GROUP BY
                              project_id
                      ) c1 ON c1.project_id = b1."projtId"
                  WHERE
                      b1."projtId" is not null
                      AND CONNECT_BY_ROOT id = ''
                                               || companyid
                                               || ''
                                                CONNECT BY
                      PRIOR a1.id = a1.parent_id
                ;

END p_pom_plan_completionranking;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PLAN_MONITOR_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PLAN_MONITOR_LIST" (
    plantype    IN          VARCHAR2, --����������ƻ�����
    currentcompanyid   IN                 VARCHAR2,--��ǰ�û��Ĺ�˾
    userid             IN                 VARCHAR2,--�û�id���ڹ��˹�ע������
    currentstationid   IN                 VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid      IN                 VARCHAR2,---��ǰ�û��Ĳ���
    bizcode            IN                 VARCHAR2,---Ȩ��code
    pageindex   IN          VARCHAR2,--���������ҳ��
    pagesizes    IN          VARCHAR2,--�������٣�ҳ������
    items       OUT         SYS_REFCURSOR
) IS
    v_where              CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN
    --��������Ȩ����֤�洢����
    p_sys_auth_data_rule_spid(userid => userid, stationid => currentstationid, deptid => currentdeptid, companyid => currentcompanyid
    , bizcode => bizcode, data_auth_spid => v_spid);

  execute immediate ' alter session set nls_date_format = ''yyyy-mm-dd hh24:mi:ss''';
    IF plantype = '�ؼ��ڵ�ƻ�' THEN
        v_where:= 'AND plan.PLAN_TYPE = ''�ؼ��ڵ�ƻ�''';
    ELSE
        v_where := 'AND plan.PLAN_TYPE = ''��Ŀ����ƻ�''';
    END IF;


v_sql_exec:='SELECT  rownum as "rowno","userName", "executionTime","executionContent", "executionType" from
(select "userName","executionTime","executionContent","executionType" from (
SELECT
    back.FEEDBACKER AS "userName",
    back.CREATED AS "executionTime",
    case when  FEEDBACK_TYPE=''PROCESS'' then
    ''<span style="color:#A2A2A2">����������:</span> ''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name )
    when FEEDBACK_TYPE=''CARRY_OUT'' then
    ''<span style="color:#A2A2A2">���������:</span>''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name ) 

     else 
     ''<span style="color:#A2A2A2">�����˳���δ�������:</span>''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name ) 
     end  AS "executionContent",
	case when  FEEDBACK_TYPE=''PROCESS'' then
        ''feedback''
     when FEEDBACK_TYPE=''CARRY_OUT'' then
        ''complete''
     else
        ''overdu''
     end AS "executionType"
--     to_char(back.CREATED,''yyyy-mm-dd'') as "groupDate"
    FROM
	pom_proj_plan_node node
	LEFT JOIN pom_proj_plan plan ON node.proj_plan_id = plan.id
    LEFT JOIN SYS_PROJECT_STAGE stage on plan.proj_id=stage.id
    LEFT JOIN SYS_PROJECT proj
    on (case when stage.id is not null then stage.ID else plan.proj_id end)=proj.id
    INNER join pom_node_feedback back on back.FEEDBACK_NODE_ORIGINAL_ID=node.original_node_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    ON (case when stage.id is not null then stage.PROJECT_ID else plan.proj_id end)=tal.orgId
    where plan.ID is not null and plan.APPROVAL_STATUS=''�����'' '|| v_where||'
    UNION ALL
   SELECT
    message.user_name AS "userName",
      message.created_time AS "executionTime",
    ''<span style="color:#A2A2A2">�߰�������:</span>''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name )   AS "executionContent",
    ''urge'' AS "executionType"
FROM
    pom_proj_plan_node   node
    LEFT JOIN pom_proj_plan        plan ON node.proj_plan_id = plan.id
    LEFT JOIN sys_project_stage    stage ON plan.proj_id = stage.id
    LEFT JOIN sys_project          proj ON (
        CASE
            WHEN stage.id IS NOT NULL THEN
                stage.ID
            ELSE
                plan.proj_id
        END
    ) = proj.id
    INNER JOIN (
         SELECT
            msg.biz_key,
            msg.biz_msg_category,
            msg.created_time,
            sms.sender_id      AS "sms_sender_id",
            sms.sms_content,
            wechat.sender_id   AS "wechat_sender_id",
            wechat.title,
            suser.user_name
        FROM
            sys_msg_record_biz      msg
            LEFT JOIN sys_msg_record_sms      sms ON sms.msg_record_biz_id = msg.id
            LEFT JOIN sys_msg_record_wechat   wechat ON wechat.msg_record_biz_id = msg.id
            INNER JOIN sys_user suser on suser.user_code=sms.sender_id OR suser.id=wechat.sender_id
        WHERE
            msg.biz_msg_category = ''�߰���Ϣ'' 
    ) message ON message.biz_key = node.original_node_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    ON (case when stage.id is not null then stage.PROJECT_ID else plan.proj_id end)=tal.orgId
    WHERE  plan.APPROVAL_STATUS=''�����'' '|| v_where||'
    UNION ALL
    select
    '''' AS "userName",
    to_date(  to_char("executionTime",''yyyy-mm-dd'')||'' 23:59:59'' ) AS "executionTime",
    ''''  AS "executionContent",
    to_char("executionTime",''mm"��"dd"��"'') "executionType" from (
SELECT
    back.FEEDBACKER AS "userName",
    back.CREATED AS "executionTime",
    case when  FEEDBACK_TYPE=''PROCESS'' then
    ''���������� ''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name )
    when FEEDBACK_TYPE=''CARRY_OUT'' then
    ''���������''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name ) 

     else 
     ''�����˳���δ�������''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name ) 
     end  AS "executionContent",
  case when  FEEDBACK_TYPE=''PROCESS'' then
        ''feedback''
     when FEEDBACK_TYPE=''CARRY_OUT'' then
        ''overdu''
     else
        ''complete''
     end AS "executionType"
--     to_char(back.CREATED,''yyyy-mm-dd'') as "groupDate"
    FROM
  pom_proj_plan_node node
  LEFT JOIN pom_proj_plan plan ON node.proj_plan_id = plan.id
    LEFT JOIN SYS_PROJECT_STAGE stage on plan.proj_id=stage.id
    LEFT JOIN SYS_PROJECT proj
    on (case when stage.id is not null then stage.ID else plan.proj_id end)=proj.id
    INNER join pom_node_feedback back on back.FEEDBACK_NODE_ORIGINAL_ID=node.original_node_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    ON (case when stage.id is not null then stage.PROJECT_ID else plan.proj_id end)=tal.orgId
    where plan.ID is not null and plan.APPROVAL_STATUS=''�����'' '|| v_where||'
    UNION ALL
   SELECT
     message.user_name AS "userName",
      message.created_time AS "executionTime",
    ''�߰�������:''|| ( ''��'' || stage.STAGE_FULL_NAME || ''��''|| node.node_name )   AS "executionContent",
    ''urge'' AS "executionType"
FROM
    pom_proj_plan_node   node
    LEFT JOIN pom_proj_plan        plan ON node.proj_plan_id = plan.id
    LEFT JOIN sys_project_stage    stage ON plan.proj_id = stage.id
    LEFT JOIN sys_project          proj ON (
        CASE
            WHEN stage.id IS NOT NULL THEN
                stage.ID
            ELSE
                plan.proj_id
        END
    ) = proj.id
    INNER JOIN (
         SELECT
            msg.biz_key,
            msg.biz_msg_category,
            msg.created_time,
            sms.sender_id      AS "sms_sender_id",
            sms.sms_content,
            wechat.sender_id   AS "wechat_sender_id",
            wechat.title,
            suser.user_name
        FROM
            sys_msg_record_biz      msg
            LEFT JOIN sys_msg_record_sms      sms ON sms.msg_record_biz_id = msg.id
            LEFT JOIN sys_msg_record_wechat   wechat ON wechat.msg_record_biz_id = msg.id
            INNER JOIN sys_user suser on suser.user_code=sms.sender_id OR suser.id=wechat.sender_id
        WHERE
            msg.biz_msg_category = ''�߰���Ϣ'' 
    ) message ON message.biz_key = node.original_node_id   WHERE  plan.APPROVAL_STATUS=''�����'' '|| v_where||')a
    group by to_char("executionTime",''mm"��"dd"��"'')
    , to_date(  to_char("executionTime",''yyyy-mm-dd'')||'' 23:59:59'' )) order BY "executionTime" DESC)   ';







      v_sql_exec_paging := '
select a.* from ( '
                         || v_sql_exec
                         || ' where rownum <= '
                         || pageIndex * pageSizes
                         || ' ) a where a."rowno" > '
                         || pagesizes * ( pageindex - 1 )
                         || '';

    dbms_output.put_line(v_sql_exec_paging);
    OPEN items FOR v_sql_exec_paging;

END p_pom_plan_monitor_list;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_PLAN_MONITOR_TASK_COUNT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PLAN_MONITOR_TASK_COUNT" ( plantype IN VARCHAR2, --����������ƻ�����
    currentcompanyid   IN                 VARCHAR2,--��ǰ�û��Ĺ�˾
    userid             IN                 VARCHAR2,--�û�id���ڹ��˹�ע������
    currentstationid   IN                 VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid      IN                 VARCHAR2,---��ǰ�û��Ĳ���
    bizcode            IN                 VARCHAR2,---Ȩ��code
	beyondtask OUT VARCHAR2,
    completedtodaytask OUT VARCHAR2,
    todotodaytask OUT VARCHAR2 )
 IS
    v_where CLOB;
    v_beyondtask_sql  CLOB;
    v_completedtodaytask_sql  CLOB;
    v_todotodaytask_sql  CLOB;
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN
--��������Ȩ����֤�洢����
    p_sys_auth_data_rule_spid(userid => userid, stationid => currentstationid, deptid => currentdeptid, companyid => currentcompanyid
    , bizcode => bizcode, data_auth_spid => v_spid);

	IF
		plantype = '�ؼ��ڵ�ƻ�' THEN
			v_where := 'AND plan.PLAN_TYPE = ''�ؼ��ڵ�ƻ�''';
		ELSE v_where := 'AND plan.PLAN_TYPE = ''��Ŀ����ƻ�''';

	END IF;
	--��������
    v_beyondtask_sql:=	'SELECT COUNT( * ) FROM POM_PROJ_PLAN_NODE node LEFT JOIN
    POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID 
    LEFT JOIN sys_project_stage    c ON c.id = plan.proj_id
    LEFT JOIN sys_project          d ON d.id = c.project_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    on (case when c.id is not null then c.PROJECT_ID else plan.proj_id end)=tal.orgId
    WHERE plan.APPROVAL_STATUS=''�����'' AND node.PLAN_END_DATE IS NOT NULL
    AND ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE ' ||v_where;
    EXECUTE IMMEDIATE  v_beyondtask_sql into beyondtask;
	--���մ���
	 v_completedtodaytask_sql:='SELECT COUNT( * ) FROM POM_PROJ_PLAN_NODE node LEFT JOIN
	 POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID 
     LEFT JOIN sys_project_stage    c ON c.id = plan.proj_id
    LEFT JOIN sys_project          d ON d.id = c.project_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    on (case when c.id is not null then c.PROJECT_ID else plan.proj_id end)=tal.orgId
     WHERE plan.APPROVAL_STATUS=''�����'' AND node.PLAN_END_DATE IS NOT NULL
     AND ACTUAL_END_DATE IS NULL AND SYSDATE = node.PLAN_END_DATE ' || v_where;
--     dbms_output.put_line(v_where);
--     dbms_output.put_line(v_completedtodaytask_sql);
     EXECUTE IMMEDIATE  v_completedtodaytask_sql into completedtodaytask;
	--�������
	v_todotodaytask_sql:='SELECT COUNT( * ) FROM POM_PROJ_PLAN_NODE node LEFT JOIN
    POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID 
    LEFT JOIN sys_project_stage    c ON c.id = plan.proj_id
    LEFT JOIN sys_project          d ON d.id = c.project_id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    on (case when c.id is not null then c.PROJECT_ID else plan.proj_id end)=tal.orgId
    WHERE plan.APPROVAL_STATUS=''�����''
	AND	SYSDATE = ACTUAL_END_DATE ' || v_where;
    EXECUTE IMMEDIATE  v_todotodaytask_sql into todotodaytask;
--    dbms_output.put_line(v_where);

END P_POM_PLAN_MONITOR_TASK_COUNT;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PLAN_MONITOR_TASK_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PLAN_MONITOR_TASK_LIST" (
    plantype    IN          VARCHAR2, --����������ƻ�����
    tabtype     IN          VARCHAR2, --�����������ѯ����//�������񡢽��մ��졢 �������
    pageIndex   IN          VARCHAR2,
    pageRows    IN          VARCHAR2,
    currentcompanyid   IN                 VARCHAR2,--��ǰ�û��Ĺ�˾
    userid             IN                 VARCHAR2,--�û�id���ڹ��˹�ע������
    currentstationid   IN                 VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid      IN                 VARCHAR2,---��ǰ�û��Ĳ���
    bizcode            IN                 VARCHAR2,---Ȩ��code
    items       OUT         SYS_REFCURSOR
) IS
    v_whre              CLOB;
    v_sql_exec          CLOB;
    nodestatus          VARCHAR2(20);
    v_nodeTime          CLOB;
    v_sql_exec_paging   CLOB;
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN
    --��������Ȩ����֤�洢����
    p_sys_auth_data_rule_spid(userid => userid, stationid => currentstationid, deptid => currentdeptid, companyid => currentcompanyid
    , bizcode => bizcode, data_auth_spid => v_spid);

    IF tabtype = '��������' THEN
        v_whre := ' AND ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE AND plan.PLAN_TYPE ='''
                  || plantype
                  || '''';
        v_nodeTime:='TO_CHAR(node.PLAN_END_DATE,''yyyy-mm-dd'') AS "nodeTime"';
        nodestatus := '�ѳ���';
    ELSIF tabtype = '���մ���' THEN
        v_whre := 'AND ACTUAL_END_DATE IS NULL AND SYSDATE = node.PLAN_END_DATE AND plan.PLAN_TYPE ='''
                  || plantype
                  || '''';
        v_nodeTime:='TO_CHAR(node.PLAN_END_DATE,''yyyy-mm-dd'') AS "nodeTime"';
        nodestatus := 'δ���';
    ELSE
        v_whre := 'AND SYSDATE = ACTUAL_END_DATE AND plan.PLAN_TYPE ='''
                  || plantype
                  || '''';
        v_nodeTime:='TO_CHAR(node.ACTUAL_END_DATE,''yyyy-mm-dd'') AS "nodeTime"';
        nodestatus := '�����';
    END IF;

    v_sql_exec := ' SELECT
    rownum as rowno,
	node.id AS "nodeId",
	node.ORIGINAL_NODE_ID AS "nodeOriginalId",
	--plan.plan_name,
	'''
                  || nodestatus
                  || ''' AS "nodeStatus",
	(node.node_name || ''��'' || stage.STAGE_FULL_NAME || ''��'') AS "nodeName",
    plan.plan_type as "nodePlanType",
	'||v_nodeTime||'

    FROM
	pom_proj_plan_node node
	LEFT JOIN pom_proj_plan plan ON node.proj_plan_id = plan.id
    LEFT JOIN SYS_PROJECT_STAGE stage on plan.proj_id=stage.id
    LEFT JOIN SYS_PROJECT proj
    on (case when stage.id is not null then stage.ID else plan.proj_id end)=proj.id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    ON (case when stage.id is not null then stage.PROJECT_ID else plan.proj_id end)=tal.orgId
where plan.ID is not null and plan.APPROVAL_STATUS=''�����'''
                  || v_whre;
    v_sql_exec_paging := '
select a.* from ( '
                         || v_sql_exec
                         || ' and rownum <= '
                         || pageIndex * pageRows
                         || ' ) a where a.rowno > '
                         || pageRows * ( pageIndex - 1 )
                         || '';

    dbms_output.put_line(v_sql_exec_paging);
    OPEN items FOR v_sql_exec_paging;

END p_pom_plan_monitor_task_list;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_PLAN_PERFROM_DYNAMIC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PLAN_PERFROM_DYNAMIC" 
(
		IN_ORG_ID    IN VARCHAR2
	 ,DATASCOPE    IN VARCHAR2
	 ,IN_PLAN_TYPE IN VARCHAR2
	 ,IN_PROJID    IN VARCHAR2
	 ,PAGEINDEX    IN INT
	 ,PAGESIZES    IN INT
	 ,P_PAGETYPE   IN INT
	 ,ITEMS        OUT SYS_REFCURSOR
	 ,TOTAL        OUT INT
) AS
		--����Ĳ�����������1��IN_ORG_ID����˾ID��
		--��2��DATASCOPE��ͳ���ڼ䣬3��ֵ��THIS_MONTH��THIS_QUARTER��THIS_YEAR"��
		--��3��PLAN_TYPE���ƻ����ͣ�Ԥ�������ƺ�����õĵ���
		--��4��P_PAGETYPE��ҳ�����ͣ�1�������� 2������� 3��Ӧ��ɣ�//alterby ��С��
		--�ؼ��ڵ�ƻ�-ִ�ж�̬��ѯ��wangck��Ҫ��
		--���ߣ�����
		--���ڣ�2019/12/07
		CURSOR CUR_COMPANY_LIST(V_ORG_ID SYS_BUSINESS_UNIT.ID%TYPE) IS
				SELECT P.ID, P.PARENT_ID, P.ORG_NAME FROM SYS_BUSINESS_UNIT P WHERE P.IS_COMPANY = 1 START WITH P.ID = V_ORG_ID CONNECT BY PRIOR P.ID = P.PARENT_ID;
		V_SQL_TOTAL     CLOB := ' ';
		V_SQL           CLOB := ' ';
		V_SQL_DATASCOPE CLOB := ' ';
		V_COMPANY_LIST  CLOB := ' ';
BEGIN

		DBMS_OUTPUT.PUT_LINE('��ʼ');
		--�¶�
		--������
		IF DATASCOPE = 'thisMonth'
			 AND P_PAGETYPE = 1
		THEN
				V_SQL_DATASCOPE := 'AND TRUNC(SYSDATE)>PN.PLAN_END_DATE  AND  PN.ACTUAL_END_DATE IS   NULL   AND PN.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when  TO_NUMBER(����_����) >1 then     TO_CHAR( A.����_����)  else   TO_CHAR( A.����_����-1) end   ||''-''||case when TO_NUMBER(����_����) >1 then  TO_CHAR( TO_NUMBER(����_����)-1) else''12'' end ||''-''||''26''  FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')  AND
 TO_DATE ((SELECT    A.����_����||''-''||����_����||''-''||''25'' FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')';
				--�¶�
				--�����
		ELSIF DATASCOPE = 'thisMonth'
					AND P_PAGETYPE = 2
		THEN
				V_SQL_DATASCOPE := ' AND  PN.ACTUAL_END_DATE IS  NOT NULL  AND PN.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when TO_NUMBER(����_����) >1 then     TO_CHAR( A.����_����)  else   TO_CHAR( A.����_����-1) end   ||''-''||case when  TO_NUMBER(����_����) >1 then  TO_CHAR( TO_NUMBER(����_����)-1) else''12'' end ||''-''||''26''  FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')  AND
 TO_DATE ((SELECT    A.����_����||''-''||����_����||''-''||''25'' FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')';

				--�¶�
				--Ӧ���

		ELSIF DATASCOPE = 'thisMonth'
					AND P_PAGETYPE = 3
		THEN
				V_SQL_DATASCOPE := 'AND PN.PLAN_END_DATE BETWEEN TO_DATE ((SELECT   case when TO_NUMBER(����_����) >1 then     TO_CHAR( A.����_����)  else   TO_CHAR( A.����_����-1) end   ||''-''||case when TO_NUMBER(����_����) >1 then  TO_CHAR( TO_NUMBER(����_����)-1) else''12'' end ||''-''||''26''  FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')  AND
 TO_DATE ((SELECT    A.����_����||''-''||����_����||''-''||''25'' FROM V_POM_GETEXAMINE_MOTH A),''yyyy-mm-dd'')';

				--����
				--������
		ELSIF DATASCOPE = 'thisQuarter'
					AND P_PAGETYPE = 1
		THEN
				V_SQL_DATASCOPE := ' AND TRUNC(SYSDATE)>PN.PLAN_END_DATE  AND  PN.ACTUAL_END_DATE IS   NULL    AND PN.PLAN_END_DATE BETWEEN
 TO_DATE((  SELECT A.��ʼ���||''-''||A.��ʼ�·�||''-26''   FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')  AND
 TO_DATE((  SELECT A.�������||''-''||A.�����·�||''-25'' FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')';
				--����
				--�����
		ELSIF DATASCOPE = 'thisQuarter'
					AND P_PAGETYPE = 2
		THEN
				V_SQL_DATASCOPE := 'AND  PN.ACTUAL_END_DATE IS  NOT NULL AND PN.PLAN_END_DATE BETWEEN
 TO_DATE((  SELECT A.��ʼ���||''-''||A.��ʼ�·�||''-26''   FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')  AND
 TO_DATE((  SELECT A.�������||''-''||A.�����·�||''-25'' FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')';
				--����
				--����Ӧ���
		ELSIF DATASCOPE = 'thisQuarter'
					AND P_PAGETYPE = 3
		THEN
				V_SQL_DATASCOPE := '  AND PN.PLAN_END_DATE BETWEEN
 TO_DATE((  SELECT A.��ʼ���||''-''||A.��ʼ�·�||''-26''   FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')  AND
 TO_DATE((  SELECT A.�������||''-''||A.�����·�||''-25'' FROM V_POM_GETEXAMINE_QUARTER A),''YYYY-MM-DD'')';
				--���
				--������
		ELSIF DATASCOPE = 'thisYear'
					AND P_PAGETYPE = 1
		THEN
				V_SQL_DATASCOPE := 'AND TRUNC(SYSDATE)>PN.PLAN_END_DATE  AND  PN.ACTUAL_END_DATE IS   NULL  
			 AND  PN.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "����_����"-1||''-12''||''-26'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "����_����"||''-12''||''-25'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH) ';
				--���
				--�����
		ELSIF DATASCOPE = 'thisYear'
					AND P_PAGETYPE = 2
		THEN
				V_SQL_DATASCOPE := 'AND  PN.ACTUAL_END_DATE IS  NOT NULL  
				 AND  PN.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "����_����"-1||''-12''||''-26'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "����_����"||''-12''||''-25'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH)  ';
				--���
				--Ӧ���
		ELSIF DATASCOPE = 'thisYear'
					AND P_PAGETYPE = 3
		THEN
				V_SQL_DATASCOPE := ' AND  PN.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "����_����"-1||''-12''||''-26'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "����_����"||''-12''||''-25'',''YYYY-MM-DD'') FROM V_POM_GETEXAMINE_MOTH) ';
				--ȫ����û��ʱ����
				--������
		ELSIF DATASCOPE = 'thisAll'
					AND P_PAGETYPE = 1
		THEN
				V_SQL_DATASCOPE := 'AND TRUNC(SYSDATE)>PN.PLAN_END_DATE  AND  PN.ACTUAL_END_DATE IS   NULL ';
				--�ƻ����нڵ�
		ELSIF DATASCOPE = 'thisAll'
					AND P_PAGETYPE = 2
		THEN
				V_SQL_DATASCOPE := ' AND   1=1 ';



		END IF;

		FOR ITEM_COMPANY_LIST IN CUR_COMPANY_LIST(IN_ORG_ID)
		LOOP
				/*DBMS_OUTPUT.PUT_LINE(ITEM_COMPANY_LIST.ORG_NAME || ',PARENT_ID' ||
        ITEM_COMPANY_LIST.PARENT_ID || ',ID:' ||
        ITEM_COMPANY_LIST.ID);*/
				V_COMPANY_LIST := V_COMPANY_LIST || '''' || ITEM_COMPANY_LIST.ID || '''' || ',';
		END LOOP;
		--   dbms_output.put_line(V_COMPANY_LIST);
		V_COMPANY_LIST := '(' || SUBSTR(V_COMPANY_LIST, 1, LENGTH(V_COMPANY_LIST) - 1) || ')';
		--     dbms_output.put_line(V_COMPANY_LIST);
		IF V_COMPANY_LIST = '()'
		THEN
				V_COMPANY_LIST := '(''' || IN_ORG_ID || ''')';
		END IF;
		--   dbms_output.put_line(V_COMPANY_LIST);
		V_SQL := V_SQL || 'SELECT PP.COMPANY_ID, PP.COMPANY_NAME AS COMPANY_NAME,PP.PROJ_name AS PROJ_NAME,PP.PLAN_NAME AS PLAN_NAME, PN.ID,PN.PROJ_PLAN_ID,PN.ORIGINAL_NODE_ID,CASE WHEN PN.IS_DISABLE = 0 THEN  PN.NODE_NAME ELSE  ''�����á�'' || PN.NODE_NAME END AS NODE_NAME, PN.NODE_CODE, PN.NODE_LEVEL, PN.PROJ_STAGE, PN.MAIN_RESPONSIBILITY, PN.DUTY_DEPARTMENT, TO_CHAR(PN.PLAN_START_DATE, ''yyyy-MM-dd'') AS PLAN_START_DATE, TO_CHAR(PN.PLAN_END_DATE, ''yyyy-MM-dd'') AS PLAN_END_DATE, PN.IS_DISABLE, PN.COMPLETION_STANDARD, PN.COMPLETION_RESULTS_REMARK, TO_CHAR(PN.ACTUAL_END_DATE, ''yyyy-MM-dd'') AS ACTUAL_END_DATE
	, case 
 --δ���ڲ�����
 WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
 --���ڵ�������ɷ���
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
 then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
	--����1-5������ɷ���
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
 then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
 --����δ�����Ƶ� 
 WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE)) >0
 THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>'' 
	--���ڳ���5��δ������� 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) >5) THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' 
 ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END
	AS PLAN_STATUS,PN.ESTIMATE_END_DATE,  nps.CHARGE_PERSON
	FROM  pom_proj_plan_node pn 
LEFT JOIN pom_proj_plan pp ON pn.proj_plan_id = pp.id 
LEFT JOIN  SYS_PROJECT_STAGE ps on  ps.id=pp.proj_id
LEFT JOIN SYS_PROJECT pj on  ps.PROJECT_ID =pj.id
LEFT JOIN(  SELECT  NODE_ID, listagg(CHARGE_PERSON,'','') WITHIN GROUP (ORDER BY CHARGE_PERSON )  as CHARGE_PERSON
	FROM POM_NODE_CHARGE_PERSON 
	GROUP BY NODE_ID) nps on  nps.NODE_ID=pn.id
	WHERE  PP.PLAN_TYPE = ''��Ŀ����ƻ�''  AND APPROVAL_STATUS = ''�����'' AND 1=1 AND PN.IS_DISABLE = 0 
	and  ((pp.proj_id =''' || IN_PROJID || ''' or pn.proj_plan_id=''' || IN_PROJID || '''  OR  pj.id=''' || IN_PROJID || ''' )
	OR PP.COMPANY_ID IN ' || V_COMPANY_LIST || ' ) ' || V_SQL_DATASCOPE || '  ORDER BY PN.PROJ_PLAN_ID,  PN.NODE_CODE';

		DBMS_OUTPUT.PUT_LINE(V_SQL);
		V_SQL_TOTAL := V_SQL_TOTAL || 'SELECT  TO_CHAR(COUNT(pn.ID))
	FROM  pom_proj_plan_node pn 
LEFT JOIN pom_proj_plan pp ON pn.proj_plan_id = pp.id 
LEFT JOIN  SYS_PROJECT_STAGE ps on  ps.id=pp.proj_id
LEFT JOIN SYS_PROJECT pj on  ps.PROJECT_ID =pj.id
LEFT JOIN(  SELECT  NODE_ID, listagg(CHARGE_PERSON,'','') WITHIN GROUP (ORDER BY CHARGE_PERSON )  as CHARGE_PERSON
	FROM POM_NODE_CHARGE_PERSON 
	GROUP BY NODE_ID) nps on  nps.NODE_ID=pn.id
	WHERE  PP.PLAN_TYPE = ''��Ŀ����ƻ�''  AND APPROVAL_STATUS = ''�����'' AND 1=1 
	and  ((pp.proj_id =''' || IN_PROJID || ''' or pn.proj_plan_id=''' || IN_PROJID || '''  OR  pj.id=''' || IN_PROJID || ''' )
	OR PP.COMPANY_ID IN ' || V_COMPANY_LIST || ' ) ' || V_SQL_DATASCOPE || '  ORDER BY PN.PROJ_PLAN_ID,  PN.NODE_CODE';

		--DBMS_OUTPUT.PUT_LINE(V_SQL_TOTAL);
		EXECUTE IMMEDIATE V_SQL_TOTAL
				INTO TOTAL;
		--   DBMS_OUTPUT.PUT_LINE(TOTAL);
		OPEN ITEMS FOR V_SQL;
END P_POM_PLAN_PERFROM_DYNAMIC;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PMP_NODE_COMP_RATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PMP_NODE_COMP_RATE" (
     tabType VARCHAR2,
     planType VARCHAR2,
     companyId VARCHAR2,
     nodeLevel VARCHAR2,
     currentcompanyid   IN                 VARCHAR2,--��ǰ�û��Ĺ�˾
     userid             IN                 VARCHAR2,--�û�id���ڹ��˹�ע������
     currentstationid   IN                 VARCHAR2,---��ǰ�û��ĸ�λ
     currentdeptid      IN                 VARCHAR2,---��ǰ�û��Ĳ���
     bizcode            IN                 VARCHAR2,---Ȩ��code
     pageRows INTEGER,
     pageIndex INTEGER,
     nodeList  OUT SYS_REFCURSOR
) IS 
v_condition varchar2(4000);
v_sql clob;
v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN 
v_condition:= ' AND 1=1';
IF(tabType is not null) THEN
    IF(tabType='��������')
        then  v_condition:=' and to_char(node.plan_end_date, ''yyyy-MM-dd'') <  to_char(sysdate, ''yyyy-MM-dd'') and node.actual_end_date is null order by node.plan_end_date desc'; 
    ELSIF(tabType='�����')
        then  v_condition:=' and node.actual_end_date is not null order by node.actual_end_date desc'; 
    END IF;
END IF;

--��������Ȩ����֤�洢����
    p_sys_auth_data_rule_spid(userid => userid, stationid => currentstationid, deptid => currentdeptid, companyid => currentcompanyid
    , bizcode => bizcode, data_auth_spid => v_spid);

v_sql:='SELECT *
  FROM (SELECT tt.*, ROWNUM AS rowno
    FROM (  
        select 
            node.id as "nodeId",
            node.original_node_id as "nodeOriginalId",
            node.node_name||''��''|| nvl(proj.project_name, projs.stage_full_name)  ||''��''  as "nodeName",
			plan.plan_type as "nodePlanType",
            case 
                when '''||tabType||'''=''��������'' then to_char(node.plan_end_date, ''yyyy-MM-dd'')
                when '''||tabType||'''=''�����'' then to_char(node.actual_end_date, ''yyyy-MM-dd'')
            end  as "nodeTime",
            case 
                when (to_char(node.plan_end_date, ''yyyy-MM-dd'') <  to_char(sysdate, ''yyyy-MM-dd'') and node.actual_end_date is null) then ''�ѳ���''
                when (node.actual_end_date is not null) then ''�����''
            end  as "nodeStatus"
        from pom_proj_plan_node node
        left join pom_proj_plan plan on node.proj_plan_id = plan.id
        left join sys_project proj on plan.proj_id = proj.id 
        left join sys_project_stage projs on plan.proj_id = projs.id
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=proj.id or tal.orgid=plan.company_id or tal.orgid = projs.id
        where tal.orgid is not null and  plan_type='''||planType||''' and plan.company_id in (select id from sys_business_unit unit start with unit.id='''||companyId||''' connect by prior unit.id=unit.parent_id) and node.node_level = '''||nodeLevel||''' and plan.approval_status = ''�����'''||v_condition||') tt
    WHERE ROWNUM <= '||pageRows||' * '||pageIndex||') table_alias
 WHERE table_alias.rowno >= '||pageRows||' * ('||pageIndex||'-1) + 1';
--dbms_output.put_line(v_sql);
open nodeList for v_sql;

END P_POM_PMP_NODE_COMP_RATE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PORTAL_ALREADY_MSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PORTAL_ALREADY_MSG" (
    bizid  in varchar2,
    info     OUT      SYS_REFCURSOR--��Ϣ����
) IS
--�Ż��������ݣ�����΢�š�������Ϣ��¼��ȡ
--���ߣ�����
--���ڣ�2020/02/13
BEGIN
    OPEN info FOR SELECT
                ------------------------------------------------------------����������Ϣ             
                      '71313f018a35f3a558166cba7599b5d6' AS "systemId",--ϵͳid
                      'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",--Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶΣ�
                 ------------------------------------------------------------ҵ��䶯������Ϣ   
                      'bizid' AS "bizKey",--ҵ��id
                       'tjWeChat,tjSMS' AS "msgChannel",--ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
                     ------------------------------------------------------------���ű������
                      '40010' AS "smsTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
                      '["1","2","3","4"]' AS "smsParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��˵��{1}Ϊ���ĵ�¼��֤�룬����{2}��������д����Ǳ��˲���������Ա����š�
                      '13896186104' as "mobile",--���Ž����˵绰
                      ------------------------------------------------------------΢�ű������
                      '40011' AS "wechatTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
                      '["1","2","3","4"]' AS "wechatParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��˵��{1}Ϊ���ĵ�¼��֤�룬����{2}��������д����Ǳ��˲���������Ա����š�
                       '///' AS "wechatJumplinkUrl",--΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
                      'v-xufeng' AS "recipientAccount",--������usercode�磺a-xiexuhua
                 ------------------------------------------------------------��Ϣ��¼��׷����Ϣ
                       '�����¶ȼƻ�����Ԥ��' AS "title",--��Ϣ����
                      'v-xufeng' AS "senderAccount",--������usercode�磺a-xiexuhua
                      '�¶ȼƻ�' AS "bizSourceCategory",--ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
                      'Ԥ����Ϣ' AS "bizMsgCategory"--��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
                  FROM
                      dual;

END p_pom_portal_already_msg;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PORTAL_MSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PORTAL_MSG" (
    messagetype   OUT           VARCHAR2,     --0:�Ż��ն���Ϣ�����ͣ�1��ֻ�����Ż���2��ֻ���Ͷ��Ż�΢��
    info          OUT           SYS_REFCURSOR--��Ϣ����
) IS
BEGIN
    messagetype := 0;
    OPEN info FOR
    
--    --������������
--				SELECT 0 AS "msgType", A.ORIGINAL_NODE_ID AS "taskId", B1.USER_ACCOUNT AS "ownerName", 'v-xufeng' AS "creatorName",
--							 'http://pom.crccre.cn/pom/pom/middle?originalUrl=' ||
--								URL_ENCODE('http://pom.crccre.cn/pom/pom/mission-center-feedback/my-responsible-task?cancelType=0' || CHR(38) || 'id=' || A.PROJ_PLAN_ID || CHR(38) || 'feedbackNodeId=' || A.ID ||
--													 CHR(38) || 'feedbackNodeOriginalId=' || A.ORIGINAL_NODE_ID || CHR(38) || 'nodeSourcePlanType=1') AS "pcUrl", '' AS "mobileUrl", SYSDATE AS "created",
--							 TRUNC(SYSDATE) + 1 AS "expireTime", '���ڵ㳬��Ԥ������' || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME || '������' || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) || '��Ԥ��' AS "taskName",
--							 '�ƻ���Ӫ' AS "typeName",1 AS "priority", '' AS "remark"
--, 'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "sourceAppId",meg.MESSAGE_MSG_TYPE AS "messageMsgType"
--				FROM   V_POM_NODE_DT A
--				LEFT   JOIN SYS_ROLE_USER_RELATION_RESULT B1
--				ON     B1.DEPT_ID = A.DUTY_DEPARTMENT_ID AND
--							 B1.VIRTUAL_GROUP_NAME = '���żƻ�רԱ'
--				LEFT JOIN SYS_MESSAGE_CENTER meg
--				ON meg.TASK_ID=A.id AND meg.CREATED-SYSDATE=0
--				WHERE  A.FINISH_NO_STATUS_TYPE = '����δ���' AND
--							 NOT EXISTS (SELECT 1
--								FROM   SYS_MESSAGE_CENTER_PUSH_RECORD P
--								WHERE  P.RESPONSE_RESULTS LIKE '%{"errcode":0%' AND
--											 TRUNC(SYSDATE) - TRUNC(P.REQUEST_TIME) = 0 AND
--											 A.ID = P.TASK_ID AND
--											 B1.USER_ACCOUNT = P.OWNER_NAME) AND
--							 B1.USER_ACCOUNT IS NOT NULL AND b1.USER_ACCOUNT = 'zhangzhuohan';

     SELECT
            ------------------------------------------------------------�����������ݡ����롿�������Ż���վ���豸��Ϣ���������ã�------------------------------------------------------------ 
                      'v-xufeng'   AS "senderAccount",--������usercode�磺a-xiexuhua,---�Ż���վ��creatorName
                      B1.USER_ACCOUNT       AS "recipientAccount",--������usercode�磺a-xiexuhua--�Ż���վ��ownerName
                      'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",--Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶ�---�Ż���վ��sourceAppId
                      '71313f018a35f3a558166cba7599b5d6' AS "systemId",--ϵͳid
                      A.ORIGINAL_NODE_ID||B1.USER_ACCOUNT   AS "bizKey",--ҵ��id--�Ż���վ��taskId
                      '����Ԥ��' AS "bizMsgCategory",--��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
            ------------------------------------------------------------�豸��Ϣ���ÿ�ʼ------------------------------------------------------------ 
            ------------------------------------------------------------������΢�ű��롿������Ϣ
                      'tjSMS,tjWeChat' AS "msgChannel",--ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
                        ------------�����ű��롿����
                      '400013' AS "smsTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  
                      --{1}���ã������������{2}���ѳ���{3}�죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
                      '["'
                      || B1.USER_NAME
                      || '","'
                      || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME
                      || '","'
                      || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) 
                      || '",""]' AS "smsParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
                      MOBILE_PHONE   AS "mobile",--���Ž����˵绰
                        ------------��΢�ű��롿����
                      '400013' AS "wechatTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
                      '["'
                      || B1.USER_NAME
                      || '","'
                      || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME
                      || '","'
                      || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) 
                      || '",""]' AS "wechatParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
                      'http://pom.crccre.cn/pom/wfi/bridge?jumpUrl=http%3a%2f%2fpom.crccre.cn%2fpom-h5%2fwfi%2fhow-to-read%3FinformationId%3D1786238shizebin%26bizUrl%3D'
                      || url_encode('http://pom.crccre.cn/pom-h5/pom/task-details?feedbackNodeId='||A.ORIGINAL_NODE_ID||'%26nodeSourcePlanType=KEY_NODE%26feedbackNodeOriginalId='||A.ORIGINAL_NODE_ID||'')||'&remoteUrl=aHR0cDovL3BvbS5jcmNjcmUuY24vcG9t'  AS "wechatJumplinkUrl",--΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
                        ------------��Ϣ��¼����׷����Ϣ
                      '���ڵ㳬��Ԥ������' || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME || '������' || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) || '��Ԥ��' AS "title",--��Ϣ����
                      '���ڵ㳬��Ԥ������' || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME || '������' || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) || '��Ԥ��' AS "bizSourceCategory",--ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
            ------------------------------------------------------------�豸��Ϣ���ý���------------------------------------------------------------ 
            ------------------------------------------------------------�����Ż���վ��Ϣ------------------------------------------------------------ 
                --taskid	��	String	����ID---------------------�����Ż���վ��1���������/2�������Ѱ�taskid��3���������/4����������informationid��5�������ҵĹ�ע��informationid
                --creatorname	��	String	������
                --ownername	��	String	ӵ����
                --sourceAppId	��	String	����Ӧ�õ�appId
                      0 "portalMsgType", --�����Ż���վ��Ϣ���ͣ�0������,1:�Ѱ죬10�����ģ�11:���ģ�20����ע��--�Ѱ죬��Ҫ�ȸ���bizKeyɾ�����죬���Ľӿ���Ҫ����bizKey���ü��Ŵ���ɾ���ӿ�
                      'http://pom.crccre.cn/pom/pom/middle?originalUrl=' ||
								URL_ENCODE('http://pom.crccre.cn/pom/pom/mission-center-feedback/my-responsible-task?cancelType=0' || CHR(38) || 'id=' || A.PROJ_PLAN_ID || CHR(38) || 'feedbackNodeId=' || A.ID ||
													 CHR(38) || 'feedbackNodeOriginalId=' || A.ORIGINAL_NODE_ID || CHR(38) || 'nodeSourcePlanType=1') "url",--url	��	String	Ӧ��ϵͳ��url��ַ
                    --http://pom.crccre.cn/pom/wfi/bridge?jumpUrl=http%3A%2F%2Fpom.crccre.cn%2Fpom-h5%2Fwfi%2Fhow-to-read%3FinformationId%3D1786238shizebin%26bizUrl%3Dhttp%253A%252F%252Fpom.crccre.cn%252Fpom-h5%252Fwfi%252Fprocess-info%253FrootProcInstId%253D288110%2526item_id%253Dd6c370aa-ddd6-40b9-95de-6fc25fdef1f0%2526actInstID%253D1990892%2526procInstId%253D288110%2526workItemId%253D1786238&remoteUrl=aHR0cDovL3BvbS5jcmNjcmUuY24vcG9t
                      'http://pom.crccre.cn/pom/wfi/bridge?jumpUrl=http%3a%2f%2fpom.crccre.cn%2fpom-h5%2fwfi%2fhow-to-read%3FinformationId%3D1786238shizebin%26bizUrl%3D'
                      || url_encode('http://pom.crccre.cn/pom-h5/pom/task-details?feedbackNodeId='||A.ORIGINAL_NODE_ID||'%26nodeSourcePlanType=KEY_NODE%26feedbackNodeOriginalId='||A.ORIGINAL_NODE_ID||'')||'&remoteUrl=aHR0cDovL3BvbS5jcmNjcmUuY24vcG9t' as "mobileUrl",--mobileUrl	��	String	Ӧ��ϵͳ���ֻ���url��ַ
                       '���ڵ㳬��Ԥ������' || A.PROJ_NAME || '-' || A.PLAN_TYPE || '-' || A.NODE_NAME || '������' || TO_CHAR(TRUNC(SYSDATE) - A.PLAN_END_DATE) || '��Ԥ��' as "taskname",--taskname	��	String	�������ƣ�����3���������/4����������informationname;���ڲ����ע��attentionname
                      '�ƻ���Ӫ' "typename",--typename	��	String	��������
                      A.ORIGINAL_NODE_ID||B1.USER_ACCOUNT         "remark",--remark	��	String	��ע

              ----------------------------------------------
              -----������ע�����С�
                      SYSDATE          "expiretime",--expiretime	��	String	����ʱ�䣬��ʽyyyy-MM-dd HH:mm:ss-----����ʱ�䣬����ע����
                      1 "priority"--priority	��	Integer	���ȼ�������ע����
                      FROM   V_POM_NODE_DT A
				LEFT   JOIN SYS_ROLE_USER_RELATION_RESULT B1
				ON     B1.DEPT_ID = A.DUTY_DEPARTMENT_ID AND
							 B1.VIRTUAL_GROUP_NAME = '���żƻ�רԱ'
				LEFT JOIN SYS_MESSAGE_CENTER meg
				ON meg.TASK_ID=A.id AND meg.CREATED-SYSDATE=0
                left join sys_user u on  B1.USER_ACCOUNT=u.USER_CODE
				WHERE  A.FINISH_NO_STATUS_TYPE = '����δ���' AND
							 NOT EXISTS (SELECT 1
								FROM   SYS_MESSAGE_CENTER_PUSH_RECORD P
								WHERE  P.RESPONSE_RESULTS LIKE '%{"errcode":0%' AND
											 TRUNC(SYSDATE) - TRUNC(P.REQUEST_TIME) = 0 AND
											 A.ID = P.TASK_ID AND
											 B1.USER_ACCOUNT = P.OWNER_NAME)
                                             AND
							 B1.USER_ACCOUNT IS NOT NULL 
                             --AND b1.USER_ACCOUNT = 'zhangzhuohan'
                             ;

END p_pom_portal_msg;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PREDICT_DELAY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PREDICT_DELAY" (planType in VARCHAR2
,dataScope in VARCHAR2
,searchKey in VARCHAR2
,orgId  in VARCHAR2
,currentDelay OUT sys_refcursor)
AS
BEGIN
open currentDelay for
SELECT
    p.COMPANY_NAME as  "orgName",
    proj_name as "projName",
    node_name as "nodeName",
    '' as "projOpenUrl",
    '' as "nodeOpenUrl",
    ROUND(TO_NUMBER(plan_end_date-sysdate)) as "delayDays"
FROM
    pom_proj_plan_node n
    left join
    pom_proj_plan p  on  n.proj_plan_id=p.id where proj_name is not null;


END p_pom_predict_delay;




/
--------------------------------------------------------
--  DDL for Procedure P_POM_PROJ_BY_KEY_NODE_PLAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PROJ_BY_KEY_NODE_PLAN" 
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
   from (SELECT
       *
   FROM sys_project where id in( select PROJ_ID from basedata )) proj
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

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PROJ_PLAN_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PROJ_PLAN_DATA" (
    condition     IN            VARCHAR2,--�������;��Ŀ����id   ר��ƻ����벿��id �����ƻ�������Ŀid
    companyid     IN            VARCHAR2,--��ǰ�û���˾
    stationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    deptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    bizcode       IN            VARCHAR2,---Ȩ��code
    userid        IN            VARCHAR2,---��ǰ�û�id
    pageindex     IN            INT,
    search1       IN            VARCHAR2, --������� ��ѯ����
    pagesizes     IN            INT,
    currenttype   IN            INT,--
    plantype      IN            VARCHAR2, --�ƻ�����
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
  --  tabledata          OUT           SYS_REFCURSOR
) IS
--ר��ƻ������мƻ���ȫ�̿����ƻ�����Ŀ����ƻ��б�����
--���ߣ�������
--���ڣ�2019/12/11

--���ģ��ͺ���
--���ڣ�2020/4/14

    v_sql              CLOB;
    v_sql_exec         CLOB;
    v_spid             VARCHAR2(200);---������֤spid
    v_where            VARCHAR2(4000);
    testmsg            NVARCHAR2(4000);
    v_maintable        NVARCHAR2(100);
    v_subtable         NVARCHAR2(100);
    v_middlesql        VARCHAR2(4000);   --��ר��ƻ�ʹ�á��������ֵ�������ƻ����ֶβ����ƴ��
    v_middlesql2       VARCHAR2(4000);
    quarantine_rule   VARCHAR2(50) :='';
    v_auth_sql         VARCHAR2(4000) :=' where 1=1';
    v_isneed_proj      VARCHAR2(200);  --�Ƿ���Ҫproj��������
BEGIN
     OPEN items FOR select ''||companyid||'' as companyid,
    ''||stationid||'' as  stationid,
    ''||deptid||'' as  deptid,
     ''||condition||'' as  condition,
      ''||userid||'' as  userid
    from dual;

----------------------------------------------------ͳһ����
    testmsg := 'condition:'
               || condition
               || '��pageindex:'
               || pageindex
               || '��pagesizes:'
               || pagesizes
               || '��currenttype:'
               || currenttype;

    BEGIN
        total := 1000;


    --ִ������Ȩ�޴洢���̡��õ���ʱ��id �û�����ʱ���Ȩ
 --���ò�ѯ����Ȩ�޵Ĵ洢����,����spid
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => stationid,
            DEPTID => deptid,
            COMPANYID => companyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
--        OPEN tabledata FOR select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = v_spid;
       -- OPEN tabledata FOR select * from SYS_PROJECT_STAGE sps   inner join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') ta on sps.project_id=ta.orgid;
        --ƴ��Ȩ����֤sql
        v_auth_sql:=' left join SYS_PROJECT_STAGE projs on pp.proj_id=projs.id
                    --����Ȩ�ޱ���
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') org
                    on (case when projs.id is not null then projs.PROJECT_ID else pp.proj_id end)=org.orgId
                    --������Ȩ���ֶ�Ϊ�ձ�ʾû��Ȩ��
                    where org.orgId is not null ';
         -- v_auth_sql:=' inner join SYS_PROJECT_STAGE sps on pp.proj_id=sps.id inner join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') ta on sps.project_id=ta.orgid or pp.proj_id=ta.orgid where ta.orgid is not null ';

    IF ( plantype <> 'ר��ƻ�' ) THEN
--      IF(quarantine_rule='����')THEN
--        v_auth_sql:=v_auth_sql||' proj_id='''||companyid||'''';
--    END IF;

          v_isneed_proj := ',a.proj_name';

    --��Ŀ����ƻ������мƻ�����׼�ڵ�ƻ���ȫ�̿����ƻ�
        IF ( currenttype = 0 ) THEN
    --��ǰʹ�ð汾
            v_maintable := 'POM_PROJ_PLAN ';
            v_subtable := 'POM_PROJ_PLAN_NODE';
            v_middlesql := ' ps.cnt1 as finish_count,
    ps.cnt2 as not_ebd_count,
    ps.cnt3 as template_node_count,
    ps.cnt4 as user_add_node_count,
    ps.cnt6-ps.cnt7 as valid_node_count,
    ps.cnt6 as node_count,
    ps.cnt7 as disable_count,'
            ;
            v_middlesql2 := ' left join(   select proj_plan_id,IS_DELETE,
    sum(case when n.ACTUAL_END_DATE is not null and n.IS_DISABLE=0 then 1  else 0 end) as cnt1, --�����
    sum(case when n.ACTUAL_END_DATE is null and n.IS_DISABLE=0  then 1 else 0 end) as cnt2,--δ���
    sum(case when n.TEMPLATE_NODE_ID is not null then 1 else 0 end) as cnt3,--ģ��ڵ�
    sum(case when n.STANDARD_NODE_ID is null and n.TEMPLATE_NODE_ID is null then 1 else 0 end) as cnt4,--�����ڵ�
    sum(case when n.TEMPLATE_NODE_ID is not null then 1 else 0 end) + sum(case when n.STANDARD_NODE_ID is null and n.TEMPLATE_NODE_ID is null then 1 else 0 end) as cnt5,
    count(*) as cnt6,--����ڵ�
    sum(case when n.IS_DISABLE=1 then 1 else 0 end) cnt7
    from '
                            || v_subtable
                            || '  n GROUP by proj_plan_id,IS_DELETE )ps on pp.id=ps.proj_plan_id '||v_auth_sql;


            v_where := ' and ps.IS_DELETE = 0 and
            (Approval_Status = ''�����'' or (Approval_Status != ''�����'' and plan_version =''1''))and plan_type='''
                       || plantype
                       || '''  and (plan_name like ''%'
                       || search1
                       || '%'' or creator like ''%'
                       || search1
                       || '%'')';
            IF(condition!='Ĭ��')THEN
               v_where:=v_where||' and COMPANY_ID='''
                       || condition
                       || '''';
            END IF;
        ELSE
    --��ʷ�����汾
            v_maintable := 'POM_PROJ_PLAN_HISTORY';
            v_subtable := 'POM_PROJ_PLAN_NODE_HISTORY';
            v_where := ' and COMPANY_ID='''
                       || condition
                       || ''' and plan_type='''
                       || plantype
                       || '''  and (plan_name like ''%'
                       || search1
                       || '%'' or creator like ''%'
                       || search1
                       || '%'')';

            v_middlesql := ' ps.cnt6 as node_count,';
    --��ʱδ��ѯ �������������������޸����������� ��������
            v_middlesql2 := ' left join(   select proj_plan_id,
    count(*) as cnt6 --����ڵ�
    from '
                            || v_subtable
                            || '  n GROUP by proj_plan_id )ps on pp.id=ps.proj_plan_id '||v_auth_sql;
        END IF;

        v_sql := 'SELECT
    rownum as rowno,
    pp.id as id,
    original_plan_id,
    template_id,
    plan_name,
    plan_version,
     (''v'' || to_char(plan_version,''0.0'')) verson,
    company_id,
    company_name,
    proj_id,
    proj_name,
    plan_type,
    approval_status,
    approver_id,
    to_char(approval_time,''yyyy-MM-dd'') as approval_time,
    other_remark,
    to_char(created,''yyyy-MM-dd'') as created,
     case plan_version when plan_version then (plan_version-1) end as adjuest_Number,
    creator_id,
    creator,
    to_char(modified,''yyyy-MM-dd'') as modified,
    modifier_id,
    modifier,
    adjust_source_id,
    adjust_subject,
    adjust_remark,
    '
                 || v_middlesql
                 || ' approver FROM '
                 || v_maintable
                 || ' pp '
                 || v_middlesql2
                 || v_where
                 || '' ;

    ELSE
    --ר��ƻ�
        IF ( currenttype = 0 ) THEN
--          IF(quarantine_rule='����')THEN
--             v_auth_sql:=v_auth_sql||' and (company_id='''||companyid||''' or department_id='''||deptid||''')';
--          END IF;

          v_isneed_proj := '';

          --��ǰʹ�ð汾
            v_where := ' and DEPARTMENT_ID='''
                       || condition
                       || ''' and (Approval_Status = ''�����'' or (Approval_Status != ''�����'' and plan_version =''1'')) and (plan_name like ''%'
                       || search1
                       || '%'' or creator like ''%'
                       || search1
                       || '%'')';
            v_maintable := 'POM_SPECIAL_PLAN';
            v_subtable := 'POM_SPECIAL_PLAN_NODE';
        ELSE
            --��ʷ�����汾
            v_where := ' and DEPARTMENT_ID='''
                       || condition
                       || ''' and (plan_name like ''%'
                       || search1
                       || '%'' or creator like ''%'
                       || search1
                       || '%'')';

            v_maintable := 'POM_SPECIAL_PLAN_HIST';
            v_subtable := 'POM_SPECIAL_PLAN_NODE_HIST';
        END IF;

        v_sql := '
    select
    distinct
    rownum as rowno,
    ps.id,
    template_id,
    plan_name,
    plan_subclass,
    (''v'' || to_char(plan_version,''0.0'')) verson,
    company_id,
    company_name,
    department_id,
    department_name,
    remark,
    approval_status,
    approver_id,
    to_char(approval_time,''yyyy-MM-dd'') as approval_time,
    to_char(created,''yyyy-MM-dd'') as created,
    creator_id,
    creator,
    to_char(modified,''yyyy-MM-dd'') as modified,
    modifier_id,
    modifier,
    approver,
    original_plan_id,
    plan_version,
    adjust_theme,
    adjust_remark,
    is_delete,
    case plan_version when plan_version then (plan_version-1) end as adjuest_Number,
    case when  pn.cnt1 is null then 0 else pn.cnt1 end as finish_count,
    case when  pn.cnt2 is null then 0 else pn.cnt2 end as not_ebd_count,
    case when  pn.cnt3 is null then 0 else pn.cnt3 end as node_count
    FROM '
                 || v_maintable
                 || '
     ps left join (
    SELECT
    plan_id,
     sum(case  when n.ACTUAL_END_DATE is not null then 1 else 0 end) as cnt1,--�������
     sum(case  when n.ACTUAL_END_DATE is null then 1 else 0 end) as cnt2,--δ����,
         count(*) as cnt3
FROM
    '
                 || v_subtable
                 || ' n
    group by plan_id) pn on ps.id=pn.plan_id  where 1=1 '
                 || v_where
                 || '';

    END IF;


v_sql_exec := '
            select s1.order_hierarchy_code as sort_code, a.* from ( '
                  || v_sql
                  || ' AND rownum <= '
                  || pageindex * pagesizes
                  || ' ) a left join SYS_BUSINESS_UNIT s1 on a.company_id = s1.id
                  where a.rowno >= '
                  || pagesizes * ( pageindex - 1 )
                  || ' order by sort_code '
                  || v_isneed_proj;


    dbms_output.put_line(v_sql_exec);
----��ȡ������
    EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                      || v_sql
                      || ') a '
    INTO total;

-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
    OPEN items FOR v_sql_exec;

EXCEPTION
    WHEN OTHERS THEN
        testmsg := sqlerrm || testmsg;
        OPEN items FOR SELECT
                           'ʧ��'
                       FROM
                           dual;

        dbms_output.put_line(sqlerrm);
        end;
END p_pom_proj_plan_data;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PROJ_PLAN_DTL_CONDITION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PROJ_PLAN_DTL_CONDITION" (
    userid                 IN                     VARCHAR2,--�û�id
    planid                 IN                     VARCHAR2,--�ƻ�id
    conditiontype          IN                     VARCHAR2,--��������0:�ڵ㼶��1����˾ID
    condition              IN                     VARCHAR2,--��������˾ID���ڵ㼶��
    total                  out              number,
    pageindex     IN            INT,
    pagesizes     IN            INT,
    items           out SYS_REFCURSOR      --�ƻ���ϸһ����
) AS
--��Ŀ����ƻ���أ�����ҳ ����ϸ
--���ߣ�Ҷ����
--���ڣ�2020/04/15
v_sql_exec   CLOB;
v_sql_exec_paging  CLOB;
BEGIN
----�ƻ���ϸһ����
total:=100;
    IF conditiontype='0' THEN
      v_sql_exec:= '
        SELECT
          rownum,
         a.PROJ_ID AS "PROJ_ID"
         ,a.PROJ_NAME AS "PROJ_NAME"
         ,a.PROJ_PLAN_ID AS "PROJ_PLAN_ID"
         ,a.NODE_ID AS "NODE_ID"
         ,a.PLAN_ID AS "PLAN_ID"
         ,a.PLAN_TYPE AS "PLAN_TYPE"
         ,a.ORIGINAL_NODE_ID AS "ORIGINAL_NODE_ID"
         ,CASE a.WARNING_STATUS
         WHEN ''���'' THEN
            ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
         WHEN ''�̵�'' THEN
            ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
         WHEN ''�Ƶ�'' THEN
            ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
        ELSE NULL
         END AS "WARNING_STATUS"
         ,case when b.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as "IS_UN_WATCH"
        ,case when a.ACTUAL_END_DATE is null then ''�߰�'' else null end as "HASTEN"
         ,a.NODE_CODE AS "NODE_CODE"
         ,a.NODE_NAME AS "NODE_NAME"
         ,a.NODE_LEVEL AS "NODE_LEVEL"
         ,a.DUTY_DEPARTMENT AS "DUTY_DEPARTMENT"
         ,a.DUTY_MANS AS "DUTY_MANS"
         ,a.FINISH_STATUS AS "FINISH_STATUS"
         ,a.STANDARD_SCORE AS "STANDARD_SCORE"
         ,a.PLAN_START_DATE AS "PLAN_START_DATE"
         ,a.PLAN_END_DATE AS "PLAN_END_DATE"
         ,a.ACTUAL_START_DATE AS "ACTUAL_START_DATE"
         ,a.ACTUAL_END_DATE AS "ACTUAL_END_DATE"
         ,a.ESTIMATE_END_DATE AS "ESTIMATE_END_DATE"
         ,a.PROCESS_FEED_BACK_CON AS "PROCESS_FEED_BACK_CON"
         ,a.FINISH_FEED_BACK_CON AS "FINISH_FEED_BACK_CON"
         ,a.OVERDUE_FEED_BACK_CON AS "OVERDUE_FEED_BACK_CON"
         ,a.NODE_FLAG AS "NODE_FLAG"
         ,a.ESTIMATE_BEYOND_NODE_FLAG AS "ESTIMATE_BEYOND_NODE_FLAG"
         ,a.COMPLETION_STANDARD AS "COMPLETION_STANDARD"
         ,a.COMPLETION_RESULTS_REMARK AS "COMPLETION_RESULTS_REMARK"
         --,nvl(b.IS_UN_WATCH,1) as  "IS_UN_WATCH"
         ,to_char(a.PLAN_START_DATE, ''YYYY-mm-dd'') as "PLAN_START_TIME"
         ,to_char(a.PLAN_END_DATE, ''YYYY-mm-dd'') as "PLAN_END_TIME"
         ,to_char(a.ACTUAL_START_DATE, ''YYYY-mm-dd'') as "ACTUAL_START_TIME"
         ,to_char(a.ACTUAL_END_DATE, ''YYYY-mm-dd'') as "ACTUAL_END_TIME"
         ,to_char(a.ESTIMATE_END_DATE, ''YYYY-mm-dd'') as "ESTIMATE_END_TIME"
          ,b.UN_WATCH_TIME  ,b.WATCH_TIME
      FROM  v_pom_proj_monitor_node_list  a
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID='''||userid||''' --and   b.WATCH_TIME is  not   null
      WHERE     a.PLAN_ID='''||planid||''' AND a.NODE_LEVEL='''||condition||'''    ' ;
    ELSE
        IF condition='δָ��������' THEN
            v_sql_exec:= '
                 SELECT
                 rownum,
                 a.PROJ_ID AS "PROJ_ID"
                 ,a.PROJ_NAME AS "PROJ_NAME"
                 ,a.PROJ_PLAN_ID AS "PROJ_PLAN_ID"
                 ,a.NODE_ID AS "NODE_ID"
                 ,a.PLAN_ID AS "PLAN_ID"
                 ,a.PLAN_TYPE AS "PLAN_TYPE"
                 ,a.ORIGINAL_NODE_ID AS "ORIGINAL_NODE_ID"
                 ,CASE a.WARNING_STATUS
                 WHEN ''���'' THEN
                    ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                 WHEN ''�̵�'' THEN
                    ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                 WHEN ''�Ƶ�'' THEN
                    ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                ELSE NULL
                 END AS "WARNING_STATUS"
                 ,case when b.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as "IS_UN_WATCH"
                ,case when a.ACTUAL_END_DATE is null then ''�߰�'' else null end as  "HASTEN"
                 ,a.NODE_CODE AS "NODE_CODE"
                 ,a.NODE_NAME AS "NODE_NAME"
                 ,a.NODE_LEVEL AS "NODE_LEVEL"
                 ,a.DUTY_DEPARTMENT AS "DUTY_DEPARTMENT"
                 ,a.DUTY_MANS AS "DUTY_MANS"
                 ,a.FINISH_STATUS AS "FINISH_STATUS"
                 ,a.STANDARD_SCORE AS "STANDARD_SCORE"
                 ,a.PLAN_START_DATE AS "PLAN_START_DATE"
                 ,a.PLAN_END_DATE AS "PLAN_END_DATE"
                 ,a.ACTUAL_START_DATE AS "ACTUAL_START_DATE"
                 ,a.ACTUAL_END_DATE AS "ACTUAL_END_DATE"
                 ,a.ESTIMATE_END_DATE AS "ESTIMATE_END_DATE"
                 ,a.PROCESS_FEED_BACK_CON AS "PROCESS_FEED_BACK_CON"
                 ,a.FINISH_FEED_BACK_CON AS "FINISH_FEED_BACK_CON"
                 ,a.OVERDUE_FEED_BACK_CON AS "OVERDUE_FEED_BACK_CON"
                 ,a.NODE_FLAG AS "NODE_FLAG"
                 ,a.ESTIMATE_BEYOND_NODE_FLAG AS "ESTIMATE_BEYOND_NODE_FLAG"
                 ,a.COMPLETION_STANDARD AS "COMPLETION_STANDARD"
                 ,a.COMPLETION_RESULTS_REMARK AS "COMPLETION_RESULTS_REMARK"
                 --,nvl(b.IS_UN_WATCH,1) as  "IS_UN_WATCH"
                 ,to_char(a.PLAN_START_DATE, ''YYYY-mm-dd'') as "PLAN_START_TIME"
                 ,to_char(a.PLAN_END_DATE, ''YYYY-mm-dd'') as "PLAN_END_TIME"
                 ,to_char(a.ACTUAL_START_DATE, ''YYYY-mm-dd'') as "ACTUAL_START_TIME"
                 ,to_char(a.ACTUAL_END_DATE, ''YYYY-mm-dd'') as "ACTUAL_END_TIME"
                 ,to_char(a.ESTIMATE_END_DATE, ''YYYY-mm-dd'') as "ESTIMATE_END_TIME"
                  ,b.UN_WATCH_TIME  ,b.WATCH_TIME
              FROM  v_pom_proj_monitor_node_list  a
              LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID='''||userid||''' --and   b.WATCH_TIME is  not   null
              WHERE     a.PLAN_ID='''||planid||''' ' ;
        ELSE
           v_sql_exec:= '
                 SELECT
                 rownum,
                 a.PROJ_ID AS "PROJ_ID"
                 ,a.PROJ_NAME AS "PROJ_NAME"
                 ,a.PROJ_PLAN_ID AS "PROJ_PLAN_ID"
                 ,a.NODE_ID AS "NODE_ID"
                 ,a.PLAN_ID AS "PLAN_ID"
                 ,a.PLAN_TYPE AS "PLAN_TYPE"
                 ,a.ORIGINAL_NODE_ID AS "ORIGINAL_NODE_ID"
                 ,CASE a.WARNING_STATUS
                 WHEN ''���'' THEN
                    ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                 WHEN ''�̵�'' THEN
                    ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                 WHEN ''�Ƶ�'' THEN
                    ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                ELSE NULL
                 END AS "WARNING_STATUS"
                 ,case when b.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as "IS_UN_WATCH"
                ,case when a.ACTUAL_END_DATE is null then ''�߰�'' else null end as  "HASTEN"
                 ,a.NODE_CODE AS "NODE_CODE"
                 ,a.NODE_NAME AS "NODE_NAME"
                 ,a.NODE_LEVEL AS "NODE_LEVEL"
                 ,a.DUTY_DEPARTMENT AS "DUTY_DEPARTMENT"
                 ,a.DUTY_MANS AS "DUTY_MANS"
                 ,a.FINISH_STATUS AS "FINISH_STATUS"
                 ,a.STANDARD_SCORE AS "STANDARD_SCORE"
                 ,a.PLAN_START_DATE AS "PLAN_START_DATE"
                 ,a.PLAN_END_DATE AS "PLAN_END_DATE"
                 ,a.ACTUAL_START_DATE AS "ACTUAL_START_DATE"
                 ,a.ACTUAL_END_DATE AS "ACTUAL_END_DATE"
                 ,a.ESTIMATE_END_DATE AS "ESTIMATE_END_DATE"
                 ,a.PROCESS_FEED_BACK_CON AS "PROCESS_FEED_BACK_CON"
                 ,a.FINISH_FEED_BACK_CON AS "FINISH_FEED_BACK_CON"
                 ,a.OVERDUE_FEED_BACK_CON AS "OVERDUE_FEED_BACK_CON"
                 ,a.NODE_FLAG AS "NODE_FLAG"
                 ,a.ESTIMATE_BEYOND_NODE_FLAG AS "ESTIMATE_BEYOND_NODE_FLAG"
                 ,a.COMPLETION_STANDARD AS "COMPLETION_STANDARD"
                 ,a.COMPLETION_RESULTS_REMARK AS "COMPLETION_RESULTS_REMARK"
                 --,nvl(b.IS_UN_WATCH,1) as  "IS_UN_WATCH"
                 ,to_char(a.PLAN_START_DATE, ''YYYY-mm-dd'') as "PLAN_START_TIME"
                 ,to_char(a.PLAN_END_DATE, ''YYYY-mm-dd'') as "PLAN_END_TIME"
                 ,to_char(a.ACTUAL_START_DATE, ''YYYY-mm-dd'') as "ACTUAL_START_TIME"
                 ,to_char(a.ACTUAL_END_DATE, ''YYYY-mm-dd'') as "ACTUAL_END_TIME"
                 ,to_char(a.ESTIMATE_END_DATE, ''YYYY-mm-dd'') as "ESTIMATE_END_TIME"
                  ,b.UN_WATCH_TIME  ,b.WATCH_TIME
              FROM  v_pom_proj_monitor_node_list  a
              LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID='''||userid||''' --and   b.WATCH_TIME is  not   null
              WHERE     a.PLAN_ID='''||planid||''' AND a.DUTY_DEPARTMENT='''||condition||'''  ' ;
        END IF;
    END IF;


     v_sql_exec_paging := '
select f.* from ( '
                             || v_sql_exec
                             || '  AND rownum <= '
                             || pageindex * pagesizes
                             ||' order by node_code asc'|| ' ) f where rownum >= '
                             || pagesizes * ( pageindex - 1 )
                             || '';
    dbms_output.put_line(v_sql_exec_paging);
    EXECUTE IMMEDIATE 'SELECT count(rownum) from('
                          || v_sql_exec
                          || ') a '
        INTO total;
      OPEN items FOR v_sql_exec_paging;
END p_pom_proj_plan_dtl_condition;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_PUSH_WATCH_MESSAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_PUSH_WATCH_MESSAGE" (bizId in varchar,message OUT sys_refcursor)
AS  
--�����ע�����������Ϣ
--���ߣ�����
--���ڣ�2019/11/15
BEGIN  
open message for  
select 
'��Ϣ����' as  "msgDescription",
'������id' as "RecipientId" ,
bizId as "bizKey" ,
'������id' as "senderId",
'ҵ������' as "bizSourceCategory" ,
'��Ϣҵ������' as "bizMsgCategory" ,
'ϵͳid' as "systemId" ,
'΢����תurl'  as "wechatJumplinkUrl"
from dual;

END p_pom_Push_watch_message;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_QUARTER_ASSESSMENT_DTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_QUARTER_ASSESSMENT_DTL" ( year IN VARCHAR2, --��
		quarter IN VARCHAR2, --����
		companyid IN VARCHAR2, --��ǰ�û���˾id
        plantype  in  INT ,--�ƻ�����30 �ؼ��ڵ�ƻ���40����ƻ�
		baseInfo OUT SYS_REFCURSOR, --������Ϣ
		detailInfo OUT SYS_REFCURSOR --��ϸ��Ϣ
	) AS
	--��˾�¶ȿ�����������
--���ߣ�Ҷ����
--���ڣ�2019/12/05
BEGIN
		OPEN baseInfo FOR SELECT
		'' AS "checkObject",--���˶���
		'' AS "sataGenerationTime",--������������
		'' AS "assessmentStartDate",--���˿�ʼ����
		'' AS "assessmentEndDate",--���˽�������
		'' AS "percentageComplete",--�����(P=N/N*100)
		'' AS "assessmentTasksCount",--������������(M)
		'' AS "missionsCompleted",--���������(N)
		'' AS "assessmentScore",--���˵÷�S=(B/A)*100
		'' AS "assessmentStandardNodeScore",--�ƿ������ڽڵ��׼��(A)
		'' AS "assessmentActualNodeScore"--�ƿ������ڽڵ�ʵ�ʵ÷�(B)
	FROM
		dual;

	OPEN detailInfo FOR SELECT
	'' AS "alertStatus",--Ԥ��״̬
	'' "completionStatus",--���״̬
	'' AS "taskName",--��������
	'' AS "planName",--�ƻ�����
	'' AS "area",--����
	'' AS "businessDivision",--��ҵ��
	'' AS "project", --��Ŀ
	'' AS "department",--������
	'' AS "tasnkLevel",--���񼶱�
	'' AS "planEndDate",--�ƻ��������
	'' AS "FactEndDate",--ʵ���������
	'' AS "auditCompletionDate",--���������
	'' AS "standardScore",--��׼��ֵ
	'' AS "scoringPercentage",--�÷ֱ���
	'' AS "actualScore" --ʵ�ʵ÷�

	FROM
		dual;

END p_pom_quarter_assessment_dtl;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_EXAMINATION_DTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_EXAMINATION_DTL" (
    rangetype   IN          INT,--ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
    rangeval    IN          VARCHAR2,--��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
    orgid       IN          VARCHAR2,--��֯id(�ؼ��ڵ�ƻ�����,��Ŀ����ƻ�����
    title       OUT         VARCHAR2,
    bartype     OUT         VARCHAR2,
    unit        OUT         VARCHAR2,
    wacthinfo   OUT         SYS_REFCURSOR
) AS
--������������
--���ߣ�����
--���ڣ�2019/11/13
BEGIN
    OPEN wacthinfo FOR SELECT
                           '�����ҵ��-��ĿA' AS "name",
                           '100' AS "total",
                           '#37cd69' AS "color"
                       FROM
                           dual
                       UNION
                       SELECT
                           '������ҵ��-��ĿB' AS "name",
                           '25' AS "total",
                           '#37cd69' AS "color"
                       FROM
                           dual
                       UNION
                       SELECT
                           '�����ҵ��-��ĿC' AS "name",
                           '25' AS "total",
                           '#37cd69' AS "color"
                       FROM
                           dual
                       UNION
                       SELECT
                           '���ݵز�-��ĿD' AS "name",
                           '25' AS "total",
                           '#37cd69' AS "color"
                       FROM
                           dual;

    title := '��Ŀ����ƻ�����_��Ŀ���а�';
    unit := '%';
    bartype := 'column';
END p_pom_rank_examination_dtl;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_ORG_EXAM_DTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_ORG_EXAM_DTL" (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    rangetype   IN          INT,--ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
  --�ƻ�����  30�ؼ��ڵ�ƻ���40��Ŀ����ƻ�
    rangeval    IN          VARCHAR2,--��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
    orgid       IN          VARCHAR2,--��֯id(�ؼ��ڵ�ƻ�����,��Ŀ����ƻ�����
    title       OUT         VARCHAR2,
    info   OUT         SYS_REFCURSOR
) AS
--��˾������������
--���ߣ�����
--���ڣ�2019/11/13
BEGIN
  IF rangetype=10
      THEN
    OPEN info FOR
SELECT A.ORG_NAME AS "company", A.ID AS "ORGID",
			 TO_CHAR(ROUND(CASE
												 WHEN SUM(CASE
																			WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
																			 Ӧ���
																			ELSE
																			 0
																	END) > 0 THEN
													SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
																	 �����
																	ELSE
																	 0
															END) / SUM(CASE
																						 WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
																							Ӧ���
																						 ELSE
																							0
																				 END) * 100
												 ELSE
													0
										 END, 2)) AS "yearPercentageComplete",
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
												Ӧ���
											 ELSE
												0
									 END)) AS "yearShouldComplete"
				--����Ӧ�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
												�����
											 ELSE
												0
									 END)) AS "yearDone"
				--�����������
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
												Ӧ���
											 ELSE
												0
									 END) - SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN
																	 �����
																	ELSE
																	 0
															END)) AS "yearUnfinished"
				--����δ�����
			 ,
			 TO_CHAR(ROUND(CASE
												 WHEN SUM(CASE
																			WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																			 SUMNODESCORE
																			ELSE
																			 0
																	END) > 0 THEN
													SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 ��̬�÷�
																	ELSE
																	 0
															END) / SUM(CASE
																						 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																							SUMNODESCORE
																						 ELSE
																							0
																				 END) * 100
												 ELSE
													0
										 END, 2)) AS "dynamicScoring"
				--���¡����ȶ�̬�÷�
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												Ӧ���
											 ELSE
												0
									 END)) AS "monthShouldComplete"
				--���¡�����Ӧ�����
			 ,
       TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												SUMNODESCORE
											 ELSE
												0
									 END)) AS "monthShouldCompleteScore"
				--����Ӧ����ܷ�
        ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												�����
											 ELSE
												0
									 END)) AS "monthdDone"
				--���¡������������
			 ,
       TO_CHAR(SUM(CASE
           WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
            ������ܷ�
           ELSE
            0
        END)) AS "monthdDoneScore"
				--����������ܷ�
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												Ӧ���
											 ELSE
												0
									 END) - SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 �����
																	ELSE
																	 0
															END)) AS "monthUnfinished"
				--����δ�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱����
											 ELSE
												0
									 END) + SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 һ���ڵ���
																	ELSE
																	 0
															END) + SUM(CASE
																						 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																							�����ڵ��� + �����ڵ���
																						 ELSE
																							0
																				 END)) AS "red"
				--�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱��Ƶ�
											 ELSE
												0
									 END) + SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 һ���ڵ�Ƶ�
																	ELSE
																	 0
															END) + SUM(CASE
																						 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																							�����ڵ�Ƶ� + �����ڵ�Ƶ�
																						 ELSE
																							0
																				 END)) AS "yellow"
				--�Ƶ���
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱��̵�
											 ELSE
												0
									 END) + SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 һ���ڵ��̵�
																	ELSE
																	 0
															END) + SUM(CASE
																						 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																							�����ڵ��̵� + �����ڵ��̵�
																						 ELSE
																							0
																				 END)) AS "green"
				--�̵���
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱�Ӧ���
											 ELSE
												0
									 END)) AS "milestoneShouldComplete"
				--��̱�Ӧ�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱������
											 ELSE
												0
									 END)) AS "milestoneDone"
				--��̱��������
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												��̱�Ӧ���
											 ELSE
												0
									 END) - SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 ��̱������
																	ELSE
																	 0
															END)) AS "milestoneUnfinished"
				--��̱�δ�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												һ���ڵ�Ӧ���
											 ELSE
												0
									 END)) AS "oneLevelNodeShouldComplete"
				--һ���ڵ�Ӧ�����
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												һ���ڵ������
											 ELSE
												0
									 END)) AS "oneLevelNodeDone"
				--һ���ڵ��������
			 ,
			 TO_CHAR(SUM(CASE
											 WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
												һ���ڵ�Ӧ���
											 ELSE
												0
									 END) - SUM(CASE
																	WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	 һ���ڵ������
																	ELSE
																	 0
															END)) AS "oneLevelNodeUnfinished"
				--һ���ڵ�δ�����
			 , 'WWW.BAIDU.COM' AS "openUrl" --�򿪵�ַ

FROM   V_POM_PJPLANRANK A
WHERE  A.Ӧ��� > 0 AND
			 A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
			 CTYPE = 'TYPE_ORG' AND
			 A.PARENT_ID = '' || ORGID || '' AND
			 SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR
GROUP  BY A.ORG_NAME, A.ID
ORDER  BY 3 DESC;
ELSIF RANGETYPE = 20 THEN OPEN INFO FOR SELECT

A.ORG_NAME AS "company", A.ID AS "ORGID", ROUND(CASE WHEN SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN Ӧ��� ELSE 0 END) > 0 THEN SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN ����� ELSE 0 END)
/ SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN Ӧ��� ELSE 0 END) * 100 ELSE 0 END, 2) AS "yearPercentageComplete", SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN Ӧ��� ELSE 0 END) AS "yearShouldComplete" --����Ӧ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN ����� ELSE 0 END) AS "yearDone" --�����������
, SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN Ӧ��� ELSE 0 END) - SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR THEN ����� ELSE 0 END) AS "yearUnfinished" --����δ�����
, TO_CHAR(ROUND(CASE WHEN SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN SUMNODESCORE ELSE 0 END) > 0 THEN SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN ��̬�÷� ELSE 0 END)
/ SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN SUMNODESCORE ELSE 0 END) * 100 ELSE 0 END, 2)) AS "dynamicScoring" --���¡����ȶ�̬�÷�
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN Ӧ��� ELSE 0 END) AS "quarterShouldComplete" --���¡�����Ӧ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN SUMNODESCORE ELSE 0 END) AS "quarterShouldCompleteScore" --���¡�����Ӧ��ɷ���
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ����� ELSE 0 END) AS "quarterDone" --���¡������������
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ������ܷ� ELSE 0 END) AS "quarterDoneScore" --���¡���������ɷ���
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN Ӧ��� ELSE 0 END) - SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ����� ELSE 0 END) AS "quarterUnfinished" --����δ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱���� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ��� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN �����ڵ��� + �����ڵ��� ELSE 0 END) AS "red" --�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱��Ƶ� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ�Ƶ� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN �����ڵ�Ƶ� + �����ڵ�Ƶ� ELSE 0 END) AS "yellow" --�Ƶ���
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱��̵� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ��̵� ELSE 0 END) + SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN �����ڵ��̵� + �����ڵ��̵� ELSE 0 END) AS "green" --�̵���
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱�Ӧ��� ELSE 0 END) AS "milestoneShouldComplete" --��̱�Ӧ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱������ ELSE 0 END) AS "milestoneDone" --��̱��������
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱�Ӧ��� ELSE 0 END) - SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN ��̱������ ELSE 0 END) AS "milestoneUnfinished" --��̱�δ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ�Ӧ��� ELSE 0 END) AS "oneLevelNodeShouldComplete" --һ���ڵ�Ӧ�����
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ������ ELSE 0 END) AS "oneLevelNodeDone" --һ���ڵ��������
, SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ�Ӧ��� ELSE 0 END) - SUM(CASE WHEN SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN һ���ڵ������ ELSE 0 END) AS "oneLevelNodeUnfinished" --һ���ڵ�δ�����
, '' AS "openUrl" --�򿪵�ַ

FROM V_POM_PJPLANRANK A WHERE A.Ӧ��� > 0 AND A.PLAN_TYPE = '��Ŀ����ƻ�' AND CTYPE = 'TYPE_ORG' AND SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND A.PARENT_ID = '' || ORGID || '' GROUP BY A.ORG_NAME, A.ID ORDER BY 3 DESC;

END IF; TITLE := '�¶ȿ������а�_��ϸ����ͳ��'; END P_POM_RANK_ORG_EXAM_DTL;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_ORG_EXAMINATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_ORG_EXAMINATION" (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    rankype        IN             INT,--ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
    plantype       IN             INT,--�ƻ����ͣ�30���ؼ��ڵ�ƻ���40����Ŀ����ƻ���
    rankval        IN             VARCHAR2,--��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
    orgid          IN             VARCHAR2,--��֯id(��ǰ��ѡ��Ĺ�˾��
    title          OUT            VARCHAR2,
    bartype        OUT            VARCHAR2,
    unit           OUT            VARCHAR2,
    info      OUT            SYS_REFCURSOR
) AS
--��������-��֯���У������¶����е� �ؼ��ڵ����Ŀ����ƻ����������еĹؼ��ڵ����Ŀ����ƻ�
--���ߣ�����
--���ڣ�2019/11/13
BEGIN

IF rankype=10  AND plantype=30
THEN
OPEN info FOR

SELECT   A.ORG_NAME   AS "name"
  , TO_CHAR(
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                        "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
            )
           AS "total" --,'90 'AS "total"
		   ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank 
     , '#37cd69' AS "color"
     FROM    V_POM_PJPLAN_EXM_SOCRE  A
     INNER JOIN SYS_BUSINESS_UNIT B ON  A.ID=B.ID
     WHERE A.PARENT_ID=''||orgid||'' AND A.CTYPE='TYPE_ORG'
     AND SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
     AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH
     AND  A.PLAN_TYPE=  '�ؼ��ڵ�ƻ�'
--      AND   B.COMPANY_TYPE='5'
      GROUP BY A.ORG_NAME  ORDER BY 3 asc  ;



ELSIF rankype=10  AND plantype=40
THEN
OPEN info FOR
SELECT   A.ORG_NAME   AS "name"
  , TO_CHAR(
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
            )
           AS "total" --,'90 'AS "total"
		   ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
     , '#37cd69' AS "color"
     FROM    V_POM_PJPLAN_EXM_SOCRE  A
     INNER JOIN SYS_BUSINESS_UNIT B ON  A.ID=B.ID
     WHERE A.PARENT_ID=''||orgid||''AND A.CTYPE='TYPE_ORG'
     AND  A.PLAN_TYPE= '��Ŀ����ƻ�'
     AND SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
     AND SUBSTR( rankval, 6, 2 ) = A.PLANMOTH
      GROUP BY A.ORG_NAME  ORDER BY 3 asc ;




ELSIF rankype=20    AND plantype=30
THEN
OPEN info FOR
SELECT   A.ORG_NAME   AS "name"
  , TO_CHAR(
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
            )
           AS "total" --,'90 'AS "total"
  ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
     , '#37cd69' AS "color"
     FROM    V_POM_PJPLAN_EXM_SOCRE  A
    
     WHERE A.PARENT_ID=''||orgid||'' AND A.CTYPE='TYPE_ORG'
     AND  A.PLAN_TYPE=  '�ؼ��ڵ�ƻ�'
     AND SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
     AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR
--      AND   B.COMPANY_TYPE='5'
      GROUP BY A.ORG_NAME  ORDER BY 3 asc ;

ELSIF rankype=20    AND plantype=40
THEN
OPEN info FOR
SELECT   A.ORG_NAME   AS "name"
  , TO_CHAR(
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
            )
           AS "total" --,'90 'AS "total"
		    ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
     , '#37cd69' AS "color"

     FROM    V_POM_PJPLAN_EXM_SOCRE  A
    
     WHERE A.PARENT_ID=''||orgid||'' AND A.CTYPE='TYPE_ORG'
     AND SUBSTR( rankval, 0, 4 ) = A.PLANYEAR
     AND SUBSTR( rankval, 6, 2 ) = A.PLANQUATOR
     AND  A.PLAN_TYPE= '�ؼ��ڵ�ƻ�'

      GROUP BY A.ORG_NAME ORDER BY 3 asc;
  END IF ;



    title :=   CASE WHEN  plantype=40 THEN '��Ŀ����ƻ�' ELSE '�ؼ��ڵ�ƻ�'  END  ||'�������а񣺰��տ��˵÷ֽ�������ͳ�ƣ�չʾ��˾�÷ֵ�����';
    unit := '';
    bartype := 'column';
END p_pom_rank_org_examination;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_ORG_GETDTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_ORG_GETDTL" 
(
		PLANTYPE  IN VARCHAR2
	 , --�ƻ�����
		RANGETYPE IN INT
	 , --ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
		RANGEVAL  IN VARCHAR2
	 , --��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
		RANKDTL   OUT SYS_REFCURSOR
) AS
BEGIN
		IF RANGETYPE = 10 THEN
				OPEN RANKDTL FOR
						SELECT ROW_NUMBER() OVER(PARTITION BY A.PARENT_ID ORDER BY ROUND(CASE
											 WHEN NVL(B.����Ӧ���, 0) > 0 THEN
												NVL(���������, 0) / NVL(B.����Ӧ���, 0)
											 ELSE
												0
									 END * 100, 2) DESC) AS RANK, A.ID, A.PARENT_ID,
									 A.ORG_NAME, NVL(B.����Ӧ���, 0) AS ����Ӧ���,
									 NVL(B.���������, 0) AS ���������
									 --     ,NVL(B.������Ӧ���,0) AS ������Ӧ���
									 --     ,NVL(B.�����������,0) AS �����������
									, NVL(B.����Ӧ���, 0) AS ����Ӧ���, NVL(B.���������, 0) AS ���������
									 /*��̬�÷����*/, NVL(B.���¶�̬�÷�, 0) AS ���¶�̬�÷�
									 --     ,NVL(B.�����ȶ�̬�÷�,0) AS �����ȶ�̬�÷�
									 /*��̱���һ���ڵ�������*/, NVL(B.������̱�Ӧ���, 0) AS ������̱�Ӧ���,
									 NVL(B.������̱������, 0) AS ������̱������,
									 NVL(B.����һ���ڵ�Ӧ���, 0) AS ����һ���ڵ�Ӧ���,
									 NVL(B.����һ���ڵ������, 0) AS ����һ���ڵ������
									 --     ,NVL(B.��������̱�Ӧ���,0) AS ��������̱�Ӧ���
									 --     ,NVL(B.��������̱������,0) AS ��������̱������
									 --     ,NVL(B.������һ���ڵ�Ӧ���,0) AS ������һ���ڵ�Ӧ���
									 --     ,NVL(B.������һ���ڵ������,0) AS ������һ���ڵ������
									 /*�������*/, NVL(B.������̱��̵�, 0) AS ������̱��̵�,
									 NVL(B.������̱��Ƶ�, 0) AS ������̱��Ƶ�,
									 NVL(B.������̱����, 0) AS ������̱����,
									 NVL(B.����һ���ڵ��̵�, 0) AS ����һ���ڵ��̵�,
									 NVL(B.����һ���ڵ�Ƶ�, 0) AS ����һ���ڵ�Ƶ�,
									 NVL(B.����һ���ڵ���, 0) AS ����һ���ڵ���,
									 NVL(B.���¶������ڵ��̵�, 0) AS ���¶������ڵ��̵�,
									 NVL(B.���¶������ڵ�Ƶ�, 0) AS ���¶������ڵ�Ƶ�,
									 NVL(B.���¶������ڵ���, 0) AS ���¶������ڵ���
									 --     ,NVL(B.��������̱��̵�,0) AS ��������̱��̵�
									 --     ,NVL(B.��������̱��Ƶ�,0) AS ��������̱��Ƶ�
									 --     ,NVL(B.��������̱����,0) AS ��������̱����
									 --     ,NVL(B.������һ���ڵ��̵�,0) AS ������һ���ڵ��̵�
									 --     ,NVL(B.������һ���ڵ�Ƶ�,0) AS ������һ���ڵ�Ƶ�
									 --     ,NVL(B.������һ���ڵ���,0) AS ������һ���ڵ���
									 --     ,NVL(B.�����ȶ������ڵ��̵�,0) AS �����ȶ������ڵ��̵�
									 --     ,NVL(B.�����ȶ������ڵ�Ƶ�,0) AS �����ȶ������ڵ�Ƶ�
									 --     ,NVL(B.�����ȶ������ڵ���,0) AS �����ȶ������ڵ���
									 
									, 'TYPE_ORG' AS CTYPE
						FROM   SYS_BUSINESS_UNIT A
						LEFT   JOIN (SELECT AB.ID, AB.PARENT_ID, SUM(AB.����Ӧ���) AS ����Ӧ���,
																SUM(AB.���������) AS ���������
																--     ,SUM(AB.������Ӧ���) AS ������Ӧ���
																--     ,SUM(AB.�����������) AS �����������
															 , SUM(AB.����Ӧ���) AS ����Ӧ���,
																SUM(AB.���������) AS ���������
																/*��̬�÷����*/, SUM(AB.���¶�̬�÷�) AS ���¶�̬�÷�
																--     ,SUM(AB.�����ȶ�̬�÷�) AS �����ȶ�̬�÷�
																/*��̱���һ���ڵ�������*/,
																SUM(AB.������̱�Ӧ���) AS ������̱�Ӧ���,
																SUM(AB.������̱������) AS ������̱������,
																SUM(AB.����һ���ڵ�Ӧ���) AS ����һ���ڵ�Ӧ���,
																SUM(AB.����һ���ڵ������) AS ����һ���ڵ������
																--     ,SUM(AB.��������̱�Ӧ���) AS ��������̱�Ӧ���
																--     ,SUM(AB.��������̱������) AS ��������̱������
																--     ,SUM(AB.������һ���ڵ�Ӧ���) AS ������һ���ڵ�Ӧ���
																--     ,SUM(AB.������һ���ڵ������) AS ������һ���ڵ������
																/*�������*/, SUM(AB.������̱��̵�) AS ������̱��̵�,
																SUM(AB.������̱��Ƶ�) AS ������̱��Ƶ�,
																SUM(AB.������̱����) AS ������̱����,
																SUM(AB.����һ���ڵ��̵�) AS ����һ���ڵ��̵�,
																SUM(AB.����һ���ڵ�Ƶ�) AS ����һ���ڵ�Ƶ�,
																SUM(AB.����һ���ڵ���) AS ����һ���ڵ���,
																SUM(AB.���¶������ڵ��̵�) AS ���¶������ڵ��̵�,
																SUM(AB.���¶������ڵ�Ƶ�) AS ���¶������ڵ�Ƶ�,
																SUM(AB.���¶������ڵ���) AS ���¶������ڵ���
												 --     ,SUM(AB.��������̱��̵�) AS ��������̱��̵�
												 --     ,SUM(AB.��������̱��Ƶ�) AS ��������̱��Ƶ�
												 --     ,SUM(AB.��������̱����) AS ��������̱����
												 --     ,SUM(AB.������һ���ڵ��̵�) AS ������һ���ڵ��̵�
												 --     ,SUM(AB.������һ���ڵ�Ƶ�) AS ������һ���ڵ�Ƶ�
												 --     ,SUM(AB.������һ���ڵ���) AS ������һ���ڵ���
												 --     ,SUM(AB.�����ȶ������ڵ��̵�) AS �����ȶ������ڵ��̵�
												 --     ,SUM(AB.�����ȶ������ڵ�Ƶ�) AS �����ȶ������ڵ�Ƶ�
												 --     ,SUM(AB.�����ȶ������ڵ���) AS �����ȶ������ڵ���
												 FROM   (
																	--  11
																	
																	SELECT
																	/*������*/
																	 NVL(B.����Ӧ���, 0) AS ����Ӧ���,
																		NVL(B.���������, 0) AS ���������
																		--                    ,NVL(B.������Ӧ���,0) AS ������Ӧ���
																		--                    ,NVL(B.�����������,0) AS �����������
																	, NVL(B.����Ӧ���, 0) AS ����Ӧ���,
																		NVL(B.���������, 0) AS ���������
																		/*��̬�÷����*/, NVL(B.���¶�̬�÷�, 0) AS ���¶�̬�÷�
																		--                    ,NVL(B.�����ȶ�̬�÷�,0) AS �����ȶ�̬�÷�
																		/*��̱���һ���ڵ�������*/,
																		NVL(B.������̱�Ӧ���, 0) AS ������̱�Ӧ���,
																		NVL(B.������̱������, 0) AS ������̱������,
																		NVL(B.����һ���ڵ�Ӧ���, 0) AS ����һ���ڵ�Ӧ���,
																		NVL(B.����һ���ڵ������, 0) AS ����һ���ڵ������
																		--                    ,NVL(B.��������̱�Ӧ���,0) AS ��������̱�Ӧ���
																		--                    ,NVL(B.��������̱������,0) AS ��������̱������
																		--                    ,NVL(B.������һ���ڵ�Ӧ���,0) AS ������һ���ڵ�Ӧ���
																		--                    ,NVL(B.������һ���ڵ������,0) AS ������һ���ڵ������
																		/*�������*/, NVL(B.������̱��̵�, 0) AS ������̱��̵�,
																		NVL(B.������̱��Ƶ�, 0) AS ������̱��Ƶ�,
																		NVL(B.������̱����, 0) AS ������̱����,
																		NVL(B.����һ���ڵ��̵�, 0) AS ����һ���ڵ��̵�,
																		NVL(B.����һ���ڵ�Ƶ�, 0) AS ����һ���ڵ�Ƶ�,
																		NVL(B.����һ���ڵ���, 0) AS ����һ���ڵ���,
																		NVL(B.���¶������ڵ��̵�, 0) AS ���¶������ڵ��̵�,
																		NVL(B.���¶������ڵ�Ƶ�, 0) AS ���¶������ڵ�Ƶ�,
																		NVL(B.���¶������ڵ���, 0) AS ���¶������ڵ���
																		--                    ,NVL(B.��������̱��̵�,0) AS ��������̱��̵�
																		--                    ,NVL(B.��������̱��Ƶ�,0) AS ��������̱��Ƶ�
																		--                    ,NVL(B.��������̱����,0) AS ��������̱����
																		--                    ,NVL(B.������һ���ڵ��̵�,0) AS ������һ���ڵ��̵�
																		--                    ,NVL(B.������һ���ڵ�Ƶ�,0) AS ������һ���ڵ�Ƶ�
																		--                    ,NVL(B.������һ���ڵ���,0) AS ������һ���ڵ���
																		--                    ,NVL(B.�����ȶ������ڵ��̵�,0) AS �����ȶ������ڵ��̵�
																		--                    ,NVL(B.�����ȶ������ڵ�Ƶ�,0) AS �����ȶ������ڵ�Ƶ�
																		--                    ,NVL(B.�����ȶ������ڵ���,0) AS �����ȶ������ڵ���
																	, CONNECT_BY_ROOT ID AS ID,
																		CONNECT_BY_ROOT PARENT_ID AS PARENT_ID
																	FROM   SYS_BUSINESS_UNIT A
																	LEFT   JOIN (
																							 
																							 SELECT B1.UNIT_ID,
																											 COUNT(A1.ID) AS "NODESUM",
																											 SUM(STANDARD_SCORE) AS "SUMNODESCORE"
																											 --��ɹ���
																											 
																											 ------------------
																											 /*��������*/
																											 ------------------
																											 ------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.PLAN_END_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY') THEN
																																 1
																																ELSE
																																 0
																														END
																														
																														) AS "����Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
																																--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																 THEN
																																 1
																																ELSE
																																 0
																														END)) AS "���������"
																											 
																											 ------------------
																											 /*��������*/
																											 ------------------
																											 ------
																											 ,
																											 SUM((CASE
																																WHEN TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																			FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "����Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																 THEN
																																 1
																																ELSE
																																 0
																														END)) AS "���������"
																											 
																											 ,
																											 SUM((CASE
																														--��ʱ���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) BETWEEN 0 AND 29 THEN
																																 A1.STANDARD_SCORE * 1
																														--��ǰһ�������
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL --�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL = '��̱�' THEN
																																 A1.STANDARD_SCORE * 1.2
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL = 'һ���ڵ�' THEN
																																 A1.STANDARD_SCORE * 1.1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 1.0
																														--��ʱ���
																														--��̱���һ���ڵ�3��
																														--�������ڵ�5��
																														--��ʱ���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�', 'һ���ڵ�') THEN
																																 A1.STANDARD_SCORE * 0.6
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 3 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 1.0
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 4 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 0.6
																														--���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�', 'һ���ڵ�') THEN
																																 A1.STANDARD_SCORE * 0
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 0
																																ELSE
																																 0
																														END)) AS "���¶�̬�÷�"
																											 
																											 ------------------
																											 /*-��̱�������*/
																											 ------------------
																											 ,
																											 SUM((CASE
																																WHEN A1. NODE_LEVEL = '��̱�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																			FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "������̱�Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND A1.
																																 NODE_LEVEL = '��̱�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																			FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "������̱������"
																											 ------------------
																											 /*-һ���ڵ�������*/
																											 ------------------
																											 ,
																											 SUM((CASE
																																WHEN A1. NODE_LEVEL = 'һ���ڵ�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																			FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "����һ���ڵ�Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND A1.
																																 NODE_LEVEL = 'һ���ڵ�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																			FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "����һ���ڵ������"
																											 
																											 ------------------
																											 /*-��̱������������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������̱��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������̱��Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������̱����"
																											 
																											 ------------------
																											 /*һ���ڵ㱾���������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "����һ���ڵ��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "����һ���ڵ�Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "����һ���ڵ���"
																											 
																											 ------------------
																											 /*�������ڵ㱾���������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 2 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "���¶������ڵ��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "���¶������ڵ�Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.����_���� || '-' || TO_CHAR(TO_NUMBER(����_����) - 1) || '-' || '26'
																																					FROM   V_POM_GETEXAMINE_MOTH A) AND
																																		 (SELECT A.����_���� || '-' || ����_���� || '-' || '25'
																																			FROM   V_POM_GETEXAMINE_MOTH A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "���¶������ڵ���"
																							 
																							 FROM   POM_PROJ_PLAN A
																							 INNER  JOIN POM_PROJ_PLAN_NODE A1
																							 ON     A.ID = A1.PROJ_PLAN_ID
																							 INNER  JOIN SYS_PROJECT_STAGE C1
																							 ON     A.PROJ_ID = C1.ID
																							 INNER  JOIN SYS_PROJECT B1
																							 ON     C1.PROJECT_ID = B1.ID
																							 LEFT   JOIN POM_NODE_FEEDBACK D
																							 ON     D.FEEDBACK_NODE_ID = A1.ID AND
																											FEEDBACK_TYPE = '��ɷ���' AND
																											D.APPROVAL_STATUS = '�����'
																							 WHERE  A.PLAN_TYPE = '��Ŀ����ƻ�' AND
																											A.APPROVAL_STATUS = '�����'
																							 GROUP  BY B1.UNIT_ID) B
																	ON     A.ID = B.UNIT_ID
																	WHERE  NVL(B.NODESUM, 0) > 0
																	CONNECT BY PRIOR A.ID = A.PARENT_ID) AB
												 GROUP  BY AB.ID, AB.PARENT_ID) B
						ON     A.ID = B.ID
						WHERE  A.ORG_TYPE = 0 AND
									 A.COMPANY_TYPE = '5' AND
									 A.PARENT_ID = '003200000000000000000000000000';
		
		ELSIF RANGETYPE = 20 THEN
				OPEN RANKDTL FOR
						SELECT ROW_NUMBER() OVER(PARTITION BY A.PARENT_ID ORDER BY ROUND(CASE
											 WHEN NVL(B.����Ӧ���, 0) > 0 THEN
												NVL(���������, 0) / NVL(B.����Ӧ���, 0)
											 ELSE
												0
									 END * 100, 2) DESC) AS RANK, A.ID, A.PARENT_ID,
									 A.ORG_NAME, NVL(B.����Ӧ���, 0) AS ����Ӧ���,
									 NVL(B.���������, 0) AS ���������, NVL(B.������Ӧ���, 0) AS ������Ӧ���,
									 NVL(B.�����������, 0) AS �����������
									 --     ,NVL(B.����Ӧ���,0) AS ����Ӧ���
									 --     ,NVL(B.���������,0) AS ���������
									 /*��̬�÷����*/
									 --     ,NVL(B.���¶�̬�÷�,0) AS ���¶�̬�÷�
									, NVL(B.�����ȶ�̬�÷�, 0) AS �����ȶ�̬�÷�
									 /*��̱���һ���ڵ�������*/
									 --     ,NVL(B.������̱�Ӧ���,0) AS ������̱�Ӧ���
									 --     ,NVL(B.������̱������,0) AS ������̱������
									 --     ,NVL(B.����һ���ڵ�Ӧ���,0) AS ����һ���ڵ�Ӧ���
									 --     ,NVL(B.����һ���ڵ������,0) AS ����һ���ڵ������
									, NVL(B.��������̱�Ӧ���, 0) AS ��������̱�Ӧ���,
									 NVL(B.��������̱������, 0) AS ��������̱������,
									 NVL(B.������һ���ڵ�Ӧ���, 0) AS ������һ���ڵ�Ӧ���,
									 NVL(B.������һ���ڵ������, 0) AS ������һ���ڵ������
									 /*�������*/
									 --     ,NVL(B.������̱��̵�,0) AS ������̱��̵�
									 --     ,NVL(B.������̱��Ƶ�,0) AS ������̱��Ƶ�
									 --     ,NVL(B.������̱����,0) AS ������̱����
									 --     ,NVL(B.����һ���ڵ��̵�,0) AS ����һ���ڵ��̵�
									 --     ,NVL(B.����һ���ڵ�Ƶ�,0) AS ����һ���ڵ�Ƶ�
									 --     ,NVL(B.����һ���ڵ���,0) AS ����һ���ڵ���
									 --     ,NVL(B.���¶������ڵ��̵�,0) AS ���¶������ڵ��̵�
									 --     ,NVL(B.���¶������ڵ�Ƶ�,0) AS ���¶������ڵ�Ƶ�
									 --     ,NVL(B.���¶������ڵ���,0) AS ���¶������ڵ���
									, NVL(B.��������̱��̵�, 0) AS ��������̱��̵�,
									 NVL(B.��������̱��Ƶ�, 0) AS ��������̱��Ƶ�,
									 NVL(B.��������̱����, 0) AS ��������̱����,
									 NVL(B.������һ���ڵ��̵�, 0) AS ������һ���ڵ��̵�,
									 NVL(B.������һ���ڵ�Ƶ�, 0) AS ������һ���ڵ�Ƶ�,
									 NVL(B.������һ���ڵ���, 0) AS ������һ���ڵ���,
									 NVL(B.�����ȶ������ڵ��̵�, 0) AS �����ȶ������ڵ��̵�,
									 NVL(B.�����ȶ������ڵ�Ƶ�, 0) AS �����ȶ������ڵ�Ƶ�,
									 NVL(B.�����ȶ������ڵ���, 0) AS �����ȶ������ڵ���
									 
									, 'TYPE_ORG' AS CTYPE
						FROM   SYS_BUSINESS_UNIT A
						LEFT   JOIN (SELECT AB.ID, AB.PARENT_ID, SUM(AB.����Ӧ���) AS ����Ӧ���,
																SUM(AB.���������) AS ���������,
																SUM(AB.������Ӧ���) AS ������Ӧ���,
																SUM(AB.�����������) AS �����������
																--     ,SUM(AB.����Ӧ���) AS ����Ӧ���
																--     ,SUM(AB.���������) AS ���������
																/*��̬�÷����*/
																--     ,SUM(AB.���¶�̬�÷�) AS ���¶�̬�÷�
															 , SUM(AB.�����ȶ�̬�÷�) AS �����ȶ�̬�÷�
																/*��̱���һ���ڵ�������*/
																--     ,SUM(AB.������̱�Ӧ���) AS ������̱�Ӧ���
																--     ,SUM(AB.������̱������) AS ������̱������
																--     ,SUM(AB.����һ���ڵ�Ӧ���) AS ����һ���ڵ�Ӧ���
																--     ,SUM(AB.����һ���ڵ������) AS ����һ���ڵ������
															 , SUM(AB.��������̱�Ӧ���) AS ��������̱�Ӧ���,
																SUM(AB.��������̱������) AS ��������̱������,
																SUM(AB.������һ���ڵ�Ӧ���) AS ������һ���ڵ�Ӧ���,
																SUM(AB.������һ���ڵ������) AS ������һ���ڵ������
																/*�������*/
																--     ,SUM(AB.������̱��̵�) AS ������̱��̵�
																--     ,SUM(AB.������̱��Ƶ�) AS ������̱��Ƶ�
																--     ,SUM(AB.������̱����) AS ������̱����
																--     ,SUM(AB.����һ���ڵ��̵�) AS ����һ���ڵ��̵�
																--     ,SUM(AB.����һ���ڵ�Ƶ�) AS ����һ���ڵ�Ƶ�
																--     ,SUM(AB.����һ���ڵ���) AS ����һ���ڵ���
																--     ,SUM(AB.���¶������ڵ��̵�) AS ���¶������ڵ��̵�
																--     ,SUM(AB.���¶������ڵ�Ƶ�) AS ���¶������ڵ�Ƶ�
																--     ,SUM(AB.���¶������ڵ���) AS ���¶������ڵ���
															 , SUM(AB.��������̱��̵�) AS ��������̱��̵�,
																SUM(AB.��������̱��Ƶ�) AS ��������̱��Ƶ�,
																SUM(AB.��������̱����) AS ��������̱����,
																SUM(AB.������һ���ڵ��̵�) AS ������һ���ڵ��̵�,
																SUM(AB.������һ���ڵ�Ƶ�) AS ������һ���ڵ�Ƶ�,
																SUM(AB.������һ���ڵ���) AS ������һ���ڵ���,
																SUM(AB.�����ȶ������ڵ��̵�) AS �����ȶ������ڵ��̵�,
																SUM(AB.�����ȶ������ڵ�Ƶ�) AS �����ȶ������ڵ�Ƶ�,
																SUM(AB.�����ȶ������ڵ���) AS �����ȶ������ڵ���
												 FROM   (
																	--  11
																	
																	SELECT
																	/*������*/
																	 NVL(B.����Ӧ���, 0) AS ����Ӧ���,
																		NVL(B.���������, 0) AS ���������,
																		NVL(B.������Ӧ���, 0) AS ������Ӧ���,
																		NVL(B.�����������, 0) AS �����������
																		--                    ,NVL(B.����Ӧ���,0) AS ����Ӧ���
																		--                    ,NVL(B.���������,0) AS ���������
																		/*��̬�÷����*/
																		--                    ,NVL(B.���¶�̬�÷�,0) AS ���¶�̬�÷�
																	, NVL(B.�����ȶ�̬�÷�, 0) AS �����ȶ�̬�÷�
																		/*��̱���һ���ڵ�������*/
																		--                    ,NVL(B.������̱�Ӧ���,0) AS ������̱�Ӧ���
																		--                    ,NVL(B.������̱������,0) AS ������̱������
																		--                    ,NVL(B.����һ���ڵ�Ӧ���,0) AS ����һ���ڵ�Ӧ���
																		--                    ,NVL(B.����һ���ڵ������,0) AS ����һ���ڵ������
																	, NVL(B.��������̱�Ӧ���, 0) AS ��������̱�Ӧ���,
																		NVL(B.��������̱������, 0) AS ��������̱������,
																		NVL(B.������һ���ڵ�Ӧ���, 0) AS ������һ���ڵ�Ӧ���,
																		NVL(B.������һ���ڵ������, 0) AS ������һ���ڵ������
																		/*�������*/
																		--                    ,NVL(B.������̱��̵�,0) AS ������̱��̵�
																		--                    ,NVL(B.������̱��Ƶ�,0) AS ������̱��Ƶ�
																		--                    ,NVL(B.������̱����,0) AS ������̱����
																		--                    ,NVL(B.����һ���ڵ��̵�,0) AS ����һ���ڵ��̵�
																		--                    ,NVL(B.����һ���ڵ�Ƶ�,0) AS ����һ���ڵ�Ƶ�
																		--                    ,NVL(B.����һ���ڵ���,0) AS ����һ���ڵ���
																		--                    ,NVL(B.���¶������ڵ��̵�,0) AS ���¶������ڵ��̵�
																		--                    ,NVL(B.���¶������ڵ�Ƶ�,0) AS ���¶������ڵ�Ƶ�
																		--                    ,NVL(B.���¶������ڵ���,0) AS ���¶������ڵ���
																	, NVL(B.��������̱��̵�, 0) AS ��������̱��̵�,
																		NVL(B.��������̱��Ƶ�, 0) AS ��������̱��Ƶ�,
																		NVL(B.��������̱����, 0) AS ��������̱����,
																		NVL(B.������һ���ڵ��̵�, 0) AS ������һ���ڵ��̵�,
																		NVL(B.������һ���ڵ�Ƶ�, 0) AS ������һ���ڵ�Ƶ�,
																		NVL(B.������һ���ڵ���, 0) AS ������һ���ڵ���,
																		NVL(B.�����ȶ������ڵ��̵�, 0) AS �����ȶ������ڵ��̵�,
																		NVL(B.�����ȶ������ڵ�Ƶ�, 0) AS �����ȶ������ڵ�Ƶ�,
																		NVL(B.�����ȶ������ڵ���, 0) AS �����ȶ������ڵ���,
																		CONNECT_BY_ROOT ID AS ID,
																		CONNECT_BY_ROOT PARENT_ID AS PARENT_ID
																	FROM   SYS_BUSINESS_UNIT A
																	LEFT   JOIN (
																							 
																							 SELECT B1.UNIT_ID,
																											 COUNT(A1.ID) AS "NODESUM",
																											 SUM(STANDARD_SCORE) AS "SUMNODESCORE"
																											 --��ɹ���
																											 
																											 ------------------
																											 /*��������*/
																											 ------------------
																											 ------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.PLAN_END_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY') THEN
																																 1
																																ELSE
																																 0
																														END
																														
																														) AS "����Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
																																--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																 THEN
																																 1
																																ELSE
																																 0
																														END)) AS "���������"
																											 
																											 ------------------
																											 /*����������*/
																											 ------------------
																											 ------
																											 ,
																											 SUM((CASE
																																WHEN
																																--�жϼ���
																																 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																 (SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																	FROM   V_POM_GETEXAMINE_QUARTER A) AND
																																 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																	FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "������Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϼ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 (SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																 THEN
																																 1
																																ELSE
																																 0
																														END)) AS "�����������"
																											 
																											 ,
																											 SUM((CASE
																														--��ʱ���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϼ���
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) BETWEEN 0 AND 29 THEN
																																 A1.STANDARD_SCORE * 1
																														
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL --�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL = '��̱�' THEN
																																 A1.STANDARD_SCORE * 1.2
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL = 'һ���ڵ�' THEN
																																 A1.STANDARD_SCORE * 1.1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(A1.PLAN_END_DATE, 'DD') - TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 1.0
																														--��ʱ���
																														--��̱���һ���ڵ�3��
																														--�������ڵ�5��
																														--��ʱ���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�', 'һ���ڵ�') THEN
																																 A1.STANDARD_SCORE * 0.6
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 3 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 1.0
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 4 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 0.6
																														--���
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�', 'һ���ڵ�') THEN
																																 A1.STANDARD_SCORE * 0
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 A1.STANDARD_SCORE * 0
																																ELSE
																																 0
																														END)) AS "�����ȶ�̬�÷�"
																											 
																											 ------------------
																											 /*-��̱�������*/
																											 ------------------
																											 ,
																											 SUM((CASE
																																WHEN A1. NODE_LEVEL = '��̱�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																			 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "��������̱�Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND A1.
																																 NODE_LEVEL = '��̱�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "��������̱������"
																											 ------------------
																											 /*-һ���ڵ�������*/
																											 ------------------
																											 ,
																											 SUM((CASE
																																WHEN A1. NODE_LEVEL = 'һ���ڵ�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																			 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "������һ���ڵ�Ӧ���",
																											 SUM((CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND A1.
																																 NODE_LEVEL = 'һ���ڵ�' AND
																																		 TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																																 1
																																ELSE
																																 0
																														END)) AS "������һ���ڵ������"
																											 
																											 ------------------
																											 /*-��̱��������������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "��������̱��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "��������̱��Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('��̱�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "��������̱����"
																											 
																											 ------------------
																											 /*һ���ڵ㱾�����������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������һ���ڵ��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������һ���ڵ�Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																																		 A1.NODE_LEVEL IN ('һ���ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "������һ���ڵ���"
																											 
																											 ------------------
																											 /*�������ڵ㱾�����������*/
																											 ------------------
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) <= 2 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "�����ȶ������ڵ��̵�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "�����ȶ������ڵ�Ƶ�"
																											 
																											 ,
																											 SUM(CASE
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND
																																		 (TRUNC(D.APPROVAL_TIME, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																																WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NULL
																																		--�жϱ�����
																																		 AND TO_CHAR(A1.PLAN_END_DATE, 'YYYY-MM-DD') BETWEEN
																																		 ((SELECT A.��ʼ��� || '-' || A.��ʼ�·� || '-26'
																																					FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																																		 (SELECT A.��ʼ��� || '-' || A.�����·� || '-25'
																																			FROM   V_POM_GETEXAMINE_QUARTER A)
																																		--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																																		 AND (TRUNC(SYSDATE, 'DD') - TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																																		 A1.NODE_LEVEL IN ('�����ڵ�', '�����ڵ�') THEN
																																 1
																														
																																ELSE
																																 0
																														END) AS "�����ȶ������ڵ���"
																							 
																							 FROM   POM_PROJ_PLAN A
																							 INNER  JOIN POM_PROJ_PLAN_NODE A1
																							 ON     A.ID = A1.PROJ_PLAN_ID
																							 INNER  JOIN SYS_PROJECT_STAGE C1
																							 ON     A.PROJ_ID = C1.ID
																							 INNER  JOIN SYS_PROJECT B1
																							 ON     C1.PROJECT_ID = B1.ID
																							 LEFT   JOIN POM_NODE_FEEDBACK D
																							 ON     D.FEEDBACK_NODE_ID = A1.ID AND
																											FEEDBACK_TYPE = '��ɷ���' AND
																											D.APPROVAL_STATUS = '�����'
																							 WHERE  A.PLAN_TYPE = '��Ŀ����ƻ�' AND
																											A.APPROVAL_STATUS = '�����'
																							 GROUP  BY B1.UNIT_ID) B
																	ON     A.ID = B.UNIT_ID
																	WHERE  NVL(B.NODESUM, 0) > 0
																	CONNECT BY PRIOR A.ID = A.PARENT_ID) AB
												 GROUP  BY AB.ID, AB.PARENT_ID) B
						ON     A.ID = B.ID
						WHERE  A.ORG_TYPE = 0 AND
									 A.COMPANY_TYPE = '5' AND
									 A.PARENT_ID = '003200000000000000000000000000';
		END IF;

END P_POM_RANK_ORG_GETDTL;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_PROJ_EXAM_DTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_PROJ_EXAM_DTL" (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    rangetype      IN             INT,--ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
    rangeval       IN             VARCHAR2,--��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
    orgid          IN             VARCHAR2,--��֯id(�ؼ��ڵ�ƻ�����,��Ŀ����ƻ�����
    title          OUT            VARCHAR2,
    info           OUT            SYS_REFCURSOR--��Ҫ������װ��
) AS
--��˾������������
--���ߣ�����
--���ڣ�2019/11/13
BEGIN

 

IF rangetype=10 then
   OPEN info FOR
 
  SELECT
  A.ORG_NAME  AS "company"

     ,  A.ID AS "orgId"
 		 , CASE  WHEN  A.ID=''||orgid||''  THEN NULL ELSE A.PARENT_ID END    AS "parentId"
    --,TO_CHAR(ROUND(CASE WHEN SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END )>0 THEN   SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  �����  ELSE 0 END)/SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END )*100  ELSE 0 END,2) )   AS  "yearPercentageComplete"
    ,TO_CHAR(SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END)) AS "yearShouldComplete"--����Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  �����  ELSE 0 END) AS "yearDone"--�����������
    ,SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END) - SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  �����  ELSE 0 END) AS "yearUnfinished"--����δ�����
    , CASE  WHEN SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  SUMNODESCORE  ELSE 0 END)  >0 THEN SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̬�÷�  ELSE 0 END)
		--/SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  SUMNODESCORE  ELSE 0 END)*100,2) 
		ELSE 0 END  AS "dynamicScoring"--���¡����ȶ�̬�÷�
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  Ӧ���  ELSE 0 END) AS "monthShouldComplete"--���¡�����Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  SUMNODESCORE  ELSE 0 END) AS "monthShouldCompleteScore"--����Ӧ����ܷ�
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����  ELSE 0 END)  AS "monthdDone"--���¡������������
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ������ܷ�  ELSE 0 END)  AS "monthdDoneScore"--����������ܷ�
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  Ӧ���  ELSE 0 END)  - SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����  ELSE 0 END)  AS "monthUnfinished"--����δ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱����  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ���  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN   �����ڵ��� + �����ڵ���  ELSE 0 END)  AS "red"--�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱��Ƶ�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ƶ�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ƶ�+�����ڵ�Ƶ�  ELSE 0 END)   AS "yellow"--�Ƶ���
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱��̵�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ��̵�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ��̵�+�����ڵ��̵�  ELSE 0 END)  AS "green"--�̵���
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱�Ӧ���  ELSE 0 END)  AS "milestoneShouldComplete"--��̱�Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱������  ELSE 0 END) AS "milestoneDone"--��̱��������
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱�Ӧ���  ELSE 0 END)-SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱������  ELSE 0 END) AS "milestoneUnfinished"--��̱�δ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ӧ���  ELSE 0 END) AS "oneLevelNodeShouldComplete"--һ���ڵ�Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ������  ELSE 0 END)  AS "oneLevelNodeDone"--һ���ڵ��������
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ������  ELSE 0 END)   AS "oneLevelNodeUnfinished"--һ���ڵ�δ�����
 --
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) AS "twoLevelNodeShouldComplete"--�����ڵ�Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)  AS "twoLevelNodeDone"--�����ڵ��������
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)   AS "twoLevelNodeUnfinished"--�����ڵ�δ�����
      ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) AS "threeLevelNodeShouldComplete"--�����ڵ�Ӧ�����
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)  AS "threeLevelNodeDone"--�����ڵ��������
    ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)   AS "threeLevelNodeUnfinished"--�����ڵ�δ�����
    ,    '' as  "openUrl"--�򿪵�ַ
 --
 FROM  V_POM_PJPLANRANK A
 WHERE 1=1
  and A.Ӧ���>0 AND  A.PLAN_TYPE='��Ŀ����ƻ�'  --AND--  CTYPE='TYPE_ORG'
 --and (PARENT_ID ='003200000000000000000000000000' or  ORG_NAME ='�й������ز�����' )
 AND SUBSTR(rangeval, 0, 4)=A.PLANYEAR
 AND( A.PARENT_ID  IN (  SELECT a.ID
 	from   SYS_BUSINESS_UNIT A
 	where  1=1 and    IS_COMPANY=1
 	START WITH a.id=''||orgid||''
 	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
 	OR A.ID=''||orgid||'')
 
 GROUP BY A.ORG_NAME   ,A.ID,A.PARENT_ID   ,A.ORGCODE    
 ORDER BY A.ORGCODE   
 ;
-- 



 

ELSIF rangetype=20 then
   OPEN info FOR


 SELECT
 A.ORG_NAME  AS "company"
   ,  A.ID AS "orgId"
		, CASE  WHEN  A.ID=''||orgid||''  THEN NULL ELSE A.PARENT_ID END    AS "parentId"
   
   ,SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END) AS "yearShouldComplete"--����Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  �����  ELSE 0 END) AS "yearDone"--�����������
   ,SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  Ӧ���  ELSE 0 END) - SUM(CASE WHEN SUBSTR(rangeval, 0, 4)=A.PLANYEAR  THEN  �����  ELSE 0 END) AS "yearUnfinished"--����δ�����
   , CASE WHEN SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN   SUMNODESCORE  ELSE 0 END) >0 THEN ROUND(SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̬�÷�  ELSE 0 END) / SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN   SUMNODESCORE  ELSE 0 END)*100,2)  ELSE 0 END AS "dynamicScoring"--���¡����ȶ�̬�÷�
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  Ӧ���  ELSE 0 END) AS "quarterShouldComplete"--���¡�����Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2) = A.PLANMOTH THEN SUMNODESCORE ELSE 0 END) AS "quarterShouldCompleteScore" --���¡�����Ӧ��ɷ���
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����  ELSE 0 END)  AS "quarterDone"--���¡������������
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2) = A.PLANMOTH THEN ������ܷ� ELSE 0 END) AS "quarterDoneScore" --���¡���������ɷ���
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  Ӧ���  ELSE 0 END)  - SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����  ELSE 0 END)  AS "quarterUnfinished"--����δ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱����  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ���  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN   �����ڵ��� + �����ڵ���  ELSE 0 END)  AS "red"--�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱��Ƶ�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ƶ�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ƶ�+�����ڵ�Ƶ�  ELSE 0 END)   AS "yellow"--�Ƶ���
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱��̵�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ��̵�  ELSE 0 END) +SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ��̵�+�����ڵ��̵�  ELSE 0 END)  AS "green"--�̵���
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱�Ӧ���  ELSE 0 END)  AS "milestoneShouldComplete"--��̱�Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱������  ELSE 0 END) AS "milestoneDone"--��̱��������
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱�Ӧ���  ELSE 0 END)-SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  ��̱������  ELSE 0 END) AS "milestoneUnfinished"--��̱�δ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ӧ���  ELSE 0 END) AS "oneLevelNodeShouldComplete"--һ���ڵ�Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ������  ELSE 0 END)  AS "oneLevelNodeDone"--һ���ڵ��������
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  һ���ڵ������  ELSE 0 END)   AS "oneLevelNodeUnfinished"--һ���ڵ�δ�����
--
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) AS "twoLevelNodeShouldComplete"--�����ڵ�Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)  AS "twoLevelNodeDone"--�����ڵ��������
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)   AS "twoLevelNodeUnfinished"--�����ڵ�δ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) AS "threeLevelNodeShouldComplete"--�����ڵ�Ӧ�����
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)  AS "threeLevelNodeDone"--�����ڵ��������
   ,SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ�Ӧ���  ELSE 0 END) -SUM(CASE WHEN SUBSTR(rangeval, 6, 2)=A.PLANMOTH  THEN  �����ڵ������  ELSE 0 END)   AS "threeLevelNodeUnfinished"--�����ڵ�δ�����
   ,  '' as  "openUrl"--�򿪵�ַ

FROM  V_POM_PJPLANRANK A
WHERE A.Ӧ���>0 AND  A.PLAN_TYPE='��Ŀ����ƻ�'  --AND  CTYPE='TYPE_ORG'
AND SUBSTR(rangeval, 0, 4)=A.PLANYEAR
--and (PARENT_ID ='003200000000000000000000000000' or  ORG_NAME ='�й������ز�����' )
AND( A.PARENT_ID  IN (  SELECT a.ID
	from   SYS_BUSINESS_UNIT A
	where  1=1 and    IS_COMPANY=1
	START WITH a.id=''||orgid||''
	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
	OR A.ID=''||orgid||'')

 GROUP BY A.ORG_NAME   ,A.ID,A.PARENT_ID   ,A.ORGCODE    
 ORDER BY A.ORGCODE      ;



END  IF;
    title := '�������а�_����Ŀ�ƻ���ϸ����ͳ��';
END p_pom_rank_proj_exam_dtl;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_PROJ_EXAM_DTLTEST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_PROJ_EXAM_DTLTEST" 
(
orgid   IN  VARCHAR2,
info           OUT            SYS_REFCURSOR
)
AS
BEGIN

OPEN info FOR
SELECT
  row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.Ӧ���,0)>0 THEN nvl(�����,0)/NVL(B.Ӧ���,0) ELSE 0 END *100,2) desc) as rank ,
  '��Ŀ����ƻ�'AS  PLAN_TYPE,A.ID,A.PARENT_ID,A.ORG_NAME ,B.PLANYEAR  ,B.PLANQUATOR,B.PLANMOTH
--     ,NVL(B.������Ӧ���,0) AS ������Ӧ���
--     ,NVL(B.�����������,0) AS �����������
    ,NVL(B.Ӧ���,0) AS Ӧ���
    ,NVL(B.�����,0) AS �����
    /*��̬�÷����*/
    , NVL(B.��̬�÷�,0) AS ��̬�÷�
    ,NVL(B.SUMNODESCORE,0) AS SUMNODESCORE
--     ,NVL(B.�����ȶ�̬�÷�,0) AS �����ȶ�̬�÷�
    /*��̱���һ���ڵ�������*/
    ,NVL(B.��̱�Ӧ���,0) AS ��̱�Ӧ���
    ,NVL(B.��̱������,0) AS ��̱������
    ,NVL(B.һ���ڵ�Ӧ���,0) AS һ���ڵ�Ӧ���
    ,NVL(B.һ���ڵ������,0) AS һ���ڵ������
    ,NVL(B.�����ڵ�Ӧ���,0) AS �����ڵ�Ӧ���
    ,NVL(B.�����ڵ������,0) AS �����ڵ������
    ,NVL(B.�����ڵ�Ӧ���,0) AS �����ڵ�Ӧ���
    ,NVL(B.�����ڵ������,0) AS �����ڵ������
--     ,NVL(B.��������̱�Ӧ���,0) AS ��������̱�Ӧ���
--     ,NVL(B.��������̱������,0) AS ��������̱������
--     ,NVL(B.������һ���ڵ�Ӧ���,0) AS ������һ���ڵ�Ӧ���
--     ,NVL(B.������һ���ڵ������,0) AS ������һ���ڵ������
    /*�������*/
    ,NVL(B.��̱��̵�,0) AS ��̱��̵�
    ,NVL(B.��̱��Ƶ�,0) AS ��̱��Ƶ�
    ,NVL(B.��̱����,0) AS ��̱����
    ,NVL(B.һ���ڵ��̵�,0) AS һ���ڵ��̵�
    ,NVL(B.һ���ڵ�Ƶ�,0) AS һ���ڵ�Ƶ�
    ,NVL(B.һ���ڵ���,0) AS һ���ڵ���
    ,NVL(B.�����ڵ��̵�,0) AS �����ڵ��̵�
    ,NVL(B.�����ڵ�Ƶ�,0) AS �����ڵ�Ƶ�
    ,NVL(B.�����ڵ���,0) AS �����ڵ���
    ,NVL(B.�����ڵ��̵�,0) AS �����ڵ��̵�
    ,NVL(B.�����ڵ�Ƶ�,0) AS �����ڵ�Ƶ�
    ,NVL(B.�����ڵ���,0) AS �����ڵ���

--     ,NVL(B.��������̱��̵�,0) AS ��������̱��̵�
--     ,NVL(B.��������̱��Ƶ�,0) AS ��������̱��Ƶ�
--     ,NVL(B.��������̱����,0) AS ��������̱����
--     ,NVL(B.������һ���ڵ��̵�,0) AS ������һ���ڵ��̵�
--     ,NVL(B.������һ���ڵ�Ƶ�,0) AS ������һ���ڵ�Ƶ�
--     ,NVL(B.������һ���ڵ���,0) AS ������һ���ڵ���
--     ,NVL(B.�����ȶ������ڵ��̵�,0) AS �����ȶ������ڵ��̵�
--     ,NVL(B.�����ȶ������ڵ�Ƶ�,0) AS �����ȶ������ڵ�Ƶ�
--     ,NVL(B.�����ȶ������ڵ���,0) AS �����ȶ������ڵ���

  ,'TYPE_ORG' AS CTYPE
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID
 ,AB.PLANYEAR  ,AB.PLANQUATOR,AB.PLANMOTH
--     ,SUM(AB.������Ӧ���) AS ������Ӧ���
--     ,SUM(AB.�����������) AS �����������
    ,SUM(AB.Ӧ���) AS Ӧ���
    ,SUM(AB.�����) AS �����
    /*��̬�÷����*/
    ,SUM(AB.��̬�÷�) AS ��̬�÷�
    ,SUM(AB.SUMNODESCORE) AS SUMNODESCORE
--     ,SUM(AB.�����ȶ�̬�÷�) AS �����ȶ�̬�÷�
    /*��̱���һ���ڵ�������*/
    ,SUM(AB.��̱�Ӧ���) AS ��̱�Ӧ���
     ,SUM(AB.��̱������) AS ��̱������
     ,SUM(AB.һ���ڵ�Ӧ���) AS һ���ڵ�Ӧ���
     ,SUM(AB.һ���ڵ������) AS һ���ڵ������
     ,SUM(AB.�����ڵ�Ӧ���) AS �����ڵ�Ӧ���
     ,SUM(AB.�����ڵ������) AS �����ڵ������
     ,SUM(AB.�����ڵ�Ӧ���) AS �����ڵ�Ӧ���
     ,SUM(AB.�����ڵ������) AS �����ڵ������
  --                    ,NVL(B.��������̱�Ӧ���,0) AS ��������̱�Ӧ���
  --                    ,NVL(B.��������̱������,0) AS ��������̱������
  --                    ,NVL(B.������һ���ڵ�Ӧ���,0) AS ������һ���ڵ�Ӧ���
  --                    ,NVL(B.������һ���ڵ������,0) AS ������һ���ڵ������
     /*�������*/
     ,SUM(AB.��̱��̵�) AS ��̱��̵�
     ,SUM(AB.��̱��Ƶ�) AS ��̱��Ƶ�
     ,SUM(AB.��̱����) AS ��̱����
     ,SUM(AB.һ���ڵ��̵�) AS һ���ڵ��̵�
     ,SUM(AB.һ���ڵ�Ƶ�) AS һ���ڵ�Ƶ�
     ,SUM(AB.һ���ڵ���) AS һ���ڵ���
     ,SUM(AB.�����ڵ��̵�) AS �����ڵ��̵�
     ,SUM(AB.�����ڵ�Ƶ�) AS �����ڵ�Ƶ�
     ,SUM(AB.�����ڵ���) AS �����ڵ���
     ,SUM(AB.�����ڵ��̵�) AS �����ڵ��̵�
     ,SUM(AB.�����ڵ�Ƶ�) AS �����ڵ�Ƶ�
     ,SUM(AB.�����ڵ���) AS �����ڵ���

--     ,SUM(AB.��������̱��̵�) AS ��������̱��̵�
--     ,SUM(AB.��������̱��Ƶ�) AS ��������̱��Ƶ�
--     ,SUM(AB.��������̱����) AS ��������̱����
--     ,SUM(AB.������һ���ڵ��̵�) AS ������һ���ڵ��̵�
--     ,SUM(AB.������һ���ڵ�Ƶ�) AS ������һ���ڵ�Ƶ�
--     ,SUM(AB.������һ���ڵ���) AS ������һ���ڵ���
--     ,SUM(AB.�����ȶ������ڵ��̵�) AS �����ȶ������ڵ��̵�
--     ,SUM(AB.�����ȶ������ڵ�Ƶ�) AS �����ȶ������ڵ�Ƶ�
--     ,SUM(AB.�����ȶ������ڵ���) AS �����ȶ������ڵ���
     FROM  (
--  11

                   SELECT
                  /*������*/
--                    ,NVL(B.������Ӧ���,0) AS ������Ӧ���
--                    ,NVL(B.�����������,0) AS �����������
                    B.PLANYEAR
                    ,B.PLANQUATOR
                    ,B.PLANMOTH
                   ,NVL(B.Ӧ���,0) AS Ӧ���
                   ,NVL(B.�����,0) AS �����
                   /*��̬�÷����*/
                   ,NVL(B.SUMNODESCORE,0)  AS "SUMNODESCORE"
                   ,NVL(B.��̬�÷�,0) AS ��̬�÷�
--                    ,NVL(B.�����ȶ�̬�÷�,0) AS �����ȶ�̬�÷�
                   /*��̱���һ���ڵ�������*/
                   ,NVL(B.��̱�Ӧ���,0) AS ��̱�Ӧ���
                   ,NVL(B.��̱������,0) AS ��̱������
                   ,NVL(B.һ���ڵ�Ӧ���,0) AS һ���ڵ�Ӧ���
                   ,NVL(B.һ���ڵ������,0) AS һ���ڵ������
                   ,NVL(B.�����ڵ�Ӧ���,0) AS �����ڵ�Ӧ���
                   ,NVL(B.�����ڵ������,0) AS �����ڵ������
                   ,NVL(B.�����ڵ�Ӧ���,0) AS �����ڵ�Ӧ���
                   ,NVL(B.�����ڵ������,0) AS �����ڵ������
--                    ,NVL(B.��������̱�Ӧ���,0) AS ��������̱�Ӧ���
--                    ,NVL(B.��������̱������,0) AS ��������̱������
--                    ,NVL(B.������һ���ڵ�Ӧ���,0) AS ������һ���ڵ�Ӧ���
--                    ,NVL(B.������һ���ڵ������,0) AS ������һ���ڵ������
                   /*�������*/
                   ,NVL(B.��̱��̵�,0) AS ��̱��̵�
                   ,NVL(B.��̱��Ƶ�,0) AS ��̱��Ƶ�
                   ,NVL(B.��̱����,0) AS ��̱����
                   ,NVL(B.һ���ڵ��̵�,0) AS һ���ڵ��̵�
                   ,NVL(B.һ���ڵ�Ƶ�,0) AS һ���ڵ�Ƶ�
                   ,NVL(B.һ���ڵ���,0) AS һ���ڵ���
                   ,NVL(B.�����ڵ��̵�,0) AS �����ڵ��̵�
                   ,NVL(B.�����ڵ�Ƶ�,0) AS �����ڵ�Ƶ�
                   ,NVL(B.�����ڵ���,0) AS �����ڵ���
                   ,NVL(B.�����ڵ��̵�,0) AS �����ڵ��̵�
                   ,NVL(B.�����ڵ�Ƶ�,0) AS �����ڵ�Ƶ�
                   ,NVL(B.�����ڵ���,0) AS �����ڵ���

--                    ,NVL(B.��������̱��̵�,0) AS ��������̱��̵�
--                    ,NVL(B.��������̱��Ƶ�,0) AS ��������̱��Ƶ�
--                    ,NVL(B.��������̱����,0) AS ��������̱����
--                    ,NVL(B.������һ���ڵ��̵�,0) AS ������һ���ڵ��̵�
--                    ,NVL(B.������һ���ڵ�Ƶ�,0) AS ������һ���ڵ�Ƶ�
--                    ,NVL(B.������һ���ڵ���,0) AS ������һ���ڵ���
--                    ,NVL(B.�����ȶ������ڵ��̵�,0) AS �����ȶ������ڵ��̵�
--                    ,NVL(B.�����ȶ������ڵ�Ƶ�,0) AS �����ȶ������ڵ�Ƶ�
--                    ,NVL(B.�����ȶ������ڵ���,0) AS �����ȶ������ڵ���
                   ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
                   from   SYS_BUSINESS_UNIT A  LEFT JOIN
                   (


                   SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"

                , TO_CHAR(A1.PLAN_END_DATE,'YYYY')   AS  "PLANYEAR"
                , CASE WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '12-26'  AND '03-25'  THEN 1
                       WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '03-26'  AND '06-25'  THEN 2
                       WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '06-26'  AND '09-25'  THEN 3
                       WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '09-26'  AND '12-25'  THEN 4  END
                      AS "PLANQUATOR"
                ,CASE
                        WHEN
                        CASE
                            WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN
                            TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) )
                          END > 12 THEN
                    1 ELSE
                  CASE
                      WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN
                      TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) )
                    END
                    END AS "PLANMOTH"
                  ,SUM(STANDARD_SCORE)   AS "SUMNODESCORE"
                   --��ɹ���




                   ------------------
                   /*����*/
                   ------------------
                   ------
                  , SUM(
                    (CASE
                      WHEN
                        TO_CHAR( A1.PLAN_END_DATE, 'YYYY-MM-DD' ) IS NOT NULL

                      THEN    1
                      ELSE 0
                      END
                      )
                    ) AS "Ӧ���"
                  ,SUM( (CASE      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                   --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                     THEN     1  ELSE    0 END))   AS "�����"

                  ,SUM(
                  (CASE
                  --��ʱ���
                      WHEN
                          TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                         --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                        AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )BETWEEN 0 AND 29
                      THEN   A1.STANDARD_SCORE*1
                      --��ǰһ�������
                      WHEN
                          TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
                          --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL='��̱�'
                      THEN   A1.STANDARD_SCORE*1.2
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                         --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                        AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL='һ���ڵ�'
                      THEN   A1.STANDARD_SCORE*1.1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                         --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

                          AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) - TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL IN ('�����ڵ�' ,'�����ڵ�')
                      THEN   A1.STANDARD_SCORE*1.0
                  --��ʱ���
                  --��̱���һ���ڵ�3��
                  --�������ڵ�5��
                  --��ʱ���
                    WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                         --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

                        AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND   A1.NODE_LEVEL IN ('��̱�' ,'һ���ڵ�')
                    THEN   A1.STANDARD_SCORE*0.6
                    WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                         --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

                        AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 3 AND A1.NODE_LEVEL IN ('�����ڵ�' ,'�����ڵ�')
                    THEN   A1.STANDARD_SCORE*1.0
                    WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                       --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                        AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 4 AND 7 AND A1.NODE_LEVEL IN ('�����ڵ�' ,'�����ڵ�')
                    THEN   A1.STANDARD_SCORE*0.6
                  --���
                    WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                       --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

                      AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('��̱�' ,'һ���ڵ�')
                    THEN   A1.STANDARD_SCORE*0
                    WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                       --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

                      AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )>=8  AND  A1.NODE_LEVEL IN ('�����ڵ�' ,'�����ڵ�')
                    THEN   A1.STANDARD_SCORE*0
                  ELSE  0 END
                  )
                  )   AS "��̬�÷�"

                   ------------------
                   /*-��̱�������*/
                   ------------------
                  ,SUM((CASE  WHEN      A1. NODE_LEVEL='��̱�'

                              THEN   1  ELSE    0 END))   AS "��̱�Ӧ���"
                  ,SUM((CASE  WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
                              AND A1. NODE_LEVEL='��̱�'
                              THEN   1  ELSE    0 END))   AS "��̱������"
                   ------------------
                   /*-һ���ڵ�������*/
                   ------------------
                  ,SUM((CASE   WHEN     A1. NODE_LEVEL='һ���ڵ�'
                                THEN   1  ELSE    0 END))   AS "һ���ڵ�Ӧ���"
                  ,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
                              AND A1. NODE_LEVEL='һ���ڵ�'
                                   THEN   1  ELSE    0 END))   AS "һ���ڵ������"
                   ------------------
                   /*-�����ڵ�������*/
                   ------------------
                  ,SUM((CASE   WHEN     A1. NODE_LEVEL='�����ڵ�'
                                THEN   1  ELSE    0 END))   AS "�����ڵ�Ӧ���"
                  ,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
                              AND A1. NODE_LEVEL='�����ڵ�'
                                   THEN   1  ELSE    0 END))   AS "�����ڵ������"
                     ------------------
                   /*-�����ڵ�������*/
                   ------------------
                  ,SUM((CASE   WHEN     A1. NODE_LEVEL='�����ڵ�'
                                THEN   1  ELSE    0 END))   AS "�����ڵ�Ӧ���"
                  ,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
                              AND A1. NODE_LEVEL='���꼶�ڵ�'
                                   THEN   1  ELSE    0 END))   AS "�����ڵ������"

                    ------------------
                   /*-��̱��������*/
                   ------------------
                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 0 AND    A1.NODE_LEVEL IN ('��̱�')
                        THEN 1

                       ELSE  0  END ) AS  "��̱��̵�"

                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND    A1.NODE_LEVEL IN ('��̱�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4  AND    A1.NODE_LEVEL IN ('��̱�')
                        THEN 1


                       ELSE  0  END ) AS  "��̱��Ƶ�"


                  ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('��̱�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('��̱�')
                        THEN 1


                       ELSE  0  END ) AS  "��̱����"



                    ------------------
                   /*һ���ڵ��������*/
                   ------------------
                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 0  AND    A1.NODE_LEVEL IN ('һ���ڵ�')
                        THEN 1

                       ELSE  0  END ) AS  "һ���ڵ��̵�"

                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND    A1.NODE_LEVEL IN ('һ���ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4  AND    A1.NODE_LEVEL IN ('һ���ڵ�')
                        THEN 1


                       ELSE  0  END ) AS  "һ���ڵ�Ƶ�"


                  ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('һ���ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('һ���ڵ�')
                        THEN 1


                       ELSE  0  END ) AS  "һ���ڵ���"




                    ------------------
                   /*�����ڵ��������*/
                   ------------------
                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 2 AND     A1.NODE_LEVEL IN ('�����ڵ�')
                        THEN 1

                       ELSE  0  END ) AS  "�����ڵ��̵�"

                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7 AND    A1.NODE_LEVEL IN ('�����ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7  AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1


                       ELSE  0  END ) AS  "�����ڵ�Ƶ�"


                  ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1


                    ELSE  0  END ) AS  "�����ڵ���"

                    ------------------
                   /*�����ڵ��������*/
                   ------------------
                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 2 AND     A1.NODE_LEVEL IN ('�����ڵ�')
                        THEN 1

                       ELSE  0  END ) AS  "�����ڵ��̵�"

                   ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7 AND    A1.NODE_LEVEL IN ('�����ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7  AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1


                       ELSE  0  END ) AS  "�����ڵ�Ƶ�"


                  ,SUM(CASE
                        WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1
                      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL

                            --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
                          AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('�����ڵ�')
                        THEN 1


                    ELSE  0  END ) AS  "�����ڵ���"

                  FROM
                  POM_PROJ_PLAN A
                  INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
                  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
                  INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
                  LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='1' AND  D.APPROVAL_STATUS='�����'
                  WHERE  A.PLAN_TYPE='��Ŀ����ƻ�' AND  A.APPROVAL_STATUS='�����'
                  GROUP BY B1.UNIT_ID  , TO_CHAR(A1.PLAN_END_DATE,'YYYY')
                  , CASE WHEN CASE   WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN  TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) )
                        END > 12 THEN  1 ELSE  CASE    WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN    TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) )
                  END   END
                  , CASE WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '12-26'  AND '03-25'  THEN 1    WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '03-26'  AND '06-25'  THEN 2
                   WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '06-26'  AND '09-25'  THEN 3      WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '09-26'  AND '12-25'  THEN 4  END

                    )  B ON  A.ID=B.UNIT_ID
                    WHERE NVL(B.NODESUM,0)>0
										start with  a.id='45e9c408-dd59-4a41-8c50-7b4eaf6c1e46'
                  CONNECT  by PRIOR   A.ID= A.PARENT_ID
									
) AB
GROUP BY AB.ID,AB.PARENT_ID  ,AB.PLANYEAR  ,AB.PLANQUATOR,AB.PLANMOTH
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  ;--  AND  A.COMPANY_TYPE='5' AND  A.PARENT_ID='003200000000000000000000000000'
--

 

END p_pom_rank_proj_exam_dtltest;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RANK_PROJ_EXAMINATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RANK_PROJ_EXAMINATION" (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    rangetype        IN             INT,--ʱ�䷶Χ���ͣ�10:�¶ȣ�20���ȣ�
     plantype       IN             INT,--�ƻ����ͣ�30���ؼ��ڵ�ƻ���40����Ŀ����ƻ���
    rangeval    IN          VARCHAR2,--��Χֵ���¶ȣ�2019|09�����ȣ�2019|04
    orgid       IN          VARCHAR2,--��֯id(�ؼ��ڵ�ƻ�����,��Ŀ����ƻ�����
    title          OUT            VARCHAR2,--����
    bartype        OUT            VARCHAR2,--ͼ����
    unit           OUT            VARCHAR2,--��λ
    info      OUT            SYS_REFCURSOR--ͼ����
) AS
--��Ŀ��������
--���ߣ�����
--���ڣ�2019/11/13
BEGIN

IF rangetype=10  AND plantype=30
THEN
OPEN info FOR
SELECT A.ORG_NAME AS "name",
			 TO_CHAR(CASE
									 WHEN SUM(CASE
																WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND
																		 SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																 SUMNODESCORE
																ELSE
																 0
														END) > 0 THEN
										ROUND(SUM(CASE

																	WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND
																			 SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																	  "��̬�÷�"
																	ELSE
																	 0
															END) / SUM(CASE

																						 WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND
																									SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN
																							SUMNODESCORE
																						 ELSE
																							0
																				 END) * 100, 2)
									 ELSE
										0
							 END) AS "total"
			  ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
				--,'90 'AS "total"
			 , '#37cd69' AS "color"
FROM   V_POM_PJPLAN_EXM_SOCRE A
 
WHERE  1=1

		AND 	 A.PLAN_TYPE = '�ؼ��ڵ�ƻ�'
		AND 	 A.CTYPE = 'TYPE_PROJTOP'  
		AND 	 SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR  
		AND 	 SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH  
		 AND( A.PARENT_ID  IN (  SELECT a.ID
 	from   SYS_BUSINESS_UNIT A
 	where  1=1 and    IS_COMPANY=1
 	START WITH a.id=''||orgid||''
 	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
 	OR A.ID=''||orgid||'')
--      AND   B.COMPANY_TYPE='5'
GROUP  BY A.ORG_NAME
HAVING SUM(SUMNODESCORE)>0
ORDER  BY 3 asc;

ELSIF RANGETYPE = 10 AND PLANTYPE = 40 THEN OPEN INFO FOR

SELECT A.ORG_NAME AS "name"
, TO_CHAR(CASE WHEN SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN SUMNODESCORE ELSE 0 END) > 0 THEN ROUND(SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN  "��̬�÷�" ELSE 0 END)
/ SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH THEN SUMNODESCORE ELSE 0 END) * 100, 2) ELSE 0 END) AS "total" --,'90 'AS "total"
  ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
			
, '#37cd69' AS "color"
FROM V_POM_PJPLAN_EXM_SOCRE A 
-- INNER JOIN SYS_BUSINESS_UNIT B ON A.ID = B.ID
WHERE 1=1
AND SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR 
AND SUBSTR(RANGEVAL, 6, 2) = A.PLANMOTH 
AND A.CTYPE = 'TYPE_PROJTOP' AND A.PLAN_TYPE = '��Ŀ����ƻ�'
AND( A.PARENT_ID  IN (  SELECT a.ID
 	from   SYS_BUSINESS_UNIT A
 	where  1=1 and    IS_COMPANY=1
 	START WITH a.id=''||orgid||''
 	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
 	OR A.ID=''||orgid||'')
GROUP BY A.ORG_NAME ORDER BY 3 asc ;

ELSIF RANGETYPE = 20 AND PLANTYPE = 30 THEN 

OPEN INFO FOR 

SELECT A.ORG_NAME AS "name"
, TO_CHAR(CASE WHEN SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN SUMNODESCORE ELSE 0 END) > 0 THEN ROUND(SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN  "��̬�÷�" ELSE 0 END)
/ SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN SUMNODESCORE ELSE 0 END) * 100, 2) ELSE 0 END) AS "total" --,'90 'AS "total"
  ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
, '#37cd69' AS "color" 
FROM V_POM_PJPLAN_EXM_SOCRE A 
-- INNER JOIN SYS_BUSINESS_UNIT B ON A.ID = B.ID 
WHERE 1=1
AND A.CTYPE = 'TYPE_PROJTOP' 
AND A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' 
AND SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR
AND( A.PARENT_ID  IN (  SELECT a.ID
 	from   SYS_BUSINESS_UNIT A
 	where  1=1 and    IS_COMPANY=1
 	START WITH a.id=''||orgid||''
 	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
 	OR A.ID=''||orgid||'')
--      AND   B.COMPANY_TYPE='5'
GROUP BY A.ORG_NAME ORDER BY 3 asc;

ELSIF RANGETYPE = 20 AND PLANTYPE = 40 THEN 
OPEN INFO FOR 
SELECT A.ORG_NAME AS "name"
, TO_CHAR(CASE WHEN SUM(CASE WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN SUMNODESCORE ELSE 0 END) > 0 THEN ROUND(SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN  "��̬�÷�" ELSE 0 END)
/ SUM(CASE
WHEN SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR THEN SUMNODESCORE ELSE 0 END) * 100, 2) ELSE 0 END) AS "total" --,'90 'AS "total"
  ,  
   CASE WHEN  SUM(
                  CASE
                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                  SUMNODESCORE ELSE 0
                    END
                )>0
        THEN   ROUND(
              SUM(
                  CASE

                      WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                      AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                         "��̬�÷�" ELSE 0
                      END
                        ) / SUM(
                      CASE

                  WHEN SUBSTR( '2020|02', 0, 4 ) = A.PLANYEAR
                  AND SUBSTR( '2020|02', 6, 2 ) = A.PLANQUATOR THEN
                    SUMNODESCORE ELSE 0
                  END
                ) * 100,
                2
              )
          ELSE  0 END
          
           AS   totalRank
			
, '#37cd69' AS "color" 
FROM V_POM_PJPLAN_EXM_SOCRE A 
-- INNER JOIN SYS_BUSINESS_UNIT B ON A.ID = B.ID 
WHERE 1=1
AND SUBSTR(RANGEVAL, 0, 4) = A.PLANYEAR 
AND SUBSTR(RANGEVAL, 6, 2) = A.PLANQUATOR 
AND A.CTYPE = 'TYPE_PROJTOP' 
AND A.PLAN_TYPE = '��Ŀ����ƻ�'
AND( A.PARENT_ID  IN (  SELECT a.ID
 	from   SYS_BUSINESS_UNIT A
 	where  1=1 and    IS_COMPANY=1
 	START WITH a.id=''||orgid||''
 	CONNECT  by PRIOR   A.ID= A.PARENT_ID	)
 	OR A.ID=''||orgid||'')
GROUP BY A.ORG_NAME ORDER BY 3 asc; END IF; TITLE := CASE WHEN PLANTYPE = 40 THEN '��Ŀ����ƻ�' ELSE '�ؼ��ڵ�ƻ�' END || '����_��Ŀ���а�'; UNIT := '%'; BARTYPE := 'column';

END P_POM_RANK_PROJ_EXAMINATION;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_REPAIR_GET_BUILDING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_REPAIR_GET_BUILDING" (
    info out sys_refcursor,
    projectStageId in varchar2
) AS
begin
    open info for with t1 as (
        select ID, ORDER_HIERARCHY_CODE, BUILD_NAME, PERIOD_ID, PROJ_ID
        from MDM_BUILD mb1
        where IS_GET_COMPLETED_PERMIT = 1
          and (projectStageId is null or mb1.PERIOD_ID = projectStageId)
    ), t2 as (
        select
            mbp.BUILD_ID,
            WM_CONCAT(moppi.PRODUCT_TYPE_ID) productTypeIds,
            WM_CONCAT(moppi.PRODUCT_TYPE_NAME) productTypeNames
        from t1 inner join MDM_BUILD_PHASE mbp on t1.ID = mbp.BUILD_ID
             inner join MDM_OBJ_PHASE_PT_INDEX moppi on moppi.OBJ_PHASE_ID = mbp.ID
        group by mbp.BUILD_ID
    )
                  select
                      mb1.ID "id",
                      mb1.ORDER_HIERARCHY_CODE "buildingCode",
                      mb1.BUILD_NAME "buildingName",
                          mp2.PROJECT_NAME || '_' || mp1.PERIOD_NAME || '_' || mb1.BUILD_NAME "buildingFullName",
                      mp1.ID "projectStageId",
                      mp1.PERIOD_NAME "projectStageName",
                      '' "buildingDeliveryDate",
                      mp2.ID "projectId",
                      mp2.PROJECT_NAME "projectName",
                      productTypeIds "productTypeIds",
                      productTypeNames "productTypeNames"
                  from t1 mb1
                       inner join MDM_PERIOD mp1 on mb1.PERIOD_ID = mp1.ID
                       inner join MDM_PROJECT mp2 on mp2.ID = mb1.PROJ_ID
                       inner join t2 on t2.BUILD_ID = mb1.ID;
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_REPAIR_PRODUCT_TYPE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_REPAIR_PRODUCT_TYPE" (
    info out sys_refcursor
) as
begin
    open info for
        select
            mbpt.ID "id",
            mbpt.PRODUCT_TYPE_SHORT_CODE "productTypeShortCode",
            mbpt.PRODUCT_TYPE_SHORT_NAME "productTypeShortName",
            mbpt.PRODUCT_TYPE_CODE "productTypeCode",
            mbpt.PRODUCT_TYPE_NAME "productTypeName",
            mbpt.PARENT_CODE "parentCode",
            mbpt.PRODUCT_TYPE_LEVEL "level",
            mbpt.IS_END "isEnd"
        from MDM_BUILD_PRODUCT_TYPE mbpt
        order by mbpt.PRODUCT_TYPE_SHORT_CODE;
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RULE_MSG_PRE_GENERATED
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RULE_MSG_PRE_GENERATED" 
(
    RULEID        IN VARCHAR --����ID
   ,MSGGROUPID    OUT VARCHAR --���β�����POM_PRE_GENERATED_MESSAGE���У�Ψһ��ʶ
   ,TOTAL         OUT NUMBER --���θ��µ���������
   ,EXECUTIONTIME OUT VARCHAR --�洢����ִ�е�ʱ��
) AS
    --Ԥ�������ѣ���ϢԤ���ɡ�
    --���ߣ�����
    --���ڣ�2019/11/15

    VS_WHERE     CLOB; --SQL����where����������̬SQL
    VS_KEY_PLAN  CLOB; --�ؼ��ڵ�ƻ���̬SQL
    VS_PROJ_PLAN CLOB; --��Ŀ����ƻ���̬SQL
    VS_DEPT_PLAN CLOB; --�����¶ȼƻ���̬SQL
    VS_SPEC_PLAN CLOB; --ר��ƻ���̬SQL
    VS_QUERY     CLOB; --ƴ������SQL

    V_FLAG            NUMBER(2, 0); --�жϵ�ǰ�����Ƿ��ִ�У����жϹ������������⣬ֱ��RETURN
    V_RULE_TYPE       VARCHAR2(100); --��¼��ǰ��������
    V_PLAN_TYPE       VARCHAR(200); --�洢��������
    V_SYSTEM_ID       VARCHAR(100); --ϵͳID���̶�ֵ������POM_PRE_GENERATED_MESSAGE����ʱʹ�ã����
    V_RULE_NODE_LEVEL VARCHAR(100); --�洢��������񼶱�����ƴ��VS_WHERE�ַ���
    V_RULE_MSG        VARCHAR(200); --�洢�����ж������Ϣ��ʽ
    V_RULE_FERQ_TYPE  VARCHAR(200); --ִ��Ƶ�����
    V_RULE_FERQ_DATE  VARCHAR(200); --��һ��ִ�У������ִ���������ж�

    V_MONTH_DAY VARCHAR(20); -- ȡ�����еĺ�
    V_WEEK_DAY  VARCHAR(20); -- ȡ���ڼ�
    --����RC_NODE_INFO���ͣ��洢�ڵ���Ϣ
    TYPE RC_NODE_INFO IS RECORD(
         PLAN_NAME        POM_PROJ_PLAN.PLAN_NAME%TYPE
        ,COMPANY_NAME     POM_PROJ_PLAN.COMPANY_NAME%TYPE
        ,DEPT_ID          POM_NODE_CHARGE_PERSON.CHARGE_PERSON_DEPT_ID%TYPE
        ,COMPANY_ID       POM_NODE_CHARGE_PERSON.CHARGE_PERSON_COMPANY_ID%TYPE
        ,NODE_NAME        POM_PROJ_PLAN_NODE.NODE_NAME%TYPE
        ,NODE_LEVEL       POM_PROJ_PLAN_NODE.NODE_LEVEL%TYPE
        ,PLAN_ID          POM_PROJ_PLAN_NODE.PROJ_PLAN_ID%TYPE
        ,NODE_ID          POM_PROJ_PLAN_NODE.ID%TYPE
        ,PLAN_START_DATE  VARCHAR(50)
        ,PLAN_END_DATE    VARCHAR(50)
        ,CHARGE_PERSON_ID POM_NODE_CHARGE_PERSON.ID%TYPE
        ,CHARGE_PERSON    POM_NODE_CHARGE_PERSON.CHARGE_PERSON%TYPE
        ,CURRENT_DATE     VARCHAR(50)
        ,NODE_MSG         VARCHAR(100)
        ,PROJ_ID          VARCHAR(100));
    --����V_NODE_INFO����

    V_NODE_INFO RC_NODE_INFO;
    --����ref_type����
    TYPE REF_TYPE IS REF CURSOR;
    VC_REF REF_TYPE;

    V_BUFFER VARCHAR(200); --�����洢��������ʱʹ�õ�ֵ

BEGIN
    EXECUTIONTIME := TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MM:SS');
    MSGGROUPID    := GET_UUID();
    V_SYSTEM_ID   := '71313f018a35f3a558166cba7599b5d6';

    V_MONTH_DAY := TO_CHAR(SYSDATE, 'dd');
    V_WEEK_DAY := CASE
                      WHEN TO_CHAR(SYSDATE, 'day') = '����һ' THEN
                       1
                      WHEN TO_CHAR(SYSDATE, 'day') = '���ڶ�' THEN
                       2
                      WHEN TO_CHAR(SYSDATE, 'day') = '������' THEN
                       3
                      WHEN TO_CHAR(SYSDATE, 'day') = '������' THEN
                       4
                      WHEN TO_CHAR(SYSDATE, 'day') = '������' THEN
                       5
                      WHEN TO_CHAR(SYSDATE, 'day') = '������' THEN
                       6
                      WHEN TO_CHAR(SYSDATE, 'day') = '������' THEN
                       7
                  END;

    DBMS_OUTPUT.PUT_LINE(V_WEEK_DAY || ' ,' || V_MONTH_DAY);

    BEGIN
        SELECT NVL(A.IS_DISABLE, 0)
        INTO   V_FLAG
        FROM   POM_RULE_SET A
        WHERE  A.ID = RULEID;

        SELECT COUNT(1)
        INTO   V_FLAG
        FROM   POM_RULE_SET_PLAN_TYPE A
        WHERE  A.RULE_ID = RULEID;

        IF V_FLAG = 0 THEN
            DBMS_OUTPUT.PUT_LINE('��⵽��POM_RULE_SET_PLAN_TYPE�����������ݣ�����������Ϣ');
            RETURN;
        END IF;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_FLAG := 0;
            DBMS_OUTPUT.PUT_LINE('�ù����ʼ����Ϣ���������������');
    END;

    SELECT A.EXPRESSION, A.RULE_TYPE, A.NODE_LEVEL, A.MESSAGE_TEMPLATE,
           A.TIME_FREQUENCY, A.MSG_FREQUENCY_TYPE, A.DATE_FREQUENCY
    INTO   VS_WHERE, V_RULE_TYPE, V_RULE_NODE_LEVEL, V_RULE_MSG,
           EXECUTIONTIME, V_RULE_FERQ_TYPE, V_RULE_FERQ_DATE
    FROM   POM_RULE_SET A
    WHERE  A.ID = RULEID AND
           IS_DISABLE <> 1;
    /*
    WHERE����ƴ��
    */
    V_RULE_NODE_LEVEL := ' AND NODE_LEVEL = ''' || V_RULE_NODE_LEVEL || '''';
    VS_WHERE          := 'WHERE 1=1 ' || ' AND ' || VS_WHERE; --1=1��ɾ��ȷ������where���Ƿ���������SQL����ִ��
    VS_WHERE          := VS_WHERE || V_RULE_NODE_LEVEL;

    SELECT TO_CHAR(WM_CONCAT(A.PLAN_TYPE))
    INTO   V_PLAN_TYPE
    FROM   POM_RULE_SET_PLAN_TYPE A
    WHERE  A.RULE_ID = RULEID;

    --ִ��Ƶ���ж�
    IF V_RULE_FERQ_TYPE = 'ÿ��' THEN
        IF V_WEEK_DAY <> V_RULE_FERQ_DATE THEN
            TOTAL := 0;
            RETURN;
        END IF;
    ELSIF V_RULE_FERQ_TYPE = 'ÿ��' THEN
        IF V_MONTH_DAY <> V_RULE_FERQ_DATE THEN
            TOTAL := 0;
            RETURN;
        END IF;
    ELSIF V_RULE_FERQ_TYPE = '����һ��' THEN
        VS_WHERE := VS_WHERE ||
                    ' AND NOT EXISTS (SELECT 1 FROM POM_PRE_GENERATED_MESSAGE WHERE POM_PRE_GENERATED_MESSAGE.BIZ_KEY = NODE_ID) ';
    END IF;

    IF INSTR(V_PLAN_TYPE, '��Ŀ����ƻ�', 1, 1) <> 0 THEN
        /*
            SQLƴ�ӣ�where�����е�1=1��ɾ����ֹRTRIMʱ����NULL�ַ�ɾ��
        */
        VS_PROJ_PLAN := ' SELECT A.PLAN_NAME, A.COMPANY_NAME,C.CHARGE_PERSON_DEPT_ID AS DEPT_ID,C.CHARGE_PERSON_COMPANY_ID AS COMPANY_ID, B.NODE_NAME,B.NODE_LEVEL AS NODE_LEVEL, A.ID AS PLAN_ID, B.ID AS NODE_ID,TO_CHAR(B.PLAN_START_DATE, ''YYYY-MM-DD'') AS PLAN_START_DATE,TO_CHAR(B.PLAN_END_DATE, ''YYYY-MM-DD'') AS PLAN_END_DATE,C.CHARGE_PERSON_ID, C.CHARGE_PERSON,TO_CHAR(SYSDATE, ''YYYY-MM-DD'') AS CURRENT_DATE,a.PROJ_ID FROM   POM_PROJ_PLAN A INNER  JOIN POM_PROJ_PLAN_NODE B ON     A.ID = B.PROJ_PLAN_ID INNER  JOIN POM_NODE_CHARGE_PERSON C ON     B.ID = C.NODE_ID WHERE  A.PLAN_TYPE = ''��Ŀ����ƻ�'' AND B.ACTUAL_END_DATE IS NULL AND 1=1   UNION ALL';
    ELSE
        VS_PROJ_PLAN := '';
    END IF;

    IF INSTR(V_PLAN_TYPE, '�ؼ��ڵ�ƻ�', 1, 1) <> 0 THEN
        VS_KEY_PLAN := ' SELECT A.PLAN_NAME, A.COMPANY_NAME, C.CHARGE_PERSON_DEPT_ID AS DEPT_ID,C.CHARGE_PERSON_COMPANY_ID AS COMPANY_ID, B.NODE_NAME,B.NODE_LEVEL AS NODE_LEVEL, A.ID AS PLAN_ID, B.ID AS NODE_ID,TO_CHAR(B.PLAN_START_DATE, ''YYYY-MM-DD'') AS PLAN_START_DATE,TO_CHAR(B.PLAN_END_DATE, ''YYYY-MM-DD'') AS PLAN_END_DATE,C.CHARGE_PERSON_ID, C.CHARGE_PERSON,TO_CHAR(SYSDATE, ''YYYY-MM-DD'') AS CURRENT_DATE,a.PROJ_ID  FROM   POM_PROJ_PLAN A INNER  JOIN POM_PROJ_PLAN_NODE B ON     A.ID = B.PROJ_PLAN_ID INNER  JOIN POM_NODE_CHARGE_PERSON C ON     B.ID = C.NODE_ID WHERE  A.PLAN_TYPE = ''�ؼ��ڵ�ƻ�'' AND B.ACTUAL_END_DATE IS NULL AND 1=1 UNION ALL';
    ELSE
        VS_KEY_PLAN := '';
    END IF;

    IF INSTR(V_PLAN_TYPE, 'ר��ƻ�', 1, 1) <> 0 THEN
        VS_SPEC_PLAN := ' SELECT A.PLAN_NAME, A.COMPANY_NAME, C.CHARGE_PERSON_DEPT_ID AS DEPT_ID,C.CHARGE_PERSON_COMPANY_ID AS COMPANY_ID, B.NODE_NAME,NULL AS NODE_LEVEL, A.ID AS PLAN_ID, B.ID AS NODE_ID,TO_CHAR(B.PLAN_START_DATE, ''YYYY-MM-DD'') AS PLAN_START_DATE,TO_CHAR(B.PLAN_END_DATE, ''YYYY-MM-DD'') AS PLAN_END_DATE,C.CHARGE_PERSON_ID, C.CHARGE_PERSON,TO_CHAR(SYSDATE, ''YYYY-MM-DD'') AS CURRENT_DATE,null FROM   POM_SPECIAL_PLAN A INNER  JOIN POM_SPECIAL_PLAN_NODE B ON     A.ID = B.PLAN_ID INNER  JOIN POM_NODE_CHARGE_PERSON C ON     B.ID = C.NODE_ID WHERE  B.ACTUAL_END_DATE IS NULL AND 1=1 UNION ALL';
    ELSE
        VS_SPEC_PLAN := '';
    END IF;

    IF INSTR(V_PLAN_TYPE, '�����¶ȼƻ�', 1, 1) <> 0 THEN
        VS_DEPT_PLAN := ' SELECT A.PLAN_NAME, A.COMPANY_NAME, C.CHARGE_PERSON_DEPT_ID AS DEPT_ID,C.CHARGE_PERSON_COMPANY_ID AS COMPANY_ID, B.NODE_NAME,B.NODE_TYPE AS NODE_LEVEL, A.ID AS PLAN_ID, B.ID AS NODE_ID,TO_CHAR(B.PLAN_START_DATE, ''YYYY-MM-DD'') AS PLAN_START_DATE,TO_CHAR(B.PLAN_END_DATE, ''YYYY-MM-DD'') AS PLAN_END_DATE,C.CHARGE_PERSON_ID, C.CHARGE_PERSON,TO_CHAR(SYSDATE, ''YYYY-MM-DD'') AS CURRENT_DATE FROM   POM_DEPT_MONTHLY_PLAN A INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B ON     A.ID = B.DEPT_MONTHLY_PLAN_ID INNER  JOIN POM_NODE_CHARGE_PERSON C ON     B.ID = C.NODE_ID WHERE  B.ACTUAL_END_DATE IS NULL AND 1=1 UNION ALL';
    ELSE
        VS_DEPT_PLAN := '';
    END IF;

    /*    IF V_RULE_TYPE = '���ѹ���' THEN
        --�·��貹�����ѹ��������

        VS_WHERE = VS_WHERE || '';

    ELSIF V_RULE_TYPE = 'Ԥ������' THEN
        --�·�����Ԥ�����������
        VS_WHERE = VS_WHERE || '';

    END IF;*/

    VS_QUERY := 'SELECT PLAN_NAME,COMPANY_NAME,DEPT_ID,COMPANY_ID,NODE_NAME,NODE_LEVEL,PLAN_ID,NODE_ID,PLAN_START_DATE,PLAN_END_DATE,CHARGE_PERSON_ID,CHARGE_PERSON, CURRENT_DATE, ' ||
                V_RULE_MSG || ' AS NODE_MSG FROM (' ||
                RTRIM(VS_PROJ_PLAN || ' ' || VS_KEY_PLAN || ' ' ||
                      VS_SPEC_PLAN || ' ' || VS_DEPT_PLAN, 'UNION ALL') || ')' || ' ' ||
                VS_WHERE;

    DBMS_OUTPUT.PUT_LINE(VS_QUERY);
    /*
        ����ֵ��POM_PRE_GENERATED_MESSAGE����
    */

    OPEN VC_REF FOR VS_QUERY;
    LOOP
        FETCH VC_REF
            INTO V_NODE_INFO;
        EXIT WHEN VC_REF%NOTFOUND;
        INSERT INTO POM_PRE_GENERATED_MESSAGE
        VALUES
            (GET_UUID(),MSGGROUPID, V_NODE_INFO.NODE_MSG, V_NODE_INFO.CHARGE_PERSON_ID,
             V_NODE_INFO.NODE_ID, 'wangck', '�ƻ�����',
             CASE WHEN V_RULE_TYPE = '���ѹ���' THEN '������Ϣ' WHEN
              V_RULE_TYPE = 'Ԥ������' THEN 'Ԥ����Ϣ' ELSE NULL END, V_SYSTEM_ID,
             'wechat_jumpLink_Url',V_NODE_INFO.COMPANY_ID,V_NODE_INFO.DEPT_ID,V_NODE_INFO.PROJ_ID);
    END LOOP;
    
    VS_QUERY:=' insert into POM_PRE_GENERATED_MESSAGE  '||VS_QUERY; 
    execute immediate VS_QUERY;
    TOTAL := VC_REF%ROWCOUNT;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('���³ɹ����Ѹ�������' || TOTAL || '��');
    CLOSE VC_REF;

END P_POM_RULE_MSG_PRE_GENERATED;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_RULE_MSG_PUSH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_RULE_MSG_PUSH" 
(
    RULEID     IN VARCHAR
   ,MSGGROUPID IN VARCHAR
   ,MESSAGE    OUT SYS_REFCURSOR
) AS
    --Ԥ�������ѣ���Ϣ���͡�p_pom_rule_msg_pre_generated
    --���ߣ�����
    --���ڣ�2019/11/15
    TYPE REF_CURSOR IS REF CURSOR;
    VC_REF_CURSOR REF_CURSOR;

    TYPE RC_PRE_MSG IS RECORD(
         ID                  POM_PRE_GENERATED_MESSAGE.ID%TYPE
        ,MSG_GROUP_ID        POM_PRE_GENERATED_MESSAGE.MSG_GROUP_ID%TYPE
        ,MSG_DESCRIPTION     POM_PRE_GENERATED_MESSAGE.MSG_DESCRIPTION%TYPE
        ,RECIPIENT_ID        POM_PRE_GENERATED_MESSAGE.RECIPIENT_ID%TYPE
        ,BIZ_KEY             POM_PRE_GENERATED_MESSAGE.BIZ_KEY%TYPE
        ,SENDER_ID           POM_PRE_GENERATED_MESSAGE.SENDER_ID%TYPE
        ,BIZ_SOURCE_CATEGORY POM_PRE_GENERATED_MESSAGE.BIZ_SOURCE_CATEGORY%TYPE
        ,BIZ_MSG_CATEGORY    POM_PRE_GENERATED_MESSAGE.BIZ_MSG_CATEGORY%TYPE
        ,SYSTEM_ID           POM_PRE_GENERATED_MESSAGE.SYSTEM_ID%TYPE
        ,WECHAT_JUMPLINK_URL POM_PRE_GENERATED_MESSAGE.WECHAT_JUMPLINK_URL%TYPE
        ,COMPANY_ID          POM_PRE_GENERATED_MESSAGE.COMPANY_ID%TYPE
        ,DEPT_ID             POM_PRE_GENERATED_MESSAGE.DEPT_ID%TYPE
        ,PROJ_ID             POM_PRE_GENERATED_MESSAGE.PROJ_ID%TYPE);
    V_RC_PRE_MSG RC_PRE_MSG;
BEGIN
    OPEN VC_REF_CURSOR FOR
        SELECT A.ID, A.MSG_GROUP_ID AS "msgGroupId",
               A.MSG_DESCRIPTION AS "msgDescription",
               A.RECIPIENT_ID AS "RecipientId", A.BIZ_KEY AS "bizKey",
               A.SENDER_ID AS "senderId",
               A.BIZ_SOURCE_CATEGORY AS "bizSourceCategory",
               A.BIZ_MSG_CATEGORY AS "bizMsgCategory",
               A.SYSTEM_ID AS "systemId",
               A.WECHAT_JUMPLINK_URL AS "wechatJumplinkUrl"
        FROM   POM_PRE_GENERATED_MESSAGE A
        INNER  JOIN POM_PROJ_PLAN_NODE B
        ON     A.BIZ_KEY = B.ID
        WHERE  MSG_GROUP_ID = MSGGROUPID AND
               B.ACTUAL_END_DATE IS NOT NULL
        UNION ALL
        SELECT A.ID, A.MSG_GROUP_ID AS "msgGroupId",
               A.MSG_DESCRIPTION AS "msgDescription",
               A.RECIPIENT_ID AS "RecipientId", A.BIZ_KEY AS "bizKey",
               A.SENDER_ID AS "senderId",
               A.BIZ_SOURCE_CATEGORY AS "bizSourceCategory",
               A.BIZ_MSG_CATEGORY AS "bizMsgCategory",
               A.SYSTEM_ID AS "systemId",
               A.WECHAT_JUMPLINK_URL AS "wechatJumplinkUrl"
        FROM   POM_PRE_GENERATED_MESSAGE A
        INNER  JOIN POM_SPECIAL_PLAN_NODE B
        ON     A.BIZ_KEY = B.ID
        WHERE  MSG_GROUP_ID = MSGGROUPID AND
               B.ACTUAL_END_DATE IS NOT NULL
        UNION ALL
        SELECT A.ID, A.MSG_GROUP_ID AS "msgGroupId",
               A.MSG_DESCRIPTION AS "msgDescription",
               A.RECIPIENT_ID AS "RecipientId", A.BIZ_KEY AS "bizKey",
               A.SENDER_ID AS "senderId",
               A.BIZ_SOURCE_CATEGORY AS "bizSourceCategory",
               A.BIZ_MSG_CATEGORY AS "bizMsgCategory",
               A.SYSTEM_ID AS "systemId",
               A.WECHAT_JUMPLINK_URL AS "wechatJumplinkUrl"
        FROM   POM_PRE_GENERATED_MESSAGE A
        INNER  JOIN POM_DEPT_MONTHLY_PLAN_NODE B
        ON     A.BIZ_KEY = B.ID
        WHERE  MSG_GROUP_ID = MSGGROUPID AND
               B.ACTUAL_END_DATE IS NOT NULL;
    LOOP
        FETCH VC_REF_CURSOR
            INTO V_RC_PRE_MSG;
        EXIT WHEN VC_REF_CURSOR%NOTFOUND;
        DELETE POM_PRE_GENERATED_MESSAGE WHERE ID = V_RC_PRE_MSG.ID;
    END LOOP;

    OPEN MESSAGE FOR
        SELECT A.ID AS "id", MSG_GROUP_ID AS "msgGroupId",
               A.MSG_DESCRIPTION AS "msgDescription",
               A.RECIPIENT_ID AS "RecipientId", A.BIZ_KEY AS "bizKey",
               A.SENDER_ID AS "senderId",
               A.BIZ_SOURCE_CATEGORY AS "bizSourceCategory",
               A.BIZ_MSG_CATEGORY AS "bizMsgCategory",
               A.SYSTEM_ID AS "systemId",
               A.WECHAT_JUMPLINK_URL AS "wechatJumplinkUrl",
               A.COMPANY_ID AS "companyId", A.DEPT_ID AS "deptId",
               A.PROJ_ID AS "projId"
        FROM   POM_PRE_GENERATED_MESSAGE A
        WHERE  MSG_GROUP_ID = MSGGROUPID;
END P_POM_RULE_MSG_PUSH;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
        --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
		condition IN VARCHAR2, --�����������˾id
        currentuserid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
        currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
        currentdeptid        IN            VARCHAR2,--��ǰ�û�����
        currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
        bizcode       IN            VARCHAR2,---Ȩ��code
        searchcondition IN          VARCHAR2,--ģ����ѯ����
        item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
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
		IF  condition <> '111' THEN
            OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND node.COMPANY_ID = ''|| condition ||''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null AND node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND node.COMPANY_ID = '' || condition || ''
                UNION ALL
                SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
					AND APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
                     AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND plan.COMPANY_ID = '' || condition || ''

            );
		ELSE
			OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND node.COMPANY_ID = ''|| condition ||''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND node.COMPANY_ID = '' || condition || ''
                UNION ALL
                SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
					AND APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
                     AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND plan.COMPANY_ID = '' || condition || ''

            );
		END IF;

END P_POM_SMART_CURRENTCOMPANY_TBS;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
        --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
		condition IN VARCHAR2, --�������������id
        currentuserid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
        currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
        currentdeptid        IN            VARCHAR2,--��ǰ�û�����
        currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
        bizcode       IN            VARCHAR2,---Ȩ��code
        searchcondition IN          VARCHAR2,--ģ����ѯ����
        item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
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
		IF  condition <> '111' THEN
            OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE  ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND node.DUTY_DEPARTMENT_ID = ''|| condition ||''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE  node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
                UNION ALL
                SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE  APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
                     AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND plan.DEPT_ID = '' || condition || ''

            );
		ELSE
			OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND node.DUTY_DEPARTMENT_ID = ''|| condition ||''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE  node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
                UNION ALL
                SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
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
                pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
                     AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND plan.DEPT_ID = '' || condition || ''

            );
		END IF;


END P_POM_SMART_CURRENTDEPT_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
        --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
		condition IN VARCHAR2, --�����������Ŀid
        currentuserid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
        currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
        currentdeptid        IN            VARCHAR2,--��ǰ�û�����
        currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
        bizcode       IN            VARCHAR2,---Ȩ��code
        searchcondition IN          VARCHAR2,--ģ����ѯ����
        item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
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
		IF  condition <> '111' THEN
            OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
                    OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
            );
		ELSE
			OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
            FROM(
                SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
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
                POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON node.ID=person.NODE_ID
                    LEFT JOIN (select org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'' GROUP BY org_id) tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
					--AND node.COMPANY_ID = ''|| condition ||''
  );
		END IF;

END P_POM_SMART_CURRENTPROJ_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPSRSON_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" (
		condition IN VARCHAR2, --�����������ǰ�û�ID
        searchcondition IN          VARCHAR2,--ģ����ѯ����
        item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
--���ߣ�yedr
--���ڣ�2020/04/07

    v_spid              VARCHAR2(200);
	BEGIN
    OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT
            FROM(
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS ACOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS CCOUNT
                    FROM
                    POM_PROJ_PLAN_NODE node
                    LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
                    WHERE  (plan.PLAN_TYPE = '��Ŀ����ƻ�' OR  plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�')
                    AND plan.APPROVAL_STATUS = '�����'
                    AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
                    AND person.CHARGE_PERSON_ID = '' || condition || ''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS ACOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS CCOUNT
                    FROM POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
                    WHERE node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
                    AND person.CHARGE_PERSON_ID = '' || condition || ''
                UNION ALL
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS ECOUNT
                    FROM pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
                    WHERE APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
                    AND person.CHARGE_PERSON_ID = '' || condition || ''
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')

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
                                     TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') > 0 --����
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
                                                        '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || A.ID ||
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
--  DDL for Procedure P_POM_SMART_DELAY_NODE_PREDICT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_DELAY_NODE_PREDICT" (
    plantype       IN             VARCHAR2,
    datascope      IN             VARCHAR2,
    orgid          IN             VARCHAR2,
    title          OUT            VARCHAR2,
    titleicon      OUT            VARCHAR2,
    predictdelay   OUT            SYS_REFCURSOR
) AS --�ؼ��ڵ�ƻ����-Ԥ������ڵ�
		--���ߣ�����
		--���ڣ�2019/11/13
BEGIN

    title := 'Ԥ������5���ڵ��ڽڵ�';
    titleicon := '';

   open predictdelay FOR


      SELECT DISTINCT
      A.ORG_NAME AS "orgName",
      B2.PROJECTSTAGE_NAME AS "projName",
      B2.NODE_NAME ||case when  ESTIMATE_END_DATE is NOT null then '   (Ԥ��������ڣ�'||  TO_CHAR(ESTIMATE_END_DATE,'yyyy-mm-dd') ||')' else  null end AS "nodeName",
      NODE_ID as "nodeId",
      ORIGINAL_NODE_ID as "nodeOriginId",
      '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' || b2.UNIT_ID ||  '&ppid=' || B2.PPID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
      '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || B2.PLANID || '&feedbackNodeId=' || NODE_ID || '&feedbackNodeOriginalId=' || ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",

				CASE  WHEN TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ) > 0   THEN
						'<span class="right"> Ԥ������ <span style="display: inline-block;
																width: 40px;
																text-align: center;
																border-radius: 4px;
																margin: 0 4px;
																background-color: rgb(248, 94, 90);
																color: #fff;
																font-weight: 700;">'
																||TO_CHAR( TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ))
																||'</span> �� </span>'
								WHEN  TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE)=0 THEN
						'<span class="right"> ���쵽�� </span>'
								ELSE
													'<span class="right"> ��  <span style="display: inline-block;
																width: 30px;
																text-align: center;
																border-radius: 4px;
																margin: 0 4px;
																background-color:  #409eff;
																color: #fff;
																font-weight: 700;">'
																||TO_CHAR(TRUNC(PLAN_END_DATE, 'dd')-TRUNC(SYSDATE, 'dd'))
																||'</span> �쵽�� </span>' 	 END
														AS "delayDays"
											, case when ESTIMATE_END_DATE is not null  then  TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' )   else  TRUNC(PLAN_END_DATE, 'dd')-TRUNC(SYSDATE, 'dd')
										  end  as daycount
    FROM
      SYS_BUSINESS_UNIT a
      LEFT JOIN (
      SELECT LEVEL
        ,
        ORG_NAME,
        CONNECT_BY_ROOT ID AS ID,
        CONNECT_BY_ROOT PARENT_ID AS PARENT_ID,
        B.UNIT_ID,
        B.NODE_NAME,
        B.NODE_ID,
        B.ACTUAL_END_DATE,
        B.PLAN_END_DATE,
        B.PROJECTSTAGE_NAME,
        B.PPID,
        B.PID,
        'TYPE_ORG' AS CTYPE,
        B.ESTIMATE_END_DATE,
        PLANID,
        ORIGINAL_NODE_ID
      FROM
        SYS_BUSINESS_UNIT A
        LEFT JOIN (
        SELECT
          B1.UNIT_ID,
          A.ID AS PLANID,
          A1.ORIGINAL_NODE_ID,
         	 case when  STAGE_NAME like '%�޷���%' then  B1.ID else A.PROJ_ID end   AS PPID,--20200427��С�ϵ������޸�
          B1.ID AS PID,
           A.PROJ_NAME AS PROJECTSTAGE_NAME,
          A1.NODE_NAME,
          A1.ID AS NODE_ID,
          A1.ACTUAL_END_DATE,
          A1.PLAN_END_DATE,
          A1.ESTIMATE_END_DATE
        FROM
          POM_PROJ_PLAN A
          INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID = A1.PROJ_PLAN_ID
          INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID = C1.ID
          INNER JOIN SYS_PROJECT B1 ON C1.PROJECT_ID = B1.ID
        WHERE
          A.PLAN_TYPE = '�ؼ��ڵ�ƻ�'
          AND A.APPROVAL_STATUS = '�����'
					and  A1.IS_DISABLE=0
          AND (TRUNC(ESTIMATE_END_DATE , 'dd' ) - TRUNC(PLAN_END_DATE , 'dd' ) > 0  OR
							 TRUNC( PLAN_END_DATE, 'dd' ) - TRUNC( SYSDATE, 'dd' )  BETWEEN 0 AND 5)
          AND ACTUAL_END_DATE IS NULL

        ) B ON A.ID = B.UNIT_ID
      WHERE
        ORG_TYPE = 0 START WITH ID = '' || orgId || '' CONNECT BY PRIOR A.ID = A.PARENT_ID
      ) B2 ON A.ID = B2.ID
    WHERE
      NODE_NAME IS NOT NULL
      AND ACTUAL_END_DATE IS NULL
			--�ж�����

    AND (TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ) > 0  OR
							 TRUNC( PLAN_END_DATE, 'dd' ) - TRUNC( SYSDATE, 'dd' )  BETWEEN 0 AND 5 --5���ڵ���
				)
				--	δ����
		AND		TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') <= 0
			--����
    UNION ALL
    SELECT DISTINCT
      '' AS "orgName",
       A.PROJ_NAME AS "projName",
      A1.NODE_NAME  ||case when  ESTIMATE_END_DATE is NOT null then '   (Ԥ��������ڣ�'||  TO_CHAR(ESTIMATE_END_DATE,'yyyy-mm-dd') ||')' else  null end  AS "nodeName",
        A1.ID as "nodeId",
      A1.ORIGINAL_NODE_ID as "nodeOriginId",
      '/pom/plan-assess/node-monitoring/plan-nodes?companyid=' ||A.COMPANY_ID || '&ppid=' || B1.ID || '&planType=�ؼ��ڵ�ƻ�' AS "projOpenUrl",
      '/pom/mission-center-feedback/my-responsible-task/view-task-information?cancelType=0&id' || A.ID || '&feedbackNodeId=' || A1.ID || '&feedbackNodeOriginalId=' || A1.ORIGINAL_NODE_ID || '&nodeSourcePlanType=0' AS "nodeOpenUrl",
			CASE  WHEN  TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ) > 0   THEN
						'<span class="right"> Ԥ������ <span style="display: inline-block;
																width: 40px;
																text-align: center;
																border-radius: 4px;
																margin: 0 4px;
																background-color: rgb(248, 94, 90);
																color: #fff;
																font-weight: 700;">'
																||TO_CHAR( TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ))
																||'</span> �� </span>'
								WHEN  TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE)=0 THEN
						'<span class="right"> ���쵽�� </span>'
								ELSE
													'<span class="right"> ��  <span style="display: inline-block;
																width: 30px;
																text-align: center;
																border-radius: 4px;
																margin: 0 4px;
																background-color:  #409eff;
																color: #fff;
																font-weight: 700;">'
																||TO_CHAR(TRUNC(PLAN_END_DATE, 'dd')-TRUNC(SYSDATE, 'dd'))
																||'</span> �쵽�� </span>' 	 END
														AS "delayDays"
				, case when ESTIMATE_END_DATE is not null  then  TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' )
				else  TRUNC(PLAN_END_DATE, 'dd')-TRUNC(SYSDATE, 'dd')
										  end  as daycount
    FROM
      POM_PROJ_PLAN A
      INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID = A1.PROJ_PLAN_ID
      INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID = C1.ID
      INNER JOIN SYS_PROJECT B1 ON C1.PROJECT_ID = B1.ID
    WHERE
      A.PLAN_TYPE = '�ؼ��ڵ�ƻ�'
      AND A.APPROVAL_STATUS = '�����'
				and  A1.IS_DISABLE=0
      AND (TRUNC(ESTIMATE_END_DATE, 'dd' ) - TRUNC(  PLAN_END_DATE, 'dd' ) > 0  OR
							 TRUNC( PLAN_END_DATE, 'dd' ) - TRUNC( SYSDATE, 'dd' )  BETWEEN 0 AND 5)
			AND	 TRUNC(SYSDATE, 'dd') - TRUNC(PLAN_END_DATE, 'dd') <= 0
      AND ACTUAL_END_DATE IS NULL

      AND C1.PROJECT_ID = '' || orgId || ''
    ORDER BY
      daycount DESC;

END p_pom_smart_delay_node_predict;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_EXAM_RUEL_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_EXAM_RUEL_DEL" 
(
		RULEID  IN VARCHAR2
	 , --�������������id
		ERRMSG  OUT VARCHAR2
	 , --��ʾ��Ϣ
		ERRCODE OUT INT --0�ɹ���1ʧ��
) IS
		--���˹���ɾ��
		--���ߣ�Ҷ����
		--���ڣ�2019/11/22
		COUNTDTL INT;
BEGIN
		BEGIN
				COUNTDTL := 0;
				IF LENGTH(RULEID) < 32 THEN
						RAISE_APPLICATION_ERROR(-20000, '��ѡ��Ҫɾ���Ĺ���');
				END IF;
				--ѭ������id
		
				FOR ITEM IN (SELECT REGEXP_SUBSTR('' || RULEID || '', '[^,]+', 1,
																					 ROWNUM) AS ID
										 FROM   DUAL
										 CONNECT BY ROWNUM <=
																LENGTH('' || RULEID || '') -
																LENGTH(REGEXP_REPLACE('' || RULEID || '', ',',
																											'')) + 1)
				LOOP
						---ɾ������
						DELETE POM_RULE_EXAMINATION WHERE ID = '' || ITEM.ID || '';
				
						COUNTDTL := COUNTDTL + 1;
				END LOOP;
		
				ERRCODE := 0;
				ERRMSG  := 'ɾ���ɹ���' || COUNTDTL || '������';
		EXCEPTION
				WHEN OTHERS THEN
						ERRCODE := 1;
						ERRMSG  := SQLERRM;
		END;
END P_POM_SMART_EXAM_RUEL_DEL;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_EXAMRULE_SET_STATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_EXAMRULE_SET_STATE" ( ruleid IN VARCHAR2, --�������������id
		statetype IN INT, --0��Ч��1ʧЧ
		errmsg OUT VARCHAR2, --��ʾ��Ϣ
		errcode OUT INT --0�ɹ���1ʧ��
	) IS --���˹�����ЧʧЧ����
--���ߣ�Ҷ����
--���ڣ�2019/11/21
	typemsg VARCHAR2 ( 50 );
ruleids VARCHAR2 ( 4000 );
countdtl INT;
testmsg NVARCHAR2 ( 200 );
statuscount NUMBER;
BEGIN
	BEGIN
			testmsg := 'ruleid:' || ruleid || '.statetype:' || statetype;
		countdtl := 0;
		IF
			statetype = 0 THEN
				typemsg := 'ʧЧ';
			ELSE typemsg := '��Ч';

		END IF;
		IF
			length( ruleid ) < 36 THEN
				raise_application_error ( - 20000, '��ѡ��Ҫ' || typemsg || '�Ĺ���' || testmsg );

		END IF;
--ѭ������id
		FOR item IN (
			SELECT
				regexp_substr( '' || ruleid || '', '[^,]+', 1, ROWNUM ) AS id 
			FROM
				dual CONNECT BY ROWNUM <= length( '' || ruleid || '' ) - length( regexp_replace( '' || ruleid || '', ',', '' ) ) + 1 
			)
			LOOP---ƴ���ַ���
			ruleids := ruleids || item.id;
		SELECT COUNT(IS_ACTIVE) INTO statuscount  FROM POM_RULE_EXAMINATION WHERE ID='' || item.id || '' AND IS_ACTIVE=statetype ;

			IF(statuscount>0) THEN
				errcode := 1;
				errmsg := '����'''||typemsg||'''�Ĺ�����ѡ����ͬ״̬�����ݽ��в���';
				return;
			ELSE 
					UPDATE POM_RULE_EXAMINATION 
					SET IS_ACTIVE = statetype 
					WHERE
						id = '' || item.id || '';
					countdtl := countdtl + 1;
			END IF;

	END LOOP;

			errcode := 0;
			errmsg := typemsg || '���óɹ���' || countdtl || '������';

EXCEPTION 
	WHEN OTHERS THEN
	errcode := 1;
errmsg := sqlerrm;

END;

END p_pom_smart_examrule_set_state;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_PROJ" 
(
    PROJID      IN VARCHAR2
   , --�����������Ŀ
    PAGEINDEX   IN INT
   ,PAGESIZES   IN INT
   ,CURRENTTYPE IN VARCHAR2
   , --��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    userid        IN            VARCHAR2,--�û�id���ڹ��˹�ע������
    currentcompanyid     IN     VARCHAR2,--��ǰ�û��Ĺ�˾
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    bizcode       IN            VARCHAR2,---Ȩ��code
    ITEMS       OUT SYS_REFCURSOR
   ,TOTAL       OUT INT
) IS
    --�����Ÿ��������
    --���ߣ�����
    --���ڣ�2019/11/15

    V_SQL_START       CLOB;
    V_SQL_END         CLOB;
    V_SQL_CONTENT     CLOB;
    V_SQL             CLOB;
    V_SQL_EXEC        CLOB;
    V_SQL_EXEC_PAGING CLOB;
    V_WHERE           VARCHAR2(500);
    TESTMSG           NVARCHAR2(200);
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
    v_where_like       CLOB;
    v_test_land        CLOB;
BEGIN
    ----------------------------------------------------ͳһ����
    TESTMSG := 'projid:' || PROJID || '��pageindex:' || PAGEINDEX || '��pagesizes:' || PAGESIZES || '��currenttype:' || CURRENTTYPE;

    BEGIN
        TOTAL         := 1000;
        V_SQL_START   := ' case ';
        V_SQL_CONTENT := '';
        V_SQL_END     := '  else '''' end  ';


        --��������Ȩ����֤�洢����
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
        --1.ƴ�Ӳ�ѯ���
        FOR ITEM IN (SELECT S.EXPRESSION, VV.NODE_LEVEL, VV.PLAN_TYPE
                     FROM   POM_RULE_SET S
                     LEFT   JOIN (SELECT MAX(S.CREATED_TIME) AS T, NODE_LEVEL, PLAN_TYPE
                                 FROM   POM_RULE_SET S
                                 LEFT   JOIN POM_RULE_SET_PLAN_TYPE PT
                                 ON     S.ID = PT.RULE_ID
                                 WHERE  RULE_TYPE = '���ƹ���'
                                       -- AND plan_type != '�ؼ��ڵ�ƻ�'
                                        AND
                                        S.IS_DISABLE = 0
                                 GROUP  BY NODE_LEVEL, PLAN_TYPE) VV
                     ON     S.CREATED_TIME = VV.T AND
                            S.NODE_LEVEL = VV.NODE_LEVEL
                     WHERE  VV.T IS NOT NULL)
        LOOP
            ---ƴ���ַ���
            V_SQL_CONTENT := V_SQL_CONTENT || '  when plan_type=''' || CASE ITEM.PLAN_TYPE
                                 WHEN '��Ŀȫ���ƻ�' THEN
                                  '��Ŀ����ƻ�'
                                 ELSE
                                  ITEM.PLAN_TYPE
                             END || ''' and node_level=''' || ITEM.NODE_LEVEL || ''' then (' || ITEM.EXPRESSION || ')';
        END LOOP;

        --dbms_output.put_line('123333');
        --dbms_output.put_line(v_sql_content);
        --�������ݴ���0��ƴ�������

        IF LENGTH(V_SQL_CONTENT) > 0
        THEN
            V_SQL := V_SQL_START || V_SQL_CONTENT || V_SQL_END;
        ELSE
            --�޹���������ʾ��
            V_SQL := '''''';
        END IF;

        -------------------------------------------------------------------------------------------����


        IF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is null and (PLAN_END_DATE>=trunc(sysdate, ''month'') and PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF CURRENTTYPE = '����δ�������'
        THEN
            V_WHERE := ' and TRUNC(SYSDATE) > PLAN_END_DATE and ACTUAL_END_DATE is null';
        ELSIF CURRENTTYPE = '����δ�������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is null ';
        ELSIF CURRENTTYPE = '�������������'
        THEN
            V_WHERE := ' and ACTUAL_END_DATE is not null ';
        ELSIF CURRENTTYPE = '��������'
        THEN
            V_WHERE := ' ';
        ELSE
            V_WHERE := ' and 1=2';
        END IF;

        --������������λ��ʱ
        IF searchcondition is not null THEN
          v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(charge_person,'''||searchcondition||''')>0 )';
        ELSE
          v_where_like := '';
        END IF;

        --3.ƴ���������
        IF PROJID<>'111' THEN
        V_SQL_EXEC := ' select  rownum as rowno,ID,
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
                    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,' || V_SQL || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
                ,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
                ,case when n.ACTUAL_END_DATE IS NOT NULL THEN NULL
                ELSE ''�߰�'' END as HASTEN
                ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0=724=300=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300==''||ORIGINAL_NODE_ID end as w_Url

                                      from(SELECT
                    n.ID,
                     p.ORIGINAL_PLAN_ID,
                    ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''�ؼ��ڵ�ƻ�''   THEN
                            0
                        WHEN ''��Ŀ����ƻ�''   THEN
                            1
                    END AS PLAN_TYPE_INT,

                    NODE_NAME,
                    p.PLAN_NAME,--�ƻ�����
                    PLAN_START_DATE,
                    PLAN_END_DATE,

                    ACTUAL_END_DATE,
                    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
                    p.PROJ_NAME,          --������Ŀ
                    p.PLAN_TYPE,        --�ƻ�������ʾ��
                    DUTY_DEPARTMENT,          --������
                    cp.CHARGE_PERSON,
                    NODE_LEVEL,           --����ȼ�
                    STANDARD_SCORE          --��׼��ֵ
                FROM
                    POM_PROJ_PLAN_NODE n LEFT
                    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                    WHERE tal.orgId is not null
                    and p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'' AND NVL(n.IS_DISABLE,0) <> 1 and APPROVAL_STATUS=''�����''
                    AND (p.PROJ_ID=''' || PROJID || ''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''' || PROJID || '''))  ' || V_WHERE || '
                )n
                    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE)  a ';

        ELSE
            V_SQL_EXEC := 'select  rownum as rowno,ID,
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
                    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,' || V_SQL || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
                ,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
                ,case when n.ACTUAL_END_DATE IS NOT NULL THEN NULL
                ELSE ''�߰�'' END as HASTEN
                ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0=724=300=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300==''||ORIGINAL_NODE_ID end as w_Url

                                      from(SELECT
                    n.ID,
                     p.ORIGINAL_PLAN_ID,
                    ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''�ؼ��ڵ�ƻ�''   THEN
                            0
                        WHEN ''��Ŀ����ƻ�''   THEN
                            1
                    END AS PLAN_TYPE_INT,

                    NODE_NAME,
                    p.PLAN_NAME,--�ƻ�����
                    PLAN_START_DATE,
                    PLAN_END_DATE,

                    ACTUAL_END_DATE,
                    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
                    p.PROJ_NAME,          --������Ŀ
                    p.PLAN_TYPE,        --�ƻ�������ʾ��
                    DUTY_DEPARTMENT,          --������
                    cp.CHARGE_PERSON,
                    NODE_LEVEL,           --����ȼ�
                    STANDARD_SCORE          --��׼��ֵ
                FROM
                    POM_PROJ_PLAN_NODE n LEFT
                    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                    WHERE tal.orgId is not null
                    and p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'' AND NVL(n.IS_DISABLE,0) <> 1 and APPROVAL_STATUS=''�����''
                     ' || V_WHERE || '
                )n
                    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
        END IF;
        -------------------------------------------------------------------------------------------����

        V_SQL_EXEC_PAGING := '
select a.* from ( ' || V_SQL_EXEC || ' where rownum <= ' || PAGEINDEX * PAGESIZES || ' ) a where a.rowno >= ' || PAGESIZES * (PAGEINDEX - 1) || '';

        DBMS_OUTPUT.PUT_LINE(V_SQL_EXEC);
        ----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from(' || V_SQL_EXEC || ') a '
            INTO TOTAL;

        -- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN ITEMS FOR V_SQL_EXEC_PAGING;
        --SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
            TESTMSG := SQLERRM || TESTMSG;
            OPEN ITEMS FOR
                SELECT 'ʧ�ܿ�' || TESTMSG PLAN_NAME FROM DUAL;

            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

END P_POM_SMART_KEY_NODE_PLAN_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_TBS" 
(
    ORGTYPE   IN VARCHAR2
   , --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,����
    CONDITION IN VARCHAR2
   , --�����������˾id | ����id | ��Ŀid | ��ǰ�û�ID
    userid        IN            VARCHAR2,--�û�id���ڹ��˹�ע������
    currentcompanyid     IN     VARCHAR2,--��ǰ�û��Ĺ�˾
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    bizcode       IN            VARCHAR2,---Ȩ��code
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    ITEM      OUT SYS_REFCURSOR
) IS
    --��������tabs��������ͳ������Դ
    --���ߣ�yedr
    --���ڣ�2019/12/25
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
BEGIN

    --��������Ȩ����֤�洢����
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    IF CONDITION<>'222' THEN
        OPEN ITEM FOR
            SELECT NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                               AND ( B.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND B.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) ) THEN
                                1
                               ELSE
                                0
                           END), 0) AS ACOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                                    AND TRUNC(SYSDATE) > B.PLAN_END_DATE THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS BCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS CCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS DCOUNT,
                   COUNT(*) AS ECOUNT
            FROM  POM_PROJ_PLAN_NODE B
            LEFT JOIN  POM_PROJ_PLAN A ON  A.ID = B.PROJ_PLAN_ID
            LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON B.ID=person.NODE_ID
            LEFT JOIN  SYS_PROJECT_STAGE sps on A.proj_id=sps.id
            LEFT JOIN  (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
            on (case when sps.id is not null then sps.PROJECT_ID else A.proj_id end)=tal.orgId
            WHERE
                   tal.orgId is not null and
                   A.APPROVAL_STATUS = '�����' AND
                   A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
                   NVL(B.IS_DISABLE, 0) <> 1 AND
                   (A.PROJ_ID = '' || CONDITION || '' OR A.PROJ_ID IN (SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID = '' || CONDITION || ''))
                   AND (b.node_name like '%'||searchcondition||'%' OR a.plan_name like '%'||searchcondition||'%'
                   OR a.PROJ_NAME like '%'||searchcondition||'%' OR b.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%');
        ELSE
             OPEN ITEM FOR
             SELECT NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                               AND ( B.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND B.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                               THEN
                                1
                               ELSE
                                0
                           END), 0) AS ACOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                                    AND TRUNC(SYSDATE) > B.PLAN_END_DATE THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS BCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS CCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS DCOUNT,
                   COUNT(*) AS ECOUNT
            FROM  POM_PROJ_PLAN_NODE B
            LEFT JOIN  POM_PROJ_PLAN A ON  A.ID = B.PROJ_PLAN_ID
            LEFT JOIN (SELECT wm_concat(CHARGE_PERSON) AS CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID)  person ON B.ID=person.NODE_ID
            LEFT JOIN  SYS_PROJECT_STAGE sps on A.proj_id=sps.id
            LEFT JOIN  (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
            on (case when sps.id is not null then sps.PROJECT_ID else A.proj_id end)=tal.orgId
            WHERE
                   tal.orgId is not null and
                   A.APPROVAL_STATUS = '�����' AND
                   A.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND
                   NVL(B.IS_DISABLE, 0) <> 1
                  AND (b.node_name like '%'||searchcondition||'%' OR a.plan_name like '%'||searchcondition||'%'
                   OR a.PROJ_NAME like '%'||searchcondition||'%' OR b.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%');
                  --AND (A.PROJ_ID = '' || CONDITION || '' OR A.PROJ_ID IN (SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID = '' || CONDITION || ''))
        END IF;
END P_POM_SMART_KEY_NODE_PLAN_TBS;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEYNODEPLAN_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEYNODEPLAN_TBS" ( orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
    condition IN VARCHAR2, --�����������˾id | ����id | ��Ŀid | ��ǰ�û�ID
  item OUT SYS_REFCURSOR ) IS
  --��������tabs��������ͳ������Դ
  --���ߣ�yedr
  --���ڣ�2019/12/25
BEGIN

OPEN item FOR

            POM_PROJ_PLAN_NODE node
            LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
          WHERE
            plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�'
            AND plan.APPROVAL_STATUS = '�����'
            AND plan.PROJ_ID ='e381dc98-c7db-4a4a-872c-02faa4c0759e'
        ) AS ACOUNT,
--����δ�������
        1 AS BCOUNT,
--����δ�������

          2
         AS CCOUNT,
--�������������

          3
         AS DCOUNT,
--��������

          4
         AS ECOUNT,
--��������

          5
        AS FCOUNT,
--����������

          6
        AS GCOUNT,
--��������

          7
         AS HCOUNT
      FROM
        dual;

END P_POM_SMART_KEYNODEPLAN_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid     IN            VARCHAR2,--�����������˾id
    currentcompanyid     IN     VARCHAR2,--��ǰ�û��Ĺ�˾
	userid        IN            VARCHAR2,--�û�id���ڹ��˹�ע������
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    bizcode       IN            VARCHAR2,---Ȩ��code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--  spiditems         OUT           SYS_REFCURSOR
) IS
--�����Ÿ��������
--���ߣ�����
--���ڣ�2019/11/15

    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content       CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    v_spid              VARCHAR2(200);--����Ȩ����֤spid
    testmsg             CLOB;
    wwhere          CLOB;
    v_where_like       CLOB;

BEGIN
----------------------------------------------------ͳһ����
    wwhere := companyid;
    --wwhere := ''' or ''1''=''1';
    testmsg := 'companyid:'
               || companyid
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
 P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );

-- open  spiditems   for select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = v_spid;
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
                        --AND plan_type = '�ؼ��ڵ�ƻ�'
                        AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                        AND s.node_level = vv.node_level
            WHERE
                vv.t IS NOT NULL
        ) LOOP
    ---ƴ���ַ���
         v_sql_content := v_sql_content
                                || '  when plan_type='''
                                ||
            CASE item.plan_type
                WHEN '��Ŀȫ���ƻ�' THEN
                    '��Ŀ����ƻ�'
                ELSE item.plan_type
            END
                                || ''' and node_level='''
                                || item.node_level
                                || ''' then ('
                                || item.expression
                                || ')';
        END LOOP;

    --dbms_output.put_line('123333');
    --dbms_output.put_line(v_sql_content);
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

            IF currenttype = '��������' THEN
            v_where := ' and ACTUAL_END_DATE is null and (PLAN_END_DATE>=trunc(sysdate, ''month'') and PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>PLAN_END_DATE  and ACTUAL_END_DATE is null';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            v_where := ' ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=last_day(trunc(sysdate))+1 and PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''Q'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;

        --������������λ��ʱ
        IF searchcondition is not null THEN
          v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(charge_person,'''||searchcondition||''')>0 )';
        ELSE
          v_where_like := '';
        END IF;

--3.ƴ���������
IF companyid <> '333' THEN
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
		CHARGE_PERSON,
    NODE_LEVEL,
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN
,case when w.IS_UN_WATCH=0 then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0&windowWidth=400&windowHeight=70&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID end as W_Url

                      from(SELECT
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

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������
		cp.CHARGE_PERSON,
    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
      FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
        left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
        on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
        WHERE tal.orgid is not null AND (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''
		AND	n.IS_DISABLE=0
    and n.COMPANY_ID='''
                      || wwhere
                      || ''' '
                      || v_where
                      || '
UNION ALL
SELECT
    n.ID   AS id,
     p.id as ORIGINAL_PLAN_ID,
    n.ID   AS ORIGINAL_NODE_ID,
    PLAN_ID,
    2 AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    PREDICT_END_DATE,
    ''������Ŀ'' AS E,
    ''ר��ƻ�'' AS F,
    DUTY_DEPARTMENT,
		cp.CHARGE_PERSON,
    ''ר��ƻ���'' AS M,
    0 AS N
FROM
    POM_SPECIAL_PLAN_NODE n
		LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
		left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
        FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
        on n.DUTY_DEPARTMENT_ID in tal.orgid or n.COMPANY_ID in tal.orgid or p.COMPANY_ID in tal.orgid
        WHERE tal.orgid is not null AND APPROVAL_STATUS=''�����''  AND n.IS_DELETE=0 and n.COMPANY_ID='''
                      || wwhere
                      || ''' '
                      || v_where
                      || '
UNION ALL
    SELECT    n.id,
    p.ORIGINAL_PLAN_ID,
    n.original_node_id,
    dept_monthly_plan_id,
    3 as  PLAN_TYPE_INT,

    node_name,
    p.PLAN_NAME,
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    ''��'' as PROJ_NAME,          --������Ŀ
    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
    p.DEPT_NAME,          --������
		cp.CHARGE_PERSON,
    node_Type,           --����ȼ�
    stand_SCORE          --��׼��ֵ
FROM
    pom_dept_monthly_plan_node n
    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
    on p.DEPT_ID in tal.orgid or p.COMPANY_ID in tal.orgid
    WHERE tal.orgid is not null AND (IS_DEL=0 OR IS_DEL=null) and APPROVE_STATUS=''�����'' and p.COMPANY_ID='''
                      || companyid
                      || ''' '
                      || v_where
                      || ')n
    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
ELSE
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
		CHARGE_PERSON,
    NODE_LEVEL,
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN
,case when w.IS_UN_WATCH=0 then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0&windowWidth=400&windowHeight=70&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID end as W_Url

                      from(SELECT
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

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������
		cp.CHARGE_PERSON,
    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
        FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
        left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
        on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
        WHERE tal.orgid is not null AND (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''
		AND	n.IS_DISABLE=0
         '|| v_where || '
UNION ALL
SELECT
    n.ID   AS id,
     p.id as ORIGINAL_PLAN_ID,
    n.ID   AS ORIGINAL_NODE_ID,
    PLAN_ID,
    2 AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    PREDICT_END_DATE,
    ''������Ŀ'' AS E,
    ''ר��ƻ�'' AS F,
    DUTY_DEPARTMENT,
		cp.CHARGE_PERSON,
    ''ר��ƻ���'' AS M,
    0 AS N
FROM
    POM_SPECIAL_PLAN_NODE n
		LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
		left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
        FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
        on n.DUTY_DEPARTMENT_ID in tal.orgid or n.COMPANY_ID in tal.orgid or  p.COMPANY_ID in tal.orgid
        WHERE tal.orgid is not null AND APPROVAL_STATUS=''�����''  AND n.IS_DELETE=0 '|| v_where || '
UNION ALL
    SELECT    n.id,
    p.ORIGINAL_PLAN_ID,
    n.original_node_id,
    dept_monthly_plan_id,
    3 as  PLAN_TYPE_INT,

    node_name,
    p.PLAN_NAME,
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    ''��'' as PROJ_NAME,          --������Ŀ
    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
    p.DEPT_NAME,          --������
		cp.CHARGE_PERSON,
    node_Type,           --����ȼ�
    stand_SCORE          --��׼��ֵ
FROM
    pom_dept_monthly_plan_node n
    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
    on p.DEPT_ID in tal.orgid or p.COMPANY_ID in tal.orgid
    WHERE tal.orgid is not null AND (IS_DEL=0 OR IS_DEL=null) and APPROVE_STATUS=''�����'' ' || v_where|| ')n
    left join ��SELECT * FROM SYS_BIZ_WATCH w WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a  ';
END IF;
-------------------------------------------------------------------------------------------����

        v_sql_exec_paging := '
select a.* from ( '
                             || v_sql_exec
                             || ' where rownum <= '
                             || pageindex * pagesizes
                             || ' ) a where a.rowno >= '
                             || pagesizes * ( pageindex - 1 )
                             || '';

       -- dbms_output.put_line(v_sql_exec_paging);

				dbms_output.put_line(v_sql_exec_paging);
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                          || v_sql_exec
                          || ') a '
        INTO total;

-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec_paging;
--SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
        testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT
                               'ʧ�ܿ�' || testmsg plan_name
                           FROM
                               dual;

           -- dbms_output.put_line(sqlerrm);
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
--���ڣ�2019/11/15

    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_spid              CLOB;
    deptidwhere         CLOB;
    v_where              CLOB;
    testmsg             CLOB;
--    test_sql        CLOB;
BEGIN
----------------------------------------------------ͳһ����
--    IF (deptid <> '444') THEN
        deptidwhere := deptid;
--    ELSE
--        deptidwhere := '';
--    END IF;
    --deptidwhere := ''' or ''1''=''1';
    testmsg := 'deptid:'
               || deptid
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
 P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
--        test_sql:=' select n.*,orgid  FROM POM_SPECIAL_PLAN_NODE n
--        LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
--        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=n.DUTY_DEPARTMENT_ID or tal.orgid=n.COMPANY_ID
--
--        WHERE  APPROVAL_STATUS=''�����'' and n.IS_DELETE=0';
--
--
--        open auth for test_sql;
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
                       -- AND plan_type != '�ؼ��ڵ�ƻ�'
                        AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                        AND s.node_level = vv.node_level
            WHERE
                vv.t IS NOT NULL
        ) LOOP
    ---ƴ���ַ���
         v_sql_content := v_sql_content
                                || '  when plan_type='''
                                ||
            CASE item.plan_type
                WHEN '��Ŀȫ���ƻ�' THEN
                    '��Ŀ����ƻ�'
                ELSE item.plan_type
            END
                                || ''' and node_level='''
                                || item.node_level
                                || ''' then ('
                                || item.expression
                                || ')';
        END LOOP;

    --dbms_output.put_line('123333');
    --dbms_output.put_line(v_sql_content);
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

       IF currenttype = '��������' THEN
            v_where := ' and ACTUAL_END_DATE is null  and (PLAN_END_DATE>=trunc(sysdate, ''month'') and PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>PLAN_END_DATE and ACTUAL_END_DATE is null';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            v_where := ' ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=last_day(trunc(sysdate))+1 and PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''Q'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;
--3.ƴ���������
IF (deptid <> '444') THEN
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
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,charge_person,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,charge_person,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN

                      from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''�ؼ��ڵ�ƻ�''   THEN
            0
        WHEN ''��Ŀ����ƻ�''   THEN
            1
    END AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������

    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n LEFT
    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
   left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
    WHERE  (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''  AND	n.IS_DISABLE=0  and DUTY_DEPARTMENT_ID='''
                      || deptidwhere
                      || ''' '
                      || v_where
                      || '
UNION ALL
SELECT
    n.ID   AS id,
     p.id as ORIGINAL_PLAN_ID,
    n.ID   AS ORIGINAL_NODE_ID,
    PLAN_ID,
    2 AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    PREDICT_END_DATE,
    ''������Ŀ'' AS E,
    ''ר��ƻ�'' AS F,
    DUTY_DEPARTMENT,

    ''ר��ƻ���'' AS M,
    0 AS N
FROM
    POM_SPECIAL_PLAN_NODE n
    LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
     LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=n.DUTY_DEPARTMENT_ID or tal.orgid=n.COMPANY_ID
     WHERE  p.APPROVAL_STATUS=''�����'' and n.IS_DELETE=0  and n.DUTY_DEPARTMENT_ID='''
                      || deptidwhere
                      || ''' '
                      || v_where
                      || '
UNION ALL
    SELECT    n.id,
    p.ORIGINAL_PLAN_ID,
    original_node_id,
    dept_monthly_plan_id,
    3 as  PLAN_TYPE_INT,

    node_name,
    p.PLAN_NAME,
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    ''��'' as PROJ_NAME,          --������Ŀ
    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
    p.DEPT_NAME,          --������

    node_Type,           --����ȼ�
    stand_SCORE          --��׼��ֵ
FROM
    pom_dept_monthly_plan_node n
    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
     LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=p.DEPT_ID or tal.orgid=p.COMPANY_ID
     WHERE APPROVE_STATUS=''�����''   AND n.IS_DEL=0 and DUTY_DEPT_ID='''
                      || deptidwhere
                      || ''' '
                      || v_where
                      || ')n
    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
    left join (SELECT node_id,
     LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
      FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID WHERE (n.NODE_NAME LIKE ''%'||searchcondition||'%'' OR  n.PLAN_NAME LIKE ''%'||searchcondition||'%''
    OR n.PROJ_NAME LIKE ''%'||searchcondition||'%'' OR n. DUTY_DEPARTMENT LIKE ''%'||searchcondition||'%'' OR cp.charge_person like ''%'||searchcondition||'%'' )  ORDER BY n.PLAN_END_DATE) a ';
else
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
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,charge_person,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,charge_person,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN

                      from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''�ؼ��ڵ�ƻ�''   THEN
            0
        WHEN ''��Ŀ����ƻ�''   THEN
            1
    END AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������

    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n LEFT
    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
    left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
    on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
    WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''  AND	n.IS_DISABLE=0 '
                      || v_where
                      || '
UNION ALL
SELECT
    n.ID   AS id,
     p.id as ORIGINAL_PLAN_ID,
    n.ID   AS ORIGINAL_NODE_ID,
    PLAN_ID,
    2 AS PLAN_TYPE_INT,

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    PREDICT_END_DATE,
    ''������Ŀ'' AS E,
    ''ר��ƻ�'' AS F,
    DUTY_DEPARTMENT,

    ''ר��ƻ���'' AS M,
    0 AS N
FROM
    POM_SPECIAL_PLAN_NODE n
    LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
     LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=n.DUTY_DEPARTMENT_ID or tal.orgid=n.COMPANY_ID
     WHERE  APPROVAL_STATUS=''�����'' and n.IS_DELETE=0  '
                      || v_where
                      || '
UNION ALL
    SELECT    n.id,
    p.ORIGINAL_PLAN_ID,
    original_node_id,
    dept_monthly_plan_id,
    3 as  PLAN_TYPE_INT,

    node_name,
    p.PLAN_NAME,
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    ''��'' as PROJ_NAME,          --������Ŀ
    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
    p.DEPT_NAME,          --������

    node_Type,           --����ȼ�
    stand_SCORE          --��׼��ֵ
FROM
    pom_dept_monthly_plan_node n
    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal on tal.orgid=p.DEPT_ID or tal.orgid=p.COMPANY_ID
    WHERE APPROVE_STATUS=''�����''   AND n.IS_DEL=0  '
                      || v_where
                      || ')n
    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
    left join (SELECT node_id,
    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID WHERE (n.NODE_NAME LIKE ''%'||searchcondition||'%'' OR  n.PLAN_NAME LIKE ''%'||searchcondition||'%''
    OR n.PROJ_NAME LIKE ''%'||searchcondition||'%'' OR n.DUTY_DEPARTMENT LIKE ''%'||searchcondition||'%'' OR cp.charge_person like ''%'||searchcondition||'%'' )  ORDER BY n.PLAN_END_DATE) a ';
end if;
-------------------------------------------------------------------------------------------����

        v_sql_exec_paging := '
select a.* from ( '
                             || v_sql_exec
                             || ' where rownum <= '
                             || pageindex * pagesizes
                             || ' ) a where a.rowno >= '
                             || pagesizes * ( pageindex - 1 )
                             || '';

        dbms_output.put_line(v_sql_exec_paging);
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                          || v_sql_exec
                          || ') a '
        INTO total;

-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec_paging;
--SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
            testmsg := sqlerrm || testmsg;
            OPEN items FOR SELECT
                               'ʧ�ܿ�' || testmsg plan_name
                           FROM
                               dual;

            dbms_output.put_line(sqlerrm);
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
    ---ƴ���ַ���
         v_sql_content := v_sql_content
                                || '  when plan_type='''
                                ||
            CASE item.plan_type
                WHEN '��Ŀȫ���ƻ�' THEN
                    '��Ŀ����ƻ�'
                ELSE item.plan_type
            END
                                || ''' and node_level='''
                                || item.node_level
                                || ''' then ('
                                || item.expression
                                || ')';
        END LOOP;

    --dbms_output.put_line('123333');
    --dbms_output.put_line(v_sql_content);
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
            v_where := ' and ACTUAL_END_DATE is null';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>PLAN_END_DATE  and ACTUAL_END_DATE is null';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and ACTUAL_END_DATE is not null ';
        ELSE
            v_where := '';
        END IF;

        --������������Ϊ��ʱ
        IF searchcondition is not null THEN
          v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(n.charge_person,'''||searchcondition||''')>0 )';
        ELSE
          v_where_like := '';
        END IF;

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

    n.NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������
		person.CHARGE_PERSON,
    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
		WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' OR p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') AND n.IS_DISABLE=0  and APPROVAL_STATUS=''�����''
		AND CHARGE_PERSON_ID='''||userid||'''  '
                      || v_where
                      || '
UNION ALL
SELECT
    n.ID   AS id,
     p.id as ORIGINAL_PLAN_ID,
    n.ID   AS ORIGINAL_NODE_ID,
    PLAN_ID,
    2 AS PLAN_TYPE_INT,
    n.NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    PREDICT_END_DATE,
    ''������Ŀ'' AS E,
    ''ר��ƻ�'' AS F,
    DUTY_DEPARTMENT,
		person.CHARGE_PERSON,
    ''ר��ƻ���'' AS M,
    0 AS N
FROM
    POM_SPECIAL_PLAN_NODE n
		LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
		where n.IS_DELETE=0 AND APPROVAL_STATUS=''�����''
		AND CHARGE_PERSON_ID='''||userid||'''  '
                      || v_where
                      || '
UNION ALL
    SELECT    n.id,
    p.ORIGINAL_PLAN_ID,
    n.original_node_id,
    dept_monthly_plan_id,
    3 as  PLAN_TYPE_INT,

    n.node_name,
    p.PLAN_NAME,
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    ''��'' as PROJ_NAME,          --������Ŀ
    ''�����¶ȼƻ�'' as  PLAN_TYPE,        --�ƻ�������ʾ��
    p.DEPT_NAME,          --������
		person.CHARGE_PERSON,
    node_Type,           --����ȼ�
    stand_SCORE          --��׼��ֵ
FROM
    pom_dept_monthly_plan_node n
    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
    where n.IS_DEL=0 and APPROVE_STATUS=''�����''
		AND CHARGE_PERSON_ID='''||userid||'''  '
                      || v_where
                      || ')n '||v_where_like||'
   ORDER BY n.PLAN_END_DATE  ) a  ';-- left join POM_NODE_CHARGE_PERSON cp on n.id=cp.NODE_ID where CHARGE_PERSON_ID='''||userid||'''
-------------------------------------------------------------------------------------------����

       -- dbms_output.put_line(v_sql_exec);
        v_sql_exec_paging := '
select a.* from ( '
                             || v_sql_exec
                             || ' where rownum <= '
                             || pageindex * pagesizes
                             || ' ) a where a.rowno >= '
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
            OPEN items FOR SELECT
                               'ʧ�ܿ�' || testmsg plan_name
                           FROM
                               dual;

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
    testmsg              CLOB;
    v_where_like       CLOB;
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
 P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
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
                       -- AND plan_type != '�ؼ��ڵ�ƻ�'
                        AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                        AND s.node_level = vv.node_level
            WHERE
                vv.t IS NOT NULL
        ) LOOP
    ---ƴ���ַ���
         v_sql_content := v_sql_content
                                || '  when plan_type='''
                                ||
            CASE item.plan_type
                WHEN '��Ŀȫ���ƻ�' THEN
                    '��Ŀ����ƻ�'
                ELSE item.plan_type
            END
                                || ''' and node_level='''
                                || item.node_level
                                || ''' then ('
                                || item.expression
                                || ')';
        END LOOP;

    --dbms_output.put_line('123333');
    --dbms_output.put_line(v_sql_content);
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


       IF currenttype = '��������' THEN
            v_where := ' and ACTUAL_END_DATE is null and (PLAN_END_DATE>=trunc(sysdate, ''month'') and PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and sysdate>PLAN_END_DATE and ACTUAL_END_DATE is null';
        ELSIF currenttype = '����δ�������' THEN
            v_where := ' and ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            v_where := ' and ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            v_where := ' ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=last_day(trunc(sysdate))+1 and PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''Q'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            v_where := ' and (PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
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

--3.ƴ���������
if projid <> '111' then
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
		CHARGE_PERSON,
    NODE_LEVEL,
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,charge_person,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN
,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=&bizId=''||ORIGINAL_NODE_ID end as w_Url

                      from(SELECT
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

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������
    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
        left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
        on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
        WHERE tal.orgid is not null AND (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''
		AND n.IS_DISABLE=0
		AND (p.PROJ_ID='''||projid||''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID='''||projid||'''))  '||v_where||'
)n
    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
    left join (SELECT node_id,
    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
else
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
		CHARGE_PERSON,
    NODE_LEVEL,
    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                      || v_sql
                      || ' as NODE_WARNING from (select n.*,charge_person,w.IS_UN_WATCH
,case when w.IS_UN_WATCH=0 then ''ȡ��'' else ''��ע'' end as WACTH
,case when n.ACTUAL_END_DATE is null then ''�߰�''
else null end as HASTEN
,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=&bizId=''||ORIGINAL_NODE_ID end as w_Url

                      from(SELECT
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

    NODE_NAME,
    p.PLAN_NAME,--�ƻ�����
    PLAN_START_DATE,
    PLAN_END_DATE,

    ACTUAL_END_DATE,
    ESTIMATE_END_DATE,           --Ԥ�����ʱ��
    p.PROJ_NAME,          --������Ŀ
    p.PLAN_TYPE,        --�ƻ�������ʾ��
    DUTY_DEPARTMENT,          --������
    NODE_LEVEL,           --����ȼ�
    STANDARD_SCORE          --��׼��ֵ
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''') tal
        on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
        WHERE tal.orgid is not null AND (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and APPROVAL_STATUS=''�����''
		AND n.IS_DISABLE=0
		  '||v_where||'
)n
    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
    left join (SELECT node_id,
    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
end if;
-------------------------------------------------------------------------------------------����

        v_sql_exec_paging := '
select a.* from ( '
                             || v_sql_exec
                             || ' where rownum <= '
                             || pageindex * pagesizes
                             || ' ) a where a.rowno >= '
                             || pagesizes * ( pageindex - 1 )
                             || '';

        dbms_output.put_line(v_sql_exec_paging);
----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
                          || v_sql_exec
                          || ') a '
        INTO total;

-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec_paging;
--SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
        testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT
                               'ʧ�ܿ�' || testmsg plan_name
                           FROM
                               dual;

            dbms_output.put_line(sqlerrm);
    END;

END p_pom_smart_my_current_proj;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_PROJ_PLAN_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_PROJ_PLAN_DEL" (
    planid    IN        VARCHAR2,--�������������id
    type      IN        VARCHAR2,--0ɾ��ǰ��֤��1ִ��ɾ��,2������֤
    errmsg    OUT       VARCHAR2,--��ʾ��Ϣ
    errcode   OUT       INT--0�ɹ���1ʧ��
) IS
--����ɾ��
--���ߣ������� 
--���ڣ�2019/11/27
    countdtl   INT;
    testmsg    NVARCHAR2(200);
    errorCount INT;
     hiddleCount INT;
BEGIN
    BEGIN
                 errorCount := 0;
        testmsg := 'planid:'
                   || planid
                   || '.type:'
                   || type;
        countdtl := 0;
        IF length(planid) < 36 THEN
            raise_application_error(-20000, '��ѡ��Ҫɾ���ļƻ�');
        END IF;
--ѭ���ƻ�id
-------------------------------------------------------
-------------------------------------------------------
        IF ( type = 1 ) THEN
            FOR item IN (
                SELECT
                    regexp_substr(''
                                  || planid
                                  || '', '[^,]+', 1, ROWNUM) AS id
                FROM
                    dual
                CONNECT BY
                    ROWNUM <= length(''
                                     || planid
                                     || '') - length(regexp_replace(''
                                                                    || planid
                                                                    || '', ',', '')) + 1
            ) LOOP 
    ---ɾ���ƻ�
                DELETE pom_proj_plan 
                WHERE
                    id = ''
                         || item.id
                         || '';

                DELETE pom_proj_plan_node 
                WHERE
                    PROJ_PLAN_ID = ''
                                   || item.id
                                   || '';

                countdtl := countdtl + 1;
            END LOOP;
            errcode := 0;
            errmsg := 'ɾ���ɹ���'
                      || countdtl
                      || '���ƻ�';
        ELSIF ( type = 0 ) THEN
               FOR item IN (
                SELECT
                    regexp_substr(''
                                  || planid
                                  || '', '[^,]+', 1, ROWNUM) AS id
                FROM
                    dual
                CONNECT BY
                    ROWNUM <= length(''
                                     || planid
                                     || '') - length(regexp_replace(''
                                                                    || planid
                                                                    || '', ',', '')) + 1
            ) LOOP          
        SELECT
            COUNT(id)
        INTO hiddleCount
        FROM
            pom_proj_Plan
        WHERE
            id = ''
                        || item.id
                        || '' and (APPROVAL_STATUS='�����' or APPROVAL_STATUS='�����');
               errorCount:=errorCount+hiddleCount;
            END LOOP; 
              IF errorCount > 0 THEN
              errcode := 1;
            errmsg := '�üƻ��ѷ����������뽫��������������ɾ����';
            ELSE
            errcode := 0;
            errmsg := '';
            END IF;

        ELSIF ( type = 2 ) THEN
        IF length(planid)>36 THEN
        errcode:=1;
        errmsg:='һ��ֻ�������һ���ƻ�';
        ELSE 
         SELECT COUNT(id) INTO hiddleCount FROM POM_PROJ_PLAN WHERE APPROVAL_STATUS <>'�����' AND ID=''|| planid;
         IF hiddleCount>0 THEN
          errcode:=1;
          errmsg:='�üƻ���δ����,�뽫�ƻ�������ɺ��ٵ�����';
          ELSE
          errcode:=0;
          errmsg:='';
          END IF;
        END IF;

    END IF;

    EXCEPTION
        WHEN OTHERS THEN
            errcode := 1;
            errmsg := sqlerrm;
    END;
END p_pom_smart_proj_plan_del;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_PROJECT_PLAN_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_PROJECT_PLAN_DEL" 
(
		PLANID  IN VARCHAR2
	 , --�������������id
		TYPE    IN VARCHAR2
	 , --0ɾ��ǰ��֤��1ִ��ɾ��
		ERRMSG  OUT VARCHAR2
	 , --��ʾ��Ϣ
		ERRCODE OUT INT --0�ɹ���1ʧ��
) IS
		--����ɾ��
		--���ߣ�������
		--���ڣ�2019/11/27
		COUNTDTL    INT;
		TESTMSG     NVARCHAR2(200);
		ERRORCOUNT  INT;
		HIDDLECOUNT INT;
BEGIN
		BEGIN
				ERRORCOUNT := 0;
				TESTMSG    := 'planid:' || PLANID || '.type:' || TYPE;
				COUNTDTL   := 0;
				IF LENGTH(PLANID) < 36 THEN
						RAISE_APPLICATION_ERROR(-20000, '��ѡ��Ҫɾ���ļƻ�' || TESTMSG);
				END IF;
				--ѭ������id
				-------------------------------------------------------
				-------------------------------------------------------
				IF (TYPE = 1) THEN
						FOR ITEM IN (SELECT REGEXP_SUBSTR('' || PLANID || '', '[^,]+', 1,
																							 ROWNUM) AS ID
												 FROM   DUAL
												 CONNECT BY ROWNUM <=
																		LENGTH('' || PLANID || '') -
																		LENGTH(REGEXP_REPLACE('' || PLANID || '',
																													',', '')) + 1)
						LOOP
								---ɾ���ƻ�
								DELETE POM_PROJ_PLAN WHERE ID = '' || ITEM.ID || '';
						
								COUNTDTL := COUNTDTL + 1;
						END LOOP;
						ERRCODE := 0;
						ERRMSG  := 'ɾ���ɹ���' || COUNTDTL || '���ƻ�';
				ELSIF (TYPE = 0) THEN
						FOR ITEM IN (SELECT REGEXP_SUBSTR('' || PLANID || '', '[^,]+', 1,
																							 ROWNUM) AS ID
												 FROM   DUAL
												 CONNECT BY ROWNUM <=
																		LENGTH('' || PLANID || '') -
																		LENGTH(REGEXP_REPLACE('' || PLANID || '',
																													',', '')) + 1)
						LOOP
								SELECT COUNT(ID)
								INTO   HIDDLECOUNT
								FROM   POM_PROJ_PLAN
								WHERE  ID = '' || ITEM.ID || '' AND
											 APPROVAL_STATUS = '�����';
								ERRORCOUNT := ERRORCOUNT + HIDDLECOUNT;
						END LOOP;
						IF ERRORCOUNT > 0 THEN
								ERRCODE := 1;
								ERRMSG  := '��������˵ļƻ���';
						ELSE
								ERRCODE := 0;
								ERRMSG  := '��֤ͨ����';
						END IF;
				END IF;
		
		EXCEPTION
				WHEN OTHERS THEN
						ERRCODE := 1;
						ERRMSG  := SQLERRM;
		END;
END P_POM_SMART_PROJECT_PLAN_DEL;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_RULE_SET_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_RULE_SET_DEL" 
(
		RULEID  IN VARCHAR2
	 , --�������������id
		TYPE    IN VARCHAR2
	 , --0ɾ��ǰ��֤��1ִ��ɾ��
		ERRMSG  OUT VARCHAR2
	 , --��ʾ��Ϣ
		ERRCODE OUT INT --0�ɹ���1ʧ��
) IS
		--����ɾ��
		--���ߣ�����
		--���ڣ�2019/11/17
		COUNTDTL INT;
		TESTMSG  NVARCHAR2(4000);
BEGIN
		BEGIN
				TESTMSG  := 'ruleid:' || RULEID || '.type:' || TYPE;
				COUNTDTL := 0;
				IF LENGTH(RULEID) < 36 THEN
						RAISE_APPLICATION_ERROR(-20000, '��ѡ��Ҫɾ���Ĺ���' || TESTMSG);
				END IF;
				--ѭ������id
		
				IF (TYPE = 1) THEN
						FOR ITEM IN (SELECT REGEXP_SUBSTR('' || RULEID || '', '[^,]+', 1,
																							 ROWNUM) AS ID
												 FROM   DUAL
												 CONNECT BY ROWNUM <=
																		LENGTH('' || RULEID || '') -
																		LENGTH(REGEXP_REPLACE('' || RULEID || '',
																													',', '')) + 1)
						LOOP
								---ɾ������
								DELETE POM_RULE_SET WHERE ID = '' || ITEM.ID || '';
						
								COUNTDTL := COUNTDTL + 1;
						END LOOP;
				
						ERRCODE := 0;
						ERRMSG  := 'ɾ���ɹ���' || COUNTDTL || '������';
				ELSIF (TYPE = 0) THEN
						ERRCODE := 0;
						ERRMSG  := '��֤ͨ����';
				END IF;
		
		EXCEPTION
				WHEN OTHERS THEN
						ERRCODE := 1;
						ERRMSG  := SQLERRM;
		END;
END P_POM_SMART_RULE_SET_DEL;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_RULE_SET_STATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_RULE_SET_STATE" (
    ruleid      IN          VARCHAR2,--�������������id
    statetype   IN          INT,--0��Ч��1ʧЧ
    errmsg      OUT         VARCHAR2,--��ʾ��Ϣ
    errcode     OUT         INT--0�ɹ���1ʧ��
) IS
--������ЧʧЧ����
--���ߣ�����
--���ڣ�2019/11/17
    typemsg    VARCHAR2(50);
    ruleids    VARCHAR2(4000);
    countdtl   INT;
     testmsg NVARCHAR2(4000);
		 statuscount NUMBER;
BEGIN
    BEGIN
        testmsg:='ruleid:'||ruleid||'.statetype:'||statetype;
        countdtl := 0;
        IF statetype = 0 THEN
            typemsg := '��Ч';
        ELSE
            typemsg := 'ʧЧ';
        END IF;

        IF length(ruleid) < 36 THEN
            raise_application_error(-20000, '��ѡ��Ҫ'
                                            || typemsg
                                            || '�Ĺ���'||testmsg);
        END IF;



--ѭ������id

        FOR item IN (
            SELECT
                regexp_substr(''
                              || ruleid
                              || '', '[^,]+', 1, ROWNUM) AS id
            FROM
                dual
            CONNECT BY
                ROWNUM <= length(''
                                 || ruleid
                                 || '') - length(regexp_replace(''
                                                                || ruleid
                                                                || '', ',', '')) + 1
        ) LOOP 
    ---ƴ���ַ���
		  ruleids := ruleids || item.id;
			SELECT COUNT(is_disable) INTO statuscount  FROM pom_rule_set WHERE ID='' || item.id || '' AND is_disable=statetype ;
			IF(statuscount>0) THEN
				errcode := 1;
				errmsg := '����'''||typemsg||'''�Ĺ�����ѡ����ͬ״̬�����ݽ��в���';
				return;
			ELSE 
					UPDATE pom_rule_set 
					SET is_disable = statetype 
					WHERE
						id = '' || item.id || '';
					countdtl := countdtl + 1;
			END IF;


--             UPDATE pom_rule_set
--             SET
--                 is_disable = statetype
--             WHERE
--                 id = ''
--                      || item.id
--                      || '';
-- 
--             countdtl := countdtl + 1;
        END LOOP;

        errcode := 0;
        errmsg := typemsg
                  || '���óɹ���'
                  || countdtl
                  || '������';
    EXCEPTION
        WHEN OTHERS THEN
            errcode := 1;
            errmsg := sqlerrm;
    END;
END p_pom_smart_rule_set_state;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_SPECIAL_PLAN_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_SPECIAL_PLAN_DEL" (
    planid    IN        VARCHAR2,--�������������id
    type      IN        VARCHAR2,--0ɾ��ǰ��֤��1ִ��ɾ��,2 ������֤
    errmsg    OUT       VARCHAR2,--��ʾ��Ϣ
    errcode   OUT       INT--0�ɹ���1ʧ��
) IS
--����ɾ��
--���ߣ������� 
--���ڣ�2019/11/27
    countdtl   INT;
    testmsg    NVARCHAR2(200);
    errorCount INT;
     hiddleCount INT;
BEGIN
    BEGIN
                 errorCount := 0;
        testmsg := 'planid:'
                   || planid
                   || '.type:'
                   || type;
        countdtl := 0;
        IF length(planid) < 36 THEN
            raise_application_error(-20000, '��ѡ��Ҫɾ���ļƻ�');
        END IF;
--ѭ���ƻ�id
-------------------------------------------------------
-------------------------------------------------------
        IF ( type = 1 ) THEN
            FOR item IN (
                SELECT
                    regexp_substr(''
                                  || planid
                                  || '', '[^,]+', 1, ROWNUM) AS id
                FROM
                    dual
                CONNECT BY
                    ROWNUM <= length(''
                                     || planid
                                     || '') - length(regexp_replace(''
                                                                    || planid
                                                                    || '', ',', '')) + 1
            ) LOOP 
    ---ɾ���ƻ�
                DELETE POM_SPECIAL_PLAN 
                WHERE
                    id = ''
                         || item.id
                         || '';

                DELETE POM_SPECIAL_PLAN_NODE
                WHERE
                    PLAN_ID = ''
                         || item.id
                         || '';

                countdtl := countdtl + 1;
            END LOOP;
            errcode := 0;
            errmsg := 'ɾ���ɹ���'
                      || countdtl
                      || '���ƻ�';
        ELSIF ( type = 0 ) THEN
               FOR item IN (
                SELECT
                    regexp_substr(''
                                  || planid
                                  || '', '[^,]+', 1, ROWNUM) AS id
                FROM
                    dual
                CONNECT BY
                    ROWNUM <= length(''
                                     || planid
                                     || '') - length(regexp_replace(''
                                                                    || planid
                                                                    || '', ',', '')) + 1
            ) LOOP          
        SELECT
            COUNT(id)
        INTO hiddleCount
        FROM
            POM_SPECIAL_PLAN
        WHERE
            id = ''
                        || item.id
                        || '' and (APPROVAL_STATUS='�����' or APPROVAL_STATUS='�����');
               errorCount:=errorCount+hiddleCount;
            END LOOP; 
              IF errorCount > 0 THEN
              errcode := 1;
            errmsg := '�üƻ��ѷ�������,�뽫��������������ɾ����';
            ELSE
            errcode := 0;
            errmsg := '';
            END IF;
        ELSIF ( type = 2 ) THEN
        IF length(planid)>36 THEN
        errcode:=1;
        errmsg:='һ��ֻ�������һ���ƻ�';
        ELSE 
         SELECT COUNT(id) INTO hiddleCount FROM POM_SPECIAL_PLAN WHERE APPROVAL_STATUS<>'�����' AND ID=''|| planid;
         IF hiddleCount>0 THEN
          errcode:=1;
          errmsg:='�üƻ���δ����,�뽫�ƻ���������ٵ�����';
          ELSE
          errcode:=0;
          errmsg:='';
          END IF;
        END IF;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            errcode := 1;
            errmsg := sqlerrm;
    END;
END p_pom_smart_special_plan_del;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_SPECIALTEMP_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_SPECIALTEMP_DEL" ( templateid IN VARCHAR2, --���������ר��ƻ�ģ��ID
		type IN VARCHAR2, 
		errmsg OUT VARCHAR2, --��ʾ��Ϣ
		errcode OUT INT --0�ɹ���1ʧ��
	) IS --ר��ƻ�ģ��ɾ��
--���ߣ�Ҷ����
--���ڣ�2019/11/21
	hiddleCount INT;
BEGIN
	BEGIN
		IF
			length( templateid ) < 36 THEN
				raise_application_error ( - 20000, '��ѡ��Ҫɾ����ģ��' );

		END IF;
		IF
			( type = 1 ) THEN
-- 				DELETE POM_SPECIAL_TEMPLATE 
-- 			WHERE
-- 				id = ''||templateid||'';
-- 			errcode := 0;
-- 			errmsg := 'ɾ���ɹ���';
-- 			


				SELECT
				COUNT( ID ) INTO hiddleCount 
			FROM
				POM_SPECIAL_TEMPLATE 
			WHERE
				ID = ''||templateid||'' 
				AND TEMPLATE_STATUS = '��ʽ';
			IF
				( hiddleCount > 0 ) THEN
					errcode := 1;
				errmsg := '�ѷ����ļƻ�ģ�岻����ɾ����';
				ELSE errcode := 0;
				errmsg := '';

			END IF;
			ELSE
							DELETE POM_SPECIAL_TEMPLATE 
			WHERE
				id = ''||templateid||'';
			errcode := 0;
			errmsg := 'ɾ���ɹ���';


		END IF;
		EXCEPTION 
			WHEN OTHERS THEN
			errcode := 1;
		errmsg := sqlerrm;

	END;

END p_pom_smart_specialtemp_del;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_STANDARD_NODE_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_STANDARD_NODE_DEL" ( nodeid IN VARCHAR2, --���������������ID
		type IN VARCHAR2,--��������   0��
		errmsg OUT VARCHAR2, --��ʾ��Ϣ
		errcode OUT INT --0�ɹ���1ʧ��
	) IS --��׼�ڵ������ɾ��
--���ߣ�Ҷ����
--���ڣ�2019/11/21
    countdtl NUMBER;
		templatenodecount NUMBER;
        nodelist CLOB;
BEGIN


 BEGIN
        countdtl := 0;
        IF length(nodeid) < 36 THEN
            raise_application_error(-20000, '��ѡ��Ҫɾ����������');
        END IF;

		IF (type=1) THEN
				--ѭ������id

        FOR item IN (
            SELECT
                regexp_substr(''
                              || nodeid
                              || '', '[^,]+', 1, ROWNUM) AS id
            FROM
                dual
            CONNECT BY
                ROWNUM <= length(''
                                 || nodeid
                                 || '') - length(regexp_replace(''
                                                                || nodeid
                                                                || '', ',', '')) + 1
        ) LOOP
    ---ɾ��������
            DELETE POM_STANDARD_NODE
            WHERE
                id = ''
                     || item.id
                     || '';

            countdtl := countdtl + 1;
        END LOOP;

        errcode := 0;
        errmsg := 'ɾ���ɹ���'
                  || countdtl
                  || '��������';

		ELSE
			--ѭ������id

        FOR item IN (
            SELECT
                regexp_substr(''
                              || nodeid
                              || '', '[^,]+', 1, ROWNUM) AS id
            FROM
                dual
            CONNECT BY
                ROWNUM <= length(''
                                 || nodeid
                                 || '') - length(regexp_replace(''
                                                                || nodeid
                                                                || '', ',', '')) + 1
        ) LOOP
    ---ɾ����֤
          SELECT COUNT(ID) INTO templatenodecount FROM POM_TEMPLATE_NODE WHERE STANDARD_NODE_ID=''||item.id||'';
					IF (templatenodecount>0) THEN
						 errcode := 1;
							errmsg := '�Ѿ���ģ�����õĽڵ㲻����ɾ��';
					ELSE
					 errcode := 0;
						errmsg := '';

					END IF;
          select wm_concat(NODE_NAME) into nodelist from POM_STANDARD_NODE where REFERENCE_DATE_NODE_ID = ''||item.id||'';
                    IF (nodelist is not null) THEN
                        errcode := 1;
                        errmsg := '��ǰ�ڵ��ǡ�'|| nodelist ||'���ڵ�Ĳο�ʱ��ڵ㣬�������������ϵ���ٽ��нڵ�ɾ��';
					ELSE
                        errcode := 0;
                        errmsg := '';

					END IF;

        END LOOP;

		END IF;

    EXCEPTION
        WHEN OTHERS THEN
            errcode := 1;
            errmsg :=  'ɾ���ڵ�ʧ�ܣ�';
    END;





END p_pom_smart_standard_node_del;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_TASKCENTER_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_TASKCENTER_TBS" (
        orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
		condition IN VARCHAR2, --�����������˾id | ����id | ��Ŀid | ��ǰ�û�ID
        currentuserid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
        currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
        currentdeptid        IN            VARCHAR2,--��ǰ�û�����
        currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
        bizcode       IN            VARCHAR2,---Ȩ��code
        item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
--���ߣ�yedr
--���ڣ�2019/12/25

    v_spid              VARCHAR2(200);
	BEGIN--========================================================����˾���������
--��������Ȩ����֤�洢����
 P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
	IF
		( orgtype = 0 ) THEN
		IF  condition <> '111' THEN
			OPEN item FOR SELECT--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
                    AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
					AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS ACOUNT,
--����δ�������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) +(
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS BCOUNT,
--����δ�������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
                    AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND node.IS_DEL=0
					AND ACTUAL_END_DATE IS NULL
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS CCOUNT,
--�������������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NOT NULL
                    AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND ACTUAL_END_DATE IS NOT NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ACTUAL_END_DATE IS NOT NULL
					AND node.IS_DEL=0
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS DCOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND node.IS_DEL=0
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS ECOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
						AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
						AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
					)
					AND node.IS_DELETE=0
					AND plan.APPROVAL_STATUS = '�����'
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND node.IS_DEL=0
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1 AND PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 ) )
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS FCOUNT,
--����������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
					)
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > trunc( SYSDATE, 'Q' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1 )
					AND node.IS_DEL=0
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS GCOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.proj_plan_id = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					AND node.COMPANY_ID = '' || condition || ''
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
					)
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					AND node.COMPANY_ID = 'condition'
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > trunc( SYSDATE, 'yyyy' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1 )
					AND node.IS_DEL=0
					AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS HCOUNT
		FROM
			dual;
		ELSE
				OPEN item FOR SELECT--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
					AND plan.APPROVAL_STATUS = '�����'
					AND	node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
					AND node.ACTUAL_END_DATE IS NULL
					AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
				)
			) AS ACOUNT,
--����δ�������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) +(
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND SYSDATE > node.PLAN_END_DATE
					AND node.ACTUAL_END_DATE IS NULL
					AND (node.IS_DEL=0 OR node.IS_DEL=null)
				)
			) AS BCOUNT,
--����δ�������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND node.IS_DEL=0
					AND ACTUAL_END_DATE IS NULL
					--AND plan.COMPANY_ID = '' || condition || ''
				)
			) AS CCOUNT,
--�������������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND node.ACTUAL_END_DATE IS NOT NULL
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND ACTUAL_END_DATE IS NOT NULL
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ACTUAL_END_DATE IS NOT NULL
					AND node.IS_DEL=0
				)
			) AS DCOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND node.IS_DEL=0
				)
			) AS ECOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
						AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
						AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
					)
					AND node.IS_DELETE=0
					AND plan.APPROVAL_STATUS = '�����'
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND node.IS_DEL=0
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1 AND PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 ) )
				)
			) AS FCOUNT,
--����������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND(
						node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
					)
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > trunc( SYSDATE, 'Q' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1 )
					AND node.IS_DEL=0
				)
			) AS GCOUNT,
--��������
			(
				(
				SELECT
					COUNT( * )
				FROM
					POM_PROJ_PLAN_NODE node
					LEFT JOIN POM_PROJ_PLAN plan ON node.proj_plan_id = plan.ID
                    left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                    left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                     on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
					)
					AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DISABLE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					POM_SPECIAL_PLAN_NODE node
					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND (
						node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
						AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
					)
					AND plan.APPROVAL_STATUS = '�����'
					AND node.IS_DELETE=0
					) + (
				SELECT
					COUNT( * )
				FROM
					pom_dept_monthly_plan_node node
					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                    WHERE tal.orgid is not null
                    AND node_source IS NULL
					AND APPROVE_STATUS = '�����'
					AND ( PLAN_END_DATE > trunc( SYSDATE, 'yyyy' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1 )
					AND node.IS_DEL=0
				)
			) AS HCOUNT
		FROM
			dual;
		END IF;
--========================================================����˾���������END
--========================================================�����Ÿ��������
		ELSIF ( orgtype = 1 ) THEN
			IF(condition <> '222') THEN
                OPEN item FOR SELECT--��������
			(
				(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						AND node.IS_DELETE=0
						AND plan.APPROVAL_STATUS = '�����'
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'month' ) AND PLAN_END_DATE < trunc( last_day( SYSDATE ) ) )
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS ACOUNT,
--����δ�������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND SYSDATE > PLAN_END_DATE
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS BCOUNT,
--����δ�������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS CCOUNT,
--�������������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NOT NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND ACTUAL_END_DATE IS NOT NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NOT NULL
						AND node.IS_DEL=0
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS DCOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS ECOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND(
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ( PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1 AND PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 ) )
						AND node.IS_DEL=0
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS FCOUNT,
--����������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'Q' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1 )
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS GCOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						AND node.DUTY_DEPARTMENT_ID = '' || condition || ''
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'yyyy' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1 )
						AND DUTY_DEPT_ID = '' || condition || ''
					)
				) AS HCOUNT
			FROM
				dual;
            ELSE
                OPEN item FOR SELECT--��������
			(
				(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND node.IS_DELETE=0
						AND plan.APPROVAL_STATUS = '�����'
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'month' ) AND PLAN_END_DATE < trunc( last_day( SYSDATE ) ) )
					)
				) AS ACOUNT,
--����δ�������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND SYSDATE > PLAN_END_DATE
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
					)
				) AS BCOUNT,
--����δ�������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NULL
						AND node.IS_DEL=0
					)
				) AS CCOUNT,
--�������������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NOT NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND ACTUAL_END_DATE IS NOT NULL
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ACTUAL_END_DATE IS NOT NULL
						AND node.IS_DEL=0
					)
				) AS DCOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
					)
				) AS ECOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND ( PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1 AND PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 ) )
						AND node.IS_DEL=0
					)
				) AS FCOUNT,
--����������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND(
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'Q' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1 )
					)
				) AS GCOUNT,
--��������
				(
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						POM_SPECIAL_PLAN_NODE node
						LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
                         LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.DUTY_DEPARTMENT_ID or tal.orgid=node.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DELETE=0
						) + (
					SELECT
						COUNT( * )
					FROM
						pom_dept_monthly_plan_node node
						LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
                        LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
                        WHERE tal.orgid is not null
                        AND node_source IS NULL
						AND APPROVE_STATUS = '�����'
						AND node.IS_DEL=0
						AND ( PLAN_END_DATE > trunc( SYSDATE, 'yyyy' ) AND PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1 )
					)
				) AS HCOUNT
			FROM
				dual;
            END IF;
--========================================================�����Ÿ��������END
--========================================================����Ŀ���������
			ELSIF ( orgtype = 2 ) THEN
				IF ( condition <> '111') THEN
					OPEN item FOR SELECT--��������
				(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS ACOUNT,
--����δ�������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS BCOUNT,
--����δ�������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS CCOUNT,
--�������������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NOT NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS DCOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS ECOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS FCOUNT,
--����������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS GCOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
						AND (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||''))
					) AS HCOUNT
				FROM
					dual;
				ELSE
					OPEN item FOR SELECT--��������
				(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND node.ACTUAL_END_DATE IS NULL
						AND ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS ACOUNT,
--����δ�������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND SYSDATE > node.PLAN_END_DATE
						AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS BCOUNT,
--����δ�������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS CCOUNT,
--�������������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND node.ACTUAL_END_DATE IS NOT NULL
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS DCOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS ECOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > last_day( trunc( SYSDATE ) ) + 1
							AND node.PLAN_END_DATE < last_day( last_day( trunc( SYSDATE ) ) + 1 )
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS FCOUNT,
--����������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'Q' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS GCOUNT,
--��������
					(
					SELECT
						COUNT( * )
					FROM
						POM_PROJ_PLAN_NODE node
						LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                        left join SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                        left join (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
                         on (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
                        WHERE tal.orgid is not null
                        AND (
							node.PLAN_END_DATE > trunc( SYSDATE, 'yyyy' )
							AND node.PLAN_END_DATE < add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
						)
						AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' OR plan.PLAN_TYPE = '�ؼ��ڵ�ƻ�' )
						AND plan.APPROVAL_STATUS = '�����'
						AND node.IS_DISABLE=0
					) AS HCOUNT
				FROM
					dual;
				END IF;
--========================================================����Ŀ���������END
--========================================================���˸��������
				ELSE OPEN item FOR SELECT--����δ�������
				(
					(
						SELECT
							COUNT( * )
						FROM
							POM_PROJ_PLAN_NODE node
							LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node.ACTUAL_END_DATE IS NULL
							AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' )
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DISABLE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							POM_SPECIAL_PLAN_NODE node
							LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node.ACTUAL_END_DATE IS NULL
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DELETE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							pom_dept_monthly_plan_node node
							LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node_source IS NULL
							AND ACTUAL_END_DATE IS NULL
							AND APPROVE_STATUS = '�����'
							AND node.IS_DEL=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
						)
					) AS ACOUNT,
--����δ�������
					(
						(
						SELECT
							COUNT( * )
						FROM
							POM_PROJ_PLAN_NODE node
							LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							SYSDATE > node.PLAN_END_DATE
							AND node.ACTUAL_END_DATE IS NULL
							AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' )
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DISABLE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							POM_SPECIAL_PLAN_NODE node
							LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							SYSDATE > node.PLAN_END_DATE
							AND node.ACTUAL_END_DATE IS NULL
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DELETE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							pom_dept_monthly_plan_node node
							LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node_source IS NULL
							AND SYSDATE > PLAN_END_DATE
							AND ACTUAL_END_DATE IS NULL
							AND APPROVE_STATUS = '�����'
							AND node.IS_DEL=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
						)
					) AS BCOUNT,
--�������������
					(
						(
						SELECT
							COUNT( * )
						FROM
							POM_PROJ_PLAN_NODE node
							LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node.ACTUAL_END_DATE IS NOT NULL
							AND ( plan.PLAN_TYPE = '��Ŀ����ƻ�' )
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DISABLE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							POM_SPECIAL_PLAN_NODE node
							LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							ACTUAL_END_DATE IS NOT NULL
							AND plan.APPROVAL_STATUS = '�����'
							AND node.IS_DELETE=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
							) + (
						SELECT
							COUNT( * )
						FROM
							pom_dept_monthly_plan_node node
							LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
							LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
						WHERE
							node_source IS NULL
							AND ACTUAL_END_DATE IS NOT NULL
							AND APPROVE_STATUS = '�����'
							AND node.IS_DEL=0
							AND person.CHARGE_PERSON_ID = '' || condition || ''
						)
					) AS CCOUNT
				FROM
					dual;
--========================================================���˸��������END

			END IF;

END P_POM_SMART_TASKCENTER_TBS;
--============================������������Դ=====================================


--============================������������Դ=====================================

/
--------------------------------------------------------
--  DDL for Procedure P_POM_TASKLEVELCOMPLETIONRATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_TASKLEVELCOMPLETIONRATE" (
items out SYS_REFCURSOR)
is
--��Ŀ����ƻ�������񼶱������
--���ߣ�Ҷ����
--���ڣ�2020/03/20
begin
open items for select nodes.* from (select node_level as "fullName",round(SUM(
                CASE
                    WHEN node.actual_end_date IS NOT NULL THEN
                        1
                    ELSE
                        0
                END
            ) /(
                CASE
                    WHEN COUNT(node.id) = 0 THEN
                        1
                    ELSE
                        COUNT(node.id)
                END
            ), 4) AS "competationRate" FROM pom_proj_plan_node node left join pom_proj_plan plan on plan.id=node.proj_plan_id
where plan.plan_type='��Ŀ����ƻ�' AND plan.approval_status = '�����'  GROUP BY node.node_level
) nodes left join sys_bizparam_option param on param.PARAM_VALUE=nodes."fullName" order by param.PARAM_CODE;
end p_pom_tasklevelcompletionrate;
--===================================��Ŀ����ƻ�������񼶱������=========

/
--------------------------------------------------------
--  DDL for Procedure P_POM_URGE_MESSAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_URGE_MESSAGE" (
    originalnodeid    varchar2,     --�ڵ�ԭʼID
    USERID IN VARCHAR2,--��ǰ��¼��
    plantype          varchar2,     --�ƻ����� ���ؼ��ڵ�ƻ�/��Ŀ����ƻ�/ר��ƻ�/�����¶ȼƻ���
   
    info     OUT      SYS_REFCURSOR--��Ϣ����
) IS
--�߰���Ϣ
--���ߣ�л�ɺ�
--���ڣ�2020/02/18
  m_user         varchar2(3000); -- �߰�������
  m_nodeid         varchar2(300); -- �ڵ�id
  m_userName         varchar2(2000); -- ���߰�������
  m_userId varchar2(2000); -- ���߰���id
  m_MOBILE_PHONE varchar2(2000); -- ���߰��˵绰
  m_nodeName         varchar2(2000); -- �߰�ڵ�
BEGIN

 begin

if plantype = '�ؼ��ڵ�ƻ�' or plantype = '��Ŀ����ƻ�' then
    dbms_output.put_line('1');
       select NODE_NAME,n.id into m_nodeName,m_nodeid from POM_PROJ_PLAN_NODE n left join 
       POM_Proj_PLAN p on n.PROJ_PLAN_ID=p.id
       where  ORIGINAL_NODE_ID=originalnodeid and p.APPROVAL_STATUS='�����';
       dbms_output.put_line('2');
  elsif plantype = 'ר��ƻ�' then
     select NODE_NAME,n.id into m_nodeName,m_nodeid from POM_SPECIAL_PLAN_NODE n left join 
       POM_SPECIAL_PLAN p on n.PLAN_ID=p.id
       where  ORIGINAL_NODE_ID=originalnodeid and p.APPROVAL_STATUS='�����';
  elsif plantype = '�����¶ȼƻ�' then
       select NODE_NAME,n.id into m_nodeName,m_nodeid from POM_DEPT_MONTHLY_PLAN_NODE n left join 
       POM_DEPT_MONTHLY_PLAN p on n.DEPT_MONTHLY_PLAN_ID=p.id
       where  ORIGINAL_NODE_ID=originalnodeid and p.APPROVE_STATUS='�����';
end if;
 select CHARGE_PERSON,CHARGE_PERSON_ID into m_userName,m_userId from POM_NODE_CHARGE_PERSON where node_id=m_nodeid;
 select MOBILE_PHONE into m_MOBILE_PHONE from sys_user where id=m_userId;
 select user_name into m_user from sys_user where id=USERID;
   EXCEPTION
        WHEN OTHERS THEN
--           m_userName:='δ֪';
--           m_nodeName:='δ֪';
            dbms_output.put_line(sqlerrm);
    END;
    OPEN info FOR SELECT
                ------------------------------------------------------------����������Ϣ
              '71313f018a35f3a558166cba7599b5d6' AS "systemId",--ϵͳid
              'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",--Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶΣ�
            ------------------------------------------------------------ҵ��䶯������Ϣ
              originalnodeid AS "bizKey",--ҵ��id
               'tjSMS' AS "msgChannel",--ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
            ------------------------------------------------------------���ű������
              '400014' AS "smsTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã�{2}�������������{3}�������˴߰죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
              '["'||m_userName||'","'||m_user||'","'||m_nodeName||'",""]' AS "smsParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
              m_MOBILE_PHONE as "mobile",--���Ž����˵绰
            ------------------------------------------------------------΢�ű������
              '400014' AS "wechatTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
              '["'||m_userName||'","'||m_user||'","'||m_nodeName||'",""]' AS "wechatParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
               '///' AS "wechatJumplinkUrl",--΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
              'v-xufeng' AS "recipientAccount",--������usercode�磺a-xiexuhua
            ------------------------------------------------------------��Ϣ��¼��׷����Ϣ
              '�߰���Ϣ' AS "title",--��Ϣ����
              'v-xufeng' AS "senderAccount",--������usercode�磺a-xiexuhua
              ''||m_userName||'���ã�'||m_user||'�������������'||m_nodeName||'�������˴߰�' AS "bizSourceCategory",--ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
              '�߰���Ϣ' AS "bizMsgCategory"--��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
             FROM
                      dual;

END p_pom_urge_message;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_URGE_MSG_INFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_URGE_MSG_INFO" 
(
		ORIGINALNODEID IN VARCHAR2 --�ڵ�ԭʼID
	 ,USERID         IN VARCHAR2 --��ǰ��¼��
	 ,PLANTYPE       IN VARCHAR2 --�ƻ����� ���ؼ��ڵ�ƻ�/��Ŀ����ƻ�/ר��ƻ�/�����¶ȼƻ���
	 ,MESSAGETYPE    OUT VARCHAR2 --0:�Ż��ն���Ϣ�����ͣ�1��ֻ�����Ż���2��ֻ���Ͷ��Ż�΢��
	 ,INFO           OUT SYS_REFCURSOR --��Ϣ����
) IS
		--ͨ�����ͼ����Ż��Ͷ���΢����Ϣ���ݻ�ȡ�洢����-------�߰���Ϣʵ��
		--1����������ɸ��ݴ洢����ע���Զ���
		--2�����ɾ��messageType��info���룬info���ؽ���ֶ����ƺʹ�Сд��Ҫ�ϸ��ն��巵��
		--���ߣ�����
		--���ڣ�2020/03/03
		M_USER           VARCHAR2(3000); -- �߰�������
		M_URGEUSERCODE   VARCHAR2(3000); -- �߰���code
		M_PLANID         VARCHAR2(300); -- �ƻ�id
		M_NODEID         VARCHAR2(300); -- �ڵ�id
		M_USERNAME       VARCHAR2(2000); -- ���߰�������
		M_USERCODE       VARCHAR2(2000); -- ���߰���id
		M_MOBILE_PHONE   VARCHAR2(2000); -- ���߰��˵绰
		M_NODENAME       VARCHAR2(2000); -- �߰�ڵ�
		M_SEC_COMPANY_ID VARCHAR(2000); -- ������λID
		M_PLAN_NAME      VARCHAR2(1000); --�ƻ�����
		M_IS_GROUPS      VARCHAR2(1000); --�����ж��Ƿ���"������Ա���Ĵ߰���Ϣ
BEGIN
		MESSAGETYPE := 0;

		BEGIN
				--��ȡ�ڵ���Ϣ
				IF PLANTYPE = '�ؼ��ڵ�ƻ�' OR PLANTYPE = '��Ŀ����ƻ�' THEN
						DBMS_OUTPUT.PUT_LINE('1');
						SELECT NODE_NAME, N.ID, P.ID
						INTO   M_NODENAME, M_NODEID, M_PLANID
						FROM   POM_PROJ_PLAN_NODE N
						LEFT   JOIN POM_PROJ_PLAN P
						ON     N.PROJ_PLAN_ID = P.ID
						WHERE  ORIGINAL_NODE_ID = ORIGINALNODEID AND P.APPROVAL_STATUS = '�����';
						DBMS_OUTPUT.PUT_LINE('2');
				ELSIF PLANTYPE = 'ר��ƻ�' THEN
						SELECT NODE_NAME, N.ID, P.ID
						INTO   M_NODENAME, M_NODEID, M_PLANID
						FROM   POM_SPECIAL_PLAN_NODE N
						LEFT   JOIN POM_SPECIAL_PLAN P
						ON     N.PLAN_ID = P.ID
						WHERE  ORIGINAL_NODE_ID = ORIGINALNODEID AND P.APPROVAL_STATUS = '�����';
				ELSIF PLANTYPE = '�����¶ȼƻ�' THEN
						SELECT NODE_NAME, N.ID, P.ID
						INTO   M_NODENAME, M_NODEID, M_PLANID
						FROM   POM_DEPT_MONTHLY_PLAN_NODE N
						LEFT   JOIN POM_DEPT_MONTHLY_PLAN P
						ON     N.DEPT_MONTHLY_PLAN_ID = P.ID
						WHERE  ORIGINAL_NODE_ID = ORIGINALNODEID AND P.APPROVE_STATUS = '�����';
				END IF;
				--��ȡ������λ��˾ID
				SELECT A.ID
				INTO   M_SEC_COMPANY_ID
				FROM   SYS_BUSINESS_UNIT A
				WHERE  A.LEVEL_RANK = 2
				START  WITH A.ID = (SELECT P.COMPANY_ID FROM POM_PROJ_PLAN P WHERE P.ID = M_PLANID)
				CONNECT BY PRIOR A.PARENT_ID = A.ID;

				--��ȡ��Ŀ����
				SELECT A.PLAN_NAME INTO M_PLAN_NAME FROM POM_PROJ_PLAN A WHERE A.ID = M_PLANID;

				--�ж��Ƿ��Ǽ��Ź�˾��Ա���Ĵ߰���Ϣ//���Ǽ�����Ա���Ĵ߰���Ϣ,�����͸�������λ�ƻ���Ӫ������

				SELECT COUNT(1)
				INTO   M_IS_GROUPS
				FROM   SYS_USER A
				INNER  JOIN SYS_STATION_TO_USER B
				ON     A.ID = B.USER_ID
				INNER  JOIN SYS_STATION C
				ON     B.STATION_ID = C.ID
				INNER  JOIN SYS_BUSINESS_UNIT D
				ON     C.ORG_ID = D.ID
				WHERE  A.ID = USERID AND (SELECT P.ORG_NAME FROM SYS_BUSINESS_UNIT P WHERE P.IS_COMPANY = 1 AND P.LEVEL_RANK = 2 START WITH P.ID = C.ORG_ID CONNECT BY PRIOR P.PARENT_ID = P.ID) = '�����ܲ�';

				IF USERID = '622f125e-e475-4a56-88e7-34d1ced1c063' THEN--ʱ��,�Ǽ�����Ա,������ʱ�ڼ��ż�ְ,���⴦��
						M_IS_GROUPS := 1;
				ELSIF USERID = 'c5c997cc-23fd-4c2f-8933-c3c9f488668f' THEN--�����⣬�Ǽ�����Ա��������ʱ�ڼ��ż�ְ�����⴦��
						M_IS_GROUPS := 1;
				END IF;

				--��ȡ���߰�����Ϣ

				/* select CHARGE_PERSON,u.user_code,u.MOBILE_PHONE into m_userName,m_userCode,m_MOBILE_PHONE from POM_NODE_CHARGE_PERSON p
        left join  sys_user u on p.CHARGE_PERSON_ID=u.id where node_id=m_nodeid;*/

				SELECT USER_NAME, USER_CODE INTO M_USER, M_URGEUSERCODE FROM SYS_USER WHERE ID = USERID;

		EXCEPTION
				WHEN OTHERS THEN
						--           m_userName:='δ֪';
						--           m_nodeName:='δ֪';
						DBMS_OUTPUT.PUT_LINE(SQLERRM);
		END;

		IF M_IS_GROUPS <> 0 THEN
				BEGIN
						OPEN INFO FOR
								SELECT
								------------------------------------------------------------�����������ݡ����롿�������Ż���վ���豸��Ϣ���������ã�----------------------------
								 M_URGEUSERCODE AS "senderAccount",
								 --������usercode�磺a-xiexuhua,---�Ż���վ��creatorName
								 U.USER_CODE AS "recipientAccount",
								 --������usercode�磺a-xiexuhua--�Ż���վ��ownerName
								 'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",
								 --Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶ�---�Ż���վ��sourceAppId
								 '71313f018a35f3a558166cba7599b5d6' AS "systemId",
								 --ϵͳid
								 ORIGINALNODEID AS "bizKey",
								 --ҵ��id--�Ż���վ��taskId
								 '�߰���Ϣ' AS "bizMsgCategory",
								 --��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
								 ------------------------------------------------------------�豸��Ϣ���ÿ�ʼ------------------------------------------------------------ 
								 ------------------------------------------------------------������΢�ű��롿������Ϣ
								 'tjSMS,tjWeChat' AS "msgChannel",
								 --ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
								 ------------�����ű��롿����
								 '400014' AS "smsTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã�{2}�������������{3}�������˴߰죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
								 '["' || P.CHARGE_PERSON || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "smsParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 U.MOBILE_PHONE AS "mobile",
								 --���Ž����˵绰
								 ------------��΢�ű��롿����
								 '400014' AS "wechatTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
								 '["' || P.CHARGE_PERSON || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "wechatParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 '///' AS "wechatJumplinkUrl",
								 --΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
								 ------------��Ϣ��¼����׷����Ϣ
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "title",
								 --��Ϣ����
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "bizSourceCategory",
								 --ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
								 ------------------------------------------------------------�豸��Ϣ���ý���------------------------------------------------------------ 
								 ------------------------------------------------------------�����Ż���վ��Ϣ------------------------------------------------------------ 
								 --taskid  �� String  ����ID---------------------�����Ż���վ��1���������/2�������Ѱ�taskid��3���������/4����������informationid��5�������ҵĹ�ע��informationid
								 --creatorname �� String  ������
								 --ownername �� String  ӵ����
								 --sourceAppId �� String  ����Ӧ�õ�appId
								 0 "portalMsgType",
								 --�����Ż���վ��Ϣ���ͣ�0������,1:�Ѱ죬10�����ģ�11:���ģ�20����ע��--�Ѱ죬��Ҫ�ȸ���bizKeyɾ�����죬���Ľӿ���Ҫ����bizKey���ü��Ŵ���ɾ���ӿ�
								 'http://pom.crccre.cn/pom/pom/middle?originalUrl=' ||
									URL_ENCODE('http://pom.crccre.cn/pom/pom/mission-center-feedback/my-responsible-task?cancelType=0' || CHR(38) || 'id=' || M_PLANID || CHR(38) || 'feedbackNodeId=' || M_NODEID ||
														 CHR(38) || 'feedbackNodeOriginalId=' || ORIGINALNODEID || CHR(38) || 'nodeSourcePlanType=1') "url",
								 --url �� String  Ӧ��ϵͳ��url��ַ
								 '��' "mobileUrl",
								 --mobileUrl  �� String  Ӧ��ϵͳ���ֻ���url��ַ
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' "taskname",
								 --taskname �� String  �������ƣ�����3���������/4����������informationname;���ڲ����ע��attentionname
								 '�ƻ���Ӫ' "typename",
								 --typename �� String  ��������
								 PLANTYPE "remark",
								 --remark �� String  ��ע

								 ----------------------------------------------
								 -----������ע�����С�
								 TO_CHAR(SYSDATE,'yyyy-MM-dd HH:mm:ss')  "expiretime",
								 --expiretime  �� String  ����ʱ�䣬��ʽyyyy-MM-dd HH:mm:ss-----����ʱ�䣬����ע����
								 1 "priority" --priority �� Integer ���ȼ�������ע����
								FROM   POM_NODE_CHARGE_PERSON P
								LEFT   JOIN SYS_USER U
								ON     P.CHARGE_PERSON_ID = U.ID
								WHERE  NODE_ID = M_NODEID
								UNION ALL
								--��ȡ������λ�ƻ���Ӫ������
								SELECT
								------------------------------------------------------------�����������ݡ����롿�������Ż���վ���豸��Ϣ���������ã�----------------------------
								 M_URGEUSERCODE AS "senderAccount",
								 --������usercode�磺a-xiexuhua,---�Ż���վ��creatorName
								 U.USER_CODE AS "recipientAccount",
								 --������usercode�磺a-xiexuhua--�Ż���վ��ownerName
								 'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",
								 --Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶ�---�Ż���վ��sourceAppId
								 '71313f018a35f3a558166cba7599b5d6' AS "systemId",
								 --ϵͳid
								 ORIGINALNODEID AS "bizKey",
								 --ҵ��id--�Ż���վ��taskId
								 '�߰���Ϣ' AS "bizMsgCategory",
								 --��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
								 ------------------------------------------------------------�豸��Ϣ���ÿ�ʼ------------------------------------------------------------ 
								 ------------------------------------------------------------������΢�ű��롿������Ϣ
								 'tjSMS,tjWeChat' AS "msgChannel",
								 --ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
								 ------------�����ű��롿����
								 '400014' AS "smsTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã�{2}�������������{3}�������˴߰죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
								 '["' || U.USER_NAME || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "smsParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 U.MOBILE_PHONE AS "mobile",
								 --���Ž����˵绰
								 ------------��΢�ű��롿����
								 '400014' AS "wechatTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
								 '["' || U.USER_NAME || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "wechatParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 '///' AS "wechatJumplinkUrl",
								 --΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
								 ------------��Ϣ��¼����׷����Ϣ
								 '' || U.USER_NAME || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "title",
								 --��Ϣ����
								 '' || U.USER_NAME || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "bizSourceCategory",
								 --ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
								 ------------------------------------------------------------�豸��Ϣ���ý���------------------------------------------------------------ 
								 ------------------------------------------------------------�����Ż���վ��Ϣ------------------------------------------------------------ 
								 --taskid  �� String  ����ID---------------------�����Ż���վ��1���������/2�������Ѱ�taskid��3���������/4����������informationid��5�������ҵĹ�ע��informationid
								 --creatorname �� String  ������
								 --ownername �� String  ӵ����
								 --sourceAppId �� String  ����Ӧ�õ�appId
								 10 "portalMsgType",
								 --�����Ż���վ��Ϣ���ͣ�0������,1:�Ѱ죬10�����ģ�11:���ģ�20����ע��--�Ѱ죬��Ҫ�ȸ���bizKeyɾ�����죬���Ľӿ���Ҫ����bizKey���ü��Ŵ���ɾ���ӿ�
								 'http://pom.crccre.cn/pom/pom/middle?originalUrl=' ||
									URL_ENCODE('http://pom.crccre.cn/pom/pom/mission-center-feedback/my-responsible-task?cancelType=0' || CHR(38) || 'id=' || M_PLANID || CHR(38) || 'feedbackNodeId=' || M_NODEID ||
														 CHR(38) || 'feedbackNodeOriginalId=' || ORIGINALNODEID || CHR(38) || 'nodeSourcePlanType=1') "url",
								 --url �� String  Ӧ��ϵͳ��url��ַ
								 '��' "mobileUrl",
								 --mobileUrl  �� String  Ӧ��ϵͳ���ֻ���url��ַ
								 '' || U.USER_NAME || '���ã�' || M_USER || '������' || M_NODENAME || '�������˴߰죬�붽�����������˼�ʱ���з���' "taskname",
								 --taskname �� String  �������ƣ�����3���������/4����������informationname;���ڲ����ע��attentionname
								 '�ƻ���Ӫ' "typename",
								 --typename �� String  ��������
								 PLANTYPE "remark",
								 --remark �� String  ��ע

								 ----------------------------------------------
								 -----������ע�����С�
								 TO_CHAR(SYSDATE,'yyyy-MM-dd HH:mm:ss')  "expiretime",
								 --expiretime  �� String  ����ʱ�䣬��ʽyyyy-MM-dd HH:mm:ss-----����ʱ�䣬����ע����
								 1 "priority" --priority �� Integer ���ȼ�������ע����
								FROM   POM_PROJ_PLAN_NODE O
								INNER  JOIN SYS_USER U
								ON     1 = 1 AND U.USER_CODE IN
											 (SELECT OO.USER_ACCOUNT
																	FROM   (SELECT (SELECT P.ID FROM SYS_BUSINESS_UNIT P WHERE P.LEVEL_RANK = 2 START WITH P.ID = A.COMPANY_ID CONNECT BY PRIOR P.PARENT_ID = P.ID) AS SEC_COMPANY_ID, A.*
																					 FROM   SYS_ROLE_USER_RELATION_RESULT A
																					 WHERE  A.ROLE_TYPE = 40 AND VIRTUAL_GROUP_NAME = '������λ�ƻ���Ӫ������') OO
																	WHERE  OO.SEC_COMPANY_ID = M_SEC_COMPANY_ID) AND EXISTS
								 (SELECT 1 FROM POM_PROJ_PLAN QQ WHERE QQ.ORIGINAL_PLAN_ID = O.ORIGINAL_PLAN_ID AND QQ.PLAN_TYPE = '�ؼ��ڵ�ƻ�' AND QQ.APPROVAL_STATUS = '�����')
								WHERE  O.ID = M_NODEID;
				END;
		ELSE
				BEGIN
						OPEN INFO FOR
								SELECT
								------------------------------------------------------------�����������ݡ����롿�������Ż���վ���豸��Ϣ���������ã�----------------------------
								 M_URGEUSERCODE AS "senderAccount",
								 --������usercode�磺a-xiexuhua,---�Ż���վ��creatorName
								 U.USER_CODE AS "recipientAccount",
								 --������usercode�磺a-xiexuhua--�Ż���վ��ownerName
								 'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",
								 --Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶ�---�Ż���վ��sourceAppId
								 '71313f018a35f3a558166cba7599b5d6' AS "systemId",
								 --ϵͳid
								 ORIGINALNODEID AS "bizKey",
								 --ҵ��id--�Ż���վ��taskId
								 '�߰���Ϣ' AS "bizMsgCategory",
								 --��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
								 ------------------------------------------------------------�豸��Ϣ���ÿ�ʼ------------------------------------------------------------ 
								 ------------------------------------------------------------������΢�ű��롿������Ϣ
								 'tjSMS,tjWeChat' AS "msgChannel",
								 --ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
								 ------------�����ű��롿����
								 '400014' AS "smsTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã�{2}�������������{3}�������˴߰죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
								 '["' || P.CHARGE_PERSON || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "smsParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 U.MOBILE_PHONE AS "mobile",
								 --���Ž����˵绰
								 ------------��΢�ű��롿����
								 '400014' AS "wechatTemplateid",
								 --ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
								 '["' || P.CHARGE_PERSON || '","' || M_USER || '","' || M_NODENAME || '",""]' AS "wechatParams",
								 --������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
								 '///' AS "wechatJumplinkUrl",
								 --΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
								 ------------��Ϣ��¼����׷����Ϣ
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "title",
								 --��Ϣ����
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' AS "bizSourceCategory",
								 --ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
								 ------------------------------------------------------------�豸��Ϣ���ý���------------------------------------------------------------ 
								 ------------------------------------------------------------�����Ż���վ��Ϣ------------------------------------------------------------ 
								 --taskid  �� String  ����ID---------------------�����Ż���վ��1���������/2�������Ѱ�taskid��3���������/4����������informationid��5�������ҵĹ�ע��informationid
								 --creatorname �� String  ������
								 --ownername �� String  ӵ����
								 --sourceAppId �� String  ����Ӧ�õ�appId
								 0 "portalMsgType",
								 --�����Ż���վ��Ϣ���ͣ�0������,1:�Ѱ죬10�����ģ�11:���ģ�20����ע��--�Ѱ죬��Ҫ�ȸ���bizKeyɾ�����죬���Ľӿ���Ҫ����bizKey���ü��Ŵ���ɾ���ӿ�
								 'http://pom.crccre.cn/pom/pom/middle?originalUrl=' ||
									URL_ENCODE('http://pom.crccre.cn/pom/pom/mission-center-feedback/my-responsible-task?cancelType=0' || CHR(38) || 'id=' || M_PLANID || CHR(38) || 'feedbackNodeId=' || M_NODEID ||
														 CHR(38) || 'feedbackNodeOriginalId=' || ORIGINALNODEID || CHR(38) || 'nodeSourcePlanType=1') "url",
								 --url �� String  Ӧ��ϵͳ��url��ַ
								 '��' "mobileUrl",
								 --mobileUrl  �� String  Ӧ��ϵͳ���ֻ���url��ַ
								 '' || P.CHARGE_PERSON || '���ã�' || M_USER || '�������������' || M_NODENAME || '�������˴߰�' "taskname",
								 --taskname �� String  �������ƣ�����3���������/4����������informationname;���ڲ����ע��attentionname
								 '�ƻ���Ӫ' "typename",
								 --typename �� String  ��������
								 PLANTYPE "remark",
								 --remark �� String  ��ע

								 ----------------------------------------------
								 -----������ע�����С�
								 TO_CHAR(SYSDATE,'yyyy-MM-dd HH:mm:ss')  "expiretime",
								 --expiretime  �� String  ����ʱ�䣬��ʽyyyy-MM-dd HH:mm:ss-----����ʱ�䣬����ע����
								 1 "priority" --priority �� Integer ���ȼ�������ע����
								FROM   POM_NODE_CHARGE_PERSON P
								LEFT   JOIN SYS_USER U
								ON     P.CHARGE_PERSON_ID = U.ID
								WHERE  NODE_ID = M_NODEID;
				END;
		END IF;

END;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_URGED_MSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_URGED_MSG" (
    bizid      IN         VARCHAR2,--���������ҵ��id
    biztype    IN         VARCHAR2,--ҵ�����ͣ�1:�ؼ��ڵ�ƻ��ڵ㣬2����Ŀ����ƻ��ڵ㣬3��ר��ƻ��ڵ㣬4���¶ȼƻ��ڵ�
    urgedmsg   OUT        SYS_REFCURSOR--0������Ϣ
) IS
--����߰찴ť����ȡ��Ϣ��Ϣ
--���ߣ�����
--���ڣ�2019/11/17
    testmsg    NVARCHAR2(4000);
BEGIN
    BEGIN
        OPEN urgedmsg FOR SELECT
                              sysdate||'id' AS "msgGroupId",
                              '��Ϣ����' || sysdate AS "msgDescription",
                              '1' AS "RecipientId",
                              bizid AS "bizKey",
                              'v-xufeng' AS "senderId",
                              biztype AS "bizSourceCategory",
                              '�߰���Ϣ' AS "bizMsgCategory",
                              'Ԥ��' AS "systemId",
                              '111' AS "wechatJumplinkUrl"
                          FROM
                              dual;

    EXCEPTION
        WHEN OTHERS THEN
            testmsg := sqlerrm;
    END;
END p_pom_urged_msg;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_VERIFY_ATTR_AREA_USE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_VERIFY_ATTR_AREA_USE" (
    attrid     IN         VARCHAR2_LIST,--�����������λ����ȼ�id����
    attrtype   IN         INT,--0��λ����ȼ�,10��Ŀ��������,20��Ӫ����
    message    OUT        VARCHAR2,--��ʾ��Ϣ
    isuse      OUT        INT--0δʹ�ã�1��ʹ��
) IS
--��֤ҵ̬�Ƿ�ʹ��
--���ߣ�����
--���ڣ�2019/11/17
BEGIN
    BEGIN
        isuse := 0;
        message := '��֤ͨ��';
    --�鿴�Ƿ���ָ���ʹ��---�ȵ������ڵ���
--        SELECT
--            COUNT(attribute_area_level_id)
--        INTO isuse
--        FROM
--            mdm_obj_phase_area_level
--        WHERE
--            attribute_area_level_id = ''
--                                      || attributeid
--                                      || '';
        IF isuse > 0 THEN
            raise_application_error(-20000, '�����ѱ�ʹ�ò�����ɾ��');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            isuse := 1;
            message := '��֤ʧ�ܣ�' || sqlerrm;
    END;
END p_pom_verify_attr_area_use;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_VERIFY_BUILDING_USE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_VERIFY_BUILDING_USE" 
(
		BUILDINGID IN VARCHAR2
	 , --���������¥��id
		MESSAGE    OUT VARCHAR2
	 , --��ʾ��Ϣ
		ISUSE      OUT INT --0δʹ�ã�1��ʹ��
) IS
		--��֤¥���Ƿ�ʹ��
		--���ߣ�����
		--���ڣ�2019/11/17
BEGIN
		BEGIN
				ISUSE := 0;
				--�鿴�����Ƿ���ָ���ʹ��
				SELECT COUNT(BUILD_ID)
				INTO   ISUSE
				FROM   MDM_BUILD_PHASE
				WHERE  BUILD_ID = '' || BUILDINGID || '';
				IF LENGTH(ISUSE) > 0 THEN
						RAISE_APPLICATION_ERROR(-20000, '¥���Ѵ���ָ�����ݲ�����ɾ��');
				END IF;
		EXCEPTION
				WHEN OTHERS THEN
						ISUSE   := 1;
						MESSAGE := '��֤ʧ�ܣ�' || SQLERRM;
		END;
END P_POM_VERIFY_BUILDING_USE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_VERIFY_PERIOD_USE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_VERIFY_PERIOD_USE" (
    periodoriginalid   IN                 VARCHAR2,--�������������ԭʼid
    message            OUT                VARCHAR2,--��ʾ��Ϣ
    isuse              OUT                INT--0δʹ�ã�1��ʹ��
) IS
--��֤�����Ƿ�ʹ��
--���ߣ�����
--���ڣ�2019/11/17
BEGIN
    BEGIN
        isuse := 0;
    --�鿴�����Ƿ���ָ���ʹ��
        SELECT
            COUNT(period_id)
        INTO isuse
        FROM
            mdm_period_phase
        WHERE
            period_id = ''
                        || periodoriginalid
                        || '';
        IF isuse > 0 THEN
            raise_application_error(-20000, '�����Ѵ���ָ�����ݲ�����ɾ��');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            isuse := 1;
            message := '��֤ʧ�ܣ�' || sqlerrm;
    END;
END p_pom_verify_period_use;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_VERIFY_PRODUCT_TYPE_USE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_VERIFY_PRODUCT_TYPE_USE" (
    ptid   IN           VARCHAR2,--���������ҵ̬id��������ŷָ���
    message      OUT          VARCHAR2,--��ʾ��Ϣ
    isuse        OUT          INT--0δʹ�ã�1��ʹ��
) IS
--��֤ҵ̬�Ƿ�ʹ��
--���ߣ�����
--���ڣ�2019/11/17
BEGIN
  BEGIN
        isuse := 0;
    --�鿴�����Ƿ���ָ���ʹ��
        SELECT
            COUNT(PRODUCT_TYPE_ID)
        INTO isuse
        FROM
            MDM_OBJ_PHASE_PT_INDEX
        WHERE
            PRODUCT_TYPE_ID = ''
                        || ptid
                        || '';
        IF isuse > 0 THEN
            raise_application_error(-20000, 'ҵ���ѱ�ʹ�ò�����ɾ��');
        END IF;
        message := '��֤ͨ��';
    EXCEPTION
        WHEN OTHERS THEN
            isuse := 1;
            message := '��֤ʧ�ܣ�'||isuse || sqlerrm;
    END;
END p_pom_verify_product_type_use;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_MAIN_LIGHT_UP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_MAIN_LIGHT_UP" (
    companyId    IN           VARCHAR2,--��˾id
    info    OUT          SYS_REFCURSOR --������Ϣ
) AS  
--��Ŀ����ƻ����-���Ƽ���
--���ߣ�����
--�޸ģ����ϲ�ѯSYS_ROLE_USER_RELATION_RESULT���ѯ����Ŀ�ƻ�רԱ  ByYedr 20200309
--���ڣ�2019/12/07
BEGIN
    OPEN info FOR                    
    SELECT DISTINCT   B1.*,B1.TOTALNODECOUNT AS "totalNodeCount"  ,'��Ŀ�ƻ�רԱ:'|| CASE WHEN C1.USER_NAME is null then '��' else to_char(C1.USER_NAME) end AS "projectPlanManager"  
		FROM SYS_BUSINESS_UNIT A1  LEFT JOIN(
SELECT  D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%�޷���%' THEN '_'||C.STAGE_NAME ELSE NULL END    AS "projectName"
,A.ID AS "planId"
,D.ID  as  "PROJECT_ID"
,A.COMPANY_ID
,COUNT(B.ID)  AS  "TOTALNODECOUNT"
,SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)  AS "actualEndNodeCount" 
,ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4) AS "completeRate"
--�����˵������ֹ��ǰ��ɽڵ�����/��ֹ��ǰӦ�����������    ���ƹ���˵����1���̵ƣ�����ʡ�95% 2���Ƶƣ�95%>����ʡ�90% 3����ƣ�����ʣ�90%
,
case when COUNT(B.ID)>0 then 
CASE WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=95 THEN 3 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=90 then 2 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100 <90 then 1
      ELSE 1 
  END else 1 END  AS "completeStatus"
    ,SUM( CASE WHEN  B.NODE_LEVEL='��̱�'    AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END) 
    +SUM( CASE WHEN  B.NODE_LEVEL='һ���ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END) 
    +SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END) 
    +SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END) 
  --  +SUM( CASE WHEN  B.NODE_LEVEL='�ļ��ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END) 

AS "overDueNotCompletedCount"

,SUM( CASE WHEN  B.NODE_LEVEL='��̱�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END)  AS "milestoneNotCompleteCount" 
,SUM( CASE WHEN  B.NODE_LEVEL='һ���ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END)  AS "oneNodeNotCompleteCount" 
,SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END)  AS "twoNodeNotCompleteCount" 
,SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NULL AND  TRUNC(  B.PLAN_END_DATE)  < TRUNC( SYSDATE) THEN 1 ELSE 0 END)  AS "threeNodeNotCompleteCount" 
--������20200330�޸��ų���������
, case when SUM( CASE WHEN  B.NODE_LEVEL='��̱�'  THEN 1 ELSE 0 END)>0 then  ROUND(SUM( CASE WHEN  B.NODE_LEVEL='��̱�'  AND  B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) /SUM( CASE WHEN  B.NODE_LEVEL='��̱�'  THEN 1 ELSE 0 END),2)  else 1 end  AS "milestoneNotCompletePercent" 
,case when SUM( CASE WHEN  B.NODE_LEVEL='һ���ڵ�'  THEN 1 ELSE 0 END)>0 then ROUND(SUM( CASE WHEN  B.NODE_LEVEL='һ���ڵ�'  AND  B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) /SUM( CASE WHEN  B.NODE_LEVEL='һ���ڵ�'  THEN 1 ELSE 0 END),2)  else 1 end  AS "oneNodeNotCompletePercent" 
,case when SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  THEN 1 ELSE 0 END)>0 then ROUND(SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) /SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  THEN 1 ELSE 0 END),2) else 1  end   AS "twoNodeNotCompletePercent" 
,case when SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  THEN 1 ELSE 0 END)>0 then ROUND(SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  AND  B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) /SUM( CASE WHEN  B.NODE_LEVEL='�����ڵ�'  THEN 1 ELSE 0 END),2) else 1 end   AS "threeNodeNotCompletePercent" 

FROM POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE B ON A.ID=B.PROJ_PLAN_ID
LEFT  JOIN SYS_PROJECT_STAGE C ON C.ID=PROJ_ID
INNER JOIN SYS_PROJECT D ON (D.ID=C.PROJECT_ID or PROJ_ID=d.id) 
WHERE     A.PLAN_TYPE='��Ŀ����ƻ�' AND A.APPROVAL_STATUS='�����' AND B.IS_DISABLE=0  AND B.PLAN_END_DATE<=SYSDATE
 AND  A.PLAN_VERSION IN ( SELECT MAX(PLAN_VERSION) FROM POM_PROJ_PLAN A1 WHERE  A1.PROJ_ID=A.PROJ_ID AND A1.APPROVAL_STATUS='�����' )
GROUP BY D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%�޷���%' THEN '_'||C.STAGE_NAME ELSE NULL END,A.COMPANY_ID,A.ID,D.ID )
B1 ON B1.COMPANY_ID=A1.ID 
LEFT JOIN(SELECT wm_concat(USER_NAME) AS USER_NAME,PROJECT_ID FROM SYS_ROLE_USER_RELATION_RESULT WHERE ROLE_CODE='pom_project_plan_manager' GROUP BY PROJECT_ID) C1 ON C1.PROJECT_ID=B1.PROJECT_ID
WHERE  NVL(B1.TOTALNODECOUNT,0)>0 AND  CONNECT_BY_ROOT ID =''||companyId||''
CONNECT  by PRIOR   A1.ID= A1.PARENT_ID ;
END p_pom_w_proj_main_light_up;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_MAIN_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_MAIN_TREE" (
    USERID VARCHAR2,
    STATIONID VARCHAR2,
    DEPTID VARCHAR2,
    COMPANYID VARCHAR2,
    info OUT SYS_REFCURSOR
)IS
    v_sql clob;
    --��ǰ����
    nowdate date:=trunc(sysdate);
    BIZCODE VARCHAR2(200):='POM.JHJKYKHPH.01';
    DATA_AUTH_SPID VARCHAR2(200);
BEGIN
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
    OPEN info FOR                    
      WITH
     ��Ŀor���� as (
    SELECT DISTINCT   B1.*
		FROM SYS_BUSINESS_UNIT A1  LEFT JOIN(
SELECT  D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%�޷���%' THEN '_'||C.STAGE_NAME ELSE NULL END    AS "projectName"
,A.ID AS "planId"
,D.ID  as  "PROJECT_ID"
,A.COMPANY_ID
,COUNT(B.ID)  AS  "TOTALNODECOUNT"
,ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4) AS "completeRate"
--�����˵������ֹ��ǰ��ɽڵ�����/��ֹ��ǰӦ�����������    ���ƹ���˵����1���̵ƣ�����ʡ�95% 2���Ƶƣ�95%>����ʡ�90% 3����ƣ�����ʣ�90%
,
case when COUNT(B.ID)>0 then 
CASE WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=95 THEN 3 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=90 then 2 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100 <90 then 1
      ELSE 1 
  END else 1 END  AS "completeStatus"
FROM POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE B ON A.ID=B.PROJ_PLAN_ID
LEFT  JOIN SYS_PROJECT_STAGE C ON C.ID=PROJ_ID
INNER JOIN SYS_PROJECT D ON (D.ID=C.PROJECT_ID or PROJ_ID=d.id) 
WHERE     A.PLAN_TYPE='��Ŀ����ƻ�' AND A.APPROVAL_STATUS='�����' AND B.IS_DISABLE=0  AND B.PLAN_END_DATE<=SYSDATE
AND  A.PLAN_VERSION IN ( SELECT MAX(PLAN_VERSION) FROM POM_PROJ_PLAN A1 WHERE  A1.PROJ_ID=A.PROJ_ID AND A1.APPROVAL_STATUS='�����' )
GROUP BY D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%�޷���%' THEN '_'||C.STAGE_NAME ELSE NULL END,A.COMPANY_ID,A.ID,D.ID )
B1 ON B1.COMPANY_ID=A1.ID 
LEFT JOIN(SELECT wm_concat(USER_NAME) AS USER_NAME,PROJECT_ID FROM SYS_ROLE_USER_RELATION_RESULT WHERE ROLE_CODE='pom_project_plan_manager' GROUP BY PROJECT_ID) C1 ON C1.PROJECT_ID=B1.PROJECT_ID
WHERE  NVL(B1.TOTALNODECOUNT,0)>0 AND  CONNECT_BY_ROOT ID ='003200000000000000000000000000'

CONNECT  by PRIOR   A1.ID= A1.PARENT_ID)

 ,ƴ����Ŀ��˾�� as(
   SELECT DISTINCT
   org_id       AS "orgId",
   org_name     AS "orgName",
   0 as  "orgType",
   parent_id    AS "parentId",
   1 as "isCompany"
   ,order_code as "orderCode"
   ,0 as "red"
    ,0 as "yellow"
    ,0 as "green"

                           FROM
                               tmp_company_tree
                           WHERE
                               id = DATA_AUTH_SPID
                               AND org_id IN (
                                   SELECT DISTINCT
                                       id
                                   FROM
                                       sys_business_unit
                                   START WITH
                                       id IN (
                                           SELECT
                                               id
                                           FROM
                                               (
                                                   SELECT
                                                       unit_id AS id
                                                   FROM
                                                       sys_project
                                                   UNION
                                                   SELECT
                                                       subordinate_company_id AS id
                                                   FROM
                                                       cdb_feasible_project_config
                                               ) ds
                                       )
                                   CONNECT BY
                                       PRIOR parent_id = id
                               )

   union all
    select    "planId"       AS "orgId",
   "projectName"     AS "orgName",
   0 as  "orgType",
   COMPANY_ID    AS "parentId",
   0 as "isCompany"
   ,'0' "orderCode"
   ,case when "completeStatus"=1 then 1 else 0 end as "red"
   ,case when "completeStatus"=2 then 1 else 0 end as "yellow"
   ,case when "completeStatus"=3 then 1 else 0 end as "green"  FROM ��Ŀor����)

   ,���� as(select
    "orgId",
    "orgName",
    "orgType",
    "parentId",
   "isCompany",
   "orderCode"
--,�̵�,�Ƶ�,���
,(select sum("red") from ƴ����Ŀ��˾�� start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "red"
,(select sum("yellow") from ƴ����Ŀ��˾�� start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "yellow"
,(select sum("green") from ƴ����Ŀ��˾�� start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "green"
 from ƴ����Ŀ��˾�� s)

   select  *
   from ����   where "isCompany"=1

   order by LPAD("orderCode",10,'0')
   ;

END p_pom_w_proj_main_tree;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_PLAN_CHART
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_PLAN_CHART" (
   userid                 IN                     VARCHAR2,--�û�id
    planid                 IN                     VARCHAR2,--�ƻ�id
    completion_level_rate_title   OUT                    VARCHAR2,---һ�������񼶱�ͳ������� (%)--����
    completion_level_rate  out SYS_REFCURSOR,---һ�������񼶱�ͳ������� (%)
    completion_dept_rate_title   OUT                    VARCHAR2,--- ������ִ�в���ͳ������� (%) --����
    completion_dept_rate  out SYS_REFCURSOR---������ִ�в���ͳ������� (%)
) AS
--��Ŀ����ƻ���أ�����ҳ ��ͼ��
--���ߣ��������壬��С��ʵ��  
--���ڣ�2020/02/26
  v_timeout_count VARCHAR2(20):='';
  v_expect_timeout_count VARCHAR2(20):='';
BEGIN
completion_level_rate_title:='һ�������񼶱�ͳ������� (%)';
completion_dept_rate_title:='������ִ�в���ͳ������� (%)';

    OPEN Completion_level_rate FOR
--      SELECT  '��̱�' as "nodeName",1 as "percentage" from dual
--      UNION all 
--      SELECT  'һ���ڵ�' as "nodeName",1 as "percentage" from dual
--     UNION all 
--      SELECT  '�����ڵ�' as "nodeName",1 as "percentage" from dual;
		SELECT   NODE_LEVEL  as "nodeName",	ROUND(SUM( CASE WHEN   B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) /COUNT(b.id),2)  AS "percentage" 
			FROM POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE B ON A.ID=B.PROJ_PLAN_ID
			INNER JOIN SYS_PROJECT_STAGE C ON C.ID=PROJ_ID
			INNER JOIN SYS_PROJECT D ON D.ID=C.PROJECT_ID
			WHERE     A.PLAN_TYPE='��Ŀ����ƻ�' AND A.APPROVAL_STATUS='�����' AND B.IS_DISABLE=0  AND B.PLAN_END_DATE<=SYSDATE and  a.id=''||planid||''
			GROUP BY NODE_LEVEL    ORDER BY   CASE  WHEN   NODE_LEVEL='��̱�' THEN  0 WHEN   NODE_LEVEL='һ���ڵ�' THEN  1 WHEN   NODE_LEVEL='�����ڵ�' THEN  3   WHEN   NODE_LEVEL='�����ڵ�' THEN  4  WHEN   NODE_LEVEL='�ļ��ڵ�' THEN  5 else 6 END asc;

	 OPEN completion_dept_rate FOR	 

SELECT ��B.DUTY_DEPARTMENT as "department"  , TO_CHAR( ROUND ( SUM(CASE WHEN B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END )/COUNT(B.ID),2)) AS "percentage" 
FROM  POM_PROJ_PLAN A  INNER JOIN POM_PROJ_PLAN_NODE B ON A.id=b.PROJ_PLAN_ID
where A.PLAN_TYPE='��Ŀ����ƻ�' AND A.APPROVAL_STATUS='�����'  AND B.IS_DISABLE=0  AND A.ID=''||planId||''
GROUP BY   B.DUTY_DEPARTMENT_ID,B.DUTY_DEPARTMENT
ORDER BY 2 desc;

END p_pom_w_proj_plan_chart;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_PLAN_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_PLAN_DEPT" (planId in varchar2,wacthinfo OUT sys_refcursor)
AS
--��Ŀ����ƻ���أ���������ͼ
--���ߣ�����
--���ڣ�2019/11/13
BEGIN
open wacthinfo for

SELECT ��B.DUTY_DEPARTMENT as "department"  , TO_CHAR( ROUND ( SUM(CASE WHEN B.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END )/COUNT(B.ID),2)) AS "percentage" 
FROM  POM_PROJ_PLAN A  INNER JOIN POM_PROJ_PLAN_NODE B ON A.id=b.PROJ_PLAN_ID
where A.PLAN_TYPE='��Ŀ����ƻ�' AND A.APPROVAL_STATUS='�����'  AND B.IS_DISABLE=0  AND A.ID=''||planId||''
GROUP BY   B.DUTY_DEPARTMENT_ID,B.DUTY_DEPARTMENT
ORDER BY 2 desc
;
 
 
END p_pom_w_proj_plan_dept;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_PLAN_DTL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_PLAN_DTL" (
    userid                 IN                     VARCHAR2,--�û�id
    planid                 IN                     VARCHAR2,--�ƻ�id
    pandect_info           out SYS_REFCURSOR      --�ƻ���ϸһ����
) AS
--��Ŀ����ƻ���أ�����ҳ ����ϸһ����
--���ߣ�����
--�޸��ߣ�л�ɺ�
--�޸�ʱ�䣺2020/05/08 
--���5��ʱ��ת��Ϊ�ַ������ѯ���ֶΣ������ֶ�ȥ��ʱ���ʽ
--���ڣ�2020/02/26
BEGIN
----�ƻ���ϸһ����
    OPEN pandect_info FOR
        SELECT
    proj_id,
    proj_name,
    proj_plan_id,
    node_id,
    plan_id,
    plan_type,
    original_node_id,
    warning_status,
    node_code,
    node_name,
    node_level,
    duty_department,
    duty_department_id,
    duty_mans,
    finish_status,
    standard_score,
    to_char(a.PLAN_START_DATE, 'YYYY-mm-dd') as plan_start_date,
    to_char(a.PLAN_END_DATE, 'YYYY-mm-dd') as  plan_end_date,
    to_char(a.ACTUAL_START_DATE, 'YYYY-mm-dd')  as actual_start_date,
    to_char(a.ACTUAL_END_DATE, 'YYYY-mm-dd') as actual_end_date,
    to_char(a.ESTIMATE_END_DATE, 'YYYY-mm-dd') as estimate_end_date,
    process_feed_back_con,
    finish_feed_back_con,
    overdue_feed_back_con,
     nvl(b.IS_UN_WATCH,1) as  IS_UN_WATCH
         ,to_char(a.PLAN_START_DATE, 'YYYY-mm-dd') as "PLAN_START_TIME"
         ,to_char(a.PLAN_END_DATE, 'YYYY-mm-dd') as "PLAN_END_TIME"
         ,to_char(a.ACTUAL_START_DATE, 'YYYY-mm-dd') as "ACTUAL_START_TIME"
         ,to_char(a.ACTUAL_END_DATE, 'YYYY-mm-dd') as "ACTUAL_END_TIME"
         ,to_char(a.ESTIMATE_END_DATE, 'YYYY-mm-dd') as "ESTIMATE_END_TIME"
          ,b.UN_WATCH_TIME  ,b.WATCH_TIME , 
    node_flag,
    estimate_beyond_node_flag,
    completion_standard,
    completion_results_remark
      FROM  V_POM_PROJ_MONITOR_SUMMARYLIST  a    
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID=''||userid||'' --and   b.WATCH_TIME is  not   null
      WHERE     a.PLAN_ID=''||planid||'' ORDER BY NODE_CODE asc ;
END p_pom_w_proj_plan_dtl;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_W_PROJ_PLAN_OVERDUE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_W_PROJ_PLAN_OVERDUE" (
    userid                 IN                     VARCHAR2,--�û�id
    planid                 IN                     VARCHAR2,--�ƻ�id
    timeout_info           OUT                    SYS_REFCURSOR,--��������δ������� 
    timeout_title          OUT                    VARCHAR2,--���� ����δ������񣺹�0��
    expect_timeout_info    OUT                    SYS_REFCURSOR,--�ġ�Ԥ�Ƴ������� 
    expect_timeout_title   OUT                    VARCHAR2--����Ԥ�Ƴ������񣺹�0��
) AS
--��Ŀ����ƻ���أ�����ҳ ������δ�������,Ԥ�Ƴ�������
--���ߣ��������壬��С��ʵ��
--�޸ģ����ϲ�ѯSYS_ROLE_USER_RELATION_RESULT���ѯ����Ŀ�ƻ�רԱ  ByYedr 20200309
--���ڣ�2020/02/26
  v_timeout_count VARCHAR2(20):='';
  v_expect_timeout_count VARCHAR2(20):='';
  planning_specialist VARCHAR2(20):='';
BEGIN
   EXECUTE IMMEDIATE  
    'SELECT role.USER_NAME FROM POM_PROJ_PLAN plan LEFT JOIN SYS_PROJECT_STAGE stage ON plan.PROJ_ID=stage.ID
    LEFT JOIN SYS_PROJECT proj ON proj.ID=stage.PROJECT_ID
    LEFT JOIN (SELECT wm_concat(USER_NAME) AS USER_NAME,PROJECT_ID FROM SYS_ROLE_USER_RELATION_RESULT WHERE ROLE_CODE=''pom_project_plan_manager'' GROUP BY PROJECT_ID) role ON role.PROJECT_ID=stage.PROJECT_ID WHERE plan.ID='''||planid||'''' into planning_specialist;

    IF to_char(planning_specialist) is null then
        planning_specialist:='��';
    END IF;


 OPEN timeout_info FOR
      SELECT   a.*,nvl(b.IS_UN_WATCH,1)  as  IS_UN_WATCH ,b.UN_WATCH_TIME  ,b.WATCH_TIME  
      FROM  v_pom_proj_monitor_node_list  a    
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID=''||userid||'' --and   b.WATCH_TIME is  not   null
      WHERE     a.PLAN_ID=''||planid||''
      AND  TRUNC( a.PLAN_END_DATE)-TRUNC(SYSDATE)<0  and  a.ACTUAL_END_DATE  is null   ;
 OPEN expect_timeout_info FOR 
          SELECT   a.*,nvl(b.IS_UN_WATCH,1)  as  IS_UN_WATCH ,b.UN_WATCH_TIME  ,b.WATCH_TIME  
      FROM  v_pom_proj_monitor_node_list  a    
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID=''||userid||'' 
      WHERE     a.PLAN_ID=''||planid||''
      AND   TRUNC( a.ESTIMATE_END_DATE)-TRUNC(SYSDATE)<0   and  a.ACTUAL_END_DATE  is null  
			and  TRUNC( a.PLAN_END_DATE)-TRUNC(SYSDATE)>=0;


SELECT  (SELECT  TO_CHAR(COUNT(NODE_ID))        FROM  v_pom_proj_monitor_node_list  a    
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID=''||userid||'' 
      WHERE     a.PLAN_ID=''||planid||''
      AND  TRUNC( PLAN_END_DATE)-TRUNC(SYSDATE)<0  and  ACTUAL_END_DATE  is null   )  
INTO v_timeout_count  FROM  DUAL;
SELECT  (SELECT  TO_CHAR(COUNT(NODE_ID))        FROM  v_pom_proj_monitor_node_list  a    
      LEFT   JOIN SYS_BIZ_WATCH b   ON     a.NODE_ID = b.BIZ_ID  and   b.WATCHER_ID=''||userid||'' 
      WHERE     a.PLAN_ID=''||planid||''
      AND   TRUNC( ESTIMATE_END_DATE)-TRUNC(SYSDATE)<0  and  ACTUAL_END_DATE  is null 	and  TRUNC( PLAN_END_DATE)-TRUNC(SYSDATE)>=0 ) 
		
INTO v_expect_timeout_count  FROM  DUAL;
    timeout_title := '����δ������񣺹�'||v_timeout_count||'��       (��Ŀ�ƻ�רԱ��'||planning_specialist||')';
    expect_timeout_title := 'Ԥ�Ƴ������񣺹�'||v_expect_timeout_count||'��';



END p_pom_w_proj_plan_overdue;
--==========================��Ŀ����ƻ���ؽ����ƻ�רԱ===================


--==========================��������--�ؼ��ڵ�ƻ�����====================

/
--------------------------------------------------------
--  DDL for Procedure P_POM_WARNING_MSG_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_WARNING_MSG_LIST" ( isread IN VARCHAR2, --0��δ��1���Ѷ�
    userid IN VARCHAR2,--��ǰ�û�ID
    items OUT SYS_REFCURSOR,    
    total OUT INT ,--��ϸ��Ϣ
    pageindex     IN            INT,
    pagesizes     IN            INT
  )IS--Ԥ����Ϣ̨��
--���ߣ�Ҷ����
--���ڣ�2019/12/18
--���ڣ�2020/01/13 ���ľ��޸�
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
BEGIN
    v_sql :='SELECT
      node.ID,
      ROWNUM as rowno,
      node.DUTY_DEPARTMENT AS DEPARTMENT,--����
      node.NODE_LEVEL AS NODE_LEVEL,--���񼶱�
      node.STANDARD_SCORE,--��׼��ֵ
      to_char(node.PLAN_START_DATE,''yyyy-mm-dd'')   AS PLAN_BEGIN_TIME,--�ƻ���ʼʱ��
      to_char(node.PLAN_END_DATE,''yyyy-mm-dd'') AS PLAN_END_TIME,--�ƻ�����ʱ��
      to_char(msg.ACTUAL_CREATED,''yyyy-mm-dd'')  AS WARNING_TIME,--Ԥ��ʱ��
      msg.pc_url AS URL, --��תURL
      msg.TASK_NAME AS WARNING_INFO,--Ԥ����Ϣ
    CASE
        WHEN node.PLAN_END_DATE - SYSDATE < 0 THEN
        ''<i style="margin-left:0.6cm;width:20px;height:20px;border-radius:50%;background-color:red;display: block"></i>''
        WHEN node.PLAN_END_DATE - SYSDATE > 0 THEN
      ''<i style="margin-left:0.6cm;width:20px;height:20px;border-radius:50%;background-color:green;display: block"></i>''
    END AS WARNING_STATUS,
    msg.biz_msg_category as WARNING_TYPE
    FROM
      POM_PROJ_PLAN_NODE node
      left JOIN SYS_MESSAGE_CENTER msg ON msg.TASK_ID = node.ID
      left JOIN SYS_USER u ON msg.owner_name=u.user_code
      where msg.TASK_ID = node.ID AND u.ID='''||userid||'''
      AND (msg.biz_msg_category=''������Ϣ'' OR msg.biz_msg_category=''Ԥ����Ϣ'')';

    IF(isread='�Ѷ���Ϣ') THEN
      v_sql_exec :=v_sql ||'  and  msg.TASK_STATE = 10 ';

    ELSE 
      v_sql_exec :=v_sql ||' and  msg.TASK_STATE = 0 ';  

    END IF;

      v_sql_exec_paging :='select a.* from ( '|| v_sql_exec|| ' and ROWNUM <= '|| pageindex * pagesizes|| ' ) a where a.rowno >= '|| pagesizes * ( pageindex - 1 )|| '';


        dbms_output.put_line(v_sql_exec);
       ----��ȡ������
        EXECUTE IMMEDIATE 'SELECT count(ROWNUM) from('
                          || v_sql_exec
                          || ') a' 
                          INTO total;

        OPEN items FOR v_sql_exec_paging;

END p_pom_warning_msg_list;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_WARNING_RULES_MSG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_WARNING_RULES_MSG" 
(
		RULEID IN VARCHAR2 --�������������id
	 ,INFO   OUT SYS_REFCURSOR --��Ϣ����
) IS
		--Ԥ����Ϣ���򣬻�ȡ������Ϣ����
		--���ߣ�����
		--���ڣ�2020/01/08
BEGIN
		OPEN info FOR SELECT
            ------------------------------------------------------------����������Ϣ
              '71313f018a35f3a558166cba7599b5d6' AS "systemId",--ϵͳid
              'ce475375-7627-40b0-b77f-2d9bbaf98a7c' AS "appid",--Ӧ��id������ϵͳid ����SYS_APPLICATION ��ѯ appid�ֶΣ�
            ------------------------------------------------------------ҵ��䶯������Ϣ
              'bizid' AS "bizKey",--ҵ��id
               'tjWeChat,tjSMS' AS "msgChannel",--ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
            ------------------------------------------------------------���ű������
              '400013' AS "smsTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã������������{2}���ѳ���{3}�죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
              '["����","Ԥ�����֤","5","��������"]' AS "smsParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��˵��{1}Ϊ���ĵ�¼��֤�룬����{2}��������д����Ǳ��˲���������Ա����š�
              '13896186104' as "mobile",--���Ž����˵绰
            ------------------------------------------------------------΢�ű������
              '400013' AS "wechatTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
              '["����","Ԥ�����֤","5","��������"]' AS "wechatParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��˵��{1}Ϊ���ĵ�¼��֤�룬����{2}��������д����Ǳ��˲���������Ա����š�
               '///' AS "wechatJumplinkUrl",--΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
              'v-xufeng' AS "recipientAccount",--������usercode�磺a-xiexuhua
            ------------------------------------------------------------��Ϣ��¼��׷����Ϣ
              '�����¶ȼƻ�����Ԥ��' AS "title",--��Ϣ����
              'v-xufeng' AS "senderAccount",--������usercode�磺a-xiexuhua
              '�¶ȼƻ�' AS "bizSourceCategory",--ҵ���������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһ������кܶ������ҵ�����¶ȼƻ���
              'Ԥ����Ϣ' AS "bizMsgCategory"--��Ϣ�������=�� ����ҵ��ϵͳ�Զ��壬�������ҵ����ݣ�ͬһҵ���������ж�����࣬��Ԥ����Ϣ��������Ϣ��
          FROM
              dual;

END P_POM_WARNING_RULES_MSG;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_AUTH_DATA_RULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_AUTH_DATA_RULE" ( USERID IN VARCHAR2, STATIONID IN VARCHAR2, DEPTID IN VARCHAR2, COMPANYID IN VARCHAR2, BIZCODE IN VARCHAR2 ,
DATA_AUTH_INFO OUT sys_refcursor) 
AS
--���ݼ�Ȩ����������Ȩ������Ȩ�޵���Ŀ���ţ������Ǹ������
--���ߣ��ȹ���
--���ڣ�2019/12/13
AUTHCOUNT INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
SPID VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN

select get_uuid() into SPID from dual;


--����������Ȩ�����ݣ�

        DECLARE
                OWNERID  VARCHAR2(36);
                OENERTYPE NVARCHAR2(50);
                CURSOR cursor_company IS
                select distinct auth_owner_id,auth_owner_type from SYS_DATA_AUTH where auth_biz_code=BIZCODE and is_disabled=0;

            BEGIN   

            --���α�
                OPEN cursor_company;
                loop
                    fetch cursor_company into OWNERID,OENERTYPE;
                    exit when cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                if OENERTYPE='��˾' or OENERTYPE='����'
                then
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                     SELECT count(*) into AUTHCOUNT FROM sys_business_unit where is_company=1 and id=COMPANYID
                    START WITH ID=OWNERID CONNECT BY PRIOR  ID=parent_id;
                    if AUTHCOUNT<>0
                    then
                        insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);

                    end if;

                end if;

                 if OENERTYPE='����'
                then
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                     SELECT count(*) into AUTHCOUNT FROM sys_business_unit where is_company=0 and id=DEPTID
                    START WITH ID=OWNERID CONNECT BY PRIOR  ID=parent_id;
                    if AUTHCOUNT<>0
                    then
                        insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);

                    end if;

                end if;

                 if (OENERTYPE='��λ' and OWNERID=STATIONID) or (OENERTYPE='��Ա' and OWNERID=USERID)
                then

                       insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);    
                end if;

                end loop;

                close cursor_company;

            END;   


          --��ȡ��Ȩ�޵Ĺ�˾���䲿�ţ�            
                DECLARE
                        OWNERID2  VARCHAR2(36);
                        CURSOR cursor_auth IS
                        select distinct auth_owner_id from TMP_AUTH_OWNER where ID=SPID;

                    BEGIN   

                    --���α�
                        OPEN cursor_auth;
                        loop
                            fetch cursor_auth into OWNERID2;
                            exit when cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                            insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,ID FROM
                            sys_business_unit where is_company=0
                                START WITH ID in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='����'
                                )  CONNECT BY PRIOR  ID=parent_id;


                         insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,org_id FROM
                            v_sys_project where org_type<>0
                                START WITH org_id in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='��Ŀ'
                                )  CONNECT BY PRIOR  org_id=parent_id;

                           --���������Ŀ     
                          insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,id FROM
                            CDB_FEASIBLE_PROJECT_CONFIG 
                            where subordinate_company_id in
                                (select id from sys_business_unit where is_company=1 START WITH id in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='��Ŀ'
                                )  CONNECT BY PRIOR  id=parent_id);       

                             --��Ȩ����Ϊ���ţ�
                               --ȡ��Ȩ���ż����Ӽ���

                                 insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,ID FROM
                            sys_business_unit where is_company=0
                                START WITH ID in  (select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type='����' and auth_type='����'
                                )  CONNECT BY PRIOR  ID=parent_id;

                               --��Ȩ����Ϊ��Ŀ�� 
                            insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,org_id FROM
                            v_sys_project where org_type<>0 and project_id in 
                                 (select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type='��Ŀ' and auth_type='��Ŀ'
                                );   

                              end loop;
                           close  cursor_auth;    
                        end;

    --2020/2/20:�ɱ����ݿ���Ҫ������
    --����������-��Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from sys_project a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='ȫ����')
    on 1=1;
    --����������-������Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from CDB_FEASIBLE_PROJECT_CONFIG a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='ȫ����')
    on 1=1;
    --����������-��Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from sys_project a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='����˾')
    on 1=1 where a.unit_id=COMPANYID;
    --����������-������Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from CDB_FEASIBLE_PROJECT_CONFIG a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='����˾')
    on 1=1 where a.subordinate_company_id=COMPANYID;



 open DATA_AUTH_INFO for
select distinct ORG_ID as orgId
from TMP_AUTH_LIST WHERE ID=SPID;

END P_SYS_AUTH_DATA_RULE;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_AUTH_DATA_RULE_SPID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_AUTH_DATA_RULE_SPID" ( USERID IN VARCHAR2, STATIONID IN VARCHAR2, DEPTID IN VARCHAR2, COMPANYID IN VARCHAR2, BIZCODE IN VARCHAR2 ,
DATA_AUTH_SPID OUT VARCHAR2) 
AS
--���ݼ�Ȩ����������Ȩ������Ȩ�޵���Ŀ���ţ������Ǹ������
--���ߣ��ȹ���
--���ڣ�2019/12/13
AUTHCOUNT INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
SPID VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
select get_uuid() into SPID from dual;
------------------------------------------------------��ʼ-----------------------------------------------���ź���Ŀ ���ƹȸ��Ȩ�洢���� 
--����������Ȩ�����ݣ�

        DECLARE
                OWNERID  VARCHAR2(36);
                OENERTYPE NVARCHAR2(50);
                CURSOR cursor_company IS
                select distinct auth_owner_id,auth_owner_type from SYS_DATA_AUTH where auth_biz_code=BIZCODE and is_disabled=0;

            BEGIN   

            --���α�
                OPEN cursor_company;
                loop
                    fetch cursor_company into OWNERID,OENERTYPE;
                    exit when cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                if OENERTYPE='��˾' or OENERTYPE='����'
                then
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                     SELECT count(*) into AUTHCOUNT FROM sys_business_unit where is_company=1 and id=COMPANYID
                    START WITH ID=OWNERID CONNECT BY PRIOR  ID=parent_id;
                    if AUTHCOUNT<>0
                    then
                        insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);

                    end if;

                end if;

                 if OENERTYPE='����'
                then
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                     SELECT count(*) into AUTHCOUNT FROM sys_business_unit where is_company=0 and id=DEPTID
                    START WITH ID=OWNERID CONNECT BY PRIOR  ID=parent_id;
                    if AUTHCOUNT<>0
                    then
                        insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);

                    end if;

                end if;

                 if (OENERTYPE='��λ' and OWNERID=STATIONID) or (OENERTYPE='��Ա' and OWNERID=USERID)
                then

                       insert into TMP_AUTH_OWNER(ID,auth_owner_id,auth_owner_type)
                        values(SPID,OWNERID,OENERTYPE);    
                end if;

                end loop;

                close cursor_company;

            END;   


          --��ȡ��Ȩ�޵Ĺ�˾���䲿�ţ�            
                DECLARE
                        OWNERID2  VARCHAR2(36);
                        CURSOR cursor_auth IS
                        select distinct auth_owner_id from TMP_AUTH_OWNER where ID=SPID;

                    BEGIN   

                    --���α�
                        OPEN cursor_auth;
                        loop
                            fetch cursor_auth into OWNERID2;
                            exit when cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                            insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,ID FROM
                            sys_business_unit where is_company=0
                                START WITH ID in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='����'
                                )  CONNECT BY PRIOR  ID=parent_id;


                         insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,org_id FROM
                            v_sys_project where org_type<>0
                                START WITH org_id in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='��Ŀ'
                                )  CONNECT BY PRIOR  org_id=parent_id;

                           --���������Ŀ     
                          insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,id FROM
                            CDB_FEASIBLE_PROJECT_CONFIG 
                            where subordinate_company_id in
                                (select id from sys_business_unit where is_company=1 START WITH id in (
                                select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type in ('��˾','����') and auth_type='��Ŀ'
                                )  CONNECT BY PRIOR  id=parent_id);       

                             --��Ȩ����Ϊ���ţ�
                               --ȡ��Ȩ���ż����Ӽ���

                                 insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,ID FROM
                            sys_business_unit where is_company=0
                                START WITH ID in  (select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type='����' and auth_type='����'
                                )  CONNECT BY PRIOR  ID=parent_id;

                               --��Ȩ����Ϊ��Ŀ�� 
                            insert into TMP_AUTH_LIST(ID,ORG_ID)
                            select SPID,org_id FROM
                            v_sys_project where org_type<>0 and project_id in 
                                 (select distinct auth_scope_id from SYS_DATA_AUTH where auth_biz_code=BIZCODE 
                                 and is_disabled=0 and auth_owner_id=OWNERID2 and auth_scope_type='��Ŀ' and auth_type='��Ŀ'
                                );   

                              end loop;
                           close  cursor_auth;    
                        end;

    --2020/2/20:�ɱ����ݿ���Ҫ������
    --����������-��Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from sys_project a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='ȫ����')
    on 1=1;
    --����������-������Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from CDB_FEASIBLE_PROJECT_CONFIG a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='ȫ����')
    on 1=1;
    --����������-��Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from sys_project a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='����˾')
    on 1=1 where a.unit_id=COMPANYID;
    --����������-������Ŀ��
    insert into TMP_AUTH_LIST(ID,ORG_ID)
    select SPID,id from CDB_FEASIBLE_PROJECT_CONFIG a inner join (
    select ISOLATION_RULE_VALUE from SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE=BIZCODE and ISOLATION_RULE_VALUE='����˾')
    on 1=1 where a.subordinate_company_id=COMPANYID;
------------------------------------------------------����-----------------------------------------------���ź���Ŀ ���ƹȸ��Ȩ�洢���� 
-------------------------------------------------------��ʼ----------------------------------------------��˾����λ���� chenl
    --����������-��˾����λ����
    insert into TMP_AUTH_LIST(ID,ORG_ID)
  	SELECT SPID,
CASE 
	ISOLATION_RULE_VALUE 
	WHEN '����˾' THEN COMPANYID
	WHEN '������' THEN DEPTID
	WHEN '����λ' THEN STATIONID
	WHEN '����' THEN USERID
	ELSE ''
END AS AUTH_SCOPE_ID
FROM SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE = BIZCODE and ISOLATION_RULE_VALUE in ('����˾','������','����λ','����');


 DATA_AUTH_SPID:=SPID;
-- open DATA_AUTH_INFO for
--select distinct ORG_ID as orgId
--from TMP_AUTH_LIST WHERE ID=SPID;

END P_SYS_AUTH_DATA_RULE_SPID;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_AUTH_ISOLATION_RULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_AUTH_ISOLATION_RULE" 
(
		USER_ID        IN VARCHAR2
	 ,STATION_ID     IN VARCHAR2
	 ,DEPT_ID        IN VARCHAR2
	 ,COMPANY_ID     IN VARCHAR2
	 ,BIZ_CODE       IN VARCHAR2
	 ,DATA_AUTH_INFO OUT SYS_REFCURSOR
) AS
		--��������Ȩ
		--���ߣ����
		--���ڣ�2019/12/14
BEGIN
		OPEN DATA_AUTH_INFO FOR
				SELECT CASE ISOLATION_RULE_VALUE
										WHEN 'ȫ����' THEN
										 '003200000000000000000000000000'
										WHEN '����˾' THEN
										 COMPANY_ID
										WHEN '������' THEN
										 DEPT_ID
										WHEN '����λ' THEN
										 STATION_ID
										WHEN '����λ' THEN
										 USER_ID
										ELSE
										 ''
								END AS AUTH_SCOPE_ID,
							 SUBSTR(ISOLATION_RULE_VALUE, 2, LENGTH(ISOLATION_RULE_VALUE)) AS AUTH_SCOPE_TYPE
				FROM   SYS_DATA_AUTH_BIZ
				WHERE  BIZ_OBJ_CODE = BIZ_CODE;
END;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_DATA_AUTH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_DATA_AUTH" ( USER_ID IN VARCHAR2, STATION_ID IN VARCHAR2, DEPT_ID IN VARCHAR2, COMPANY_ID IN VARCHAR2, BIZ_CODE IN VARCHAR2 ,
  DATA_AUTH_INFO OUT sys_refcursor) 
AS
--���ݼ�Ȩ����������Ȩ�޺͸������ļ�Ȩ��
--���ߣ����
--���ڣ�2019/11/17
BEGIN
 open DATA_AUTH_INFO for
--����Ȩ��
SELECT
	AUTH_SCOPE_ID,
	AUTH_SCOPE_TYPE,
	'����Ȩ��' AS Auth_TYPE 
FROM
	SYS_DATA_AUTH 
WHERE
    IS_DISABLED = 0
    AND auth_biz_code = BIZ_CODE
		AND ( AUTH_OWNER_ID = USER_ID OR AUTH_OWNER_ID = STATION_ID OR AUTH_OWNER_ID = DEPT_ID OR AUTH_OWNER_ID = COMPANY_ID )
	UNION all 
--�������
	SELECT
CASE
	ISOLATION_RULE_VALUE 
	WHEN 'ȫ����' THEN '003200000000000000000000000000'
	WHEN '����˾' THEN COMPANY_ID
	WHEN '������' THEN DEPT_ID
	WHEN '����λ' THEN STATION_ID
	else USER_ID
END AS AUTH_SCOPE_ID,
	SUBSTR( ISOLATION_RULE_VALUE, 2, length( ISOLATION_RULE_VALUE )) AS AUTH_SCOPE_TYPE,
	'�������' AS Auth_TYPE 
FROM SYS_DATA_AUTH_BIZ where BIZ_OBJ_CODE = BIZ_CODE;
END P_SYS_DATA_AUTH;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_COMPANY_PROJ_SPID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_COMPANY_PROJ_SPID" 
(
		USERID         IN VARCHAR2
	 ,STATIONID      IN VARCHAR2
	 ,DEPTID         IN VARCHAR2
	 ,COMPANYID      IN VARCHAR2
	 ,BIZCODE        IN VARCHAR2
	 ,DATA_AUTH_SPID OUT VARCHAR2
) AS
		--��ȡ����Ŀ�Ĺ�˾��
		--���ߣ��ȹ���
		--���ڣ�2019/12/13
		RULEVALUE VARCHAR2(50);
		AUTHCOUNT INT; --�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
		SPID      VARCHAR2(36); --ʹ����ʱ������κ�
BEGIN

		SELECT GET_UUID() INTO SPID FROM DUAL;
		--���뼯����Ϊ���ڵ�
		INSERT INTO TMP_COMPANY_TREE
				(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY, ORDER_CODE)
				SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
							 ORDER_CODE
				FROM   SYS_BUSINESS_UNIT
				WHERE  ID = '003200000000000000000000000000';

		--��ȡ�������
		SELECT ISOLATION_RULE_VALUE
		INTO   RULEVALUE
		FROM   SYS_DATA_AUTH_BIZ
		WHERE  BIZ_OBJ_CODE = BIZCODE;
		IF RULEVALUE = 'ȫ����' THEN
				INSERT INTO TMP_COMPANY_TREE
						(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
						 ORDER_CODE)
						SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
									 ORDER_CODE
						FROM   SYS_BUSINESS_UNIT
						WHERE  IS_COMPANY = 1;
		ELSE
				--���뱾��˾���丸��
				INSERT INTO TMP_COMPANY_TREE
						(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
						 ORDER_CODE)
						SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
									 ORDER_CODE
						FROM   SYS_BUSINESS_UNIT
						WHERE  IS_COMPANY = 1
						START  WITH ID = COMPANYID
						CONNECT BY PRIOR PARENT_ID = ID;

				--����������Ȩ�����ݣ�

				DECLARE
						OWNERID   VARCHAR2(36);
						OENERTYPE NVARCHAR2(50);
						CURSOR CURSOR_COMPANY IS
								SELECT DISTINCT AUTH_OWNER_ID, AUTH_OWNER_TYPE
								FROM   SYS_DATA_AUTH
								WHERE  AUTH_BIZ_CODE = BIZCODE AND
											 IS_DISABLED = 0;

				BEGIN

						--���α�
						OPEN CURSOR_COMPANY;
						LOOP
								FETCH CURSOR_COMPANY
										INTO OWNERID, OENERTYPE;
								EXIT WHEN CURSOR_COMPANY%NOTFOUND;

								--���˵�ǰ�û���Ȩ�޵���Ȩ����
								IF OENERTYPE = '��˾' OR OENERTYPE = '����' THEN
										--AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
										SELECT COUNT(*)
										INTO   AUTHCOUNT
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 1 AND
													 ID = COMPANYID
										START  WITH ID = OWNERID
										CONNECT BY PRIOR ID = PARENT_ID;
										IF AUTHCOUNT <> 0 THEN
												INSERT INTO TMP_AUTH_OWNER
														(ID, AUTH_OWNER_ID, AUTH_OWNER_TYPE)
												VALUES
														(SPID, OWNERID, OENERTYPE);

										END IF;

								END IF;

								IF OENERTYPE = '����' THEN
										--AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
										SELECT COUNT(*)
										INTO   AUTHCOUNT
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 0 AND
													 ID = DEPTID
										START  WITH ID = OWNERID
										CONNECT BY PRIOR ID = PARENT_ID;
										IF AUTHCOUNT <> 0 THEN
												INSERT INTO TMP_AUTH_OWNER
														(ID, AUTH_OWNER_ID, AUTH_OWNER_TYPE)
												VALUES
														(SPID, OWNERID, OENERTYPE);

										END IF;

								END IF;

								IF (OENERTYPE = '��λ' AND OWNERID = STATIONID) OR
									 (OENERTYPE = '��Ա' AND OWNERID = USERID) THEN

										INSERT INTO TMP_AUTH_OWNER
												(ID, AUTH_OWNER_ID, AUTH_OWNER_TYPE)
										VALUES
												(SPID, OWNERID, OENERTYPE);
								END IF;

						END LOOP;

						CLOSE CURSOR_COMPANY;

				END;

				--��ȡ��Ȩ�޵Ĺ�˾���丸����            
				DECLARE
						OWNERID2 VARCHAR2(36);
						CURSOR CURSOR_AUTH IS
								SELECT AUTH_OWNER_ID FROM TMP_AUTH_OWNER WHERE ID = SPID;

				BEGIN

						--���α�
						OPEN CURSOR_AUTH;
						LOOP
								FETCH CURSOR_AUTH
										INTO OWNERID2;
								EXIT WHEN CURSOR_AUTH%NOTFOUND;

								--��Ȩ����Ϊ��˾��
								--ȡ��Ȩ��˾���Ӽ���
								INSERT INTO TMP_COMPANY_TREE
										(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
										 ORDER_CODE)
										SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID,
													 IS_COMPANY, ORDER_CODE
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 1
										START  WITH ID IN
																(SELECT DISTINCT AUTH_SCOPE_ID
																 FROM   SYS_DATA_AUTH
																 WHERE  AUTH_BIZ_CODE = BIZCODE AND
																				IS_DISABLED = 0 AND
																				AUTH_OWNER_ID = OWNERID2 AND
																				AUTH_SCOPE_TYPE IN ('��˾', '����'))
										CONNECT BY PRIOR ID = PARENT_ID;

								--ȡ��Ȩ��˾�ĸ�����
								INSERT INTO TMP_COMPANY_TREE
										(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
										 ORDER_CODE)
										SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID,
													 IS_COMPANY, ORDER_CODE
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 1
										START  WITH ID IN
																(SELECT DISTINCT AUTH_SCOPE_ID
																 FROM   SYS_DATA_AUTH
																 WHERE  AUTH_BIZ_CODE = BIZCODE AND
																				IS_DISABLED = 0 AND
																				AUTH_OWNER_ID = OWNERID2 AND
																				AUTH_SCOPE_TYPE IN ('��˾', '����'))
										CONNECT BY PRIOR PARENT_ID = ID;

								--��Ȩ��ӦΪ���ţ�
								--ȡ��Ȩ���ŵĸ�����

								INSERT INTO TMP_COMPANY_TREE
										(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
										 ORDER_CODE)
										SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID,
													 IS_COMPANY, ORDER_CODE
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 1
										START  WITH ID IN (SELECT DISTINCT AUTH_SCOPE_ID
																			 FROM   SYS_DATA_AUTH
																			 WHERE  AUTH_BIZ_CODE = BIZCODE AND
																							IS_DISABLED = 0 AND
																							AUTH_OWNER_ID = OWNERID2 AND
																							AUTH_SCOPE_TYPE = '����')
										CONNECT BY PRIOR PARENT_ID = ID;
								--��Ȩ��ӦΪ��Ŀ��

								INSERT INTO TMP_COMPANY_TREE
										(ID, ORG_ID, ORG_NAME, ORG_TYPE, PARENT_ID, IS_COMPANY,
										 ORDER_CODE)
										SELECT SPID, ID, ORG_NAME, ORG_TYPE, PARENT_ID,
													 IS_COMPANY, ORDER_CODE
										FROM   SYS_BUSINESS_UNIT
										WHERE  IS_COMPANY = 1
										START  WITH ID IN
																(SELECT UNIT_ID
																 FROM   SYS_PROJECT
																 WHERE  ID IN
																				(SELECT DISTINCT AUTH_SCOPE_ID
																				 FROM   SYS_DATA_AUTH
																				 WHERE  AUTH_BIZ_CODE = BIZCODE AND
																								IS_DISABLED = 0 AND
																								AUTH_OWNER_ID = OWNERID2 AND
																								AUTH_SCOPE_TYPE = '��Ŀ'))
										CONNECT BY PRIOR PARENT_ID = ID;

						END LOOP;
						CLOSE CURSOR_AUTH;
				END;

		END IF;
DATA_AUTH_SPID:=SPID;
--		OPEN DATA_AUTH_INFO FOR
--				SELECT DISTINCT ORG_ID AS ORGID, ORG_NAME AS ORGNAME,
--												ORG_TYPE AS ORGTYPE, PARENT_ID AS PARENTID,
--												1 AS ISCOMPANY, ORDER_CODE AS ORDERCODE
--				FROM   TMP_COMPANY_TREE
--				WHERE  ID = SPID AND
--							 ORG_ID IN (SELECT DISTINCT ID
--													FROM   SYS_BUSINESS_UNIT
--													START  WITH ID IN
--																			(SELECT ID
--																			 FROM   (SELECT UNIT_ID AS ID
--																								FROM   SYS_PROJECT
--																								UNION
--																								SELECT SUBORDINATE_COMPANY_ID AS ID
--																								FROM   CDB_FEASIBLE_PROJECT_CONFIG) DS)
--													CONNECT BY PRIOR PARENT_ID = ID)
--				ORDER  BY TO_NUMBER(ORDER_CODE);

END P_SYS_GET_COMPANY_PROJ_SPID;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_COMPANY_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_COMPANY_TREE" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ��˾��
--���ߣ��ȹ���
--���ڣ�2019/12/13
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;
--���뼯����Ϊ���ڵ�

    INSERT INTO tmp_company_tree (
        id,
        org_id,
        org_name,
        org_type,
        parent_id,
        is_company,
        order_code
    )
        SELECT
            spid,
            id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_hierarchy_code
        FROM
            sys_business_unit
        WHERE
            id = '003200000000000000000000000000';

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1;

    ELSE 
--���뱾��˾���丸��
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1
            START WITH
                id = companyid
            CONNECT BY
                PRIOR parent_id = id;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0;

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR id = parent_id;


                            --ȡ��Ȩ��˾�ĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

                             --��Ȩ��ӦΪ���ţ�
                               --ȡ��Ȩ���ŵĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '����'
                        )
                    CONNECT BY
                        PRIOR parent_id = id;
                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT
                                unit_id
                            FROM
                                sys_project
                            WHERE
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        --20200516 chenl ��֯��Ȩ������Ŀ��Χ��Ȩ��������Ŀ auth_scope_type ��һ�α������"����"�����ݸ�������
                                        AND (auth_scope_type = '��Ŀ' or auth_type='��Ŀ')
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

            END LOOP;

            CLOSE cursor_auth;
        END;

    END IF;

    OPEN data_auth_info FOR SELECT DISTINCT
                               org_id       AS orgid,
                               org_name     AS orgname,
                               org_type     AS orgtype,
                               parent_id    AS parentid,
                               is_company   AS iscompany,
                               order_code   AS ordercode
                           FROM
                               tmp_company_tree
                           WHERE
                               id = spid
                           ORDER BY
                               order_code;

END p_sys_get_company_tree;

---------------------------------chenl ����---------1389 [20200511-20200515]-16:�û�ֻ��Ȩ����ĿȨ�ޣ���ѡ����Ŀʱ������ѡ��˾��������Ŀ�޷�ѡ��

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_COMPANY_TREE_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_COMPANY_TREE_PROJ" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ����Ŀ�Ĺ�˾��
--���ߣ��ȹ���
--���ڣ�2019/12/13
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;
--���뼯����Ϊ���ڵ�

    INSERT INTO tmp_company_tree (
        id,
        org_id,
        org_name,
        org_type,
        parent_id,
        is_company,
        order_code
    )
        SELECT
            spid,
            id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_hierarchy_code
        FROM
            sys_business_unit
        WHERE
            id = '003200000000000000000000000000';

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1;

    ELSE 
--���뱾��˾���丸��
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1
            START WITH
                id = companyid
            CONNECT BY
                PRIOR parent_id = id;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0;

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR id = parent_id;


                            --ȡ��Ȩ��˾�ĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

                             --��Ȩ��ӦΪ���ţ�
                               --ȡ��Ȩ���ŵĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '����'
                        )
                    CONNECT BY
                        PRIOR parent_id = id;
                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT
                                unit_id
                            FROM
                                sys_project
                            WHERE
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        --20200516 chenl ��֯��Ȩ������Ŀ��Χ��Ȩ��������Ŀ auth_scope_type ��һ�α������"����"�����ݸ�������
                                        AND (auth_scope_type = '��Ŀ' or auth_type='��Ŀ')
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

            END LOOP;

            CLOSE cursor_auth;
        END;

    END IF;

    OPEN data_auth_info FOR SELECT DISTINCT
                               org_id       AS orgid,
                               org_name     AS orgname,
                               org_type     AS orgtype,
                               parent_id    AS parentid,
                               1 AS iscompany,
                               order_code   AS ordercode
                           FROM
                               tmp_company_tree
                           WHERE
                               id = spid
                               AND org_id IN (
                                   SELECT DISTINCT
                                       id
                                   FROM
                                       sys_business_unit
                                   START WITH
                                       id IN (
                                           SELECT
                                               id
                                           FROM
                                               (
                                                   SELECT
                                                       unit_id AS id
                                                   FROM
                                                       sys_project
                                                   UNION
                                                   SELECT
                                                       subordinate_company_id AS id
                                                   FROM
                                                       cdb_feasible_project_config
                                               ) ds
                                       )
                                   CONNECT BY
                                       PRIOR parent_id = id
                               )
                           ORDER BY
                               order_code;

END p_sys_get_company_tree_proj;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_COMPANY_TREE_SPID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_COMPANY_TREE_SPID" ( USERID IN VARCHAR2, STATIONID IN VARCHAR2, DEPTID IN VARCHAR2, COMPANYID IN VARCHAR2, BIZCODE IN VARCHAR2 ,
DATA_AUTH_SPID OUT varchar2) 
AS
--��ȡ��˾��
--���ߣ��ȹ���
--���ڣ�2019/12/13
RULEVALUE varchar2(50);
AUTHCOUNT INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
SPID VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
   SELECT
        get_uuid()
    INTO spid
    FROM
        dual;
--���뼯����Ϊ���ڵ�

    INSERT INTO tmp_company_tree (
        id,
        org_id,
        org_name,
        org_type,
        parent_id,
        is_company,
        order_code
    )
        SELECT
            spid,
            id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_hierarchy_code
        FROM
            sys_business_unit
        WHERE
            id = '003200000000000000000000000000';

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1;

    ELSE 
--���뱾��˾���丸��
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                is_company,
                order_hierarchy_code
            FROM
                sys_business_unit
            WHERE
                is_company = 1
            START WITH
                id = companyid
            CONNECT BY
                PRIOR parent_id = id;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0;

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR id = parent_id;


                            --ȡ��Ȩ��˾�ĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type IN (
                                    '��˾',
                                    '����'
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

                             --��Ȩ��ӦΪ���ţ�
                               --ȡ��Ȩ���ŵĸ�����

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '����'
                        )
                    CONNECT BY
                        PRIOR parent_id = id;
                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                    START WITH
                        id IN (
                            SELECT
                                unit_id
                            FROM
                                sys_project
                            WHERE
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        AND auth_scope_type = '��Ŀ'
                                )
                        )
                    CONNECT BY
                        PRIOR parent_id = id;

            END LOOP;

            CLOSE cursor_auth;
        END;

    END IF;
DATA_AUTH_SPID:=spid;
--    OPEN data_auth_info FOR SELECT DISTINCT
--                               org_id       AS orgid,
--                               org_name     AS orgname,
--                               org_type     AS orgtype,
--                               parent_id    AS parentid,
--                               is_company   AS iscompany,
--                               order_code   AS ordercode
--                           FROM
--                               tmp_company_tree
--                           WHERE
--                               id = spid
--                           ORDER BY
--                               order_code;

END P_SYS_GET_COMPANY_TREE_SPID;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_DPT_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_DPT_TREE" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ��Ȩ�޵Ĺ�˾������
--���ߣ��ȹ���
--���ڣ�2019/12/13
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;

--IS_COMPANY������洢�����е���Ϊ�ж��Ƿ���Ȩ��ʹ�ã��籾����ʱ�����ܿ��������ŵ����ݡ�
--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_company_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            is_company,
            order_code
        )
            SELECT
                spid,
                id,
                org_name,
                org_type,
                parent_id,
                0,
                order_hierarchy_code
            FROM
                sys_business_unit;

    ELSE
        BEGIN
            IF rulevalue = '����˾' THEN
--���뱾��˾���䲿��
                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        0,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    START WITH
                        id = companyid
                    CONNECT BY PRIOR id = parent_id
                               AND is_company = 0;

            ELSE  
--���뱾��˾����ǰ����
                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        0,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    WHERE
                        id = companyid;

                INSERT INTO tmp_company_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    is_company,
                    order_code
                )
                    SELECT
                        spid,
                        id,
                        org_name,
                        org_type,
                        parent_id,
                        CASE
                            WHEN id = deptid THEN
                                0
                            ELSE
                                1
                        END AS is_company,
                        order_hierarchy_code
                    FROM
                        sys_business_unit
                    START WITH
                        id = deptid
                    CONNECT BY PRIOR parent_id = id
                               AND is_company = 0;

            END IF;   
--����������Ȩ�����ݣ�

            DECLARE
                ownerid     VARCHAR2(36);
                oenertype   NVARCHAR2(50);
                CURSOR cursor_company IS
                SELECT DISTINCT
                    auth_owner_id,
                    auth_owner_type
                FROM
                    sys_data_auth
                WHERE
                    auth_biz_code = bizcode
                    AND is_disabled = 0
                    AND auth_type = '����';

            BEGIN   

            --���α�
                OPEN cursor_company;
                LOOP
                    FETCH cursor_company INTO
                        ownerid,
                        oenertype;
                    EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                    IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                        SELECT
                            COUNT(*)
                        INTO authcount
                        FROM
                            sys_business_unit
                        WHERE
                            is_company = 1
                            AND id = companyid
                        START WITH
                            id = ownerid
                        CONNECT BY
                            PRIOR id = parent_id;

                        IF authcount <> 0 THEN
                            INSERT INTO tmp_auth_owner (
                                id,
                                auth_owner_id,
                                auth_owner_type
                            ) VALUES (
                                spid,
                                ownerid,
                                oenertype
                            );

                        END IF;

                    END IF;

                    IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                        SELECT
                            COUNT(*)
                        INTO authcount
                        FROM
                            sys_business_unit
                        WHERE
                            is_company = 0
                            AND id = deptid
                        START WITH
                            id = ownerid
                        CONNECT BY
                            PRIOR id = parent_id;

                        IF authcount <> 0 THEN
                            INSERT INTO tmp_auth_owner (
                                id,
                                auth_owner_id,
                                auth_owner_type
                            ) VALUES (
                                spid,
                                ownerid,
                                oenertype
                            );

                        END IF;

                    END IF;

                    IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END LOOP;

                CLOSE cursor_company;
            END;   

          --��ȡ��Ȩ�޵Ĺ�˾���䲿�ţ�            

            DECLARE
                ownerid2 VARCHAR2(36);
                CURSOR cursor_auth IS
                SELECT
                    auth_owner_id
                FROM
                    tmp_auth_owner
                WHERE
                    id = spid;

            BEGIN   

                    --���α�
                OPEN cursor_auth;
                LOOP
                    FETCH cursor_auth INTO ownerid2;
                    EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                    INSERT INTO tmp_company_tree (
                        id,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_code
                    )
                        SELECT
                            spid,
                            id,
                            org_name,
                            org_type,
                            parent_id,
                            0,
                            order_hierarchy_code
                        FROM
                            sys_business_unit
                        START WITH
                            id IN (
                                SELECT DISTINCT
                                    auth_scope_id
                                FROM
                                    sys_data_auth
                                WHERE
                                    auth_biz_code = bizcode
                                    AND is_disabled = 0
                                    AND auth_owner_id = ownerid2
                                    AND auth_scope_type IN (
                                        '��˾',
                                        '����'
                                    )
                                    AND auth_type = '����'
                            )
                        CONNECT BY
                            PRIOR id = parent_id;


                             --��Ȩ����Ϊ���ţ�
                               --ȡ��Ȩ���ż����Ӽ���

                    INSERT INTO tmp_company_tree (
                        id,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        is_company,
                        order_code
                    )
                        SELECT
                            spid,
                            id,
                            org_name,
                            org_type,
                            parent_id,
                            0,
                            order_hierarchy_code
                        FROM
                            sys_business_unit
                        START WITH
                            id IN (
                                SELECT DISTINCT
                                    auth_scope_id
                                FROM
                                    sys_data_auth
                                WHERE
                                    auth_biz_code = bizcode
                                    AND is_disabled = 0
                                    AND auth_owner_id = ownerid2
                                    AND auth_scope_type = '����'
                                    AND auth_type = '����'
                            )
                        CONNECT BY
                            PRIOR id = parent_id;

                END LOOP;

                CLOSE cursor_auth;
            END;

        END;
    END IF;

    OPEN data_auth_info FOR SELECT DISTINCT
                               org_id       AS orgid,
                               org_name     AS orgname,
                               org_type     AS orgtype,
                               parent_id    AS parentid,
                               is_company   AS isdisable,
                               CASE
                                   WHEN org_type = 0 THEN
                                       1
                                   ELSE
                                       0
                               END AS iscompany,
                               order_code   AS ordercode
                           FROM
                               tmp_company_tree
                           WHERE
                               id = spid
                           ORDER BY
                               order_code;

END p_sys_get_dpt_tree;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_HAS_PROJ_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_HAS_PROJ_TREE" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
    --��ȡ��Ȩ�޵Ĺ�˾��
    --���ߣ�������
    --���ڣ�2020��5��9��
    ruleValue   VARCHAR2(50);
    ruleOrgId        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT isolation_rule_value INTO rulevalue FROM sys_data_auth_biz WHERE biz_obj_code = bizcode;
    if ruleValue = 'ȫ����' then
        ruleOrgId := '003200000000000000000000000000';
    end if;
    if ruleValue = '����˾' then
        ruleOrgId := companyId;
    end if;
    if ruleValue = '������' then
        ruleOrgId := deptid;
    end if;
    open data_auth_info for with t1 as (
        -- ��ȡ����Ȩ�޹�˾id
        select *
        from SYS_DATA_AUTH sda
        where instr(userId||','|| stationId || ',' || deptId || ',' || companyId, sda.AUTH_OWNER_ID) > 0
          and nvl(sda.AUTH_TYPE, '��Ŀ') = '��Ŀ' and sda.AUTH_BIZ_CODE=bizCode
    ), t2 as (
        -- ���ϸ������id
        select AUTH_SCOPE_ID from t1
        union
        select ruleOrgId from dual
    ), t3 as (
        -- ��ѯ��˾�����������ӹ�˾
        select distinct *
        from SYS_BUSINESS_UNIT sbu
        where IS_COMPANY = 1
        start with sbu.id in (select AUTH_SCOPE_ID from t2)
        connect by prior sbu.id = sbu.PARENT_ID
    ), t4 as (
        --��ѯ��Ŀ��Ϊ�յĹ�˾ID
        select  distinct mp.id mid, mp.PROJECT_NAME, mp.UNIT_ID mParentId,
            nvl(mp.ORDER_HIERARCHY_CODE, mp.PROJECT_CODE)  as pCode,
            t3.*
        from t3 left join SYS_PROJECT mp on t3.ID = mp.UNIT_ID
        where mp.ID is not null
    ) select
            distinct ID orgId,
            ORG_NAME orgName,
            ORG_TYPE orgType,
            PARENT_ID parentId,
            IS_COMPANY isCompany,
            ORDER_HIERARCHY_CODE || '' orderCode
    from SYS_BUSINESS_UNIT sbu
    start with sbu.ID in (select ID from t4)
    connect by prior sbu.PARENT_ID = sbu.ID
    union
    select
        t4.mid orgId,
        t4.PROJECT_NAME orgName,
        '10' orgType,
        t4.mParentId parentId,
        0 isCompany,
        nvl(pCode, '0') orderCode
    from t4;
END P_SYS_GET_HAS_PROJ_TREE;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_ISOLATION_ID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_ISOLATION_ID" 
(
		USER_ID           IN VARCHAR2
	 ,STATION_ID        IN VARCHAR2
	 ,DEPT_ID           IN VARCHAR2
	 ,COMPANY_ID        IN VARCHAR2
	 ,BIZ_CODE          IN VARCHAR2
	 ,OUT_AUTH_SCOPE_ID OUT VARCHAR2
) AS
		--��������Ȩ
		--���ߣ����
		--���ڣ�2019/12/14
BEGIN

		SELECT AUTH_SCOPE_ID
		INTO   OUT_AUTH_SCOPE_ID
		FROM   (SELECT CASE ISOLATION_RULE_VALUE
												 WHEN 'ȫ����' THEN
													'����'
												 WHEN '����˾' THEN
													COMPANY_ID
												 WHEN '������' THEN
													DEPT_ID
												 WHEN '����λ' THEN
													STATION_ID
												 WHEN '����λ' THEN
													USER_ID
												 ELSE
													''
										 END AS AUTH_SCOPE_ID
						 FROM   SYS_DATA_AUTH_BIZ
						 WHERE  BIZ_OBJ_CODE = BIZ_CODE);

END;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_PROJ_STAGE_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_PROJ_STAGE_TREE" (
     userid           IN               VARCHAR2,
     stationid        IN               VARCHAR2,
     deptid           IN               VARCHAR2,
     companyid        IN               VARCHAR2,
     bizcode          IN               VARCHAR2,
     data_auth_info   OUT              SYS_REFCURSOR
 ) AS
 --��ȡ��Ȩ�޵���Ŀ��
 --���ߣ�л�ɺ�
 --���ڣ�2020/04/10
     rulevalue   VARCHAR2(50);
     authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
     spid        VARCHAR2(36);--ʹ����ʱ������κ�
 BEGIN
     SELECT
         get_uuid()
     INTO spid
     FROM
         dual;

 --��ȡ�������

     SELECT
         isolation_rule_value
     INTO rulevalue
     FROM
         sys_data_auth_biz
     WHERE
             biz_obj_code = bizcode;

     IF rulevalue = 'ȫ����' THEN
         INSERT INTO tmp_proj_tree (
             id,
             org_id,
             org_name,
             org_type,
             parent_id,
             full_name,
             is_end,
             city_name,
             company_id,
             order_code
         )
         SELECT
             spid,
             org_id,
             org_name,
             org_type,
             parent_id,
             full_name,
             is_end,
             city_name,
             company_id,
             sn
         FROM
             V_SYS_PROJECT_STAGE_TREE;

     ELSE
 --���뱾��˾����Ŀ
         INSERT INTO tmp_proj_tree (
             id,
             org_id,
             org_name,
             org_type,
             parent_id,
             full_name,
             is_end,
             city_name,
             company_id,
             order_code
         )
         SELECT
             spid,
             org_id,
             org_name,
             org_type,
             parent_id,
             full_name,
             is_end,
             city_name,
             company_id,
             sn
         FROM
             V_SYS_PROJECT_STAGE_TREE
         WHERE
                 company_id = companyid;

 --����������Ȩ�����ݣ�

         DECLARE
             ownerid     VARCHAR2(36);
             oenertype   NVARCHAR2(50);
             CURSOR cursor_company IS
                 SELECT DISTINCT
                     auth_owner_id,
                     auth_owner_type
                 FROM
                     sys_data_auth
                 WHERE
                         auth_biz_code = bizcode
                   AND is_disabled = 0
                   AND nvl(auth_type, '��Ŀ') = '��Ŀ';

         BEGIN

             --���α�
             OPEN cursor_company;
             LOOP
                 FETCH cursor_company INTO
                     ownerid,
                     oenertype;
                 EXIT WHEN cursor_company%notfound;

                 --���˵�ǰ�û���Ȩ�޵���Ȩ����
                 IF oenertype = '��˾' OR oenertype = '����' THEN
                     --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                     SELECT
                         COUNT(*)
                     INTO authcount
                     FROM
                         sys_business_unit
                     WHERE
                             is_company = 1
                       AND id = companyid
                     START WITH
                             id = ownerid
                     CONNECT BY
                             PRIOR id = parent_id;

                     IF authcount <> 0 THEN
                         INSERT INTO tmp_auth_owner (
                             id,
                             auth_owner_id,
                             auth_owner_type
                         ) VALUES (
                                      spid,
                                      ownerid,
                                      oenertype
                                  );

                     END IF;

                 END IF;

                 IF oenertype = '����' THEN
                     --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                     SELECT
                         COUNT(*)
                     INTO authcount
                     FROM
                         sys_business_unit
                     WHERE
                             is_company = 0
                       AND id = deptid
                     START WITH
                             id = ownerid
                     CONNECT BY
                             PRIOR id = parent_id;

                     IF authcount <> 0 THEN
                         INSERT INTO tmp_auth_owner (
                             id,
                             auth_owner_id,
                             auth_owner_type
                         ) VALUES (
                                      spid,
                                      ownerid,
                                      oenertype
                                  );

                     END IF;

                 END IF;

                 IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                     INSERT INTO tmp_auth_owner (
                         id,
                         auth_owner_id,
                         auth_owner_type
                     ) VALUES (
                                  spid,
                                  ownerid,
                                  oenertype
                              );

                 END IF;

             END LOOP;

             CLOSE cursor_company;
         END;

         --��ȡ��Ȩ�޵Ĺ�˾���丸����            

         DECLARE
             ownerid2 VARCHAR2(36);
             CURSOR cursor_auth IS
                 SELECT
                     auth_owner_id
                 FROM
                     tmp_auth_owner
                 WHERE
                         id = spid;

         BEGIN

             --���α�
             OPEN cursor_auth;
             LOOP
                 FETCH cursor_auth INTO ownerid2;
                 EXIT WHEN cursor_auth%notfound;


                 --��Ȩ����Ϊ��˾��
                 --ȡ��Ȩ��˾���Ӽ���
                 INSERT INTO tmp_proj_tree (
                     id,
                     org_id,
                     org_name,
                     org_type,
                     parent_id,
                     full_name,
                     is_end,
                     city_name,
                     company_id,
                     order_code
                 )
                 SELECT
                     spid,
                     org_id,
                     org_name,
                     org_type,
                     parent_id,
                     full_name,
                     is_end,
                     city_name,
                     company_id,
                     sn
                 FROM
                     V_SYS_PROJECT_STAGE_TREE
                 WHERE
                         company_id IN (
                         SELECT
                             id
                         FROM
                             sys_business_unit
                         WHERE
                                 is_company = 1
                         START WITH
                                 id IN (
                                 SELECT DISTINCT
                                     auth_scope_id
                                 FROM
                                     sys_data_auth
                                 WHERE
                                         auth_biz_code = bizcode
                                   AND is_disabled = 0
                                   AND auth_owner_id = ownerid2
                                   AND auth_scope_type IN (
                                                           '��˾',
                                                           '����'
                                     )
                                   AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                             )
                         CONNECT BY
                                 PRIOR id = parent_id
                     );



                 --��Ȩ��ӦΪ��Ŀ��

                 INSERT INTO tmp_proj_tree (
                     id,
                     org_id,
                     org_name,
                     org_type,
                     parent_id,
                     full_name,
                     is_end,
                     city_name,
                     company_id,
                     order_code
                 )
                 SELECT
                     spid,
                     org_id,
                     org_name,
                     org_type,
                     parent_id,
                     full_name,
                     is_end,
                     city_name,
                     company_id,
                     sn
                 FROM
                     V_SYS_PROJECT_STAGE_TREE
                 WHERE
                         project_id IN (
                         SELECT DISTINCT
                             auth_scope_id
                         FROM
                             sys_data_auth
                         WHERE
                                 auth_biz_code = bizcode
                           AND is_disabled = 0
                           AND auth_owner_id = ownerid2
                           AND auth_scope_type = '��Ŀ'
                           AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                     );

             END LOOP;

             CLOSE cursor_auth;
         END;

     END IF;

     OPEN data_auth_info FOR SELECT DISTINCT
                                 a.org_id         AS orgid,
                                 a.org_name       AS orgname,
                                 a.org_type       AS orgtype,
                                 a.parent_id      AS parentid,
                                 a.full_name      AS fullname,
                                 a.is_end         AS isend,
                                 a.city_name      AS cityname,
                                 a.company_id     AS companyid,
                                 b.company_type   AS companytype,
                                 a.order_code     AS ordercode
                             FROM
                                 tmp_proj_tree       a
                                     LEFT JOIN sys_business_unit   b ON a.org_id = b.id
                             ORDER BY
                                 a.order_code;

 END p_sys_get_proj_stage_tree;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_PROJ_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_PROJ_TREE" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ��Ȩ�޵���Ŀ��
--���ߣ��ȹ���
--���ڣ�2019/12/14
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project;

    ELSE 
--���뱾��˾����Ŀ
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project
            WHERE
                company_id = companyid;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0
                AND nvl(auth_type, '��Ŀ') = '��Ŀ';

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project
                    WHERE
                        company_id IN (
                            SELECT
                                id
                            FROM
                                sys_business_unit
                            WHERE
                                is_company = 1
                            START WITH
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        AND auth_scope_type IN (
                                            '��˾',
                                            '����'
                                        )
                                        AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                                )
                            CONNECT BY
                                PRIOR id = parent_id
                        );



                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project
                    WHERE
                        project_id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '��Ŀ'
                                AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                        );

            END LOOP;

            CLOSE cursor_auth;
        END;

    END IF;

    OPEN data_auth_info FOR SELECT DISTINCT
                               a.org_id         AS orgid,
                               a.org_name       AS orgname,
                               a.org_type       AS orgtype,
                               a.parent_id      AS parentid,
                               a.full_name      AS fullname,
                               a.is_end         AS isend,
                               a.city_name      AS cityname,
                               a.company_id     AS companyid,
                               b.company_type   AS companytype,
                               a.order_code     AS ordercode
                           FROM
                               tmp_proj_tree       a
                               LEFT JOIN sys_business_unit   b ON a.org_id = b.id
                           ORDER BY
                               a.order_code;

END p_sys_get_proj_tree;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_GET_PROJ_TREE_SPID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_GET_PROJ_TREE_SPID" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    auth_spid           OUT           VARCHAR2
) AS
--��ȡ��Ȩ�޵���Ŀ��
--���ߣ��ȹ���
--���ڣ�2019/12/14
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project;

    ELSE 
--���뱾��˾����Ŀ
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project
            WHERE
                company_id = companyid;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0
                AND nvl(auth_type, '��Ŀ') = '��Ŀ';

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project
                    WHERE
                        company_id IN (
                            SELECT
                                id
                            FROM
                                sys_business_unit
                            WHERE
                                is_company = 1
                            START WITH
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        AND auth_scope_type IN (
                                            '��˾',
                                            '����'
                                        )
                                        AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                                )
                            CONNECT BY
                                PRIOR id = parent_id
                        );



                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project
                    WHERE
                        project_id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '��Ŀ'
                                AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                        );

            END LOOP;
            CLOSE cursor_auth;
        END;
    END IF;
--    OPEN data_auth_info FOR SELECT DISTINCT
--                               a.org_id         AS orgid,
--                               a.org_name       AS orgname,
--                               a.org_type       AS orgtype,
--                               a.parent_id      AS parentid,
--                               a.full_name      AS fullname,
--                               a.is_end         AS isend,
--                               a.city_name      AS cityname,
--                               a.company_id     AS companyid,
--                               b.company_type   AS companytype,
--                               a.order_code     AS ordercode
--                           FROM
--                               tmp_proj_tree       a
--                               LEFT JOIN sys_business_unit   b ON a.org_id = b.id
--                           ORDER BY
--                               a.order_code;
        auth_spid:=spid;
END p_sys_get_proj_tree_spid;

/
--------------------------------------------------------
--  DDL for Procedure P_SYS_MSG_BY_TYPE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_MSG_BY_TYPE" ( isMobile in int,msgType IN VARCHAR2,systemId IN VARCHAR2,userName IN VARCHAR2,wherestr  IN VARCHAR2,datalist OUT SYS_REFCURSOR,total out int )
as
rowcountBySystemId  int;
whereSql VARCHAR2(200);
orderSql VARCHAR2(200);
systemWhereSql VARCHAR2(2000);
appid VARCHAR2(1000);
selectSql VARCHAR2(4000);
likeWhereSql  VARCHAR2(1000);
v_sql VARCHAR2(1000);
systemIds VARCHAR2(1000);
BEGIN
likeWhereSql:=' ';
/*�ж��Ƿ���ɸѡ��䣬�����ʽΪ%����%*/
if wherestr is not null then
likeWhereSql:=' and ( task_name like '''||wherestr||''' or  type_name like '''||wherestr||''')';
end if;
/*�ж��Ƿ���ϵͳid����������ϵͳɸѡ*/
if systemId is not null then
   if instr(systemId,',',1,1) !=0 then
         systemIds:=''''||replace(systemId, ',', ''',''')||'''';
         execute immediate ' select count(1) from  SYS_APPLICATION  s where s.id in ('||systemIds||')' INTO  rowcountBySystemId;
          if rowcountBySystemId<>0 THEN
             execute immediate '  select  WMSYS.WM_CONCAT(APP_ID)  from  SYS_APPLICATION  s  where s.id in ('||systemIds||')' INTO  appid;
             appid:=''''||replace(appid, ',', ''',''')||'''';
             systemWhereSql:=' and SOURCE_APP_ID in ('||appid||')';
          end if;
    else
        select count(1) into rowcountBySystemId  from  SYS_APPLICATION  s
        where s.id=systemId;
        if rowcountBySystemId<>0 THEN
        select APP_ID into appid  from  SYS_APPLICATION  s
        where s.id=systemId;
        systemWhereSql:=' and SOURCE_APP_ID= '''||appid||'''';
        end if;
   end if;
end if;
/*���ݴ������Ͳ�ͬչʾ��ͬ��ʱ����*/
if msgType='todo' then
selectSql:=' SELECT
    {url},
   created as startTime,
    task_name as processInstName,
    CREATOR_NAME as partiName,
    remark  as activityInstName,
    type_name as processChName,
    CREATOR_NAME as sender
FROM
    sys_message_center where owner_name=  '''||userName||'''';
whereSql:=' and MSG_TYPE=0 and TASK_STATE=0';
ELSIF  msgType='haveTodo' then
selectSql:=' SELECT
    {url},
    complete_time as startTime,
    task_name as processInstName,
    CREATOR_NAME as partiName,
    remark  as activityInstName,
    type_name as processChName,
    CREATOR_NAME as sender
FROM
    sys_message_center where owner_name=  '''||userName||'''';
whereSql:=' and MSG_TYPE=0 and TASK_STATE=10';
orderSql:=' order by EXPIRE_TIME desc';
ELSIF  msgType='unRead' then
selectSql:=' SELECT
    {url},
    created as startTime,
    task_name as processInstName,
    cuser.user_name as partiName,
    remark  as activityInstName,
    type_name as processChName,
    cuser.user_name as sender
FROM
    sys_message_center 
    left join sys_user cuser 
    on sys_message_center.CREATOR_NAME=cuser.user_code 
    where owner_name=  '''||userName||'''';
whereSql:=' and MSG_TYPE=10 and TASK_STATE=0';
ELSIF  msgType='haveRead' then
selectSql:=' SELECT
    {url},
    complete_time as startTime,
    task_name as processInstName,
    cuser.user_name as partiName,
    remark  as activityInstName,
    type_name as processChName,
    cuser.user_name as sender
FROM
    sys_message_center 
    left join sys_user cuser 
    on sys_message_center.CREATOR_NAME=cuser.user_code 
    where owner_name=  '''||userName||'''';
whereSql:=' and MSG_TYPE=10 and TASK_STATE=10';
else
selectSql:=' SELECT
    {url},
    complete_time as startTime,
    task_name as processInstName,
    cuser.user_name as partiName,
    remark  as activityInstName,
    type_name as processChName,
    cuser.user_name as sender
FROM
    sys_message_center 
    left join sys_user cuser 
    on sys_message_center.CREATOR_NAME=cuser.user_code 
    where owner_name=  '''||userName||'''';
whereSql:=' and MSG_TYPE=20';
end if;
dbms_output.put_line(whereSql);
/*ƴ��sql*/
selectSql:=selectSql||whereSql||systemWhereSql||likeWhereSql;
/*���ݴ����Ƿ�Ϊ�ƶ������򿪲�ͬ�ĵ�ַ*/
if isMobile=1 then
selectSql:=replace(selectSql,'{url}','mobile_url as url');
else
selectSql:=replace(selectSql,'{url}','pc_url as url');
end if;
dbms_output.put_line(selectSql);
  v_sql:= 'select count(*) FROM (' || selectSql || ')';
  EXECUTE IMMEDIATE v_sql INTO total;
OPEN datalist FOR selectSql;
EXCEPTION
WHEN OTHERS THEN
 CLOSE datalist;
end p_sys_msg_by_type;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_COMPONENT_BY_PAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_COMPONENT_BY_PAGE" (containerGuid in varchar,pageComponents OUT sys_refcursor,treeSelect OUT sys_refcursor,tabs OUT sys_refcursor,tableColumn OUT sys_refcursor,buttoneEvent OUT sys_refcursor,eventMonitoring OUT sys_refcursor,datePicker OUT sys_refcursor)
AS  
haspage INTEGER;
BEGIN  
select count(1) into haspage  from UDP_PAGE where ID=containerGuid;
if haspage=1
then
open pageComponents for  
select   c.ID componentId,                                                      --���ID
p.ID containerGuid,                                                                --����ID          
c.COMPONENT_HIGH componentHeight,                          --����߶�
c.COMPONENT_WIDE componentWidth,                            --������
p.TITLE  pageTitle,                                                                    --ҳ�����
p.WINDOW_WIDTH  windowWidth,                                      --�򿪴��ڿ��
p.WINDOW_HEIGHT windowHeight,                                     --�򿪴��ڸ߶�
c.COMPONENT_ORDER,                                                           --չʾ˳�� 
c.COMPONENT_NAME componentName,                           --�������
c.COMPONENT_LABLE lable,                                                   --���չʾ����
c.COMPONENT_TYPE componentType,                                --�������
c.PLACEHOLDER placeholder,                                                 --չʾˮӡ����
p.LAYOUT_TEMPLATE_ID templateName,                              --ʹ��ģ������
l.LAYOUT_AREA_TEMPLATE_ID regionMark,                        --ʹ�������ʶ����
s.IS_CHECK,                                                                                 --�Ƿ��ܹ���ѡ
s.IS_CHECKED_LAST_STAGE,                                                    --�Ƿ�ֻ��ѡ����ĩ��
 s.DEFAULT_VALUE,                                                                   --Ĭ��ֵ
s.DATA_SOURCE_TYPE,                                                             --����Դ����
s.DATA_SOURCE componentSource,                                      --�������Դ
s.PK_FIELD,                                                                                    --�����ֶ�
s.LABLE_FIELD,                                                                              --չʾ�ֶ�
c.DATA_SOURCE                                                                          --չʾ����(TemplateHyperText��TemplateContainer)
 from  UDP_LAYOUT l  
 left join UDP_PAGE P on  l.page_id=p.ID
 left join UDP_COMPONENT c on  l.COMPONENT_ID=c.ID 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
where l.PAGE_ID=containerGuid and l.page_id=c.page_id order by c.COMPONENT_ORDER asc;
else
open pageComponents for  
select   c.ID componentId,                                                      --���ID
containerGuid containerGuid,                                                 --����ID         
c.COMPONENT_HIGH componentHeight,                          --����߶�
c.COMPONENT_WIDE componentWidth,                            --������
''  pageTitle,                                                                              --ҳ�����
''  windowWidth,                                                                       --�򿪴��ڿ��
'' windowHeight,                                                                       --�򿪴��ڸ߶�
c.COMPONENT_ORDER ,                                                         --չʾ˳�� 
c.COMPONENT_NAME componentName,                           --�������
c.COMPONENT_LABLE lable,                                                  --���չʾ����
c.COMPONENT_TYPE componentType,                               --�������
c.PLACEHOLDER placeholder,                                                --չʾˮӡ����
'' templateName,                                                                        --ģ������
l.LAYOUT_AREA_TEMPLATE_ID regionMark,                       --ʹ�������ʶ����
s.IS_CHECK,                                                                                --�Ƿ��ܹ���ѡ
s.IS_CHECKED_LAST_STAGE,                                                   --�Ƿ�ֻ��ѡ����ĩ��
s.DEFAULT_VALUE ,                                                                   --Ĭ��ֵ
s.DATA_SOURCE_TYPE,                                                             --����Դ����
s.DATA_SOURCE componentSource,                                      --�������Դ
s.PK_FIELD,                                                                                    --�����ֶ�
s.LABLE_FIELD,                                                                              --չʾ�ֶ�
c.DATA_SOURCE                                                                       --չʾ����(TemplateHyperText��TemplateContainer)
from UDP_COMPONENT c
left join UDP_LAYOUT l on  l.COMPONENT_ID=c.ID 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
where c.PAGE_ID=containerGuid order by c.COMPONENT_ORDER asc;
end if;

open treeSelect for  
select  
c.id componentId,                                                                     --���ID
containerGuid containerGuid,                                                 --����ID       
case when  t.default_expanded is null then '{"node":0,"level":1,"type":"index"}'
else
t.default_expanded end as default_expanded,                                   --Ĭ��չ��
t.default_checked,                                                                      --Ĭ��ѡ��
case when t.IS_CHECKED_LAST_STAGE   is null
then  s.IS_CHECKED_LAST_STAGE  else    t.IS_CHECKED_LAST_STAGE 
end as  IS_CHECKED_LAST_STAGE                                                --�Ƿ�ֻ��ѡ����ĩ��
from  UDP_COMPONENT c 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
left join UDP_COMPONENT_TREE_SELECT t on t.ID=c.id
where c.page_id=containerGuid and (c.component_type='TemplateTreeSelect') ;


open tabs for  
select  
c.id componentId,                                                               --���ID
t.default_tabsitem,                                                              --Ĭ��ѡ����
t.layout_style,                                                                       --Ĭ����ʽ
i.ITEM_VALUE,                                                                       --tabs����������ֵ
i.ITEM_LABLE,                                                                        --tabs�������չʾֵ
i.ID                                                                                          --tabs�������ID
from  UDP_COMPONENT c 
left join UDP_COMPONENT_TABS t on t.ID=c.id
left join UDP_COMPONENT_TABS_ITEM i on t.ID=i.COMPONENT_TABS_ID
where c.page_id=containerGuid and (c.component_type='TemplateTabs') order by i.item_order;

open tableColumn for
select 
*
from
(select 
n.ID,
c.ID componentId,                                                     --���ID
n.COLUMN_LABLE,                                                     --�б���
n.COLUMN_FIELD  ,                                                    --���ֶ���
n.COLUMN_WIDE ,                                                     --�п��
n.COLUMN_ALIGN ,                                                   --�ж���
n.COLUMN_FIXED ,                                                    --����������left,right��
2 COLUMN_NUMBER_FLOAT,                               --С���ֶα�����λ
n.COLUMN_DATA_TYPE ,                                         --��������
n.is_show_total,                                                          --�Ƿ���ʾ�ϼ�
n.parent_column_id,                                                  --����������
n.is_use_sort,                                                              --�Ƿ�ʹ������
d.IS_CHECK,                                                                 --�Ƿ�ѡ
t.detail_url,                                                                   --˫������ת��ַ
d.PK_FIELD,                                                                  --�����ֶ�
n.JUMP_URL,                                                               --�������ת��ַ
n.OPEN_MODE,                                                           --����д�ҳ�淽ʽ
t.OPEN_MODE DETAIL_MODE,                                          --˫���д�ҳ�淽ʽ
n.WINDOW_WIDTH,                                                   --�����д򿪵����Ŀ��
n.WINDOW_HEIGHT,                                                   --�����д򿪵����ĸ߶�
n.DEAL_WITH_MODE,                                                  --�����д����ģʽ
t.WINDOW_WIDTH as ROW_WINDOW_WIDTH,                              --˫���д򿪵����Ŀ��
t.WINDOW_HEIGHT as ROW_WINDOW_HEIGHT,                             --˫���д򿪵����ĸ߶�
n.IS_USE_HTML,                                                                                      --�Ƿ�ʹ��html
case  when t.IS_SHOW_PAGINATION is null
then 1 else t.IS_SHOW_PAGINATION end IS_SHOW_PAGINATION,           --�Ƿ���ʾ��ҳ
case  when t.IS_SHOW_BORDER is null
then 1 else t.IS_SHOW_BORDER end IS_SHOW_BORDER,                   --�Ƿ���ʾ�߿�
case  when t.IS_SHOW_STRIPE is null
then 1 else t.IS_SHOW_STRIPE end is_show_stripe,                    --�Ƿ���ʾ������
1 is_default_expanded,          --�Ƿ�չ�������Ӽ�
t.ENABLE_STATUS_FIELD,
case  when t.IS_NEED_PARAMETER_CACHE is null then 0 else  t.IS_NEED_PARAMETER_CACHE end as IS_NEED_PARAMETER_CACHE ,
case  when n.IS_NEED_PARAMETER_CACHE is null then 0 else  n.IS_NEED_PARAMETER_CACHE end as COL_IS_NEED_PARAMETER_CACHE,
case  when t.IS_SHOW_SERIAL_NUMBER is null and lower(c.component_type)='templatetable'  then 1 when
t.IS_SHOW_SERIAL_NUMBER is null and lower(c.component_type)<>'templatetable' then 0 
else t.IS_SHOW_SERIAL_NUMBER end as IS_SHOW_SERIAL_NUMBER,
n.COLUMN_ORDER
from UDP_COMPONENT c 
left join UDP_COMPONENT_TABLE_COLUMN n on c.ID=n.component_table_id
left join UDP_COMPONENT_TABLE  t on c.ID=t.ID
left join UDP_COMPONENT_DATA_SOURCE  d on d.ID=c.COMPONENT_DATA_SOURCE_ID
where c.page_id=containerGuid and (lower(c.component_type)='templatetable' or lower(c.component_type)='templatetreetable' )
and n.STATE=1
union 
select 
n.ID,
c.ID componentId,                                                     --���ID
n.COLUMN_LABLE,                                                     --�б���
n.COLUMN_FIELD  ,                                                    --���ֶ���
n.COLUMN_WIDE ,                                                     --�п��
n.COLUMN_ALIGN ,                                                   --�ж���
n.COLUMN_FIXED ,                                                    --����������left,right��
2 COLUMN_NUMBER_FLOAT,                               --С���ֶα�����λ
n.COLUMN_DATA_TYPE ,                                         --��������
n.is_show_total,                                                          --�Ƿ���ʾ�ϼ�
n.parent_column_id,                                                  --����������
n.is_use_sort,                                                              --�Ƿ�ʹ������
d.IS_CHECK,                                                                 --�Ƿ�ѡ
t.detail_url,                                                                   --˫������ת��ַ
d.PK_FIELD,                                                                  --�����ֶ�
n.JUMP_URL,                                                               --�������ת��ַ
n.OPEN_MODE,                                                           --����д�ҳ�淽ʽ
t.OPEN_MODE DETAIL_MODE,                                          --˫���д�ҳ�淽ʽ
n.WINDOW_WIDTH,                                                   --�����д򿪵����Ŀ��
n.WINDOW_HEIGHT,                                                   --�����д򿪵����ĸ߶�
n.DEAL_WITH_MODE,                                                  --�����д����ģʽ
t.WINDOW_WIDTH as ROW_WINDOW_WIDTH,                              --˫���д򿪵����Ŀ��
t.WINDOW_HEIGHT as ROW_WINDOW_HEIGHT,                             --˫���д򿪵����ĸ߶�
n.IS_USE_HTML,                                                                                      --�Ƿ�ʹ��html
0 IS_SHOW_PAGINATION,                                                                    --�Ƿ���ʾ��ҳ
case  when t.IS_SHOW_BORDER is null
then 1 else t.IS_SHOW_BORDER end IS_SHOW_BORDER,                   --�Ƿ���ʾ�߿�
case  when t.IS_SHOW_STRIPE is null
then 1 else t.IS_SHOW_STRIPE end is_show_stripe,                    --�Ƿ���ʾ������
case  when t.IS_DEFAULT_EXPANDED is null
then 1 else t.IS_DEFAULT_EXPANDED end is_default_expanded,          --�Ƿ�չ�������Ӽ�
t.ENABLE_STATUS_FIELD,
case  when t.IS_NEED_PARAMETER_CACHE is null then 0 else  t.IS_NEED_PARAMETER_CACHE end as IS_NEED_PARAMETER_CACHE ,
case  when n.IS_NEED_PARAMETER_CACHE is null then 0 else  n.IS_NEED_PARAMETER_CACHE end as COL_IS_NEED_PARAMETER_CACHE,
case  when t.IS_SHOW_SERIAL_NUMBER is null then 0 else t.IS_SHOW_SERIAL_NUMBER end as IS_SHOW_SERIAL_NUMBER,
n.COLUMN_ORDER
from UDP_COMPONENT c 
left join UDP_COMPONENT_TABLE_COLUMN n on c.ID=n.component_table_id
left join UDP_COMPONENT_TREE_TABLE  t on c.ID=t.ID
left join UDP_COMPONENT_DATA_SOURCE  d on d.ID=c.COMPONENT_DATA_SOURCE_ID
where c.page_id=containerGuid and lower(c.component_type)='templatetreetable'
and n.STATE=1) tab
order by COLUMN_ORDER asc;



open buttoneEvent for
SELECT
    e.COMPONENT_BUTTON_ID,                                 --��ť���ID
    b.TRADE_ID,                                                               --Ȩ�޵�ID
    b.icon,                                                                         --��ťͼ��
    e.EVENT_TYPE ,                                                          --��ť�¼�����
    e.EXECUTE_TYPE ,                                                      --��ťִ������
    e.EXECUTE_CONTENT,                                              --��ťִ������
    e.DIALOG_TITLE,                                                        --�����������
    e.DIALOG_CONTEN,                                                   --�����������
    e.WINDOW_WIDTH,                                                   --�򿪵����Ŀ��
    e.WINDOW_HEIGHT,                                                   --�򿪵����ĸ߶�
case  when e.IS_NEED_PARAMETER_CACHE is null then 0 else  e.IS_NEED_PARAMETER_CACHE end  as IS_NEED_PARAMETER_CACHE
FROM
    UDP_COMPONENT c 
    left join UDP_COMPONENT_BUTTON_EVENT e  on c.ID=e.COMPONENT_BUTTON_ID
    left join udp_component_button b  on c.ID=b.ID
    where c.PAGE_ID=containerGuid and  e.COMPONENT_BUTTON_ID  is not null;

open eventMonitoring for
select 
m.ID,                                                                              --�¼���������
m.COMPONENT_ID ,                                                   --���ID
m.TARGET_COMPONENT_ID ,                                   --���������ID
c.COMPONENT_TYPE ,                                                --�������
m.IS_MUST_MONITORING   from UDP_EVENT_MONITORING m 
left join UDP_COMPONENT c on m.TARGET_COMPONENT_ID=c.ID
where m.component_id in (select  c.ID   from UDP_COMPONENT c where  c.PAGE_ID=containerGuid);

open datePicker for
select 
c.ID componentId,                                                     --���ID
d.START_TIME,                                                           --��ʼʱ��
d.END_TIME,                                                               --����ʱ��
d.DEFAULT_VALUE,                                                   --Ĭ��ʱ��
d.VALUE_FORMAT                                                    --ʱ���ʽ
from  UDP_COMPONENT c 
left join UDP_COMPONENT_DATE_PICKER d on c.ID=d.ID
where  c.PAGE_ID=containerGuid and (lower(c.component_type)='templatedatepicker' or lower(c.component_type)='templatedatetimepicker' );
END P_UDP_COMPONENT_BY_PAGE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_COMPONENT_BY_TABLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_COMPONENT_BY_TABLE" (componentId in varchar,componentInfo OUT sys_refcursor,tableAttributes OUT sys_refcursor)
AS  
haspage INTEGER;
BEGIN  
open componentInfo for  
select   c.ID componentId,                                                      --���ID   
c.COMPONENT_HIGH componentHeight,                          --����߶�
c.COMPONENT_WIDE componentWidth,                            --������
''  pageTitle,                                                                              --ҳ�����
''  windowWidth,                                                                       --�򿪴��ڿ��
'' windowHeight,                                                                       --�򿪴��ڸ߶�
c.COMPONENT_ORDER ,                                                         --չʾ˳�� 
c.COMPONENT_NAME componentName,                           --�������
c.COMPONENT_LABLE lable,                                                  --���չʾ����
c.COMPONENT_TYPE componentType,                               --�������
c.PLACEHOLDER placeholder,                                                --չʾˮӡ����
s.IS_CHECK,                                                                                --�Ƿ��ܹ���ѡ
s.IS_CHECKED_LAST_STAGE,                                                   --�Ƿ�ֻ��ѡ����ĩ��
s.DEFAULT_VALUE ,                                                                   --Ĭ��ֵ
s.DATA_SOURCE_TYPE,                                                             --����Դ����
s.DATA_SOURCE componentSource,                                      --�������Դ
s.PK_FIELD,                                                                                 --�����ֶ�
s.LABLE_FIELD,                                                                           --չʾ�ֶ�
c.DATA_SOURCE                                                                       --չʾ����(TemplateHyperText��TemplateContainer)
from UDP_COMPONENT c
left join UDP_LAYOUT l on  l.COMPONENT_ID=c.ID 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
where c.ID=componentId;
open tableAttributes for
select 
n.ID,
c.ID componentId,                                                     --���ID
n.COLUMN_LABLE,                                                     --�б���
n.COLUMN_FIELD  ,                                                    --���ֶ���
n.COLUMN_WIDE ,                                                     --�п��
n.COLUMN_ALIGN ,                                                   --�ж���
n.COLUMN_FIXED ,                                                    --����������left,right��
2 COLUMN_NUMBER_FLOAT,                               --С���ֶα�����λ
n.COLUMN_DATA_TYPE ,                                         --��������
n.is_show_total,                                                          --�Ƿ���ʾ�ϼ�
n.parent_column_id,                                                  --����������
n.is_use_sort,                                                              --�Ƿ�ʹ������
d.IS_CHECK,                                                                 --�Ƿ�ѡ
t.detail_url,                                                                   --˫������ת��ַ
d.PK_FIELD,                                                                  --�����ֶ�
n.JUMP_URL,                                                               --�������ת��ַ
n.OPEN_MODE,                                                           --����д�ҳ�淽ʽ
t.OPEN_MODE DETAIL_MODE,                                 --˫���д�ҳ�淽ʽ
n.WINDOW_WIDTH,                                                   --�����д򿪵����Ŀ��
n.WINDOW_HEIGHT,                                                   --�����д򿪵����ĸ߶�
n.DEAL_WITH_MODE,                                                  --�����д����ģʽ
t.WINDOW_WIDTH as "ROW_WINDOW_WIDTH",  --˫���д򿪵����Ŀ��
t.WINDOW_HEIGHT as "ROW_WINDOW_WIDTH",  --˫���д򿪵����ĸ߶�
n.IS_USE_HTML,                                                            --�Ƿ���ʾhtml
case  when t.IS_SHOW_PAGINATION is null
then 1 else t.IS_SHOW_PAGINATION end IS_SHOW_PAGINATION,           --�Ƿ���ʾ��ҳ
case  when t.IS_SHOW_BORDER is null
then 1 else t.IS_SHOW_BORDER end IS_SHOW_BORDER,                   --�Ƿ���ʾ�߿�
case  when t.IS_SHOW_STRIPE is null
then 1 else t.IS_SHOW_STRIPE end is_show_stripe                    --�Ƿ���ʾ������
from UDP_COMPONENT c 
left join UDP_COMPONENT_TABLE_COLUMN n on c.ID=n.component_table_id
left join UDP_COMPONENT_TABLE  t on c.ID=t.ID
left join UDP_COMPONENT_DATA_SOURCE  d on d.ID=c.COMPONENT_DATA_SOURCE_ID
where c.ID=componentId and (lower(c.component_type)='templatetable' or lower(c.component_type)='templatetreetable' )
and n.STATE=1
order by n.COLUMN_ORDER asc;

END P_UDP_COMPONENT_BY_TABLE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_COMPONENT_DATA_SOURCE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_COMPONENT_DATA_SOURCE" (componentId in varchar,dataSourceInfo OUT sys_refcursor)
AS  
BEGIN  
open dataSourceInfo for  
select 
c.DATA_SOURCE ,                                                                                      --����Դ���ò�ѯ�����ߴ洢���̱�ʶcode
c.DATA_SOURCE_TYPE ,                                                                           --����Դ����
c.PARENT_FIELD ,                                                                                       --�����ֶ���
c.PK_FIELD ,                                                                                                 --�����ֶ���
c.LABLE_FIELD,                                                                                            --չʾ�ֶ���
c.CHILD_FIELD,                                                                                            --�Ӽ��ֶ���
t.COMPONENT_TYPE
from UDP_COMPONENT t
left join UDP_COMPONENT_DATA_SOURCE c on t.COMPONENT_DATA_SOURCE_ID=c.id
where t.id=componentId;
END p_UDP_Component_Data_Source;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_CREATE_TEMP_TABLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_CREATE_TEMP_TABLE" (temp_table_name in VARCHAR2,tablename in VARCHAR2,SQL_STR  in VARCHAR2) AUTHID current_user 
as
sqlstr VARCHAR2(4000);
sqlstr1 VARCHAR2(4000);
TABLEEXIST NUMBER;
begin
select    WMSYS.WM_CONCAT( tab.col)   into sqlstr1  from (SELECT a.column_name||'  '||a.data_type||case 
 WHEN  a.DATA_TYPE = 'NVARCHAR2' OR a.DATA_TYPE = 'VARCHAR2' or  a.DATA_TYPE ='CHAR'  THEN  '('||a.DATA_LENGTH||')' 
 WHEN  a.DATA_TYPE = 'DATE' OR a.DATA_TYPE = 'CLOB' or  a.DATA_TYPE = 'NUMBER' or   a.DATA_TYPE ='BLOB' THEN ''
 end as col
 FROM USER_TAB_COLUMNS a where a.TABLE_NAME=tablename order by a.column_id ) tab;
  select count(1) into TABLEEXIST from user_tables where table_name = upper(temp_table_name);
    if TABLEEXIST=1 then 
     execute immediate 'drop table '||upper(temp_table_name);
    end if;
 sqlstr:=' create global temporary table '||upper(temp_table_name)||'(';
 sqlstr:=sqlstr||sqlstr1||') on commit delete rows';
 --������ʱ��
  execute immediate sqlstr;
--����ʱ���е�������
  if  SQL_STR is not null
  then
  execute immediate ' insert into  '||temp_table_name||' '||SQL_STR;
  end if;
end P_UDP_CREATE_TEMP_TABLE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_DATA_SOURCE_BY_CODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_DATA_SOURCE_BY_CODE" (code in varchar,dataSourceInfo OUT sys_refcursor)
AS  
pcode VARCHAR2(1000);
rowcountByCode int;
rowcountBySource int;
BEGIN  
pcode:=code;
select count(1) into rowcountByCode  from  UDP_COMPONENT_DATA_SOURCE c 
where c.CODE=pcode ;
select count(1) into rowcountBySource  from  UDP_COMPONENT_DATA_SOURCE c 
where c.DATA_SOURCE=pcode ;
if rowcountBySource<>0 THEN
open dataSourceInfo for  
select 
c.DATA_SOURCE ,                                                                                      --����Դ���ò�ѯ�����ߴ洢���̱�ʶcode
c.DATA_SOURCE_TYPE ,                                                                            --����Դ����
c.PARENT_FIELD ,                                                                                       --�����ֶ���
c.PK_FIELD ,                                                                                                 --�����ֶ���
c.LABLE_FIELD,                                                                                            --չʾ�ֶ���
c.CHILD_FIELD                                                                                             --�Ӽ��ֶ���
from  UDP_COMPONENT_DATA_SOURCE c 
where c.DATA_SOURCE=pcode and rownum = 1;
ELSIF rowcountByCode<>0 then
open dataSourceInfo for  
select 
c.DATA_SOURCE ,                                                                                      --����Դ���ò�ѯ�����ߴ洢���̱�ʶcode
c.DATA_SOURCE_TYPE ,                                                                            --����Դ����
c.PARENT_FIELD ,                                                                                       --�����ֶ���
c.PK_FIELD ,                                                                                                 --�����ֶ���
c.LABLE_FIELD,                                                                                            --չʾ�ֶ���
c.CHILD_FIELD                                                                                             --�Ӽ��ֶ���
from  UDP_COMPONENT_DATA_SOURCE c 
where c.CODE=pcode and rownum = 1;
else 
open dataSourceInfo for  
SELECT pcode as  DATA_SOURCE,
'procedure' as  DATA_SOURCE_TYPE,
'' as PARENT_FIELD,
'' as PK_FIELD,
'' as LABLE_FIELD,
'' as CHILD_FIELD
from dual;
end if;
END p_UDP_Data_Source_By_Code;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_DATA_SOURCE_BY_PAGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_DATA_SOURCE_BY_PAGE" (
    p_pagesql  IN CLOB,                  --sql
    p_curPage  IN  NUMBER ,         --��ǰҳ
    p_pageSize IN NUMBER ,         --ÿҳ��ʾ��¼������
    total OUT NUMBER,                   --�ܼ�¼��
    items OUT SYS_REFCURSOR     -- ���������α�
  )
AS
  v_sql    CLOB;                                  --sql���
  v_startRecord NUMBER;             --��ʼ��ʾ�ļ�¼��
  v_endRecord   NUMBER;             --������ʾ�ļ�¼����
BEGIN
                                                            --��¼�ܼ�¼����
  v_sql:= 'select count(*) FROM (' || p_pagesql || ')';
  EXECUTE IMMEDIATE v_sql INTO total;
                                                            --ʵ�ַ�ҳ��ѯ
  v_startRecord :=(p_curPage - 1) * p_pageSize + 1;
  v_endRecord   :=p_curPage  * p_pageSize;
  v_sql         :='select * from (SELECT t.*, ROWNUM RN from (' || p_pagesql || ') t where rownum<=' || v_endRecord || ' ) where RN>=' ||v_startRecord;

  OPEN items FOR v_sql;
EXCEPTION
WHEN OTHERS THEN
  CLOSE items;
END p_UDP_Data_Source_By_Page;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_DELETE_SQL_BY_EXCELID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_DELETE_SQL_BY_EXCELID" (CODE in VARCHAR2, EXPORT_SQL_LIST OUT SYS_REFCURSOR)  AUTHID current_user 
as
str_sql VARCHAR2(4000);
TEMP_TABLE_NAME VARCHAR2(200);
TABLE_NAME VARCHAR2(200);
SQL_STR VARCHAR2(4000);
EXPORT_SQL CLOB :='';
row_index NUMBER;
ROW_COUNT NUMBER;
TABLEEXIST NUMBER;
begin
    row_index:=1;
     str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڴ��ھ�ɾ��
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
     --������ʱ��
    execute immediate str_sql;
    else 
    execute immediate 'delete EXPORT_SQL_TABLE';
    end if;

  insert into EXPORT_SQL_TABLE VALUES(row_index,'','set define off;');
/*=================================ɾ���ֶ���Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_EXPORT_FIELD';
  SQL_STR:=' select * from UDP_EXPORT_FIELD where id in (select EXPORT_FIELD_ID from  UDP_EXPORT_SHEET_FIELD where EXPORT_SHEET_ID='''||CODE||'''';
  SQL_STR:=SQL_STR||'UNION select EXPORT_FIELD_ID from  UDP_EXPORT_SHEET_FIELD where  EXPORT_SHEET_ID in (select Id from UDP_EXPORT_SHEET where EXCEL_ID='''||CODE||'''))';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���ֶ���Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*=================================ɾ��sheet�����ֶ���Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_EXPORT_SHEET_FIELD';
  SQL_STR:=' select * from UDP_EXPORT_SHEET_FIELD where EXPORT_SHEET_ID='''||CODE||''' UNION select * from UDP_EXPORT_SHEET_FIELD where EXPORT_SHEET_ID in (select ID from UDP_EXPORT_SHEET where EXCEL_ID='''||CODE||''' )';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��sheet�����ֶ���Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*=================================ɾ��sheet������Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_EXPORT_SHEET';
  SQL_STR:=' select * from UDP_EXPORT_SHEET where ID='''||CODE||''' UNION select * from UDP_EXPORT_SHEET where EXCEL_ID='''||CODE||''' ';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��sheet������Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*=================================ɾ��excel������Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_EXPORT_EXCEL';
  SQL_STR:='select * from UDP_EXPORT_EXCEL where ID='''||CODE||''' ';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��excel������Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
  /*=================================��ѯ������sql�����Ϣ=================================================*/
  open EXPORT_SQL_LIST for 'select SQL from EXPORT_SQL_TABLE order by ID';
  commit;
end  P_UDP_DELETE_SQL_BY_EXCELID;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_DELETE_SQL_BY_PAGEID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_DELETE_SQL_BY_PAGEID" (PAGEID in VARCHAR2, EXPORT_SQL_LIST OUT SYS_REFCURSOR  )  AUTHID current_user 
as
str_sql VARCHAR2(4000);
SQL_STR CLOB :='';
row_index NUMBER;
TABLEEXIST NUMBER;
TABLE_NAME VARCHAR2(4000);
ROW_COUNT NUMBER;
SELECT_COMPONENT_BY_PAGEID CLOB :='';
BEGIN
 row_index:=1;
    str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڲ����ھʹ���
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
      --������ʱ��
      execute immediate str_sql;
    else
     --ɾ����ʱ������
      execute immediate 'delete  EXPORT_SQL_TABLE';
    end if;
  insert into EXPORT_SQL_TABLE  VALUES(row_index,'','set define off;');
  SQL_STR:='select * from udp_component where  page_id='''||PAGEID||''' UNION select * from udp_component where  page_id in ';
  SQL_STR:=SQL_STR||'(select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  (select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))';
  SQL_STR:=SQL_STR||' UNION ';
  SQL_STR:=SQL_STR||' select * from udp_component WHERE page_id IN (select ID from (select * from udp_component where page_id='''||PAGEID||''' ';
  SQL_STR:=SQL_STR||' UNION  ';
  SQL_STR:=SQL_STR||' select * from udp_component where  page_id in ';
  SQL_STR:=SQL_STR||' (select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  ';
  SQL_STR:=SQL_STR||'(select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))) tab1';
  SQL_STR:=SQL_STR||' where tab1.COMPONENT_TYPE=''TemplateDropdown'')';
  SELECT_COMPONENT_BY_PAGEID:='select t.ID from ('||SQL_STR||') t';
/*==================================ɾ�� UDP_EXPORT_FIELD ���ֶ�����================================================*/
  TABLE_NAME:= 'UDP_EXPORT_FIELD';
  SQL_STR:=' select * from '||TABLE_NAME||' where ID in (select EXPORT_FIELD_ID from UDP_EXPORT_SHEET_FIELD where  EXPORT_SHEET_ID in��select ID from  UDP_EXPORT_SHEET  where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION select ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) ) )';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���ֶ�����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_EXPORT_SHEET_FIELD ��sheet�����ֶ�����================================================*/
  TABLE_NAME:= 'UDP_EXPORT_SHEET_FIELD';
   SQL_STR:=' select * from '||TABLE_NAME||' where  EXPORT_SHEET_ID in��select ID from  UDP_EXPORT_SHEET  where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION select ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) )';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��sheet�����ֶ�����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_EXPORT_SHEET ��excel����sheet����================================================*/
  TABLE_NAME:= 'UDP_EXPORT_SHEET';
  SQL_STR:=' select * from  '||TABLE_NAME||' where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION  select * from '||TABLE_NAME||' where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) ';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��excel����sheet����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_EXPORT_EXCEL ��excel��������================================================*/
  TABLE_NAME:= 'UDP_EXPORT_EXCEL';
  SQL_STR:=' select * from  '||TABLE_NAME||' where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION  select * from '||TABLE_NAME||' where ID in  (select EXCEL_ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) )';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��excel��������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
  /*==================================ɾ�� UDP_LAYOUT �������������================================================*/
  TABLE_NAME:= 'UDP_LAYOUT';
  SQL_STR:='  select * from '||TABLE_NAME||' where COMPONENT_ID  in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ�������������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_EVENT_MONITORING �������������================================================*/
 TABLE_NAME:= 'UDP_EVENT_MONITORING';
  SQL_STR:='  select *  from '||TABLE_NAME||' where component_id in ('||SELECT_COMPONENT_BY_PAGEID||') and TARGET_COMPONENT_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ�������������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_DATE_PICKER ��洢���̲�������================================================*/
  TABLE_NAME:= 'UDP_PROCEDURE_PARAMETER';
    SQL_STR:='select r.* from UDP_PROCEDURE_REGISTRATION r where r.code in (select s.data_source from  (select component_data_source_id from UDP_COMPONENT where ID  in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||' and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id where s.data_source_type=''procedure'') ';
    SQL_STR:=SQL_STR|| ' UNION ';
    SQL_STR:=SQL_STR||'select  r.* from ( select  case when instr(s.data_source,''?'',1,1) <>0 then  substr(s.data_source,instr(s.data_source,''?'',1,1)+1)||''&''  end conten ';
    SQL_STR:=SQL_STR||'from  (select component_data_source_id from UDP_COMPONENT where ID in  ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||'and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id ';
    SQL_STR:=SQL_STR||'where s.data_source LIKE ''/api/udp/getExecuteProcedureResult%'' or  s.data_source LIKE ''/api/udp/getRegisterResult%'' or  s.data_source LIKE ''/api/public/udp/getRegisterResult%'' )tab , UDP_PROCEDURE_REGISTRATION r ';
    SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
    SQL_STR:=SQL_STR||' UNION ';
    SQL_STR:=SQL_STR||'select  r.*  from (select case when instr(EXECUTE_CONTENT,''?'',1,1) <>0 then  substr(EXECUTE_CONTENT,instr(EXECUTE_CONTENT,''?'',1,1)+1)||''&''  end conten   from UDP_COMPONENT_BUTTON_EVENT where COMPONENT_BUTTON_ID in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||'and EXECUTE_CONTENT LIKE ''/api/udp/getExecuteProcedureResult%'' or  EXECUTE_CONTENT LIKE ''/api/udp/getRegisterResult%'' or  EXECUTE_CONTENT LIKE ''/api/public/udp/getRegisterResult%'' ) tab, UDP_PROCEDURE_REGISTRATION r ';
    SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
  SQL_STR:='select * from '||TABLE_NAME||' where PROCEDURE_REGISTRATION_ID in ('||' select ID  from ('||SQL_STR||') '||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���洢���̲�������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_PROCEDURE_REGISTRATION ��洢��������================================================*/
  TABLE_NAME:= 'UDP_PROCEDURE_REGISTRATION';
    SQL_STR:='select r.* from UDP_PROCEDURE_REGISTRATION r where r.code in (select s.data_source from  (select component_data_source_id from UDP_COMPONENT where ID  in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||' and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id where s.data_source_type=''procedure'') ';
    SQL_STR:=SQL_STR|| ' UNION ';
    SQL_STR:=SQL_STR||'select  r.* from ( select  case when instr(s.data_source,''?'',1,1) <>0 then  substr(s.data_source,instr(s.data_source,''?'',1,1)+1)||''&''  end conten ';
    SQL_STR:=SQL_STR||'from  (select component_data_source_id from UDP_COMPONENT where ID in  ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||'and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id ';
    SQL_STR:=SQL_STR||'where s.data_source LIKE ''/api/udp/getExecuteProcedureResult%'' or  s.data_source LIKE ''/api/udp/getRegisterResult%'' or  s.data_source LIKE ''/api/public/udp/getRegisterResult%'' )tab , UDP_PROCEDURE_REGISTRATION r ';
    SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
    SQL_STR:=SQL_STR||' UNION ';
    SQL_STR:=SQL_STR||'select  r.*  from (select case when instr(EXECUTE_CONTENT,''?'',1,1) <>0 then  substr(EXECUTE_CONTENT,instr(EXECUTE_CONTENT,''?'',1,1)+1)||''&''  end conten   from UDP_COMPONENT_BUTTON_EVENT where COMPONENT_BUTTON_ID in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
    SQL_STR:=SQL_STR||'and EXECUTE_CONTENT LIKE ''/api/udp/getExecuteProcedureResult%'' or  EXECUTE_CONTENT LIKE ''/api/udp/getRegisterResult%'' or  EXECUTE_CONTENT LIKE ''/api/public/udp/getRegisterResult%'' ) tab, UDP_PROCEDURE_REGISTRATION r ';
    SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���洢��������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_DATA_SOURCE ������Դ����================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_DATA_SOURCE';
  SQL_STR:='select s.*  FROM udp_component c RIGHT join udp_component_data_source s on c.component_data_source_id=s.id where c.id in ('||SELECT_COMPONENT_BY_PAGEID||') UNION ';
  SQL_STR:=SQL_STR||'select s.*  from (SELECT case when instr(s.data_source,''?'',1,1) <>0 then  substr(s.data_source,instr(s.data_source,''?'',1,1)+1)||''&''  end conten  FROM udp_component c RIGHT join udp_component_data_source s on c.component_data_source_id=s.id where c.id in (';
  SQL_STR:=SQL_STR||SELECT_COMPONENT_BY_PAGEID||')';
  SQL_STR:=SQL_STR||' and  s.data_source LIKE ''/api/udp/getDataSource%'')  tab,udp_component_data_source s where  tab.conten   like ''%code=''||s.code||''&%'' ';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ������Դ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_BUTTON_EVENT ��ť����¼�����================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_BUTTON_EVENT';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ����ť����¼�����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_BUTTON ��ť�������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_BUTTON';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ����ť�������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_TABLE_COLUMN ��table�б��������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_TABLE_COLUMN';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_TABLE_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��table���������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_TABLE ��table�б��������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_TABLE';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��table�б��������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_TREE_SELECT ��tree-select�������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_TREE_SELECT';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��tree-select�������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_DATE_PICKER ��ʱ��ѡ�����������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_DATE_PICKER';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��ʱ��ѡ�����������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_TABS_ITEM ��tabs���items����================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_TABS_ITEM';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_TABS_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��tabs���items����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT_TABS ��tabs�������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT_TABS';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��tabs�������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_PAGE ������================================================*/
  TABLE_NAME:= 'UDP_PAGE';
  SQL_STR:='  select * from '||TABLE_NAME||' where ID='''||PAGEID||'''';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ��ҳ������');
    row_index:=row_index+1;
     insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*==================================ɾ�� UDP_COMPONENT ���������================================================*/
  TABLE_NAME:= 'UDP_COMPONENT';
  SQL_STR:='select * from udp_component where  page_id='''||PAGEID||''' UNION select * from udp_component where  page_id in ';
  SQL_STR:=SQL_STR||'(select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  (select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))';
  SQL_STR:=SQL_STR||' UNION ';
  SQL_STR:=SQL_STR||' select * from udp_component WHERE page_id IN (select ID from (select * from udp_component where page_id='''||PAGEID||''' ';
  SQL_STR:=SQL_STR||' UNION  ';
  SQL_STR:=SQL_STR||' select * from udp_component where  page_id in ';
  SQL_STR:=SQL_STR||' (select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  ';
  SQL_STR:=SQL_STR||'(select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))) tab1';
  SQL_STR:=SQL_STR||' where tab1.COMPONENT_TYPE=''TemplateDropdown'')';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���������');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*=================================��ѯ������sql�����Ϣ=================================================*/
open EXPORT_SQL_LIST for 'select SQL from EXPORT_SQL_TABLE order by ID';
END P_UDP_DELETE_SQL_BY_PAGEID;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_DELETE_SQL_BY_PROCODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_DELETE_SQL_BY_PROCODE" (CODE in VARCHAR2, EXPORT_SQL_LIST OUT SYS_REFCURSOR)  AUTHID current_user 
as
str_sql VARCHAR2(4000);
TEMP_TABLE_NAME VARCHAR2(200);
TABLE_NAME VARCHAR2(200);
SQL_STR VARCHAR2(4000);
EXPORT_SQL CLOB :='';
row_index NUMBER;
ROW_COUNT NUMBER;
TABLEEXIST NUMBER;
begin
    row_index:=1;
     str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڴ��ھ�ɾ��
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
     --������ʱ��
    execute immediate str_sql;
    else 
    execute immediate 'delete EXPORT_SQL_TABLE';
    end if;

  insert into EXPORT_SQL_TABLE VALUES(row_index,'','set define off;');
/*=================================ɾ���洢���̲�����Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_PROCEDURE_PARAMETER';
  SQL_STR:=' select * from '||TABLE_NAME||' WHERE PROCEDURE_REGISTRATION_ID IN (select ID from UDP_PROCEDURE_REGISTRATION where CODE='''||CODE||''' and  STATE=1)';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���洢���̲�����Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
/*=================================ɾ���洢����ע����Ϣ����=================================================*/
  TABLE_NAME:= 'UDP_PROCEDURE_REGISTRATION';
  SQL_STR:='  select * from '||TABLE_NAME||' where CODE='''||CODE||'''  and  STATE=1';
  execute immediate ' select COUNT(1)  from ('||SQL_STR||') t' INTO  ROW_COUNT;
  IF ROW_COUNT <> 0 THEN
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'--ɾ���洢����ע����Ϣ����');
    row_index:=row_index+1;
    insert into EXPORT_SQL_TABLE  VALUES(row_index,TABLE_NAME,'delete '||TABLE_NAME||' where ID in  (select t.ID from ('||SQL_STR||') t );');
  END IF;
  /*=================================��ѯ������sql�����Ϣ=================================================*/
  open EXPORT_SQL_LIST for 'select SQL from EXPORT_SQL_TABLE order by ID';
  commit;
end  P_UDP_DELETE_SQL_BY_PROCODE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_EXPORT_BY_CODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_EXPORT_BY_CODE" (code in  VARCHAR2,sheetField OUT sys_refcursor )
AS  
rowcountByExcelId  int;
rowcountByDataSource  int;
BEGIN  
select count(1) into rowcountByExcelId  from  UDP_EXPORT_EXCEL e
where e.id=code;
if rowcountByExcelId<>0 THEN
open sheetField for  
 SELECT
    e.id as excel_id,
    e.file_name,
    s.id as sheet_id,
    data_source,
    name,
    excel_title,
    ROW_BG_COLOR_FIELD,
    header_bg_color,
    header_font_color,
    sheet_order,
    f. id,
    f.lable,
    f.field,
    f.wide,
    f.align,
    f.data_type,
    f.is_show_total,
    f.field_order,
    f.TEXT_ALIGN,
    f.parent_id as PARENT_COLUMN_ID
FROM
    udp_export_sheet s
    left join UDP_EXPORT_EXCEL e on s.excel_id=e.id
    left join UDP_EXPORT_SHEET_FIELD t on  s.Id=t.export_sheet_id
    left join UDP_EXPORT_FIELD f on t.export_field_id=f.id
    where e.id=code order by f.field_order;
else
    select count(1) into rowcountByDataSource  from  udp_export_sheet s
    where s.id=code;
        if rowcountByDataSource<>0 THEN
    open sheetField for  
     SELECT
        e.id as excel_id,
        e.file_name,
        s.id as sheet_id,
        data_source,
        name,
        excel_title,
        ROW_BG_COLOR_FIELD,
        header_bg_color,
        header_font_color,
        sheet_order,
        f. id,
        f.lable,
        f.field,
        f.wide,
        f.align,
        f.data_type,
        f.is_show_total,
        f.field_order,
        f.TEXT_ALIGN,
        f.parent_id as PARENT_COLUMN_ID
    FROM
        udp_export_sheet s
        left join UDP_EXPORT_EXCEL e on s.excel_id=e.id
        left join UDP_EXPORT_SHEET_FIELD t on  s.Id=t.export_sheet_id
        left join UDP_EXPORT_FIELD f on t.export_field_id=f.id
        where s.id=code order by f.field_order;
        end if;
end if;
END P_UDP_EXPORT_BY_CODE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_EXPORT_SQL_BY_EXCELID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_EXPORT_SQL_BY_EXCELID" (EXCELID in VARCHAR2, EXPORT_SQL_LIST OUT SYS_REFCURSOR)  AUTHID current_user 
as
str_sql VARCHAR2(4000);
TEMP_TABLE_NAME VARCHAR2(200);
TABLE_NAME VARCHAR2(200);
SQL_STR VARCHAR2(4000);
EXPORT_SQL CLOB :='';
row_index NUMBER;
TABLEEXIST NUMBER;
ROW_COUNT NUMBER;
begin
    row_index:=1;
    str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڲ����ھʹ���
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
      --������ʱ��
      execute immediate str_sql;
    else
     --ɾ����ʱ������
      execute immediate 'delete  EXPORT_SQL_TABLE';
    end if;
  execute immediate 'select count(1) from UDP_EXPORT_EXCEL where id='''||EXCELID||''' '  INTO  ROW_COUNT;
  insert into EXPORT_SQL_TABLE VALUES(row_index,'','set define off;');
/*=================================EXCEL�����ļ���Ϣ����=================================================*/
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_EXCEL';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
--��ѯ���
   if ROW_COUNT = 1  then
   SQL_STR:='  select * from '||TABLE_NAME||' where ID='''||EXCELID||'''  ';
   end if;
    if ROW_COUNT = 0  then
    SQL_STR:='  select * from '||TABLE_NAME||' where ID in (SELECT EXCEL_ID FROM UDP_EXPORT_SHEET WHERE  ID= '''||EXCELID||''') ';
   end if;
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--EXCEL�����ļ���Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
    --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================EXCEL������������Ϣ����=================================================*/
  select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_SHEET';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  --��ѯҳ����ʾ�����id�ļ���
   if ROW_COUNT = 1  then
     SQL_STR:=' select * from '||TABLE_NAME||' WHERE EXCEL_ID ='''||EXCELID||''' ';
   end if;
    if ROW_COUNT = 0  then
    SQL_STR:='  select * from '||TABLE_NAME||' where ID ='''||EXCELID||''' ';
   end if;
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--EXCEL������������Ϣ��ʼ��' ,
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
 /*=================================EXCEL�����������������ֶ���Ϣ����=================================================*/
  select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_SHEET_FIELD';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_EXPORT_SHEET_FIELD';
   if ROW_COUNT = 1  then
   SQL_STR:='select * from '||TABLE_NAME||'  where EXPORT_SHEET_ID in (select ID from UDP_EXPORT_SHEET WHERE EXCEL_ID ='''||EXCELID||''' )';
   end if;
    if ROW_COUNT = 0  then
    SQL_STR:='select * from '||TABLE_NAME||'  where EXPORT_SHEET_ID ='''||EXCELID||''' ';
   end if;
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--EXCEL�����������������ֶ���Ϣ��ʼ��' ,
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
 /*=================================EXCEL�����ֶ���Ϣ����=================================================*/
  select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_FIELD';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  --��ѯҳ����ʾ�����id�ļ���
   if ROW_COUNT = 1  then
     SQL_STR:='select * from '||TABLE_NAME||' where ID in (select  EXPORT_FIELD_ID  from UDP_EXPORT_SHEET_FIELD  where EXPORT_SHEET_ID in (select ID from UDP_EXPORT_SHEET WHERE EXCEL_ID ='''||EXCELID||''' ))';
   end if;
    if ROW_COUNT = 0  then
     SQL_STR:='select * from '||TABLE_NAME||' where ID in (select  EXPORT_FIELD_ID  from UDP_EXPORT_SHEET_FIELD  where EXPORT_SHEET_ID  ='''||EXCELID||''' )';
   end if;
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--EXCEL�����ֶ���Ϣ��ʼ��' ,
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================��ѯ������sql�����Ϣ=================================================*/
   open EXPORT_SQL_LIST for 'select replace(replace(SQL,''''''$("time")$'',''to_date(''''''),''$("timeend")$'''''','''''',''''yyyy-mm-dd hh24:mi:ss'''')'') SQL from EXPORT_SQL_TABLE order by ID';
  commit;
end  P_UDP_EXPORT_SQL_BY_EXCELID;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_EXPORT_SQL_BY_PAGEID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_EXPORT_SQL_BY_PAGEID" (PAGEID in VARCHAR2,IS_COPY in NUMBER, EXPORT_SQL_LIST OUT SYS_REFCURSOR  )  AUTHID current_user 
as
str_sql VARCHAR2(4000);
TEMP_TABLE_NAME VARCHAR2(200);
TABLE_NAME VARCHAR2(200);
SQL_STR CLOB :='';
EXPORT_SQL CLOB :='';
row_index NUMBER;
TABLEEXIST NUMBER;
REGISTRATION_IDS VARCHAR2(4000);
SELECT_COMPONENT_BY_PAGEID VARCHAR2(4000);
SELECT_COL VARCHAR2(4000);
begin
    row_index:=1;
    str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڲ����ھʹ���
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
      --������ʱ��
      execute immediate str_sql;
    else
     --ɾ����ʱ������
      execute immediate 'delete  EXPORT_SQL_TABLE';
    end if;
  insert into EXPORT_SQL_TABLE  VALUES(row_index,'','set define off;');
/*=================================����ҳ������=================================================*/
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_PAGE';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
--��ѯ���
  if IS_COPY=1 then
   SQL_STR:='  select ID ,LAYOUT_TEMPLATE_ID ,CREATED ,CREATOR_ID ,CREATOR ,MODIFIED ,MODIFIER_ID ,MODIFIER ,FUNCTION_ID ,TITLE ,WINDOW_WIDTH ,WINDOW_HEIGHT ,''��''||ID||''������������Ϣ'' REMARK  from '||TABLE_NAME||' where ID='''||PAGEID||'''';
  else
   SQL_STR:='  select * from '||TABLE_NAME||' where ID='''||PAGEID||'''';
  end if;
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--ҳ�������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
 /*=================================�����������=================================================*/
  select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  --��ѯҳ����ʾ�����id�ļ���
    SQL_STR:='select * from udp_component where  page_id='''||PAGEID||''' UNION select * from udp_component where  page_id in ';
    SQL_STR:=SQL_STR||'(select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  (select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))';
    SQL_STR:=SQL_STR||' UNION ';
    SQL_STR:=SQL_STR||' select * from udp_component WHERE page_id IN (select ID from (select * from udp_component where page_id='''||PAGEID||''' ';
    SQL_STR:=SQL_STR||' UNION  ';
    SQL_STR:=SQL_STR||' select * from udp_component where  page_id in ';
    SQL_STR:=SQL_STR||' (select ID from UDP_COMPONENT_TABS_ITEM where component_tabs_id in  ';
    SQL_STR:=SQL_STR||'(select id from udp_component where  page_id='''||PAGEID||''' and component_type=''TemplateTabs''))) tab1';
    SQL_STR:=SQL_STR||' where tab1.COMPONENT_TYPE=''TemplateDropdown'')';
    SELECT_COMPONENT_BY_PAGEID:='select t.ID from ('||SQL_STR||') t';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--���������Ϣ��ʼ��' ,
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================���������������=================================================*/
 select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_LAYOUT';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
   SQL_STR:='  select * from '||TABLE_NAME||' where COMPONENT_ID  in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--���������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================���������������=================================================*/
 select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EVENT_MONITORING';
 --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:='  select *  from '||TABLE_NAME||' where component_id in ('||SELECT_COMPONENT_BY_PAGEID||') and TARGET_COMPONENT_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--���������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================������ť�������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_BUTTON';
 --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--��ť���������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================������ť����¼�����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_BUTTON_EVENT';
 --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_BUTTON_EVENT';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--��ť����¼���Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '|| EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
--/*=================================����table�б�����¼�����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_TABLE';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--table�б����������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����table���������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_TABLE_COLUMN';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_TABLE_COLUMN';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_TABLE_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--table�б������ʾ����Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����tabs�������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_TABS';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--tabsѡ����������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����tabs���items����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_TABS_ITEM';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_TABS_ITEM';
  SQL_STR:=' select *  from '||TABLE_NAME||' where COMPONENT_TABS_ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--tabsѡ����items����Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����UDP_COMPONENT_TREE_SELECT�������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_TREE_SELECT';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_TREE_SELECT';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--������ѡ�������������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����UDP_COMPONENT_DATE_PICKER�������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_DATE_PICKER';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_DATE_PICKER';
  SQL_STR:=' select *  from '||TABLE_NAME||' where ID in ('||SELECT_COMPONENT_BY_PAGEID||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--ʱ��ѡ�������������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����udp_component_data_source�������Դ����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_COMPONENT_DATA_SOURCE';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_COMPONENT_SOURCE';
  if IS_COPY=1 then
    SELECT_COL:='  s. id, s.data_source, s.data_source_type, s.parent_field, s.pk_field, s.lable_field, s.created, s.creator_id,s.creator,s.modified, s.modifier_id,s.modifier,s.child_field, s.code,s.is_checked_last_stage, s.is_check, s.default_value, ''��''||s.id||''������������Ϣ'' remark';
    else
    SELECT_COL:='  s.* ';
    end if;
  SQL_STR:='select '||SELECT_COL||' FROM udp_component c RIGHT join udp_component_data_source s on c.component_data_source_id=s.id where c.id in ('||SELECT_COMPONENT_BY_PAGEID||') UNION ';
  SQL_STR:=SQL_STR||'select '||SELECT_COL||' from (SELECT case when instr(s.data_source,''?'',1,1) <>0 then  substr(s.data_source,instr(s.data_source,''?'',1,1)+1)||''&''  end conten  FROM udp_component c RIGHT join udp_component_data_source s on c.component_data_source_id=s.id where c.id in (';
  SQL_STR:=SQL_STR||SELECT_COMPONENT_BY_PAGEID||')';
 SQL_STR:=SQL_STR||' and  s.data_source LIKE ''/api/udp/getDataSource%'')  tab,udp_component_data_source s where  tab.conten   like ''%code=''||s.code||''&%'' ';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--����Դ��Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================�����������Դ�洢��������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_PROCEDURE_REGISTRATION';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_PROCEDURE_REGISTRATION';
    if IS_COPY=1 then
    SELECT_COL:=' r.ID ,r.NAME ,r.CODE ,r.STATE ,r.CREATED ,r.CREATOR_ID ,r.CREATOR ,r.MODIFIED ,r.MODIFIER_ID ,r.MODIFIER,''��''||r.ID||''������������Ϣ'' REMARK';
    else
    SELECT_COL:=' r.*';
    end if;
SQL_STR:='select '||SELECT_COL||' from UDP_PROCEDURE_REGISTRATION r where r.code in (select s.data_source from  (select component_data_source_id from UDP_COMPONENT where ID  in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
SQL_STR:=SQL_STR||' and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id where s.data_source_type=''procedure'') ';
SQL_STR:=SQL_STR|| ' UNION ';
SQL_STR:=SQL_STR||'select '||SELECT_COL||' from ( select  case when instr(s.data_source,''?'',1,1) <>0 then  substr(s.data_source,instr(s.data_source,''?'',1,1)+1)||''&''  end conten ';
SQL_STR:=SQL_STR||'from  (select component_data_source_id from UDP_COMPONENT where ID in  ('||SELECT_COMPONENT_BY_PAGEID||') ';
SQL_STR:=SQL_STR||'and component_data_source_id is not null) d left join UDP_COMPONENT_DATA_SOURCE s on d.component_data_source_id=s.id ';
SQL_STR:=SQL_STR||'where s.data_source LIKE ''/api/udp/getExecuteProcedureResult%'' or  s.data_source LIKE ''/api/udp/getRegisterResult%'' or  s.data_source LIKE ''/api/public/udp/getRegisterResult%'' )tab , UDP_PROCEDURE_REGISTRATION r ';
SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
SQL_STR:=SQL_STR||' UNION ';
SQL_STR:=SQL_STR||'select '||SELECT_COL||' from (select case when instr(EXECUTE_CONTENT,''?'',1,1) <>0 then  substr(EXECUTE_CONTENT,instr(EXECUTE_CONTENT,''?'',1,1)+1)||''&''  end conten   from UDP_COMPONENT_BUTTON_EVENT where COMPONENT_BUTTON_ID in   ('||SELECT_COMPONENT_BY_PAGEID||') ';
SQL_STR:=SQL_STR||'and EXECUTE_CONTENT LIKE ''/api/udp/getExecuteProcedureResult%'' or  EXECUTE_CONTENT LIKE ''/api/udp/getRegisterResult%'' or  EXECUTE_CONTENT LIKE ''/api/public/udp/getRegisterResult%'' ) tab, UDP_PROCEDURE_REGISTRATION r ';
    SQL_STR:=SQL_STR||'where tab.conten like ''%code=''||r.code||''&%'' ';
execute immediate ' select WMSYS.WM_CONCAT(t.ID)  from ('||SQL_STR||') t' INTO  REGISTRATION_IDS;
if REGISTRATION_IDS is not null then  REGISTRATION_IDS:=replace(REGISTRATION_IDS,',',''','''); end if;
REGISTRATION_IDS:=''''||REGISTRATION_IDS||'''';
SQL_STR:='select * from '||TABLE_NAME||' where ID in ('||REGISTRATION_IDS||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--�洢����ע����Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================�����������Դ�洢���̲�������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_PROCEDURE_PARAMETER';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_PROCEDURE_PARAMETER';
  SQL_STR:='select * from '||TABLE_NAME||' where PROCEDURE_REGISTRATION_ID in ('||' select ID  from ('||SQL_STR||') '||')';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--�洢���̲�����Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����UDP_EXPORT_EXCEL��������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_EXCEL';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
    if IS_COPY=1 then
    SELECT_COL:=' ID ,FILE_NAME ,CREATED ,CREATOR_ID ,CREATOR ,MODIFIED ,MODIFIER_ID ,MODIFIER ,''��''||ID||''������������Ϣ'' REMARK';
    else
    SELECT_COL:=' *';
    end if;
  SQL_STR:=' select '||SELECT_COL||' from  '||TABLE_NAME||' where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION  select '||SELECT_COL||' from '||TABLE_NAME||' where ID in  (select EXCEL_ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) )';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--����excel������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����UDP_EXPORT_SHEET��sheet��������=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_SHEET';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:=' select * from  '||TABLE_NAME||' where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION  select * from '||TABLE_NAME||' where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) ';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--����sheet������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================����UDP_EXPORT_SHEET_FIELD��sheet�����ֶ�����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_SHEET_FIELD';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_EXPORT_SHEET_FIELD';
  SQL_STR:=' select * from '||TABLE_NAME||' where  EXPORT_SHEET_ID in��select ID from  UDP_EXPORT_SHEET  where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION select ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) )';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--����sheet�ֶ���Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================�����ֶ�����=================================================*/
select count(*) into row_index from EXPORT_SQL_TABLE;
  --��Ҫ�����ı���
  TABLE_NAME := 'UDP_EXPORT_FIELD';
  --��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_'||TABLE_NAME;
  SQL_STR:=' select * from UDP_EXPORT_FIELD where ID in (select EXPORT_FIELD_ID from UDP_EXPORT_SHEET_FIELD where  EXPORT_SHEET_ID in��select ID from  UDP_EXPORT_SHEET  where EXCEL_ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') )';
  SQL_STR:=SQL_STR||' UNION select ID from  UDP_EXPORT_SHEET  where ID in  (select EXECUTE_CONTENT  from UDP_COMPONENT_BUTTON_EVENT  where  EXECUTE_TYPE=''export''  and COMPONENT_BUTTON_ID in ('||SELECT_COMPONENT_BY_PAGEID||') ) ) )';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR=>'--�����ֶ�������Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
/*=================================��ѯ������sql�����Ϣ=================================================*/
 if IS_COPY is not null and IS_COPY <> 0 then
  open EXPORT_SQL_LIST for 'select ID,TABLE_NAME,
  CASE 
  WHEN TABLE_NAME IS NOT NULL
  THEN
   substr(substr(SQL,instr(SQL,'') values ('',1,1)+11,length(SQL)),0,
    instr( substr(SQL,instr(SQL,'') values ('',1,1)+11,length(SQL)) ,'','',1,1)-2
   )
  END  PKID,SQL from EXPORT_SQL_TABLE where  TABLE_NAME is null or  instr(TABLE_NAME,''(DELETE)'',1,1)=0   order by ID';
  else
     open EXPORT_SQL_LIST for 'select replace(replace(SQL,''''''$("time")$'',''to_date(''''''),''$("timeend")$'''''','''''',''''yyyy-mm-dd hh24:mi:ss'''')'') SQL from EXPORT_SQL_TABLE order by ID';
  end if;
  commit;
end P_UDP_EXPORT_SQL_BY_PAGEID;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_EXPORT_SQL_BY_PROCODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_EXPORT_SQL_BY_PROCODE" (CODE in VARCHAR2, EXPORT_SQL_LIST OUT SYS_REFCURSOR)  AUTHID current_user 
as
str_sql VARCHAR2(4000);
TEMP_TABLE_NAME VARCHAR2(200);
TABLE_NAME VARCHAR2(200);
SQL_STR VARCHAR2(4000);
EXPORT_SQL CLOB :='';
row_index NUMBER;
TABLEEXIST NUMBER;
begin
    row_index:=1;
     str_sql := 'create global temporary table EXPORT_SQL_TABLE  (
        ID INT,
        TABLE_NAME VARCHAR(1000),
        SQL  VARCHAR(4000)
     ) 
    on commit preserve rows';
    --�ж���ʱ���Ƿ���ڴ��ھ�ɾ��
    select count(1) into TABLEEXIST from user_tables where table_name = 'EXPORT_SQL_TABLE';
    if TABLEEXIST=0 then 
     --������ʱ��
    execute immediate str_sql;
    else 
    execute immediate 'delete EXPORT_SQL_TABLE';
    end if;

  insert into EXPORT_SQL_TABLE VALUES(row_index,'','set define off;');
/*=================================�洢����ע����Ϣ����=================================================*/
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_PROCEDURE_REGISTRATION';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_PROCEDURE_REGISTRATION';
--��ѯ���
  SQL_STR:='  select * from '||TABLE_NAME||' where CODE='''||CODE||'''  and  STATE=1';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--�洢����ע����Ϣ��ʼ��',
    SQL_STR => EXPORT_SQL
  );
    --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
  /*=================================�洢���̲���ע����Ϣ����=================================================*/
  select count(*) into row_index from EXPORT_SQL_TABLE;
 --��Ҫ�����ı���
  TABLE_NAME := 'UDP_PROCEDURE_PARAMETER';
--��Ҫ��������ʱ����
  TEMP_TABLE_NAME:='TEMP_PROCEDURE_PARAMETER';
  --��ѯҳ����ʾ�����id�ļ���
  SQL_STR:=' select * from '||TABLE_NAME||' WHERE PROCEDURE_REGISTRATION_ID IN (select ID from UDP_PROCEDURE_REGISTRATION where CODE='''||CODE||''' and  STATE=1)';
--������ʱ�����ɳ�ʼ��sql���
   P_UDP_EXPORT_SQL_BY_TABLE_NAME(
    TEMP_TABLE_NAME => TEMP_TABLE_NAME,
    TABLENAME => TABLE_NAME,
    ROW_INDEX =>row_index,
    WHERE_SQL_STR=>SQL_STR,
    COMMENT_STR => '--�洢���̲���ע����Ϣ��ʼ��' ,
    SQL_STR => EXPORT_SQL
  );
  --��ʼ��sql����¼����ʱ����
  execute immediate '  insert into EXPORT_SQL_TABLE  '||EXPORT_SQL;
  --ɾ����ʱ��
  execute immediate 'drop table '||TEMP_TABLE_NAME;
  /*=================================��ѯ������sql�����Ϣ=================================================*/
  open EXPORT_SQL_LIST for 'select replace(replace(SQL,''''''$("time")$'',''to_date(''''''),''$("timeend")$'''''','''''',''''yyyy-mm-dd hh24:mi:ss'''')'') SQL from EXPORT_SQL_TABLE order by ID';
  commit;
end  P_UDP_EXPORT_SQL_BY_PROCODE;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_EXPORT_SQL_BY_TABLE_NAME
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_EXPORT_SQL_BY_TABLE_NAME" (temp_table_name in VARCHAR2,tablename  in VARCHAR2,row_index in NUMBER,WHERE_SQL_STR  in VARCHAR2,COMMENT_STR in VARCHAR2 ,sql_str out  CLOB)  AUTHID current_user 
as
sqlstr  VARCHAR2(4000);
sqlstr1 VARCHAR2(4000);
sqlstr2 VARCHAR2(4000);
colimns VARCHAR2(4000);
TABLE_NAME  VARCHAR2(4000);
ROW_NUMBER NUMBER;
ROW_COUNT NUMBER;
WHERE_SQL  VARCHAR2(4000);
TABLE_NAME_STR VARCHAR2(4000);
begin
   TABLE_NAME:=upper(tablename);
    P_UDP_CREATE_TEMP_TABLE(
     TEMP_TABLE_NAME => TEMP_TABLE_NAME,
     TABLENAME => TABLE_NAME,
     SQL_STR=>WHERE_SQL_STR
    );
    execute immediate ' alter session set nls_date_format = ''yyyy-mm-dd hh24:mi:ss''';
    TABLE_NAME_STR:=''''||TABLE_NAME||''',';
    ROW_NUMBER:=row_index+1;
    sqlstr:='';
    ROW_COUNT:=0;
    if WHERE_SQL_STR is not null
    then 
    WHERE_SQL:=replace(WHERE_SQL_STR,'''','''''');
     execute immediate ' select COUNT(1)  from ('||WHERE_SQL_STR||') t' INTO  ROW_COUNT;
    end if;
    if COMMENT_STR is not null AND ROW_COUNT<>0 
    then 
    --ƴ��sqlע��
    sqlstr:=' select '||ROW_NUMBER||','''','''||COMMENT_STR||''' from dual  UNION ';
    ROW_NUMBER:=ROW_NUMBER+1;
    sqlstr:=sqlstr||' select '||ROW_NUMBER||','||''''||TABLE_NAME||'(DELETE)'''||',''delete '||TABLE_NAME||' where ID in  (select t.ID from ('||WHERE_SQL||') t );'' from dual  UNION ';
    end if;
     --ƴ�Ӳ����������
     sql_str:='select '||ROW_NUMBER||'+ROWNUM, '||TABLE_NAME_STR||'  ''insert into '||upper(tablename);
     SELECT WMSYS.WM_CONCAT(t.column_name) INTO colimns  FROM USER_TAB_COLUMNS t where t.TABLE_NAME=upper(temp_table_name);
     sqlstr2:='('||colimns||') values (';
     SELECT  WMSYS.WM_CONCAT(t.col) into sqlstr1
	 FROM (
    SELECT  CASE a.data_type 
    WHEN 'NUMBER'
    THEN  '''||case when '||a.column_name||' is null then ''0''  else to_char('||a.column_name ||')  end || '''
    WHEN 'DATE'
    THEN    '''''''||case when '||a.column_name||' is  not  null then  ''$("time")$''||replace('||a.column_name||','''''''','''''''''''')||''$("timeend")$''' || 'end || '''''''
    else 
    '''''''||case when '||a.column_name||' is  not  null then replace('||a.column_name||','''''''','''''''''''')' || 'end || '''''''
    END AS COL,a.column_id,a.column_name FROM USER_TAB_COLUMNS a where a.TABLE_NAME=upper(temp_table_name)
     ) t ORDER BY column_id;
     sqlstr1:=replace(sqlstr1,'||,','||'',');
     sqlstr1:=sqlstr1||');''';
     sql_str:=sqlstr||sql_str||sqlstr2||sqlstr1||' from '||upper(temp_table_name);
end P_UDP_EXPORT_SQL_BY_TABLE_NAME;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_PAGE_COMPONENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_PAGE_COMPONENTS" (containerGuid in varchar,pageComponents OUT sys_refcursor,treeSelect OUT sys_refcursor,tabs OUT sys_refcursor,tableColumn OUT sys_refcursor,buttoneEvent OUT sys_refcursor,eventMonitoring OUT sys_refcursor,datePicker OUT sys_refcursor)
AS  
haspage INTEGER;
BEGIN  
select count(1) into haspage  from UDP_PAGE where ID=containerGuid;
if haspage=1
then
open pageComponents for  
select   c.ID componentId,                                 --���ID
c.COMPONENT_HIGH componentHeight,                          --����߶�
c.COMPONENT_WIDE componentWidth,                            --������
p.TITLE  pageTitle,                                                                    --ҳ�����
p.WINDOW_WIDTH  windowWidth,                                      --�򿪴��ڿ��
p.WINDOW_HEIGHT windowHeight,                                     --�򿪴��ڸ߶�
c.COMPONENT_ORDER,                                                           --չʾ˳�� 
c.COMPONENT_NAME componentName,                           --�������
c.COMPONENT_LABLE lable,                                                   --���չʾ����
c.COMPONENT_TYPE componentType,                                --�������
c.PLACEHOLDER placeholder,                                                 --չʾˮӡ����
p.LAYOUT_TEMPLATE_ID templateName,                              --ʹ��ģ������
l.LAYOUT_AREA_TEMPLATE_ID regionMark,                        --ʹ�������ʶ����
s.IS_CHECK,                                                                                 --�Ƿ��ܹ���ѡ
s.IS_CHECKED_LAST_STAGE,                                                    --�Ƿ�ֻ��ѡ����ĩ��
'' default_value,                                                                           --Ĭ��ֵ
s.DATA_SOURCE_TYPE,                                                             --����Դ����
s.DATA_SOURCE componentSource,                                      --�������Դ
s.PK_FIELD,                                                                                    --�����ֶ�
s.LABLE_FIELD,                                                                              --չʾ�ֶ�
c.DATA_SOURCE                                                                          --չʾ����(TemplateHyperText��TemplateContainer)
 from  UDP_LAYOUT l  
 left join UDP_PAGE P on  l.page_id=p.ID
 left join UDP_COMPONENT c on  l.COMPONENT_ID=c.ID 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
where l.PAGE_ID=containerGuid and l.page_id=c.page_id order by c.COMPONENT_ORDER asc;
else
open pageComponents for  
select   c.ID componentId,                                                      --���ID
c.COMPONENT_HIGH componentHeight,                          --����߶�
c.COMPONENT_WIDE componentWidth,                            --������
''  pageTitle,                                                                              --ҳ�����
''  windowWidth,                                                                       --�򿪴��ڿ��
'' windowHeight,                                                                       --�򿪴��ڸ߶�
c.COMPONENT_ORDER ,                                                         --չʾ˳�� 
c.COMPONENT_NAME componentName,                           --�������
c.COMPONENT_LABLE lable,                                                  --���չʾ����
c.COMPONENT_TYPE componentType,                               --�������
c.PLACEHOLDER placeholder,                                                --չʾˮӡ����
'' templateName,                                                                        --ģ������
l.LAYOUT_AREA_TEMPLATE_ID regionMark,                       --ʹ�������ʶ����
s.IS_CHECK,                                                                                --�Ƿ��ܹ���ѡ
s.IS_CHECKED_LAST_STAGE,                                                   --�Ƿ�ֻ��ѡ����ĩ��
'' default_value,                                                                          --Ĭ��ֵ
s.DATA_SOURCE_TYPE,                                                             --����Դ����
s.DATA_SOURCE componentSource,                                      --�������Դ
s.PK_FIELD,                                                                                    --�����ֶ�
s.LABLE_FIELD,                                                                              --չʾ�ֶ�
c.DATA_SOURCE                                                                       --չʾ����(TemplateHyperText��TemplateContainer)
from UDP_COMPONENT c
left join UDP_LAYOUT l on  l.COMPONENT_ID=c.ID 
left join UDP_COMPONENT_DATA_SOURCE s on c.COMPONENT_DATA_SOURCE_ID=s.ID
where c.PAGE_ID=containerGuid order by c.COMPONENT_ORDER asc;
end if;

open treeSelect for  
select  
c.id componentId,                                                                     --���ID
t.default_expanded,                                                                  --Ĭ��չ��
t.default_checked,                                                                      --Ĭ��ѡ��
t.IS_CHECKED_LAST_STAGE                                                      --�Ƿ�ֻ��ѡ����ĩ��
from  UDP_COMPONENT c 
left join UDP_COMPONENT_TREE_SELECT t on t.ID=c.id
where c.page_id=containerGuid and (c.component_type='TemplateTreeSelect') ;


open tabs for  
select  
c.id componentId,                                                               --���ID
t.default_tabsitem,                                                              --Ĭ��ѡ����
t.layout_style,                                                                       --Ĭ����ʽ
i.ITEM_VALUE,                                                                       --tabs����������ֵ
i.ITEM_LABLE,                                                                        --tabs�������չʾֵ
i.ID                                                                                          --tabs�������ID
from  UDP_COMPONENT c 
left join UDP_COMPONENT_TABS t on t.ID=c.id
left join UDP_COMPONENT_TABS_ITEM i on t.ID=i.COMPONENT_TABS_ID
where c.page_id=containerGuid and (c.component_type='TemplateTabs') order by i.item_order;

open tableColumn for
select 
n.ID,
c.ID componentId,                                                     --���ID
n.COLUMN_LABLE,                                                     --�б���
n.COLUMN_FIELD  ,                                                    --���ֶ���
n.COLUMN_WIDE ,                                                     --�п��
n.COLUMN_ALIGN ,                                                   --�ж���
n.COLUMN_FIXED ,                                                    --����������left,right��
2 COLUMN_NUMBER_FLOAT,                               --С���ֶα�����λ
n.COLUMN_DATA_TYPE ,                                         --��������
n.is_show_total,                                                          --�Ƿ���ʾ�ϼ�
n.parent_column_id,                                                  --����������
n.is_use_sort,                                                              --�Ƿ�ʹ������
d.IS_CHECK,                                                                 --�Ƿ�ѡ
t.detail_url,                                                                   --˫������ת��ַ
d.PK_FIELD,                                                                  --�����ֶ�
n.JUMP_URL,                                                               --�������ת��ַ
n.OPEN_MODE,                                                           --����д�ҳ�淽ʽ
t.OPEN_MODE DETAIL_MODE,                                 --˫���д�ҳ�淽ʽ
n.WINDOW_WIDTH,                                                   --�����д򿪵����Ŀ��
n.WINDOW_HEIGHT,                                                   --�����д򿪵����ĸ߶�
n.DEAL_WITH_MODE,                                                  --�����д����ģʽ
t.WINDOW_WIDTH as "ROW_WINDOW_WIDTH",  --˫���д򿪵����Ŀ��
t.WINDOW_HEIGHT as "ROW_WINDOW_WIDTH",  --˫���д򿪵����ĸ߶�
n.IS_USE_HTML,
'' is_show_stripe from UDP_COMPONENT c 
left join UDP_COMPONENT_TABLE_COLUMN n on c.ID=n.component_table_id
left join UDP_COMPONENT_TABLE  t on c.ID=t.ID
left join UDP_COMPONENT_DATA_SOURCE  d on d.ID=c.COMPONENT_DATA_SOURCE_ID
where c.page_id=containerGuid and (lower(c.component_type)='templatetable' or lower(c.component_type)='templatetreetable' )
and n.STATE=1
order by n.COLUMN_ORDER asc;
open buttoneEvent for
SELECT
    e.COMPONENT_BUTTON_ID,                                 --��ť���ID
    b.TRADE_ID,                                                               --Ȩ�޵�ID
    b.icon,                                                                         --��ťͼ��
    e.EVENT_TYPE ,                                                          --��ť�¼�����
    e.EXECUTE_TYPE ,                                                      --��ťִ������
    e.EXECUTE_CONTENT,                                              --��ťִ������
    e.DIALOG_TITLE,                                                        --�����������
    e.DIALOG_CONTEN,                                                   --�����������
    e.WINDOW_WIDTH,                                                   --�򿪵����Ŀ��
    e.WINDOW_HEIGHT                                                   --�򿪵����ĸ߶�
FROM
    UDP_COMPONENT c 
    left join UDP_COMPONENT_BUTTON_EVENT e  on c.ID=e.COMPONENT_BUTTON_ID
    left join udp_component_button b  on c.ID=b.ID
    where c.PAGE_ID=containerGuid and  e.COMPONENT_BUTTON_ID  is not null;

open eventMonitoring for
select 
m.ID,                                                                              --�¼���������
m.COMPONENT_ID ,                                                   --���ID
m.TARGET_COMPONENT_ID ,                                   --���������ID
c.COMPONENT_TYPE ,                                                --�������
m.IS_MUST_MONITORING   from UDP_EVENT_MONITORING m 
left join UDP_COMPONENT c on m.TARGET_COMPONENT_ID=c.ID
where m.component_id in (select  c.ID   from UDP_COMPONENT c where  c.PAGE_ID=containerGuid);

open datePicker for
select 
c.ID componentId,                                                     --���ID
d.START_TIME,                                                           --��ʼʱ��
d.END_TIME,                                                               --����ʱ��
d.DEFAULT_VALUE,                                                   --Ĭ��ʱ��
d.VALUE_FORMAT                                                    --ʱ���ʽ
from  UDP_COMPONENT c 
left join UDP_COMPONENT_DATE_PICKER d on c.ID=d.ID
where  c.PAGE_ID=containerGuid and (lower(c.component_type)='templatedatepicker' or lower(c.component_type)='templatedatetimepicker' );
END P_UDP_PAGE_COMPONENTS;

/
--------------------------------------------------------
--  DDL for Procedure P_UDP_PROCEDURE_CONFIG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_UDP_PROCEDURE_CONFIG" (procedure_code in varchar,procedureConfigs OUT sys_refcursor)
AS  
BEGIN  
open procedureConfigs for  
SELECT
    r.id,                                                                                 --�洢����������Ϣ������
    r.name,                                                                          --�洢������
    r.code,                                                                            --���ñ�ʶcode
    r.state,                                                                            --�Ƿ�����
    p.parameter_name,                                                      --�洢���̲�����
    p.data_source_keyword,                                              --����������Դ�Ĺؼ��ֱ�ʶ
    p.parameter_default,                                                    --����Ĭ��ֵ
    case  sys.IN_OUT                                                           --�Ƿ�Ϊ�������
    when 'IN' then 1
    else 0 
    end as is_input_parameter,                                          --�Ƿ�Ϊ�������
    sys.DATA_TYPE as parameter_type,                           --��������
    sys.SEQUENCE as sort                                                  --��������
FROM
    udp_procedure_registration r left join UDP_PROCEDURE_PARAMETER p on r.ID=p.PROCEDURE_REGISTRATION_ID
    left join sys.user_arguments sys on upper(r.name)=sys.OBJECT_NAME and upper(p.parameter_name)=sys.ARGUMENT_NAME
    where code=procedure_code;
END p_UDP_Procedure_Config;


/
--------------------------------------------------------
--  DDL for Procedure P_WFI_COPY_TO_INFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_WFI_COPY_TO_INFO" (
    noticePersons  IN   CLOB,              --�û�code���
    noticeGroups   IN    CLOB,             --������
    noticeProjectRoles    IN     CLOB,    --��Ŀ����ɫ
    noticeTitle    IN     varchar2,           -- ����֪ͨ����
    addressParams in varchar2,           --ҳ�����
    workItemID  in  varchar2,               --������ID
    processInstID  in varchar2,             --����ʵ��ID
    pchost in varchar2,                         --pc������
    mobilehost in varchar2,                   --pc������
    messageType out      varchar2,       --0:�Ż��ն���Ϣ�����ͣ�1��ֻ�����Ż���2��ֻ���Ͷ��Ż�΢��
    info     OUT      SYS_REFCURSOR     --��Ϣ����
) IS
toreadpc  varchar2(1000);
toreadmobile  varchar2(1000);
systemId  varchar2(100);
systemappId  varchar2(100);
bizMsgCategory varchar2(100);
creater varchar2(100);
processName varchar2(4000);
portalMsgType number;
formcode  varchar2(1000);
addressParamsStr varchar2(1000);
begin
  execute immediate ' alter session set nls_date_format = ''yyyy-mm-dd hh24:mi:ss''';
  toreadpc:=pchost||'/wfi-sys/process-operation';
  toreadmobile:=mobilehost||'/wfi/process-info';
  messageType:=1;
  portalMsgType:=10;
  bizMsgCategory:='�߰���Ϣ';
  if addressParams is not null then
  addressParamsStr:=replace(addressParams,'||','&');
  end if;
  select PROCESS_INST_NAME,CREATEBY,FORM_CODE into processName,creater,formcode from WFI_PROCESS_INST where Id=processInstID and rownum=1;
  select f.SYSTEM_ID,s.APP_ID into systemId,systemappId from WFI_BIZ_FORM f left join SYS_APPLICATION s on f.SYSTEM_ID=s.ID  where f.FORM_CODE=formcode;
  p_wfi_person_role_analysis(
    noticePersons => noticePersons,
    noticeGroups => noticeGroups,
    noticeProjectRoles =>noticeProjectRoles
  );
 OPEN info FOR 
    select 
    creater as "senderAccount",                        --������
    persons.user_code as  "recipientAccount",    --������
    systemId as  "systemId",--ϵͳid
    systemappId as   "appid",--Ӧ��id
    workItemID||persons.user_code as "bizKey",--ҵ��id--�Ż���վ��taskId
    bizMsgCategory as "bizMsgCategory",--��Ϣ�������
-------------------------------------------------------------������΢�ű��롿������Ϣ ------------------------------------------------------------
    '' as "msgChannel", --ʹ����Ϣ���� ��������ŷָ�   tjWeChat������΢��,tjSMS����������
    '' as "smsTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID  --{1}���ã�{2}�������������{3}�������˴߰죬�뼰ʱ���Ż���վ�鿴���첢�ڡ��ƻ�����ϵͳ���з����������{4}��
    '[]' AS "smsParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
    ''  as "mobile",--���Ž����˵绰
    '' AS "wechatTemplateid",--ģ�� ID������Ѷ�ƶ������ͨ����ģ�� ID
    '[]' AS "wechatParams",--������Ϣ������--ʵ���磺["����","����0522"] ---����ʱ�ᰴ˳���滻ģ���λ��=��
    '' AS "wechatJumplinkUrl",--΢�Ŵ򿪵�ַ��������÷���Ϣǰ��Ҫ����
    '' AS "title",--��Ϣ����
    '' AS "bizSourceCategory",
-------------------------------------------------------------���Ż���Ϣ���롿������Ϣ ------------------------------------------------------------
    portalMsgType as "portalMsgType",
    CASE 
    when addressParamsStr is not null then
    toreadpc||'?'||addressParamsStr
    else 
    toreadpc end as "url",--pc�˵�url��ַ
    case when addressParamsStr is not null then
    toreadmobile||'?'||addressParamsStr 
    else toreadmobile  end as "mobileUrl",--�ƶ��˵�url��ַ
    case 
    when noticeTitle is not null then
    noticeTitle||'��'||processName
    else 
    processName end as "taskname", --�������ƣ�����3���������/4����������informationname;���ڲ����ע��attentionname
    '�ƻ���Ӫ' as "typename",--��������
    '������ƽ̨������Ϣ����' as "remark",
     to_char(sysdate,'yyyy-MM-dd HH24:mi:ss')  "expiretime",--expiretime	��	String	����ʱ�䣬��ʽyyyy-MM-dd HH:mm:ss-----����ʱ�䣬����ע����
     1  "priority"--priority	��	Integer	���ȼ�������ע���� 
    from 
    (select  distinct tab1.USER_ACCOUNT as user_code from (SELECT r.USER_CODE USER_ACCOUNT from (select code from PERSON_ROLE_ANALYSIS_TABLE where  type='person') tab left join SYS_USER r on r.USER_CODE = tab.code
   union select r.USER_ACCOUNT from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='group' and detail  is not null) tab left join SYS_ROLE_USER_RELATION_RESULT r on 
   tab.code=r.VIRTUAL_GROUP_NAME where r.role_type=40 and (r.COMPANY_ID=tab.detail or r.DEPT_ID=tab.detail)
   union select r.USER_ACCOUNT from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='projectRole'  and detail  is not null) tab left join SYS_ROLE_USER_RELATION_RESULT r on 
   tab.code=r.role_code  where r.role_type=30 and r.PROJECT_ID=tab.detail) tab1) persons where persons.user_code is not null;
END p_wfi_copy_to_info;

/
--------------------------------------------------------
--  DDL for Procedure P_WFI_FORM_DATA_BY_BIZ_ID
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_WFI_FORM_DATA_BY_BIZ_ID" (
    biz_id in VARCHAR2,                    --ҵ������
    process_inst_id in VARCHAR2,       --����ʵ��ID
    code OUT VARCHAR2,                  --ҵ���code
    formData OUT SYS_REFCURSOR,    -- ��������ݽ�����α�
    fieldData OUT SYS_REFCURSOR      -- ������ֶν�����α�
  )
AS
  v_sql    VARCHAR2(4000);                               
  id_field VARCHAR2(50);
  bizId VARCHAR2(50);
BEGIN
execute immediate ' alter session set nls_date_format = ''yyyy-mm-dd hh24:mi:ss''';
SELECT 
    form_code,biz_id  into code,bizId
FROM
    wfi_process_inst where ID=process_inst_id and ROWNUM=1;
SELECT
    d.field_name INTO id_field
FROM
    wfi_biz_form f,wfi_biz_field d 
where form_code=code and f.id=d.form_id and d.is_pk=1 and ROWNUM=1;
SELECT
    form_sql INTO v_sql
FROM
    wfi_biz_form where form_code=code and ROWNUM=1;
open fieldData for  
SELECT
   d. chinese_name,d.field_name,d.IS_SHOW
FROM
    wfi_biz_form f,wfi_biz_field d 
where form_code=code and f.id=d.form_id and form_code=code order by d.sort;
if  instr(v_sql,'{bizId}',1,1)<>0 then
   v_sql :=replace(v_sql,'{bizId}',bizId);
else 
     v_sql :=replace(v_sql,';','');
    v_sql  :='select * from (' || v_sql || ' ) where  ROWNUM=1 and   '||id_field||' =  '''|| bizId||'''';
end if;
    dbms_output.put_line(v_sql);
OPEN formData FOR v_sql;
EXCEPTION
WHEN OTHERS THEN
  CLOSE formData;
END P_WFI_FORM_DATA_BY_BIZ_ID;

/
--------------------------------------------------------
--  DDL for Procedure P_WFI_PERSON_ROLE_ANALYSIS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_WFI_PERSON_ROLE_ANALYSIS" (
    noticePersons  IN   CLOB,     --�û�code���
    noticeGroups   IN    CLOB,    --������
    noticeProjectRoles    IN     CLOB --��Ŀ����ɫ
) IS
begin
delete PERSON_ROLE_ANALYSIS_TABLE;

if noticePersons is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE (code , type ) SELECT COLUMN_VALUE ,'person' as type 
FROM table (split (noticePersons,';'));
end if;

if noticeGroups is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE SELECT splitstr(COLUMN_VALUE,1) as code,splitstr(COLUMN_VALUE,2) as detail ,'group' as type 
FROM table (split (noticeGroups,';'));
end if;

if noticeProjectRoles is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE SELECT splitstr(COLUMN_VALUE,1) as code,splitstr(COLUMN_VALUE,2) as detail ,'projectRole' as type 
FROM table (split (noticeProjectRoles,';'));
end if;

end p_wfi_person_role_analysis;

/
--------------------------------------------------------
--  DDL for Procedure P_WFI_SAVE_FORM_CATALOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_WFI_SAVE_FORM_CATALOG" (systemId in VARCHAR2, UUID in VARCHAR2,NEWUUID in VARCHAR2,CATALOGCODE in VARCHAR2,CATALOGNAME in varchar,code OUT NUMBER,msg OUT VARCHAR2)
as
  row_count number;
  appid VARCHAR2(36);
BEGIN
  select count(1) into row_count from SYS_APPLICATION where id=systemId;
  if row_count=1 then
    select APP_ID into appid from SYS_APPLICATION where id=systemId;
    select count(1) into row_count from WFI_BIZ_FORM_CATALOG where ID=UUID;
    if row_count=0 then
        Insert into WFI_BIZ_FORM_CATALOG (ID,APP_ID,CODE,NAME) values (UUID,appid,CATALOGCODE,CATALOGNAME);
        code:=0;
        msg:='����ҵ��Ŀ¼��Ϣ�ɹ�';
    else
        UPDATE WFI_BIZ_FORM_CATALOG SET APP_ID=appid,CODE=CATALOGCODE,NAME=CATALOGNAME,ID=NEWUUID WHERE ID=UUID;
        select count(1) into row_count from WFI_BIZ_FORM where CATALOG_UUID=UUID;
            if  row_count<>0 then
                UPDATE WFI_BIZ_FORM SET BELONG_SYSTEM=CATALOGCODE,SYSTEM_ID=systemId,CATALOG_UUID=NEWUUID WHERE CATALOG_UUID=UUID;
            end if;
           code:=0;
           msg:='����ҵ��Ŀ¼��Ϣ�ɹ�';
    end if;
  ELSE
  code:=1000;
  msg:='���������Ч';
  end if;
  exception 
        when DUP_VAL_ON_INDEX then 
        code:=100;
        msg:='ҵ��Ŀ¼ID�ظ�';
        rollback;
END P_WFI_SAVE_FORM_CATALOG;

/
--------------------------------------------------------
--  DDL for Procedure POM_KEY_NODE_MY_REMINDER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "POM_KEY_NODE_MY_REMINDER" 
(
    REMINDERGUID IN VARCHAR2,
    pageIndex    IN INT,
    pageSize     IN INT,
    total        OUT INT,
    items        OUT SYS_REFCURSOR
)
IS
    v_count clob;
    v_sql clob;
BEGIN
    v_sql := '
    SELECT *
    FROM (SELECT tt.*, ROWNUM AS rowno
          FROM (
            select total.* from  (
                           select
                               node.id AS "id",
                               node.original_node_id  AS "nodeOriginalId",
                               --δ���ڲ�����
                               case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                   --���ڵ�������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                        then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                   --����1-5������ɷ���
                                   when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                    --����δ�����Ƶ�
                                    WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                             THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                    --���ڳ���5��δ�������
                                    WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                             THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                         ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                    case when node.actual_end_date is not null
                                            then ''�����''
                                        when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                            then ''δ����''
                                        when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                            then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                    TO_CHAR(smrb.created_time, ''YYYY-MM-DD'')  AS "urgeTime",
                                    node.node_name AS "taskName",
                                    node.node_level  AS "taskLevel",
                                    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                    plan.plan_type AS "planType",
                                    plan.id AS "planId",
                                    nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                    plan.plan_name AS "originPlan",
                                    node.duty_department AS "dutyDept",
                                    unit.org_name AS "secondCompany"
                          from SYS_MSG_RECORD_BIZ smrb
                                   left join SYS_MSG_RECORD_SMS smrs on smrs.MSG_RECORD_BIZ_ID = smrb.ID
                                   left join sys_user sy on smrs.sender_id = sy.user_code
                                   left join pom_proj_plan_node node on smrb.BIZ_KEY = node.id
                                   left join pom_proj_plan plan on node.proj_plan_id = plan.id
                                   left join sys_project sp on plan.proj_id = sp.id
                                   left join sys_project_stage sps on plan.proj_id = sps.id
                                   left join sys_business_unit unit on plan.company_id = unit.id
                          where smrb.biz_msg_category = ''�߰���Ϣ''
                            and smrb.system_id = ''71313f018a35f3a558166cba7599b5d6''
                            and plan.plan_type = ''�ؼ��ڵ�ƻ�''
                            and plan.approval_status = ''�����''
                            and sy.id = '''||REMINDERGUID||'''
                            and node.is_disable = 0
                          union
                            select
                                node.id AS "id",
                                node.original_node_id  AS "nodeOriginalId",
                                --δ���ڲ�����
                                case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                    --���ڵ�������ɷ���
                                     when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                         then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                    --����1-5������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --����δ�����Ƶ�
                                WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                         THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --���ڳ���5��δ�������
                                WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                         THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                     ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                case when node.actual_end_date is not null
                                        then ''�����''
                                    when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''δ����''
                                    when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                TO_CHAR(smrb.created_time, ''YYYY-MM-DD'')  AS "urgeTime",
                                node.node_name AS "taskName",
                                node.node_level  AS "taskLevel",
                                TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                plan.plan_type AS "planType",
                                plan.id AS "planId",
                                nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                plan.plan_name AS "originPlan",
                                node.duty_department AS "dutyDept",
                                unit.org_name AS "secondCompany"
                          from SYS_MSG_RECORD_BIZ smrb
                              left join SYS_MSG_RECORD_WECHAT smrw on smrw.MSG_RECORD_BIZ_ID = smrb.ID
                              left join sys_user sy on smrw.sender_id = sy.user_code
                              left join pom_proj_plan_node node on smrb.BIZ_KEY = node.id
                              left join pom_proj_plan plan on node.proj_plan_id = plan.id
                              left join sys_project sp on plan.proj_id = sp.id
                              left join sys_project_stage sps on plan.proj_id = sps.id
                              left join sys_business_unit unit on plan.company_id = unit.id
                          where
                              smrb.biz_msg_category = ''�߰���Ϣ''
                            and smrb.system_id = ''71313f018a35f3a558166cba7599b5d6''
                            and plan.plan_type=''�ؼ��ڵ�ƻ�''
                            and plan.approval_status=''�����''
                            and sy.id='''||REMINDERGUID||'''
                            and node.is_disable = 0
                        union
                            select
                                node.id AS "id",
                                node.original_node_id  AS "nodeOriginalId",
                                --δ���ڲ�����
                                case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                    --���ڵ�������ɷ���
                                     when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                         then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                    --����1-5������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --����δ�����Ƶ�
                                WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                         THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --���ڳ���5��δ�������
                                WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                         THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                     ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                case when node.actual_end_date is not null
                                        then ''�����''
                                    when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''δ����''
                                    when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                TO_CHAR(smc.created, ''YYYY-MM-DD'')  AS "urgeTime",
                                node.node_name AS "taskName",
                                node.node_level  AS "taskLevel",
                                TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                plan.plan_type AS "planType",
                                plan.id AS "planId",
                                nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                plan.plan_name AS "originPlan",
                                node.duty_department AS "dutyDept",
                                unit.org_name AS "secondCompany"
                          from sys_message_center smc
                              left join sys_user sy on smc.creator_name = sy.user_code
                              left join pom_proj_plan_node node on smc.task_id = node.id
                              left join pom_proj_plan plan on node.proj_plan_id = plan.id
                              left join sys_project sp on plan.proj_id = sp.id
                              left join sys_project_stage sps on plan.proj_id = sps.id
                              left join sys_business_unit unit on plan.company_id = unit.id
                          where
                              smc.biz_msg_category = ''�߰���Ϣ''
                            and plan.plan_type=''�ؼ��ڵ�ƻ�''
                            and plan.approval_status=''�����''
                            and sy.id='''||REMINDERGUID||'''
                            and node.is_disable = 0
        )total order by total."planTime" asc
    ) tt
           WHERE ROWNUM <= '||pageSize||' * '||pageIndex||' )table_alias
           WHERE table_alias.rowno >= '||pageSize||' * ( '||pageIndex||' -1) + 1 ';

    v_count := 'select count(*) from  (
                           select
                               node.id AS "id",
                               node.original_node_id  AS "nodeOriginalId",
                               --δ���ڲ�����
                               case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                   --���ڵ�������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                        then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                   --����1-5������ɷ���
                                   when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                    --����δ�����Ƶ�
                                    WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                             THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                    --���ڳ���5��δ�������
                                    WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                             THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                         ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                    case when node.actual_end_date is not null
                                            then ''�����''
                                        when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                            then ''δ����''
                                        when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                            then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                    TO_CHAR(smrb.created_time, ''YYYY-MM-DD'')  AS "urgeTime",
                                    node.node_name AS "taskName",
                                    node.node_level  AS "taskLevel",
                                    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                    plan.plan_type AS "planType",
                                    plan.id AS "planId",
                                    nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                    plan.plan_name AS "originPlan",
                                    node.duty_department AS "dutyDept",
                                    unit.org_name AS "secondCompany"
                          from SYS_MSG_RECORD_BIZ smrb
                                   left join SYS_MSG_RECORD_SMS smrs on smrs.MSG_RECORD_BIZ_ID = smrb.ID
                                   left join sys_user sy on smrs.sender_id = sy.user_code
                                   left join pom_proj_plan_node node on smrb.BIZ_KEY = node.id
                                   left join pom_proj_plan plan on node.proj_plan_id = plan.id
                                   left join sys_project sp on plan.proj_id = sp.id
                                   left join sys_project_stage sps on plan.proj_id = sps.id
                                   left join sys_business_unit unit on plan.company_id = unit.id
                          where smrb.biz_msg_category = ''�߰���Ϣ''
                            and smrb.system_id = ''71313f018a35f3a558166cba7599b5d6''
                            and plan.plan_type = ''�ؼ��ڵ�ƻ�''
                            and plan.approval_status = ''�����''
                            and sy.id = '''||REMINDERGUID||'''
                            and node.is_disable = 0
                          union
                            select
                                node.id AS "id",
                                node.original_node_id  AS "nodeOriginalId",
                                --δ���ڲ�����
                                case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                    --���ڵ�������ɷ���
                                     when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                         then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                    --����1-5������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --����δ�����Ƶ�
                                WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                         THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --���ڳ���5��δ�������
                                WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                         THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                     ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                case when node.actual_end_date is not null
                                        then ''�����''
                                    when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''δ����''
                                    when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                TO_CHAR(smrb.created_time, ''YYYY-MM-DD'')  AS "urgeTime",
                                node.node_name AS "taskName",
                                node.node_level  AS "taskLevel",
                                TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                plan.plan_type AS "planType",
                                plan.id AS "planId",
                                nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                plan.plan_name AS "originPlan",
                                node.duty_department AS "dutyDept",
                                unit.org_name AS "secondCompany"
                          from SYS_MSG_RECORD_BIZ smrb
                              left join SYS_MSG_RECORD_WECHAT smrw on smrw.MSG_RECORD_BIZ_ID = smrb.ID
                              left join sys_user sy on smrw.sender_id = sy.user_code
                              left join pom_proj_plan_node node on smrb.BIZ_KEY = node.id
                              left join pom_proj_plan plan on node.proj_plan_id = plan.id
                              left join sys_project sp on plan.proj_id = sp.id
                              left join sys_project_stage sps on plan.proj_id = sps.id
                              left join sys_business_unit unit on plan.company_id = unit.id
                          where
                              smrb.biz_msg_category = ''�߰���Ϣ''
                            and smrb.system_id = ''71313f018a35f3a558166cba7599b5d6''
                            and plan.plan_type=''�ؼ��ڵ�ƻ�''
                            and plan.approval_status=''�����''
                            and sy.id='''||REMINDERGUID||'''
                            and node.is_disable = 0
                        union
                            select
                                node.id AS "id",
                                node.original_node_id  AS "nodeOriginalId",
                                --δ���ڲ�����
                                case WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                                    --���ڵ�������ɷ���
                                     when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                                         then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                                    --����1-5������ɷ���
                                    when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                                         then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --����δ�����Ƶ�
                                WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                                         THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                                --���ڳ���5��δ�������
                                WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                                         THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                                     ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' END AS "warnState",
                                case when node.actual_end_date is not null
                                        then ''�����''
                                    when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''δ����''
                                    when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                        then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                                TO_CHAR(smc.created, ''YYYY-MM-DD'')  AS "urgeTime",
                                node.node_name AS "taskName",
                                node.node_level  AS "taskLevel",
                                TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'')  AS "planTime",
                                TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'')  AS "estimateTime",
                                TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'')  AS "realityTime",
                                plan.plan_type AS "planType",
                                plan.id AS "planId",
                                nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                                plan.plan_name AS "originPlan",
                                node.duty_department AS "dutyDept",
                                unit.org_name AS "secondCompany"
                          from sys_message_center smc
                              left join sys_user sy on smc.creator_name = sy.user_code
                              left join pom_proj_plan_node node on smc.task_id = node.id
                              left join pom_proj_plan plan on node.proj_plan_id = plan.id
                              left join sys_project sp on plan.proj_id = sp.id
                              left join sys_project_stage sps on plan.proj_id = sps.id
                              left join sys_business_unit unit on plan.company_id = unit.id
                          where
                              smc.biz_msg_category = ''�߰���Ϣ''
                            and plan.plan_type=''�ؼ��ڵ�ƻ�''
                            and plan.approval_status=''�����''
                            and sy.id=:c
                            and node.is_disable = 0 )total';
     execute immediate v_count into total using REMINDERGUID;
    --dbms_output.put_line(v_sql);

     open items FOR v_sql;

END POM_KEY_NODE_MY_REMINDER;

/
--------------------------------------------------------
--  DDL for Procedure POM_KEY_NODE_MY_WATCH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "POM_KEY_NODE_MY_WATCH" 
(
    WatcherID    IN VARCHAR2,
    pageIndex    IN INT,
    pageSize     IN INT,
    total        OUT INT,
    items        OUT SYS_REFCURSOR
)
    IS
    v_count clob;
    v_sql clob;
BEGIN
    v_sql := 'SELECT *
    FROM (SELECT tt.*, ROWNUM AS rowno
          FROM (
                   select
                       node.id AS "id",
                       node.node_Name AS "taskName",
                       node.original_node_id  AS "nodeOriginalId",			
                       plan.id AS "planId",
                       case
                           --δ���ڲ�����
                           WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''''
                           --���ڵ�������ɷ���
                           when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
                               then ''<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>''
                           --����1-5������ɷ���
                           when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
                               then ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                           --����δ�����Ƶ�
                           WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 0 and 5
                               THEN  ''<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>''
                           --���ڳ���5��δ�������
                           WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(NODE.PLAN_END_DATE)) >5)
                               THEN  ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>''
                           ELSE ''<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>'' end as "warnState",
                       case when node.actual_end_date is not null
                                then ''�����''
                            when to_char(node.plan_end_date,''YYYY-MM-DD'') >to_char(sysdate,''YYYY-MM-DD'') and node.actual_end_date is  null
                                then ''δ����''
                            when TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') < TO_CHAR(sysdate, ''YYYY-MM-DD'') and node.actual_end_date is  null
                                then ''<span style="color:red">�ѳ���</span>'' end as "taskState" ,
                       TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') AS "planTime",
                       case when feed.approval_status = ''�����''
                            then TO_CHAR(node.ESTIMATE_END_DATE, ''YYYY-MM-DD'')
                       else '''' end AS "estimateTime",
                       TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') AS "realityTime",
                       plan.plan_type AS "planType",
                       nvl(sp.project_name, sps.stage_full_name) AS "originProj",
                       plan.plan_name AS "originPlan",
                       node.node_level AS "taskLevel",
                       node.duty_department AS "dutyDept",
                       unit.org_name AS "secondCompany"
                   from sys_biz_watch sbw
                             left join pom_proj_plan_node node on sbw.biz_id = node.id
                            left join pom_proj_plan plan on node.proj_plan_id = plan.id
                            left join pom_node_feedback feed on node.feedback_id = feed.id
                            left join sys_project sp on plan.proj_id = sp.id
                            left join sys_project_stage sps on plan.proj_id = sps.id
                            left join sys_business_unit unit on plan.company_id = unit.id
                   where is_un_watch = 0 and watcher_id = '''||WatcherID||''' and plan.plan_type=''�ؼ��ڵ�ƻ�'' and plan.approval_status=''�����'' and node.is_disable = 0 order by node.plan_end_date asc
               ) tt
           WHERE ROWNUM <= '||pageSize||' * '||pageIndex||') table_alias
 WHERE table_alias.rowno >= '||pageSize||' * ('||pageIndex||'-1) + 1';
    v_count := 'select count(*) from sys_biz_watch sbw
                             left join pom_proj_plan_node node on sbw.biz_id = node.id
                            left join pom_proj_plan plan on node.proj_plan_id = plan.id
                            left join pom_node_feedback feed on node.feedback_id = feed.id
                            left join sys_project sp on plan.proj_id = sp.id
                            left join sys_project_stage sps on plan.proj_id = sps.id
                            left join sys_business_unit unit on plan.company_id = unit.id
                   where is_un_watch = 0 and watcher_id = :c and plan.plan_type=''�ؼ��ڵ�ƻ�'' and plan.approval_status=''�����'' and node.is_disable = 0 order by node.plan_end_date asc';
     execute immediate v_count into total using WatcherID;
    --dbms_output.put_line(v_sql);
    open items for v_sql;
END POM_KEY_NODE_MY_WATCH;

/
--------------------------------------------------------
--  DDL for Procedure POM_KEY_NODE_SCHEDULE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "POM_KEY_NODE_SCHEDULE" 
(
    companyGUID IN VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id clob;
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '0001';
    ELSE
        v_id := companyGUID;
    END IF;
    v_sql :='with temp_origin as (
        select connect_by_isleaf as IS_END ,org.*,project_name,nvl(validtasks,0) AS validTasks,nvl(completenum,0) AS completenum,nvl(completed,0) AS completed,nvl(unfinished,0) AS unfinished,nvl(needResult,0) AS needResult,nvl(realResult,0) AS realResult,nvl(greenLight,0) AS greenLight,
        nvl(yellowLight,0) AS yellowLight,nvl(redlight,0) AS redlight,nvl(micompletenum,0) AS micompletenum,nvl(micompleted,0) AS micompleted,nvl(miunfinished,0) AS miunfinished,
        nvl(olcompletenum,0) AS olcompletenum,nvl(olcompleted,0) AS olcompleted,nvl(olunfinished,0) AS olunfinished,completionrate,dynamicresult
        from (
        select *
        from (select id, org_name as company, org_full_name, parent_id, ''1'' as isCompany,'''' as jumpUrl,order_hierarchy_code as code
        from sys_business_unit
        where is_company = 1)
        union
        select id, project_name as company, '''' as org_full_name, unit_id as parent_id, ''0'' as isCompany,''/pom/plan-assess/node-monitoring/plan-nodes?companyid=''||proj.unit_id||''&ppid=''||proj.id||''&planType=�ؼ��ڵ�ƻ�'' as jumpUrl,'''' as code
        from sys_project proj
        union
        select *
        from (select stage.id, stage.stage_full_name as company, stage.stage_full_name as org_full_name, stage.project_id as parent_id, ''0'' as isCompany,''/pom/plan-assess/node-monitoring/plan-nodes?companyid=''||sysP.unit_id||''&ppid=''||stage.id||''&planType=�ؼ��ڵ�ƻ�'' as jumpUrl,'''' as code
        from sys_project_stage stage left join sys_project sysP on stage.project_id = sysP.id
        order by stage.sn desc)
        ) org --��֯����
        left join
        (
        select proj.*,
        case when proj.validTasks is null or proj.validTasks = 0 or proj.completed = 0 then
        ''0''
        else to_char((proj.completed / proj.validTasks)*100, ''9999999990.00'') end as completionRate,
        case when proj.needResult is null or proj.needResult = 0 or proj.realResult = 0 then
        ''0''
        else to_char((proj.realResult / proj.needResult)*100, ''9999999990.00'') end as dynamicResult
        FROM (
        select A.*,B.completeNum,C.completed,D.unfinished,N.needResult,O.realResult,E.greenLight,F.yellowLight,G.redLight,H.miCompleteNum,I.miCompleted,J.miUnfinished,
        K.olCompleteNum,L.olCompleted,M.olUnfinished
        from (
        select sp.id, sp.project_name, nvl(count(node.id), 0) as validTasks
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --��Ч�ڵ�
        ) A
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS completeNum
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --Ӧ���
        ) B ON A.ID = B.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS completed
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --�����
        ) C ON A.ID = C.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS unfinished
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.actual_end_date is null
        and node.is_disable = 0
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --δ���
        ) D ON A.ID = D.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS greenLight
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where (TRUNC(ACTUAL_END_DATE) - trunc(PLAN_END_DATE)) <= 0
        and actual_end_date is null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --�̵�
        ) E ON A.ID = E.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS yellowLight
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where (((TRUNC(ACTUAL_END_DATE) - trunc(PLAN_END_DATE)) BETWEEN 1 and 5) or
        ((trunc(SYSDATE) - trunc(PLAN_END_DATE)) BETWEEN 0 and 5))
        and actual_end_date is null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --�Ƶ�
        ) F ON A.ID = F.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS redLight
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where ACTUAL_END_DATE IS NULL
        and ((trunc(SYSDATE) - trunc(NODE.PLAN_END_DATE)) > 5)
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --���
        ) G ON A.ID = G.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS miCompleteNum
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --��̱�Ӧ���
        ) H ON A.ID = H.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS miCompleted
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --��̱������
        ) I ON A.ID = I.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS miUnfinished
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and ACTUAL_END_DATE IS NULL
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --��̱�δ���
        ) J ON A.ID = J.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS olCompleteNum
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --һ���ڵ�Ӧ���
        ) K ON A.ID = K.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS olCompleted
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --һ���ڵ������
        ) L ON A.ID = L.ID
        left join
        (
        select sp.id, sp.project_name, nvl(count(node.id), 0) AS olUnfinished
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and ACTUAL_END_DATE IS NULL
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --һ���ڵ�δ���
        ) M ON A.ID = M.ID

        left join
        (
        select sp.id, sp.project_name, nvl(sum(node.standard_score), 0) AS needResult
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --Ӧ���ܷ�
        ) N ON A.ID = N.ID
        left join
        (
        select sp.id, sp.project_name, nvl(sum(exam.standard_score), 0) AS realResult
        from sys_project sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        left join pom_node_examination exam on node.id = exam.original_node_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.project_name --ʵ�ʵ÷�
        ) O ON A.ID = O.ID
        )proj
        union
        select projs.*,
        case when projs.validTasks is null or projs.validTasks = 0 or projs.completed = 0 then
        ''0''
        else to_char((projs.completed / projs.validTasks)*100, ''9999999990.00'') end as completionRate,
        case when projs.needResult is null or projs.needResult = 0 or projs.realResult = 0 then
        ''0''
        else to_char((projs.realResult / projs.needResult)*100, ''9999999990.00'') end as dynamicResult
        FROM (
        select A.*,B.completeNum,C.completed,D.unfinished,N.needResult,O.realResult,E.greenLight,F.yellowLight,G.redLight,H.miCompleteNum,I.miCompleted,J.miUnfinished,
        K.olCompleteNum,L.olCompleted,M.olUnfinished
        from (
        select sp.id,sp.stage_full_name as project_name, nvl(count(node.id), 0) as validTasks
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --��Ч�ڵ�
        ) A
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS completeNum
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --Ӧ���
        ) B ON A.ID = B.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS completed
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --�����
        ) C ON A.ID = C.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS unfinished
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.actual_end_date is null
        and node.is_disable = 0
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --δ���
        ) D ON A.ID = D.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS greenLight
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where (TRUNC(ACTUAL_END_DATE) - trunc(PLAN_END_DATE)) <= 0
        and actual_end_date is null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --�̵�
        ) E ON A.ID = E.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS yellowLight
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where (((TRUNC(ACTUAL_END_DATE) - trunc(PLAN_END_DATE)) BETWEEN 1 and 5) or
        ((trunc(SYSDATE) - trunc(PLAN_END_DATE)) BETWEEN 0 and 5))
        and actual_end_date is null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --�Ƶ�
        ) F ON A.ID = F.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS redLight
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where ACTUAL_END_DATE IS NULL
        and ((trunc(SYSDATE) - trunc(NODE.PLAN_END_DATE)) > 5)
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --���
        ) G ON A.ID = G.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS miCompleteNum
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --��̱�Ӧ���
        ) H ON A.ID = H.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS miCompleted
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --��̱������
        ) I ON A.ID = I.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS miUnfinished
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''��̱�''
        and ACTUAL_END_DATE IS NULL
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --��̱�δ���
        ) J ON A.ID = J.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS olCompleteNum
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and to_char(node.plan_end_date, ''YYYY-MM-DD'') <= to_char(sysdate, ''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --һ���ڵ�Ӧ���
        ) K ON A.ID = K.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS olCompleted
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and actual_end_date is not null
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --һ���ڵ������
        ) L ON A.ID = L.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(count(node.id), 0) AS olUnfinished
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.node_level = ''һ���ڵ�''
        and ACTUAL_END_DATE IS NULL
        and to_char(node.plan_end_date,''YYYY-MM-DD'') <= to_char(sysdate,''YYYY-MM-DD'')
        and node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --һ���ڵ�δ���
        ) M ON A.ID = M.ID

        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(sum(node.standard_score), 0) AS needResult
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --Ӧ���ܷ�
        ) N ON A.ID = N.ID
        left join
        (
        select sp.id, sp.stage_full_name as project_name, nvl(sum(exam.standard_score), 0) AS realResult
        from sys_project_stage sp
        left join pom_proj_plan plan on sp.id = plan.proj_id
        left join pom_proj_plan_node node on plan.id = node.proj_plan_id
        left join pom_node_examination exam on node.id = exam.original_node_id
        where node.is_disable = 0
        and plan.approval_status = ''�����''
        and plan.plan_type = ''�ؼ��ڵ�ƻ�''
        group by sp.id, sp.stage_full_name --ʵ�ʵ÷�
        ) O ON A.ID = O.ID
        )projs
        ) statistics on org.id = statistics.id    --�ڵ�ͳ��
        start with org.id = '''||v_id||'''
        connect by prior org.id = parent_id
        )
    SELECT fullAll.*,CASE WHEN fullAll.ISEND =''1'' and fullAll.isCompany=''0'' then
                                  ''<span style="color:#409eff">''||company||''</span>''
                          else company end as "company"
    FROM (
             SELECT id as "id",t1.company as company,org_full_name as "fullName",parent_id as "parentId", to_char(IS_END) AS isEnd,t1.isCompany, t1.jumpUrl as "jumpUrl",
                    (select sum(validTasks) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "validTasks",
                    (select sum(completenum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "completeNum",
                    (select sum(completed) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "completed",
                    (select sum(unfinished) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "unfinished",
                    (select sum(needResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "needResult",
                    (select sum(realResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "realResult",
                    (select sum(greenLight) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "greenLight",
                    (select sum(yellowLight) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "yellowLight",
                    (select sum(redlight) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "redLight",
                    (select sum(micompletenum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "miCompleteNum",
                    (select sum(micompleted) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "miCompleted",
                    (select sum(miunfinished) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "miUnfinished",
                    (select sum(olcompletenum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "olCompleteNum",
                    (select sum(olcompleted) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "olCompleted",
                    (select sum(olunfinished) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) AS "olUnfinished",
                    case when
                                     (select sum(completeNum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) is null or
                                     (select sum(completeNum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) = 0 or
                                     (select sum(completed) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) = 0 then
                             ''0%''
                         else to_char(((select sum(completed) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) /
                                       (select sum(completeNum) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id))*100, ''9999999990.00'') ||''%'' end as "completionRate",
                    case when
                                     (select sum(needResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) is null or
                                     (select sum(needResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) = 0 or
                                     (select sum(realResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) = 0 then
                             ''0''
                         else to_char(((select sum(realResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id) /
                                       (select sum(needResult) from temp_origin start with id=t1.id connect by prior id=parent_id and id!=parent_id))*100, ''9999999990.00'') end as "dynamicResult",
                    (select count(validTasks) from temp_origin  where isCompany =''0''  start with t1.id=parent_id connect by prior id=parent_id ) as "childrenLength"
             FROM temp_origin t1 order by t1.code
         ) fullAll where (fullAll."childrenLength">0 and fullAll."childrenLength" is not null and fullAll.isCompany =''1'') or fullAll.isCompany = ''0''';
    open items for v_sql;

END POM_KEY_NODE_SCHEDULE;

/
--------------------------------------------------------
--  DDL for Procedure TMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "TMP" IS
		CURSOR CR_BUILD_LIST IS
				SELECT * FROM MDM_BUILD;

BEGIN
		FOR ITEM_BUILD_LIST IN CR_BUILD_LIST
		LOOP
				DBMS_OUTPUT.PUT_LINE(ITEM_BUILD_LIST.BUILD_NAME);
		END LOOP;
END TMP;

/
