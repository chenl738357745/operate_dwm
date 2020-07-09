SET DEFINE OFF;
create or replace FUNCTION GET_JUMP_URL_DOMAIN(DOMAIN_TYPE VARCHAR2, DOMAIN_ID VARCHAR2) 
RETURN VARCHAR2
AS
--��ȡ����
--�޸��ߣ����� 20200626 ����code
--���ڣ�2020-03-31
BACK_ID VARCHAR2(36);
BEGIN
    SELECT APPLICATION_URL INTO BACK_ID FROM SYS_APPLICATION_TERMINAL 
    WHERE (UPPER(APPLICATION_ID) = UPPER(DOMAIN_ID)  or UPPER(APPLICATION_CODE)=UPPER(DOMAIN_ID))
    AND UPPER(APPLICATION_TERMINAL_CODE) = UPPER(DOMAIN_TYPE);
    RETURN BACK_ID;
END;

/
create or replace PROCEDURE P_DWM_W_WORTH_BIG_DATA
(
	  ORGID         IN VARCHAR2---��ѯ��ֵ����֯
	 ,ORGTYPE       IN VARCHAR2---��ѯ��ֵ������ 
     ,i_source      IN VARCHAR2---��������Դ OA��DWM
--     ,userid           IN               VARCHAR2---��ǰ��¼��
--     ,stationid        IN               VARCHAR2---��ǰ��¼�˸�λ
--     ,deptid           IN               VARCHAR2---��ǰ��¼�˲���
--     ,companyid        IN               VARCHAR2---��ǰ��¼�˹�˾
	 ,TARGETWORTH  OUT SYS_REFCURSOR---Ŀ���ֵ
	 ,DYNAMICWORTH OUT SYS_REFCURSOR---��̬��ֵ
     ,O_SOURCECONFIG OUT SYS_REFCURSOR---����
	 ,DESCRIPTION  OUT CLOB--��ֵ�·�����
) AS
		--��̬��ֵ���-tab��ֵ������
		--���ߣ�����
		--�޸��ߣ�л�ɺ�
        --�޸��ߣ����� 20200626 ����Ҫ�󣬶�̬��ֵ���-��ֵ���ݣ�����ֵ��ʣ���ֵ��Ҫ���롣�����󰴹̶���ȼ��㡣Ҫ�� 'Ŀ���ܻ�ֵ'��'��̬�ܻ�ֵ' id ���ܸı䡣
		--���ڣ�2020-03-31
		V_DT_VALUE_ALL      NUMBER(18, 2); --��̬�ܻ�ֵ
		V_DT_SYHZ_VALUE_ALL NUMBER(18, 2); --ʣ���ֵ
		V_DT_YSHZ_VALUE     NUMBER(18, 2); --���ۻ�ֵ
		V_DT_CBHZ_VALUE     NUMBER(18, 2); --������ֵ
		V_DT_ZTHZ_VALUE     NUMBER(18, 2); --��;��ֵ
		V_DT_YQZHZ_VALUE    NUMBER(18, 2); --��ȡ֤��ֵ
		V_DT_KCHZ_VALUE     NUMBER(18, 2); --����ֵ
		V_DT_WQGZHZ_VALUE   NUMBER(18, 2); --δȡ��֤��ֵ
		V_DT_GHXKZHZ_VALUE  NUMBER(18, 2); --�滮���֤��ֵ
		V_DT_SGXKZHZ_VALUE  NUMBER(18, 2); --ʩ�����֤��ֵ
		V_DT_YSXKZHZ_VALUE  NUMBER(18, 2); --Ԥ�����֤��ֵ
		V_DT_JGBAHZ_VALUE   NUMBER(18, 2); --����������ֵ
		V_DT_JZHZ_VALUE     NUMBER(18, 2); --��ת��ֵ
        
        min_base_width VARCHAR2(10):=(case when i_source='OA' then '75' else '85' end);
        base_width NUMBER(18, 2):=(case when i_source='OA' then 200 else 400 end);
        δȡ��֤	 VARCHAR2(10):=min_base_width;
        �滮���֤�׶� VARCHAR2(10):=	min_base_width;
        ʩ�����֤�׶� VARCHAR2(10):=	min_base_width;
        Ԥ�����֤�׶�	 VARCHAR2(10):=min_base_width;
        ���������׶�	 VARCHAR2(10):=min_base_width;
        ��ת�׶�	 VARCHAR2(10):=min_base_width;
	
        ������ֵ	 VARCHAR2(10):=min_base_width;
        ��;��ֵ VARCHAR2(10):=to_char(2*min_base_width,'99,990.0');
        ��ȡ֤��ֵ VARCHAR2(10):=to_char(3*min_base_width,'99,990.0');
        ����ֵ	 VARCHAR2(10):=min_base_width;
        ���ۻ�ֵ1	 VARCHAR2(10):=to_char(2*min_base_width,'99,990.0');
	
        ʣ���ֵ	 VARCHAR2(10):=to_char(������ֵ+��;��ֵ+����ֵ,'99,990.0');
        ���ۻ�ֵ	 VARCHAR2(10):=���ۻ�ֵ1;
        
        base_row_width  NUMBER(18, 2):=base_width+ʣ���ֵ+���ۻ�ֵ; --�ܿ��
        jumpurl VARCHAR2(500);
        domain VARCHAR2(500):=GET_JUMP_URL_DOMAIN('pc','dwm');
        oaj   VARCHAR2(500):=domain||'/dwm/value-manage/dynamic-value/value-monitor?companyId=003200000000000000000000000000&orgtype=0&projectId=003200000000000000000000000000&tabType=5';

        mj   VARCHAR2(500):=domain||'/dwm/value-manage/value-project/list?code=value_list&companyId=003200000000000000000000000000&projectId=003200000000000000000000000000';
       
BEGIN
-------------------------20200701 �������������������  �Ż���վ��ֵ����ҳ��,�����С ���Ը���Դ���ø߶Ⱥ�����
 
        
   BEGIN   
    OPEN o_sourceConfig FOR select (case when i_source='OA' then 50 else 60 end) as rowHeight
         ,(case when i_source='OA' then 12 else 18 end) as valueFontSize
         ,(case when i_source='OA' then 50 else 60 end) as  leftWidth
         ,(case when i_source='OA' then 5 else 10 end) as  spacing
         ,12 as descriptionFontSize
          from dual;
         jumpurl:=(case when i_source='OA' then oaj else mj end);
           EXCEPTION
        WHEN OTHERS THEN 
           jumpurl:=mj;
        OPEN o_sourceConfig FOR select 60 as rowHeight
         ,18 as valueFontSize
         ,60 as  leftWidth
         ,10 as  spacing
         ,12 as descriptionFontSize
          from dual;
    END; 
		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_DT_ALL) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_DT_ALL / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_VALUE_ALL
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_REMAIN) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_REMAIN / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_SYHZ_VALUE_ALL
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_HAVED_SALE) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_HAVED_SALE / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_YSHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_RESERVE) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_RESERVE / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_CBHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_IN_PROCESS) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_IN_PROCESS / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_ZTHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;


		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_CONSTRUCTION_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_CONSTRUCTION_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_GHXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_STOCK) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_STOCK / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_KCHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		V_DT_YQZHZ_VALUE := V_DT_YSHZ_VALUE + V_DT_KCHZ_VALUE;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_PLANNING_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_PLANNING_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_WQGZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_SALE_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_SALE_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_SGXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_COMPLETION) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_COMPLETION / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_YSXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_YES_COMPLETION) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_YES_COMPLETION / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_JGBAHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_YES_SETTLEMENT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_YES_SETTLEMENT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0)
		INTO   V_DT_JZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		OPEN TARGETWORTH FOR 
				SELECT (case 
 when "id"='δȡ��֤' then δȡ��֤ 
 when "id"='�滮���֤�׶�' then �滮���֤�׶� 
 when "id"='ʩ�����֤�׶�' then ʩ�����֤�׶� 
 when "id"='Ԥ�����֤�׶�' then Ԥ�����֤�׶� 
 when "id"='���������׶�' then ���������׶� 
 when "id"='��ת�׶�' then ��ת�׶� 
 when "id"='������ֵ��c=b0��' then ������ֵ 
 when "id"='��;��ֵ��d��' then ��;��ֵ 
 when "id"='��ȡ֤��ֵ' then ��ȡ֤��ֵ 
 when "id"='����ֵ' then ����ֵ 
 when "id"='���ۻ�ֵ1' then ���ۻ�ֵ1 
 when "id"='ʣ���ֵ' then ʣ���ֵ 
 when "id"='���ۻ�ֵ��E2��' then ���ۻ�ֵ
 else '6' end  ) AS "minPercentage"
 ,base_row_width as "baseRowWidth"
 ,to_char(base_width/(case when V_DT_VALUE_ALL=0 then 1 else V_DT_VALUE_ALL end),'fm990.000000000000000000000000000') as "singleWidth"
 ,jumpurl as "jumpUrl"
 , RESULT.*
				FROM   (SELECT 'Ŀ���ܻ�ֵ' AS "id", NULL AS "parentsId", 'Ŀ���ܻ�ֵ' AS "name", NULL AS "value", '#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
								 FROM   SYS_BUSINESS_UNIT AA
								 WHERE  AA.IS_COMPANY = 1 AND AA.ID = '003200000000000000000000000000'
--								 UNION ALL
--								 SELECT AA.ID AS "id", 'Ŀ���ܻ�ֵ' AS "parentsId", 'A1���а�Ŀ���ֵ' AS "name",
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A1_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A1_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0) AS "value",
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
--								 WHERE  AA.ID = ORGID
--								 UNION ALL
--								 SELECT AA.ID, 'Ŀ���ܻ�ֵ', 'A2ȫ�̰�Ŀ���ֵ',
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A2_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A2_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0),
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
--								 WHERE  AA.ID = ORGID
--								 UNION ALL
--								 SELECT AA.ID, 'Ŀ���ܻ�ֵ', 'A3��̬��Ŀ���ֵ',
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A3_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A3_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0),
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
--								 WHERE  AA.ID = ORGID
								 UNION ALL
								 SELECT AA.ID, 'Ŀ���ܻ�ֵ', '���°�Ŀ���ֵ',
												NVL((SELECT ROUND(SUM(DDV.TARGET_A_VALUE) / 10000, 2)
														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
														 LEFT   JOIN SYS_PROJECT SP
														 ON     PP.ID = SP.UNIT_ID
														 LEFT   JOIN DWM_DT_VALUE DDV
														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '��Ŀ'), 0),
												'#FFA500' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
								 WHERE  AA.ID = ORGID) RESULT;

		OPEN DYNAMICWORTH FOR
				SELECT (case 
 when "id"='δȡ��֤' then δȡ��֤ 
 when "id"='�滮���֤�׶�' then �滮���֤�׶� 
 when "id"='ʩ�����֤�׶�' then ʩ�����֤�׶� 
 when "id"='Ԥ�����֤�׶�' then Ԥ�����֤�׶� 
 when "id"='���������׶�' then ���������׶� 
 when "id"='��ת�׶�' then ��ת�׶� 
 when "id"='������ֵ��c=b0��' then ������ֵ 
 when "id"='��;��ֵ��d��' then ��;��ֵ 
 when "id"='��ȡ֤��ֵ' then ��ȡ֤��ֵ 
 when "id"='����ֵ' then ����ֵ 
 when "id"='���ۻ�ֵ1' then ���ۻ�ֵ1 
 when "id"='ʣ���ֵ' then ʣ���ֵ 
 when "id"='���ۻ�ֵ��E2��' then ���ۻ�ֵ
 else '6' end  ) AS "minPercentage"
 ,base_row_width as "baseRowWidth"
 ,to_char(base_width/(case when V_DT_VALUE_ALL=0 then 1 else V_DT_VALUE_ALL end),'fm990.000000000000000000000000000') as "singleWidth"
 ,jumpurl as "jumpUrl"
 ,"id", "parentsId", "name", "value", "color" AS "color", "bgColor" AS "bgColor", "nameColor" AS "nameColor",
							 CASE WHEN "name"=
										'��ȡ֤��ֵ' THEN
										 1
										ELSE
										 0
								END AS "isNesting", 0 "layout"
				FROM   (SELECT '��̬�ܻ�ֵ' AS "id", '' AS "parentsId", '��̬�ܻ�ֵ' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 --- ��̬�ܻ�ֵ
								 UNION ALL
								 SELECT '0' AS "id", '��̬�ܻ�ֵ' AS "parentsId", '��̬�ܻ�ֵ' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '1' AS "id", '��̬�ܻ�ֵ' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#00BFFF' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT 'ʣ���ֵ' AS "id", '1' AS "parentsId", 'ʣ���ֵ' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_SYHZ_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
--                                 --------------------chenl
--                                  UNION ALL
--								 SELECT '������ֵ��c=b0��old' AS "id", 'ʣ���ֵ' AS "parentsId", '������ֵ��c=b0��' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_CBHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--								 UNION ALL
--								 SELECT '��;��ֵ��d��old' AS "id", 'ʣ���ֵ' AS "parentsId", '��;��ֵ��d��' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_ZTHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--                                  UNION ALL
--								 SELECT '����ֵold' AS "id", 'ʣ���ֵ' AS "parentsId", '����ֵ' AS "name", '#ffffff' AS "color", '#e46c0a' AS "bgColor", '#666666' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_KCHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--                                 ---------------------chenl
								 UNION ALL
								 SELECT '���ۻ�ֵ��E2��' AS "id", '1' AS "parentsId", '���ۻ�ֵ��E2��' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 ------2
								 UNION ALL
								 SELECT '2' AS "id", '��̬�ܻ�ֵ' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '������ֵ��c=b0��' AS "id", '2' AS "parentsId", '������ֵ��c=b0��' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_CBHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '��;��ֵ��d��' AS "id", '2' AS "parentsId", '��;��ֵ��d��' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_ZTHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '��ȡ֤��ֵ' AS "id", '2' AS "parentsId", '��ȡ֤��ֵ' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YQZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '����ֵ' AS "id", '��ȡ֤��ֵ' AS "parentsId", '����ֵ' AS "name", '#ffffff' AS "color", '#e46c0a' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_KCHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '���ۻ�ֵ1' AS "id", '��ȡ֤��ֵ' AS "parentsId", '���ۻ�ֵ' AS "name", '#ffffff' AS "color", '#00b050' AS "bgColor", '#d7d7d7' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 --------------------3
								 UNION ALL
								 SELECT '3' AS "id", '��̬�ܻ�ֵ' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT 'δȡ��֤' AS "id", '3' AS "parentsId", 'δȡ��֤' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_WQGZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '�滮���֤�׶�' AS "id", '3' AS "parentsId", '�滮���֤�׶�' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(NVL(V_DT_GHXKZHZ_VALUE, 0), 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT 'ʩ�����֤�׶�' AS "id", '3' AS "parentsId", 'ʩ�����֤�׶�' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_SGXKZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT 'Ԥ�����֤�׶�' AS "id", '3' AS "parentsId", 'Ԥ�����֤�׶�' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSXKZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '���������׶�' AS "id", '3' AS "parentsId", '���������׶�' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_JGBAHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '��ת�׶�' AS "id", '3' AS "parentsId", '��ת�׶�' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_JZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL) A;

		DESCRIPTION := '<span style="font-size:14px;color:#333333"><span style="font-weight:bold">���°�Ŀ���ܻ�ֵ�� </span>����"��̬��Ŀ���ֵ"����ȡ"��̬��Ŀ���ֵ"������"��̬��Ŀ���ֵ"����ȡ"ȫ�̰�Ŀ���ֵ"������"ȫ�̰�Ŀ���ֵ"����ȡ"���а�Ŀ���ֵ��</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">��̬�ܻ�ֵ</span> =ʣ���ֵ+���ۻ�ֵ=������ֵ+��;��ֵ+����ֵ+���ۻ�ֵ��</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">ʣ���ֵ</span> =������ֵ+��;��ֵ+����ֵ��</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">���ۻ�ֵ��</span> ����Ԥ�����֤����ǩԼ�Ļ�ֵ��ȡ������ϵͳ���е�ǩԼ��</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">������ֵ(��δȡ��֤��ֵ)�� </span>���ȡ�������С�δȡ��֤����������۸�ҵ̬ȡ���µ�Ŀ����ۡ�</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">��;��ֵ�� </span>���ȡ�������С���ȡ��֤δȡԤ�����֤����������۸�ҵ̬ȡ���µ�Ŀ����ۡ�</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">��ȡ֤��ֵ�� </span>����Ԥ�����֤��ֵ��������δǩԼ����ǩԼ����</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">����ֵ�� </span>����Ԥ�����֤��δǩԼ�Ļ�ֵ��ȡ������ϵͳ���еĵ׼ۡ�</span>';
END P_DWM_W_WORTH_BIG_DATA;