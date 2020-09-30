--------------------------------------------------------
--  文件已创建 - 星期三-九月-02-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View A1_POM_IMPORT_CHECK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "A1_POM_IMPORT_CHECK" ("所属二级单位", "所属公司", "PLAN_NAME", "所属项目", "项目ID", "所属分期", "分期ID", "PLAN_ID", "NODE_ID", "节点名称", "计划类别是否相等", "计划类别_EXCEL", "计划类别_SYS", "禁用属性是否正确", "是否禁用_EXCEL", "是否禁用_SYS", "计划开始日期是否相等", "计划开始日期_EXCEL", "计划开始日期_SYS", "计划完成日期是否相等", "计划完成日期_EXCEL", "计划完成日期_SYS", "实际开始日期是否相等", "实际开始日期_EXCEL", "实际开始日期_SYS", "实际完成日期是否相等", "实际完成日期_EXCEL", "实际完成日期_SYS") AS SELECT (SELECT P.ORG_NAME FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 AND p.LEVEL_RANK=2 START WITH p.ID = b.COMPANY_ID CONNECT BY PRIOR p.PARENT_ID = p.ID) AS 所属二级单位,B.COMPANY_NAME AS 所属公司,B.PLAN_NAME, B.PROJ_NAME AS 所属项目, A.项目ID, A.所属分期, A.分期ID, A.PLAN_ID, A.NODE_ID, A.节点名称, CASE WHEN A.计划类别 = B.PLAN_TYPE THEN	'是' ELSE	'否' END AS 计划类别是否相等, A.计划类别 AS 计划类别_EXCEL, B.PLAN_TYPE AS 计划类别_SYS, CASE WHEN CASE	WHEN A.是否禁用 = '是' THEN	 1	ELSE 0	END = NVL(B.IS_DISABLE, 0) THEN	'是' ELSE	'否' END AS 禁用属性是否正确, A.是否禁用 AS 是否禁用_EXCEL, CASE	 WHEN B.IS_DISABLE = 1 THEN	'是' ELSE	'否' END AS 是否禁用_SYS, CASE WHEN NVL(A.计划开始日期, TO_DATE('1900-01-01', 'YYYY-MM-DD')) = NVL(B.PLAN_START_DATE, TO_DATE('1900-01-01', 'YYYY-MM-DD')) THEN	'是' ELSE	'否' END 计划开始日期是否相等, A.计划开始日期 AS 计划开始日期_EXCEL, B.PLAN_START_DATE AS 计划开始日期_SYS, CASE WHEN NVL(A.计划完成日期, TO_DATE('1900-01-01', 'YYYY-MM-DD')) = NVL(B.PLAN_END_DATE, TO_DATE('1900-01-01', 'YYYY-MM-DD')) THEN	'是' ELSE '否' END AS 计划完成日期是否相等, A.计划完成日期 AS 计划完成日期_EXCEL, B.PLAN_END_DATE AS 计划完成日期_SYS, CASE WHEN NVL(A.实际开始日期, TO_DATE('1900-01-01', 'YYYY-MM-DD')) = NVL(B.ACTUAL_START_DATE, TO_DATE('1900-01-01', 'YYYY-MM-DD')) THEN		'是'	 ELSE	'否' END AS 实际开始日期是否相等, A.实际开始日期 实际开始日期_EXCEL, B.ACTUAL_START_DATE AS 实际开始日期_SYS, CASE WHEN NVL(A.实际完成日期, TO_DATE('1900-1-01', 'YYYY-MM-DD')) = NVL(B.ACTUAL_END_DATE, TO_DATE('1900-1-01', 'YYYY-MM-DD')) THEN '是' ELSE '否' END AS 实际完成日期是否相等, A.实际完成日期 AS 实际完成日期_EXCEL, B.ACTUAL_END_DATE AS 实际完成日期_SYS FROM   A1_PLAN_INFO_E A LEFT   JOIN (SELECT A1.ID AS PLAN_ID, A1.PLAN_NAME, A1.PLAN_TYPE, A1.PROJ_NAME, B1.* FROM POM_PROJ_PLAN A1 INNER JOIN POM_PROJ_PLAN_NODE B1 ON A1.ID = B1.PROJ_PLAN_ID) B ON     A.PLAN_ID = B.PLAN_ID AND A.NODE_ID = B.ID ORDER BY 1,2,3,12

;
--------------------------------------------------------
--  DDL for View EPC_BUILD_PHASE_INDEX
--------------------------------------------------------

  CREATE OR REPLACE VIEW "EPC_BUILD_PHASE_INDEX" ("ID", "UNDERGROUND_CAPACITY_AREA", "GROUND_TOTAL_BUILD_AREA", "GROUND_UNCAPACITY_AREA", "GROUND_CAPACITY_AREA", "UNDERGROUND_TOTAL_RJ_CARPORT", "UNDERGROUND_RFJ_CARPORT", "UNDERGROUND_RJ_CARPORT", "UNDERGROUND_TOTAL_FRJ_CARPORT", "UNDERGROUND_FRFJ_CARPORT", "UNDERGROUND_FRJ_CARPORT", "UNDERGROUND_TOTAL_SALE_CARPORT", "UNDERGROUND_R_SALE_CARPORT", "UNDERGROUND_FRFJ_SALE_CARPORT", "UNDERGROUND_FRJ_SALE_CARPORT", "TOTAL_SALE_AREA", "GROUND_SALE_AREA", "UNDERGROUND_SALE_AREA", "TOTAL_GIVE_AREA", "GROUND_GIVE_AREA", "UNDERGROUND_GIVE_AREA", "TOTAL_RESIDENCE", "TOTAL_BUSINESS") AS SELECT D1.ID,E1.UNDERGROUND_CAPACITY_AREA, E1.GROUND_TOTAL_BUILD_AREA, E1.GROUND_UNCAPACITY_AREA, E1.GROUND_CAPACITY_AREA, E1.UNDERGROUND_TOTAL_RJ_CARPORT, E1.UNDERGROUND_RFJ_CARPORT,
                E1.UNDERGROUND_RJ_CARPORT, E1.UNDERGROUND_TOTAL_FRJ_CARPORT, E1.UNDERGROUND_FRFJ_CARPORT, E1.UNDERGROUND_FRJ_CARPORT, E1.UNDERGROUND_TOTAL_SALE_CARPORT, E1.UNDERGROUND_R_SALE_CARPORT,
                E1.UNDERGROUND_FRFJ_SALE_CARPORT, E1.UNDERGROUND_FRJ_SALE_CARPORT, E1.TOTAL_SALE_AREA, E1.GROUND_SALE_AREA, E1.UNDERGROUND_SALE_AREA, E1.TOTAL_GIVE_AREA, E1.GROUND_GIVE_AREA,
                E1. UNDERGROUND_GIVE_AREA,e1.TOTAL_RESIDENCE,e1.TOTAL_BUSINESS
         FROM   MDM_PROJECT A1
         INNER  JOIN MDM_BUILD B1
         ON     A1.ID = B1.PROJ_ID
         INNER  JOIN MDM_BUILD_PHASE C1
         ON     B1.ID = C1.BUILD_ID AND
                C1.PHASE_ID = '987b3331-8b68-3c60-e053-0100007fd322'
         INNER  JOIN MDM_OBJ_PHASE_INDEX D1
         ON     C1.ID = D1.OBJ_PHASE_ID
         INNER  JOIN (

                     SELECT B.ID, D.ID AS OBJ_PHASE_ID, SUM(E.UNDERGROUND_CAPACITY_AREA) UNDERGROUND_CAPACITY_AREA, SUM(E.GROUND_TOTAL_BUILD_AREA) GROUND_TOTAL_BUILD_AREA,
                             SUM(E.GROUND_UNCAPACITY_AREA) GROUND_UNCAPACITY_AREA, SUM(E.GROUND_CAPACITY_AREA) GROUND_CAPACITY_AREA, SUM(E.UNDERGROUND_TOTAL_RJ_CARPORT) UNDERGROUND_TOTAL_RJ_CARPORT,
                             SUM(E.UNDERGROUND_RFJ_CARPORT) UNDERGROUND_RFJ_CARPORT, SUM(E.UNDERGROUND_RJ_CARPORT) UNDERGROUND_RJ_CARPORT,
                             SUM(E.UNDERGROUND_TOTAL_FRJ_CARPORT) UNDERGROUND_TOTAL_FRJ_CARPORT, SUM(E.UNDERGROUND_FRFJ_CARPORT) UNDERGROUND_FRFJ_CARPORT,
                             SUM(E.UNDERGROUND_FRJ_CARPORT) UNDERGROUND_FRJ_CARPORT, SUM(E.UNDERGROUND_TOTAL_SALE_CARPORT) UNDERGROUND_TOTAL_SALE_CARPORT,
                             SUM(E.UNDERGROUND_R_SALE_CARPORT) UNDERGROUND_R_SALE_CARPORT, SUM(E.UNDERGROUND_FRFJ_SALE_CARPORT) UNDERGROUND_FRFJ_SALE_CARPORT,
                             SUM(E.UNDERGROUND_FRJ_SALE_CARPORT) UNDERGROUND_FRJ_SALE_CARPORT, SUM(E.TOTAL_SALE_AREA) TOTAL_SALE_AREA, SUM(E.GROUND_SALE_AREA) GROUND_SALE_AREA,
                             SUM(E.UNDERGROUND_SALE_AREA) UNDERGROUND_SALE_AREA, SUM(E.TOTAL_GIVE_AREA) TOTAL_GIVE_AREA, SUM(E.GROUND_GIVE_AREA) GROUND_GIVE_AREA,
                             SUM(E.UNDERGROUND_GIVE_AREA) UNDERGROUND_GIVE_AREA,SUM(e.TOTAL_RESIDENCE) TOTAL_RESIDENCE,SUM(e.TOTAL_BUSINESS)  TOTAL_BUSINESS
                     FROM   MDM_PROJECT A
                     INNER  JOIN MDM_BUILD B
                     ON     A.ID = B.PROJ_ID
                     INNER  JOIN SYS_BUSINESS_UNIT C
                     ON     A.COMPANY_ID = C.ID AND
                            C.ID IN (SELECT ID FROM SYS_BUSINESS_UNIT P1 WHERE P1.IS_COMPANY = 1 START WITH P1.ORG_NAME IN ('西南公司', '华中公司', '华东公司') CONNECT BY PRIOR P1.ID = P1.PARENT_ID)
                     INNER  JOIN MDM_BUILD_PHASE D
                     ON     B.ID = D.BUILD_ID AND
                            D.PHASE_ID = '987b3331-8b68-3c60-e053-0100007fd322'
                     LEFT   JOIN MDM_OBJ_PHASE_PT_INDEX E
                     ON     D.ID = E.OBJ_PHASE_ID
                     /*        WHERE  E.ID IS NULL*/
                     GROUP  BY B.ID, A.PROJECT_NAME, B.BUILD_NAME, D.ID

                     ) E1
         ON     E1.ID = B1.ID

;
--------------------------------------------------------
--  DDL for View V_AREA_COMPANY_PROJ_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_AREA_COMPANY_PROJ_TREE" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "ISCOMPANY", "ORDERCODE") AS select orgId,orgName,orgType,parentId,isCompany,orderCode from
(
select ID as orgId,STAGE_NAME as orgName,'11' as orgType,PROJECT_ID as parentId,'0' as isCompany,'' as orderCode
from SYS_PROJECT_STAGE
UNION
select ID as orgId,PROJECT_NAME as orgName,'10' as orgType,UNIT_ID as parentId,'0' as isCompany,PROJECT_CODE as orderCode
from SYS_PROJECT
UNION
select ID as orgId,ORG_NAME as orgName,'0' as orgType,PARENT_ID as parentId,'1' as isCompany,ORG_CODE as orderCode
from SYS_BUSINESS_UNIT where ORG_TYPE = 0
) t
;
--------------------------------------------------------
--  DDL for View V_DWM_DT_VALUE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_DT_VALUE" ("TARGET_1", "TARGET_2", "TARGET_3", "TARGET_NOW", "TARGET_NOW_DIFF", "ID", "OBJ_ID", "OBJ_NAME", "OBJ_TYPE", "OBJ_IS_PARKING", "OBJ_IS_SALE", "OBJ_IS_HOLD", "PARENT_ID", "OBJ_LEVEL", "ORDER_CODE", "ORDER_HIERARCHY_CODE", "VALUE_DT_ALL", "VALUE_REMAIN", "VALUE_HAVED_SALE", "VALUE_RESERVE", "VALUE_IN_PROCESS", "VALUE_ALLOW_SALE", "VALUE_STOCK", "VALUE_NOT_PLANNING_PERMIT", "VALUE_NOT_CONSTRUCTION_PERMIT", "VALUE_NOT_SALE_PERMIT", "VALUE_NOT_COMPLETION", "VALUE_YES_COMPLETION", "VALUE_YES_SETTLEMENT", "AREA_DT_ALL", "AREA_REMAIN", "AREA_HAVED_SALE", "AREA_RESERVE", "AREA_IN_PROCESS", "AREA_ALLOW_SALE", "AREA_STOCK", "AREA_NOT_PLANNING_PERMIT", "AREA_NOT_CONSTRUCTION_PERMIT", "AREA_NOT_SALE_PERMIT", "AREA_NOT_COMPLETION", "AREA_YES_COMPLETION", "AREA_YES_SETTLEMENT", "TMP_1KY_VALUE", "TMP_1KY_AREA", "TMP_1KY_PRICE", "TMP_2QP_VALUE", "TMP_2QP_AREA", "TMP_2QP_PRICE", "TMP_3DT_TARGETVALUE", "TMP_3DT_TARGETAREA", "TMP_3DT_TARGETPRICE", "CW_VALUE_DT_ALL", "CW_VALUE_REMAIN", "CW_VALUE_HAVED_SALE", "CW_VALUE_RESERVE", "CW_VALUE_IN_PROCESS", "CW_VALUE_ALLOW_SALE", "CW_VALUE_STOCK", "CW_VALUE_NOT_PLANNING_PERMIT", "CW_VALUE_NOT_CONSTRUCTION_PER", "CW_VALUE_NOT_SALE_PERMIT", "CW_VALUE_NOT_COMPLETION", "CW_VALUE_YES_COMPLETION", "CW_VALUE_YES_SETTLEMENT", "CW_AREA_DT_ALL", "CW_AREA_REMAIN", "CW_AREA_HAVED_SALE", "CW_AREA_RESERVE", "CW_AREA_IN_PROCESS", "CW_AREA_ALLOW_SALE", "CW_AREA_STOCK", "CW_AREA_NOT_PLANNING_PERMIT", "CW_AREA_NOT_CONSTRUCTION_PER", "CW_AREA_NOT_SALE_PERMIT", "CW_AREA_NOT_COMPLETION", "CW_AREA_YES_COMPLETION", "CW_AREA_YES_SETTLEMENT", "ZZ_VALUE_DT_ALL", "ZZ_VALUE_REMAIN", "ZZ_VALUE_HAVED_SALE", "ZZ_VALUE_RESERVE", "ZZ_VALUE_IN_PROCESS", "ZZ_VALUE_ALLOW_SALE", "ZZ_VALUE_STOCK", "ZZ_VALUE_NOT_PLANNING_PERMIT", "ZZ_VALUE_NOT_CONSTRUCTION_PER", "ZZ_VALUE_NOT_SALE_PERMIT", "ZZ_VALUE_NOT_COMPLETION", "ZZ_VALUE_YES_COMPLETION", "ZZ_VALUE_YES_SETTLEMENT", "ZZ_AREA_DT_ALL", "ZZ_AREA_REMAIN", "ZZ_AREA_HAVED_SALE", "ZZ_AREA_RESERVE", "ZZ_AREA_IN_PROCESS", "ZZ_AREA_ALLOW_SALE", "ZZ_AREA_STOCK", "ZZ_AREA_NOT_PLANNING_PERMIT", "ZZ_AREA_NOT_CONSTRUCTION_PER", "ZZ_AREA_NOT_SALE_PERMIT", "ZZ_AREA_NOT_COMPLETION", "ZZ_AREA_YES_COMPLETION", "ZZ_AREA_YES_SETTLEMENT", "SY_VALUE_DT_ALL", "SY_VALUE_REMAIN", "SY_VALUE_HAVED_SALE", "SY_VALUE_RESERVE", "SY_VALUE_IN_PROCESS", "SY_VALUE_ALLOW_SALE", "SY_VALUE_STOCK", "SY_VALUE_NOT_PLANNING_PERMIT", "SY_VALUE_NOT_CONSTRUCTION_PER", "SY_VALUE_NOT_SALE_PERMIT", "SY_VALUE_NOT_COMPLETION", "SY_VALUE_YES_COMPLETION", "SY_VALUE_YES_SETTLEMENT", "SY_AREA_DT_ALL", "SY_AREA_REMAIN", "SY_AREA_HAVED_SALE", "SY_AREA_RESERVE", "SY_AREA_IN_PROCESS", "SY_AREA_ALLOW_SALE", "SY_AREA_STOCK", "SY_AREA_NOT_PLANNING_PERMIT", "SY_AREA_NOT_CONSTRUCTION_PER", "SY_AREA_NOT_SALE_PERMIT", "SY_AREA_NOT_COMPLETION", "SY_AREA_YES_COMPLETION", "SY_AREA_YES_SETTLEMENT", "PROJ_ID") AS SELECT
          d1.worth AS Target_1
          ,d2.worth AS Target_2
          ,d3.worth AS Target_3
          ,d.worth AS Target_Now
          ,ROUND(a.value_dt_all-d.worth*10000,2) AS Target_Now_Diff
         ,a."ID",a."OBJ_ID",a."OBJ_NAME",a."OBJ_TYPE",a."OBJ_IS_PARKING",a."OBJ_IS_SALE",a."OBJ_IS_HOLD",a."PARENT_ID",a."OBJ_LEVEL",a."ORDER_CODE",a."ORDER_HIERARCHY_CODE",a."VALUE_DT_ALL",a."VALUE_REMAIN",a."VALUE_HAVED_SALE",a."VALUE_RESERVE",a."VALUE_IN_PROCESS",a."VALUE_ALLOW_SALE",a."VALUE_STOCK",a."VALUE_NOT_PLANNING_PERMIT",a."VALUE_NOT_CONSTRUCTION_PERMIT",a."VALUE_NOT_SALE_PERMIT",a."VALUE_NOT_COMPLETION",a."VALUE_YES_COMPLETION",a."VALUE_YES_SETTLEMENT",a."AREA_DT_ALL",a."AREA_REMAIN",a."AREA_HAVED_SALE",a."AREA_RESERVE",a."AREA_IN_PROCESS",a."AREA_ALLOW_SALE",a."AREA_STOCK",a."AREA_NOT_PLANNING_PERMIT",a."AREA_NOT_CONSTRUCTION_PERMIT",a."AREA_NOT_SALE_PERMIT",a."AREA_NOT_COMPLETION",a."AREA_YES_COMPLETION",a."AREA_YES_SETTLEMENT",a."TMP_1KY_VALUE",a."TMP_1KY_AREA",a."TMP_1KY_PRICE",a."TMP_2QP_VALUE",a."TMP_2QP_AREA",a."TMP_2QP_PRICE",a."TMP_3DT_TARGETVALUE",a."TMP_3DT_TARGETAREA",a."TMP_3DT_TARGETPRICE",a."CW_VALUE_DT_ALL",a."CW_VALUE_REMAIN",a."CW_VALUE_HAVED_SALE",a."CW_VALUE_RESERVE",a."CW_VALUE_IN_PROCESS",a."CW_VALUE_ALLOW_SALE",a."CW_VALUE_STOCK",a."CW_VALUE_NOT_PLANNING_PERMIT",a."CW_VALUE_NOT_CONSTRUCTION_PER",a."CW_VALUE_NOT_SALE_PERMIT",a."CW_VALUE_NOT_COMPLETION",a."CW_VALUE_YES_COMPLETION",a."CW_VALUE_YES_SETTLEMENT",a."CW_AREA_DT_ALL",a."CW_AREA_REMAIN",a."CW_AREA_HAVED_SALE",a."CW_AREA_RESERVE",a."CW_AREA_IN_PROCESS",a."CW_AREA_ALLOW_SALE",a."CW_AREA_STOCK",a."CW_AREA_NOT_PLANNING_PERMIT",a."CW_AREA_NOT_CONSTRUCTION_PER",a."CW_AREA_NOT_SALE_PERMIT",a."CW_AREA_NOT_COMPLETION",a."CW_AREA_YES_COMPLETION",a."CW_AREA_YES_SETTLEMENT",a."ZZ_VALUE_DT_ALL",a."ZZ_VALUE_REMAIN",a."ZZ_VALUE_HAVED_SALE",a."ZZ_VALUE_RESERVE",a."ZZ_VALUE_IN_PROCESS",a."ZZ_VALUE_ALLOW_SALE",a."ZZ_VALUE_STOCK",a."ZZ_VALUE_NOT_PLANNING_PERMIT",a."ZZ_VALUE_NOT_CONSTRUCTION_PER",a."ZZ_VALUE_NOT_SALE_PERMIT",a."ZZ_VALUE_NOT_COMPLETION",a."ZZ_VALUE_YES_COMPLETION",a."ZZ_VALUE_YES_SETTLEMENT",a."ZZ_AREA_DT_ALL",a."ZZ_AREA_REMAIN",a."ZZ_AREA_HAVED_SALE",a."ZZ_AREA_RESERVE",a."ZZ_AREA_IN_PROCESS",a."ZZ_AREA_ALLOW_SALE",a."ZZ_AREA_STOCK",a."ZZ_AREA_NOT_PLANNING_PERMIT",a."ZZ_AREA_NOT_CONSTRUCTION_PER",a."ZZ_AREA_NOT_SALE_PERMIT",a."ZZ_AREA_NOT_COMPLETION",a."ZZ_AREA_YES_COMPLETION",a."ZZ_AREA_YES_SETTLEMENT",a."SY_VALUE_DT_ALL",a."SY_VALUE_REMAIN",a."SY_VALUE_HAVED_SALE",a."SY_VALUE_RESERVE",a."SY_VALUE_IN_PROCESS",a."SY_VALUE_ALLOW_SALE",a."SY_VALUE_STOCK",a."SY_VALUE_NOT_PLANNING_PERMIT",a."SY_VALUE_NOT_CONSTRUCTION_PER",a."SY_VALUE_NOT_SALE_PERMIT",a."SY_VALUE_NOT_COMPLETION",a."SY_VALUE_YES_COMPLETION",a."SY_VALUE_YES_SETTLEMENT",a."SY_AREA_DT_ALL",a."SY_AREA_REMAIN",a."SY_AREA_HAVED_SALE",a."SY_AREA_RESERVE",a."SY_AREA_IN_PROCESS",a."SY_AREA_ALLOW_SALE",a."SY_AREA_STOCK",a."SY_AREA_NOT_PLANNING_PERMIT",a."SY_AREA_NOT_CONSTRUCTION_PER",a."SY_AREA_NOT_SALE_PERMIT",a."SY_AREA_NOT_COMPLETION",a."SY_AREA_YES_COMPLETION",a."SY_AREA_YES_SETTLEMENT",a."PROJ_ID"

      FROM dwm_dt_value a
      LEFT JOIN v_dwm_target_worth_idlist b ON a.proj_id=b.proj_id
      LEFT JOIN dwm_target_worth_dtl d1 ON d1.target_worth_id=b.A1_可研版目标货值ID AND d1.obj_id=a.obj_id AND d1.obj_Type<>40 AND a.OBJ_TYPE = '项目'
      LEFT JOIN dwm_target_worth_dtl d2 ON d2.target_worth_id=b.A2_全盘版目标货值ID AND d2.obj_id=a.obj_id AND d2.obj_Type<>40 AND a.OBJ_TYPE = '项目'
      LEFT JOIN dwm_target_worth_dtl d3 ON d3.target_worth_id=b.A3_动态版目标货值ID AND d3.obj_id=a.obj_id AND d3.obj_Type<>40 AND a.OBJ_TYPE = '项目'
      LEFT JOIN dwm_target_worth_dtl d ON d.target_worth_id=b.A_当前最新版ID AND d.obj_id=a.obj_id AND d.obj_Type<>40
       --WHERE a.proj_id='23730850-ea5d-44de-b980-a3bb65ab0098'
     -- ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_DWM_ROOM_BY_BLD
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_ROOM_BY_BLD" ("BUILDING_ID", "ORDER_HIERARCHY_CODE", "PROJECT_NAME", "PROJ_ID", "ALL库存货值_房间合计", "ALL已售货值_房间合计", "ALL库存及已售总货值", "ALL库存面积_房间合计", "ALL已售面积_房间合计", "ALL库存套数_房间合计", "ALL已售套数_房间合计", "ALL库存货量_房间合计", "ALL已售货量_房间合计", "ZZ库存货值_房间合计", "ZZ已售货值_房间合计", "ZZ库存面积_房间合计", "ZZ已售面积_房间合计", "ZZ库存套数_房间合计", "ZZ已售套数_房间合计", "SY库存货值_房间合计", "SY已售货值_房间合计", "SY库存面积_房间合计", "SY已售面积_房间合计", "SY库存套数_房间合计", "SY已售套数_房间合计", "ZS库存货值_房间合计", "ZS已售货值_房间合计", "ZS库存面积_房间合计", "ZS已售面积_房间合计", "ZS库存套数_房间合计", "ZS已售套数_房间合计", "CW库存货值_房间合计", "CW已售货值_房间合计", "CW库存面积_房间合计", "CW已售面积_房间合计", "CW库存套数_房间合计", "CW已售套数_房间合计") AS SELECT b.building_id
       ,a.order_hierarchy_code
      ,b.project_name
      ,b.project_id AS Proj_id
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约' THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0)) AS ALL库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS ALL已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约' THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0))
      +SUM(NVL((CASE WHEN b.sale_state='签约' THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS ALL库存及已售总货值

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ALL库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ALL已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'THEN 1 ELSE 0 END),0)) AS ALL库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN 1 ELSE 0 END),0)) AS ALL已售套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name IN ('住宅','商办') THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ALL库存货量_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name IN ('住宅','商办') THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ALL已售货量_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='住宅' THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0)) AS ZZ库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='住宅' THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS ZZ已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='住宅' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ZZ库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='住宅' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ZZ已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='住宅' THEN 1 ELSE 0 END),0)) AS ZZ库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='住宅' THEN 1 ELSE 0 END),0)) AS ZZ已售套数_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='商办' THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0)) AS SY库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='商办' THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS SY已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='商办' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS SY库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='商办' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS SY已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='商办' THEN 1 ELSE 0 END),0)) AS SY库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='商办' THEN 1 ELSE 0 END),0)) AS SY已售套数_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name IN ('住宅','商办') THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0)) AS ZS库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name IN ('住宅','商办') THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS ZS已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name IN ('住宅','商办') THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ZS库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name IN ('住宅','商办') THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS ZS已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name IN ('住宅','商办') THEN 1 ELSE 0 END),0)) AS ZS库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name IN ('住宅','商办') THEN 1 ELSE 0 END),0)) AS ZS已售套数_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN ROUND(b.bz_price*NVL(b.new_bld_area,0),2) ELSE 0 END),0)) AS CW库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN NVL(b.trade_total,0) ELSE 0 END),0)) AS CW已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS CW库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN NVL(b.new_bld_area,0) ELSE 0 END),0)) AS CW已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN 1 ELSE 0 END),0)) AS CW库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN 1 ELSE 0 END),0)) AS CW已售套数_房间合计

FROM Mdm_Room b LEFT JOIN mdm_build a ON a.id=b.building_id
-- WHERE b.project_name='佛山领秀公馆（北区）'
GROUP BY b.project_name,b.project_id,b.building_id ,a.order_hierarchy_code
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_DWM_TARGET_PRICE_BLD_NOW
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_TARGET_PRICE_BLD_NOW" ("PROJ_NAME", "BLD_NAME", "货值A_最新动态版", "货值A_最新动态版ID", "货值A_最新版审核日期", "是否有目标均价记录", "经营类别", "主数据PT阶段", "主数据PT阶段序号", "楼栋阶段", "目标货值阶段", "是否已取规证", "是否已取施证", "是否已取预售证", "是否已竣备", "四证当前阶段", "ZZ_目标均价", "SY_目标均价", "CW_目标均价", "JT_B1ZZ_目标货值", "JT_B1SY_目标货值", "JT_B1CW_目标货值", "JT_B2ZZ_目标货值", "JT_B2SY_目标货值", "JT_B2CW_目标货值", "JT_B3ZZ_目标货值", "JT_B3SY_目标货值", "JT_B3CW_目标货值", "DT_B0ZZ_动态货值", "DT_B0SY_动态货值", "DT_B0CW_动态货值", "DT_B0ZZ_动态货量", "DT_B0SY_动态货量", "DT_B0CW_动态货量", "DT_B1ZZ_动态货值", "DT_B1SY_动态货值", "DT_B1CW_动态货值", "DT_B2ZZ_动态货值", "DT_B2SY_动态货值", "DT_B2CW_动态货值", "DT_B1ZZ_动态货量", "DT_B1SY_动态货量", "DT_B1CW_动态货量", "DT_B2ZZ_动态货量", "DT_B2SY_动态货量", "DT_B2CW_动态货量", "目标均价", "PROJ_ID", "PROJECT_NAME", "BLD_ID", "BUILD_NAME", "ORDER_HIERARCHY_CODE", "NOW_PHASE_ID", "NOW_PHASE_NAME", "NOW_PHASE_ORDER", "B1_是否有", "B1_经营类别", "B2_是否有", "B3_是否有", "B4_是否有", "B1ZZ_建筑面积", "B1ZZ_计容面积", "B1ZZ_可售面积", "B1SY_建筑面积", "B1SY_计容面积", "B1SY_可售面积", "B1CW_建筑面积", "B1CW_计容面积", "B1CW_可售面积", "B1CW_可售车位数", "B1PT_建筑面积", "B1PT_计容面积", "B1PT_可售面积", "B2ZZ_建筑面积", "B2ZZ_计容面积", "B2ZZ_可售面积", "B2SY_建筑面积", "B2SY_计容面积", "B2SY_可售面积", "B2CW_建筑面积", "B2CW_计容面积", "B2CW_可售面积", "B2CW_可售车位数", "B2PT_建筑面积", "B2PT_计容面积", "B2PT_可售面积", "B3ZZ_建筑面积", "B3ZZ_计容面积", "B3ZZ_可售面积", "B3SY_建筑面积", "B3SY_计容面积", "B3SY_可售面积", "B3CW_建筑面积", "B3CW_计容面积", "B3CW_可售面积", "B3CW_可售车位数", "B3PT_建筑面积", "B3PT_计容面积", "B3PT_可售面积", "B4ZZ_建筑面积", "B4ZZ_计容面积", "B4ZZ_可售面积", "B4SY_建筑面积", "B4SY_计容面积", "B4SY_可售面积", "B4CW_建筑面积", "B4CW_计容面积", "B4CW_可售面积", "B4CW_可售车位数", "B4PT_建筑面积", "B4PT_计容面积", "B4PT_可售面积") AS SELECT
a.Project_name AS Proj_name,a.build_name AS Bld_name
,b.A_当前最新版 AS 货值A_最新动态版,b.A_当前最新版ID AS 货值A_最新动态版ID,b.A_最新版审核日期 AS 货值A_最新版审核日期
,(CASE WHEN c.id IS NOT NULL THEN '有' ELSE '无' END ) AS 是否有目标均价记录
,c.operate_attribute_name AS 经营类别
,a.NOW_Phase_ID AS 主数据PT阶段
,a.Now_Phase_Order AS 主数据PT阶段序号
,c.obj_phase_id AS 楼栋阶段
,b.A_当前最新版ID AS 目标货值阶段
,d.is_get_con_plan_permit AS 是否已取规证
,d.is_get_constrcution_permit AS 是否已取施证
,d.is_get_pre_sale_permit AS 是否已取预售证
,d.is_get_completed_permit AS 是否已竣备
,e.Permit_Now_Phase AS 四证当前阶段
,(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) AS ZZ_目标均价
,(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) AS SY_目标均价
,(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) AS CW_目标均价

,a.B1ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B1ZZ_目标货值 -- B1表示“规证阶段”，ZZ表示住宅，JT表示“静态”
,a.B1SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B1SY_目标货值
,a.B1CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B1CW_目标货值

,a.B2ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B2ZZ_目标货值 -- B2表示“施证阶段”，ZZ表示住宅，JT表示“静态”
,a.B2SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B2SY_目标货值
,a.B2CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B2CW_目标货值

,a.B3ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B3ZZ_目标货值 -- B3表示“预售证阶段”，ZZ表示住宅，JT表示“静态”
,a.B3SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B3SY_目标货值
,a.B3CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) AS JT_B3CW_目标货值

--
,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END) AS DT_B0ZZ_动态货值 -- B1表示“未取规证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END)  AS DT_B0SY_动态货值
,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END)  AS DT_B0CW_动态货值

,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1ZZ_可售面积 ELSE 0 END) AS DT_B0ZZ_动态货量 -- B1表示“规证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1SY_可售面积  ELSE 0 END)  AS DT_B0SY_动态货量
,(CASE WHEN e.Permit_Now_Phase='B0' THEN a.B1CW_可售车位数 ELSE 0 END)  AS DT_B0CW_动态货量
--

,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END) AS DT_B1ZZ_动态货值 -- B1表示“规证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END)  AS DT_B1SY_动态货值
,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END)  AS DT_B1CW_动态货值

,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0) THEN a.B2ZZ_可售面积*(CASE WHEN c.obj_name LIKE '住宅%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END) AS DT_B2ZZ_动态货值 -- B2表示“施证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0)  THEN a.B2SY_可售面积*(CASE WHEN c.obj_name LIKE '商办产业%' THEN NVL(c.average_price,0) ELSE 0 END) ELSE 0 END) AS DT_B2SY_动态货值
,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0)  THEN a.B2CW_可售车位数*(CASE WHEN c.obj_name LIKE '车位%' THEN NVL(c.average_price,0) ELSE 0 END)ELSE 0 END)  AS DT_B2CW_动态货值

,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1ZZ_可售面积 ELSE 0 END) AS DT_B1ZZ_动态货量 -- B1表示“规证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1SY_可售面积  ELSE 0 END)  AS DT_B1SY_动态货量
,(CASE WHEN e.Permit_Now_Phase='B1' THEN a.B1CW_可售车位数 ELSE 0 END)  AS DT_B1CW_动态货量

,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0)  THEN a.B2ZZ_可售面积 ELSE 0 END) AS DT_B2ZZ_动态货量 -- B2表示“施证阶段”，ZZ表示住宅，DT表示“动态”
,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0)  THEN a.B2SY_可售面积 ELSE 0 END) AS DT_B2SY_动态货量
,(CASE WHEN e.Permit_Now_Phase='B2' OR (e.Permit_Now_Phase='B3' AND NVL(f.RoomCount,0)=0)  THEN a.B2CW_可售车位数 ELSE 0 END)  AS DT_B2CW_动态货量

,NVL(c.average_price,0) AS 目标均价
,a."PROJ_ID",a."PROJECT_NAME",a."BLD_ID",a."BUILD_NAME",a."ORDER_HIERARCHY_CODE",a."NOW_PHASE_ID",a."NOW_PHASE_NAME",a."NOW_PHASE_ORDER",a."B1_是否有",a."B1_经营类别",a."B2_是否有",a."B3_是否有",a."B4_是否有",a."B1ZZ_建筑面积",a."B1ZZ_计容面积",a."B1ZZ_可售面积",a."B1SY_建筑面积",a."B1SY_计容面积",a."B1SY_可售面积",a."B1CW_建筑面积",a."B1CW_计容面积",a."B1CW_可售面积",a."B1CW_可售车位数",a."B1PT_建筑面积",a."B1PT_计容面积",a."B1PT_可售面积",a."B2ZZ_建筑面积",a."B2ZZ_计容面积",a."B2ZZ_可售面积",a."B2SY_建筑面积",a."B2SY_计容面积",a."B2SY_可售面积",a."B2CW_建筑面积",a."B2CW_计容面积",a."B2CW_可售面积",a."B2CW_可售车位数",a."B2PT_建筑面积",a."B2PT_计容面积",a."B2PT_可售面积",a."B3ZZ_建筑面积",a."B3ZZ_计容面积",a."B3ZZ_可售面积",a."B3SY_建筑面积",a."B3SY_计容面积",a."B3SY_可售面积",a."B3CW_建筑面积",a."B3CW_计容面积",a."B3CW_可售面积",a."B3CW_可售车位数",a."B3PT_建筑面积",a."B3PT_计容面积",a."B3PT_可售面积",a."B4ZZ_建筑面积",a."B4ZZ_计容面积",a."B4ZZ_可售面积",a."B4SY_建筑面积",a."B4SY_计容面积",a."B4SY_可售面积",a."B4CW_建筑面积",a."B4CW_计容面积",a."B4CW_可售面积",a."B4CW_可售车位数",a."B4PT_建筑面积",a."B4PT_计容面积",a."B4PT_可售面积"
FROM V_MDM_bld_Index_SUM a
LEFT JOIN V_DWM_Target_Worth_IdList b ON a.Proj_id=b.proj_id
LEFT JOIN dwm_target_worth_dtl c ON c.target_worth_id=b.A_当前最新版ID AND c.obj_id=a.bld_id AND c.obj_type=40
LEFT JOIN mdm_build d ON a.bld_id=d.id AND d.is_delete=0
LEFT JOIN (SELECT ID,(case when is_get_completed_permit=1 THEN 'B4'
             ELSE (case when is_get_pre_sale_permit=1 THEN 'B3'
               ELSE (case when is_get_constrcution_permit=1 THEN 'B2'
                 ELSE (case when is_get_con_plan_permit=1 THEN 'B1'
                   ELSE 'B0' END )
                    END )  END )
             END ) AS  Permit_Now_Phase
           FROM mdm_build
          ) e ON a.bld_id=e.id
LEFT JOIN (SELECT mdm_room.building_id AS Bld_id,NVL(COUNT(*),0) AS RoomCount FROM mdm_room GROUP BY mdm_room.building_id ) f ON f.bld_id=e.id
WHERE 1=1
-- AND a.project_name='花语岭南苑'
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_DWM_TARGET_WORTH_DTL_NOW
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_TARGET_WORTH_DTL_NOW" ("ID", "OBJ_NAME", "OBJ_ID", "OPERATE_ATTRIBUTE_ID", "OPERATE_ATTRIBUTE_NAME", "TOTAL_BUILD_AREA", "TOTAL_VOLUME_AREA", "TOTAL_SALES_AREA", "GROUND_CAN_SELL_AREA", "UNDERGROUND_CAN_SELL_AREA", "TOTAL_CARPORT", "GROUND_CARPORT", "UNDERGROUND_CARPORT", "AVERAGE_PRICE", "WORTH", "TARGET_WORTH_ID", "OBJ_TYPE", "CREATOR_ID", "CREATED", "CREATOR", "MODIFIED", "MODIFIER_ID", "MODIFIER", "OBJ_PHASE_ID", "IS_CARPORT") AS SELECT b."ID",b."OBJ_NAME",b."OBJ_ID",b."OPERATE_ATTRIBUTE_ID",b."OPERATE_ATTRIBUTE_NAME",b."TOTAL_BUILD_AREA",b."TOTAL_VOLUME_AREA",b."TOTAL_SALES_AREA",b."GROUND_CAN_SELL_AREA",b."UNDERGROUND_CAN_SELL_AREA",b."TOTAL_CARPORT",b."GROUND_CARPORT",b."UNDERGROUND_CARPORT",b."AVERAGE_PRICE",b."WORTH",b."TARGET_WORTH_ID",b."OBJ_TYPE",b."CREATOR_ID",b."CREATED",b."CREATOR",b."MODIFIED",b."MODIFIER_ID",b."MODIFIER",b."OBJ_PHASE_ID",b."IS_CARPORT"
FROM v_dwm_target_worth_now a
LEFT   JOIN  dwm_target_worth_dtl b ON a.ID=b.target_worth_id
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_DWM_TARGET_WORTH_IDLIST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_TARGET_WORTH_IDLIST" ("PROJ_ID", "ORDER_HIERARCHY_CODE", "PROJECT_NAME", "A_当前最新版", "A_当前最新版ID", "A_最新版审核日期", "A1_可研版目标货值ID", "A2_全盘版目标货值ID", "A3_动态版目标货值ID") AS SELECT a.id AS proj_id,a.order_hierarchy_code,a.project_name
,(CASE WHEN b2.id IS NOT NULL THEN 20  ELSE (CASE WHEN b1.id IS NOT NULL THEN 10 ELSE (CASE WHEN b0.id IS NOT NULL THEN 0  ELSE NULL END ) END ) END) AS A_当前最新版
,(CASE WHEN b2.id IS NOT NULL THEN b2.id  ELSE (CASE WHEN b1.id IS NOT NULL THEN b1.id  ELSE (CASE WHEN b0.id IS NOT NULL THEN b0.id  ELSE '' END ) END ) END) AS A_当前最新版ID
,(CASE WHEN b2.id IS NOT NULL THEN b2.approval_Time  ELSE (CASE WHEN b1.id IS NOT NULL THEN b1.approval_Time  ELSE (CASE WHEN b0.id IS NOT NULL THEN b0.approval_Time  ELSE  NULL END ) END ) END) AS A_最新版审核日期

,b0.id AS A1_可研版目标货值ID
,b1.id AS A2_全盘版目标货值ID
,b2.id AS A3_动态版目标货值ID
FROM mdm_project a
LEFT JOIN DWM_TARGET_WORTH b0 ON a.id=b0.proj_id AND b0.approval_status='已审核' AND b0.target_worth_phase=0 AND b0.is_delete=0
LEFT JOIN DWM_TARGET_WORTH b1 ON a.id=b1.proj_id AND b1.approval_status='已审核' AND b1.target_worth_phase=10 AND b1.is_delete=0
LEFT JOIN ( SELECT t1.*   FROM DWM_TARGET_WORTH t1
          WHERE approval_status='已审核' AND target_worth_phase=20 AND is_delete=0
              AND t1.ID IN (SELECT ID FROM V_DWM_TARGET_WORTH_NOW)
          ) b2 ON a.id=b2.proj_id AND b2.approval_status='已审核' AND b2.target_worth_phase=20 AND b2.is_delete=0

WHERE a.is_delete=0 AND a.approval_status='已审核'
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_DWM_TARGET_WORTH_NOW
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_DWM_TARGET_WORTH_NOW" ("ORDER_HIERARCHY_CODE", "PROJECT_CODE", "ID", "PROJ_ID", "PROJ_NAME", "TARGET_WORTH_PHASE", "TARGET_WORTH", "REMARK", "APPROVAL_STATUS", "APPROVER_ID", "APPROVAL_TIME", "CREATOR_ID", "CREATOR", "CREATED", "MODIFIED", "MODIFIER_ID", "MODIFIER", "WORTH_V", "PREVIOUS_V_WORTH", "PREVIOUS_V_INCREMENT", "FULL_V_WORTH", "FULL_V_INCREMENT", "FEASIBILITY_STUDY_V_WORTH", "FEASIBILITY_STUDY_V_INCREMENT", "IS_DELETE", "APPROVER") AS SELECT a.order_hierarchy_code,a.project_code,b."ID",b."PROJ_ID",b."PROJ_NAME",b."TARGET_WORTH_PHASE"
,b."TARGET_WORTH",b."REMARK",b."APPROVAL_STATUS",b."APPROVER_ID",b."APPROVAL_TIME"
,b."CREATOR_ID",b."CREATOR",b."CREATED",b."MODIFIED",b."MODIFIER_ID",b."MODIFIER"
,b."WORTH_V",b."PREVIOUS_V_WORTH",b."PREVIOUS_V_INCREMENT",b."FULL_V_WORTH",b."FULL_V_INCREMENT"
,b."FEASIBILITY_STUDY_V_WORTH",b."FEASIBILITY_STUDY_V_INCREMENT",b."IS_DELETE",b."APPROVER"
FROM sys_project A
LEFT JOIN DWM_TARGET_WORTH B ON A.id = B.PROJ_ID AND b.is_delete=0 AND b.approval_status='已审核'
LEFT JOIN (SELECT
        proj_id,MAX(target_worth_phase) AS target_worth_phase,MAX(worth_v) AS worth_v
        FROM DWM_TARGET_WORTH
        WHERE is_delete=0 AND  APPROVAL_STATUS = '已审核'
        GROUP BY  proj_id) c ON B.Proj_Id=C.proj_id AND B.Target_Worth_Phase=C.Target_Worth_Phase AND B.Worth_v=C.Worth_v
WHERE c.proj_id IS NOT NULL
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_MDM_BLD_INDEX_SUM
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_BLD_INDEX_SUM" ("PROJ_ID", "PROJECT_NAME", "BLD_ID", "BUILD_NAME", "ORDER_HIERARCHY_CODE", "NOW_PHASE_ID", "NOW_PHASE_NAME", "NOW_PHASE_ORDER", "B1_是否有", "B1_经营类别", "B2_是否有", "B3_是否有", "B4_是否有", "B1ZZ_建筑面积", "B1ZZ_计容面积", "B1ZZ_可售面积", "B1SY_建筑面积", "B1SY_计容面积", "B1SY_可售面积", "B1CW_建筑面积", "B1CW_计容面积", "B1CW_可售面积", "B1CW_可售车位数", "B1PT_建筑面积", "B1PT_计容面积", "B1PT_可售面积", "B2ZZ_建筑面积", "B2ZZ_计容面积", "B2ZZ_可售面积", "B2SY_建筑面积", "B2SY_计容面积", "B2SY_可售面积", "B2CW_建筑面积", "B2CW_计容面积", "B2CW_可售面积", "B2CW_可售车位数", "B2PT_建筑面积", "B2PT_计容面积", "B2PT_可售面积", "B3ZZ_建筑面积", "B3ZZ_计容面积", "B3ZZ_可售面积", "B3SY_建筑面积", "B3SY_计容面积", "B3SY_可售面积", "B3CW_建筑面积", "B3CW_计容面积", "B3CW_可售面积", "B3CW_可售车位数", "B3PT_建筑面积", "B3PT_计容面积", "B3PT_可售面积", "B4ZZ_建筑面积", "B4ZZ_计容面积", "B4ZZ_可售面积", "B4SY_建筑面积", "B4SY_计容面积", "B4SY_可售面积", "B4CW_建筑面积", "B4CW_计容面积", "B4CW_可售面积", "B4CW_可售车位数", "B4PT_建筑面积", "B4PT_计容面积", "B4PT_可售面积") AS SELECT a.id AS Proj_id
,a.project_name
,b.id AS bld_id
,b.build_name
,b.order_hierarchy_code
,C.PHASE_ID AS NOW_Phase_ID
,G.phase_name AS Now_phase_Name
,c.phase_order AS Now_Phase_Order

,SUM(CASE WHEN C1.Id IS NOT NULL THEN 1 ELSE 0 END ) AS B1_是否有
,SUM(CASE WHEN E1.OPERATE_ATTRIBUTE_NAME='可售' THEN 1 ELSE 0 END ) AS B1_经营类别
,SUM(CASE WHEN C2.Id IS NOT NULL THEN 1 ELSE 0 END ) AS B2_是否有
,SUM(CASE WHEN C3.Id IS NOT NULL THEN 1 ELSE 0 END ) AS B3_是否有
,SUM(CASE WHEN C4.Id IS NOT NULL THEN 1 ELSE 0 END ) AS B4_是否有

,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='A' THEN NVL(E1.GROUND_TOTAL_BUILD_AREA,0)+NVL(E1.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B1ZZ_建筑面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='A' THEN NVL(E1.GROUND_CAPACITY_AREA,0)+NVL(E1.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B1ZZ_计容面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='A' THEN NVL(E1.GROUND_SALE_AREA,0)+NVL(E1.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B1ZZ_可售面积

,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='B' THEN NVL(E1.GROUND_TOTAL_BUILD_AREA,0)+NVL(E1.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B1SY_建筑面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='B' THEN NVL(E1.GROUND_CAPACITY_AREA,0)+NVL(E1.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B1SY_计容面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='B' THEN NVL(E1.GROUND_SALE_AREA,0)+NVL(E1.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B1SY_可售面积

,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='C' THEN NVL(E1.GROUND_TOTAL_BUILD_AREA,0)+NVL(E1.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B1CW_建筑面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='C' THEN NVL(E1.GROUND_CAPACITY_AREA,0)+NVL(E1.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B1CW_计容面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='C' THEN NVL(E1.GROUND_SALE_AREA,0)+NVL(E1.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B1CW_可售面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='C' THEN NVL(E1.UNDERGROUND_R_SALE_CARPORT,0)+NVL(E1.UNDERGROUND_FRFJ_SALE_CARPORT,0)+NVL(E1.UNDERGROUND_FRJ_SALE_CARPORT,0) ELSE 0 END ) AS B1CW_可售车位数

,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='D' THEN NVL(E1.GROUND_TOTAL_BUILD_AREA,0)+NVL(E1.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B1PT_建筑面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='D' THEN NVL(E1.GROUND_CAPACITY_AREA,0)+NVL(E1.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B1PT_计容面积
,SUM(CASE WHEN SUBSTR(F1.Product_Type_Code,1,1)='D' THEN NVL(E1.GROUND_SALE_AREA,0)+NVL(E1.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B1PT_可售面积


,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='A' THEN NVL(E2.GROUND_TOTAL_BUILD_AREA,0)+NVL(E2.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B2ZZ_建筑面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='A' THEN NVL(E2.GROUND_CAPACITY_AREA,0)+NVL(E2.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B2ZZ_计容面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='A' THEN NVL(E2.GROUND_SALE_AREA,0)+NVL(E2.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B2ZZ_可售面积

,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='B' THEN NVL(E2.GROUND_TOTAL_BUILD_AREA,0)+NVL(E2.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B2SY_建筑面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='B' THEN NVL(E2.GROUND_CAPACITY_AREA,0)+NVL(E2.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B2SY_计容面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='B' THEN NVL(E2.GROUND_SALE_AREA,0)+NVL(E2.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B2SY_可售面积

,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='C' THEN NVL(E2.GROUND_TOTAL_BUILD_AREA,0)+NVL(E2.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B2CW_建筑面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='C' THEN NVL(E2.GROUND_CAPACITY_AREA,0)+NVL(E2.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B2CW_计容面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='C' THEN NVL(E2.GROUND_SALE_AREA,0)+NVL(E2.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B2CW_可售面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='C' THEN NVL(E2.UNDERGROUND_R_SALE_CARPORT,0)+NVL(E2.UNDERGROUND_FRFJ_SALE_CARPORT,0)+NVL(E2.UNDERGROUND_FRJ_SALE_CARPORT,0) ELSE 0 END ) AS B2CW_可售车位数

,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='D' THEN NVL(E2.GROUND_TOTAL_BUILD_AREA,0)+NVL(E2.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B2PT_建筑面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='D' THEN NVL(E2.GROUND_CAPACITY_AREA,0)+NVL(E2.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B2PT_计容面积
,SUM(CASE WHEN SUBSTR(F2.Product_Type_Code,1,1)='D' THEN NVL(E2.GROUND_SALE_AREA,0)+NVL(E2.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B2PT_可售面积


,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='A' THEN NVL(E3.GROUND_TOTAL_BUILD_AREA,0)+NVL(E3.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B3ZZ_建筑面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='A' THEN NVL(E3.GROUND_CAPACITY_AREA,0)+NVL(E3.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B3ZZ_计容面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='A' THEN NVL(E3.GROUND_SALE_AREA,0)+NVL(E3.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B3ZZ_可售面积

,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='B' THEN NVL(E3.GROUND_TOTAL_BUILD_AREA,0)+NVL(E3.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B3SY_建筑面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='B' THEN NVL(E3.GROUND_CAPACITY_AREA,0)+NVL(E3.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B3SY_计容面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='B' THEN NVL(E3.GROUND_SALE_AREA,0)+NVL(E3.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B3SY_可售面积

,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='C' THEN NVL(E3.GROUND_TOTAL_BUILD_AREA,0)+NVL(E3.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B3CW_建筑面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='C' THEN NVL(E3.GROUND_CAPACITY_AREA,0)+NVL(E3.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B3CW_计容面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='C' THEN NVL(E3.GROUND_SALE_AREA,0)+NVL(E3.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B3CW_可售面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='C' THEN NVL(E3.UNDERGROUND_R_SALE_CARPORT,0)+NVL(E3.UNDERGROUND_FRFJ_SALE_CARPORT,0)+NVL(E3.UNDERGROUND_FRJ_SALE_CARPORT,0) ELSE 0 END ) AS B3CW_可售车位数

,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='D' THEN NVL(E3.GROUND_TOTAL_BUILD_AREA,0)+NVL(E3.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B3PT_建筑面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='D' THEN NVL(E3.GROUND_CAPACITY_AREA,0)+NVL(E3.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B3PT_计容面积
,SUM(CASE WHEN SUBSTR(F3.Product_Type_Code,1,1)='D' THEN NVL(E3.GROUND_SALE_AREA,0)+NVL(E3.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B3PT_可售面积


,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='A' THEN NVL(E4.GROUND_TOTAL_BUILD_AREA,0)+NVL(E4.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B4ZZ_建筑面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='A' THEN NVL(E4.GROUND_CAPACITY_AREA,0)+NVL(E4.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B4ZZ_计容面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='A' THEN NVL(E4.GROUND_SALE_AREA,0)+NVL(E4.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B4ZZ_可售面积

,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='B' THEN NVL(E4.GROUND_TOTAL_BUILD_AREA,0)+NVL(E4.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B4SY_建筑面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='B' THEN NVL(E4.GROUND_CAPACITY_AREA,0)+NVL(E4.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B4SY_计容面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='B' THEN NVL(E4.GROUND_SALE_AREA,0)+NVL(E4.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B4SY_可售面积

,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='C' THEN NVL(E4.GROUND_TOTAL_BUILD_AREA,0)+NVL(E4.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B4CW_建筑面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='C' THEN NVL(E4.GROUND_CAPACITY_AREA,0)+NVL(E4.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B4CW_计容面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='C' THEN NVL(E4.GROUND_SALE_AREA,0)+NVL(E4.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B4CW_可售面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='C' THEN NVL(E4.UNDERGROUND_R_SALE_CARPORT,0)+NVL(E4.UNDERGROUND_FRFJ_SALE_CARPORT,0)+NVL(E4.UNDERGROUND_FRJ_SALE_CARPORT,0) ELSE 0 END ) AS B4CW_可售车位数

,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='D' THEN NVL(E4.GROUND_TOTAL_BUILD_AREA,0)+NVL(E4.UNDERGROUND_TOTAL_BUILD_AREA,0) ELSE 0 END ) AS B4PT_建筑面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='D' THEN NVL(E4.GROUND_CAPACITY_AREA,0)+NVL(E4.UNDERGROUND_CAPACITY_AREA,0) ELSE 0 END ) AS B4PT_计容面积
,SUM(CASE WHEN SUBSTR(F4.Product_Type_Code,1,1)='D' THEN NVL(E4.GROUND_SALE_AREA,0)+NVL(E4.UNDERGROUND_SALE_AREA,0) ELSE 0 END ) AS B4PT_可售面积

FROM  mdm_project a
LEFT JOIN mdm_build b ON a.id=b.proj_id

LEFT JOIN mdm_build_phase C1 ON b.id=C1.BUILD_ID AND C1.PHASE_ORDER=3 -- B1规证阶段
LEFT JOIN mdm_obj_phase_index D1 ON D1.obj_phase_id=c1.id
LEFT JOIN mdm_obj_phase_pt_index E1 ON E1.OBJ_PHASE_ID=c1.id
LEFT JOIN MDM_BUILD_PRODUCT_TYPE F1 ON E1.PRODUCT_TYPE_ID=F1.ID

LEFT JOIN mdm_build_phase C2 ON b.id=C2.BUILD_ID AND C2.PHASE_ORDER=4 -- B2施工证阶段
LEFT JOIN mdm_obj_phase_index D2 ON D2.obj_phase_id=c2.id
LEFT JOIN mdm_obj_phase_pt_index E2 ON E2.OBJ_PHASE_ID=c2.id
LEFT JOIN MDM_BUILD_PRODUCT_TYPE F2 ON E2.PRODUCT_TYPE_ID=F2.ID

LEFT JOIN mdm_build_phase C3 ON b.id=C3.BUILD_ID AND C3.PHASE_ORDER=5 -- B3预售证阶段
LEFT JOIN mdm_obj_phase_index D3 ON D3.obj_phase_id=c3.id
LEFT JOIN mdm_obj_phase_pt_index E3 ON E3.OBJ_PHASE_ID=c3.id
LEFT JOIN MDM_BUILD_PRODUCT_TYPE F3 ON E3.PRODUCT_TYPE_ID=F3.ID


LEFT JOIN mdm_build_phase C4 ON b.id=C4.BUILD_ID AND C4.PHASE_ORDER=6 -- B4竣备阶段
LEFT JOIN mdm_obj_phase_index D4 ON D4.obj_phase_id=c4.id
LEFT JOIN mdm_obj_phase_pt_index E4 ON E4.OBJ_PHASE_ID=c4.id
LEFT JOIN MDM_BUILD_PRODUCT_TYPE F4 ON E4.PRODUCT_TYPE_ID=F4.ID

LEFT JOIN (SELECT BUILD_ID,MAX(PHASE_ORDER) AS NOW_PHASE_ORDER FROM MDM_BUILD_PHASE GROUP BY BUILD_ID)T ON T.BUILD_ID = B.ID -- 当前最新版
LEFT JOIN mdm_build_phase C ON T.BUILD_ID=C.BUILD_ID AND C.PHASE_ORDER=T.NOW_PHASE_ORDER
LEFT JOIN mdm_obj_phase_index D ON D.obj_phase_id=C.Id
LEFT JOIN mdm_obj_phase_pt_index E ON E.OBJ_PHASE_ID=c.id
LEFT JOIN MDM_BUILD_PRODUCT_TYPE F ON E.PRODUCT_TYPE_ID=F.ID
LEFT JOIN mdm_phase G ON C.PHASE_ID=G.id

WHERE a.is_delete=0 AND a.approval_status='已审核'
AND b.is_delete=0
--AND a.project_name='增城国际公馆'
GROUP BY a.id
,a.project_name
,b.id
,b.build_name
,b.order_hierarchy_code
,C.PHASE_ID
,G.phase_name
,c.phase_order

ORDER BY b.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_MDM_BLD_PERMIT_DTL
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_BLD_PERMIT_DTL" ("PROJECT_ID", "PROJECT_NAME", "PARCEL_NAME", "PARCEL_ID", "STAGE_ID", "STAGE_NAME", "BLD_ID", "BLD_NAME", "BLD_CODE", "PRODUCT_FULL_NAME", "MANAGEMENT_TYPE", "PLAN_PERMIT_DATE", "PLAN_PERMIT_ID", "PLAN_PERMIT_NO", "CONSTRUCTION_PERMIT_DATE", "CONSTRUCTION_PERMIT_ID", "CONSTRUCTION_PERMIT_NO", "PRE_SALE_PERMIT_DATE", "PER_SALE_PERMIT_ID", "PRE_SALE_PERMIT_NO", "COMPLETED_PERMIT_DATE", "COMPLATED_PERMIT_ID", "COMPLETED_PERMIT_NO") AS SELECT MB.PROJ_ID AS "PROJECT_ID", MP.PROJECT_NAME AS "PROJECT_NAME",
       --MPAR.PARCEL_NAME AS "PARCEL_NAME"
       '' AS "PARCEL_NAME"
       , MB.PARCEL_ID AS "PARCEL_ID",
       MB.PERIOD_ID AS "STAGE_ID", (CASE WHEN NVL(MB.PERIOD_NAME,'')='' OR MB.PERIOD_NAME='无分期' THEN '' ELSE MB.PERIOD_NAME END) AS "STAGE_NAME",
       MB.ID AS "BLD_ID", MB.BUILD_NAME AS "BLD_NAME",MB.BUILD_NAME AS "BLD_CODE",
      c.product_Type_name AS "PRODUCT_FULL_NAME", c.OPERATE_ATTRIBUTE_NAME AS "MANAGEMENT_TYPE",
      to_char(MB.GET_CON_PLAN_PERMIT_DATE,'yyyy-mm-dd') AS PLAN_PERMIT_DATE, -- 规划许可证办理日期
       MB.CON_PLAN_PERMIT_ID AS "PLAN_PERMIT_ID",
       MB.CON_PLAN_PERMIT_NO AS "PLAN_PERMIT_NO",-- 规划许可证编号
       to_char(MB.GET_CONSTRCUTION_PERMIT_DATE,'yyyy-mm-dd') AS "CONSTRUCTION_PERMIT_DATE", -- 施工许可证办理日期
       MB.CONSTRACUTION_PERMIT_ID AS "CONSTRUCTION_PERMIT_ID",
       MB.CONSTRUCTION_PERMIT_NO AS "CONSTRUCTION_PERMIT_NO", -- 施工许可证编号
       to_char(MB.GET_PRE_SALE_PERMIT_DATE,'yyyy-mm-dd') AS "PRE_SALE_PERMIT_DATE", -- 预售许可证办理日期
       MB.PRE_SALE_PERMIT_ID AS "PER_SALE_PERMIT_ID",
       MB.PRE_SALE_PERMIT_NO AS "PRE_SALE_PERMIT_NO", -- 预售许可证编号
       to_char(MB.GET_COMPLETED_PERMIT_DATE,'yyyy-mm-dd') AS "COMPLETED_PERMIT_DATE", -- 竣工备案办理日期
       MB.COMPLETED_PERMIT_ID AS "COMPLATED_PERMIT_ID",
       MB.GET_COMPLETED_PERMIT_NO AS "COMPLETED_PERMIT_NO"-- 竣工备案编号
FROM   V_MDM_BLD_TO_NOW_PHASE  MB
LEFT  JOIN MDM_PROJECT MP
ON     MB.PROJ_ID = MP.PROJECT_ORIGINAL_ID
LEFT  JOIN MDM_PERIOD MPER
ON    MPER.PERIOD_ORIGINAL_ID = MB.PERIOD_ID
LEFT JOIN MDM_PERIOD_VERSION MPerVer
ON     MPER.PERIOD_VERSION_ID = MPerVer.ID
LEFT  JOIN MDM_PARCEL MPAR
ON     MPAR.ID = MB.PARCEL_ID
 LEFT JOIN MDM_OBJ_PHASE_PT_INDEX c on c.obj_Phase_ID=MB.BLD_PHASE_ID_NOW

WHERE 1=1
and MB.IS_DELETE=0
and MP.APPROVAL_STATUS = '已审核' AND
       MP.PROJECT_VERSION IN
       (SELECT MAX(PROJECT_VERSION)
        FROM   MDM_PROJECT
        WHERE  APPROVAL_STATUS = '已审核'
        GROUP  BY PROJECT_ORIGINAL_ID) AND
       MPerVer.APPROVAL_STATUS = '已审核'
--  and MP.PROJECT_NAME='花语岭南苑'
--  and MP.PROJECT_NAME='佛山凤语潮鸣'
--  and MP.PROJECT_NAME='广州荔湾国际城'
ORDER BY MP.PROJECT_CODE,STAGE_NAME,BLD_NAME
;
--------------------------------------------------------
--  DDL for View V_MDM_BLD_TO_NOW_PHASE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_BLD_TO_NOW_PHASE" ("PROJ_ID", "PROJECT_NAME", "BLD_PHASE_ID_NOW", "PHASE_ID_NOW", "PHASE_ORDER_NOW", "PHASE_NAME_NOW", "PHASE_CODE_N0W", "PHASE_CREATED_DATE", "BLD_ID", "ID", "BUILD_NAME", "ORDER_HIERARCHY_CODE", "FIRST_PRODUCT_NAME", "SECOND_PRODUCT_NAME", "THIRD_PRODUCT_NAME", "PRODUCT_FULL_NAME", "PERIOD_ID", "REMARK", "PARCEL_ID", "DELIVERY_TYPE", "BUILD_STATE", "CREATED", "CREATOR_ID", "CREATOR", "MODIFIED", "MODIFIER_ID", "MODIFIER", "ISSUE_TIME", "IS_DELETE", "PERIOD_NAME", "IS_GET_CON_PLAN_PERMIT", "GET_CON_PLAN_PERMIT_DATE", "CON_PLAN_PERMIT_NO", "IS_GET_CONSTRCUTION_PERMIT", "GET_CONSTRCUTION_PERMIT_DATE", "CONSTRUCTION_PERMIT_NO", "IS_GET_PRE_SALE_PERMIT", "GET_PRE_SALE_PERMIT_DATE", "PRE_SALE_PERMIT_NO", "IS_GET_COMPLETED_PERMIT", "GET_COMPLETED_PERMIT_DATE", "GET_COMPLETED_PERMIT_NO", "NEWEST_BLD_AREA", "NEWEST_SALE_BLD_AREA", "NEWEST_SALE_BLD_AREA_ON", "NEWEST_SALE_BLD_AREA_UBDER", "NEWEST_CARPORT", "CON_PLAN_PERMIT_ID", "CONSTRACUTION_PERMIT_ID", "PRE_SALE_PERMIT_ID", "COMPLETED_PERMIT_ID", "NEWEST_VALUE_PHASE") AS SELECT
 E.ID AS Proj_ID
,E.Project_Name AS Project_Name
,B.ID AS BLD_PHASE_ID_NOW
,C.ID AS PHASE_ID_NOW,C.PHASE_ORDER AS PHASE_ORDER_NOW
,C.PHASE_NAME AS PHASE_NAME_NOW,C.PHASE_CODE AS PHASE_CODE_N0W
,B.CREATED AS PHASE_CREATED_DATE
,A.ID AS BLD_ID
,A."ID",A."BUILD_NAME"
,E.Order_Hierarchy_Code||A.BUILD_NAME AS Order_Hierarchy_Code
,SUBSTR(D.PRODUCT_TYPE_NAME, 1,
       INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 1) - 1) AS FIRST_PRODUCT_NAME
,SUBSTR(D.PRODUCT_TYPE_NAME,
       INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 1) + 1,
       INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 2) -
        INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 1) - 1) AS SECOND_PRODUCT_NAME
,SUBSTR(D.PRODUCT_TYPE_NAME,
       DECODE(INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 2), 0, 100,
               INSTR(D.PRODUCT_TYPE_NAME, '/', 1, 2)) + 1) AS THIRD_PRODUCT_NAME
,D.PRODUCT_TYPE_NAME AS PRODUCT_FULL_NAME
,A."PERIOD_ID",A."REMARK",A."PARCEL_ID",A."DELIVERY_TYPE",A."BUILD_STATE"
,A."CREATED",A."CREATOR_ID",A."CREATOR",A."MODIFIED",A."MODIFIER_ID",A."MODIFIER",A."ISSUE_TIME",A."IS_DELETE",A."PERIOD_NAME",A."IS_GET_CON_PLAN_PERMIT"
,A."GET_CON_PLAN_PERMIT_DATE",A."CON_PLAN_PERMIT_NO",A."IS_GET_CONSTRCUTION_PERMIT",A."GET_CONSTRCUTION_PERMIT_DATE",A."CONSTRUCTION_PERMIT_NO"
,A."IS_GET_PRE_SALE_PERMIT",A."GET_PRE_SALE_PERMIT_DATE",A."PRE_SALE_PERMIT_NO",A."IS_GET_COMPLETED_PERMIT",A."GET_COMPLETED_PERMIT_DATE"
,A."GET_COMPLETED_PERMIT_NO",A."NEWEST_BLD_AREA",A."NEWEST_SALE_BLD_AREA",A."NEWEST_SALE_BLD_AREA_ON",A."NEWEST_SALE_BLD_AREA_UBDER"
,A."NEWEST_CARPORT",A."CON_PLAN_PERMIT_ID",A."CONSTRACUTION_PERMIT_ID",A."PRE_SALE_PERMIT_ID",A."COMPLETED_PERMIT_ID",A."NEWEST_VALUE_PHASE"
FROM MDM_BUILD A
LEFT JOIN MDM_BUILD_PHASE B ON A.ID=B.BUILD_ID
LEFT JOIN MDM_PHASE C ON C.PHASE_ORDER=B.PHASE_ORDER
LEFT JOIN (SELECT B1.PRODUCT_TYPE_CODE, A1.*
         FROM   MDM_OBJ_PHASE_PT_INDEX A1
         INNER  JOIN MDM_BUILD_PRODUCT_TYPE B1
         ON     A1.PRODUCT_TYPE_ID = B1.ID) D ON D.OBJ_PHASE_ID = B.ID
LEFT JOIN mdm_project E ON a.proj_id=E.Id AND E.Is_Delete=0 AND E.Approval_Status='已审核'
WHERE
A.IS_DELETE=0 AND
B.PHASE_ORDER=(SELECT MAX(T.PHASE_ORDER) FROM MDM_BUILD_PHASE T WHERE T.BUILD_ID = A.ID GROUP BY  BUILD_ID )

;
--------------------------------------------------------
--  DDL for View V_MDM_BUILDING
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_BUILDING" ("BUILDINGID", "BUILDINGNAME", "PROJID", "PROJNAME", "PERMIT_STATUS", "STAGESID", "STAGESNAME", "COMPANYID", "COMPANYNAME", "GET_CON_PLAN_PERMIT_DATE", "CON_PLAN_PERMIT_ID", "CON_PLAN_PERMIT_NO", "GET_CONSTRCUTION_PERMIT_DATE", "CONSTRACUTION_PERMIT_ID", "CONSTRUCTION_PERMIT_NO", "GET_PRE_SALE_PERMIT_DATE", "PRE_SALE_PERMIT_ID", "PRE_SALE_PERMIT_NO", "GET_COMPLETED_PERMIT_DATE", "COMPLETED_PERMIT_ID", "GET_COMPLETED_PERMIT_NO") AS SELECT A.ID AS BUILDINGID, A.BUILD_NAME AS BUILDINGNAME,
       B.PROJECT_ORIGINAL_ID AS PROJID, B.PROJECT_NAME AS PROJNAME,
             (case when a.is_get_completed_permit=1 THEN '已竣备'
             ELSE (case when a.is_get_pre_sale_permit=1 THEN '已领预售证'
               ELSE (case when a.is_get_constrcution_permit=1 THEN '已领施工证'
                 ELSE (case when a.is_get_con_plan_permit=1 THEN '已领规证'
                   ELSE '未领规证' END )
                    END )  END ) END ) AS  Permit_Status,
       C.PERIOD_ORIGINAL_ID AS STAGESID, C.PERIOD_NAME AS STAGESNAME,
       D.ID AS COMPANYID, D.ORG_NAME AS COMPANYNAME,
       A.GET_CON_PLAN_PERMIT_DATE, A.CON_PLAN_PERMIT_ID,
       A.CON_PLAN_PERMIT_NO, A.GET_CONSTRCUTION_PERMIT_DATE,
       A.CONSTRACUTION_PERMIT_ID, A.CONSTRUCTION_PERMIT_NO,
       A.GET_PRE_SALE_PERMIT_DATE, A.PRE_SALE_PERMIT_ID,
       A.PRE_SALE_PERMIT_NO, A.GET_COMPLETED_PERMIT_DATE,
       A.COMPLETED_PERMIT_ID, A.GET_COMPLETED_PERMIT_NO

FROM   MDM_BUILD A
LEFT   JOIN MDM_PROJECT B
ON     A.PROJ_ID = B.PROJECT_ORIGINAL_ID
LEFT   JOIN MDM_PERIOD C
ON     A.PERIOD_ID = C.PERIOD_ORIGINAL_ID
LEFT   JOIN MDM_PERIOD_VERSION E
ON     C.PERIOD_VERSION_ID = E.ID
LEFT   JOIN SYS_BUSINESS_UNIT D
ON     B.COMPANY_ID = D.ID
WHERE  B.APPROVAL_STATUS = '已审核' AND
       B.PROJECT_VERSION IN
       (SELECT MAX(PROJECT_VERSION)
        FROM   MDM_PROJECT
        WHERE  APPROVAL_STATUS = '已审核'
        GROUP  BY PROJECT_ORIGINAL_ID) AND
       E.APPROVAL_STATUS = '已审核'
and a.BUILD_STATE='10'
ORDER BY a.ORDER_HIERARCHY_CODE

;
--------------------------------------------------------
--  DDL for View V_MDM_PROJECT_LIST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_PROJECT_LIST" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "CITYNAME", "PROJCODE", "LEVELRANK") AS select orgId,orgName,orgType,parentId,cityName,projCode,levelRank from
(select a.PERIOD_ORIGINAL_ID as orgId , a.PERIOD_NAME as orgName,'11' as orgType,d.PROJECT_ORIGINAL_ID as parentId,e.CITY_NAME as cityName,'' as projCode,'2' as levelRank
from MDM_PERIOD a left join MDM_PERIOD_VERSION d on a.PERIOD_VERSION_ID = d.ID
left join MDM_PROJECT e on e.PROJECT_ORIGINAL_ID = d.PROJECT_ORIGINAL_ID
where d.APPROVAL_STATUS = '已审核'
UNION
select b.PROJECT_ORIGINAL_ID as orgId, b.PROJECT_NAME as orgName,'10' as orgType,b.COMPANY_ID as parentId,b.CITY_NAME as cityName,b.PROJECT_CODE as projCode,'1' as levelRank
from MDM_PROJECT b  where APPROVAL_STATUS = '已审核' and PROJECT_VERSION in (
select max(PROJECT_VERSION) from MDM_PROJECT  where APPROVAL_STATUS = '已审核' group by PROJECT_ORIGINAL_ID
)
) t
;
--------------------------------------------------------
--  DDL for View V_MDM_PROJECT_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_PROJECT_TREE" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "CITYNAME", "PROJCODE") AS SELECT ORGID, ORGNAME, ORGTYPE, PARENTID, CITYNAME, PROJCODE
/*,order_Code
*/
FROM   (SELECT A.PERIOD_ORIGINAL_ID AS ORGID, A.PERIOD_NAME AS ORGNAME,
								'11' AS ORGTYPE, D.PROJECT_ORIGINAL_ID AS PARENTID,
								E.CITY_NAME AS CITYNAME, '' AS PROJCODE
				 /*,c.Parent_ID||'-'||substr('000'||c.order_code,-3)||'-'||e.project_code||'-'|| a.PERIOD_NAME AS ORDER_CODE --用于树形的排序
         */
				 FROM   MDM_PERIOD A
				 LEFT   JOIN MDM_PERIOD_VERSION D
				 ON     A.PERIOD_VERSION_ID = D.ID
				 LEFT   JOIN MDM_PROJECT E
				 ON     E.PROJECT_ORIGINAL_ID = D.PROJECT_ORIGINAL_ID
				 /*LEFT JOIN SYS_BUSINESS_UNIT c ON e.company_id=c.id
         */
				 WHERE  D.APPROVAL_STATUS = '已审核'

				 UNION
				 SELECT B.PROJECT_ORIGINAL_ID AS ORGID, B.PROJECT_NAME AS ORGNAME,
								'10' AS ORGTYPE, B.COMPANY_ID AS PARENTID,
								B.CITY_NAME AS CITYNAME, B.PROJECT_CODE AS PROJCODE
				 /*,c.Parent_ID||'-'||substr('000'||c.order_code,-3)||'-'||b.project_code AS ORDER_CODE --用于树形的排序
         */
				 FROM   MDM_PROJECT B
				 /*LEFT JOIN SYS_BUSINESS_UNIT c ON b.company_id=c.id
         */
				 WHERE  APPROVAL_STATUS = '已审核' AND
								PROJECT_VERSION IN
								(SELECT MAX(PROJECT_VERSION)
								 FROM   MDM_PROJECT
								 WHERE  APPROVAL_STATUS = '已审核'
								 GROUP  BY PROJECT_ORIGINAL_ID)

				 UNION
				 SELECT C.ID AS ORGID, C.ORG_NAME AS ORGNAME, '0' AS ORGTYPE,
								C.PARENT_ID AS PARENTID, '' AS CITYNAME, '' AS PROJCODE
				 /*,c.Parent_ID||'-'||substr('000'||c.order_code,-3) AS ORDER_CODE --用于树形的排序
         */
				 FROM   SYS_BUSINESS_UNIT C
				 WHERE  ORG_TYPE = 0 AND
								(ID != '000100000000000000000000000000' AND
								ID != '000200000000000000000000000000')) T
/*ORDER BY order_Code
*/

;
--------------------------------------------------------
--  DDL for View V_MDM_PROJECTS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_PROJECTS" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "CITYNAME", "PROJCODE") AS select orgId,orgName,orgType,parentId,cityName,projCode from
(select a.PERIOD_ORIGINAL_ID as orgId , a.PERIOD_NAME as orgName,'11' as orgType,d.PROJECT_ORIGINAL_ID as parentId,e.CITY_NAME as cityName,'' as projCode
from MDM_PERIOD a left join MDM_PERIOD_VERSION d on a.PERIOD_VERSION_ID = d.ID
left join MDM_PROJECT e on e.PROJECT_ORIGINAL_ID = d.PROJECT_ORIGINAL_ID
where d.APPROVAL_STATUS = '已审核'
UNION
select b.PROJECT_ORIGINAL_ID as orgId, b.PROJECT_NAME as orgName,'10' as orgType,b.COMPANY_ID as parentId,b.CITY_NAME as cityName,b.PROJECT_CODE as projCode
from MDM_PROJECT b  where APPROVAL_STATUS = '已审核' and PROJECT_VERSION in (
select max(PROJECT_VERSION) from MDM_PROJECT  where APPROVAL_STATUS = '已审核' group by PROJECT_ORIGINAL_ID
)
UNION
select c.ID as orgId,c.ORG_NAME as orgName,'0' as orgType,c.PARENT_ID as parentId,'' as cityName,'' as projCode
from SYS_BUSINESS_UNIT c where ORG_TYPE = 0 and (ID != '000100000000000000000000000000' and ID != '000200000000000000000000000000')
) t
where orgTYpe in ('10','11')
;
--------------------------------------------------------
--  DDL for View V_MDM_ROOM
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_ROOM" ("BUILDING_ID", "ORDER_HIERARCHY_CODE", "PROJECT_NAME", "ALL库存货值_房间合计", "ALL已售货值_房间合计", "ALL库存面积_房间合计", "ALL已售面积_房间合计", "ALL库存套数_房间合计", "ALL已售套数_房间合计", "ZZ库存货值_房间合计", "ZZ已售货值_房间合计", "ZZ库存面积_房间合计", "ZZ已售面积_房间合计", "SY库存货值_房间合计", "SY已售货值_房间合计", "SY库存面积_房间合计", "SY已售面积_房间合计", "CW库存货值_房间合计", "CW已售货值_房间合计", "CW库存面积_房间合计", "CW已售面积_房间合计", "CW库存套数_房间合计", "CW已售套数_房间合计") AS SELECT b.building_id
       ,a.order_hierarchy_code
      ,b.project_name
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约' THEN ROUND(b.bz_price*b.pre_bld_area,2) ELSE 0 END),0)) AS ALL库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN b.trade_total ELSE 0 END),0)) AS ALL已售货值_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS ALL库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS ALL已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'THEN (CASE WHEN b.bz_total_area_type='预售' THEN 1 ELSE 0 END) ELSE 0 END),0)) AS ALL库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' THEN (CASE WHEN b.bz_total_area_type='预售' THEN 1 ELSE 0 END) ELSE 0 END),0)) AS ALL已售套数_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='住宅' THEN ROUND(b.bz_price*b.pre_bld_area,2) ELSE 0 END),0)) AS ZZ库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='住宅' THEN b.trade_total ELSE 0 END),0)) AS ZZ已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='住宅' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS ZZ库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='住宅' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS ZZ已售面积_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='商办' THEN ROUND(b.bz_price*b.pre_bld_area,2) ELSE 0 END),0)) AS SY库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='商办' THEN b.trade_total ELSE 0 END),0)) AS SY已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='商办' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS SY库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='商办' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS SY已售面积_房间合计

      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN ROUND(b.bz_price*b.pre_bld_area,2) ELSE 0 END),0)) AS CW库存货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN b.trade_total ELSE 0 END),0)) AS CW已售货值_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS CW库存面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS CW已售面积_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state<>'签约'AND b.product_name='车位' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS CW库存套数_房间合计
      ,SUM(NVL((CASE WHEN b.sale_state='签约' AND b.product_name='车位' THEN (CASE WHEN b.bz_total_area_type='预售' THEN  b.pre_bld_area ELSE b.actual_bld_area END) ELSE 0 END),0)) AS CW已售套数_房间合计

FROM Mdm_Room b LEFT JOIN mdm_build a ON a.id=b.building_id
GROUP BY b.project_name,b.building_id ,a.order_hierarchy_code
ORDER BY a.order_hierarchy_code

;
--------------------------------------------------------
--  DDL for View V_MDM_STAGE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_MDM_STAGE" ("STAGESID", "STAGESNAME", "PROJID", "PROJNAME", "PROJCODE", "COMPANYID", "COMPANYNAME") AS SELECT A.PERIOD_ORIGINAL_ID AS STAGESID, A.PERIOD_NAME AS STAGESNAME,
			 B.PROJECT_ORIGINAL_ID AS PROJID, B.PROJECT_NAME AS PROJNAME,
			 B.PROJECT_CODE AS PROJCODE, C.ID AS COMPANYID,
			 C.ORG_NAME AS COMPANYNAME
FROM   MDM_PERIOD A
LEFT   JOIN MDM_PERIOD_VERSION D
ON     A.PERIOD_VERSION_ID = D.ID
LEFT   JOIN MDM_PROJECT B
ON     D.PROJECT_ORIGINAL_ID = B.PROJECT_ORIGINAL_ID
LEFT   JOIN SYS_BUSINESS_UNIT C
ON     B.COMPANY_ID = C.ID
WHERE  D.APPROVAL_STATUS = '已审核'

;
--------------------------------------------------------
--  DDL for View V_NODES_LIST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_NODES_LIST" ("NODEID", "NODENAME", "PROJECTNAME", "SQLLEVEL", "STATUS", "PLANID", "PLANTYPE", "PLANENDDATE", "ESTIMATEENDDATE", "ACTUALENDDATE", "CHARGEPERSONID", "ORIGINALNODEID") AS SELECT
	b.id as nodeId ,
	b.NODE_NAME as nodeName,
	c.PROJ_NAME as projectName,
    case when  b.NODE_LEVEL='里程碑'or b.NODE_LEVEL='一级节点' or b.NODE_LEVEL='二级节点' or b.NODE_LEVEL='三级节点' then b.NODE_LEVEL else '其他' end  as sqlLevel,
    case when B.ACTUAL_END_DATE is not null then '已完成'
        when B.PLAN_END_DATE < Trunc(sysdate)   then '已超期' else '未完成' end as  status ,
	b.PROJ_PLAN_ID as planId,
	c.plan_type as planType,
	b.PLAN_END_DATE as planEndDate,
	b.ESTIMATE_END_DATE as estimateEndDate,
	b.ACTUAL_END_DATE as actualEndDate,
	a.charge_person_id as chargePersonId,
	b.ORIGINAL_NODE_ID as originalNodeId
FROM
	POM_NODE_CHARGE_PERSON a
	left join POM_PROJ_PLAN_NODE b ON a.node_id = b.id
	left join POM_PROJ_PLAN c ON b.PROJ_PLAN_ID = c.ID
WHERE
	 c.plan_type in ('关键节点计划', '项目主项计划')
	and b.is_delete = 0 and b.is_disable = 0 and c.APPROVAL_STATUS = '已审核'
	UNION ALL
SELECT
	 b.id as nodeId,
	 b.NODE_NAME as nodeName,
	 c.PLAN_NAME as projectName,
	 '其他' as sqlLevel,
        case when B.ACTUAL_END_DATE is not null then '已完成'
        when B.PLAN_END_DATE < Trunc(sysdate)   then '已超期' else '未完成' end as  status ,
	 b.plan_id as planId,
	 '专项计划' as planType,
	 b.PLAN_END_DATE as planEndDate,
	 b.PREDICT_END_DATE as estimateEndDate,
	 b.ACTUAL_END_DATE as actualEndDate,
	 a.charge_person_id as chargePersonId,
	 b.ORIGINAL_NODE_ID as originalNodeId
	 FROM
	 POM_NODE_CHARGE_PERSON a
	 left join POM_SPECIAL_PLAN_NODE b on a.node_id = b.id
	 left join POM_SPECIAL_PLAN c on b.plan_id = c.id
	 WHERE
	  b.is_delete = 0 and c.APPROVAL_STATUS = '已审核'
	 UNION ALL
SELECT
	b.id as nodeId,
	b.NODE_NAME as nodeName,
	c.PLAN_NAME as projectName,
	'其他' as sqlLevel,
        case when B.ACTUAL_END_DATE is not null then '已完成'
        when B.PLAN_END_DATE < Trunc(sysdate)   then '已超期' else '未完成' end as  status ,
	b.DEPT_MONTHLY_PLAN_ID as planId,
	'部门月度计划' as planType,
	b.PLAN_END_DATE as planEndDate,
	b.ESTIMATE_END_DATE as estimateEndDate,
	b.ACTUAL_END_DATE as actualEndDate,
	a.charge_person_id as chargePersonId,
	b.ORIGINAL_NODE_ID as originalNodeId
	FROM
	 POM_NODE_CHARGE_PERSON a
  left join POM_DEPT_MONTHLY_PLAN_NODE b on a.node_id = b.id
  left join POM_DEPT_MONTHLY_PLAN c on c.id = b.DEPT_MONTHLY_PLAN_ID
	where  c.APPROVE_STATUS = '已审核'
;
--------------------------------------------------------
--  DDL for View V_POM_GET_NODE_EXAMINE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_GET_NODE_EXAMINE" ("ID", "PROJ_PLAN_ID", "ORIGINAL_NODE_ID", "TEMPLATE_NODE_ID", "STANDARD_NODE_ID", "NODE_GRADE", "NODE_NAME", "NODE_CODE", "NODE_LEVEL", "PROJ_STAGE", "MAIN_RESPONSIBILITY", "CONTROL_TYPE", "DUTY_DEPARTMENT_ID", "DUTY_DEPARTMENT", "PLAN_START_DATE", "PLAN_END_DATE", "IS_DISABLE", "DISABLE_TIME", "DISABLE_REASON_ID", "STANDARD_SCORE", "REFERENCE_DATE_NODE_ID", "REFERENCE_DAY", "PRECONDITION_REMARK", "IS_CONTAINS_PERMIT", "PERMIT_TYPE", "COMPLETION_STANDARD", "COMPLETION_RESULTS_REMARK", "INPUT_CONDITION", "OTHER_REMARK", "CREATED", "CREATOR_ID", "CREATOR", "MODIFIED", "MODIFIER_ID", "MODIFIER", "PLAN_VERSION", "IS_DELETE", "DISABLE_REASON", "ACTUAL_END_DATE", "ACTUAL_START_DATE", "ESTIMATE_START_DATE", "ESTIMATE_END_DATE", "ORIGINAL_PLAN_ID", "FEEDBACK_ID", "COMPANY_NAME", "COMPANY_ID", "FISSION_SOURCE_ORIGINAL_ID") AS select node."ID",node."PROJ_PLAN_ID",node."ORIGINAL_NODE_ID",node."TEMPLATE_NODE_ID",node."STANDARD_NODE_ID",node."NODE_GRADE",node."NODE_NAME",node."NODE_CODE",node."NODE_LEVEL",node."PROJ_STAGE",node."MAIN_RESPONSIBILITY",node."CONTROL_TYPE",node."DUTY_DEPARTMENT_ID",node."DUTY_DEPARTMENT",node."PLAN_START_DATE",node."PLAN_END_DATE",node."IS_DISABLE",node."DISABLE_TIME",node."DISABLE_REASON_ID",node."STANDARD_SCORE",node."REFERENCE_DATE_NODE_ID",node."REFERENCE_DAY",node."PRECONDITION_REMARK",node."IS_CONTAINS_PERMIT",node."PERMIT_TYPE",node."COMPLETION_STANDARD",node."COMPLETION_RESULTS_REMARK",node."INPUT_CONDITION",node."OTHER_REMARK",node."CREATED",node."CREATOR_ID",node."CREATOR",node."MODIFIED",node."MODIFIER_ID",node."MODIFIER",node."PLAN_VERSION",node."IS_DELETE",node."DISABLE_REASON",node."ACTUAL_END_DATE",node."ACTUAL_START_DATE",node."ESTIMATE_START_DATE",node."ESTIMATE_END_DATE",node."ORIGINAL_PLAN_ID",node."FEEDBACK_ID",node."COMPANY_NAME",node."COMPANY_ID",node."FISSION_SOURCE_ORIGINAL_ID" from pom_proj_plan plan inner join pom_proj_plan_node node on plan.id=node.proj_plan_id  
    where  plan.approval_status = '已审核'
    AND ( plan.plan_type = '项目主项计划' OR plan.plan_type = '关键节点计划' )
    AND case when (0 in (select FN_BIZPARAM_CONFIG('pom_fission_node_is_examined') as is_examined from dual) ) then 
     node.fission_source_original_id 
    else null  end is null
;
--------------------------------------------------------
--  DDL for View V_POM_GETEXAMINE_MOTH
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_GETEXAMINE_MOTH" ("铁建_本年", "铁建_本季度", "铁建_本月", "铁建_当天") AS SELECT
	TO_CHAR(
	CASE
			WHEN TO_CHAR( SYSDATE, 'DD' ) > 25 
			AND TO_NUMBER( TO_CHAR( SYSDATE, 'MM' ) ) + 1 > 12 THEN
				TO_CHAR( SYSDATE, 'YYYY' ) + 1 ELSE TO_NUMBER( TO_CHAR( SYSDATE, 'YYYY' ) ) 
			END 
			) AS "铁建_本年",
	   TO_CHAR(case when   TO_NUMBER(TO_CHAR(SYSDATE,'mm'))=12 and  TO_NUMBER(TO_CHAR(SYSDATE,'dd')) >25 then 1 else     TO_NUMBER(TO_CHAR(SYSDATE,'Q'))  end) AS "铁建_本季度",
		CASE
			WHEN
			CASE
					WHEN TO_CHAR( SYSDATE, 'DD' ) > 25 THEN
					TO_NUMBER( TO_CHAR( SYSDATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( SYSDATE, 'MM' ) ) 
				END > 12 THEN
	1 ELSE
CASE
		WHEN TO_CHAR( SYSDATE, 'DD' ) > 25 THEN
		TO_NUMBER( TO_CHAR( SYSDATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( SYSDATE, 'MM' ) ) 
	END 
	END AS "铁建_本月" 
,TO_CHAR( SYSDATE, 'DD' ) AS  "铁建_当天"

FROM
	dual
;
--------------------------------------------------------
--  DDL for View V_POM_GETEXAMINE_QUARTER
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_GETEXAMINE_QUARTER" ("开始年度", "结束年度", "开始月份", "结束月份") AS SELECT
CASE
		
	WHEN
		    A.铁建_本季度  = 1  THEN
	  	TO_CHAR(TO_NUMBER(TO_CHAR( SYSDATE, 'YYYY' )-1))

			WHEN A.铁建_本季度 = 2 THEN
			TO_CHAR( SYSDATE, 'YYYY' ) 
			WHEN A.铁建_本季度 = 3 THEN
			TO_CHAR( SYSDATE, 'YYYY' ) 
			WHEN A.铁建_本季度 = 4 THEN
			TO_CHAR( SYSDATE, 'YYYY' ) ELSE NULL 
		END AS 开始年度 
		,TO_CHAR(
CASE
		
	WHEN  TO_NUMBER(TO_CHAR(SYSDATE,'mm'))=12 AND  TO_NUMBER(TO_CHAR(SYSDATE,'DD'))>25 THEN   TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))+1
 ELSE   TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
		END) AS 结束年度  
		,
	CASE
			
			WHEN A.铁建_本季度 = 4 THEN
			'09' 
			WHEN A.铁建_本季度 = 3 THEN
			'06' 
			WHEN A.铁建_本季度 = 2 THEN
			'03' 
			WHEN A.铁建_本季度 = 1 THEN
			'12' ELSE NULL 
		END AS 开始月份 
		,
	CASE
			
			WHEN A.铁建_本季度 = 4 THEN
			'12' 
			WHEN A.铁建_本季度 = 3 THEN
			'09' 
			WHEN A.铁建_本季度 = 2 THEN
			'06' 
			WHEN A.铁建_本季度 = 1 THEN
			'03' ELSE NULL 
		END AS 结束月份 
FROM
	V_POM_GETEXAMINE_MOTH A
;
--------------------------------------------------------
--  DDL for View V_POM_KEY_NODE_Q_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_KEY_NODE_Q_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='关键节点计划' 
  AND A1. IS_DISABLE=0
AND  A.APPROVAL_STATUS='已审核'
 --判断季度
 AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD') BETWEEN
 (	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD')
 BETWEEN
(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID ,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD')
 BETWEEN
(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划' 
   AND A1. IS_DISABLE=0
    AND  A.APPROVAL_STATUS='已审核'
   AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD') BETWEEN (	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_KEY_NODE_Y_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_KEY_NODE_Y_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='关键节点计划'
  AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
	 --判断本年
 -- A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
	 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'  
   AND A1. IS_DISABLE=0
   AND  A.APPROVAL_STATUS='已审核'
	 --判断本年

 AND A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_KEYNODE_M_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_KEYNODE_M_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS "COMPANY_ID"
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS "CTYPE"
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


  FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划' AND  A.APPROVAL_STATUS='已审核'
   AND A1. IS_DISABLE=0
 --判断本月
 AND A1.PLAN_END_DATE  BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总//无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4 as  lw
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID
 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核'
   AND A1. IS_DISABLE=0
   AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME LIKE '%无分期%'


UNION ALL
--顶级项目汇总//有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE,
 '' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
	where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME NOT   LIKE '%无分期%'
		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划' 
   AND A1. IS_DISABLE=0
    AND  A.APPROVAL_STATUS='已审核'
   AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'--C1.PROJECT_ID
		GROUP BY  C1.PROJECT_ID,A.COMPANY_ID,C1.ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_MAIN_PLAN_M_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_MAIN_PLAN_M_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS "COMPANY_ID"
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


  FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
  AND  A.APPROVAL_STATUS='已审核'
 --判断本月
 AND A1.PLAN_END_DATE  BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总//无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4 as  lw
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.id) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME LIKE '%无分期%'
UNION ALL
--顶级项目汇总//有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
	where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME NOT   LIKE '%无分期%'
		----分期汇总

UNION ALL

SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划' 
   AND A1. IS_DISABLE=0
    AND  A.APPROVAL_STATUS='已审核'
   AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'--C1.PROJECT_ID
		GROUP BY  C1.PROJECT_ID,A.COMPANY_ID,C1.ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_MAIN_PLAN_Q_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_MAIN_PLAN_Q_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='项目主项计划' 
  AND A1. IS_DISABLE=0
AND  A.APPROVAL_STATUS='已审核'
 --判断季度
 AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD') BETWEEN
 (	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD')
 BETWEEN
(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID ,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.id) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'  AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD')
 BETWEEN
(	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划' 
   AND A1. IS_DISABLE=0
    AND  A.APPROVAL_STATUS='已审核'
   AND TO_CHAR(A1.PLAN_END_DATE,'YYYY-MM-DD') BETWEEN (	SELECT A.开始年度||'-'||A.开始月份||'-26'   FROM V_POM_GETEXAMINE_QUARTER A)  AND
 (	SELECT A.结束年度||'-'||A.结束月份||'-25' FROM V_POM_GETEXAMINE_QUARTER A)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_MAIN_PLAN_Y_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_MAIN_PLAN_Y_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='项目主项计划'
  AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
	 --判断本年
 -- A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.id) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'
   AND A1. IS_DISABLE=0
 AND  A.APPROVAL_STATUS='已审核'
	 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='项目主项计划'  
   AND A1. IS_DISABLE=0
   AND  A.APPROVAL_STATUS='已审核'
	 --判断本年

 AND A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_MONTH_QUARTER_YEAR
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_MONTH_QUARTER_YEAR" ("M_END", "QUARTER_END", "YEAR_END", "M_BEGIN", "QUARTER_BEGIN", "YEAR_BEGIN") AS with examination_day as (SELECT
         fn_pom_examination_day() - 1 as examination_day    FROM        dual)
 --当前--月考核结束日期
,now_m_end as (SELECT  trunc(SYSDATE, 'month') + examination_day- numtodsinterval(1/1000,'second') as d FROM examination_day) 
 --当前--月考核结束日期
,now_quarter_end as (SELECT  add_months(trunc(SYSDATE, 'Q'), 2) + examination_day- numtodsinterval(1/1000,'second')  as d   FROM  examination_day)       
 --当前--月考核结束日期
,now_year_end as (SELECT add_months(trunc(SYSDATE, 'yyyy'), 11) + examination_day- numtodsinterval(1/1000,'second')  as d   FROM  examination_day)
 --下一个--月考核结束日期
,next_m_end as (select add_months(d,1) as nd from now_m_end )
 --下一个--季考核结束日期
,next_quarter_end as (SELECT add_months(d, 3)  as nd  FROM  now_quarter_end)
 --下一个--年考核结束日期
,next_year_end as (SELECT add_months(d, 12)  as nd  FROM   now_year_end)

---合并将结束时间合并到一起
,o_all_end as (select m.d as md,nm.nd as nmd
,q.d as qd,nq.nd as nqd
,y.d as yd ,ny.nd  as nyd
from 
(select * from now_m_end) m
 cross join
(select * from next_m_end ) nm
 cross join
(select * from now_quarter_end ) q
 cross join
(select * from next_quarter_end ) nq
 cross join
(select * from now_year_end ) y
 cross join
(select * from next_year_end ) ny
)
,计算结束时间 as (select 
case when SYSDATE < md then md else  nmd end as m_end
,case when SYSDATE < qd then qd else  nqd end as quarter_end
,case when SYSDATE < yd then yd else  nyd end as year_end
from o_all_end)
,年季月 as (
select 计算结束时间.*
,add_months(m_end, -1) as m_begin
,add_months(quarter_end, -3) as quarter_begin
,add_months(year_end, -12) as year_begin from 计算结束时间)

select "M_END","QUARTER_END","YEAR_END","M_BEGIN","QUARTER_BEGIN","YEAR_BEGIN" from 年季月
;
--------------------------------------------------------
--  DDL for View V_POM_MONTH_QUARTER_YEARS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_MONTH_QUARTER_YEARS" ("YYYY", "MM", "Q", "M_BEGIN", "M_END", "QUARTER_BEGIN", "QUARTER_END", "YEAR_BEGIN", "YEAR_END") AS with examination_day as (SELECT
         fn_pom_examination_day()-1 as e_day
         ,TO_DATE(''||to_char(SYSDATE, 'yyyy' )||'-'||to_char(SYSDATE, 'MM' )||'-01','YYYY-MM-DD')  as cmday  
         FROM dual)
 --当前--月考核结束日期
,base as (
SELECT  trunc(cmday, 'month') + e_day as m_end
,add_months(trunc(cmday, 'Q'), 3) + e_day as quarter_end
,add_months(trunc(cmday, 'yyyy'), 12) + e_day as year_end
,cmday
FROM examination_day) 

,年季月 as (
select base.*
,add_months(m_end, -1) as m_begin
,add_months(quarter_end, -3) as quarter_begin
,add_months(year_end, -12) as year_begin
,to_char(add_months(m_end, -1), 'MM' ) as base_mm
,to_char(add_months(m_end, -1), 'yyyy' ) as base_yyyy
from base)

,mms as(SELECT column_value+0 mm   FROM TABLE ( split('1,2,3,4,5,6,7,8,9,10,11,12') ))

,近5年季月 as(
select  年季月.*,mms.*,yyyys.*,e_day
,months_between(TO_DATE(''||yyyy||'-'||mm||'-01','yyyy-mm-dd'),TO_DATE(''||base_yyyy||'-'||base_mm||'-01','yyyy-mm-dd')) as 月份差 
from 年季月
cross join  
(select to_char(SYSDATE, 'yyyy')-1 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-2 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-3 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-4 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-0 as yyyy from dual) yyyys
cross join  mms
cross join examination_day
)

select 
--近5年季月.cmday,
yyyy,mm,to_char(add_months(add_months(m_end, 月份差), -1), 'Q' ) as Q
,add_months(m_begin, 月份差)-numtodsinterval(1/1000, 'SECOND') as m_begin
,add_months(m_end, 月份差)-numtodsinterval(1/1000, 'SECOND') as m_end
,trunc(add_months(m_begin, 月份差), 'Q')+e_day-numtodsinterval(1/1000, 'SECOND') as quarter_begin
,add_months(trunc(add_months(m_begin, 月份差), 'Q'), 3)+e_day-numtodsinterval(1/1000, 'SECOND') as quarter_end

,trunc(add_months(m_begin, 月份差), 'yyyy')+e_day-numtodsinterval(1/1000, 'SECOND') as year_begin
,add_months(trunc(add_months(m_begin, 月份差), 'yyyy'), 12)+e_day-numtodsinterval(1/1000, 'SECOND') as year_end
 from 近5年季月 order by yyyy,mm
;
--------------------------------------------------------
--  DDL for View V_POM_NODE_DT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_NODE_DT" ("ROWCODE", "PLAN_TYPE", "PLAN_NAME", "PROJ_NAME", "NODE_CODE", "NODE_NAME", "PLAN_START_DATE", "PLAN_END_DATE", "FINISH_STATUS", "FINISH_NO_STATUS_TYPE", "FINISH_YES_STATUS_TYPE", "ACTUAL_START_DATE", "ACTUAL_END_DATE", "ESTIMATE_STATUS", "ESTIMATE_START_DATE", "ESTIMATE_END_DATE", "ID", "PROJ_PLAN_ID", "TEMPLATE_NODE_ID", "STANDARD_NODE_ID", "NODE_GRADE", "NODE_LEVEL", "PROJ_STAGE", "MAIN_RESPONSIBILITY", "CONTROL_TYPE", "DUTY_DEPARTMENT_ID", "DUTY_DEPARTMENT", "IS_DISABLE", "DISABLE_TIME", "DISABLE_REASON_ID", "STANDARD_SCORE", "REFERENCE_DATE_NODE_ID", "REFERENCE_DAY", "PRECONDITION_REMARK", "IS_CONTAINS_PERMIT", "PERMIT_TYPE", "COMPLETION_STANDARD", "COMPLETION_RESULTS_REMARK", "INPUT_CONDITION", "OTHER_REMARK", "CREATED", "CREATOR_ID", "CREATOR", "MODIFIED", "MODIFIER_ID", "MODIFIER", "PLAN_VERSION", "IS_DELETE", "DISABLE_REASON", "FEEDBACK_ID", "COMPANY_NAME", "COMPANY_ID", "ORIGINAL_NODE_ID") AS SELECT
-- 黄伟2020-01-09创建：展示“已审核的计划”的所有未禁用节点的动态情况；涉及到节点的统计、当前状态、预警等都应尽可能从这里取数。
  row_number() OVER(ORDER BY b.Plan_Type,c.order_hierarchy_code,b.proj_name,a.node_code) AS RowCode
  ,b.plan_type AS PlAN_Type -- 计划类别
  ,b.plan_name AS Plan_Name -- 计划名称
  ,b.proj_name AS Proj_Name -- 所属项目
  ,a.node_code AS Node_Code -- 节点编号
  ,a.node_name AS Node_Name -- 节点名称
  ,a.plan_start_date AS plan_start_date -- 计划开始日期
  ,a.plan_end_date AS plan_end_date -- 计划完成日期
  ,(CASE WHEN a.actual_end_date IS NOT NULL THEN '已完成' ELSE '未完成' END) AS Finish_Status -- 节点完成状态
  ,(CASE WHEN a.actual_end_date IS NOT NULL THEN ''
         WHEN a.actual_end_date IS NULL AND TRUNC(SYSDATE)-TRUNC(a.plan_end_date)>0 THEN '超期未完成'
         WHEN a.actual_end_date IS NULL AND TRUNC(SYSDATE)-TRUNC(a.plan_end_date)=0 THEN '今天到期'
         ELSE '未到期' END) AS Finish_NO_Status_Type -- 未完成细分类别
  ,(CASE WHEN a.actual_end_date IS NULL THEN ''
         WHEN a.actual_end_date IS NOT NULL AND TRUNC(actual_end_date)-TRUNC(a.plan_end_date)>0 THEN '超期完成'
         WHEN a.actual_end_date IS NOT NULL AND TRUNC(actual_end_date)-TRUNC(a.plan_end_date)=0 THEN '按时完成'
         WHEN a.actual_end_date IS NOT NULL AND TRUNC(actual_end_date)-TRUNC(a.plan_end_date)<0 THEN '提前完成'
         ELSE '未知' END) AS Finish_YES_Status_Type -- 已完成细分类别
  ,a.actual_start_date -- 实际开始日期
  ,a.actual_end_date -- 实际完成日期
  ,(CASE WHEN a.actual_end_date IS NOT NULL THEN ''
         WHEN a.actual_end_date IS NULL AND TRUNC(a.estimate_end_date)-TRUNC(a.plan_end_date)>0 THEN '预计超期'
         WHEN a.actual_end_date IS NULL AND TRUNC(a.estimate_end_date)-TRUNC(a.plan_end_date)=0 THEN '预计按时'
         WHEN a.actual_end_date IS NULL AND TRUNC(a.estimate_end_date)-TRUNC(a.plan_end_date)=0 THEN '预计提前'
         ELSE '无预测' END) AS Estimate_Status -- 预测状态
  ,a.estimate_start_date, -- 预计开始日期
   a.estimate_end_date, -- 预计完成日期

  a.id,-- 节点ID
   a.proj_plan_id, -- 计划ID
   a.template_node_id, -- 使用模板节点ID
   a.standard_node_id, -- 标准节点ID
   a.node_grade, -- 节点等级(集团级、区域级）
   a.node_level, -- 任务级别（里程碑、一级节点、二级节点、三级节点）
   a.proj_stage, -- 项目阶段
   a.main_responsibility, -- 主责职能
   a.control_type, -- 控制类型
   a.duty_department_id, -- 主责部门ID
   a.duty_department, -- 主责部门
   a.is_disable, -- 是否禁用
   a.disable_time, -- 禁用时间
   a.disable_reason_id, -- 禁用原因ID
   a.standard_score, -- 标准分值
   a.reference_date_node_id, --
   a.reference_day, -- 参考天数
   a.precondition_remark, -- 前置条件说明
   a.is_contains_permit, -- 是否证照节点
   a.permit_type, -- 证照类型
   a.completion_standard, -- 完成标准说明
   a.completion_results_remark, -- 完成成果说明
   a.input_condition, -- 输入条件
   a.other_remark, --  其他备注说明
   a.created, -- 创建时间
   a.creator_id, -- 创建人ID
   a.creator, -- 创建人
   a.modified, -- 修改时间
   a.modifier_id, -- 修改改人ID
   a.modifier, -- 修改人
   a.plan_version, -- 计划版本
   a.is_delete, -- 是否删除
   a.disable_reason, -- 禁用原因
   a.feedback_id, -- 反馈ID
   a.company_name, -- 公司名称
   a.company_id, -- 公司ID
	 a.ORIGINAL_NODE_ID --节点原始ID
FROM pom_proj_plan_node a
LEFT JOIN pom_proj_plan b ON a.proj_plan_id=b.id AND b.approval_status IN ('已审核')
LEFT JOIN Sys_Project c ON b.proj_id=c.id
WHERE b.id IS NOT NULL
--AND b.id='1dccd70b-b294-4424-acca-ca4ea49e1a33'
--AND b.plan_type='关键节点计划'
AND a.is_disable=0
-- ORDER BY b.proj_name,a.node_code

;
--------------------------------------------------------
--  DDL for View V_POM_PJMAINPLANRANK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJMAINPLANRANK" ("RANK", "ID", "PARENT_ID", "ORG_NAME", "本年应完成", "本年已完成", "本季度应完成", "本季度已完成", "本月应完成", "本月已完成", "本月动态得分", "本季度动态得分", "本月里程碑应完成", "本月里程碑已完成", "本月一级节点应完成", "本月一级节点已完成", "本季度里程碑应完成", "本季度里程碑已完成", "本季度一级节点应完成", "本季度一级节点已完成", "本月里程碑绿灯", "本月里程碑黄灯", "本月里程碑红灯", "本月一级节点绿灯", "本月一级节点黄灯", "本月一级节点红灯", "本月二三级节点绿灯", "本月二三级节点黄灯", "本月二三级节点红灯", "本季度里程碑绿灯", "本季度里程碑黄灯", "本季度里程碑红灯", "本季度一级节点绿灯", "本季度一级节点黄灯", "本季度一级节点红灯", "本季度二三级节点绿灯", "本季度二三级节点黄灯", "本季度二三级节点红灯", "CTYPE") AS SELECT ROW_NUMBER() OVER(PARTITION BY A.PARENT_ID ORDER BY ROUND(CASE
					 WHEN NVL(B.本年应完成,
										0) > 0 THEN
						NVL(本年已完成,
								0) /
						NVL(B.本年应完成,
								0)
					 ELSE
						0
			 END * 100, 2) DESC) AS RANK, A.ID, A.PARENT_ID, A.ORG_NAME,
			 NVL(B.本年应完成, 0) AS 本年应完成, NVL(B.本年已完成, 0) AS 本年已完成,
			 NVL(B.本季度应完成, 0) AS 本季度应完成, NVL(B.本季度已完成, 0) AS 本季度已完成,
			 NVL(B.本月应完成, 0) AS 本月应完成, NVL(B.本月已完成, 0) AS 本月已完成
			 /*动态得分情况*/, NVL(B.本月动态得分, 0) AS 本月动态得分, NVL(B.本季度动态得分, 0) AS 本季度动态得分
			 /*里程碑、一级节点完成情况*/, NVL(B.本月里程碑应完成, 0) AS 本月里程碑应完成,
			 NVL(B.本月里程碑已完成, 0) AS 本月里程碑已完成, NVL(B.本月一级节点应完成, 0) AS 本月一级节点应完成,
			 NVL(B.本月一级节点已完成, 0) AS 本月一级节点已完成, NVL(B.本季度里程碑应完成, 0) AS 本季度里程碑应完成,
			 NVL(B.本季度里程碑已完成, 0) AS 本季度里程碑已完成, NVL(B.本季度一级节点应完成, 0) AS 本季度一级节点应完成,
			 NVL(B.本季度一级节点已完成, 0) AS 本季度一级节点已完成
			 /*亮点情况*/, NVL(B.本月里程碑绿灯, 0) AS 本月里程碑绿灯, NVL(B.本月里程碑黄灯, 0) AS 本月里程碑黄灯,
			 NVL(B.本月里程碑红灯, 0) AS 本月里程碑红灯, NVL(B.本月一级节点绿灯, 0) AS 本月一级节点绿灯,
			 NVL(B.本月一级节点黄灯, 0) AS 本月一级节点黄灯, NVL(B.本月一级节点红灯, 0) AS 本月一级节点红灯,
			 NVL(B.本月二三级节点绿灯, 0) AS 本月二三级节点绿灯, NVL(B.本月二三级节点黄灯, 0) AS 本月二三级节点黄灯,
			 NVL(B.本月二三级节点红灯, 0) AS 本月二三级节点红灯, NVL(B.本季度里程碑绿灯, 0) AS 本季度里程碑绿灯,
			 NVL(B.本季度里程碑黄灯, 0) AS 本季度里程碑黄灯, NVL(B.本季度里程碑红灯, 0) AS 本季度里程碑红灯,
			 NVL(B.本季度一级节点绿灯, 0) AS 本季度一级节点绿灯, NVL(B.本季度一级节点黄灯, 0) AS 本季度一级节点黄灯,
			 NVL(B.本季度一级节点红灯, 0) AS 本季度一级节点红灯, NVL(B.本季度二三级节点绿灯, 0) AS 本季度二三级节点绿灯,
			 NVL(B.本季度二三级节点黄灯, 0) AS 本季度二三级节点黄灯,
			 NVL(B.本季度二三级节点红灯, 0) AS 本季度二三级节点红灯

			, 'TYPE_ORG' AS CTYPE
FROM   SYS_BUSINESS_UNIT A
LEFT   JOIN (SELECT AB.ID, AB.PARENT_ID, SUM(AB.本年应完成) AS 本年应完成,
										SUM(AB.本年已完成) AS 本年已完成, SUM(AB.本季度应完成) AS 本季度应完成,
										SUM(AB.本季度已完成) AS 本季度已完成, SUM(AB.本月应完成) AS 本月应完成,
										SUM(AB.本月已完成) AS 本月已完成
										/*动态得分情况*/, SUM(AB.本月动态得分) AS 本月动态得分,
										SUM(AB.本季度动态得分) AS 本季度动态得分
										/*里程碑、一级节点完成情况*/, SUM(AB.本月里程碑应完成) AS 本月里程碑应完成,
										SUM(AB.本月里程碑已完成) AS 本月里程碑已完成,
										SUM(AB.本月一级节点应完成) AS 本月一级节点应完成,
										SUM(AB.本月一级节点已完成) AS 本月一级节点已完成,
										SUM(AB.本季度里程碑应完成) AS 本季度里程碑应完成,
										SUM(AB.本季度里程碑已完成) AS 本季度里程碑已完成,
										SUM(AB.本季度一级节点应完成) AS 本季度一级节点应完成,
										SUM(AB.本季度一级节点已完成) AS 本季度一级节点已完成
										/*亮点情况*/, SUM(AB.本月里程碑绿灯) AS 本月里程碑绿灯,
										SUM(AB.本月里程碑黄灯) AS 本月里程碑黄灯, SUM(AB.本月里程碑红灯) AS 本月里程碑红灯,
										SUM(AB.本月一级节点绿灯) AS 本月一级节点绿灯,
										SUM(AB.本月一级节点黄灯) AS 本月一级节点黄灯,
										SUM(AB.本月一级节点红灯) AS 本月一级节点红灯,
										SUM(AB.本月二三级节点绿灯) AS 本月二三级节点绿灯,
										SUM(AB.本月二三级节点黄灯) AS 本月二三级节点黄灯,
										SUM(AB.本月二三级节点红灯) AS 本月二三级节点红灯,
										SUM(AB.本季度里程碑绿灯) AS 本季度里程碑绿灯,
										SUM(AB.本季度里程碑黄灯) AS 本季度里程碑黄灯,
										SUM(AB.本季度里程碑红灯) AS 本季度里程碑红灯,
										SUM(AB.本季度一级节点绿灯) AS 本季度一级节点绿灯,
										SUM(AB.本季度一级节点黄灯) AS 本季度一级节点黄灯,
										SUM(AB.本季度一级节点红灯) AS 本季度一级节点红灯,
										SUM(AB.本季度二三级节点绿灯) AS 本季度二三级节点绿灯,
										SUM(AB.本季度二三级节点黄灯) AS 本季度二三级节点黄灯,
										SUM(AB.本季度二三级节点红灯) AS 本季度二三级节点红灯
						 FROM   (
											--  11

											SELECT
											/*完成情况*/
											 NVL(B.本年应完成, 0) AS 本年应完成, NVL(B.本年已完成, 0) AS 本年已完成,
												NVL(B.本季度应完成, 0) AS 本季度应完成, NVL(B.本季度已完成, 0) AS 本季度已完成,
												NVL(B.本月应完成, 0) AS 本月应完成, NVL(B.本月已完成, 0) AS 本月已完成
												/*动态得分情况*/, NVL(B.本月动态得分, 0) AS 本月动态得分,
												NVL(B.本季度动态得分, 0) AS 本季度动态得分
												/*里程碑、一级节点完成情况*/, NVL(B.本月里程碑应完成, 0) AS 本月里程碑应完成,
												NVL(B.本月里程碑已完成, 0) AS 本月里程碑已完成,
												NVL(B.本月一级节点应完成, 0) AS 本月一级节点应完成,
												NVL(B.本月一级节点已完成, 0) AS 本月一级节点已完成,
												NVL(B.本季度里程碑应完成, 0) AS 本季度里程碑应完成,
												NVL(B.本季度里程碑已完成, 0) AS 本季度里程碑已完成,
												NVL(B.本季度一级节点应完成, 0) AS 本季度一级节点应完成,
												NVL(B.本季度一级节点已完成, 0) AS 本季度一级节点已完成
												/*亮点情况*/, NVL(B.本月里程碑绿灯, 0) AS 本月里程碑绿灯,
												NVL(B.本月里程碑黄灯, 0) AS 本月里程碑黄灯,
												NVL(B.本月里程碑红灯, 0) AS 本月里程碑红灯,
												NVL(B.本月一级节点绿灯, 0) AS 本月一级节点绿灯,
												NVL(B.本月一级节点黄灯, 0) AS 本月一级节点黄灯,
												NVL(B.本月一级节点红灯, 0) AS 本月一级节点红灯,
												NVL(B.本月二三级节点绿灯, 0) AS 本月二三级节点绿灯,
												NVL(B.本月二三级节点黄灯, 0) AS 本月二三级节点黄灯,
												NVL(B.本月二三级节点红灯, 0) AS 本月二三级节点红灯,
												NVL(B.本季度里程碑绿灯, 0) AS 本季度里程碑绿灯,
												NVL(B.本季度里程碑黄灯, 0) AS 本季度里程碑黄灯,
												NVL(B.本季度里程碑红灯, 0) AS 本季度里程碑红灯,
												NVL(B.本季度一级节点绿灯, 0) AS 本季度一级节点绿灯,
												NVL(B.本季度一级节点黄灯, 0) AS 本季度一级节点黄灯,
												NVL(B.本季度一级节点红灯, 0) AS 本季度一级节点红灯,
												NVL(B.本季度二三级节点绿灯, 0) AS 本季度二三级节点绿灯,
												NVL(B.本季度二三级节点黄灯, 0) AS 本季度二三级节点黄灯,
												NVL(B.本季度二三级节点红灯, 0) AS 本季度二三级节点红灯,
												CONNECT_BY_ROOT ID AS ID,
												CONNECT_BY_ROOT PARENT_ID AS PARENT_ID
											FROM   SYS_BUSINESS_UNIT A
											LEFT   JOIN (

																	 SELECT B1.UNIT_ID, COUNT(A1.ID) AS "NODESUM",
																					 SUM(STANDARD_SCORE) AS "SUMNODESCORE"
																					 --完成规则

																					 ------------------
																					 /*本年任务*/
																					 ------------------
																					 ------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.PLAN_END_DATE, 'YYYY') =
																												TO_CHAR(SYSDATE, 'YYYY') THEN
																										1
																									 ELSE
																										0
																							 END

																							 ) AS "本年应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本年
																												AND
																												TO_CHAR(A1.PLAN_END_DATE, 'YYYY') =
																												TO_CHAR(SYSDATE, 'YYYY')
																									 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																										THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本年已完成"

																					 ------------------
																					 /*本月任务*/
																					 ------------------
																					 ------
																					 ,
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																									 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																										THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月已完成"

																					 ,
																					 SUM((CASE
																							 --按时完成
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) BETWEEN 0 AND 29 THEN
																										A1.STANDARD_SCORE * 1
																							 --提前一个月完成
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL = '里程碑' THEN
																										A1.STANDARD_SCORE * 1.2
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL = '一级节点' THEN
																										A1.STANDARD_SCORE * 1.1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 1.0
																							 --延时完成
																							 --里程碑、一级节点3天
																							 --二三级节点5天
																							 --延时完成
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN
																												('里程碑', '一级节点') THEN
																										A1.STANDARD_SCORE * 0.6
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 3 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 1.0
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 4 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 0.6
																							 --红灯
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN
																												('里程碑', '一级节点') THEN
																										A1.STANDARD_SCORE * 0
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 0
																									 ELSE
																										0
																							 END)) AS "本月动态得分"

																					 ------------------
																					 /*-里程碑完成情况*/
																					 ------------------
																					 ,
																					 SUM((CASE
																									 WHEN A1.
																										NODE_LEVEL = '里程碑' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月里程碑应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL AND A1.
																										NODE_LEVEL = '里程碑' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月里程碑已完成"
																					 ------------------
																					 /*-一级节点完成情况*/
																					 ------------------
																					 ,
																					 SUM((CASE
																									 WHEN A1.
																										NODE_LEVEL = '一级节点' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月一级节点应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL AND A1.
																										NODE_LEVEL = '一级节点' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本月一级节点已完成"

																					 ------------------
																					 /*-里程碑本月亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月里程碑绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月里程碑黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月里程碑红灯"

																					 ------------------
																					 /*一级节点本月亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月一级节点绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月一级节点黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月一级节点红灯"

																					 ------------------
																					 /*二三级节点本月亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 2 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月二三级节点绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月二三级节点黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本月
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.铁建_本年 || '-' ||
																																 TO_CHAR(TO_NUMBER(铁建_本月) - 1) || '-' || '26'
																												 FROM   V_POM_GETEXAMINE_MOTH A) AND
																												(SELECT A.铁建_本年 || '-' || 铁建_本月 || '-' || '25'
																												 FROM   V_POM_GETEXAMINE_MOTH A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本月二三级节点红灯"

																					 ------------------
																					 /*本季度任务*/
																					 ------------------
																					 ------
																					 ,
																					 SUM((CASE
																									 WHEN
																									 --判断季度
																										TO_CHAR(A1.PLAN_END_DATE,
																														'YYYY-MM-DD') BETWEEN
																										(SELECT A.开始年度 || '-' || A.开始月份 ||
																														 '-26'
																										 FROM   V_POM_GETEXAMINE_QUARTER A) AND
																										(SELECT A.开始年度 || '-' || A.结束月份 ||
																														 '-25'
																										 FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												(SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																									 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																										THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度已完成"

																					 ,
																					 SUM((CASE
																							 --按时完成
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) BETWEEN 0 AND 29 THEN
																										A1.STANDARD_SCORE * 1

																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL = '里程碑' THEN
																										A1.STANDARD_SCORE * 1.2
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL = '一级节点' THEN
																										A1.STANDARD_SCORE * 1.1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(A1.PLAN_END_DATE, 'DD') -
																												 TRUNC(D.APPROVAL_TIME, 'DD')) >= 30 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 1.0
																							 --延时完成
																							 --里程碑、一级节点3天
																							 --二三级节点5天
																							 --延时完成
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN
																												('里程碑', '一级节点') THEN
																										A1.STANDARD_SCORE * 0.6
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 3 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 1.0
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 4 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 0.6
																							 --红灯
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN
																												('里程碑', '一级节点') THEN
																										A1.STANDARD_SCORE * 0
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'

																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										A1.STANDARD_SCORE * 0
																									 ELSE
																										0
																							 END)) AS "本季度动态得分"

																					 ------------------
																					 /*-里程碑完成情况*/
																					 ------------------
																					 ,
																					 SUM((CASE
																									 WHEN A1.
																										NODE_LEVEL = '里程碑' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																	'-26'
																													FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度里程碑应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL AND A1.
																										NODE_LEVEL = '里程碑' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度里程碑已完成"
																					 ------------------
																					 /*-一级节点完成情况*/
																					 ------------------
																					 ,
																					 SUM((CASE
																									 WHEN A1.
																										NODE_LEVEL = '一级节点' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																	'-26'
																													FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度一级节点应完成",
																					 SUM((CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL AND A1.
																										NODE_LEVEL = '一级节点' AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A) THEN
																										1
																									 ELSE
																										0
																							 END)) AS "本季度一级节点已完成"

																					 ------------------
																					 /*-里程碑本季度亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度里程碑绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度里程碑黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('里程碑') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度里程碑红灯"

																					 ------------------
																					 /*一级节点本季度亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 0 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度一级节点绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 1 AND 4 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度一级节点黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 5 AND
																												A1.NODE_LEVEL IN ('一级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度一级节点红灯"

																					 ------------------
																					 /*二三级节点本季度亮灯情况*/
																					 ------------------
																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) <= 2 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度二三级节点绿灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) BETWEEN 3 AND 7 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度二三级节点黄灯"

																					 ,
																					 SUM(CASE
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NOT NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(D.APPROVAL_TIME, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1
																									 WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																																'YYYY-MM-DD') IS NULL
																											 --判断本季度
																												AND
																												TO_CHAR(A1.PLAN_END_DATE,
																																'YYYY-MM-DD') BETWEEN
																												((SELECT A.开始年度 || '-' || A.开始月份 ||
																																 '-26'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)) AND
																												(SELECT A.开始年度 || '-' || A.结束月份 ||
																																 '-25'
																												 FROM   V_POM_GETEXAMINE_QUARTER A)
																											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																												AND
																												(TRUNC(SYSDATE, 'DD') -
																												 TRUNC(A1.PLAN_END_DATE, 'DD')) >= 8 AND
																												A1.NODE_LEVEL IN
																												('二级节点', '三级节点') THEN
																										1

																									 ELSE
																										0
																							 END) AS "本季度二三级节点红灯"

																	 FROM   POM_PROJ_PLAN A
																	 INNER  JOIN POM_PROJ_PLAN_NODE A1
																	 ON     A.ID = A1.PROJ_PLAN_ID
																	 INNER  JOIN SYS_PROJECT_STAGE C1
																	 ON     A.PROJ_ID = C1.ID
																	 INNER  JOIN SYS_PROJECT B1
																	 ON     C1.PROJECT_ID = B1.ID
																	 LEFT   JOIN POM_NODE_FEEDBACK D
																	 ON     D.FEEDBACK_NODE_ID = A1.ID AND
																					FEEDBACK_TYPE = '完成反馈' AND
																					D.APPROVAL_STATUS = '已审核'
																	 WHERE  A.PLAN_TYPE = '项目主项计划' AND
																					A.APPROVAL_STATUS = '已审核'
																	 GROUP  BY B1.UNIT_ID) B
											ON     A.ID = B.UNIT_ID
											WHERE  NVL(B.NODESUM, 0) > 0
											CONNECT BY PRIOR A.ID = A.PARENT_ID) AB
						 GROUP  BY AB.ID, AB.PARENT_ID) B
ON     A.ID = B.ID
WHERE  A.ORG_TYPE = 0 AND
			 A.COMPANY_TYPE = '5' AND
			 A.PARENT_ID = '00320000000000000000000000000S0'

;
--------------------------------------------------------
--  DDL for View V_POM_PJMOTHPLAN_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJMOTHPLAN_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS "COMPANY_ID"
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS "CTYPE"
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


  FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划' AND  A.APPROVAL_STATUS='已审核'
 and A1.IS_DISABLE=0
 --判断本月
 AND A1.PLAN_END_DATE  BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总//无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4 as  lw
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID
 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核'
 and A1.IS_DISABLE=0

 AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME LIKE '%无分期%' 


UNION ALL
--顶级项目汇总//有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE,
 '' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
 --完成规则
 ,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,c1.PROJECT_ID


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核' 
 and A1.IS_DISABLE=0

 AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME,c1.PROJECT_ID 	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
	where        NVL(B2.NODESUM,0)>0 and B3.STAGE_NAME NOT   LIKE '%无分期%'
		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'    AND  A.APPROVAL_STATUS='已审核'
  and A1.IS_DISABLE=0
   AND A1.PLAN_END_DATE BETWEEN
  TO_DATE ((SELECT   case when  TO_NUMBER(铁建_本月) >1 then     TO_CHAR( A.铁建_本年)  else   TO_CHAR( A.铁建_本年-1) end   ||'-'||case when  TO_NUMBER(铁建_本月) >1 then  TO_CHAR( TO_NUMBER(铁建_本月)-1) else'12' end ||'-'||'26'  FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')  AND
 TO_DATE ((SELECT    A.铁建_本年||'-'||铁建_本月||'-'||'25' FROM V_POM_GETEXAMINE_MOTH A),'yyyy-mm-dd')
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'--C1.PROJECT_ID
		GROUP BY  C1.PROJECT_ID,A.COMPANY_ID,C1.ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_PJPLAN_EXM_SOCRE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJPLAN_EXM_SOCRE" ("RANK", "PLAN_TYPE", "ID", "PARENT_ID", "ORG_NAME", "PROJECT_NAME", "ORGCODE", "PLANYEAR", "PLANQUATOR", "PLANMOTH", "应完成", "已完成", "SUMNODESCORE", "已完成总分", "动态得分", "里程碑应完成", "里程碑已完成", "一级节点应完成", "一级节点已完成", "二级节点应完成", "二级节点已完成", "三级节点应完成", "三级节点已完成", "里程碑绿灯", "一级节点绿灯", "二级节点绿灯", "三级节点绿灯", "里程碑黄灯", "一级节点黄灯", "二级节点黄灯", "三级节点黄灯", "里程碑红灯", "一级节点红灯", "二级节点红灯", "三级节点红灯", "CTYPE") AS SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE

, A3.PROJECTID as ID  
,A4.ID AS    PARENT_ID  
,A3.PROJECT_NAME as ORG_NAME 
,PROJECT_NAME as PROJECT_NAME
,LPAD( A3.SN, 4,'0') AS ORGCODE
,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(

SELECT 
A2.PROJECT_NAME AS PROJECT_NAME,PLAN_TYPE,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_PROJTOP' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.SN,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,A.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,nvl(PNE.EXAMINATION_SCORE,0) as EXAMINATION_SCORE ,nvl(PNE.NEW_EXAMINATION_SCORE,0) as NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
		,TO_CHAR(A1.PLAN_END_DATE,'YYYY')   AS  "PLANYEAR"
	,LPAD( TO_CHAR( A1.PLAN_END_DATE, 'Q' ),2,'0') 	AS "PLANQUATOR"
	,TO_CHAR( A1.PLAN_END_DATE, 'MM' ) AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE   A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  and a1.IS_DISABLE=0

and( (select FN_BIZPARAM_CONFIG('pom_fission_node_is_examined') as is_examined from dual)=0 and  a1.FISSION_SOURCE_ORIGINAL_ID is  null )


) A2

GROUP BY A2.PROJECT_NAME ,PLAN_TYPE ,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 

UNION ALL 

SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE

, A3.PROJECTID as ID  
,A4.ID AS    PARENT_ID  
,A3.PROJECT_NAME as ORG_NAME 
,PROJECT_NAME as PROJECT_NAME
,LPAD( A3.SN, 4,'0') AS ORGCODE
,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(

SELECT 
A2.PROJECT_NAME AS PROJECT_NAME,PLAN_TYPE,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_PROJTOP' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.SN,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,A.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,nvl(PNE.EXAMINATION_SCORE,0) as EXAMINATION_SCORE ,nvl(PNE.NEW_EXAMINATION_SCORE,0) as NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
		,TO_CHAR(A1.PLAN_END_DATE,'YYYY')   AS  "PLANYEAR"
	,LPAD( TO_CHAR( A1.PLAN_END_DATE, 'Q' ),2,'0') 	AS "PLANQUATOR"
	,TO_CHAR( A1.PLAN_END_DATE, 'MM' ) AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE   A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  and a1.IS_DISABLE=0

and (select FN_BIZPARAM_CONFIG('pom_fission_node_is_examined') as is_examined from dual)=1 


) A2

GROUP BY A2.PROJECT_NAME ,PLAN_TYPE ,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 



--and  A4.PARENT_ID='003200000000000000000000000000'
-- AND    PLANYEAR=2020
-- AND ORGNAME in ('贵州公司','贵州地产总部')
;
--------------------------------------------------------
--  DDL for View V_POM_PJPLANDELAY_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJPLANDELAY_STATISTICS" ("RANK", "ID", "PARENT_ID", "ORG_NAME", "NODESUM", "DELAYFINISHTOTAL", "开盘DELAYFINISH", "开工DELAYFINISH", "PROJDELAY", "PROSTAGEDELAY", "CTYPE") AS SELECT ROW_NUMBER() OVER(PARTITION BY A.PARENT_ID ORDER BY ROUND(CASE
					 WHEN NVL(B.NODESUM,
										0) > 0 THEN
						NVL(DELAYFINISH,
								0) /
						NVL(B.NODESUM,
								0)
					 ELSE
						0
			 END * 100, 2) DESC) AS RANK, A.ID, A.PARENT_ID, A.ORG_NAME,
			 NVL(B.NODESUM, 0) AS NODESUM, NVL(DELAYFINISH, 0) AS DELAYFINISHTOTAL,
			 NVL(B."开盘DELAYFINISH", 0) AS "开盘DELAYFINISH",
			 NVL(B."开工DELAYFINISH", 0) AS "开工DELAYFINISH",
			 NVL(B."PROJIDDELAY", 0) AS "PROJDELAY",
			 NVL(B."PROSTAGEID", 0) AS "PROSTAGEDELAY", 'TYPE_ORG' AS CTYPE
FROM   SYS_BUSINESS_UNIT A
LEFT   JOIN (SELECT AB.ID, AB.PARENT_ID, SUM(AB.NODESUM) AS NODESUM,
										SUM(AB.开盘DELAYFINISH) AS 开盘DELAYFINISH,
										SUM(AB.开工DELAYFINISH) AS 开工DELAYFINISH,
										SUM(AB.DELAYFINISH) AS DELAYFINISH,
										SUM(CASE
														WHEN (AB.PROJIDDELAY) IS NOT NULL THEN
														 1
														ELSE
														 0
												END) AS PROJIDDELAY,
										SUM(CASE
														WHEN (AB.PROSTAGEID) IS NOT NULL THEN
														 1
														ELSE
														 0
												END) AS PROSTAGEID -- ,COUNT(AB.PROSTAGEID) AS  PROSTAGEID
						 FROM   (
											--  11

											SELECT NVL(B.NODESUM, 0) AS NODESUM,
															NVL(B.DELAYFINISH, 0) AS DELAYFINISH,
															NVL(B."开盘DELAYFINISH", 0) AS "开盘DELAYFINISH",
															NVL(B."开工DELAYFINISH", 0) AS "开工DELAYFINISH",
															(CASE
																	WHEN NVL(B."DELAYFINISH", 0) > 0 THEN
																	 B.PROSTAGEID
																	ELSE
																	 NULL
															END) AS "PROSTAGEID",
															(CASE
																	WHEN NVL(B."DELAYFINISH", 0) > 0 THEN
																	 B.PROJID
																	ELSE
																	 NULL
															END) AS "PROJIDDELAY", ORG_NAME,
															CONNECT_BY_ROOT ID AS ID,
															CONNECT_BY_ROOT PARENT_ID AS PARENT_ID
											FROM   SYS_BUSINESS_UNIT A
											LEFT   JOIN (SELECT B1.UNIT_ID, C1.ID AS PROSTAGEID,
																					B1.ID AS PROJID,
																					COUNT(A1.ID) AS "NODESUM"
																					--完成规则
																					,
																					SUM((CASE
																									WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') IS NOT NULL AND
																											 TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') >
																											 TO_CHAR(PLAN_END_DATE,
																															 'YYYY-MM-DD') THEN
																									 1
																									ELSE
																									 0
																							END)) AS "DELAYFINISH",
																					SUM((CASE
																									WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') IS NOT NULL AND
																											 A1.NODE_NAME LIKE '%开盘%' AND
																											 TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') >
																											 TO_CHAR(PLAN_END_DATE,
																															 'YYYY-MM-DD') THEN
																									 1
																									ELSE
																									 0
																							END)) AS "开盘DELAYFINISH",
																					SUM((CASE
																									WHEN TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') IS NOT NULL AND
																											 A1.NODE_NAME LIKE '%建设规划许可证%' AND
																											 TO_CHAR(A1.ACTUAL_END_DATE,
																															 'YYYY-MM-DD') >
																											 TO_CHAR(PLAN_END_DATE,
																															 'YYYY-MM-DD') THEN
																									 1
																									ELSE
																									 0
																							END)) AS "开工DELAYFINISH"

																	 FROM   POM_PROJ_PLAN A
																	 INNER  JOIN POM_PROJ_PLAN_NODE A1
																	 ON     A.ID = A1.PROJ_PLAN_ID
																	 INNER  JOIN SYS_PROJECT_STAGE C1
																	 ON     A.PROJ_ID = C1.ID
																	 INNER  JOIN SYS_PROJECT B1
																	 ON     C1.PROJECT_ID = B1.ID
																	 WHERE  A.PLAN_TYPE = '关键节点计划' AND
																					A.APPROVAL_STATUS = '已审核'
																	 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
																	 GROUP  BY B1.UNIT_ID, C1.ID, B1.ID) B
											ON     A.ID = B.UNIT_ID
											WHERE  NVL(B.NODESUM, 0) > 0

											CONNECT BY PRIOR A.ID = A.PARENT_ID) AB
						 GROUP  BY AB.ID, AB.PARENT_ID) B
ON     A.ID = B.ID
WHERE  A.ORG_TYPE = 0 AND
			 NVL(B.NODESUM, 0) > 0

UNION ALL
--顶级项目汇总
SELECT ROW_NUMBER() OVER(PARTITION BY PARENT_ID ORDER BY ROUND(CASE
					 WHEN NVL(NODESUM, 0) > 0 THEN
						NVL(DELAYFINISH, 0) / NVL(NODESUM, 0)
					 ELSE
						0
			 END * 100, 2) DESC) AS RANK, B3."PROJID", B3."PARENT_ID",
			 B3."PROJECT_NAME", B3."NODESUM", B3."DELAYFINISH", B3."开盘DELAYFINISH",
			 B3."开工DELAYFINISH", B3."PROSTAGEID", B3."PROJIDDELAY", B3."CTYPE"
FROM   (SELECT B2.PROJID, B2.PARENT_ID, B2.PROJECT_NAME,
								SUM(NVL(B2.NODESUM, 0)) AS NODESUM,
								SUM(NVL(B2.DELAYFINISH, 0)) AS DELAYFINISH,
								SUM(NVL(B2."开盘DELAYFINISH", 0)) AS "开盘DELAYFINISH",
								SUM(NVL(B2."开工DELAYFINISH", 0)) AS "开工DELAYFINISH",
								COUNT((CASE
													WHEN NVL(B2."DELAYFINISH", 0) > 0 THEN
													 B2.PROSTAGEID
													ELSE
													 NULL
											END)) AS "PROSTAGEID",
								COUNT((CASE
													WHEN NVL(B2."DELAYFINISH", 0) > 0 THEN
													 B2.PROJID
													ELSE
													 NULL
											END)) AS "PROJIDDELAY", 'TYPE_PROJTOP' AS CTYPE
				 FROM   (SELECT B1.UNIT_ID AS PARENT_ID, C1.ID AS PROSTAGEID,
												 B1.ID AS PROJID, B1.PROJECT_NAME,
												 COUNT(A1.ID) AS "NODESUM"
												 --完成规则
												 ,
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "DELAYFINISH",
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			A1.NODE_NAME LIKE '%开盘%' AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "开盘DELAYFINISH",
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			A1.NODE_NAME LIKE '%建设规划许可证%' AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "开工DELAYFINISH"

									FROM   POM_PROJ_PLAN A
									INNER  JOIN POM_PROJ_PLAN_NODE A1
									ON     A.ID = A1.PROJ_PLAN_ID
									INNER  JOIN SYS_PROJECT_STAGE C1
									ON     A.PROJ_ID = C1.ID
									INNER  JOIN SYS_PROJECT B1
									ON     C1.PROJECT_ID = B1.ID
									WHERE  A.PLAN_TYPE = '关键节点计划' AND
												 A.APPROVAL_STATUS = '已审核'
									--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
									GROUP  BY B1.UNIT_ID, C1.ID, B1.ID, PROJECT_NAME) B2
				 WHERE  NVL(B2.NODESUM, 0) > 0
				 GROUP  BY B2.PROJID, B2.PARENT_ID, B2.PROJECT_NAME) B3
----分期汇总

UNION ALL
SELECT ROW_NUMBER() OVER(PARTITION BY B3.PARENT_ID ORDER BY ROUND(CASE
					 WHEN NVL(B3.NODESUM, 0) > 0 THEN
						NVL(DELAYFINISH, 0) / NVL(B3.NODESUM, 0)
					 ELSE
						0
			 END * 100, 2) DESC) AS RANK, B3."PROSTAGEID", B3."PARENT_ID",
			 B3."PROJSTAGE_NAME", B3."NODESUM", B3."DELAYFINISH",
			 B3."开盘DELAYFINISH", B3."开工DELAYFINISH", B3."PROSTAGEIDDELAY",
			 B3."PROJIDDELAY", B3."CTYPE"
FROM   (SELECT B2.PROSTAGEID, B2.PARENT_ID, B2.PROJSTAGE_NAME,
								SUM(NVL(B2.NODESUM, 0)) AS NODESUM,
								SUM(NVL(B2.DELAYFINISH, 0)) AS DELAYFINISH,
								SUM(NVL(B2."开盘DELAYFINISH", 0)) AS "开盘DELAYFINISH",
								SUM(NVL(B2."开工DELAYFINISH", 0)) AS "开工DELAYFINISH",
								COUNT((CASE
													WHEN NVL(B2."DELAYFINISH", 0) > 0 THEN
													 B2.PROSTAGEID
													ELSE
													 NULL
											END)) AS "PROSTAGEIDDELAY",
								COUNT((CASE
													WHEN NVL(B2."DELAYFINISH", 0) > 0 THEN
													 B2.PROJID
													ELSE
													 NULL
											END)) AS "PROJIDDELAY", 'TYPE_PROJLAST' AS CTYPE
				 FROM   (SELECT C1.PROJECT_ID AS PARENT_ID, C1.ID AS PROSTAGEID,
												 B1.ID AS PROJID,
												 B1.PROJECT_NAME || '_' || C1.STAGE_NAME AS PROJSTAGE_NAME,
												 COUNT(A1.ID) AS "NODESUM"
												 --完成规则
												 ,
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "DELAYFINISH",
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			A1.NODE_NAME LIKE '%开盘%' AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "开盘DELAYFINISH",
												 SUM((CASE
																 WHEN TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') IS NOT NULL AND
																			A1.NODE_NAME LIKE '%建设规划许可证%' AND
																			TO_CHAR(A1.ACTUAL_END_DATE, 'YYYY-MM-DD') >
																			TO_CHAR(PLAN_END_DATE, 'YYYY-MM-DD') THEN
																	1
																 ELSE
																	0
														 END)) AS "开工DELAYFINISH"

									FROM   POM_PROJ_PLAN A
									INNER  JOIN POM_PROJ_PLAN_NODE A1
									ON     A.ID = A1.PROJ_PLAN_ID
									INNER  JOIN SYS_PROJECT_STAGE C1
									ON     A.PROJ_ID = C1.ID
									INNER  JOIN SYS_PROJECT B1
									ON     C1.PROJECT_ID = B1.ID
									WHERE  A.PLAN_TYPE = '关键节点计划' AND
												 A.APPROVAL_STATUS = '已审核'

									--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
									GROUP  BY C1.PROJECT_ID, C1.ID, B1.ID, PROJECT_NAME,
														STAGE_NAME) B2
				 WHERE  NVL(B2.NODESUM, 0) > 0
				 GROUP  BY B2.PROSTAGEID, B2.PARENT_ID, B2.PROJSTAGE_NAME) B3

;
--------------------------------------------------------
--  DDL for View V_POM_PJPLANRANK
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJPLANRANK" ("RANK", "PLAN_TYPE", "ID", "PARENT_ID", "ORG_NAME", "ORGCODE", "PLANYEAR", "PLANQUATOR", "PLANMOTH", "应完成", "已完成", "SUMNODESCORE", "已完成总分", "动态得分", "里程碑应完成", "里程碑已完成", "一级节点应完成", "一级节点已完成", "二级节点应完成", "二级节点已完成", "三级节点应完成", "三级节点已完成", "里程碑绿灯", "一级节点绿灯", "二级节点绿灯", "三级节点绿灯", "里程碑黄灯", "一级节点黄灯", "二级节点黄灯", "三级节点黄灯", "里程碑红灯", "一级节点红灯", "二级节点红灯", "三级节点红灯", "CTYPE") AS SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE

,CONNECT_BY_ROOT A4.ID as ID  ,CONNECT_BY_ROOT A4.PARENT_ID as PARENT_ID  
,CONNECT_BY_ROOT A4."ORG_NAME" as ORG_NAME 
,LPAD(CONNECT_BY_ROOT A4.ORDER_CODE, 4,'0') AS ORGCODE
,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(
SELECT 
A2.ORGNAME AS ORG_NAME,A2.PLAN_TYPE ,A2.ORGID,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_ORG' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,a.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,PNE.EXAMINATION_SCORE,PNE.NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
	, CASE WHEN  	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'MM'))=12 AND 	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'DD'))>25 THEN  TO_CHAR(TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'YYYY') +1)) ELSE    TO_CHAR(A1.PLAN_END_DATE,'YYYY')  END AS  "PLANYEAR"
	, CASE WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 
	BETWEEN  1  AND 3 THEN 1
	WHEN

	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 4  AND 6  THEN 2
	WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 


	BETWEEN 7 AND  9  THEN 3
	WHEN   
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 10 AND 12  THEN 4  END
	AS "PLANQUATOR"
	,CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE     A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  
AND   A.COMPANY_NAME  NOT  in(  '中南公司','贵州公司')
) A2

GROUP BY A2.ORGID,A2.ORGNAME,PLAN_TYPE,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 
--and  A4.PARENT_ID='003200000000000000000000000000'
-- AND    PLANYEAR=2020
-- AND ORGNAME in ('贵州公司','贵州地产总部')
CONNECT BY PRIOR A4.ID=A4.PARENT_ID


-- AND  B1.PROJECT_NAME='重庆西派城'
--   SELECT * FROM  POM_PROJ_PLAN_NODE  where   ROWNUM<2


UNION ALL 

 ------------------------------------------------------------------------------------
 --查询公司//中南公司项目、贵州公司项目汇总--集团公司
 ------------------------------------------------------------------------------------
 SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE
,'003200000000000000000000000000' as id ,'0001' as PARENT_ID,'中国铁建地产集团' as ORG_NAME
,'0001' AS ORGCODE

,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(
SELECT 
A2.ORGNAME AS ORG_NAME ,PLAN_TYPE,A2.ORGID,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_ORG' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,A.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,PNE.EXAMINATION_SCORE,PNE.NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
	, CASE WHEN  	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'MM'))=12 AND 	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'DD'))>25 THEN  TO_CHAR(TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'YYYY') +1)) ELSE    TO_CHAR(A1.PLAN_END_DATE,'YYYY')  END AS  "PLANYEAR"
	, CASE WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 
	BETWEEN  1  AND 3 THEN 1
	WHEN

	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 4  AND 6  THEN 2
	WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 


	BETWEEN 7 AND  9  THEN 3
	WHEN   
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 10 AND 12  THEN 4  END
	AS "PLANQUATOR"
	,CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE   A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  
AND   A.COMPANY_NAME     in (  '中南公司','贵州公司')--集团
) A2


GROUP BY A2.ORGID,A2.ORGNAME,PLAN_TYPE,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 
--and  A4.PARENT_ID='003200000000000000000000000000'
-- AND    PLANYEAR=2020
-- AND ORGNAME in ('贵州公司','贵州地产总部')



-- AND  B1.PROJECT_NAME='重庆西派城'
--   SELECT * FROM  POM_PROJ_PLAN_NODE  where   ROWNUM<2
UNION ALL 

 ------------------------------------------------------------------------------------
 --查询公司//中南公司项目、贵州公司项目
 ------------------------------------------------------------------------------------
 SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE

, A4.ID as ID  , A4.PARENT_ID as PARENT_ID  
, A4."ORG_NAME" as ORG_NAME 
,LPAD( A4.ORDER_CODE, 4,'0') AS ORGCODE
,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(
SELECT 
A2.ORGNAME AS ORG_NAME ,PLAN_TYPE,A2.ORGID,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_ORG' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,A.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,PNE.EXAMINATION_SCORE,PNE.NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
	, CASE WHEN  	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'MM'))=12 AND 	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'DD'))>25 THEN  TO_CHAR(TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'YYYY') +1)) ELSE    TO_CHAR(A1.PLAN_END_DATE,'YYYY')  END AS  "PLANYEAR"
	, CASE WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 
	BETWEEN  1  AND 3 THEN 1
	WHEN

	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 4  AND 6  THEN 2
	WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 


	BETWEEN 7 AND  9  THEN 3
	WHEN   
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 10 AND 12  THEN 4  END
	AS "PLANQUATOR"
	,CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE    A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  
AND   A.COMPANY_NAME     in(  '中南公司','贵州公司')--中南公司、贵州公司
) A2

GROUP BY A2.ORGID,PLAN_TYPE,A2.ORGNAME,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 
--and  A4.PARENT_ID='003200000000000000000000000000'
-- AND    PLANYEAR=2020
-- AND ORGNAME in ('贵州公司','贵州地产总部')



-- AND  B1.PROJECT_NAME='重庆西派城'
--   SELECT * FROM  POM_PROJ_PLAN_NODE  where   ROWNUM<2


 ------------------------------------------------------------------------------------
 --查询项目
 ------------------------------------------------------------------------------------
UNION ALL 


 SELECT  
 row_number() over( PARTITION  BY A4.PARENT_ID  order by ROUND( CASE WHEN NVL(A3.应完成,0)>0 THEN nvl(已完成,0)/NVL(A3.应完成,0) ELSE 0 END *100,2) desc) as rank
 ,PLAN_TYPE AS  PLAN_TYPE

, A3.PROJECTID as ID  
,A4.ID AS    PARENT_ID  
,A3.PROJECT_NAME as ORG_NAME 
,LPAD( A3.SN, 4,'0') AS ORGCODE
,A3."PLANYEAR",A3."PLANQUATOR",A3."PLANMOTH",A3."应完成",A3."已完成",A3."SUMNODESCORE",A3."已完成总分",A3."动态得分",A3."里程碑应完成",A3."里程碑已完成",A3."一级节点应完成",A3."一级节点已完成",A3."二级节点应完成",A3."二级节点已完成",A3."三级节点应完成",A3."三级节点已完成",A3."里程碑绿灯",A3."一级节点绿灯",A3."二级节点绿灯",A3."三级节点绿灯",A3."里程碑黄灯",A3."一级节点黄灯",A3."二级节点黄灯",A3."三级节点黄灯",A3."里程碑红灯",A3."一级节点红灯",A3."二级节点红灯",A3."三级节点红灯",A3."CTYPE"
FROM 
SYS_BUSINESS_UNIT A4 LEFT JOIN
(

SELECT 
A2.PROJECT_NAME AS PROJECT_NAME,PLAN_TYPE,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
,COUNT(A2.NODEID) AS 应完成
,SUM(CASE WHEN A2.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0   END ) AS 已完成
,SUM(A2.STANDARD_SCORE) AS SUMNODESCORE
,SUM(NVL(A2.EXAMINATION_SCORE,0)) AS 已完成总分
    /*动态得分情况*/
,SUM(NVL(A2.NEW_EXAMINATION_SCORE,0))   AS 动态得分
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN 1 ELSE 0 END ) AS 里程碑应完成
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' AND  A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 里程碑已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN 1 ELSE 0 END ) AS 一级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 一级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN 1 ELSE 0 END ) AS 二级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='"二级节点'  AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 二级节点已完成
 ,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN 1 ELSE 0 END ) AS 三级节点应完成
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' AND A2.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END ) AS 三级节点已完成

,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.绿灯  ELSE 0 END ) AS 里程碑绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.绿灯  ELSE 0 END ) AS 一级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.绿灯  ELSE 0 END ) AS 二级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.绿灯  ELSE 0 END ) AS 三级节点绿灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.黄灯  ELSE 0 END ) AS 里程碑黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.黄灯  ELSE 0 END ) AS 一级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.黄灯  ELSE 0 END ) AS 二级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.黄灯  ELSE 0 END ) AS 三级节点黄灯
,SUM(CASE WHEN A2.NODE_LEVEL='里程碑' THEN A2.红灯  ELSE 0 END ) AS 里程碑红灯
,SUM(CASE WHEN A2.NODE_LEVEL='一级节点' THEN A2.红灯  ELSE 0 END ) AS 一级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='二级节点' THEN A2.红灯  ELSE 0 END ) AS 二级节点红灯
,SUM(CASE WHEN A2.NODE_LEVEL='三级节点' THEN A2.红灯  ELSE 0 END ) AS 三级节点红灯
   ,'TYPE_PROJTOP' AS CTYPE
		
FROM 

(
SELECT      B1.ID AS PROJECTID,B1.SN,B1.PROJECT_NAME,B1.UNIT_ID AS ORGID,b1.UNIT_NAME AS ORGNAME 
,A.ID AS PLANID ,A.PLAN_NAME,A.PLAN_TYPE
	,A1.ID AS NODEID,A1.NODE_NAME,A1.NODE_LEVEL,A1.PLAN_END_DATE,A1.ACTUAL_END_DATE,A1.ESTIMATE_END_DATE
	,A1.STANDARD_SCORE,PNE.EXAMINATION_SCORE,PNE.NEW_EXAMINATION_SCORE
	,A1.COMPLETION_STANDARD,COMPLETION_RESULTS_REMARK
	, CASE WHEN  	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'MM'))=12 AND 	TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'DD'))>25 THEN  TO_CHAR(TO_NUMBER( TO_CHAR(A1.PLAN_END_DATE,'YYYY') +1)) ELSE    TO_CHAR(A1.PLAN_END_DATE,'YYYY')  END AS  "PLANYEAR"
	, CASE WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 
	BETWEEN  1  AND 3 THEN 1
	WHEN

	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 4  AND 6  THEN 2
	WHEN  
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 


	BETWEEN 7 AND  9  THEN 3
	WHEN   
	CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END 

	BETWEEN 10 AND 12  THEN 4  END
	AS "PLANQUATOR"
	,CASE
	WHEN
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END > 12 THEN
	1 ELSE
	CASE
	WHEN TO_CHAR( A1.PLAN_END_DATE, 'DD' ) > 25 THEN
	TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( A1.PLAN_END_DATE, 'MM' ) )
	END
	END AS "PLANMOTH"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
<= (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 0 ELSE 3 END) 

THEN 1   ELSE  0  END AS "绿灯"
,D.APPROVAL_TIME
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
BETWEEN (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 1 ELSE 4 END)   AND  (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 7 END)   

THEN 1   ELSE  0  END AS "黄灯"
,CASE 
WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  
>=     (CASE WHEN  A1.NODE_LEVEL IN ('里程碑','一级节点')   THEN 5 ELSE 8 END)   

THEN 1   ELSE  0  END AS "红灯"
 

FROM
POM_PROJ_PLAN A
INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
LEFT JOIN POM_NODE_EXAMINATION PNE ON A1.ID = PNE.NODE_ID
LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='CARRY_OUT' AND  D.APPROVAL_STATUS='已审核'
WHERE   A.APPROVAL_STATUS='已审核' AND  A1.IS_DELETE=0  
) A2

GROUP BY A2.PROJECT_NAME ,PLAN_TYPE ,A2.SN ,A2.ORGID,  A2.PROJECTID ,A2.PLANYEAR,A2.PLANQUATOR,A2.PLANMOTH
)A3  ON A3.ORGID=A4.ID
WHERE 1=1
AND A3.应完成>0 

--and  A4.PARENT_ID='003200000000000000000000000000'
-- AND    PLANYEAR=2020
-- AND ORGNAME in ('贵州公司','贵州地产总部')
;
--------------------------------------------------------
--  DDL for View V_POM_PJPLANRANK0528
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJPLANRANK0528" ("RANK", "PLAN_TYPE", "ID", "PARENT_ID", "ORG_NAME", "PLANYEAR", "PLANQUATOR", "PLANMOTH", "应完成", "已完成", "动态得分", "里程碑应完成", "里程碑已完成", "一级节点应完成", "一级节点已完成", "二级节点应完成", "二级节点已完成", "三级节点应完成", "三级节点已完成", "里程碑绿灯", "里程碑黄灯", "里程碑红灯", "一级节点绿灯", "一级节点黄灯", "一级节点红灯", "二级节点绿灯", "二级节点黄灯", "二级节点红灯", "三级节点绿灯", "三级节点黄灯", "三级节点红灯", "CTYPE") AS SELECT  
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.应完成,0)>0 THEN nvl(已完成,0)/NVL(B.应完成,0) ELSE 0 END *100,2) desc) as rank ,
	'项目主项计划'AS  PLAN_TYPE,A.ID,A.PARENT_ID,A.ORG_NAME ,B.PLANYEAR	,B.PLANQUATOR,B.PLANMOTH
-- 		,NVL(B.本季度应完成,0) AS 本季度应完成
-- 		,NVL(B.本季度已完成,0) AS 本季度已完成
		,NVL(B.应完成,0) AS 应完成
		,NVL(B.已完成,0) AS 已完成
		/*动态得分情况*/
		,NVL(B.动态得分,0) AS 动态得分
-- 		,NVL(B.本季度动态得分,0) AS 本季度动态得分
		/*里程碑、一级节点完成情况*/
		,NVL(B.里程碑应完成,0) AS 里程碑应完成
		,NVL(B.里程碑已完成,0) AS 里程碑已完成
		,NVL(B.一级节点应完成,0) AS 一级节点应完成
		,NVL(B.一级节点已完成,0) AS 一级节点已完成
		,NVL(B.二级节点应完成,0) AS 二级节点应完成
		,NVL(B.二级节点已完成,0) AS 二级节点已完成
		,NVL(B.三级节点应完成,0) AS 三级节点应完成
		,NVL(B.三级节点已完成,0) AS 三级节点已完成
-- 		,NVL(B.本季度里程碑应完成,0) AS 本季度里程碑应完成
-- 		,NVL(B.本季度里程碑已完成,0) AS 本季度里程碑已完成
-- 		,NVL(B.本季度一级节点应完成,0) AS 本季度一级节点应完成
-- 		,NVL(B.本季度一级节点已完成,0) AS 本季度一级节点已完成
		/*亮点情况*/
		,NVL(B.里程碑绿灯,0) AS 里程碑绿灯
		,NVL(B.里程碑黄灯,0) AS 里程碑黄灯
		,NVL(B.里程碑红灯,0) AS 里程碑红灯
		,NVL(B.一级节点绿灯,0) AS 一级节点绿灯
		,NVL(B.一级节点黄灯,0) AS 一级节点黄灯
		,NVL(B.一级节点红灯,0) AS 一级节点红灯
		,NVL(B.二级节点绿灯,0) AS 二级节点绿灯
		,NVL(B.二级节点黄灯,0) AS 二级节点黄灯
		,NVL(B.二级节点红灯,0) AS 二级节点红灯
		,NVL(B.三级节点绿灯,0) AS 三级节点绿灯
		,NVL(B.三级节点黄灯,0) AS 三级节点黄灯
		,NVL(B.三级节点红灯,0) AS 三级节点红灯
		
-- 		,NVL(B.本季度里程碑绿灯,0) AS 本季度里程碑绿灯
-- 		,NVL(B.本季度里程碑黄灯,0) AS 本季度里程碑黄灯
-- 		,NVL(B.本季度里程碑红灯,0) AS 本季度里程碑红灯
-- 		,NVL(B.本季度一级节点绿灯,0) AS 本季度一级节点绿灯
-- 		,NVL(B.本季度一级节点黄灯,0) AS 本季度一级节点黄灯
-- 		,NVL(B.本季度一级节点红灯,0) AS 本季度一级节点红灯
-- 		,NVL(B.本季度二三级节点绿灯,0) AS 本季度二三级节点绿灯
-- 		,NVL(B.本季度二三级节点黄灯,0) AS 本季度二三级节点黄灯
-- 		,NVL(B.本季度二三级节点红灯,0) AS 本季度二三级节点红灯
	
	,'TYPE_ORG' AS CTYPE
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID
 ,AB.PLANYEAR	,AB.PLANQUATOR,AB.PLANMOTH
-- 		,SUM(AB.本季度应完成) AS 本季度应完成
-- 		,SUM(AB.本季度已完成) AS 本季度已完成
		,SUM(AB.应完成) AS 应完成
		,SUM(AB.已完成) AS 已完成
		/*动态得分情况*/
		,SUM(AB.动态得分) AS 动态得分
-- 		,SUM(AB.本季度动态得分) AS 本季度动态得分
		/*里程碑、一级节点完成情况*/
		,SUM(AB.里程碑应完成) AS 里程碑应完成
		 ,SUM(AB.里程碑已完成) AS 里程碑已完成
		 ,SUM(AB.一级节点应完成) AS 一级节点应完成
		 ,SUM(AB.一级节点已完成) AS 一级节点已完成
		 ,SUM(AB.二级节点应完成) AS 二级节点应完成
		 ,SUM(AB.二级节点已完成) AS 二级节点已完成
		 ,SUM(AB.三级节点应完成) AS 三级节点应完成
		 ,SUM(AB.三级节点已完成) AS 三级节点已完成
	-- 									 ,NVL(B.本季度里程碑应完成,0) AS 本季度里程碑应完成
	-- 									 ,NVL(B.本季度里程碑已完成,0) AS 本季度里程碑已完成
	-- 									 ,NVL(B.本季度一级节点应完成,0) AS 本季度一级节点应完成
	-- 									 ,NVL(B.本季度一级节点已完成,0) AS 本季度一级节点已完成
		 /*亮点情况*/
		 ,SUM(AB.里程碑绿灯) AS 里程碑绿灯
		 ,SUM(AB.里程碑黄灯) AS 里程碑黄灯
		 ,SUM(AB.里程碑红灯) AS 里程碑红灯
		 ,SUM(AB.一级节点绿灯) AS 一级节点绿灯
		 ,SUM(AB.一级节点黄灯) AS 一级节点黄灯
		 ,SUM(AB.一级节点红灯) AS 一级节点红灯
		 ,SUM(AB.二级节点绿灯) AS 二级节点绿灯
		 ,SUM(AB.二级节点黄灯) AS 二级节点黄灯
		 ,SUM(AB.二级节点红灯) AS 二级节点红灯
		 ,SUM(AB.三级节点绿灯) AS 三级节点绿灯
		 ,SUM(AB.三级节点黄灯) AS 三级节点黄灯
		 ,SUM(AB.三级节点红灯) AS 三级节点红灯

-- 		,SUM(AB.本季度里程碑绿灯) AS 本季度里程碑绿灯
-- 		,SUM(AB.本季度里程碑黄灯) AS 本季度里程碑黄灯
-- 		,SUM(AB.本季度里程碑红灯) AS 本季度里程碑红灯
-- 		,SUM(AB.本季度一级节点绿灯) AS 本季度一级节点绿灯
-- 		,SUM(AB.本季度一级节点黄灯) AS 本季度一级节点黄灯
-- 		,SUM(AB.本季度一级节点红灯) AS 本季度一级节点红灯
-- 		,SUM(AB.本季度二三级节点绿灯) AS 本季度二三级节点绿灯
-- 		,SUM(AB.本季度二三级节点黄灯) AS 本季度二三级节点黄灯
-- 		,SUM(AB.本季度二三级节点红灯) AS 本季度二三级节点红灯
		 FROM  (
--  11
									 
									 SELECT    
									/*完成情况*/
-- 									 ,NVL(B.本季度应完成,0) AS 本季度应完成
-- 									 ,NVL(B.本季度已完成,0) AS 本季度已完成
										B.PLANYEAR
										,B.PLANQUATOR
										,B.PLANMOTH
									 ,NVL(B.应完成,0) AS 应完成
									 ,NVL(B.已完成,0) AS 已完成
									 /*动态得分情况*/
									 ,NVL(B.动态得分,0) AS 动态得分
-- 									 ,NVL(B.本季度动态得分,0) AS 本季度动态得分
									 /*里程碑、一级节点完成情况*/
									 ,NVL(B.里程碑应完成,0) AS 里程碑应完成
									 ,NVL(B.里程碑已完成,0) AS 里程碑已完成
									 ,NVL(B.一级节点应完成,0) AS 一级节点应完成
									 ,NVL(B.一级节点已完成,0) AS 一级节点已完成
									 ,NVL(B.二级节点应完成,0) AS 二级节点应完成
									 ,NVL(B.二级节点已完成,0) AS 二级节点已完成
									 ,NVL(B.三级节点应完成,0) AS 三级节点应完成
									 ,NVL(B.三级节点已完成,0) AS 三级节点已完成
-- 									 ,NVL(B.本季度里程碑应完成,0) AS 本季度里程碑应完成
-- 									 ,NVL(B.本季度里程碑已完成,0) AS 本季度里程碑已完成
-- 									 ,NVL(B.本季度一级节点应完成,0) AS 本季度一级节点应完成
-- 									 ,NVL(B.本季度一级节点已完成,0) AS 本季度一级节点已完成
									 /*亮点情况*/
									 ,NVL(B.里程碑绿灯,0) AS 里程碑绿灯
									 ,NVL(B.里程碑黄灯,0) AS 里程碑黄灯
									 ,NVL(B.里程碑红灯,0) AS 里程碑红灯
									 ,NVL(B.一级节点绿灯,0) AS 一级节点绿灯
									 ,NVL(B.一级节点黄灯,0) AS 一级节点黄灯
									 ,NVL(B.一级节点红灯,0) AS 一级节点红灯
									 ,NVL(B.二级节点绿灯,0) AS 二级节点绿灯
									 ,NVL(B.二级节点黄灯,0) AS 二级节点黄灯
									 ,NVL(B.二级节点红灯,0) AS 二级节点红灯
									 ,NVL(B.三级节点绿灯,0) AS 三级节点绿灯
									 ,NVL(B.三级节点黄灯,0) AS 三级节点黄灯
									 ,NVL(B.三级节点红灯,0) AS 三级节点红灯

-- 									 ,NVL(B.本季度里程碑绿灯,0) AS 本季度里程碑绿灯
-- 									 ,NVL(B.本季度里程碑黄灯,0) AS 本季度里程碑黄灯
-- 									 ,NVL(B.本季度里程碑红灯,0) AS 本季度里程碑红灯
-- 									 ,NVL(B.本季度一级节点绿灯,0) AS 本季度一级节点绿灯
-- 									 ,NVL(B.本季度一级节点黄灯,0) AS 本季度一级节点黄灯
-- 									 ,NVL(B.本季度一级节点红灯,0) AS 本季度一级节点红灯
-- 									 ,NVL(B.本季度二三级节点绿灯,0) AS 本季度二三级节点绿灯
-- 									 ,NVL(B.本季度二三级节点黄灯,0) AS 本季度二三级节点黄灯
-- 									 ,NVL(B.本季度二三级节点红灯,0) AS 本季度二三级节点红灯
									 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID 
									 from   SYS_BUSINESS_UNIT A  LEFT JOIN 
									 ( 	 

									
									 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
									
								, TO_CHAR(A1.PLAN_END_DATE,'YYYY')	 AS  "PLANYEAR"
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
									 --完成规则
									 
							
										 

									 ------------------
									 /*任务*/
									 ------------------
									 ------
									, SUM(
										(CASE
											WHEN 
												TO_CHAR( A1.PLAN_END_DATE, 'YYYY-MM-DD' ) IS NOT NULL
									
											THEN		1 
											ELSE 0 
											END 
											) 
										) AS "应完成"
									,SUM( (CASE    	WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL  
							
									 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
										 THEN 		1	ELSE		0 END))   AS "已完成"

									,SUM(
									(CASE    
									--按时完成
											WHEN 
													TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
												
												 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )BETWEEN 0 AND 29 
											THEN 	A1.STANDARD_SCORE*1	
											--提前一个月完成
											WHEN 
													TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL 
													--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL='里程碑'      
											THEN 	A1.STANDARD_SCORE*1.2		
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
												 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) -TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL='一级节点'     
											THEN 	A1.STANDARD_SCORE*1.1		
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL 
										
												 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												 
													AND  (TRUNC( A1.PLAN_END_DATE, 'DD' ) - TRUNC( D.APPROVAL_TIME, 'DD' ) )>= 30   AND  A1.NODE_LEVEL IN ('二级节点' ,'三级节点')     
											THEN 	A1.STANDARD_SCORE*1.0	
									--延时完成
									--里程碑、一级节点3天
									--二三级节点5天
									--延时完成
										WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
									
												 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												 
												AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND   A1.NODE_LEVEL IN ('里程碑' ,'一级节点')     
										THEN 	A1.STANDARD_SCORE*0.6
										WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
								
												 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												 
												AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 3 AND A1.NODE_LEVEL IN ('二级节点' ,'三级节点')     
										THEN 	A1.STANDARD_SCORE*1.0
										WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
								
											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
												AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 4 AND 7 AND A1.NODE_LEVEL IN ('二级节点' ,'三级节点')     
										THEN 	A1.STANDARD_SCORE*0.6
									--红灯
										WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
							
											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
											 
											AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('里程碑' ,'一级节点')     
										THEN 	A1.STANDARD_SCORE*0
										WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
									
											 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
											 
											AND  ( TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC(A1.PLAN_END_DATE, 'DD' )  )>=8  AND  A1.NODE_LEVEL IN ('二级节点' ,'三级节点')     
										THEN 	A1.STANDARD_SCORE*0
									ELSE	0 END
									)
									)   AS "动态得分"

									 ------------------
									 /*-里程碑完成情况*/
									 ------------------
									,SUM((CASE  WHEN   	 A1. NODE_LEVEL='里程碑'  		 
						
															THEN 	1	ELSE		0 END))   AS "里程碑应完成"
									,SUM((CASE  WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL  
															AND A1. NODE_LEVEL='里程碑' 		 
													    THEN 	1	ELSE		0 END))   AS "里程碑已完成"
									 ------------------
									 /*-一级节点完成情况*/
									 ------------------
									,SUM((CASE   WHEN  	 A1. NODE_LEVEL='一级节点'  				
															  THEN 	1	ELSE		0 END))   AS "一级节点应完成"
									,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL 	
															AND A1. NODE_LEVEL='一级节点'  		
															     THEN 	1	ELSE		0 END))   AS "一级节点已完成"
									 ------------------
									 /*-二级节点完成情况*/
									 ------------------
									,SUM((CASE   WHEN  	 A1. NODE_LEVEL='二级节点'  				
															  THEN 	1	ELSE		0 END))   AS "二级节点应完成"
									,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL 	
															AND A1. NODE_LEVEL='二级节点'  		
															     THEN 	1	ELSE		0 END))   AS "二级节点已完成"	
										 ------------------
									 /*-三级节点完成情况*/
									 ------------------
									,SUM((CASE   WHEN  	 A1. NODE_LEVEL='三级节点'  				
															  THEN 	1	ELSE		0 END))   AS "三级节点应完成"
									,SUM((CASE   WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL 	
															AND A1. NODE_LEVEL='三年级节点'  		
															     THEN 	1	ELSE		0 END))   AS "三级节点已完成"																			 
									 
										------------------
									 /*-里程碑亮灯情况*/
									 ------------------
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
								
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 0 AND    A1.NODE_LEVEL IN ('里程碑')     
												THEN 1

											 ELSE  0  END ) AS  "里程碑绿灯"
												
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND    A1.NODE_LEVEL IN ('里程碑')     
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
									
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4  AND    A1.NODE_LEVEL IN ('里程碑')     
												THEN 1		
										

											 ELSE  0  END ) AS  "里程碑黄灯"
												
												
									,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('里程碑')     
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
										
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('里程碑')     
												THEN 1		
										

											 ELSE  0  END ) AS  "里程碑红灯"
												
												
									 
										------------------
									 /*一级节点亮灯情况*/
									 ------------------
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
									
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 0  AND    A1.NODE_LEVEL IN ('一级节点')     
												THEN 1

											 ELSE  0  END ) AS  "一级节点绿灯"
												
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
								
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4 AND    A1.NODE_LEVEL IN ('一级节点')     
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
												 
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 1 AND 4  AND    A1.NODE_LEVEL IN ('一级节点')     
												THEN 1		
										

											 ELSE  0  END ) AS  "一级节点黄灯"
												
												
									,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('一级节点')     
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
												
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=5 AND    A1.NODE_LEVEL IN ('一级节点')     
												THEN 1		
										

											 ELSE  0  END ) AS  "一级节点红灯"
												
												
									 

										------------------
									 /*二级节点亮灯情况*/
									 ------------------
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
							
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 2 AND     A1.NODE_LEVEL IN ('二级节点')     
												THEN 1

											 ELSE  0  END ) AS  "二级节点绿灯"
												
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7 AND    A1.NODE_LEVEL IN ('二级节点')      
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
						
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7  AND    A1.NODE_LEVEL IN  ('二级节点')     
												THEN 1		
										

											 ELSE  0  END ) AS  "二级节点黄灯"
												
												
									,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('二级节点')    
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('二级节点')     
												THEN 1		
										

										ELSE  0  END ) AS  "二级节点红灯"

										------------------
									 /*三级节点亮灯情况*/
									 ------------------
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
							
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  <= 2 AND     A1.NODE_LEVEL IN ('三级节点')     
												THEN 1

											 ELSE  0  END ) AS  "三级节点绿灯"
												
									 ,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7 AND    A1.NODE_LEVEL IN ('三级节点')      
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
						
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  BETWEEN 3 AND 7  AND    A1.NODE_LEVEL IN  ('三级节点')     
												THEN 1		
										

											 ELSE  0  END ) AS  "三级节点黄灯"
												
												
									,SUM(CASE  
												WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( D.APPROVAL_TIME, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('三级节点')    
												THEN 1
											WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS  NULL
											
														--WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
													AND  (TRUNC( SYSDATE, 'DD' )-TRUNC( A1.PLAN_END_DATE, 'DD' )  )  >=8 AND    A1.NODE_LEVEL IN  ('三级节点')     
												THEN 1		
										

										ELSE  0  END ) AS  "三级节点红灯"
										
									FROM 	
									POM_PROJ_PLAN A 
									INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
									INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
									INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID 
									LEFT JOIN POM_NODE_FEEDBACK D ON D.FEEDBACK_NODE_ID=A1.ID AND  FEEDBACK_TYPE='完成反馈' AND  D.APPROVAL_STATUS='已审核'
									WHERE  A.PLAN_TYPE='项目主项计划' AND  A.APPROVAL_STATUS='已审核'
									GROUP BY B1.UNIT_ID	, TO_CHAR(A1.PLAN_END_DATE,'YYYY')
									, CASE WHEN CASE 	WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN	TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) 
												END > 12 THEN	1 ELSE  CASE		WHEN TO_CHAR( PLAN_END_DATE, 'DD' ) > 25 THEN		TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) + 1 ELSE TO_NUMBER( TO_CHAR( PLAN_END_DATE, 'MM' ) ) 
									END 	END 
									, CASE WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '12-26'  AND '03-25'  THEN 1 	 WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '03-26'  AND '06-25'  THEN 2 
									 WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '06-26'  AND '09-25'  THEN 3 		 WHEN    TO_CHAR( PLAN_END_DATE ,'MM-DD') BETWEEN '09-26'  AND '12-25'  THEN 4  END
	
										)  B ON  A.ID=B.UNIT_ID
										WHERE NVL(B.NODESUM,0)>0
									CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID  ,AB.PLANYEAR	,AB.PLANQUATOR,AB.PLANMOTH
)B  ON  A.ID=B.ID 
WHERE  A.ORG_TYPE=0  --  AND  A.COMPANY_TYPE='5' AND  A.PARENT_ID='003200000000000000000000000000'
--
;
--------------------------------------------------------
--  DDL for View V_POM_PJQUARTERPLAN_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJQUARTERPLAN_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='关键节点计划' AND  A.APPROVAL_STATUS='已审核'
AND A1. IS_DISABLE=0
 --判断季度
 AND A1.PLAN_END_DATE BETWEEN
 (	SELECT   ADD_MONTHS(M_END,-1)+1  FROM v_pom_month_quarter_year )  AND
 (	SELECT M_END  FROM v_pom_month_quarter_year)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核' 

 AND A1. IS_DISABLE=0

 --判断季度
 AND A1.PLAN_END_DATE BETWEEN
 (	SELECT   ADD_MONTHS(M_END,-1)+1  FROM v_pom_month_quarter_year )  AND
 (	SELECT M_END  FROM v_pom_month_quarter_year) 
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID ,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核'
  AND A1. IS_DISABLE=0

 --判断季度
 AND A1.PLAN_END_DATE BETWEEN
 (	SELECT   ADD_MONTHS(M_END,-1)+1  FROM v_pom_month_quarter_year )  AND
 (	SELECT M_END  FROM v_pom_month_quarter_year)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'    AND  A.APPROVAL_STATUS='已审核'
 AND A1. IS_DISABLE=0
    --判断季度
 AND A1.PLAN_END_DATE BETWEEN
 (	SELECT   ADD_MONTHS(M_END,-1)+1  FROM v_pom_month_quarter_year )  AND
 (	SELECT M_END  FROM v_pom_month_quarter_year)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_PJYEARPLAN_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PJYEARPLAN_STATISTICS" ("RANK", "LEVEL_RANK", "ID", "PARENT_ID", "ORG_NAME", "COMPANY_ID", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "ISDELAY", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE", "CTYPE", "STAGEID") AS SELECT
	row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,LEVEL_RANK,
	A.ID,A.PARENT_ID,A.ORG_NAME,'' AS COMPANY_ID
	,NVL(B.NODESUM,0) AS NODESUM
	,nvl(ISFINISH,0) AS  ISFINISHTOTAL
	,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
	,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
	,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
		,NVL(ISDELAY,0) AS ISDELAY
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
	,ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
	,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
	,'TYPE_ORG' AS CTYPE
    ,'' as "STAGEID"
FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.ISDELAY) AS ISDELAY,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (
--  11

 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
  ,NVL(ISDELAY,0) AS ISDELAY
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"

FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
 INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
WHERE  A.PLAN_TYPE='关键节点计划' AND  A.APPROVAL_STATUS='已审核'
 AND A1. IS_DISABLE=0
	 --判断本年
 -- A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID
	)  B ON  A.ID=B.UNIT_ID
	WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
WHERE  A.ORG_TYPE=0  AND     NVL(B.NODESUM,0) >0

UNION ALL
--顶级项目汇总有分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,b3."STAGEID" AS "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID ,A.COMPANY_ID ,C1.PROJECT_ID AS ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核'
  AND A1. IS_DISABLE=0
 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME,p2.id as "STAGEID" FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID,p2.ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0 AND  B3.STAGE_NAME    LIKE '%无分期%'


		UNION ALL
--顶级项目汇总无分期
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,4
,B2.ID,B2.PARENT_ID,B2.PROJECT_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
  ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,/*'TYPE_PROJTOP' AS CTYPE*/CASE WHEN B3.STAGE_NAME LIKE '%无分期%' THEN 'TYPE_PROJLAST' else 'TYPE_PROJTOP' end as CTYPE
,'' as "STAGEID"
FROM(
 SELECT  B1.UNIT_ID AS PARENT_ID  ,A.COMPANY_ID,B1.ID,B1.PROJECT_NAME ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,C1.PROJECT_ID
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'AND  A.APPROVAL_STATUS='已审核'
  AND A1. IS_DISABLE=0
	 --判断本年

 AND  A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
		GROUP BY B1.UNIT_ID,A.COMPANY_ID,B1.ID,PROJECT_NAME ,C1.PROJECT_ID	) B2
		LEFT JOIN (SELECT P2.PROJECT_ID,TO_CHAR(wm_concat(P2.STAGE_NAME)) AS STAGE_NAME FROM SYS_PROJECT P1 LEFT JOIN SYS_PROJECT_STAGE P2 ON P1.ID = P2.PROJECT_ID GROUP BY P2.PROJECT_ID) B3 ON B2.PROJECT_ID = B3.PROJECT_ID
		where        NVL(B2.NODESUM,0)>0  AND  B3.STAGE_NAME not  LIKE '%无分期%'


		----分期汇总

UNION ALL
SELECT
 row_number() over( PARTITION  BY B2.PARENT_ID  order by ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) desc) as rank,5
,B2.ID,B2.PARENT_ID,B2.PROJSTAGE_NAME,COMPANY_ID
 ,NVL(B2.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
 ,NVL(ISDELAY,0) AS ISDELAY
, ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B2.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B2.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"
,'TYPE_PROJLAST' AS CTYPE
,B2."STAGEID"
FROM(
 SELECT  C1.PROJECT_ID AS PARENT_ID,A.COMPANY_ID  ,C1.ID,B1.PROJECT_NAME||'_'|| C1.STAGE_NAME AS  PROJSTAGE_NAME ,COUNT(A1.ID) AS "NODESUM"
  --完成规则
,SUM( (CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS   NULL AND  TRUNC(A1.PLAN_END_DATE)< TRUNC(SYSDATE)  THEN 		1	ELSE		0 END))   AS "ISDELAY"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL  THEN 		1	ELSE		0 END))   AS "ISFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <=TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ONTIMEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  <TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "ADVANCEFINISH"
,SUM((CASE    	WHEN TRUNC( A1.ACTUAL_END_DATE) IS NOT NULL AND TRUNC( A1.ACTUAL_END_DATE)  >TRUNC( PLAN_END_DATE)       THEN 		1	ELSE		0 END))   AS "DELAYFINISH"
,C1.ID as "STAGEID"

 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID
  INNER JOIN SYS_PROJECT_STAGE C1 ON A.PROJ_ID=C1.ID
 INNER  JOIN    SYS_PROJECT B1  ON  C1.PROJECT_ID=B1.ID
 WHERE  A.PLAN_TYPE='关键节点计划'    AND  A.APPROVAL_STATUS='已审核'
  AND A1. IS_DISABLE=0
	 --判断本年

 AND A1.PLAN_END_DATE BETWEEN (SELECT TO_DATE( "铁建_本年"-1||'-12'||'-26','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH) AND (SELECT TO_DATE( "铁建_本年"||'-12'||'-25','YYYY-MM-DD') FROM V_POM_GETEXAMINE_MOTH)
		GROUP BY C1.PROJECT_ID,C1.ID,A.COMPANY_ID,PROJECT_NAME, STAGE_NAME	) B2		where        NVL(B2.NODESUM,0)>0 AND B2.PROJSTAGE_NAME NOT LIKE '%无分期%'
;
--------------------------------------------------------
--  DDL for View V_POM_PROJ_MONITOR_NODE_LIST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PROJ_MONITOR_NODE_LIST" ("PROJ_ID", "PROJ_NAME", "PROJ_PLAN_ID", "NODE_ID", "PLAN_ID", "PLAN_TYPE", "ORIGINAL_NODE_ID", "WARNING_STATUS", "NODE_CODE", "NODE_NAME", "NODE_LEVEL", "DUTY_DEPARTMENT", "DUTY_MANS", "FINISH_STATUS", "STANDARD_SCORE", "PLAN_START_DATE", "PLAN_END_DATE", "ACTUAL_START_DATE", "ACTUAL_END_DATE", "ESTIMATE_END_DATE", "PROCESS_FEED_BACK_CON", "FINISH_FEED_BACK_CON", "OVERDUE_FEED_BACK_CON", "NODE_FLAG", "ESTIMATE_BEYOND_NODE_FLAG", "COMPLETION_STANDARD", "COMPLETION_RESULTS_REMARK") AS SELECT 

NODEINFO.PROJ_ID
,NODEINFO.PROJ_NAME
,NODEINFO.PROJ_PLAN_ID
,NODEINFO.NODE_ID
,NODEINFO.PLAN_ID
,NODEINFO.PLAN_TYPE
,NODEINFO.ORIGINAL_NODE_ID
,NODEINFO.WARNING_STATUS
,NODEINFO.NODE_CODE
,NODEINFO.NODE_NAME
,NODEINFO.NODE_LEVEL
,NODEINFO.DUTY_DEPARTMENT
,DUTY_MANS 
,NODEINFO.FINISH_STATUS
,NODEINFO.STANDARD_SCORE
,NODEINFO.PLAN_START_DATE
,NODEINFO.PLAN_END_DATE
,NODEINFO.ACTUAL_START_DATE
,NODEINFO.ACTUAL_END_DATE
,NODEINFO.ESTIMATE_END_DATE
,NODEINFO.PROCESS_FEED_BACK_CON
,NODEINFO.FINISH_FEED_BACK_CON
,NODEINFO.OVERDUE_FEED_BACK_CON
,NODEINFO.NODE_FLAG
,NODEINFO.ESTIMATE_BEYOND_NODE_FLAG
,NODEINFO.COMPLETION_STANDARD
,NODEINFO.COMPLETION_RESULTS_REMARK

FROM (
SELECT A.PROJ_ID, A.PROJ_NAME, B.PROJ_PLAN_ID, B.ID AS NODE_ID /*任务ID*/,
			 A.ID AS PLAN_ID /*计划ID */, A.PLAN_TYPE /*计划类别*/, B.ORIGINAL_NODE_ID
			 /*节点原始ID*/, 
			  
				CASE WHEN NODE_LEVEL  in ('里程碑','一级节点') then  
				case 
 --未到期不亮灯
 WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''
 --到期当天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
 then '绿灯'
  --到期1-5天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
 then '绿灯'
 --到期未反馈黄灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE)) >0
 THEN  '黄灯'
  --到期超过5天未反馈红灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) >5) THEN  '红灯'
 ELSE '红灯' END
 
 else  
 
 case 
 --未到期不亮灯
 WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''
 --到期3天内完成反馈两天内
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 2
 then '绿灯'
  --到期3-8天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 3 and 8
 then '黄灯'
 --到期8天内未反馈黄灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) BETWEEN 0 AND 8) 
 THEN   '黄灯'
  --到期超过8天未反馈红灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) > 8) THEN   '红灯'
 ELSE  '红灯' END
 end
 
 
 
			 


			 AS WARNING_STATUS, B.NODE_CODE AS NODE_CODE,
			 B.NODE_NAME AS NODE_NAME, B.NODE_LEVEL, B.DUTY_DEPARTMENT,
 
TO_CHAR(D.CHARGE_PERSON)
   AS DUTY_MANS,
			 CASE
					 WHEN
								B.ACTUAL_END_DATE IS NOT NULL THEN
						'已完成'
					 ELSE
						'未完成'
			 END AS FINISH_STATUS, B.STANDARD_SCORE, B.PLAN_START_DATE,
			 B.PLAN_END_DATE, B.ACTUAL_START_DATE AS ACTUAL_START_DATE,
			 B.ACTUAL_END_DATE, B.ESTIMATE_END_DATE AS ESTIMATE_END_DATE,
			 0 AS PROCESS_FEED_BACK_CON, 0 AS FINISH_FEED_BACK_CON,
			 0 AS OVERDUE_FEED_BACK_CON,
			 CASE
					 WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
						'已完成'
					 WHEN (NVL(B.ACTUAL_END_DATE, SYSDATE) - B.PLAN_END_DATE) > 0 AND
								B.ACTUAL_END_DATE IS NULL THEN
						'超期未完成'
					 ELSE
						'正常'
			 END AS NODE_FLAG,
			 CASE
					 WHEN B.ESTIMATE_END_DATE > B.PLAN_END_DATE AND
								B.ACTUAL_END_DATE IS NULL THEN
						'是'
					 ELSE
						'否'
			 END AS ESTIMATE_BEYOND_NODE_FLAG,
			
			 B.COMPLETION_STANDARD, B.COMPLETION_RESULTS_REMARK
FROM   POM_PROJ_PLAN A
INNER  JOIN POM_PROJ_PLAN_NODE B
ON     A.ID = B.PROJ_PLAN_ID

LEFT   JOIN (SELECT M.NODE_ID,listagg(M.CHARGE_PERSON,',') WITHIN  GROUP (ORDER BY CHARGE_PERSON) 

AS CHARGE_PERSON
						 FROM   POM_NODE_CHARGE_PERSON M
						 GROUP  BY M.NODE_ID) D
ON     D.NODE_ID = B.ID

LEFT   JOIN (SELECT FEEDBACK_NODE_ORIGINAL_ID,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '0' THEN
														 1
														ELSE
														 0
												END) AS PROCESS_FEED_BACK_CON,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '1' THEN
														 1
														ELSE
														 0
												END) AS FINISH_FEED_BACK_CON,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '2' THEN
														 1
														ELSE
														 0
												END) AS OVERDUE_FEED_BACK_CON
						 FROM   POM_NODE_FEEDBACK
						 GROUP  BY FEEDBACK_NODE_ORIGINAL_ID) E
ON     E.FEEDBACK_NODE_ORIGINAL_ID = B.ORIGINAL_NODE_ID
WHERE  A.APPROVAL_STATUS = '已审核' AND
			 A.PLAN_TYPE = '项目主项计划' AND
			 B.IS_DISABLE <> 1
			-- AND  B.id='1e0d1efe-dcc2-4232-9362-5cc4c324c4ab'
	) NODEINFO
-- 	WHERE  TRUNC( PLAN_END_DATE)-TRUNC(SYSDATE)<0 --超期 
-- 	WHERE  TRUNC( ESTIMATE_END_DATE)-TRUNC(SYSDATE)<0 --预计超期
;
--------------------------------------------------------
--  DDL for View V_POM_PROJ_MONITOR_SUMMARYLIST
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_PROJ_MONITOR_SUMMARYLIST" ("PROJ_ID", "PROJ_NAME", "PROJ_PLAN_ID", "NODE_ID", "PLAN_ID", "PLAN_TYPE", "ORIGINAL_NODE_ID", "WARNING_STATUS", "NODE_CODE", "NODE_NAME", "NODE_LEVEL", "DUTY_DEPARTMENT", "DUTY_DEPARTMENT_ID", "DUTY_MANS", "FINISH_STATUS", "STANDARD_SCORE", "PLAN_START_DATE", "PLAN_END_DATE", "ACTUAL_START_DATE", "ACTUAL_END_DATE", "ESTIMATE_END_DATE", "PROCESS_FEED_BACK_CON", "FINISH_FEED_BACK_CON", "OVERDUE_FEED_BACK_CON", "NODE_FLAG", "ESTIMATE_BEYOND_NODE_FLAG", "COMPLETION_STANDARD", "COMPLETION_RESULTS_REMARK") AS SELECT 

NODEINFO.PROJ_ID
,NODEINFO.PROJ_NAME
,NODEINFO.PROJ_PLAN_ID
,NODEINFO.NODE_ID
,NODEINFO.PLAN_ID
,NODEINFO.PLAN_TYPE
,NODEINFO.ORIGINAL_NODE_ID
,NODEINFO.WARNING_STATUS
,NODEINFO.NODE_CODE
,NODEINFO.NODE_NAME
,NODEINFO.NODE_LEVEL
,NODEINFO.DUTY_DEPARTMENT
,NODEINFO.DUTY_DEPARTMENT_ID
,DUTY_MANS 
,NODEINFO.FINISH_STATUS
,NODEINFO.STANDARD_SCORE
,NODEINFO.PLAN_START_DATE
,NODEINFO.PLAN_END_DATE
,NODEINFO.ACTUAL_START_DATE
,NODEINFO.ACTUAL_END_DATE
,NODEINFO.ESTIMATE_END_DATE
,NODEINFO.PROCESS_FEED_BACK_CON
,NODEINFO.FINISH_FEED_BACK_CON
,NODEINFO.OVERDUE_FEED_BACK_CON
,NODEINFO.NODE_FLAG
,NODEINFO.ESTIMATE_BEYOND_NODE_FLAG
,NODEINFO.COMPLETION_STANDARD
,NODEINFO.COMPLETION_RESULTS_REMARK

FROM (
SELECT A.PROJ_ID, A.PROJ_NAME, B.PROJ_PLAN_ID, B.ID AS NODE_ID /*任务ID*/,
			 A.ID AS PLAN_ID /*计划ID */, A.PLAN_TYPE /*计划类别*/, B.ORIGINAL_NODE_ID
			 /*节点原始ID*/, 

				CASE WHEN NODE_LEVEL  in ('里程碑','一级节点') then  
				case 
 --未到期不亮灯
 WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''
 --到期当天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
 then '<p style=" font-size: 40px;color: green;margin-bottom: 0px;">●</p>'
  --到期1-5天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
 then '<p style=" font-size: 40px;color: green;margin-bottom: 0px;">●</p>'
 --到期未反馈黄灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE)) >0
 THEN  '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">●</p>'
  --到期超过5天未反馈红灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) >5) THEN  '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>'
 ELSE '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>' END

 else  

 case 
 --未到期不亮灯
 WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<0  THEN ''
 --到期3天内完成反馈两天内
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 2
 then '<p style=" font-size: 40px;color: green;margin-bottom: 0px;">●</p>'
  --到期3-8天内完成反馈
 when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 3 and 8
 then '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">●</p>'
 --到期8天内未反馈黄灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) BETWEEN 0 AND 8) 
 THEN   '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">●</p>'
  --到期超过8天未反馈红灯 
 WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) > 8) THEN   '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>'
 ELSE '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>' END
 end






			 AS WARNING_STATUS, B.NODE_CODE AS NODE_CODE,
			 B.NODE_NAME AS NODE_NAME, B.NODE_LEVEL, B.DUTY_DEPARTMENT,B.DUTY_DEPARTMENT_ID,

TO_CHAR(D.CHARGE_PERSON)
   AS DUTY_MANS,
			 CASE
					 WHEN
								B.ACTUAL_END_DATE IS NOT NULL THEN
						'已完成'
					 ELSE
						'未完成'
			 END AS FINISH_STATUS, B.STANDARD_SCORE, B.PLAN_START_DATE,
			 B.PLAN_END_DATE, B.ACTUAL_START_DATE AS ACTUAL_START_DATE,
			 B.ACTUAL_END_DATE, B.ESTIMATE_END_DATE AS ESTIMATE_END_DATE,
			 0 AS PROCESS_FEED_BACK_CON, 0 AS FINISH_FEED_BACK_CON,
			 0 AS OVERDUE_FEED_BACK_CON,
			 CASE
					 WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
						'已完成'
					 WHEN (NVL(B.ACTUAL_END_DATE, SYSDATE) - B.PLAN_END_DATE) > 0 AND
								B.ACTUAL_END_DATE IS NULL THEN
						'超期未完成'
					 ELSE
						'正常'
			 END AS NODE_FLAG,
			 CASE
					 WHEN B.ESTIMATE_END_DATE > B.PLAN_END_DATE AND
								B.ACTUAL_END_DATE IS NULL THEN
						'是'
					 ELSE
						'否'
			 END AS ESTIMATE_BEYOND_NODE_FLAG,

			 B.COMPLETION_STANDARD, B.COMPLETION_RESULTS_REMARK
FROM   POM_PROJ_PLAN A
INNER  JOIN POM_PROJ_PLAN_NODE B
ON     A.ID = B.PROJ_PLAN_ID

LEFT   JOIN (SELECT M.NODE_ID,listagg(M.CHARGE_PERSON,',') WITHIN  GROUP (ORDER BY CHARGE_PERSON) 

AS CHARGE_PERSON
						 FROM   POM_NODE_CHARGE_PERSON M
						 GROUP  BY M.NODE_ID) D
ON     D.NODE_ID = B.ID

LEFT   JOIN (SELECT FEEDBACK_NODE_ORIGINAL_ID,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '0' THEN
														 1
														ELSE
														 0
												END) AS PROCESS_FEED_BACK_CON,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '1' THEN
														 1
														ELSE
														 0
												END) AS FINISH_FEED_BACK_CON,
										SUM(CASE
														WHEN FEEDBACK_TYPE = '2' THEN
														 1
														ELSE
														 0
												END) AS OVERDUE_FEED_BACK_CON
						 FROM   POM_NODE_FEEDBACK
						 GROUP  BY FEEDBACK_NODE_ORIGINAL_ID) E
ON     E.FEEDBACK_NODE_ORIGINAL_ID = B.ORIGINAL_NODE_ID
WHERE  A.APPROVAL_STATUS = '已审核' AND
			 A.PLAN_TYPE = '项目主项计划' AND
			 B.IS_DISABLE <> 1
	) NODEINFO
;
--------------------------------------------------------
--  DDL for View V_POM_ROGPROJPLAN_STATISTICS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_POM_ROGPROJPLAN_STATISTICS" ("RANK", "ID", "PARENT_ID", "ORG_NAME", "NODESUM", "ISFINISHTOTAL", "ONTIMEFINISHTOTAL", "DELAYFINISHTOTAL", "ADVANCEFINISHTOTAL", "FINLISHRATE", "DELAYFINISHRATE", "ADVANCEFINISHRATE") AS SELECT
  row_number() over( PARTITION  BY A.PARENT_ID  order by ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) desc) as rank ,
 A.ID,A.PARENT_ID,A.ORG_NAME
 ,NVL(B.NODESUM,0) AS NODESUM
 ,nvl(ISFINISH,0) AS  ISFINISHTOTAL
 ,NVL(ONTIMEFINISH,0)AS ONTIMEFINISHTOTAL
 ,NVL(DELAYFINISH,0) AS DELAYFINISHTOTAL
 ,NVL(ADVANCEFINISH,0) AS ADVANCEFINISHTOTAL
, ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ISFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100,2) AS  "FINLISHRATE"
, ROUND(CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(DELAYFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END *100 ,2)AS  "DELAYFINISHRATE"
,ROUND( CASE WHEN NVL(B.NODESUM,0)>0 THEN nvl(ADVANCEFINISH,0)/NVL(B.NODESUM,0) ELSE 0 END*100,2) AS  "ADVANCEFINISHRATE"

FROM SYS_BUSINESS_UNIT A LEFT JOIN  (
 SELECT AB.ID,AB.PARENT_ID,SUM(AB.NODESUM) AS NODESUM,SUM(AB.ISFINISH) AS ISFINISH,SUM(AB.ONTIMEFINISH) AS ONTIMEFINISH,SUM(AB.DELAYFINISH) AS DELAYFINISH,SUM(AB.ADVANCEFINISH) AS ADVANCEFINISH from  (


 SELECT    NVL(B.NODESUM,0) AS NODESUM
 ,NVL(B.ISFINISH,0) AS ISFINISH
 ,NVL(B.ONTIMEFINISH,0) AS ONTIMEFINISH
 ,NVL(B.DELAYFINISH,0) AS DELAYFINISH,ORG_NAME
 ,NVL(ADVANCEFINISH,0) AS AdvanceFINISH
 ,ORG_NAME
 ,CONNECT_BY_ROOT ID AS  ID ,CONNECT_BY_ROOT PARENT_ID  AS  PARENT_ID
 from   SYS_BUSINESS_UNIT A  LEFT JOIN
 (
 SELECT  B1.UNIT_ID ,COUNT(A1.ID) AS "NODESUM"
 --完成规则
,SUM( (CASE      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL  THEN     1  ELSE    0 END))   AS "ISFINISH"
,SUM((CASE      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD')  <=TO_CHAR( PLAN_END_DATE,'YYYY-MM-DD')       THEN     1  ELSE    0 END))   AS "ONTIMEFINISH"
,SUM((CASE      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD')  <TO_CHAR( PLAN_END_DATE,'YYYY-MM-DD')       THEN     1  ELSE    0 END))   AS "ADVANCEFINISH"
,SUM((CASE      WHEN TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD') IS NOT NULL AND TO_CHAR( A1.ACTUAL_END_DATE,'YYYY-MM-DD')  >TO_CHAR( PLAN_END_DATE,'YYYY-MM-DD')       THEN     1  ELSE    0 END))   AS "DELAYFINISH"


 FROM
 POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE A1 ON A.ID=A1.PROJ_PLAN_ID

 INNER  JOIN    SYS_PROJECT B1  ON  A.PROJ_ID=B1.ID
 --WHERE  B1.UNIT_ID='1b922b32-928c-44a7-85d7-ee12b74f97e0'
    GROUP BY B1.UNIT_ID
  )  B ON  A.ID=B.UNIT_ID
  WHERE NVL(B.NODESUM,0)>0
CONNECT  by PRIOR   A.ID= A.PARENT_ID
) AB
GROUP BY AB.ID,AB.PARENT_ID
)B  ON  A.ID=B.ID
;
--------------------------------------------------------
--  DDL for View V_SYS_AREA_COMPANY_PROJ_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_AREA_COMPANY_PROJ_TREE" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "ISCOMPANY", "ORDERCODE", "FULLNAME") AS select orgId,orgName,orgType,parentId,isCompany,orderCode,fullName from
(
select ID as orgId,STAGE_NAME as orgName,'11' as orgType,PROJECT_ID as parentId,'0' as isCompany,'' as orderCode,STAGE_FULL_NAME as fullName
from SYS_PROJECT_STAGE
UNION
select ID as orgId,PROJECT_NAME as orgName,'10' as orgType,UNIT_ID as parentId,'0' as isCompany,'' as orderCode,PROJECT_NAME as fullName
from SYS_PROJECT
UNION
select ID as orgId,ORG_NAME as orgName,'0' as orgType,PARENT_ID as parentId,'1' as isCompany,ORDER_CODE as orderCode,ORG_NAME  as fullName
from SYS_BUSINESS_UNIT where ORG_TYPE = 0 and COMPANY_TYPE = '5'
) t
;
--------------------------------------------------------
--  DDL for View V_SYS_DEPARTMENT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_DEPARTMENT" ("DEPARTMENTID", "DEPARTMENTNAME", "ORGTYPE", "COMPANYID", "COMPANYNAME", "ORDERCODE") AS select a.ID as departmentId ,a.ORG_NAME as departmentName,a.ORG_TYPE as orgType,a.PARENT_ID as companyId,
b.ORG_NAME as companyName,a.ORDER_CODE as orderCode from SYS_BUSINESS_UNIT  a
left join SYS_BUSINESS_UNIT  b on a.PARENT_ID = b.ID
where a.ORG_TYPE = 1
;
--------------------------------------------------------
--  DDL for View V_SYS_ORG_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_ORG_TREE" ("ORGID", "ORGNAME", "PARENTID", "ORGTYPE", "ORDERCODE", "ISCOMPANY", "ORDERHIERARCHYCODE") AS SELECT orgId,orgName,parentId,orgType,orderCode,isCompany,orderHierarchyCode from (
SELECT id as orgId ,ORG_NAME as orgName,PARENT_ID as parentId,ORG_TYPE as orgType,ORDER_CODE as orderCode,IS_COMPANY as isCompany,ORDER_HIERARCHY_CODE as orderHierarchyCode from SYS_BUSINESS_UNIT
union
SELECT ID as orgId, STATION_NAME  as orgName ,org_id as parentId, '2' as orgType,'1' as orderCode,0 as isCompany,'001' as orderHierarchyCode from SYS_STATION
) t
;
--------------------------------------------------------
--  DDL for View V_SYS_PROJECT
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_PROJECT" ("ORG_ID", "ORG_NAME", "COMPANY_NAME", "ORG_TYPE", "PARENT_ID", "CITY_NAME", "PROJ_CODE", "IS_END", "FULL_NAME", "SN", "COMPANY_ID", "PROJECT_ID") AS SELECT
        a.id              AS org_id,
        stage_name        AS org_name,
        c.org_name as company_name,
        '11' AS org_type,
        project_id        AS parent_id,
        b.city_name       AS city_name,
        '' AS proj_code,
        1 AS is_end,
        stage_full_name   AS full_name,
        c.order_hierarchy_code
        || '.'
        || replace(lpad(b.sn, 3), ' ', '0')
        || '.'
        || replace(lpad(a.sn, 3), ' ', '0') AS sn,
        b.unit_id         AS company_id,
        b.id              AS project_id
    FROM
        sys_project_stage   a
        INNER JOIN sys_project         b ON a.project_id = b.id
        INNER JOIN sys_business_unit   c ON b.unit_id = c.id
        where stage_name<>'无分期'
    UNION
    SELECT
        a.id           AS orgid,
        project_name   AS orgname,
        c.org_name as company_name,
        '10' AS orgtype,
        unit_id        AS parentid,
        city_name      AS cityname,
        project_code   AS projcode,
        CASE
            WHEN b.project_id IS NULL THEN
                1
            ELSE
                0
        END AS isend,
        project_name   AS fullname,
        c.order_hierarchy_code
        || '.'
        || replace(lpad(a.sn, 3), ' ', '0'),
        a.unit_id      AS companyid,
        a.id           AS project_id
    FROM
        sys_project a
        LEFT JOIN (
            SELECT DISTINCT
                project_id
            FROM
                sys_project_stage
        ) b ON a.id = b.project_id
        INNER JOIN sys_business_unit c ON a.unit_id = c.id
    UNION
    SELECT
        a.id,
        org_name,
        a.org_name as company_name,
        org_type,
        parent_id,
        '' AS city_name,
        '' AS proj_code,
        CASE
            WHEN b.id IS NULL THEN
                1
            ELSE
                0
        END AS isend,
        org_name               AS full_name,
        order_hierarchy_code   AS sn,
        a.id,
        ''
    FROM
        sys_business_unit a
        LEFT JOIN (
            SELECT DISTINCT
                ( unit_id ) AS id
            FROM
                sys_project
        ) b ON a.id = b.id
    WHERE
        is_company = 1
;
--------------------------------------------------------
--  DDL for View V_SYS_PROJECT_STAGE_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_PROJECT_STAGE_TREE" ("ORG_ID", "ORG_NAME", "ORG_TYPE", "PARENT_ID", "CITY_NAME", "PROJ_CODE", "IS_END", "FULL_NAME", "SN", "COMPANY_ID", "PROJECT_ID") AS SELECT a.id                                    AS org_id,
        stage_name                              AS org_name,
        '11'                                    AS org_type,
        project_id                              AS parent_id,
        b.city_name                             AS city_name,
        ''                                      AS proj_code,
        1                                       AS is_end,
        stage_full_name                         AS full_name,
        c.order_hierarchy_code
            || '.'
            || replace(lpad(b.sn, 3), ' ', '0')
            || '.'
            || replace(lpad(a.sn, 3), ' ', '0') AS sn,
        b.unit_id                               AS company_id,
        b.id                                    AS project_id
 FROM sys_project_stage a
          INNER JOIN sys_project b ON a.project_id = b.id
          INNER JOIN sys_business_unit c ON b.unit_id = c.id
 UNION
 SELECT a.id         AS orgid,
        project_name AS orgname,
        '10'         AS orgtype,
        unit_id      AS parentid,
        city_name    AS cityname,
        project_code AS projcode,
        CASE
            WHEN b.project_id IS NULL THEN
                1
            ELSE
                0
            END      AS isend,
        project_name AS fullname,
        c.order_hierarchy_code
            || '.'
            || replace(lpad(a.sn, 3), ' ', '0'),
        a.unit_id    AS companyid,
        a.id         AS project_id
 FROM sys_project a
          LEFT JOIN (
     SELECT DISTINCT project_id
     FROM sys_project_stage
 ) b ON a.id = b.project_id
          INNER JOIN sys_business_unit c ON a.unit_id = c.id
 UNION
 SELECT a.id,
        org_name,
        org_type,
        parent_id,
        ''                   AS city_name,
        ''                   AS proj_code,
        CASE
            WHEN b.id IS NULL THEN
                1
            ELSE
                0
            END              AS isend,
        org_name             AS full_name,
        order_hierarchy_code AS sn,
        a.id,
        ''
 FROM sys_business_unit a
          LEFT JOIN (
     SELECT DISTINCT (unit_id) AS id
     FROM sys_project
 ) b ON a.id = b.id
 WHERE is_company = 1
;
--------------------------------------------------------
--  DDL for View V_SYS_PROJECT_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_PROJECT_TREE" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "CITYNAME", "PROJCODE", "FULLNAME") AS SELECT ORGID, ORGNAME, ORGTYPE, PARENTID, CITYNAME, PROJCODE, FULLNAME
FROM   (SELECT ID AS ORGID, STAGE_NAME AS ORGNAME, '11' AS ORGTYPE,
								PROJECT_ID AS PARENTID, '' AS CITYNAME, '' AS PROJCODE,
								STAGE_FULL_NAME AS FULLNAME
				 FROM   SYS_PROJECT_STAGE
				 UNION
				 SELECT ID AS ORGID, PROJECT_NAME AS ORGNAME, '10' AS ORGTYPE,
								UNIT_ID AS PARENTID, CITY_NAME AS CITYNAME,
								PROJECT_CODE AS PROJCODE, PROJECT_NAME AS FULLNAME
				 FROM   SYS_PROJECT
				 UNION
				 SELECT ID AS ORGID, ORG_NAME AS ORGNAME, '0' AS ORGTYPE,
								PARENT_ID AS PARENTID, '' AS CITYNAME, '' AS PROJCODE,
								ORG_NAME AS FULLNAME
				 FROM   SYS_BUSINESS_UNIT
				 WHERE  ORG_TYPE = 0) T
ORDER  BY PROJCODE

;
--------------------------------------------------------
--  DDL for View V_SYS_PROJECTS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_PROJECTS" ("ORGID", "ORGNAME", "ORGTYPE", "PARENTID", "CITYNAME", "PROJCODE", "FULLNAME") AS SELECT ORGID, ORGNAME, ORGTYPE, PARENTID, CITYNAME, PROJCODE, FULLNAME
FROM   (SELECT ID AS ORGID, STAGE_NAME AS ORGNAME, '11' AS ORGTYPE,
								PROJECT_ID AS PARENTID, '' AS CITYNAME, '' AS PROJCODE,
								STAGE_FULL_NAME AS FULLNAME
				 FROM   SYS_PROJECT_STAGE
				 UNION
				 SELECT ID AS ORGID, PROJECT_NAME AS ORGNAME, '10' AS ORGTYPE,
								UNIT_ID AS PARENTID, CITY_NAME AS CITYNAME,
								PROJECT_CODE AS PROJCODE, PROJECT_NAME AS FULLNAME
				 FROM   SYS_PROJECT) T

;
--------------------------------------------------------
--  DDL for View V_SYS_STATION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_STATION" ("STATIONID", "STATIONNAME", "ORGID", "ORGNAME", "COMPANYID", "COMPANYNAME") AS SELECT A.ID AS STATIONID, A.STATION_NAME AS STATIONNAME, B.ID AS ORGID,
			 B.ORG_NAME AS ORGNAME, C.ID AS COMPANYID, C.ORG_NAME AS COMPANYNAME
FROM   SYS_STATION A
LEFT   JOIN SYS_BUSINESS_UNIT B
ON     B.ID = A.ORG_ID
LEFT   JOIN SYS_BUSINESS_UNIT C
ON     B.PARENT_ID = C.ID

;
--------------------------------------------------------
--  DDL for View V_SYS_USER
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_USER" ("USER_ID", "USER_NAME", "USER_CODE", "STATION_ID", "STATION_NAME", "DEPARTMENTGUID", "DEPARTMENTNAME", "COMPANYGUID", "COMPANYNAME") AS select SYS_USER.ID as USER_ID,SYS_USER.USER_NAME,SYS_USER.USER_CODE,SYS_STATION.ID as STATION_ID,SYS_STATION.STATION_NAME,
deptment.ID as departmentGUID,deptment.ORG_NAME as departmentName,
deptment.PARENT_ID as companyGUID,company.ORG_NAME as companyName
from SYS_USER  left join  SYS_STATION_TO_USER 
on SYS_USER.ID = SYS_STATION_TO_USER.USER_ID
left join SYS_STATION on SYS_STATION_TO_USER.STATION_ID = SYS_STATION.ID
left join SYS_BUSINESS_UNIT deptment on SYS_STATION.ORG_ID = deptment.ID
left join SYS_BUSINESS_UNIT company on deptment.PARENT_ID = company.ID
;
--------------------------------------------------------
--  DDL for View V_SYS_USER_TREE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_USER_TREE" ("ORGID", "ORGNAME", "PARENTID", "ORGTYPE", "ISCOMPANY", "ORDERCODE", "ORDERHIERARCHYCODE") AS SELECT orgId,orgName,parentId,orgType,isCompany,orderCode,orderHierarchyCode
from (
  SELECT id as orgId ,ORG_NAME as orgName,PARENT_ID as parentId,ORG_TYPE as orgType,IS_COMPANY as isCompany,
         ORDER_CODE as orderCode,ORDER_HIERARCHY_CODE as orderHierarchyCode
  from SYS_BUSINESS_UNIT
  where ID != '000100000000000000000000000000' or ID != '000200000000000000000000000000'
  union
  SELECT ID as orgId, STATION_NAME  as orgName ,org_id as parentId, '2' as orgType,0 as isCompany,'88' as orderCode,
         '001' as orderHierarchyCode
  from SYS_STATION
  union
  SELECT a.ID as orgId, a.USER_NAME as orgName, b.STATION_ID as parentId, '4' as orgType,0 as isCompany,
         '99' as orderCode,'001' as orderHierarchyCode
  from SYS_USER a
  left JOIN SYS_STATION_TO_USER b on a.id = b.USER_ID
) t
;
--------------------------------------------------------
--  DDL for View V_SYS_ZTREES
--------------------------------------------------------

  CREATE OR REPLACE VIEW "V_SYS_ZTREES" ("ID", "PID", "NAME", "PATH", "OPEN", "ICON", "IS_DISABLED", "ISPARENT", "SYSTEM_ID", "ORDE_RHIERARCHY_CODE", "TYPE") AS SELECT ID AS ID, PARENT_FUNCTION_ID AS PID, FUNCTION_NAME AS NAME,
			 FUNCTION_URL AS PATH, 'true' AS OPEN, ICON AS ICON, T.IS_DISABLED,
			 CASE
					 WHEN PARENT_FUNCTION_ID IS NULL THEN
						'true'
					 ELSE
						'false'
			 END AS ISPARENT, SYSTEM_ID, ORDE_RHIERARCHY_CODE, 'function' AS TYPE
FROM   "SYS_FUNCTION" T
WHERE  IS_DISABLED = 0
UNION
SELECT ID AS ID, FUNCTION_ID AS PID, ACTION_NAME AS NAME, '' AS PATH,
			 '' AS ICON, 'false' AS OPEN, 0 AS IS_DISABLED, 'false' AS ISPARENT,
			 SYSTEM_ID, '' ORDE_RHIERARCHY_CODE, 'action' AS TYPE
FROM   SYS_ACTION
WHERE  FUNCTION_ID IS NOT NULL

;
