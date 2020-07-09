SET DEFINE OFF;
create or replace FUNCTION GET_JUMP_URL_DOMAIN(DOMAIN_TYPE VARCHAR2, DOMAIN_ID VARCHAR2) 
RETURN VARCHAR2
AS
--获取域名
--修改者：陈丽 20200626 兼容code
--日期：2020-03-31
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
	  ORGID         IN VARCHAR2---查询货值的组织
	 ,ORGTYPE       IN VARCHAR2---查询货值的类型 
     ,i_source      IN VARCHAR2---请求数据源 OA、DWM
--     ,userid           IN               VARCHAR2---当前登录人
--     ,stationid        IN               VARCHAR2---当前登录人岗位
--     ,deptid           IN               VARCHAR2---当前登录人部门
--     ,companyid        IN               VARCHAR2---当前登录人公司
	 ,TARGETWORTH  OUT SYS_REFCURSOR---目标货值
	 ,DYNAMICWORTH OUT SYS_REFCURSOR---动态货值
     ,O_SOURCECONFIG OUT SYS_REFCURSOR---配置
	 ,DESCRIPTION  OUT CLOB--货值下方描述
) AS
		--动态货值监控-tab货值大数据
		--作者：陈丽
		--修改者：谢松宏
        --修改者：陈丽 20200626 于政要求，动态货值监控-货值数据，库存货值和剩余货值需要对齐。调整后按固定宽度计算。要求 '目标总货值'和'动态总货值' id 不能改变。
		--日期：2020-03-31
		V_DT_VALUE_ALL      NUMBER(18, 2); --动态总货值
		V_DT_SYHZ_VALUE_ALL NUMBER(18, 2); --剩余货值
		V_DT_YSHZ_VALUE     NUMBER(18, 2); --已售货值
		V_DT_CBHZ_VALUE     NUMBER(18, 2); --储备货值
		V_DT_ZTHZ_VALUE     NUMBER(18, 2); --在途货值
		V_DT_YQZHZ_VALUE    NUMBER(18, 2); --已取证货值
		V_DT_KCHZ_VALUE     NUMBER(18, 2); --库存货值
		V_DT_WQGZHZ_VALUE   NUMBER(18, 2); --未取规证货值
		V_DT_GHXKZHZ_VALUE  NUMBER(18, 2); --规划许可证货值
		V_DT_SGXKZHZ_VALUE  NUMBER(18, 2); --施工许可证货值
		V_DT_YSXKZHZ_VALUE  NUMBER(18, 2); --预售许可证货值
		V_DT_JGBAHZ_VALUE   NUMBER(18, 2); --竣工备案货值
		V_DT_JZHZ_VALUE     NUMBER(18, 2); --结转货值
        
        min_base_width VARCHAR2(10):=(case when i_source='OA' then '75' else '85' end);
        base_width NUMBER(18, 2):=(case when i_source='OA' then 200 else 400 end);
        未取规证	 VARCHAR2(10):=min_base_width;
        规划许可证阶段 VARCHAR2(10):=	min_base_width;
        施工许可证阶段 VARCHAR2(10):=	min_base_width;
        预售许可证阶段	 VARCHAR2(10):=min_base_width;
        竣工备案阶段	 VARCHAR2(10):=min_base_width;
        结转阶段	 VARCHAR2(10):=min_base_width;
	
        储备货值	 VARCHAR2(10):=min_base_width;
        在途货值 VARCHAR2(10):=to_char(2*min_base_width,'99,990.0');
        已取证货值 VARCHAR2(10):=to_char(3*min_base_width,'99,990.0');
        库存货值	 VARCHAR2(10):=min_base_width;
        已售货值1	 VARCHAR2(10):=to_char(2*min_base_width,'99,990.0');
	
        剩余货值	 VARCHAR2(10):=to_char(储备货值+在途货值+库存货值,'99,990.0');
        已售货值	 VARCHAR2(10):=已售货值1;
        
        base_row_width  NUMBER(18, 2):=base_width+剩余货值+已售货值; --总宽度
        jumpurl VARCHAR2(500);
        domain VARCHAR2(500):=GET_JUMP_URL_DOMAIN('pc','dwm');
        oaj   VARCHAR2(500):=domain||'/dwm/value-manage/dynamic-value/value-monitor?companyId=003200000000000000000000000000&orgtype=0&projectId=003200000000000000000000000000&tabType=5';

        mj   VARCHAR2(500):=domain||'/dwm/value-manage/value-project/list?code=value_list&companyId=003200000000000000000000000000&projectId=003200000000000000000000000000';
       
BEGIN
-------------------------20200701 集团栗亚鹏和于政提出  门户网站货值数据页面,区域较小 所以根据源设置高度和字体
 
        
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
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_DT_ALL / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_VALUE_ALL
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_REMAIN) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_REMAIN / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_SYHZ_VALUE_ALL
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_HAVED_SALE) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_HAVED_SALE / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_YSHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_RESERVE) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_RESERVE / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_CBHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_IN_PROCESS) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_IN_PROCESS / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_ZTHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;


		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_CONSTRUCTION_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_CONSTRUCTION_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_GHXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_STOCK) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_STOCK / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_KCHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		V_DT_YQZHZ_VALUE := V_DT_YSHZ_VALUE + V_DT_KCHZ_VALUE;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_PLANNING_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_PLANNING_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_WQGZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_SALE_PERMIT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_SALE_PERMIT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_SGXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_NOT_COMPLETION) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_NOT_COMPLETION / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_YSXKZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_YES_COMPLETION) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_YES_COMPLETION / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_JGBAHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		SELECT NVL((SELECT ROUND(SUM(DDV.VALUE_YES_SETTLEMENT) / 100000000, 2)
						FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
						LEFT   JOIN SYS_PROJECT SP
						ON     PP.ID = SP.UNIT_ID
						LEFT   JOIN DWM_DT_VALUE DDV
						ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.VALUE_YES_SETTLEMENT / 100000000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0)
		INTO   V_DT_JZHZ_VALUE
		FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
		WHERE  AA.ID = ORGID;

		OPEN TARGETWORTH FOR 
				SELECT (case 
 when "id"='未取规证' then 未取规证 
 when "id"='规划许可证阶段' then 规划许可证阶段 
 when "id"='施工许可证阶段' then 施工许可证阶段 
 when "id"='预售许可证阶段' then 预售许可证阶段 
 when "id"='竣工备案阶段' then 竣工备案阶段 
 when "id"='结转阶段' then 结转阶段 
 when "id"='储备货值（c=b0）' then 储备货值 
 when "id"='在途货值（d）' then 在途货值 
 when "id"='已取证货值' then 已取证货值 
 when "id"='库存货值' then 库存货值 
 when "id"='已售货值1' then 已售货值1 
 when "id"='剩余货值' then 剩余货值 
 when "id"='已售货值（E2）' then 已售货值
 else '6' end  ) AS "minPercentage"
 ,base_row_width as "baseRowWidth"
 ,to_char(base_width/(case when V_DT_VALUE_ALL=0 then 1 else V_DT_VALUE_ALL end),'fm990.000000000000000000000000000') as "singleWidth"
 ,jumpurl as "jumpUrl"
 , RESULT.*
				FROM   (SELECT '目标总货值' AS "id", NULL AS "parentsId", '目标总货值' AS "name", NULL AS "value", '#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
								 FROM   SYS_BUSINESS_UNIT AA
								 WHERE  AA.IS_COMPANY = 1 AND AA.ID = '003200000000000000000000000000'
--								 UNION ALL
--								 SELECT AA.ID AS "id", '目标总货值' AS "parentsId", 'A1可研版目标货值' AS "name",
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A1_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A1_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0) AS "value",
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   (SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP) AA
--								 WHERE  AA.ID = ORGID
--								 UNION ALL
--								 SELECT AA.ID, '目标总货值', 'A2全盘版目标货值',
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A2_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A2_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0),
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
--								 WHERE  AA.ID = ORGID
--								 UNION ALL
--								 SELECT AA.ID, '目标总货值', 'A3动态版目标货值',
--												NVL((SELECT ROUND(SUM(DDV.TARGET_A3_VALUE) / 10000, 2)
--														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
--														 LEFT   JOIN SYS_PROJECT SP
--														 ON     PP.ID = SP.UNIT_ID
--														 LEFT   JOIN DWM_DT_VALUE DDV
--														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A3_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0),
--												'#009900' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
--								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
--								 WHERE  AA.ID = ORGID
								 UNION ALL
								 SELECT AA.ID, '目标总货值', '最新版目标货值',
												NVL((SELECT ROUND(SUM(DDV.TARGET_A_VALUE) / 10000, 2)
														 FROM   (SELECT SBU.ORG_NAME, SBU.ID FROM SYS_BUSINESS_UNIT SBU WHERE SBU.IS_COMPANY = 1 START WITH SBU.ID = ORGID CONNECT BY PRIOR SBU.ID = SBU.PARENT_ID) PP
														 LEFT   JOIN SYS_PROJECT SP
														 ON     PP.ID = SP.UNIT_ID
														 LEFT   JOIN DWM_DT_VALUE DDV
														 ON     DDV.OBJ_ID = SP.ID), 0) + NVL((SELECT ROUND(P.TARGET_A_VALUE / 10000, 2) FROM DWM_DT_VALUE P WHERE P.OBJ_ID = AA.ID AND P.OBJ_TYPE = '项目'), 0),
												'#FFA500' AS "color", '#f2f2f2' AS "bgColor", '#666666' AS "nameColor", 0 "isNesting", 0 "layout"
								 FROM   ((SELECT SBU.ID, SBU.IS_COMPANY FROM SYS_BUSINESS_UNIT SBU UNION ALL SELECT SP.ID, 0 FROM SYS_PROJECT SP)) AA
								 WHERE  AA.ID = ORGID) RESULT;

		OPEN DYNAMICWORTH FOR
				SELECT (case 
 when "id"='未取规证' then 未取规证 
 when "id"='规划许可证阶段' then 规划许可证阶段 
 when "id"='施工许可证阶段' then 施工许可证阶段 
 when "id"='预售许可证阶段' then 预售许可证阶段 
 when "id"='竣工备案阶段' then 竣工备案阶段 
 when "id"='结转阶段' then 结转阶段 
 when "id"='储备货值（c=b0）' then 储备货值 
 when "id"='在途货值（d）' then 在途货值 
 when "id"='已取证货值' then 已取证货值 
 when "id"='库存货值' then 库存货值 
 when "id"='已售货值1' then 已售货值1 
 when "id"='剩余货值' then 剩余货值 
 when "id"='已售货值（E2）' then 已售货值
 else '6' end  ) AS "minPercentage"
 ,base_row_width as "baseRowWidth"
 ,to_char(base_width/(case when V_DT_VALUE_ALL=0 then 1 else V_DT_VALUE_ALL end),'fm990.000000000000000000000000000') as "singleWidth"
 ,jumpurl as "jumpUrl"
 ,"id", "parentsId", "name", "value", "color" AS "color", "bgColor" AS "bgColor", "nameColor" AS "nameColor",
							 CASE WHEN "name"=
										'已取证货值' THEN
										 1
										ELSE
										 0
								END AS "isNesting", 0 "layout"
				FROM   (SELECT '动态总货值' AS "id", '' AS "parentsId", '动态总货值' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 --- 动态总货值
								 UNION ALL
								 SELECT '0' AS "id", '动态总货值' AS "parentsId", '动态总货值' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '1' AS "id", '动态总货值' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#00BFFF' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '剩余货值' AS "id", '1' AS "parentsId", '剩余货值' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_SYHZ_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
--                                 --------------------chenl
--                                  UNION ALL
--								 SELECT '储备货值（c=b0）old' AS "id", '剩余货值' AS "parentsId", '储备货值（c=b0）' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_CBHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--								 UNION ALL
--								 SELECT '在途货值（d）old' AS "id", '剩余货值' AS "parentsId", '在途货值（d）' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_ZTHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--                                  UNION ALL
--								 SELECT '库存货值old' AS "id", '剩余货值' AS "parentsId", '库存货值' AS "name", '#ffffff' AS "color", '#e46c0a' AS "bgColor", '#666666' AS "nameColor",
--												RTRIM(TO_CHAR(V_DT_KCHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
--								 FROM   DUAL
--                                 ---------------------chenl
								 UNION ALL
								 SELECT '已售货值（E2）' AS "id", '1' AS "parentsId", '已售货值（E2）' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 ------2
								 UNION ALL
								 SELECT '2' AS "id", '动态总货值' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '储备货值（c=b0）' AS "id", '2' AS "parentsId", '储备货值（c=b0）' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_CBHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '在途货值（d）' AS "id", '2' AS "parentsId", '在途货值（d）' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_ZTHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '已取证货值' AS "id", '2' AS "parentsId", '已取证货值' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#bcbcbc' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YQZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '库存货值' AS "id", '已取证货值' AS "parentsId", '库存货值' AS "name", '#ffffff' AS "color", '#e46c0a' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_KCHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '已售货值1' AS "id", '已取证货值' AS "parentsId", '已售货值' AS "name", '#ffffff' AS "color", '#00b050' AS "bgColor", '#d7d7d7' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 --------------------3
								 UNION ALL
								 SELECT '3' AS "id", '动态总货值' AS "parentsId", '' AS "name", '#ffffff' AS "color", '#0070C0' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_VALUE_ALL, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '未取规证' AS "id", '3' AS "parentsId", '未取规证' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_WQGZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '规划许可证阶段' AS "id", '3' AS "parentsId", '规划许可证阶段' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(NVL(V_DT_GHXKZHZ_VALUE, 0), 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '施工许可证阶段' AS "id", '3' AS "parentsId", '施工许可证阶段' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_SGXKZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '预售许可证阶段' AS "id", '3' AS "parentsId", '预售许可证阶段' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_YSXKZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '竣工备案阶段' AS "id", '3' AS "parentsId", '竣工备案阶段' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_JGBAHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL
								 UNION ALL
								 SELECT '结转阶段' AS "id", '3' AS "parentsId", '结转阶段' AS "name", '#ffffff' AS "color", '#ffc000' AS "bgColor", '#666666' AS "nameColor",
												RTRIM(TO_CHAR(V_DT_JZHZ_VALUE, 'FM999990D99'), TO_CHAR(0, 'D')) AS "value"
								 FROM   DUAL) A;

		DESCRIPTION := '<span style="font-size:14px;color:#333333"><span style="font-weight:bold">最新版目标总货值： </span>若有"动态版目标货值"，则取"动态版目标货值"；若无"动态版目标货值"，则取"全盘版目标货值"；若无"全盘版目标货值"，则取"可研版目标货值。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">动态总货值</span> =剩余货值+已售货值=储备货值+在途货值+库存货值+已售货值。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">剩余货值</span> =储备货值+在途货值+库存货值。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">已售货值：</span> 已拿预售许可证且已签约的货值，取《销售系统》中的签约金额。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">储备货值(即未取规证货值)： </span>面积取主数据中“未取规证的面积”，价格按业态取最新的目标均价。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">在途货值： </span>面积取主数据中“已取规证未取预售许可证的面积”，价格按业态取最新的目标均价。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">已取证货值： </span>已拿预售许可证货值，包括“未签约、已签约”。</span></br>
<span style="font-size:14px;color:#333333"><span style="font-weight:bold">库存货值： </span>已拿预售许可证但未签约的货值，取《销售系统》中的底价。</span>';
END P_DWM_W_WORTH_BIG_DATA;