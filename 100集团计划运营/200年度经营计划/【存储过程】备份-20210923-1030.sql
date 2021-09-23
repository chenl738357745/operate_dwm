--------------------------------------------------------
--  文件已创建 - 星期四-九月-23-2021   
--------------------------------------------------------
DROP PROCEDURE "P_OPM_ED_GROUP";
DROP PROCEDURE "P_OPM_ED_GROUP_CASH";
DROP PROCEDURE "P_OPM_ED_GROUP_INVENTORY";
DROP PROCEDURE "P_OPM_ED_GROUP_OPERATING";
DROP PROCEDURE "P_OPM_ED_PROJ";
DROP PROCEDURE "P_OPM_ED_PROJ_BUDGET";
DROP PROCEDURE "P_OPM_ED_PROJ_INVENTORY";
DROP PROCEDURE "P_OPM_ED_PROJ_INVESTMENT";
DROP PROCEDURE "P_OPM_ED_PROJ_OPERATING";
DROP PROCEDURE "P_OPM_ED_REGION";
DROP PROCEDURE "P_OPM_ED_REGION_CASH";
DROP PROCEDURE "P_OPM_ED_REGION_INVENTORY";
DROP PROCEDURE "P_OPM_ED_REGION_OPERATING";
DROP PROCEDURE "P_OPM_ES_GROUP";
DROP PROCEDURE "P_OPM_ES_PROJ";
DROP PROCEDURE "P_OPM_ES_REGION";
DROP PROCEDURE "P_OPM_FIELD_GROUP";
DROP PROCEDURE "P_OPM_FIELD_PROJ";
DROP PROCEDURE "P_OPM_FIELD_REGION";
DROP PROCEDURE "P_OPM_INIT";
DROP PROCEDURE "P_OPM_INIT_GROUP";
DROP PROCEDURE "P_OPM_INIT_GROUP_CASH";
DROP PROCEDURE "P_OPM_INIT_GROUP_INVENTORY";
DROP PROCEDURE "P_OPM_INIT_GROUP_OPERATING";
DROP PROCEDURE "P_OPM_INIT_PROJ";
DROP PROCEDURE "P_OPM_INIT_PROJ_BUDGET";
DROP PROCEDURE "P_OPM_INIT_PROJ_INVENTORY";
DROP PROCEDURE "P_OPM_INIT_PROJ_INVESTMENT";
DROP PROCEDURE "P_OPM_INIT_PROJ_OPERATING";
DROP PROCEDURE "P_OPM_INIT_REGION";
DROP PROCEDURE "P_OPM_INIT_REGION_CASH";
DROP PROCEDURE "P_OPM_INIT_REGION_INVENTORY";
DROP PROCEDURE "P_OPM_INIT_REGION_OPERATING";
DROP PROCEDURE "P_OPM_PROJ_LIST";
DROP PROCEDURE "P_OPM_SUM_GROUP";
DROP PROCEDURE "P_OPM_SUM_GROUP_CASH";
DROP PROCEDURE "P_OPM_SUM_GROUP_INVENTORY";
DROP PROCEDURE "P_OPM_SUM_GROUP_OPERATING";
DROP PROCEDURE "P_OPM_SUM_REGION";
DROP PROCEDURE "P_OPM_SUM_REGION_CASH";
DROP PROCEDURE "P_OPM_SUM_REGION_INVENTORY";
DROP PROCEDURE "P_OPM_SUM_REGION_OPERATING";
DROP PROCEDURE "P_OPM_TREE_LIST";
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_GROUP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_GROUP" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
groupsheet1 OUT SYS_REFCURSOR,--1、sheet页的数据源集合 【根据集合顺序】
groupsheet2 OUT SYS_REFCURSOR,--2、sheet页的数据源集合 【根据集合顺序】
groupsheet3 OUT SYS_REFCURSOR--3、sheet页的数据源集合 【根据集合顺序】
) AS
-- operate plan 经营计划-集团级导出表数据。
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
--- group_sheet1
BEGIN P_OPM_ED_GROUP_OPERATING(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
    GROUPSHEET1 => GROUPSHEET1
  ); end;
--- group_sheet2
BEGIN P_OPM_ED_GROUP_CASH(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
    GROUPSHEET2 => GROUPSHEET2
  ); end;
--- group_sheet3
BEGIN P_OPM_ED_GROUP_INVENTORY(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
    GROUPSHEET3 => GROUPSHEET3
  );end;
END P_OPM_ED_GROUP;
------------------------------------------------

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_GROUP_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_GROUP_CASH" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
groupsheet2 OUT SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
-- operate plan 经营计划-集团级导出表数据。
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet2 FOR 
SELECT
ID as "id",--- 主键  
LEVEL_CODE,--- 层级：1开始
--OBJECT_ID,--- 对象ID
OBJECT_NAME,--- 对象名称（城市/项目名称）
--OBJECT_TYPE,--- 类型（公司、项目、补差公司、拟新获取项目、总计）
--ORDER_CODE,--- 顺序
PARENT_ID,--- 父级ID
PLAN_YEAR,--- 计划年份
NVL(FMA_AVAILABLE_FUNDS,CASH_AVAILABLE_FUNDS) as "可动用资金",--- 2022年当年现金流情况展示窗（可动用资金）
NVL(fma_flow_funds,CASH_FLOW_FUNDS) as "资金净流量",--- 2022年当年现金流情况展示窗（资金净流量）
NVL(FMA_CASH_REMAINING_AMOUNT,CASH_REMAINING_AMOUNT) as "展示窗-期末资金余额",--- 2022年当年现金流情况展示窗（期末资金余额）
NVL(FMA_REMAINING_AMOUNT,REMAINING_AMOUNT) as "年底-期末资金余额",--- 截至XXXX年底（期末资金余额）（去年）
NVL(FMA_COLLECTION_LOAN,SOUR_COLLECTION_LOAN) as "代收款",--- XXXX年资金来源计划（代收款）
NVL(FMA_INCREASE_LOAN,SOUR_INCREASE_LOAN) as "净增贷款",--- XXXX年资金来源计划（净增贷款）
NVL(FMA_INVESTMENT_INPUT,SOUR_INVESTMENT_INPUT) as "往来投入",--- XXXX年资金来源计划（往来投入）
NVL(FMA_OTHER_INPUT,SOUR_OTHER_INPUT) as "其他投入",--- XXXX年资金来源计划（其他投入）
NVL(FMA_RENTAL_INCOME,SOUR_RENTAL_INCOME) as "租金收入",--- XXXX年资金来源计划（租金收入）
NVL(FMA_SALES_COLLECTION,SOUR_SALES_COLLECTION)as "销售回款",--- XXXX年资金来源计划（销售回款）
NVL(fma_shareholder_input,SOUR_SHAREHOLDER_INPUT)as "股东投入",--- XXXX年资金来源计划（股东投入）
NVL(fma_total_source_funds,SOUR_TOTAL_FUNDS) as "资金来源合计",--- 2022年资金来源计划（资金来源合计）
NVL(FMA_CURRENT_EXPENDITURE,UTIL_CURRENT_EXPENDITURE) as "往来支出",--- 2022年资金运用计划（往来支出）
NVL(FMA_DEVELOPMENT_OVERHEAD,UTIL_DEVELOPMENT_OVERHEAD) as "开发间接费",--- 2022年资金运用计划（开发间接费）
NVL(fma_engineering_expenditure,UTIL_ENGINEERING_EXPENDITURE) as "工程性支出",--- 2022年资金运用计划（工程性支出）
NVL(FMA_EXPENSES_THE_PERIOD,UTIL_EXPENSES_THE_PERIOD)as "期间费用",--- 2022年资金运用计划（期间费用）
NVL(FMA_LAND_COST,UTIL_LAND_COST) as "土地费用",--- 2022年资金运用计划（土地费用）
NVL(FMA_OTHER_EXPENSES,UTIL_OTHER_EXPENSES) as "其他支出",--- 2022年资金运用计划（其他支出）
NVL(FMA_PRE_PAYMENT,UTIL_PRE_PAYMENT) as "代付款",--- 2022年资金运用计划（代付款）
NVL(fma_subtotal_Fund,UTIL_SUBTOTAL_FUND) as "资金运用小计",--- 2022年资金运用计划（资金运用小计）
NVL(fma_taxes,UTIL_TAXES) as "税金"--- 2022年资金运用计划（税金）
FROM    opm_group_cash where PLAN_YEAR=planyear order by LPAD(order_code,10,'0');
END P_OPM_ED_GROUP_CASH;
------------------------------------------------

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_GROUP_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_GROUP_INVENTORY" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
groupsheet3 OUT SYS_REFCURSOR--2、sheet3 供销存
) AS
-- 
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet3 FOR 
SELECT
     id,
     plan_year ---计划年份
     ,
     parent_id ---父级ID
     ,
     level_code ---层级：1开始
     ,
     order_code ---顺序
     ,
     object_id ---对象ID
     ,
     object_name ---项目名称与分期
     ,
     object_type ---业态（住宅、商办产业、车位仓储、配套设施、合计）
     ,
     nvl(fma_saleable_area, saleable_area) AS "saleable_area", ---（公式）全案总可售货值（面积）
     nvl(fma_saleable_number, saleable_number) AS "saleable_number", ---（公式）全案总可售货值（套数）
     nvl(fma_saleable_amount, saleable_amount) AS "saleable_amount", ---（公式）全案总可售货值（金额）
     nvl(fma_saleable_price, saleable_price) AS "saleable_price", ---（公式）全案总可售货值（平方单价）
     nvl(fma_tired_sale_area, tired_sale_area) AS "tired_sale_area", ---（公式）开累已取预售总货值（面积）
     nvl(fma_tired_sale_number, tired_sale_number) AS "tired_sale_number", ---（公式）开累已取预售总货值（套数）
     nvl(fma_tired_sale_amount, tired_sale_amount) AS "tired_sale_amount", ---（公式）开累已取预售总货值（金额）
     nvl(fma_tired_sale_price, tired_sale_price) AS "tired_sale_price", ---（公式）开累已取预售总货值（平米单价）
     nvl(fma_tired_complete_area, tired_complete_area) AS "tired_complete_area", ---（公式）开累完成销售（面积）
     nvl(fma_tired_complete_number, tired_complete_number) AS "tired_complete_number", ---（公式）开累完成销售（套数）
     nvl(fma_tired_complete_amount, tired_complete_amount) AS "tired_complete_amount", ---（公式）开累完成销售（金额）
     nvl(fma_tired_complete_price, tired_complete_price) AS "tired_complete_price", ---（公式）开累完成销售（平米单价）
     nvl(fma_stock_area, stock_area) AS "stock_area", ---（公式）全案库存（面积）
     nvl(fma_stock_number, stock_number) AS "stock_number", ---（公式）全案库存（套数）
     nvl(fma_stock_amount, stock_amount) AS "stock_amount", ---（公式）全案库存（金额）
     nvl(fma_stock_price, stock_price) AS "stock_price", ---（公式）全案库存（平米单价）
     nvl(fma_sale_area, sale_area) AS "sale_area", ---（公式）已取预售证库存（面积）
     nvl(fma_sale_sleeve, sale_sleeve) AS "sale_sleeve", ---（公式）已取预售证库存（套数）
     nvl(fma_sale_amount, sale_amount) AS "sale_amount", ---（公式）已取预售证库存（金额）
     nvl(fma_sale_price, sale_price) AS "sale_price", ---（公式）已取预售证库存（平米单价）
     nvl(fma_supply_area, supply_area) AS "supply_area", ---（公式）2021年供货计划（面积）
     nvl(fma_supply_sleeve, supply_sleeve) AS "supply_sleeve", ---（公式）2021年供货计划（套数）
     nvl(fma_supply_amount, supply_amount) AS "supply_amount", ---（公式）2021年供货计划（金额）
     nvl(fma_supply_price, supply_price) AS "supply_price", ---（公式）2021年供货计划（平米单价）
     nvl(fma_sales_area, sales_area) AS "sales_area", ---（公式）2021年销售计划（面积）
     nvl(fma_sales_sleeve, sales_sleeve) AS "sales_sleeve", ---（公式）2021年销售计划（套数）
     nvl(fma_sales_amount, sales_amount) AS "sales_amount", ---（公式）2021年销售计划（金额）
     nvl(fma_sales_price, sales_price) AS "sales_price", ---（公式）2021年销售计划（平米单价）
     nvl(fma_jan_supply_area, jan_supply_area) AS "jan_supply_area", ---（公式）第一个月（供应）（面积）
     nvl(fma_jan_supply_sleeve, jan_supply_sleeve) AS "jan_supply_sleeve", ---（公式）第一个月（供应）（套数）
     nvl(fma_jan_supply_amount, jan_supply_amount) AS "jan_supply_amount", ---（公式）第一个月（供应）（金额）
     nvl(fma_jan_sales_area, jan_sales_area) AS "jan_sales_area", ---（公式）第一个月（销售）（面积）
     nvl(fma_jan_sales_sleeve, jan_sales_sleeve) AS "jan_sales_sleeve", ---（公式）第一个月（销售）（套数）
     nvl(fma_jan_sales_amount, jan_sales_amount) AS "jan_sales_amount", ---（公式）第一个月（销售）（金额）
     nvl(fma_feb_supply_area, feb_supply_area) AS "feb_supply_area", ---（公式）第二个月（供应）（面积）
     nvl(fma_feb_supply_sleeve, feb_supply_sleeve) AS "feb_supply_sleeve", ---（公式）第二个月（供应）（套数）
     nvl(fma_feb_supply_amount, feb_supply_amount) AS "feb_supply_amount", ---（公式）第二个月（供应）（金额）
     nvl(fma_feb_sales_area, feb_sales_area) AS "feb_sales_area", ---（公式）第二个月（销售）（面积）
     nvl(fma_feb_sales_sleeve, feb_sales_sleeve) AS "feb_sales_sleeve", ---（公式）第二个月（销售）（套数）
     nvl(fma_feb_sales_amount, feb_sales_amount) AS "feb_sales_amount", ---（公式）第二个月（销售）（金额）
     nvl(fma_mar_supply_area, mar_supply_area) AS "mar_supply_area", ---（公式）第三个月（供应）（面积）
     nvl(fma_mar_supply_sleeve, mar_supply_sleeve) AS "mar_supply_sleeve", ---（公式）第三个月（供应）（套数）
     nvl(fma_mar_supply_amount, mar_supply_amount) AS "mar_supply_amount", ---（公式）第三个月（供应）（金额）
     nvl(fma_mar_sales_area, mar_sales_area) AS "mar_sales_area", ---（公式）第三个月（销售）（面积）
     nvl(fma_mar_sales_sleeve, mar_sales_sleeve) AS "mar_sales_sleeve", ---（公式）第三个月（销售）（套数）
     nvl(fma_mar_sales_amount, mar_sales_amount) AS "mar_sales_amount", ---（公式）第三个月（销售）（金额）
     nvl(fma_apr_supply_area, apr_supply_area) AS "apr_supply_area", ---（公式）第四个月（供应）（面积）
     nvl(fma_apr_supply_sleeve, apr_supply_sleeve) AS "apr_supply_sleeve", ---（公式）第四个月（供应）（套数）
     nvl(fma_apr_supply_amount, apr_supply_amount) AS "apr_supply_amount", ---（公式）第四个月（供应）（金额）
     nvl(fma_apr_sales_area, apr_sales_area) AS "apr_sales_area", ---（公式）第四个月（销售）（面积）
     nvl(fma_apr_sales_sleeve, apr_sales_sleeve) AS "apr_sales_sleeve", ---（公式）第四个月（销售）（套数）
     nvl(fma_apr_sales_amount, apr_sales_amount) AS "apr_sales_amount", ---（公式）第四个月（销售）（金额）
     nvl(fma_may_supply_area, may_supply_area) AS "may_supply_area", ---（公式）第五个月（供应）（面积）
     nvl(fma_may_supply_sleeve, may_supply_sleeve) AS "may_supply_sleeve", ---（公式）第五个月（供应）（套数）
     nvl(fma_may_supply_amount, may_supply_amount) AS "may_supply_amount", ---（公式）第五个月（供应）（金额）
     nvl(fma_may_sales_area, may_sales_area) AS "may_sales_area", ---（公式）第五个月（销售）（面积）
     nvl(fma_may_sales_sleeve, may_sales_sleeve) AS "may_sales_sleeve", ---（公式）第五个月（销售）（套数）
     nvl(fma_may_sales_amount, may_sales_amount) AS "may_sales_amount", ---（公式）第五个月（销售）（金额）
     nvl(fma_june_supply_area, june_supply_area) AS "june_supply_area", ---（公式）第六个月（供应）（面积）
     nvl(fma_june_supply_sleeve, june_supply_sleeve) AS "june_supply_sleeve", ---（公式）第六个月（供应）（套数）
     nvl(fma_june_supply_amount, june_supply_amount) AS "june_supply_amount", ---（公式）第六个月（供应）（金额）
     nvl(fma_june_sales_area, june_sales_area) AS "june_sales_area", ---（公式）第六个月（销售）（面积）
     nvl(fma_june_sales_sleeve, june_sales_sleeve) AS "june_sales_sleeve", ---（公式）第六个月（销售）（套数）
     nvl(fma_june_sales_amount, june_sales_amount) AS "june_sales_amount", ---（公式）第六个月（销售）（金额）
     nvl(fma_july_supply_area, july_supply_area) AS "july_supply_area", ---（公式）第七个月（供应）（面积）
     nvl(fma_july_supply_sleeve, july_supply_sleeve) AS "july_supply_sleeve", ---（公式）第七个月（供应）（套数）
     nvl(fma_july_supply_amount, july_supply_amount) AS "july_supply_amount", ---（公式）第七个月（供应）（金额）
     nvl(fma_july_sales_area, july_sales_area) AS "july_sales_area", ---（公式）第七个月（销售）（面积）
     nvl(fma_july_sales_sleeve, july_sales_sleeve) AS "july_sales_sleeve", ---（公式）第七个月（销售）（套数）
     nvl(fma_july_sales_amount, july_sales_amount) AS "july_sales_amount", ---（公式）第七个月（销售）（金额）
     nvl(fma_aug_supply_area, aug_supply_area) AS "aug_supply_area", ---（公式）第八个月（供应）（面积）
     nvl(fma_aug_supply_sleeve, aug_supply_sleeve) AS "aug_supply_sleeve", ---（公式）第八个月（供应）（套数）
     nvl(fma_aug_supply_amount, aug_supply_amount) AS "aug_supply_amount", ---（公式）第八个月（供应）（金额）
     nvl(fma_aug_sales_area, aug_sales_area) AS "aug_sales_area", ---（公式）第八个月（销售）（面积）
     nvl(fma_aug_sales_sleeve, aug_sales_sleeve) AS "aug_sales_sleeve", ---（公式）第八个月（销售）（套数）
     nvl(fma_aug_sales_amount, aug_sales_amount) AS "aug_sales_amount", ---（公式）第八个月（销售）（金额）
     nvl(fma_sep_supply_area, sep_supply_area) AS "sep_supply_area", ---（公式）第九个月（供应）（面积）
     nvl(fma_sep_supply_sleeve, sep_supply_sleeve) AS "sep_supply_sleeve", ---（公式）第九个月（供应）（套数）
     nvl(fma_sep_supply_amount, sep_supply_amount) AS "sep_supply_amount", ---（公式）第九个月（供应）（金额）
     nvl(fma_sep_sales_area, sep_sales_area) AS "sep_sales_area", ---（公式）第九个月（销售）（面积）
     nvl(fma_sep_sales_sleeve, sep_sales_sleeve) AS "sep_sales_sleeve", ---（公式）第九个月（销售）（套数）
     nvl(fma_sep_sales_amount, sep_sales_amount) AS "sep_sales_amount", ---（公式）第九个月（销售）（金额）
     nvl(fma_oct_supply_area, oct_supply_area) AS "oct_supply_area", ---（公式）第十个月（供应）（面积）
     nvl(fma_oct_supply_sleeve, oct_supply_sleeve) AS "oct_supply_sleeve", ---（公式）第十个月（供应）（套数）
     nvl(fma_oct_supply_amount, oct_supply_amount) AS "oct_supply_amount", ---（公式）第十个月（供应）（金额）
     nvl(fma_oct_sales_area, oct_sales_area) AS "oct_sales_area", ---（公式）第十个月（销售）（面积）
     nvl(fma_oct_sales_sleeve, oct_sales_sleeve) AS "oct_sales_sleeve", ---（公式）第十个月（销售）（套数）
     nvl(fma_oct_sales_amount, oct_sales_amount) AS "oct_sales_amount", ---（公式）第十个月（销售）（金额）
     nvl(fma_nov_supply_area, nov_supply_area) AS "nov_supply_area", ---（公式）第十一个月（供应）（面积）
     nvl(fma_nov_supply_sleeve, nov_supply_sleeve) AS "nov_supply_sleeve", ---（公式）第十一个月（供应）（套数）
     nvl(fma_nov_supply_amount, nov_supply_amount) AS "nov_supply_amount", ---（公式）第十一个月（供应）（金额）
     nvl(fma_nov_sales_area, nov_sales_area) AS "nov_sales_area", ---（公式）第十一个月（销售）（面积）
     nvl(fma_nov_sales_sleeve, nov_sales_sleeve) AS "nov_sales_sleeve", ---（公式）第十一个月（销售）（套数）
     nvl(fma_nov_sales_amount, nov_sales_amount) AS "nov_sales_amount", ---（公式）第十一个月（销售）（金额）
     nvl(fma_dec_supply_area, dec_supply_area) AS "dec_supply_area", ---（公式）第十二个月（供应）（面积）
     nvl(fma_dec_supply_sleeve, dec_supply_sleeve) AS "dec_supply_sleeve", ---（公式）第十二个月（供应）（套数）
     nvl(fma_dec_supply_amount, dec_supply_amount) AS "dec_supply_amount", ---（公式）第十二个月（供应）（金额）
     nvl(fma_dec_sales_area, dec_sales_area) AS "dec_sales_area", ---（公式）第十二个月（销售）（面积）
     nvl(fma_dec_sales_sleeve, dec_sales_sleeve) AS "dec_sales_sleeve", ---（公式）第十二个月（销售）（套数）
     nvl(fma_dec_sales_amount, dec_sales_amount) AS "dec_sales_amount", ---（公式）第十二个月（销售）（金额）
     
     nvl(fma_fina_stock_area, fina_stock_area) AS "fina_stock_area", ---
     nvl(fma_fina_stock_number, fina_stock_number) AS "fina_stock_number", ---
     nvl(fma_fina_stock_amount, fina_stock_amount) AS "fina_stock_amount", ---
     nvl(fma_fina_stock_price, fina_stock_price) AS "fina_stock_price", ---
     nvl(fma_fina_sale_area, fina_sale_area) AS "fina_sale_area", ---
     nvl(fma_fina_sale_number, fina_sale_number) AS "fina_sale_number", ---
     nvl(fma_fina_sale_amout, fina_sale_amout) AS "fina_sale_amout", ---
     nvl(fma_fina_sale_price, fina_sale_price) AS "fina_sale_price", ---

     nvl(fma_supply_one_amount, supply_one_amount) AS "supply_one_amount", ---（公式）供货均衡性分析（S1）金额
     nvl(fma_supply_one_ratio, supply_one_ratio) AS "supply_one_ratio", ---（公式）供货均衡性分析（S1）占比
     nvl(fma_supply_two_amount, supply_two_amount) AS "supply_two_amount", ---（公式）供货均衡性分析（S2）金额
     nvl(fma_supply_two_ratio, supply_two_ratio) AS "supply_two_ratio", ---（公式）供货均衡性分析（S2）占比
     nvl(fma_supply_three_amount, supply_three_amount) AS "supply_three_amount", ---（公式）供货均衡性分析（S3）金额
     nvl(fma_supply_three_ratio, supply_three_ratio) AS "supply_three_ratio", ---（公式）供货均衡性分析（S3）占比
     nvl(fma_supply_four_amount, supply_four_amount) AS "supply_four_amount", ---（公式）供货均衡性分析（S4）金额
     nvl(fma_supply_four_ratio, supply_four_ratio) AS "supply_four_ratio", ---（公式）供货均衡性分析（S4）占比
     nvl(fma_sales_one_amount, sales_one_amount) AS "sales_one_amount", ---（公式）销售均衡性分析（S1）金额
     nvl(fma_sales_one_ratio, sales_one_ratio) AS "sales_one_ratio", ---（公式）销售均衡性分析（S1）占比
     nvl(fma_sales_two_amount, sales_two_amount) AS "sales_two_amount", ---（公式）销售均衡性分析（S2）金额
     nvl(fma_sales_two_ratio, sales_two_ratio) AS "sales_two_ratio", ---（公式）销售均衡性分析（S2）占比
     nvl(fma_sales_three_amount, sales_three_amount) AS "sales_three_amount", ---（公式）销售均衡性分析（S3）金额
     nvl(fma_sales_three_ratio, sales_three_ratio) AS "sales_three_ratio", ---（公式）销售均衡性分析（S3）占比
     nvl(fma_sales_four_amount, sales_four_amount) AS "sales_four_amount", ---（公式）销售均衡性分析（S4）金额
     nvl(fma_sales_four_ratio, sales_four_ratio) AS "sales_four_ratio", ---（公式）销售均衡性分析（S4）占比
     nvl(fma_desalination_rate, desalination_rate) AS "desalination_rate", ---（公式）去化率
     nvl(fma_ny_first_supply_area, ny_first_supply_area) AS "ny_first_supply_area", ---（公式）2022一季度（供应）（面积）
     nvl(fma_ny_first_supply_number, ny_first_supply_number) AS "ny_first_supply_number", ---（公式）2022一季度（供应）（套数）
     nvl(fma_ny_first_supply_amount, ny_first_supply_amount) AS "ny_first_supply_amount", ---（公式）2022一季度（供应）（金额）
     nvl(fma_ny_first_sale_area, ny_first_sale_area) AS "ny_first_sale_area", ---（公式）2022一季度（销售）（面积）
     nvl(fma_ny_first_sale_number, ny_first_sale_number) AS "ny_first_sale_number", ---（公式）2022一季度（销售）（套数）
     nvl(fma_ny_first_sale_amount, ny_first_sale_amount) AS "ny_first_sale_amount", ---（公式）2022一季度（销售）（金额）
     nvl(fma_ny_second_supply_area, ny_second_supply_area) AS "ny_second_supply_area", ---（公式）2022二季度（供应）（面积）
     nvl(fma_ny_second_supply_number, ny_second_supply_number) AS "ny_second_supply_number", ---（公式）2022二季度（供应）（套数）
     nvl(fma_ny_second_supply_amount, ny_second_supply_amount) AS "ny_second_supply_amount", ---（公式）2022二季度（供应）（金额）
     nvl(fma_ny_second_sale_area, ny_second_sale_area) AS "ny_second_sale_area", ---（公式）2022二季度（销售）（面积）
     nvl(fma_ny_second_sale_number, ny_second_sale_number) AS "ny_second_sale_number", ---（公式）2022二季度（销售）（套数）
     nvl(fma_ny_second_sale_amount, ny_second_sale_amount) AS "ny_second_sale_amount", ---（公式）2022二季度（销售）（金额）
     nvl(fma_ny_third_supply_area, ny_third_supply_area) AS "ny_third_supply_area", ---（公式）2022三季度（供应）（面积）
     nvl(fma_ny_third_supply_number, ny_third_supply_number) AS "ny_third_supply_number", ---（公式）2022三季度（供应）（套数）
     nvl(fma_ny_third_supply_amount, ny_third_supply_amount) AS "ny_third_supply_amount", ---（公式）2022三季度（供应）（金额）
     nvl(fma_ny_third_sale_area, ny_third_sale_area) AS "ny_third_sale_area", ---（公式）2022三季度（销售）（面积）
     nvl(fma_ny_third_sale_number, ny_third_sale_number) AS "ny_third_sale_number", ---（公式）2022三季度（销售）（套数）
     nvl(fma_ny_third_sale_amount, ny_third_sale_amount) AS "ny_third_sale_amount", ---（公式）2022三季度（销售）（金额）
     nvl(fma_ny_fourth_supply_area, ny_fourth_supply_area) AS "ny_fourth_supply_area", ---（公式）2022四季度（供应）（面积）
     nvl(fma_ny_fourth_supply_number, ny_fourth_supply_number) AS "ny_fourth_supply_number", ---（公式）2022四季度（供应）（套数）
     nvl(fma_ny_fourth_supply_amount, ny_fourth_supply_amount) AS "ny_fourth_supply_amount", ---（公式）2022四季度（供应）（金额）
     nvl(fma_ny_fourth_sale_area, ny_fourth_sale_area) AS "ny_fourth_sale_area", ---（公式）2022四季度（销售）（面积）
     nvl(fma_ny_fourth_sale_number, ny_fourth_sale_number) AS "ny_fourth_sale_number", ---（公式）2022四季度（销售）（套数）
     nvl(fma_ny_fourth_sale_amount, ny_fourth_sale_amount) AS "ny_fourth_sale_amount", ---（公式）2022四季度（销售）（金额）
     nvl(fma_ncy_first_supply_area, ncy_first_supply_area) AS "ncy_first_supply_area", ---（公式）2023一季度（供应）（面积）
     nvl(fma_ncy_first_supply_number, ncy_first_supply_number) AS "ncy_first_supply_number", ---（公式）2023一季度（供应）（套数）
     nvl(fma_ncy_first_supply_amount, ncy_first_supply_amount) AS "ncy_first_supply_amount", ---（公式）2023一季度（供应）（金额）
     nvl(fma_ncy_first_sale_area, ncy_first_sale_area) AS "ncy_first_sale_area", ---（公式）2023一季度（销售）（面积）
     nvl(fma_ncy_first_sale_number, ncy_first_sale_number) AS "ncy_first_sale_number", ---（公式）2023一季度（销售）（套数）
     nvl(fma_ncy_first_sale_amount, ncy_first_sale_amount) AS "ncy_first_sale_amount", ---（公式）2023一季度（销售）（金额）
     nvl(fma_ncy_second_supply_area, ncy_second_supply_area) AS "ncy_second_supply_area", ---（公式）2023二季度（供应）（面积）
     nvl(fma_ncy_second_supply_number, ncy_second_supply_number) AS "ncy_second_supply_number", ---（公式）2023二季度（供应）（套数）
     nvl(fma_ncy_second_supply_amount, ncy_second_supply_amount) AS "ncy_second_supply_amount", ---（公式）2023二季度（供应）（金额）
     nvl(fma_ncy_second_sale_area, ncy_second_sale_area) AS "ncy_second_sale_area", ---（公式）2023二季度（销售）（面积）
     nvl(fma_ncy_second_sale_number, ncy_second_sale_number) AS "ncy_second_sale_number", ---（公式）2023二季度（销售）（套数）
     nvl(fma_ncy_second_sale_amount, ncy_second_sale_amount) AS "ncy_second_sale_amount", ---（公式）2023二季度（销售）（金额）
     nvl(fma_ncy_third_supply_area, ncy_third_supply_area) AS "ncy_third_supply_area", ---（公式）2023三季度（供应）（面积）
     nvl(fma_ncy_third_supply_number, ncy_third_supply_number) AS "ncy_third_supply_number", ---（公式）2023三季度（供应）（套数）
     nvl(fma_ncy_third_supply_amount, ncy_third_supply_amount) AS "ncy_third_supply_amount", ---（公式）2023三季度（供应）（金额）
     nvl(fma_ncy_third_sale_area, ncy_third_sale_area) AS "ncy_third_sale_area", ---（公式）2023三季度（销售）（面积）
     nvl(fma_ncy_third_sale_number, ncy_third_sale_number) AS "ncy_third_sale_number", ---（公式）2023三季度（销售）（套数）
     nvl(fma_ncy_third_sale_amount, ncy_third_sale_amount) AS "ncy_third_sale_amount", ---（公式）2023三季度（销售）（金额）
     nvl(fma_ncy_fourth_supply_area, ncy_fourth_supply_area) AS "ncy_fourth_supply_area", ---（公式）2023四季度（供应）（面积）
     nvl(fma_ncy_fourth_supply_number, ncy_fourth_supply_number) AS "ncy_fourth_supply_number", ---（公式）2023四季度（供应）（套数）
     nvl(fma_ncy_fourth_supply_amount, ncy_fourth_supply_amount) AS "ncy_fourth_supply_amount", ---（公式）2023四季度（供应）（金额）
     nvl(fma_ncy_fourth_sale_area, ncy_fourth_sale_area) AS "ncy_fourth_sale_area", ---（公式）2023四季度（销售）（面积）
     nvl(fma_ncy_fourth_sale_number, ncy_fourth_sale_number) AS "ncy_fourth_sale_number", ---（公式）2023四季度（销售）（套数）
     nvl(fma_ncy_fourth_sale_amount, ncy_fourth_sale_amount) AS "ncy_fourth_sale_amount", ---（公式）2023四季度（销售）（金额）
     nvl(fma_nty_first_supply_area, nty_first_supply_area) AS "nty_first_supply_area", ---（公式）2024一季度（供应）（面积）
     nvl(fma_nty_first_supply_number, nty_first_supply_number) AS "nty_first_supply_number", ---（公式）2024一季度（供应）（套数）
     nvl(fma_nty_first_supply_amount, nty_first_supply_amount) AS "nty_first_supply_amount", ---（公式）2024一季度（供应）（金额）
     nvl(fma_nty_first_sale_area, nty_first_sale_area) AS "nty_first_sale_area", ---（公式）2024一季度（销售）（面积）
     nvl(fma_nty_first_sale_number, nty_first_sale_number) AS "nty_first_sale_number", ---（公式）2024一季度（销售）（套数）
     nvl(fma_nty_first_sale_amount, nty_first_sale_amount) AS "nty_first_sale_amount", ---（公式）2024一季度（销售）（金额）
     nvl(fma_nty_second_supply_area, nty_second_supply_area) AS "nty_second_supply_area", ---（公式）2024二季度（供应）（面积）
     nvl(fma_nty_second_supply_number, nty_second_supply_number) AS "nty_second_supply_number", ---（公式）2024二季度（供应）（套数）
     nvl(fma_nty_second_supply_amount, nty_second_supply_amount) AS "nty_second_supply_amount", ---（公式）2024二季度（供应）（金额）
     nvl(fma_nty_second_sale_area, nty_second_sale_area) AS "nty_second_sale_area", ---（公式）2024二季度（销售）（面积）
     nvl(fma_nty_second_sale_number, nty_second_sale_number) AS "nty_second_sale_number", ---（公式）2024二季度（销售）（套数）
     nvl(fma_nty_second_sale_amount, nty_second_sale_amount) AS "nty_second_sale_amount", ---（公式）2024二季度（销售）（金额）
     nvl(fma_nty_third_supply_area, nty_third_supply_area) AS "nty_third_supply_area", ---（公式）2024三季度（供应）（面积）
     nvl(fma_nty_third_supply_number, nty_third_supply_number) AS "nty_third_supply_number", ---（公式）2024三季度（供应）（套数）
     nvl(fma_nty_third_supply_amount, nty_third_supply_amount) AS "nty_third_supply_amount", ---（公式）2024三季度（供应）（金额）
     nvl(fma_nty_third_sale_area, nty_third_sale_area) AS "nty_third_sale_area", ---（公式）2024三季度（销售）（面积）
     nvl(fma_nty_third_sale_number, nty_third_sale_number) AS "nty_third_sale_number", ---（公式）2024三季度（销售）（套数）
     nvl(fma_nty_third_sale_amount, nty_third_sale_amount) AS "nty_third_sale_amount", ---（公式）2024三季度（销售）（金额）
     nvl(fma_nty_fourth_supply_area, nty_fourth_supply_area) AS "nty_fourth_supply_area", ---（公式）2024四季度（供应）（面积）
     nvl(fma_nty_fourth_supply_number, nty_fourth_supply_number) AS "nty_fourth_supply_number", ---（公式）2024四季度（供应）（套数）
     nvl(fma_nty_fourth_supply_amount, nty_fourth_supply_amount) AS "nty_fourth_supply_amount", ---（公式）2024四季度（供应）（金额）
     nvl(fma_nty_fourth_sale_area, nty_fourth_sale_area) AS "nty_fourth_sale_area", ---（公式）2024四季度（销售）（面积）
     nvl(fma_nty_fourth_sale_number, nty_fourth_sale_number) AS "nty_fourth_sale_number", ---（公式）2024四季度（销售）（套数）
     nvl(fma_nty_fourth_sale_amount, nty_fourth_sale_amount) AS "nty_fourth_sale_amount", ---（公式）2024四季度（销售）（金额）
     nvl(fma_nfy_first_supply_area, nfy_first_supply_area) AS "nfy_first_supply_area", ---（公式）2025一季度（供应）（面积）
     nvl(fma_nfy_first_supply_number, nfy_first_supply_number) AS "nfy_first_supply_number", ---（公式）2025一季度（供应）（套数）
     nvl(fma_nfy_first_supply_amount, nfy_first_supply_amount) AS "nfy_first_supply_amount", ---（公式）2025一季度（供应）（金额）
     nvl(fma_nfy_first_sale_area, nfy_first_sale_area) AS "nfy_first_sale_area", ---（公式）2025一季度（销售）（面积）
     nvl(fma_nfy_first_sale_number, nfy_first_sale_number) AS "nfy_first_sale_number", ---（公式）2025一季度（销售）（套数）
     nvl(fma_nfy_first_sale_amount, nfy_first_sale_amount) AS "nfy_first_sale_amount", ---（公式）2025一季度（销售）（金额）
     nvl(fma_nfy_second_supply_area, nfy_second_supply_area) AS "nfy_second_supply_area", ---（公式）2025二季度（供应）（面积）
     nvl(fma_nfy_second_supply_number, nfy_second_supply_number) AS "nfy_second_supply_number", ---（公式）2025二季度（供应）（套数）
     nvl(fma_nfy_second_supply_amount, nfy_second_supply_amount) AS "nfy_second_supply_amount", ---（公式）2025二季度（供应）（金额）
     nvl(fma_nfy_second_sale_area, nfy_second_sale_area) AS "nfy_second_sale_area", ---（公式）2025二季度（销售）（面积）
     nvl(fma_nfy_second_sale_number, nfy_second_sale_number) AS "nfy_second_sale_number", ---（公式）2025二季度（销售）（套数）
     nvl(fma_nfy_second_sale_amount, nfy_second_sale_amount) AS "nfy_second_sale_amount", ---（公式）2025二季度（销售）（金额）
     nvl(fma_nfy_third_supply_area, nfy_third_supply_area) AS "nfy_third_supply_area", ---（公式）2025三季度（供应）（面积）
     nvl(fma_nfy_third_supply_number, nfy_third_supply_number) AS "nfy_third_supply_number", ---（公式）2025三季度（供应）（套数）
     nvl(fma_nfy_third_supply_amount, nfy_third_supply_amount) AS "nfy_third_supply_amount", ---（公式）2025三季度（供应）（金额）
     nvl(fma_nfy_third_sale_area, nfy_third_sale_area) AS "nfy_third_sale_area", ---（公式）2025三季度（销售）（面积）
     nvl(fma_nfy_third_sale_number, nfy_third_sale_number) AS "nfy_third_sale_number", ---（公式）2025三季度（销售）（套数）
     nvl(fma_nfy_third_sale_amount, nfy_third_sale_amount) AS "nfy_third_sale_amount", ---（公式）2025三季度（销售）（金额）
     nvl(fma_nfy_fourth_supply_area, nfy_fourth_supply_area) AS "nfy_fourth_supply_area", ---（公式）2025四季度（供应）（面积）
     nvl(fma_nfy_fourth_supply_number, nfy_fourth_supply_number) AS "nfy_fourth_supply_number", ---（公式）2025四季度（供应）（套数）
     nvl(fma_nfy_fourth_supply_amount, nfy_fourth_supply_amount) AS "nfy_fourth_supply_amount", ---（公式）2025四季度（供应）（金额）
     nvl(fma_nfy_fourth_sale_area, nfy_fourth_sale_area) AS "nfy_fourth_sale_area", ---（公式）2025四季度（销售）（面积）
     nvl(fma_nfy_fourth_sale_number, nfy_fourth_sale_number) AS "nfy_fourth_sale_number", ---（公式）2025四季度（销售）（套数）
     nvl(fma_nfy_fourth_sale_amount, nfy_fourth_sale_amount) AS "nfy_fourth_sale_amount" ---（公式）2025四季度（销售）（金额）
FROM
    opm_group_inventory_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END P_OPM_ED_GROUP_INVENTORY;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_GROUP_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_GROUP_OPERATING" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
groupsheet1 OUT SYS_REFCURSOR--2、sheet1 经营计划
) AS
-- 
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet1 FOR 
 SELECT
    id AS "id",
    plan_year, ---计划年份
    parent_id, ---父级id
    level_code, ---层级
    order_code as "order_code", ---顺序
    object_type as "object_type", ---类型（公司、项目、总计）
    object_id as "object_id", ---对象ID（公司ID、项目ID）
    object_name as "object_name", ---对象名称（城市/项目名称）
    nvl(fma_railway_bool, railway_bool) AS "railway_bool", ---（公式）是否并表（中国铁建）
    nvl(fma_estate_bool, estate_bool) AS "estate_bool", ---是否并表（地产集团）
    nvl(fma_estate_ratio, estate_ratio) AS "estate_ratio", ---地产集团所占股权比例
    nvl(fma_railway_ratio, railway_ratio) AS "railway_ratio", ---中国铁建所占股权比例
    nvl(fma_build_land_area, build_land_area) AS "build_land_area", ---建设用地面积（过规版方案指标）
    nvl(fma_surface_total_area, surface_total_area) AS "surface_total_area", ---总建筑面积
    nvl(fma_above_ground_area, above_ground_area) AS "above_ground_area", ---地上建筑面积（万平方米）
    nvl(fma_construction_stage, construction_stage) AS "construction_stage", --- 建设阶段（竣工/在建／未开工）
    nvl(fma_total_investment, total_investment) AS "total_investment", --- 总投资
    nvl(fma_total_saleable_area, total_saleable_area) AS "total_saleable_area", --- 总可售面积
    nvl(fma_total_value, total_value) AS "total_value", --- 总货值
    nvl(fma_last_started_area, last_started_area) AS "last_started_area", ---工程数据，截止2020年开累(开工面积)（去年）
    nvl(fma_last_completed_area, last_completed_area) AS "last_completed_area", ---工程数据，截止2020年开累(竣工面积)（去年）
    nvl(fma_this_started_area, this_started_area) AS "this_started_area", ---工程数据，2021年当年（开工面积）（今年）
    nvl(fma_this_completed_area, this_completed_area) AS "this_completed_area", ---工程数据，2021年当年（竣工面积）（今年）
    nvl(fma_todec_due_time, todec_due_time) AS "todec_due_time", ---工程数据，2021年10~12月（交付时间）（今年）
    nvl(fma_todec_delivery_installment, todec_delivery_installment) AS "todec_delivery_installment", ---工程数据，2021年10~12月（交付分期及相应楼栋）（今年）
    nvl(fma_cutoff_started_area, cutoff_started_area) AS "cutoff_started_area", ---截止2021年开累（开工面积）（今年）
    nvl(fma_cutoff_completed_area, cutoff_completed_area) AS "cutoff_completed_area", ---（公式）截止2021年开累（竣工面积）（今年）
    nvl(fma_next_started_area, next_started_area) AS "next_started_area", --- 2022年当年（开工面积）
    nvl(fma_next_completed_area, next_completed_area) AS "next_completed_area", --- 2022年当年（竣工面积）
    nvl(fma_next_due_time, next_due_time) AS "next_due_time", --- （公式）2022年交付项目（交付时间） 
    nvl(fma_next_delivery_installment, next_delivery_installment) AS "next_delivery_installment", --- （公式）2022年交付项目（交付分期及相应楼栋）
    nvl(fma_cutoff_last_started_area, cutoff_last_started_area) AS "cutoff_last_started_area", --- （公式）截止2020年开累（开工面积）
    nvl(fma_cutoff_last_completed_area, cutoff_last_completed_area) AS "cutoff_last_completed_area", --- （公式）截止2020年开累（竣工面积）
    nvl(fma_cutoff_sales_area, cutoff_sales_area) AS "cutoff_sales_area", ---（公式）截止2020年开累（销售面积）
    nvl(fma_cotoff_sales_amount, cotoff_sales_amount) AS "cotoff_sales_amount", --- （公式）截止2020年开累（销售金额）
    nvl(fma_remaining_value_area, remaining_value_area) AS "remaining_value_area", --- （公式）截止2020年开累（剩余货值面积）
    nvl(fma_remaining_value_amount, remaining_value_amount) AS "remaining_value_amount", --- （公式）截止2020年开累（剩余货值金额）
    nvl(fma_added_supply_area, added_supply_area) AS "added_supply_area", --- （公式）2021年预计完成（新增供货面积）
    nvl(fma_added_supply_amount, added_supply_amount) AS "added_supply_amount", --- （公式）2021年预计完成（新增供货金额）
    nvl(fma_expected_sales_area, expected_sales_area) AS "expected_sales_area", --- （公式）2021年预计完成（销售面积）
    nvl(fma_expected_sales_amount, expected_sales_amount) AS "expected_sales_amount", --- （公式）2021年预计完成（销售金额）
    nvl(fma_equity_sales_amount, equity_sales_amount) AS "equity_sales_amount", --- （公式）2021年预计完成（权益销售金额）
    nvl(fma_tired_supply_area, tired_supply_area) AS "tired_supply_area", --- （公式）截止2021年开累（开累供货（取预售证口径）面积）
    nvl(fma_tired_supply_amount, tired_supply_amount) AS "tired_supply_amount", --- （公式）截止2021年开累（开累供货（取预售证口径）金额）
    nvl(fma_tired_sales_area, tired_sales_area) AS "tired_sales_area", --- （公式）截止2021年开累（销售面积）
    nvl(fma_tired_sales_amount, tired_sales_amount) AS "tired_sales_amount", --- （公式）截止2021年开累（销售金额）
    nvl(fma_tired_stock_area, tired_stock_area) AS "tired_stock_area", --- （公式）截止2021年开累（已取预售证库存面积）
    nvl(fma_tired_stock_amount, tired_stock_amount) AS "tired_stock_amount", --- （公式）截止2021年开累（已取预售证库存金额）
    nvl(fma_tired_remaining_area, tired_remaining_area) AS "tired_remaining_area", --- （公式）截止2021年开累（剩余货值面积）
    nvl(fma_tired_remaining_amount, tired_remaining_amount) AS "tired_remaining_amount", --- （公式）截止2021年开累（剩余货值金额）
    nvl(fma_forecast_supply_area, forecast_supply_area) AS "forecast_supply_area", --- （公式）2022年预计完成（新增供货（取预售证口径）面积）
    nvl(fma_forecast_supply_amount, forecast_supply_amount) AS "forecast_supply_amount", --- （公式）2022年预计完成（新增供货（取预售证口径）金额）
    nvl(fma_forecast_sales_area, forecast_sales_area) AS "forecast_sales_area", --- （公式）2022年预计完成（销售面积）
    nvl(fma_forecast_sales_amount, forecast_sales_amount) AS "forecast_sales_amount", --- （公式）2022年预计完成（销售金额）
    nvl(fma_forecast_equity_amount, forecast_equity_amount) AS "forecast_equity_amount", --- （公式）2022年预计完成（权益销售金额）
    nvl(fma_forecast_tired_area, forecast_tired_area) AS "forecast_tired_area", --- （公式）截止2022年开累（已取预售证面积）
    nvl(fma_forecast_tired_amount, forecast_tired_amount) AS "forecast_tired_amount", --- （公式）截止2022年开累（已取预售证金额）
    nvl(fma_forecast_cotoff_area, forecast_cotoff_area) AS "forecast_cotoff_area", --- （公式）截止2022年开累（销售面积）
    nvl(fma_forecast_cotoff_amount, forecast_cotoff_amount) AS "forecast_cotoff_amount", --- （公式）截止2022年开累（销售金额）
    nvl(fma_forecast_stock_area, forecast_stock_area) AS "forecast_stock_area", --- （公式）截止2022年开累（已取预售证库存面积）
    nvl(fma_forecast_stock_amount, forecast_stock_amount) AS "forecast_stock_amount", --- （公式）截止2022年开累（已取预售证库存金额）
    nvl(fma_forecast_remaining_area, forecast_remaining_area) AS "forecast_remaining_area", --- （公式）截止2022年开累（剩余货值面积）
    nvl(fma_forecast_remaining_amount, forecast_remaining_amount) AS "forecast_remaining_amount", --- （公式）截止2022年开累（剩余货值金额）
    nvl(fma_sac_last_sale_amount, sac_last_sale_amount) AS "sac_last_sale_amount", --- （公式）销售回款（截止2020年开累，销售回款）
    nvl(fma_sac_last_unpaid_amount, sac_last_unpaid_amount) AS "sac_last_unpaid_amount", --- （公式）销售回款（截止2020年开累，已售未回款金额）
    nvl(fma_sac_then_sale_amount, sac_then_sale_amount) AS "sac_then_sale_amount", --- （公式）销售回款（2021年当年，销售回款）
    nvl(fma_sac_then_equity_sale, sac_then_equity_sale) AS "sac_then_equity_sale", --- （公式）销售回款（2021年当年，权益销售回款）
    nvl(fma_tried_sale_amount, tried_sale_amount) AS "tried_sale_amount", --- （公式）销售回款（截止2021年开累，销售回款）
    nvl(fma_tried_unpaid_amount, tried_unpaid_amount) AS "tried_unpaid_amount", --- （公式）销售回款（截止2021年开累，已售未回款金额）
    nvl(fma_sac_next_sale_amount, sac_next_sale_amount) AS "sac_next_sale_amount", --- （公式）销售回款（2022年当年，销售回款）
    nvl(fma_sac_next_equity_sale, sac_next_equity_sale) AS "sac_next_equity_sale", --- （公式）销售回款（2022年当年，权益销售回款）
    nvl(fma_sac_tried_sale_amount, sac_tried_sale_amount) AS "sac_tried_sale_amount", --- （公式）销售回款（截止2022年开累，销售回款）
    nvl(fma_sac_tried_unpaid_amount, sac_tried_unpaid_amount) AS "sac_tried_unpaid_amount", --- （公式）销售回款（截止2022年开累，已售未回款金额）
    nvl(fma_inv_last_investment, inv_last_investment) AS "inv_last_investment", --- （公式）投资、资金计划（截止2020年开累（总投资））
    nvl(fma_inv_then_actual, inv_then_actual) AS "inv_then_actual", --- （公式）投资、资金计划（2021年当年，实际完成投资）
    nvl(fma_inv_then_payment, inv_then_payment) AS "inv_then_payment", --- （公式）投资、资金计划（2021年当年，实际支付资金）
    nvl(fma_inv_invest_firm, inv_invest_firm) AS "inv_invest_firm", --- （公式）投资、资金计划（2021年当年，按照资金来源（企业自有资金））
    nvl(fma_inv_external_financing, inv_external_financing) AS "inv_external_financing", --- （公式）投资、资金计划（2021年当年，按照资金来源（外部融资））
    nvl(fma_inv_sales_collection, inv_sales_collection) AS "inv_sales_collection", --- （公式）投资、资金计划（2021年当年，按照资金来源（销售回款））
    nvl(fma_inv_land_price, inv_land_price) AS "inv_land_price", --- （公式）投资、资金计划（2021年当年，其中土地价款支付资金）
    nvl(fma_inv_then_investment, inv_then_investment) AS "inv_then_investment", --- （公式）投资、资金计划（截止2021年开累，总投资）
    nvl(fma_inv_plan_investment, inv_plan_investment) AS "inv_plan_investment", --- （公式）投资、资金计划（2022年当年，计划投资）
    nvl(fma_inv_invest_funds, inv_invest_funds) AS "inv_invest_funds", --- （公式）投资、资金计划（2022年当年，计划投入资金）
    nvl(fma_inv_next_invest_funds, inv_next_invest_funds) AS "inv_next_invest_funds", --- （公式）投资、资金计划（2022年当年，按照资金来源（企业自有资金））
    nvl(fma_inv_next_external_finan, inv_next_external_finan) AS "inv_next_external_finan", --- （公式）投资、资金计划（2022年当年，按照资金来源（外部融资））
    nvl(fma_inv_next_sales_collection, inv_next_sales_collection) AS "inv_next_sales_collection", --- （公式）投资、资金计划（2022年当年，按照资金来源（销售回款））
    nvl(fma_inv_next_land_price, inv_next_land_price) AS "inv_next_land_price", --- （公式）投资、资金计划（2022年当年，其中土地价款支付资金）
    nvl(fma_inv_next_investment, inv_next_investment) AS "inv_next_investment", --- （公式）投资、资金计划（截止2022年开累，总投资）
    nvl(fma_ltopera_income, ltopera_income) AS "ltopera_income", --- （公式）财务数据（截止2020年开累，营业收入）
    nvl(fma_ltopera_income_outside, ltopera_income_outside) AS "ltopera_income_outside", --- （公式）财务数据（截止2020年开累，营业收入（表外））
    nvl(fma_ltopera_income_inside, ltopera_income_inside) AS "ltopera_income_inside", --- （公式）财务数据（截止2020年开累，营业收入（表内+表外））
    nvl(fma_lttotal_profit, lttotal_profit) AS "lttotal_profit", --- （公式）财务数据（截止2020年开累，利润总额（全口径））
    nvl(fma_ltprofit_inside, ltprofit_inside) AS "ltprofit_inside", --- （公式）财务数据（截止2020年开累，净利润（表内））
    nvl(fma_ltprofit_outside, ltprofit_outside) AS "ltprofit_outside", --- （公式）财务数据（截止2020年开累，净利润（表外））
    nvl(fma_ltprofit_outside_equity, ltprofit_outside_equity) AS "ltprofit_outside_equity", --- （公式）财务数据（截止2020年开累，净利润（表外权益））
    nvl(fma_ltprofit_inside_equity, ltprofit_inside_equity) AS "ltprofit_inside_equity", --- （公式）财务数据（截止2020年开累，净利润（表内+表外权益））
    nvl(fma_thopera_income, thopera_income) AS "thopera_income", --- （公式）财务数据（2021年当年，营业收入（表内））
    nvl(fma_thopera_income_outside, thopera_income_outside) AS "thopera_income_outside", --- （公式）财务数据（2021年当年，营业收入（表外））
    nvl(fma_thopera_income_inside, thopera_income_inside) AS "thopera_income_inside", --- （公式）财务数据（2021年当年，营业收入（表内+表外））
    nvl(fma_thtotal_profit, thtotal_profit) AS "thtotal_profit", --- （公式）财务数据（2021年当年，利润总额（全口径））
    nvl(fma_thprofit_inside, thprofit_inside) AS "thprofit_inside", --- （公式）财务数据（2021年当年，净利润（表内））
    nvl(fma_thprofit_outside, thprofit_outside) AS "thprofit_outside", --- （公式）财务数据（2021年当年，净利润（表外））
    nvl(fma_thprofit_outside_equity, thprofit_outside_equity) AS "thprofit_outside_equity", --- （公式）财务数据（2021年当年，净利润（表外权益））
    nvl(fma_thprofit_inside_equity, thprofit_inside_equity) AS "thprofit_inside_equity", --- （公式）财务数据（2021年当年，净利润（表内+表外权益））
    nvl(fma_end_opera_income, end_opera_income) AS "end_opera_income", --- （公式）财务数据（截止2021年开累，营业收入（表内））
    nvl(fma_end_opera_income_outside, end_opera_income_outside) AS "end_opera_income_outside", --- （公式）财务数据（截止2021年开累，营业收入（表外））
    nvl(fma_end_opera_income_inside, end_opera_income_inside) AS "end_opera_income_inside", --- （公式）财务数据（截止2021年开累，营业收入（表内+表外））
    nvl(fma_end_total_profit, end_total_profit) AS "end_total_profit", --- （公式）财务数据（截止2021年开累，利润总额（全口径））
    nvl(fma_end_profit_inside, end_profit_inside) AS "end_profit_inside", --- （公式）财务数据（截止2021年开累，净利润（表内））
    nvl(fma_end_profit_outside, end_profit_outside) AS "end_profit_outside", --- （公式）财务数据（截止2021年开累，净利润（表外））
    nvl(fma_end_profit_outside_equity, end_profit_outside_equity) AS "end_profit_outside_equity", --- （公式）财务数据（截止2021年开累，净利润（表外权益））
    nvl(fma_end_profit_inside_equity, end_profit_inside_equity) AS "end_profit_inside_equity", --- （公式）财务数据（截止2021年开累，净利润（表内+表外权益））
    nvl(fma_ntprofit_inside_equity, ntprofit_inside_equity) AS "ntprofit_inside_equity", --- （公式）财务数据（2022年当年，营业收入（表内））
    nvl(fma_ntopera_income_outside, ntopera_income_outside) AS "ntopera_income_outside", --- （公式）财务数据（2022年当年，营业收入（表外））
    nvl(fma_ntopera_income_inside, ntopera_income_inside) AS "ntopera_income_inside", --- （公式）财务数据（2022年当年，营业收入（表内+表外））
    nvl(fma_nttotal_profit, nttotal_profit) AS "nttotal_profit", --- （公式）财务数据（2022年当年，利润总额（全口径））
    nvl(fma_ntprofit_inside, ntprofit_inside) AS "ntprofit_inside", --- （公式）财务数据（2022年当年，净利润（表内））
    nvl(fma_ntprofit_outside, ntprofit_outside) AS "ntprofit_outside", --- （公式）财务数据（2022年当年，净利润（表外））
    nvl(fma_ntprofit_outside_equity, ntprofit_outside_equity) AS "ntprofit_outside_equity", --- （公式）财务数据（2022年当年，净利润（表外权益））
    nvl(fma_ntprofit_rights_equity, ntprofit_rights_equity) AS "ntprofit_rights_equity", --- （公式）财务数据（2022年当年，净利润（表内+表外权益））
    nvl(fma_entnt_opera_income, entnt_opera_income) AS "entnt_opera_income", --- （公式）财务数据（截止2022年开累，营业收入（表内））
    nvl(fma_entnt_opera_income_out, entnt_opera_income_out) AS "entnt_opera_income_out", --- （公式）财务数据（截止2022年开累，营业收入（表外））
    nvl(fma_entnt_opera_income_ins, entnt_opera_income_ins) AS "entnt_opera_income_ins", --- （公式）财务数据（截止2022年开累，营业收入（表内+表外））
    nvl(fma_entnt_total_profit, entnt_total_profit) AS "entnt_total_profit", --- （公式）财务数据（截止2022年开累，利润总额（全口径））
    nvl(fma_entnt_profit_inside, entnt_profit_inside) AS "entnt_profit_inside", --- （公式）财务数据（截止2022年开累，净利润（表内））
    nvl(fma_entnt_profit_outside, entnt_profit_outside) AS "entnt_profit_outside", --- （公式）财务数据（截止2022年开累，净利润（表外））
    nvl(fma_entnt_profit_out_equity, entnt_profit_out_equity) AS "entnt_profit_out_equity", --- （公式）财务数据（截止2022年开累，净利润（表外权益））
    nvl(fma_entnt_profit_ins_equity, entnt_profit_ins_equity) AS "entnt_profit_ins_equity", --- （公式）财务数据（截止2022年开累，净利润（表内+表外权益））
    nvl(fma_own_return_time, own_return_time) AS "own_return_time", --- （公式）财务数据（自有资金回正时间）
    nvl(fma_full_return_time, full_return_time) AS "full_return_time", --- （公式）财务数据（全投资回正时间）
    nvl(fma_freed_value, freed_value) AS "freed_value", --- （公式）财务数据（未来两年产值释放计划，）
    nvl(fma_tomar_opera_income, tomar_opera_income) AS "tomar_opera_income", --- （公式）财务数据（2023年，营业收入）
    nvl(fma_tomar_opera_income_ins, tomar_opera_income_ins) AS "tomar_opera_income_ins", --- （公式）财务数据（2023年，营业收入（表内））
    nvl(fma_tomar_total_profit, tomar_total_profit) AS "tomar_total_profit", --- （公式）财务数据（2023年，利润总额（全口径））
    nvl(fma_tomar_profit_inside, tomar_profit_inside) AS "tomar_profit_inside", --- （公式）财务数据（2023年，净利润）
    nvl(fma_tomar_profit_equity, tomar_profit_equity) AS "tomar_profit_equity", --- （公式）财务数据（2023年，净利润（表内+表外权益））
    nvl(fma_toapr_opera_income, toapr_opera_income) AS "toapr_opera_income", --- （公式）财务数据（2024年、营业收入）
    nvl(fma_toapr_opera_income_ins, toapr_opera_income_ins) AS "toapr_opera_income_ins", --- （公式）财务数据（2024年、营业收入（表内））
    nvl(fma_toapr_total_profit, toapr_total_profit) AS "toapr_total_profit", --- （公式）财务数据（2024年、利润总额（全口径））
    nvl(fma_toapr_profit_inside, toapr_profit_inside) AS "toapr_profit_inside", --- （公式）财务数据（2024年、净利润）
    nvl(fma_toapr_profit_equity, toapr_profit_equity) AS "toapr_profit_equity", --- （公式）财务数据（2024年、净利润（表内+表外权益））
    created, --- 创建时间
    creator_id, ---创建人ID
    creator, ---创建人
    modified, --- 最近修改时间
    modifier_id, ---最近修改人ID
    modifier  ---最近修改人
FROM
    opm_group_operating_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END P_OPM_ED_GROUP_OPERATING;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_PROJ" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
projectid in VARCHAR2,---所属项目id
planyear in number,--计划年
projsheet1 OUT SYS_REFCURSOR,--1、sheet页的数据源集合 【根据集合顺序】
projsheet2 OUT SYS_REFCURSOR,--2、sheet页的数据源集合 【根据集合顺序】
projsheet3 OUT SYS_REFCURSOR,--3、sheet页的数据源集合 【根据集合顺序】
projsheet4 OUT SYS_REFCURSOR--4、sheet页的数据源集合 【根据集合顺序】
) AS 
BEGIN
--- proj_sheet1
BEGIN P_OPM_ED_PROJ_INVENTORY(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    projectid => projectid,
    PLANYEAR => PLANYEAR,
    PROJSHEET1 => PROJSHEET1
  );end;
--- proj_sheet2
BEGIN P_OPM_ED_PROJ_INVESTMENT(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    projectid => projectid,
    PLANYEAR => PLANYEAR,
    PROJSHEET2 => PROJSHEET2
  );end;
--- proj_sheet3
BEGIN P_OPM_ED_PROJ_BUDGET(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    projectid => projectid,
    PLANYEAR => PLANYEAR,
    PROJSHEET3 => PROJSHEET3
  );end;
--- proj_sheet4
BEGIN P_OPM_ED_PROJ_OPERATING(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    projectid => projectid,
    PLANYEAR => PLANYEAR,
    PROJSHEET4 => PROJSHEET4
  );end;
END P_OPM_ED_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_PROJ_BUDGET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_PROJ_BUDGET" (
    userid         IN    VARCHAR2,--当前用户id
    stationid      IN    VARCHAR2,--当前用户岗位id
    departmentid   IN    VARCHAR2,--当前用户部门id
    companyid      IN    VARCHAR2,--当前用户公司id
    projectid      IN    VARCHAR2,--所属项目id
    planyear       IN    NUMBER,--计划年
    projsheet3     OUT   SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
BEGIN
    OPEN projsheet3 FOR 
    SELECT
    id,
    plan_year, ---计划年份
    order_code, ---顺序
    object_type, ---类型（销售回款、销售收入…）
    object_id, ---对象id
    object_main_name, ---项目主标题（资金来源、资金运用…）
    object_sub_name, ---项目副标题
    belong_proj_id, ---所属项目ID
    nvl(fma_previous_total, previous_total) AS "previous_total", ---2019年之前实际发生合计
    nvl(fma_tosep_budget_total, tosep_budget_total) AS "tosep_budget_total", ---2020年预算（1-9月实际发生）
    nvl(fma_todec_budget_total, todec_budget_total) AS "todec_budget_total", ---2020年预算（10-12月申报）
    nvl(fma_last_declaration_total, last_declaration_total) AS "last_declaration_total", ---2020年预算（合计申报）
    nvl(fma_last_cumulative_amount, last_cumulative_amount) AS "last_cumulative_amount", ---2020年末累计金额
    nvl(fma_plan_amount, plan_amount) AS "plan_amount", ---2021年计划金额（申报）
    nvl(fma_cumulative_amount, cumulative_amount) AS "cumulative_amount", ---2021年末累计金额
    remark ---备注
FROM
    opm_proj_budget
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END p_opm_ed_proj_budget;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_PROJ_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_PROJ_INVENTORY" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
projectid IN VARCHAR2,--所属项目id
planyear in number,--计划年
projsheet1 OUT SYS_REFCURSOR--1、sheet1 附表1
) AS 
BEGIN
OPEN projsheet1 FOR 
SELECT
     id,
     plan_year ---计划年份
     ,
     parent_id ---父级ID
     ,
     level_code ---层级：1开始
     ,
     order_code ---顺序
     ,
     object_id ---对象ID
     ,
     object_name ---项目名称与分期
     ,
     object_type ---业态（住宅、商办产业、车位仓储、配套设施、合计）
     ,
     nvl(fma_saleable_area, saleable_area) AS "saleable_area", ---（公式）全案总可售货值（面积）
     nvl(fma_saleable_number, saleable_number) AS "saleable_number", ---（公式）全案总可售货值（套数）
     nvl(fma_saleable_amount, saleable_amount) AS "saleable_amount", ---（公式）全案总可售货值（金额）
     nvl(fma_saleable_price, saleable_price) AS "saleable_price", ---（公式）全案总可售货值（平方单价）
     nvl(fma_tired_sale_area, tired_sale_area) AS "tired_sale_area", ---（公式）开累已取预售总货值（面积）
     nvl(fma_tired_sale_number, tired_sale_number) AS "tired_sale_number", ---（公式）开累已取预售总货值（套数）
     nvl(fma_tired_sale_amount, tired_sale_amount) AS "tired_sale_amount", ---（公式）开累已取预售总货值（金额）
     nvl(fma_tired_sale_price, tired_sale_price) AS "tired_sale_price", ---（公式）开累已取预售总货值（平米单价）
     nvl(fma_tired_complete_area, tired_complete_area) AS "tired_complete_area", ---（公式）开累完成销售（面积）
     nvl(fma_tired_complete_number, tired_complete_number) AS "tired_complete_number", ---（公式）开累完成销售（套数）
     nvl(fma_tired_complete_amount, tired_complete_amount) AS "tired_complete_amount", ---（公式）开累完成销售（金额）
     nvl(fma_tired_complete_price, tired_complete_price) AS "tired_complete_price", ---（公式）开累完成销售（平米单价）
     nvl(fma_stock_area, stock_area) AS "stock_area", ---（公式）全案库存（面积）
     nvl(fma_stock_number, stock_number) AS "stock_number", ---（公式）全案库存（套数）
     nvl(fma_stock_amount, stock_amount) AS "stock_amount", ---（公式）全案库存（金额）
     nvl(fma_stock_price, stock_price) AS "stock_price", ---（公式）全案库存（平米单价）
     nvl(fma_sale_area, sale_area) AS "sale_area", ---（公式）已取预售证库存（面积）
     nvl(fma_sale_sleeve, sale_sleeve) AS "sale_sleeve", ---（公式）已取预售证库存（套数）
     nvl(fma_sale_amount, sale_amount) AS "sale_amount", ---（公式）已取预售证库存（金额）
     nvl(fma_sale_price, sale_price) AS "sale_price", ---（公式）已取预售证库存（平米单价）
     nvl(fma_supply_area, supply_area) AS "supply_area", ---（公式）2021年供货计划（面积）
     nvl(fma_supply_sleeve, supply_sleeve) AS "supply_sleeve", ---（公式）2021年供货计划（套数）
     nvl(fma_supply_amount, supply_amount) AS "supply_amount", ---（公式）2021年供货计划（金额）
     nvl(fma_supply_price, supply_price) AS "supply_price", ---（公式）2021年供货计划（平米单价）
     nvl(fma_sales_area, sales_area) AS "sales_area", ---（公式）2021年销售计划（面积）
     nvl(fma_sales_sleeve, sales_sleeve) AS "sales_sleeve", ---（公式）2021年销售计划（套数）
     nvl(fma_sales_amount, sales_amount) AS "sales_amount", ---（公式）2021年销售计划（金额）
     nvl(fma_sales_price, sales_price) AS "sales_price", ---（公式）2021年销售计划（平米单价）
     nvl(fma_jan_supply_area, jan_supply_area) AS "jan_supply_area", ---（公式）第一个月（供应）（面积）
     nvl(fma_jan_supply_sleeve, jan_supply_sleeve) AS "jan_supply_sleeve", ---（公式）第一个月（供应）（套数）
     nvl(fma_jan_supply_amount, jan_supply_amount) AS "jan_supply_amount", ---（公式）第一个月（供应）（金额）
     nvl(fma_jan_sales_area, jan_sales_area) AS "jan_sales_area", ---（公式）第一个月（销售）（面积）
     nvl(fma_jan_sales_sleeve, jan_sales_sleeve) AS "jan_sales_sleeve", ---（公式）第一个月（销售）（套数）
     nvl(fma_jan_sales_amount, jan_sales_amount) AS "jan_sales_amount", ---（公式）第一个月（销售）（金额）
     nvl(fma_feb_supply_area, feb_supply_area) AS "feb_supply_area", ---（公式）第二个月（供应）（面积）
     nvl(fma_feb_supply_sleeve, feb_supply_sleeve) AS "feb_supply_sleeve", ---（公式）第二个月（供应）（套数）
     nvl(fma_feb_supply_amount, feb_supply_amount) AS "feb_supply_amount", ---（公式）第二个月（供应）（金额）
     nvl(fma_feb_sales_area, feb_sales_area) AS "feb_sales_area", ---（公式）第二个月（销售）（面积）
     nvl(fma_feb_sales_sleeve, feb_sales_sleeve) AS "feb_sales_sleeve", ---（公式）第二个月（销售）（套数）
     nvl(fma_feb_sales_amount, feb_sales_amount) AS "feb_sales_amount", ---（公式）第二个月（销售）（金额）
     nvl(fma_mar_supply_area, mar_supply_area) AS "mar_supply_area", ---（公式）第三个月（供应）（面积）
     nvl(fma_mar_supply_sleeve, mar_supply_sleeve) AS "mar_supply_sleeve", ---（公式）第三个月（供应）（套数）
     nvl(fma_mar_supply_amount, mar_supply_amount) AS "mar_supply_amount", ---（公式）第三个月（供应）（金额）
     nvl(fma_mar_sales_area, mar_sales_area) AS "mar_sales_area", ---（公式）第三个月（销售）（面积）
     nvl(fma_mar_sales_sleeve, mar_sales_sleeve) AS "mar_sales_sleeve", ---（公式）第三个月（销售）（套数）
     nvl(fma_mar_sales_amount, mar_sales_amount) AS "mar_sales_amount", ---（公式）第三个月（销售）（金额）
     nvl(fma_apr_supply_area, apr_supply_area) AS "apr_supply_area", ---（公式）第四个月（供应）（面积）
     nvl(fma_apr_supply_sleeve, apr_supply_sleeve) AS "apr_supply_sleeve", ---（公式）第四个月（供应）（套数）
     nvl(fma_apr_supply_amount, apr_supply_amount) AS "apr_supply_amount", ---（公式）第四个月（供应）（金额）
     nvl(fma_apr_sales_area, apr_sales_area) AS "apr_sales_area", ---（公式）第四个月（销售）（面积）
     nvl(fma_apr_sales_sleeve, apr_sales_sleeve) AS "apr_sales_sleeve", ---（公式）第四个月（销售）（套数）
     nvl(fma_apr_sales_amount, apr_sales_amount) AS "apr_sales_amount", ---（公式）第四个月（销售）（金额）
     nvl(fma_may_supply_area, may_supply_area) AS "may_supply_area", ---（公式）第五个月（供应）（面积）
     nvl(fma_may_supply_sleeve, may_supply_sleeve) AS "may_supply_sleeve", ---（公式）第五个月（供应）（套数）
     nvl(fma_may_supply_amount, may_supply_amount) AS "may_supply_amount", ---（公式）第五个月（供应）（金额）
     nvl(fma_may_sales_area, may_sales_area) AS "may_sales_area", ---（公式）第五个月（销售）（面积）
     nvl(fma_may_sales_sleeve, may_sales_sleeve) AS "may_sales_sleeve", ---（公式）第五个月（销售）（套数）
     nvl(fma_may_sales_amount, may_sales_amount) AS "may_sales_amount", ---（公式）第五个月（销售）（金额）
     nvl(fma_june_supply_area, june_supply_area) AS "june_supply_area", ---（公式）第六个月（供应）（面积）
     nvl(fma_june_supply_sleeve, june_supply_sleeve) AS "june_supply_sleeve", ---（公式）第六个月（供应）（套数）
     nvl(fma_june_supply_amount, june_supply_amount) AS "june_supply_amount", ---（公式）第六个月（供应）（金额）
     nvl(fma_june_sales_area, june_sales_area) AS "june_sales_area", ---（公式）第六个月（销售）（面积）
     nvl(fma_june_sales_sleeve, june_sales_sleeve) AS "june_sales_sleeve", ---（公式）第六个月（销售）（套数）
     nvl(fma_june_sales_amount, june_sales_amount) AS "june_sales_amount", ---（公式）第六个月（销售）（金额）
     nvl(fma_july_supply_area, july_supply_area) AS "july_supply_area", ---（公式）第七个月（供应）（面积）
     nvl(fma_july_supply_sleeve, july_supply_sleeve) AS "july_supply_sleeve", ---（公式）第七个月（供应）（套数）
     nvl(fma_july_supply_amount, july_supply_amount) AS "july_supply_amount", ---（公式）第七个月（供应）（金额）
     nvl(fma_july_sales_area, july_sales_area) AS "july_sales_area", ---（公式）第七个月（销售）（面积）
     nvl(fma_july_sales_sleeve, july_sales_sleeve) AS "july_sales_sleeve", ---（公式）第七个月（销售）（套数）
     nvl(fma_july_sales_amount, july_sales_amount) AS "july_sales_amount", ---（公式）第七个月（销售）（金额）
     nvl(fma_aug_supply_area, aug_supply_area) AS "aug_supply_area", ---（公式）第八个月（供应）（面积）
     nvl(fma_aug_supply_sleeve, aug_supply_sleeve) AS "aug_supply_sleeve", ---（公式）第八个月（供应）（套数）
     nvl(fma_aug_supply_amount, aug_supply_amount) AS "aug_supply_amount", ---（公式）第八个月（供应）（金额）
     nvl(fma_aug_sales_area, aug_sales_area) AS "aug_sales_area", ---（公式）第八个月（销售）（面积）
     nvl(fma_aug_sales_sleeve, aug_sales_sleeve) AS "aug_sales_sleeve", ---（公式）第八个月（销售）（套数）
     nvl(fma_aug_sales_amount, aug_sales_amount) AS "aug_sales_amount", ---（公式）第八个月（销售）（金额）
     nvl(fma_sep_supply_area, sep_supply_area) AS "sep_supply_area", ---（公式）第九个月（供应）（面积）
     nvl(fma_sep_supply_sleeve, sep_supply_sleeve) AS "sep_supply_sleeve", ---（公式）第九个月（供应）（套数）
     nvl(fma_sep_supply_amount, sep_supply_amount) AS "sep_supply_amount", ---（公式）第九个月（供应）（金额）
     nvl(fma_sep_sales_area, sep_sales_area) AS "sep_sales_area", ---（公式）第九个月（销售）（面积）
     nvl(fma_sep_sales_sleeve, sep_sales_sleeve) AS "sep_sales_sleeve", ---（公式）第九个月（销售）（套数）
     nvl(fma_sep_sales_amount, sep_sales_amount) AS "sep_sales_amount", ---（公式）第九个月（销售）（金额）
     nvl(fma_oct_supply_area, oct_supply_area) AS "oct_supply_area", ---（公式）第十个月（供应）（面积）
     nvl(fma_oct_supply_sleeve, oct_supply_sleeve) AS "oct_supply_sleeve", ---（公式）第十个月（供应）（套数）
     nvl(fma_oct_supply_amount, oct_supply_amount) AS "oct_supply_amount", ---（公式）第十个月（供应）（金额）
     nvl(fma_oct_sales_area, oct_sales_area) AS "oct_sales_area", ---（公式）第十个月（销售）（面积）
     nvl(fma_oct_sales_sleeve, oct_sales_sleeve) AS "oct_sales_sleeve", ---（公式）第十个月（销售）（套数）
     nvl(fma_oct_sales_amount, oct_sales_amount) AS "oct_sales_amount", ---（公式）第十个月（销售）（金额）
     nvl(fma_nov_supply_area, nov_supply_area) AS "nov_supply_area", ---（公式）第十一个月（供应）（面积）
     nvl(fma_nov_supply_sleeve, nov_supply_sleeve) AS "nov_supply_sleeve", ---（公式）第十一个月（供应）（套数）
     nvl(fma_nov_supply_amount, nov_supply_amount) AS "nov_supply_amount", ---（公式）第十一个月（供应）（金额）
     nvl(fma_nov_sales_area, nov_sales_area) AS "nov_sales_area", ---（公式）第十一个月（销售）（面积）
     nvl(fma_nov_sales_sleeve, nov_sales_sleeve) AS "nov_sales_sleeve", ---（公式）第十一个月（销售）（套数）
     nvl(fma_nov_sales_amount, nov_sales_amount) AS "nov_sales_amount", ---（公式）第十一个月（销售）（金额）
     nvl(fma_dec_supply_area, dec_supply_area) AS "dec_supply_area", ---（公式）第十二个月（供应）（面积）
     nvl(fma_dec_supply_sleeve, dec_supply_sleeve) AS "dec_supply_sleeve", ---（公式）第十二个月（供应）（套数）
     nvl(fma_dec_supply_amount, dec_supply_amount) AS "dec_supply_amount", ---（公式）第十二个月（供应）（金额）
     nvl(fma_dec_sales_area, dec_sales_area) AS "dec_sales_area", ---（公式）第十二个月（销售）（面积）
     nvl(fma_dec_sales_sleeve, dec_sales_sleeve) AS "dec_sales_sleeve", ---（公式）第十二个月（销售）（套数）
     nvl(fma_dec_sales_amount, dec_sales_amount) AS "dec_sales_amount", ---（公式）第十二个月（销售）（金额）
     nvl(fma_fina_stock_area, fina_stock_area) AS "fina_stock_area", ---
     nvl(fma_fina_stock_number, fina_stock_number) AS "fina_stock_number", ---
     nvl(fma_fina_stock_amount, fina_stock_amount) AS "fina_stock_amount", ---
     nvl(fma_fina_stock_price, fina_stock_price) AS "fina_stock_price", ---
     nvl(fma_fina_sale_area, fina_sale_area) AS "fina_sale_area", ---
     nvl(fma_fina_sale_number, fina_sale_number) AS "fina_sale_number", ---
     nvl(fma_fina_sale_amout, fina_sale_amout) AS "fina_sale_amout", ---
     nvl(fma_fina_sale_price, fina_sale_price) AS "fina_sale_price", ---
     nvl(fma_supply_one_amount, supply_one_amount) AS "supply_one_amount", ---（公式）供货均衡性分析（S1）金额
     nvl(fma_supply_one_ratio, supply_one_ratio) AS "supply_one_ratio", ---（公式）供货均衡性分析（S1）占比
     nvl(fma_supply_two_amount, supply_two_amount) AS "supply_two_amount", ---（公式）供货均衡性分析（S2）金额
     nvl(fma_supply_two_ratio, supply_two_ratio) AS "supply_two_ratio", ---（公式）供货均衡性分析（S2）占比
     nvl(fma_supply_three_amount, supply_three_amount) AS "supply_three_amount", ---（公式）供货均衡性分析（S3）金额
     nvl(fma_supply_three_ratio, supply_three_ratio) AS "supply_three_ratio", ---（公式）供货均衡性分析（S3）占比
     nvl(fma_supply_four_amount, supply_four_amount) AS "supply_four_amount", ---（公式）供货均衡性分析（S4）金额
     nvl(fma_supply_four_ratio, supply_four_ratio) AS "supply_four_ratio", ---（公式）供货均衡性分析（S4）占比
     nvl(fma_sales_one_amount, sales_one_amount) AS "sales_one_amount", ---（公式）销售均衡性分析（S1）金额
     nvl(fma_sales_one_ratio, sales_one_ratio) AS "sales_one_ratio", ---（公式）销售均衡性分析（S1）占比
     nvl(fma_sales_two_amount, sales_two_amount) AS "sales_two_amount", ---（公式）销售均衡性分析（S2）金额
     nvl(fma_sales_two_ratio, sales_two_ratio) AS "sales_two_ratio", ---（公式）销售均衡性分析（S2）占比
     nvl(fma_sales_three_amount, sales_three_amount) AS "sales_three_amount", ---（公式）销售均衡性分析（S3）金额
     nvl(fma_sales_three_ratio, sales_three_ratio) AS "sales_three_ratio", ---（公式）销售均衡性分析（S3）占比
     nvl(fma_sales_four_amount, sales_four_amount) AS "sales_four_amount", ---（公式）销售均衡性分析（S4）金额
     nvl(fma_sales_four_ratio, sales_four_ratio) AS "sales_four_ratio", ---（公式）销售均衡性分析（S4）占比
     nvl(fma_desalination_rate, desalination_rate) AS "desalination_rate", ---（公式）去化率
     nvl(fma_ny_first_supply_area, ny_first_supply_area) AS "ny_first_supply_area", ---（公式）2022一季度（供应）（面积）
     nvl(fma_ny_first_supply_number, ny_first_supply_number) AS "ny_first_supply_number", ---（公式）2022一季度（供应）（套数）
     nvl(fma_ny_first_supply_amount, ny_first_supply_amount) AS "ny_first_supply_amount", ---（公式）2022一季度（供应）（金额）
     nvl(fma_ny_first_sale_area, ny_first_sale_area) AS "ny_first_sale_area", ---（公式）2022一季度（销售）（面积）
     nvl(fma_ny_first_sale_number, ny_first_sale_number) AS "ny_first_sale_number", ---（公式）2022一季度（销售）（套数）
     nvl(fma_ny_first_sale_amount, ny_first_sale_amount) AS "ny_first_sale_amount", ---（公式）2022一季度（销售）（金额）
     nvl(fma_ny_second_supply_area, ny_second_supply_area) AS "ny_second_supply_area", ---（公式）2022二季度（供应）（面积）
     nvl(fma_ny_second_supply_number, ny_second_supply_number) AS "ny_second_supply_number", ---（公式）2022二季度（供应）（套数）
     nvl(fma_ny_second_supply_amount, ny_second_supply_amount) AS "ny_second_supply_amount", ---（公式）2022二季度（供应）（金额）
     nvl(fma_ny_second_sale_area, ny_second_sale_area) AS "ny_second_sale_area", ---（公式）2022二季度（销售）（面积）
     nvl(fma_ny_second_sale_number, ny_second_sale_number) AS "ny_second_sale_number", ---（公式）2022二季度（销售）（套数）
     nvl(fma_ny_second_sale_amount, ny_second_sale_amount) AS "ny_second_sale_amount", ---（公式）2022二季度（销售）（金额）
     nvl(fma_ny_third_supply_area, ny_third_supply_area) AS "ny_third_supply_area", ---（公式）2022三季度（供应）（面积）
     nvl(fma_ny_third_supply_number, ny_third_supply_number) AS "ny_third_supply_number", ---（公式）2022三季度（供应）（套数）
     nvl(fma_ny_third_supply_amount, ny_third_supply_amount) AS "ny_third_supply_amount", ---（公式）2022三季度（供应）（金额）
     nvl(fma_ny_third_sale_area, ny_third_sale_area) AS "ny_third_sale_area", ---（公式）2022三季度（销售）（面积）
     nvl(fma_ny_third_sale_number, ny_third_sale_number) AS "ny_third_sale_number", ---（公式）2022三季度（销售）（套数）
     nvl(fma_ny_third_sale_amount, ny_third_sale_amount) AS "ny_third_sale_amount", ---（公式）2022三季度（销售）（金额）
     nvl(fma_ny_fourth_supply_area, ny_fourth_supply_area) AS "ny_fourth_supply_area", ---（公式）2022四季度（供应）（面积）
     nvl(fma_ny_fourth_supply_number, ny_fourth_supply_number) AS "ny_fourth_supply_number", ---（公式）2022四季度（供应）（套数）
     nvl(fma_ny_fourth_supply_amount, ny_fourth_supply_amount) AS "ny_fourth_supply_amount", ---（公式）2022四季度（供应）（金额）
     nvl(fma_ny_fourth_sale_area, ny_fourth_sale_area) AS "ny_fourth_sale_area", ---（公式）2022四季度（销售）（面积）
     nvl(fma_ny_fourth_sale_number, ny_fourth_sale_number) AS "ny_fourth_sale_number", ---（公式）2022四季度（销售）（套数）
     nvl(fma_ny_fourth_sale_amount, ny_fourth_sale_amount) AS "ny_fourth_sale_amount", ---（公式）2022四季度（销售）（金额）
     nvl(fma_ncy_first_supply_area, ncy_first_supply_area) AS "ncy_first_supply_area", ---（公式）2023一季度（供应）（面积）
     nvl(fma_ncy_first_supply_number, ncy_first_supply_number) AS "ncy_first_supply_number", ---（公式）2023一季度（供应）（套数）
     nvl(fma_ncy_first_supply_amount, ncy_first_supply_amount) AS "ncy_first_supply_amount", ---（公式）2023一季度（供应）（金额）
     nvl(fma_ncy_first_sale_area, ncy_first_sale_area) AS "ncy_first_sale_area", ---（公式）2023一季度（销售）（面积）
     nvl(fma_ncy_first_sale_number, ncy_first_sale_number) AS "ncy_first_sale_number", ---（公式）2023一季度（销售）（套数）
     nvl(fma_ncy_first_sale_amount, ncy_first_sale_amount) AS "ncy_first_sale_amount", ---（公式）2023一季度（销售）（金额）
     nvl(fma_ncy_second_supply_area, ncy_second_supply_area) AS "ncy_second_supply_area", ---（公式）2023二季度（供应）（面积）
     nvl(fma_ncy_second_supply_number, ncy_second_supply_number) AS "ncy_second_supply_number", ---（公式）2023二季度（供应）（套数）
     nvl(fma_ncy_second_supply_amount, ncy_second_supply_amount) AS "ncy_second_supply_amount", ---（公式）2023二季度（供应）（金额）
     nvl(fma_ncy_second_sale_area, ncy_second_sale_area) AS "ncy_second_sale_area", ---（公式）2023二季度（销售）（面积）
     nvl(fma_ncy_second_sale_number, ncy_second_sale_number) AS "ncy_second_sale_number", ---（公式）2023二季度（销售）（套数）
     nvl(fma_ncy_second_sale_amount, ncy_second_sale_amount) AS "ncy_second_sale_amount", ---（公式）2023二季度（销售）（金额）
     nvl(fma_ncy_third_supply_area, ncy_third_supply_area) AS "ncy_third_supply_area", ---（公式）2023三季度（供应）（面积）
     nvl(fma_ncy_third_supply_number, ncy_third_supply_number) AS "ncy_third_supply_number", ---（公式）2023三季度（供应）（套数）
     nvl(fma_ncy_third_supply_amount, ncy_third_supply_amount) AS "ncy_third_supply_amount", ---（公式）2023三季度（供应）（金额）
     nvl(fma_ncy_third_sale_area, ncy_third_sale_area) AS "ncy_third_sale_area", ---（公式）2023三季度（销售）（面积）
     nvl(fma_ncy_third_sale_number, ncy_third_sale_number) AS "ncy_third_sale_number", ---（公式）2023三季度（销售）（套数）
     nvl(fma_ncy_third_sale_amount, ncy_third_sale_amount) AS "ncy_third_sale_amount", ---（公式）2023三季度（销售）（金额）
     nvl(fma_ncy_fourth_supply_area, ncy_fourth_supply_area) AS "ncy_fourth_supply_area", ---（公式）2023四季度（供应）（面积）
     nvl(fma_ncy_fourth_supply_number, ncy_fourth_supply_number) AS "ncy_fourth_supply_number", ---（公式）2023四季度（供应）（套数）
     nvl(fma_ncy_fourth_supply_amount, ncy_fourth_supply_amount) AS "ncy_fourth_supply_amount", ---（公式）2023四季度（供应）（金额）
     nvl(fma_ncy_fourth_sale_area, ncy_fourth_sale_area) AS "ncy_fourth_sale_area", ---（公式）2023四季度（销售）（面积）
     nvl(fma_ncy_fourth_sale_number, ncy_fourth_sale_number) AS "ncy_fourth_sale_number", ---（公式）2023四季度（销售）（套数）
     nvl(fma_ncy_fourth_sale_amount, ncy_fourth_sale_amount) AS "ncy_fourth_sale_amount", ---（公式）2023四季度（销售）（金额）
     nvl(fma_nty_first_supply_area, nty_first_supply_area) AS "nty_first_supply_area", ---（公式）2024一季度（供应）（面积）
     nvl(fma_nty_first_supply_number, nty_first_supply_number) AS "nty_first_supply_number", ---（公式）2024一季度（供应）（套数）
     nvl(fma_nty_first_supply_amount, nty_first_supply_amount) AS "nty_first_supply_amount", ---（公式）2024一季度（供应）（金额）
     nvl(fma_nty_first_sale_area, nty_first_sale_area) AS "nty_first_sale_area", ---（公式）2024一季度（销售）（面积）
     nvl(fma_nty_first_sale_number, nty_first_sale_number) AS "nty_first_sale_number", ---（公式）2024一季度（销售）（套数）
     nvl(fma_nty_first_sale_amount, nty_first_sale_amount) AS "nty_first_sale_amount", ---（公式）2024一季度（销售）（金额）
     nvl(fma_nty_second_supply_area, nty_second_supply_area) AS "nty_second_supply_area", ---（公式）2024二季度（供应）（面积）
     nvl(fma_nty_second_supply_number, nty_second_supply_number) AS "nty_second_supply_number", ---（公式）2024二季度（供应）（套数）
     nvl(fma_nty_second_supply_amount, nty_second_supply_amount) AS "nty_second_supply_amount", ---（公式）2024二季度（供应）（金额）
     nvl(fma_nty_second_sale_area, nty_second_sale_area) AS "nty_second_sale_area", ---（公式）2024二季度（销售）（面积）
     nvl(fma_nty_second_sale_number, nty_second_sale_number) AS "nty_second_sale_number", ---（公式）2024二季度（销售）（套数）
     nvl(fma_nty_second_sale_amount, nty_second_sale_amount) AS "nty_second_sale_amount", ---（公式）2024二季度（销售）（金额）
     nvl(fma_nty_third_supply_area, nty_third_supply_area) AS "nty_third_supply_area", ---（公式）2024三季度（供应）（面积）
     nvl(fma_nty_third_supply_number, nty_third_supply_number) AS "nty_third_supply_number", ---（公式）2024三季度（供应）（套数）
     nvl(fma_nty_third_supply_amount, nty_third_supply_amount) AS "nty_third_supply_amount", ---（公式）2024三季度（供应）（金额）
     nvl(fma_nty_third_sale_area, nty_third_sale_area) AS "nty_third_sale_area", ---（公式）2024三季度（销售）（面积）
     nvl(fma_nty_third_sale_number, nty_third_sale_number) AS "nty_third_sale_number", ---（公式）2024三季度（销售）（套数）
     nvl(fma_nty_third_sale_amount, nty_third_sale_amount) AS "nty_third_sale_amount", ---（公式）2024三季度（销售）（金额）
     nvl(fma_nty_fourth_supply_area, nty_fourth_supply_area) AS "nty_fourth_supply_area", ---（公式）2024四季度（供应）（面积）
     nvl(fma_nty_fourth_supply_number, nty_fourth_supply_number) AS "nty_fourth_supply_number", ---（公式）2024四季度（供应）（套数）
     nvl(fma_nty_fourth_supply_amount, nty_fourth_supply_amount) AS "nty_fourth_supply_amount", ---（公式）2024四季度（供应）（金额）
     nvl(fma_nty_fourth_sale_area, nty_fourth_sale_area) AS "nty_fourth_sale_area", ---（公式）2024四季度（销售）（面积）
     nvl(fma_nty_fourth_sale_number, nty_fourth_sale_number) AS "nty_fourth_sale_number", ---（公式）2024四季度（销售）（套数）
     nvl(fma_nty_fourth_sale_amount, nty_fourth_sale_amount) AS "nty_fourth_sale_amount", ---（公式）2024四季度（销售）（金额）
     nvl(fma_nfy_first_supply_area, nfy_first_supply_area) AS "nfy_first_supply_area", ---（公式）2025一季度（供应）（面积）
     nvl(fma_nfy_first_supply_number, nfy_first_supply_number) AS "nfy_first_supply_number", ---（公式）2025一季度（供应）（套数）
     nvl(fma_nfy_first_supply_amount, nfy_first_supply_amount) AS "nfy_first_supply_amount", ---（公式）2025一季度（供应）（金额）
     nvl(fma_nfy_first_sale_area, nfy_first_sale_area) AS "nfy_first_sale_area", ---（公式）2025一季度（销售）（面积）
     nvl(fma_nfy_first_sale_number, nfy_first_sale_number) AS "nfy_first_sale_number", ---（公式）2025一季度（销售）（套数）
     nvl(fma_nfy_first_sale_amount, nfy_first_sale_amount) AS "nfy_first_sale_amount", ---（公式）2025一季度（销售）（金额）
     nvl(fma_nfy_second_supply_area, nfy_second_supply_area) AS "nfy_second_supply_area", ---（公式）2025二季度（供应）（面积）
     nvl(fma_nfy_second_supply_number, nfy_second_supply_number) AS "nfy_second_supply_number", ---（公式）2025二季度（供应）（套数）
     nvl(fma_nfy_second_supply_amount, nfy_second_supply_amount) AS "nfy_second_supply_amount", ---（公式）2025二季度（供应）（金额）
     nvl(fma_nfy_second_sale_area, nfy_second_sale_area) AS "nfy_second_sale_area", ---（公式）2025二季度（销售）（面积）
     nvl(fma_nfy_second_sale_number, nfy_second_sale_number) AS "nfy_second_sale_number", ---（公式）2025二季度（销售）（套数）
     nvl(fma_nfy_second_sale_amount, nfy_second_sale_amount) AS "nfy_second_sale_amount", ---（公式）2025二季度（销售）（金额）
     nvl(fma_nfy_third_supply_area, nfy_third_supply_area) AS "nfy_third_supply_area", ---（公式）2025三季度（供应）（面积）
     nvl(fma_nfy_third_supply_number, nfy_third_supply_number) AS "nfy_third_supply_number", ---（公式）2025三季度（供应）（套数）
     nvl(fma_nfy_third_supply_amount, nfy_third_supply_amount) AS "nfy_third_supply_amount", ---（公式）2025三季度（供应）（金额）
     nvl(fma_nfy_third_sale_area, nfy_third_sale_area) AS "nfy_third_sale_area", ---（公式）2025三季度（销售）（面积）
     nvl(fma_nfy_third_sale_number, nfy_third_sale_number) AS "nfy_third_sale_number", ---（公式）2025三季度（销售）（套数）
     nvl(fma_nfy_third_sale_amount, nfy_third_sale_amount) AS "nfy_third_sale_amount", ---（公式）2025三季度（销售）（金额）
     nvl(fma_nfy_fourth_supply_area, nfy_fourth_supply_area) AS "nfy_fourth_supply_area", ---（公式）2025四季度（供应）（面积）
     nvl(fma_nfy_fourth_supply_number, nfy_fourth_supply_number) AS "nfy_fourth_supply_number", ---（公式）2025四季度（供应）（套数）
     nvl(fma_nfy_fourth_supply_amount, nfy_fourth_supply_amount) AS "nfy_fourth_supply_amount", ---（公式）2025四季度（供应）（金额）
     nvl(fma_nfy_fourth_sale_area, nfy_fourth_sale_area) AS "nfy_fourth_sale_area", ---（公式）2025四季度（销售）（面积）
     nvl(fma_nfy_fourth_sale_number, nfy_fourth_sale_number) AS "nfy_fourth_sale_number", ---（公式）2025四季度（销售）（套数）
     nvl(fma_nfy_fourth_sale_amount, nfy_fourth_sale_amount) AS "nfy_fourth_sale_amount" ---（公式）2025四季度（销售）（金额）
  FROM
    opm_proj_inventory_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');
END P_OPM_ED_PROJ_INVENTORY;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_PROJ_INVESTMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_PROJ_INVESTMENT" (
    userid         IN    VARCHAR2,--当前用户id
    stationid      IN    VARCHAR2,--当前用户岗位id
    departmentid   IN    VARCHAR2,--当前用户部门id
    companyid      IN    VARCHAR2,--当前用户公司id
    projectid      IN    VARCHAR2,--所属项目id
    planyear       IN    NUMBER,--计划年
    projsheet2     OUT   SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
BEGIN
    OPEN projsheet2 FOR 
    SELECT
    id, ---
    plan_year, ---计划年份
    parent_id, ---父级ID
    level_code, ---层级：1开始
    order_code, ---顺序
    object_id, ---对象ID
    object_name, ---对象名称
    object_type, ---对象类别
    nvl(fma_kf_land_cost, kf_land_cost) AS "kf_land_cost", ---土地成本
    nvl(fma_kf_land_transfer_fee, kf_land_transfer_fee) AS "kf_land_transfer_fee", ---其中：土地出让金（或土地收购价）
    nvl(fma_kf_land_payment, kf_land_payment) AS "kf_land_payment", ---其中：补交地价款
    nvl(fma_kf_land_municipal_support, kf_land_municipal_support) AS "kf_land_municipal_support", ---其中：大市政配套费
    nvl(fma_kf_land_deed_tax, kf_land_deed_tax) AS "kf_land_deed_tax", ---其中：契税
    nvl(fma_kf_land_compensation, kf_land_compensation) AS "kf_land_compensation", ---其中：拆迁补偿费、土地熟化费用
    nvl(fma_kf_land_other, kf_land_other) AS "kf_land_other", ---其中：其他
    nvl(fma_kf_policy_charge, kf_policy_charge) AS "kf_policy_charge", ---政策性收费
    nvl(fma_kf_proj_costs, kf_proj_costs) AS "kf_proj_costs", ---前期工程费
    nvl(fma_kf_facil_fee, kf_facil_fee) AS "kf_facil_fee", ---基础设施费
    nvl(fma_kf_landscap_road, kf_landscap_road) AS "kf_landscap_road", ---园林绿化道路
    nvl(fma_ja_proj_costs, ja_proj_costs) AS "ja_proj_costs", ---建安工程费
    nvl(fma_ja_basic_proj, ja_basic_proj) AS "ja_basic_proj", ---其中：基础工程
    nvl(fma_ja_underground_structure, ja_underground_structure) AS "ja_underground_structure", ---其中：地下结构
    nvl(fma_ja_ontheground_structure, ja_ontheground_structure) AS "ja_ontheground_structure", ---其中：地上结构
    nvl(fma_ja_exterior, ja_exterior) AS "ja_exterior", ---其中：外装
    nvl(fma_ja_initial_decoration, ja_initial_decoration) AS "ja_initial_decoration", ---其中：初装修
    nvl(fma_ja_public_exquisite, ja_public_exquisite) AS "ja_public_exquisite", ---其中：公区精装修
    nvl(fma_ja_indoor_exquisite, ja_indoor_exquisite) AS "ja_indoor_exquisite", ---其中：户内精装修
    nvl(fma_ja_drainage, ja_drainage) AS "ja_drainage", ---其中：给排水
    nvl(fma_ja_strong_current, ja_strong_current) AS "ja_strong_current", ---其中：强电
    nvl(fma_ja_heating, ja_heating) AS "ja_heating", ---其中：采暖
    nvl(fma_ja_airiness, ja_airiness) AS "ja_airiness", ---其中：通风空调
    nvl(fma_ja_fire_control, ja_fire_control) AS "ja_fire_control", ---其中：消防
    nvl(fma_ja_elevator, ja_elevator) AS "ja_elevator", ---其中：电梯
    nvl(fma_ja_weak_current, ja_weak_current) AS "ja_weak_current", ---其中：弱电及智能化
    nvl(fma_ja_other, ja_other) AS "ja_other", ---其中：其他
    nvl(fma_pc_support_construct_fee, pc_support_construct_fee) AS "pc_support_construct_fee", ---公共配套建设费
    nvl(fma_pc_development_overhead, pc_development_overhead) AS "pc_development_overhead", ---开发间接费
    nvl(fma_pc_property_subsidy, pc_property_subsidy) AS "pc_property_subsidy", ---其中：物业补贴
    nvl(fma_pc_resear_expenses, pc_resear_expenses) AS "pc_resear_expenses", ---其中：品质提升基金、科研费用
    nvl(fma_pc_other, pc_other) AS "pc_other", ---其中：其他
    nvl(fma_sa_sales_expense, sa_sales_expense) AS "sa_sales_expense", ---销售费用
    nvl(fma_sa_manage_expense, sa_manage_expense) AS "sa_manage_expense", ---管理费用
    nvl(fma_sa_finance_expense, sa_finance_expense) AS "sa_finance_expense", ---财务费用
    nvl(fma_sa_capitali_interest, sa_capitali_interest) AS "sa_capitali_interest", ---其中：资本化利息
    nvl(fma_sa_expensed_interest, sa_expensed_interest) AS "sa_expensed_interest", ---其中：费用化利息
    nvl(fma_sa_other, sa_other) AS "sa_other", ---其中：其他
    nvl(fma_ld_the_tax, ld_the_tax) AS "ld_the_tax", ---增值税
    nvl(fma_ld_urban_construc_tax, ld_urban_construc_tax) AS "ld_urban_construc_tax", ---城市维护建设税、教育费附加及地方教育费附加
    nvl(fma_ld_advance, ld_advance) AS "ld_advance", ---土地增值税（预缴）
    nvl(fma_ld_payment, ld_payment) AS "ld_payment", ---土地增值税（清算后补缴）
    nvl(fma_ld_land_use_tax, ld_land_use_tax) AS "ld_land_use_tax", ---土地使用税
    nvl(fma_ld_stamp_duty, ld_stamp_duty) AS "ld_stamp_duty", ---印花税（含土地印花等）
    nvl(fma_ld_other, ld_other) AS "ld_other", ---其他
    nvl(fma_total_investment, total_investment) AS "total_investment", ---总投资（所得税前成本）
    nvl(fma_controllable_costs, controllable_costs) AS "controllable_costs" ---其中：可控成本（所得税前成本-税金及附加-土地出让金-补交地价款-契税）
FROM
    opm_proj_investment_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END p_opm_ed_proj_investment;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_PROJ_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_PROJ_OPERATING" (
    userid         IN    VARCHAR2,--当前用户id
    stationid      IN    VARCHAR2,--当前用户岗位id
    departmentid   IN    VARCHAR2,--当前用户部门id
    companyid      IN    VARCHAR2,--当前用户公司id
    projectid      IN    VARCHAR2,--所属项目id
    planyear       IN    NUMBER,--计划年
    projsheet4     OUT   SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
BEGIN
    OPEN projsheet4 FOR 
    SELECT
    id,
    plan_year, ---计划年份
    order_code, ---顺序
    object_staging, ---项目分期
    object_type, ---项目组团（住宅、商办产业、小区……）
    belong_proj_id, ---所属项目ID
    delivery_date, ---项目交付时间
    nvl(fma_construction_area_total, construction_area_total) AS "construction_area_total", ---预计总值（总建面）
    nvl(fma_value_total, value_total) AS "value_total", ---预计总值（总货值）
    nvl(fma_saleable_area_total, saleable_area_total) AS "saleable_area_total", ---预计总值（总可售面积）
    nvl(fma_operating_income_total, operating_income_total) AS "operating_income_total", ---预计总值（总营业收入）
    nvl(fma_profit_total, profit_total) AS "profit_total", ---预计总值（利润总额）
    nvl(fma_expect_total, expect_total) AS "expect_total", ---预计总值（净利润）
    nvl(fma_last_started_area, last_started_area) AS "last_started_area", ---2020年末开累值（开工面积）（去年）
    nvl(fma_last_completed_area, last_completed_area) AS "last_completed_area", ---2020年末开累值（竣工面积）（去年）
    nvl(fma_last_sales_amount, last_sales_amount) AS "last_sales_amount", ---2020年末开累值（销售金额）
    nvl(fma_last_sales_area, last_sales_area) AS "last_sales_area", ---2020年末开累值（销售面积）
    nvl(fma_last_sales_collection, last_sales_collection) AS "last_sales_collection", ---2020年末开累值（销售回款）
    nvl(fma_last_unpaid_collection, last_unpaid_collection) AS "last_unpaid_collection", ---2020年末开累值（已售未回款）
    nvl(fma_last_operating_income, last_operating_income) AS "last_operating_income", ---2020年末开累值（营业收入）
    nvl(fma_last_carryover_area, last_carryover_area) AS "last_carryover_area", ---2020年末开累值（结转面积）
    nvl(fma_last_total_profit, last_total_profit) AS "last_total_profit", ---2020年末开累值（利润总额）
    nvl(fma_last_net_profit, last_net_profit) AS "last_net_profit", ---2020年末开累值（净利润）（去年）
    nvl(fma_tosep_started_area, tosep_started_area) AS "tosep_started_area", ---2021年预计完成（1-9月实际完成）（开工面积）
    nvl(fma_tosep_completed_area, tosep_completed_area) AS "tosep_completed_area", ---2021年预计完成（1-9月实际完成）（竣工面积）
    nvl(fma_tosep_sales_amount, tosep_sales_amount) AS "tosep_sales_amount", ---2021年预计完成（1-9月实际完成）（销售金额）
    nvl(fma_tosep_sales_area, tosep_sales_area) AS "tosep_sales_area", ---2021年预计完成（1-9月实际完成）（销售面积）
    nvl(fma_tosep_sales_collection, tosep_sales_collection) AS "tosep_sales_collection", ---2021年预计完成（1-9月实际完成）（销售回款）
    nvl(fma_tosep_operating_income, tosep_operating_income) AS "tosep_operating_income", ---2021年预计完成（1-9月实际完成）（营业收入）
    nvl(fma_tosep_carryover_area, tosep_carryover_area) AS "tosep_carryover_area", ---2021年预计完成（1-9月实际完成）（结转面积）
    nvl(fma_tosep_total_profit, tosep_total_profit) AS "tosep_total_profit", ---2021年预计完成（1-9月实际完成）（利润总额）
    nvl(fma_tosep_net_profit, tosep_net_profit) AS "tosep_net_profit", ---2021年预计完成（1-9月实际完成）（净利润）
    nvl(fma_todec_started_area, todec_started_area) AS "todec_started_area", ---2021年预计完成（10-12月计划完成）（开工面积）
    nvl(fma_todec_completed_area, todec_completed_area) AS "todec_completed_area", ---2021年预计完成（10-12月计划完成）（竣工面积）
    nvl(fma_todec_sales_amount, todec_sales_amount) AS "todec_sales_amount", ---2021年预计完成（10-12月计划完成）（销售金额）
    nvl(fma_todec_sales_area, todec_sales_area) AS "todec_sales_area", ---2021年预计完成（10-12月计划完成）（销售面积）
    nvl(fma_todec_sales_collection, todec_sales_collection) AS "todec_sales_collection", ---2021年预计完成（10-12月计划完成）（销售回款）
    nvl(fma_todec_operating_income, todec_operating_income) AS "todec_operating_income", ---2021年预计完成（10-12月计划完成）（营业收入）
    nvl(fma_todec_carryover_area, todec_carryover_area) AS "todec_carryover_area", ---2021年预计完成（10-12月计划完成）（结转面积）
    nvl(fma_todec_total_profit, todec_total_profit) AS "todec_total_profit", ---2021年预计完成（10-12月计划完成）（利润总额）
    nvl(fma_todec_net_profit, todec_net_profit) AS "todec_net_profit", ---2021年预计完成（10-12月计划完成）（净利润）
    nvl(fma_started_area_total, started_area_total) AS "started_area_total", ---2021年预计完成（2021年度合计）（开工面积）
    nvl(fma_completed_area_total, completed_area_total) AS "completed_area_total", ---2021年预计完成（2021年度合计）（竣工面积）
    nvl(fma_sales_amount_total, sales_amount_total) AS "sales_amount_total", ---2021年预计完成（2021年度合计）（销售金额）
    nvl(fma_sales_area_total, sales_area_total) AS "sales_area_total", ---2021年预计完成（2021年度合计）（销售面积）
    nvl(fma_sales_collection_total, sales_collection_total) AS "sales_collection_total", ---2021年预计完成（2021年度合计）（销售回款）
    nvl(fma_expect_income_total, expect_income_total) AS "expect_income_total", ---2021年预计完成（2021年度合计）（营业收入）
    nvl(fma_carryover_area_total, carryover_area_total) AS "carryover_area_total", ---2021年预计完成（2021年度合计）（结转面积）
    nvl(fma_total_profit_total, total_profit_total) AS "total_profit_total", ---2021年预计完成（2021年度合计）（利润总额）
    nvl(fma_net_profit_total, net_profit_total) AS "net_profit_total", ---2021年预计完成（2021年度合计）（净利润）
    nvl(fma_tired_started_area, tired_started_area) AS "tired_started_area", ---2021年末开累值（开工面积）
    nvl(fma_tired_completed_area, tired_completed_area) AS "tired_completed_area", ---2021年末开累值（竣工面积）
    nvl(fma_tired_sales_amount, tired_sales_amount) AS "tired_sales_amount", ---2021年末开累值（销售金额）
    nvl(fma_tired_sales_area, tired_sales_area) AS "tired_sales_area", ---2021年末开累值（销售面积）
    nvl(fma_tired_sales_collection, tired_sales_collection) AS "tired_sales_collection", ---2021年末开累值（销售回款）
    nvl(fma_tired_unpaid_collection, tired_unpaid_collection) AS "tired_unpaid_collection", ---2021年末开累值（已售未回款）
    nvl(fma_tired_operating_income, tired_operating_income) AS "tired_operating_income", ---2021年末开累值（营业收入）
    nvl(fma_tired_carryover_area, tired_carryover_area) AS "tired_carryover_area", ---2021年末开累值（结转面积）
    nvl(fma_tired_total_profit, tired_total_profit) AS "tired_total_profit", ---2021年末开累值（利润总额）
    nvl(fma_tired_net_profit, tired_net_profit) AS "tired_net_profit", ---2021年末开累值（净利润）
    nvl(fma_ntstarted_area, ntstarted_area) AS "ntstarted_area", ---2022年计划（开工面积）
    nvl(fma_ntcompleted_area, ntcompleted_area) AS "ntcompleted_area", ---2022年计划（竣工面积）
    nvl(fma_ntsales_amount, ntsales_amount) AS "ntsales_amount", ---2022年计划（销售金额）
    nvl(fma_ntsales_area, ntsales_area) AS "ntsales_area", ---2022年计划（销售面积）
    nvl(fma_ntunpaid_collection, ntunpaid_collection) AS "ntunpaid_collection", ---2022年计划（2021年签约未回款对应的回款）
    nvl(fma_ntsales_collection, ntsales_collection) AS "ntsales_collection", ---2022年计划（2021年新增销售对应的回款）
    nvl(fma_ntcollection_total, ntcollection_total) AS "ntcollection_total", ---2022年计划（销售回款合计）
    nvl(fma_ntoperating_income, ntoperating_income) AS "ntoperating_income", ---2022年计划（营业收入）
    nvl(fma_ntcarryover_area, ntcarryover_area) AS "ntcarryover_area", ---2022年计划（结转面积）
    nvl(fma_nttotal_profit, nttotal_profit) AS "nttotal_profit", ---2022年计划（利润总额）
    nvl(fma_ntnet_profit, ntnet_profit) AS "ntnet_profit", ---2022年计划（净利润）
    nvl(fma_nttired_started_area, nttired_started_area) AS "nttired_started_area", ---2022年末开累值（开工面积）
    nvl(fma_nttired_completed_area, nttired_completed_area) AS "nttired_completed_area", ---2022年末开累值（竣工面积）
    nvl(fma_nt_tired_sales_amount, nt_tired_sales_amount) AS "nt_tired_sales_amount", ---2022年末开累值（销售金额）
    nvl(fma_ntired_sales_area, ntired_sales_area) AS "ntired_sales_area", ---2022年末开累值（销售面积）
    nvl(fma_nttired_sales_collection, nttired_sales_collection) AS "nttired_sales_collection", ---2022年末开累值（销售回款）
    nvl(fma_nttired_unpaid_collection, nttired_unpaid_collection) AS "nttired_unpaid_collection", ---2022年末开累值（已售未回款）
    nvl(fma_nttired_operating_income, nttired_operating_income) AS "nttired_operating_income", ---2022年末开累值（营业收入）
    nvl(fma_nttired_carryover_area, nttired_carryover_area) AS "nttired_carryover_area", ---2022年末开累值（结转面积）
    nvl(fma_nttired_total_profit, nttired_total_profit) AS "nttired_total_profit", ---2022年末开累值（利润总额）
    nvl(fma_nttired_net_profit, nttired_net_profit) AS "nttired_net_profit", ---2022年末开累值（净利润）
    nvl(fma_tomar_release_revenue, tomar_release_revenue) AS "tomar_release_revenue", ---未来两年产值释放计划（2023年结转营收）
    nvl(fma_tomar_release_profit, tomar_release_profit) AS "tomar_release_profit", ---未来两年产值释放计划（2023结转净利润）
    nvl(fma_toapr_release_revenue, toapr_release_revenue) AS "toapr_release_revenue", ---未来两年产值释放计划（2024年结转营收）
    nvl(fma_toapr_release_profit, toapr_release_profit) AS "toapr_release_profit", ---未来两年产值释放计划（2024结转净利润）
    remark
FROM
    opm_proj_operating_index
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');
END p_opm_ed_proj_operating;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_REGION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_REGION" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
groupsheet1 OUT SYS_REFCURSOR,--1、sheet页的数据源集合 【根据集合顺序】
groupsheet2 OUT SYS_REFCURSOR,--2、sheet页的数据源集合 【根据集合顺序】
groupsheet3 OUT SYS_REFCURSOR--3、sheet页的数据源集合 【根据集合顺序】
) AS
-- operate plan 经营计划-集团级导出表数据。
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_REGION中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_REGION中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
--- group_sheet1
BEGIN P_OPM_ED_REGION_OPERATING(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
     REGIONCOMPANYID => REGIONCOMPANYID,
    GROUPSHEET1 => GROUPSHEET1
  ); end;
--- group_sheet2
BEGIN P_OPM_ED_REGION_CASH(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
     REGIONCOMPANYID => REGIONCOMPANYID,
    GROUPSHEET2 => GROUPSHEET2
  ); end;
--- group_sheet3
BEGIN P_OPM_ED_REGION_INVENTORY(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
     REGIONCOMPANYID => REGIONCOMPANYID,
    GROUPSHEET3 => GROUPSHEET3
  );end;
END P_OPM_ED_REGION;
------------------------------------------------


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_REGION_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_REGION_CASH" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
groupsheet2 OUT SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
-- operate plan 经营计划-集团级导出表数据。
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet2 FOR 
SELECT
ID as "id",--- 主键  
LEVEL_CODE,--- 层级：1开始
--OBJECT_ID,--- 对象ID
OBJECT_NAME,--- 对象名称（城市/项目名称）
--OBJECT_TYPE,--- 类型（公司、项目、补差公司、拟新获取项目、总计）
--ORDER_CODE,--- 顺序
PARENT_ID,--- 父级ID
PLAN_YEAR,--- 计划年份
NVL(FMA_AVAILABLE_FUNDS,CASH_AVAILABLE_FUNDS) as "可动用资金",--- 2022年当年现金流情况展示窗（可动用资金）
NVL(fma_flow_funds,CASH_FLOW_FUNDS) as "资金净流量",--- 2022年当年现金流情况展示窗（资金净流量）
NVL(FMA_CASH_REMAINING_AMOUNT,CASH_REMAINING_AMOUNT) as "展示窗-期末资金余额",--- 2022年当年现金流情况展示窗（期末资金余额）
NVL(FMA_REMAINING_AMOUNT,REMAINING_AMOUNT) as "年底-期末资金余额",--- 截至XXXX年底（期末资金余额）（去年）
NVL(FMA_COLLECTION_LOAN,SOUR_COLLECTION_LOAN) as "代收款",--- XXXX年资金来源计划（代收款）
NVL(FMA_INCREASE_LOAN,SOUR_INCREASE_LOAN) as "净增贷款",--- XXXX年资金来源计划（净增贷款）
NVL(FMA_INVESTMENT_INPUT,SOUR_INVESTMENT_INPUT) as "往来投入",--- XXXX年资金来源计划（往来投入）
NVL(FMA_OTHER_INPUT,SOUR_OTHER_INPUT) as "其他投入",--- XXXX年资金来源计划（其他投入）
NVL(FMA_RENTAL_INCOME,SOUR_RENTAL_INCOME) as "租金收入",--- XXXX年资金来源计划（租金收入）
NVL(FMA_SALES_COLLECTION,SOUR_SALES_COLLECTION)as "销售回款",--- XXXX年资金来源计划（销售回款）
NVL(fma_shareholder_input,SOUR_SHAREHOLDER_INPUT)as "股东投入",--- XXXX年资金来源计划（股东投入）
NVL(fma_total_source_funds,SOUR_TOTAL_FUNDS) as "资金来源合计",--- 2022年资金来源计划（资金来源合计）
NVL(FMA_CURRENT_EXPENDITURE,UTIL_CURRENT_EXPENDITURE) as "往来支出",--- 2022年资金运用计划（往来支出）
NVL(FMA_DEVELOPMENT_OVERHEAD,UTIL_DEVELOPMENT_OVERHEAD) as "开发间接费",--- 2022年资金运用计划（开发间接费）
NVL(fma_engineering_expenditure,UTIL_ENGINEERING_EXPENDITURE) as "工程性支出",--- 2022年资金运用计划（工程性支出）
NVL(FMA_EXPENSES_THE_PERIOD,UTIL_EXPENSES_THE_PERIOD)as "期间费用",--- 2022年资金运用计划（期间费用）
NVL(FMA_LAND_COST,UTIL_LAND_COST) as "土地费用",--- 2022年资金运用计划（土地费用）
NVL(FMA_OTHER_EXPENSES,UTIL_OTHER_EXPENSES) as "其他支出",--- 2022年资金运用计划（其他支出）
NVL(FMA_PRE_PAYMENT,UTIL_PRE_PAYMENT) as "代付款",--- 2022年资金运用计划（代付款）
NVL(fma_subtotal_Fund,UTIL_SUBTOTAL_FUND) as "资金运用小计",--- 2022年资金运用计划（资金运用小计）
NVL(fma_taxes,UTIL_TAXES) as "税金"--- 2022年资金运用计划（税金）
FROM    opm_REGION_cash where PLAN_YEAR=planyear order by order_code  asc ;
END P_OPM_ED_REGION_CASH;
------------------------------------------------

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_REGION_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_REGION_INVENTORY" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
groupsheet3 OUT SYS_REFCURSOR--2、sheet3 供销存
) AS
-- 
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet3 FOR 
SELECT
     id,
     plan_year ---计划年份
     ,
     parent_id ---父级ID
     ,
     level_code ---层级：1开始
     ,
     order_code ---顺序
     ,
     object_id ---对象ID
     ,
     object_name ---项目名称与分期
     ,
     object_type ---业态（住宅、商办产业、车位仓储、配套设施、合计）
     ,
     nvl(fma_saleable_area, saleable_area) AS "saleable_area", ---（公式）全案总可售货值（面积）
     nvl(fma_saleable_number, saleable_number) AS "saleable_number", ---（公式）全案总可售货值（套数）
     nvl(fma_saleable_amount, saleable_amount) AS "saleable_amount", ---（公式）全案总可售货值（金额）
     nvl(fma_saleable_price, saleable_price) AS "saleable_price", ---（公式）全案总可售货值（平方单价）
     nvl(fma_tired_sale_area, tired_sale_area) AS "tired_sale_area", ---（公式）开累已取预售总货值（面积）
     nvl(fma_tired_sale_number, tired_sale_number) AS "tired_sale_number", ---（公式）开累已取预售总货值（套数）
     nvl(fma_tired_sale_amount, tired_sale_amount) AS "tired_sale_amount", ---（公式）开累已取预售总货值（金额）
     nvl(fma_tired_sale_price, tired_sale_price) AS "tired_sale_price", ---（公式）开累已取预售总货值（平米单价）
     nvl(fma_tired_complete_area, tired_complete_area) AS "tired_complete_area", ---（公式）开累完成销售（面积）
     nvl(fma_tired_complete_number, tired_complete_number) AS "tired_complete_number", ---（公式）开累完成销售（套数）
     nvl(fma_tired_complete_amount, tired_complete_amount) AS "tired_complete_amount", ---（公式）开累完成销售（金额）
     nvl(fma_tired_complete_price, tired_complete_price) AS "tired_complete_price", ---（公式）开累完成销售（平米单价）
     nvl(fma_stock_area, stock_area) AS "stock_area", ---（公式）全案库存（面积）
     nvl(fma_stock_number, stock_number) AS "stock_number", ---（公式）全案库存（套数）
     nvl(fma_stock_amount, stock_amount) AS "stock_amount", ---（公式）全案库存（金额）
     nvl(fma_stock_price, stock_price) AS "stock_price", ---（公式）全案库存（平米单价）
     nvl(fma_sale_area, sale_area) AS "sale_area", ---（公式）已取预售证库存（面积）
     nvl(fma_sale_sleeve, sale_sleeve) AS "sale_sleeve", ---（公式）已取预售证库存（套数）
     nvl(fma_sale_amount, sale_amount) AS "sale_amount", ---（公式）已取预售证库存（金额）
     nvl(fma_sale_price, sale_price) AS "sale_price", ---（公式）已取预售证库存（平米单价）
     nvl(fma_supply_area, supply_area) AS "supply_area", ---（公式）2021年供货计划（面积）
     nvl(fma_supply_sleeve, supply_sleeve) AS "supply_sleeve", ---（公式）2021年供货计划（套数）
     nvl(fma_supply_amount, supply_amount) AS "supply_amount", ---（公式）2021年供货计划（金额）
     nvl(fma_supply_price, supply_price) AS "supply_price", ---（公式）2021年供货计划（平米单价）
     nvl(fma_sales_area, sales_area) AS "sales_area", ---（公式）2021年销售计划（面积）
     nvl(fma_sales_sleeve, sales_sleeve) AS "sales_sleeve", ---（公式）2021年销售计划（套数）
     nvl(fma_sales_amount, sales_amount) AS "sales_amount", ---（公式）2021年销售计划（金额）
     nvl(fma_sales_price, sales_price) AS "sales_price", ---（公式）2021年销售计划（平米单价）
     nvl(fma_jan_supply_area, jan_supply_area) AS "jan_supply_area", ---（公式）第一个月（供应）（面积）
     nvl(fma_jan_supply_sleeve, jan_supply_sleeve) AS "jan_supply_sleeve", ---（公式）第一个月（供应）（套数）
     nvl(fma_jan_supply_amount, jan_supply_amount) AS "jan_supply_amount", ---（公式）第一个月（供应）（金额）
     nvl(fma_jan_sales_area, jan_sales_area) AS "jan_sales_area", ---（公式）第一个月（销售）（面积）
     nvl(fma_jan_sales_sleeve, jan_sales_sleeve) AS "jan_sales_sleeve", ---（公式）第一个月（销售）（套数）
     nvl(fma_jan_sales_amount, jan_sales_amount) AS "jan_sales_amount", ---（公式）第一个月（销售）（金额）
     nvl(fma_feb_supply_area, feb_supply_area) AS "feb_supply_area", ---（公式）第二个月（供应）（面积）
     nvl(fma_feb_supply_sleeve, feb_supply_sleeve) AS "feb_supply_sleeve", ---（公式）第二个月（供应）（套数）
     nvl(fma_feb_supply_amount, feb_supply_amount) AS "feb_supply_amount", ---（公式）第二个月（供应）（金额）
     nvl(fma_feb_sales_area, feb_sales_area) AS "feb_sales_area", ---（公式）第二个月（销售）（面积）
     nvl(fma_feb_sales_sleeve, feb_sales_sleeve) AS "feb_sales_sleeve", ---（公式）第二个月（销售）（套数）
     nvl(fma_feb_sales_amount, feb_sales_amount) AS "feb_sales_amount", ---（公式）第二个月（销售）（金额）
     nvl(fma_mar_supply_area, mar_supply_area) AS "mar_supply_area", ---（公式）第三个月（供应）（面积）
     nvl(fma_mar_supply_sleeve, mar_supply_sleeve) AS "mar_supply_sleeve", ---（公式）第三个月（供应）（套数）
     nvl(fma_mar_supply_amount, mar_supply_amount) AS "mar_supply_amount", ---（公式）第三个月（供应）（金额）
     nvl(fma_mar_sales_area, mar_sales_area) AS "mar_sales_area", ---（公式）第三个月（销售）（面积）
     nvl(fma_mar_sales_sleeve, mar_sales_sleeve) AS "mar_sales_sleeve", ---（公式）第三个月（销售）（套数）
     nvl(fma_mar_sales_amount, mar_sales_amount) AS "mar_sales_amount", ---（公式）第三个月（销售）（金额）
     nvl(fma_apr_supply_area, apr_supply_area) AS "apr_supply_area", ---（公式）第四个月（供应）（面积）
     nvl(fma_apr_supply_sleeve, apr_supply_sleeve) AS "apr_supply_sleeve", ---（公式）第四个月（供应）（套数）
     nvl(fma_apr_supply_amount, apr_supply_amount) AS "apr_supply_amount", ---（公式）第四个月（供应）（金额）
     nvl(fma_apr_sales_area, apr_sales_area) AS "apr_sales_area", ---（公式）第四个月（销售）（面积）
     nvl(fma_apr_sales_sleeve, apr_sales_sleeve) AS "apr_sales_sleeve", ---（公式）第四个月（销售）（套数）
     nvl(fma_apr_sales_amount, apr_sales_amount) AS "apr_sales_amount", ---（公式）第四个月（销售）（金额）
     nvl(fma_may_supply_area, may_supply_area) AS "may_supply_area", ---（公式）第五个月（供应）（面积）
     nvl(fma_may_supply_sleeve, may_supply_sleeve) AS "may_supply_sleeve", ---（公式）第五个月（供应）（套数）
     nvl(fma_may_supply_amount, may_supply_amount) AS "may_supply_amount", ---（公式）第五个月（供应）（金额）
     nvl(fma_may_sales_area, may_sales_area) AS "may_sales_area", ---（公式）第五个月（销售）（面积）
     nvl(fma_may_sales_sleeve, may_sales_sleeve) AS "may_sales_sleeve", ---（公式）第五个月（销售）（套数）
     nvl(fma_may_sales_amount, may_sales_amount) AS "may_sales_amount", ---（公式）第五个月（销售）（金额）
     nvl(fma_june_supply_area, june_supply_area) AS "june_supply_area", ---（公式）第六个月（供应）（面积）
     nvl(fma_june_supply_sleeve, june_supply_sleeve) AS "june_supply_sleeve", ---（公式）第六个月（供应）（套数）
     nvl(fma_june_supply_amount, june_supply_amount) AS "june_supply_amount", ---（公式）第六个月（供应）（金额）
     nvl(fma_june_sales_area, june_sales_area) AS "june_sales_area", ---（公式）第六个月（销售）（面积）
     nvl(fma_june_sales_sleeve, june_sales_sleeve) AS "june_sales_sleeve", ---（公式）第六个月（销售）（套数）
     nvl(fma_june_sales_amount, june_sales_amount) AS "june_sales_amount", ---（公式）第六个月（销售）（金额）
     nvl(fma_july_supply_area, july_supply_area) AS "july_supply_area", ---（公式）第七个月（供应）（面积）
     nvl(fma_july_supply_sleeve, july_supply_sleeve) AS "july_supply_sleeve", ---（公式）第七个月（供应）（套数）
     nvl(fma_july_supply_amount, july_supply_amount) AS "july_supply_amount", ---（公式）第七个月（供应）（金额）
     nvl(fma_july_sales_area, july_sales_area) AS "july_sales_area", ---（公式）第七个月（销售）（面积）
     nvl(fma_july_sales_sleeve, july_sales_sleeve) AS "july_sales_sleeve", ---（公式）第七个月（销售）（套数）
     nvl(fma_july_sales_amount, july_sales_amount) AS "july_sales_amount", ---（公式）第七个月（销售）（金额）
     nvl(fma_aug_supply_area, aug_supply_area) AS "aug_supply_area", ---（公式）第八个月（供应）（面积）
     nvl(fma_aug_supply_sleeve, aug_supply_sleeve) AS "aug_supply_sleeve", ---（公式）第八个月（供应）（套数）
     nvl(fma_aug_supply_amount, aug_supply_amount) AS "aug_supply_amount", ---（公式）第八个月（供应）（金额）
     nvl(fma_aug_sales_area, aug_sales_area) AS "aug_sales_area", ---（公式）第八个月（销售）（面积）
     nvl(fma_aug_sales_sleeve, aug_sales_sleeve) AS "aug_sales_sleeve", ---（公式）第八个月（销售）（套数）
     nvl(fma_aug_sales_amount, aug_sales_amount) AS "aug_sales_amount", ---（公式）第八个月（销售）（金额）
     nvl(fma_sep_supply_area, sep_supply_area) AS "sep_supply_area", ---（公式）第九个月（供应）（面积）
     nvl(fma_sep_supply_sleeve, sep_supply_sleeve) AS "sep_supply_sleeve", ---（公式）第九个月（供应）（套数）
     nvl(fma_sep_supply_amount, sep_supply_amount) AS "sep_supply_amount", ---（公式）第九个月（供应）（金额）
     nvl(fma_sep_sales_area, sep_sales_area) AS "sep_sales_area", ---（公式）第九个月（销售）（面积）
     nvl(fma_sep_sales_sleeve, sep_sales_sleeve) AS "sep_sales_sleeve", ---（公式）第九个月（销售）（套数）
     nvl(fma_sep_sales_amount, sep_sales_amount) AS "sep_sales_amount", ---（公式）第九个月（销售）（金额）
     nvl(fma_oct_supply_area, oct_supply_area) AS "oct_supply_area", ---（公式）第十个月（供应）（面积）
     nvl(fma_oct_supply_sleeve, oct_supply_sleeve) AS "oct_supply_sleeve", ---（公式）第十个月（供应）（套数）
     nvl(fma_oct_supply_amount, oct_supply_amount) AS "oct_supply_amount", ---（公式）第十个月（供应）（金额）
     nvl(fma_oct_sales_area, oct_sales_area) AS "oct_sales_area", ---（公式）第十个月（销售）（面积）
     nvl(fma_oct_sales_sleeve, oct_sales_sleeve) AS "oct_sales_sleeve", ---（公式）第十个月（销售）（套数）
     nvl(fma_oct_sales_amount, oct_sales_amount) AS "oct_sales_amount", ---（公式）第十个月（销售）（金额）
     nvl(fma_nov_supply_area, nov_supply_area) AS "nov_supply_area", ---（公式）第十一个月（供应）（面积）
     nvl(fma_nov_supply_sleeve, nov_supply_sleeve) AS "nov_supply_sleeve", ---（公式）第十一个月（供应）（套数）
     nvl(fma_nov_supply_amount, nov_supply_amount) AS "nov_supply_amount", ---（公式）第十一个月（供应）（金额）
     nvl(fma_nov_sales_area, nov_sales_area) AS "nov_sales_area", ---（公式）第十一个月（销售）（面积）
     nvl(fma_nov_sales_sleeve, nov_sales_sleeve) AS "nov_sales_sleeve", ---（公式）第十一个月（销售）（套数）
     nvl(fma_nov_sales_amount, nov_sales_amount) AS "nov_sales_amount", ---（公式）第十一个月（销售）（金额）
     nvl(fma_dec_supply_area, dec_supply_area) AS "dec_supply_area", ---（公式）第十二个月（供应）（面积）
     nvl(fma_dec_supply_sleeve, dec_supply_sleeve) AS "dec_supply_sleeve", ---（公式）第十二个月（供应）（套数）
     nvl(fma_dec_supply_amount, dec_supply_amount) AS "dec_supply_amount", ---（公式）第十二个月（供应）（金额）
     nvl(fma_dec_sales_area, dec_sales_area) AS "dec_sales_area", ---（公式）第十二个月（销售）（面积）
     nvl(fma_dec_sales_sleeve, dec_sales_sleeve) AS "dec_sales_sleeve", ---（公式）第十二个月（销售）（套数）
     nvl(fma_dec_sales_amount, dec_sales_amount) AS "dec_sales_amount", ---（公式）第十二个月（销售）（金额）
     nvl(fma_supply_one_amount, supply_one_amount) AS "supply_one_amount", ---（公式）供货均衡性分析（S1）金额
     nvl(fma_supply_one_ratio, supply_one_ratio) AS "supply_one_ratio", ---（公式）供货均衡性分析（S1）占比
     nvl(fma_supply_two_amount, supply_two_amount) AS "supply_two_amount", ---（公式）供货均衡性分析（S2）金额
     nvl(fma_supply_two_ratio, supply_two_ratio) AS "supply_two_ratio", ---（公式）供货均衡性分析（S2）占比
     nvl(fma_supply_three_amount, supply_three_amount) AS "supply_three_amount", ---（公式）供货均衡性分析（S3）金额
     nvl(fma_supply_three_ratio, supply_three_ratio) AS "supply_three_ratio", ---（公式）供货均衡性分析（S3）占比
     nvl(fma_supply_four_amount, supply_four_amount) AS "supply_four_amount", ---（公式）供货均衡性分析（S4）金额
     nvl(fma_supply_four_ratio, supply_four_ratio) AS "supply_four_ratio", ---（公式）供货均衡性分析（S4）占比
     nvl(fma_sales_one_amount, sales_one_amount) AS "sales_one_amount", ---（公式）销售均衡性分析（S1）金额
     nvl(fma_sales_one_ratio, sales_one_ratio) AS "sales_one_ratio", ---（公式）销售均衡性分析（S1）占比
     nvl(fma_sales_two_amount, sales_two_amount) AS "sales_two_amount", ---（公式）销售均衡性分析（S2）金额
     nvl(fma_sales_two_ratio, sales_two_ratio) AS "sales_two_ratio", ---（公式）销售均衡性分析（S2）占比
     nvl(fma_sales_three_amount, sales_three_amount) AS "sales_three_amount", ---（公式）销售均衡性分析（S3）金额
     nvl(fma_sales_three_ratio, sales_three_ratio) AS "sales_three_ratio", ---（公式）销售均衡性分析（S3）占比
     nvl(fma_sales_four_amount, sales_four_amount) AS "sales_four_amount", ---（公式）销售均衡性分析（S4）金额
     nvl(fma_sales_four_ratio, sales_four_ratio) AS "sales_four_ratio", ---（公式）销售均衡性分析（S4）占比
     nvl(fma_desalination_rate, desalination_rate) AS "desalination_rate", ---（公式）去化率
     nvl(fma_ny_first_supply_area, ny_first_supply_area) AS "ny_first_supply_area", ---（公式）2022一季度（供应）（面积）
     nvl(fma_ny_first_supply_number, ny_first_supply_number) AS "ny_first_supply_number", ---（公式）2022一季度（供应）（套数）
     nvl(fma_ny_first_supply_amount, ny_first_supply_amount) AS "ny_first_supply_amount", ---（公式）2022一季度（供应）（金额）
     nvl(fma_ny_first_sale_area, ny_first_sale_area) AS "ny_first_sale_area", ---（公式）2022一季度（销售）（面积）
     nvl(fma_ny_first_sale_number, ny_first_sale_number) AS "ny_first_sale_number", ---（公式）2022一季度（销售）（套数）
     nvl(fma_ny_first_sale_amount, ny_first_sale_amount) AS "ny_first_sale_amount", ---（公式）2022一季度（销售）（金额）
     nvl(fma_ny_second_supply_area, ny_second_supply_area) AS "ny_second_supply_area", ---（公式）2022二季度（供应）（面积）
     nvl(fma_ny_second_supply_number, ny_second_supply_number) AS "ny_second_supply_number", ---（公式）2022二季度（供应）（套数）
     nvl(fma_ny_second_supply_amount, ny_second_supply_amount) AS "ny_second_supply_amount", ---（公式）2022二季度（供应）（金额）
     nvl(fma_ny_second_sale_area, ny_second_sale_area) AS "ny_second_sale_area", ---（公式）2022二季度（销售）（面积）
     nvl(fma_ny_second_sale_number, ny_second_sale_number) AS "ny_second_sale_number", ---（公式）2022二季度（销售）（套数）
     nvl(fma_ny_second_sale_amount, ny_second_sale_amount) AS "ny_second_sale_amount", ---（公式）2022二季度（销售）（金额）
     nvl(fma_ny_third_supply_area, ny_third_supply_area) AS "ny_third_supply_area", ---（公式）2022三季度（供应）（面积）
     nvl(fma_ny_third_supply_number, ny_third_supply_number) AS "ny_third_supply_number", ---（公式）2022三季度（供应）（套数）
     nvl(fma_ny_third_supply_amount, ny_third_supply_amount) AS "ny_third_supply_amount", ---（公式）2022三季度（供应）（金额）
     nvl(fma_ny_third_sale_area, ny_third_sale_area) AS "ny_third_sale_area", ---（公式）2022三季度（销售）（面积）
     nvl(fma_ny_third_sale_number, ny_third_sale_number) AS "ny_third_sale_number", ---（公式）2022三季度（销售）（套数）
     nvl(fma_ny_third_sale_amount, ny_third_sale_amount) AS "ny_third_sale_amount", ---（公式）2022三季度（销售）（金额）
     nvl(fma_ny_fourth_supply_area, ny_fourth_supply_area) AS "ny_fourth_supply_area", ---（公式）2022四季度（供应）（面积）
     nvl(fma_ny_fourth_supply_number, ny_fourth_supply_number) AS "ny_fourth_supply_number", ---（公式）2022四季度（供应）（套数）
     nvl(fma_ny_fourth_supply_amount, ny_fourth_supply_amount) AS "ny_fourth_supply_amount", ---（公式）2022四季度（供应）（金额）
     nvl(fma_ny_fourth_sale_area, ny_fourth_sale_area) AS "ny_fourth_sale_area", ---（公式）2022四季度（销售）（面积）
     nvl(fma_ny_fourth_sale_number, ny_fourth_sale_number) AS "ny_fourth_sale_number", ---（公式）2022四季度（销售）（套数）
     nvl(fma_ny_fourth_sale_amount, ny_fourth_sale_amount) AS "ny_fourth_sale_amount", ---（公式）2022四季度（销售）（金额）
     nvl(fma_ncy_first_supply_area, ncy_first_supply_area) AS "ncy_first_supply_area", ---（公式）2023一季度（供应）（面积）
     nvl(fma_ncy_first_supply_number, ncy_first_supply_number) AS "ncy_first_supply_number", ---（公式）2023一季度（供应）（套数）
     nvl(fma_ncy_first_supply_amount, ncy_first_supply_amount) AS "ncy_first_supply_amount", ---（公式）2023一季度（供应）（金额）
     nvl(fma_ncy_first_sale_area, ncy_first_sale_area) AS "ncy_first_sale_area", ---（公式）2023一季度（销售）（面积）
     nvl(fma_ncy_first_sale_number, ncy_first_sale_number) AS "ncy_first_sale_number", ---（公式）2023一季度（销售）（套数）
     nvl(fma_ncy_first_sale_amount, ncy_first_sale_amount) AS "ncy_first_sale_amount", ---（公式）2023一季度（销售）（金额）
     nvl(fma_ncy_second_supply_area, ncy_second_supply_area) AS "ncy_second_supply_area", ---（公式）2023二季度（供应）（面积）
     nvl(fma_ncy_second_supply_number, ncy_second_supply_number) AS "ncy_second_supply_number", ---（公式）2023二季度（供应）（套数）
     nvl(fma_ncy_second_supply_amount, ncy_second_supply_amount) AS "ncy_second_supply_amount", ---（公式）2023二季度（供应）（金额）
     nvl(fma_ncy_second_sale_area, ncy_second_sale_area) AS "ncy_second_sale_area", ---（公式）2023二季度（销售）（面积）
     nvl(fma_ncy_second_sale_number, ncy_second_sale_number) AS "ncy_second_sale_number", ---（公式）2023二季度（销售）（套数）
     nvl(fma_ncy_second_sale_amount, ncy_second_sale_amount) AS "ncy_second_sale_amount", ---（公式）2023二季度（销售）（金额）
     nvl(fma_ncy_third_supply_area, ncy_third_supply_area) AS "ncy_third_supply_area", ---（公式）2023三季度（供应）（面积）
     nvl(fma_ncy_third_supply_number, ncy_third_supply_number) AS "ncy_third_supply_number", ---（公式）2023三季度（供应）（套数）
     nvl(fma_ncy_third_supply_amount, ncy_third_supply_amount) AS "ncy_third_supply_amount", ---（公式）2023三季度（供应）（金额）
     nvl(fma_ncy_third_sale_area, ncy_third_sale_area) AS "ncy_third_sale_area", ---（公式）2023三季度（销售）（面积）
     nvl(fma_ncy_third_sale_number, ncy_third_sale_number) AS "ncy_third_sale_number", ---（公式）2023三季度（销售）（套数）
     nvl(fma_ncy_third_sale_amount, ncy_third_sale_amount) AS "ncy_third_sale_amount", ---（公式）2023三季度（销售）（金额）
     nvl(fma_ncy_fourth_supply_area, ncy_fourth_supply_area) AS "ncy_fourth_supply_area", ---（公式）2023四季度（供应）（面积）
     nvl(fma_ncy_fourth_supply_number, ncy_fourth_supply_number) AS "ncy_fourth_supply_number", ---（公式）2023四季度（供应）（套数）
     nvl(fma_ncy_fourth_supply_amount, ncy_fourth_supply_amount) AS "ncy_fourth_supply_amount", ---（公式）2023四季度（供应）（金额）
     nvl(fma_ncy_fourth_sale_area, ncy_fourth_sale_area) AS "ncy_fourth_sale_area", ---（公式）2023四季度（销售）（面积）
     nvl(fma_ncy_fourth_sale_number, ncy_fourth_sale_number) AS "ncy_fourth_sale_number", ---（公式）2023四季度（销售）（套数）
     nvl(fma_ncy_fourth_sale_amount, ncy_fourth_sale_amount) AS "ncy_fourth_sale_amount", ---（公式）2023四季度（销售）（金额）
     nvl(fma_nty_first_supply_area, nty_first_supply_area) AS "nty_first_supply_area", ---（公式）2024一季度（供应）（面积）
     nvl(fma_nty_first_supply_number, nty_first_supply_number) AS "nty_first_supply_number", ---（公式）2024一季度（供应）（套数）
     nvl(fma_nty_first_supply_amount, nty_first_supply_amount) AS "nty_first_supply_amount", ---（公式）2024一季度（供应）（金额）
     nvl(fma_nty_first_sale_area, nty_first_sale_area) AS "nty_first_sale_area", ---（公式）2024一季度（销售）（面积）
     nvl(fma_nty_first_sale_number, nty_first_sale_number) AS "nty_first_sale_number", ---（公式）2024一季度（销售）（套数）
     nvl(fma_nty_first_sale_amount, nty_first_sale_amount) AS "nty_first_sale_amount", ---（公式）2024一季度（销售）（金额）
     nvl(fma_nty_second_supply_area, nty_second_supply_area) AS "nty_second_supply_area", ---（公式）2024二季度（供应）（面积）
     nvl(fma_nty_second_supply_number, nty_second_supply_number) AS "nty_second_supply_number", ---（公式）2024二季度（供应）（套数）
     nvl(fma_nty_second_supply_amount, nty_second_supply_amount) AS "nty_second_supply_amount", ---（公式）2024二季度（供应）（金额）
     nvl(fma_nty_second_sale_area, nty_second_sale_area) AS "nty_second_sale_area", ---（公式）2024二季度（销售）（面积）
     nvl(fma_nty_second_sale_number, nty_second_sale_number) AS "nty_second_sale_number", ---（公式）2024二季度（销售）（套数）
     nvl(fma_nty_second_sale_amount, nty_second_sale_amount) AS "nty_second_sale_amount", ---（公式）2024二季度（销售）（金额）
     nvl(fma_nty_third_supply_area, nty_third_supply_area) AS "nty_third_supply_area", ---（公式）2024三季度（供应）（面积）
     nvl(fma_nty_third_supply_number, nty_third_supply_number) AS "nty_third_supply_number", ---（公式）2024三季度（供应）（套数）
     nvl(fma_nty_third_supply_amount, nty_third_supply_amount) AS "nty_third_supply_amount", ---（公式）2024三季度（供应）（金额）
     nvl(fma_nty_third_sale_area, nty_third_sale_area) AS "nty_third_sale_area", ---（公式）2024三季度（销售）（面积）
     nvl(fma_nty_third_sale_number, nty_third_sale_number) AS "nty_third_sale_number", ---（公式）2024三季度（销售）（套数）
     nvl(fma_nty_third_sale_amount, nty_third_sale_amount) AS "nty_third_sale_amount", ---（公式）2024三季度（销售）（金额）
     nvl(fma_nty_fourth_supply_area, nty_fourth_supply_area) AS "nty_fourth_supply_area", ---（公式）2024四季度（供应）（面积）
     nvl(fma_nty_fourth_supply_number, nty_fourth_supply_number) AS "nty_fourth_supply_number", ---（公式）2024四季度（供应）（套数）
     nvl(fma_nty_fourth_supply_amount, nty_fourth_supply_amount) AS "nty_fourth_supply_amount", ---（公式）2024四季度（供应）（金额）
     nvl(fma_nty_fourth_sale_area, nty_fourth_sale_area) AS "nty_fourth_sale_area", ---（公式）2024四季度（销售）（面积）
     nvl(fma_nty_fourth_sale_number, nty_fourth_sale_number) AS "nty_fourth_sale_number", ---（公式）2024四季度（销售）（套数）
     nvl(fma_nty_fourth_sale_amount, nty_fourth_sale_amount) AS "nty_fourth_sale_amount", ---（公式）2024四季度（销售）（金额）
     nvl(fma_nfy_first_supply_area, nfy_first_supply_area) AS "nfy_first_supply_area", ---（公式）2025一季度（供应）（面积）
     nvl(fma_nfy_first_supply_number, nfy_first_supply_number) AS "nfy_first_supply_number", ---（公式）2025一季度（供应）（套数）
     nvl(fma_nfy_first_supply_amount, nfy_first_supply_amount) AS "nfy_first_supply_amount", ---（公式）2025一季度（供应）（金额）
     nvl(fma_nfy_first_sale_area, nfy_first_sale_area) AS "nfy_first_sale_area", ---（公式）2025一季度（销售）（面积）
     nvl(fma_nfy_first_sale_number, nfy_first_sale_number) AS "nfy_first_sale_number", ---（公式）2025一季度（销售）（套数）
     nvl(fma_nfy_first_sale_amount, nfy_first_sale_amount) AS "nfy_first_sale_amount", ---（公式）2025一季度（销售）（金额）
     nvl(fma_nfy_second_supply_area, nfy_second_supply_area) AS "nfy_second_supply_area", ---（公式）2025二季度（供应）（面积）
     nvl(fma_nfy_second_supply_number, nfy_second_supply_number) AS "nfy_second_supply_number", ---（公式）2025二季度（供应）（套数）
     nvl(fma_nfy_second_supply_amount, nfy_second_supply_amount) AS "nfy_second_supply_amount", ---（公式）2025二季度（供应）（金额）
     nvl(fma_nfy_second_sale_area, nfy_second_sale_area) AS "nfy_second_sale_area", ---（公式）2025二季度（销售）（面积）
     nvl(fma_nfy_second_sale_number, nfy_second_sale_number) AS "nfy_second_sale_number", ---（公式）2025二季度（销售）（套数）
     nvl(fma_nfy_second_sale_amount, nfy_second_sale_amount) AS "nfy_second_sale_amount", ---（公式）2025二季度（销售）（金额）
     nvl(fma_nfy_third_supply_area, nfy_third_supply_area) AS "nfy_third_supply_area", ---（公式）2025三季度（供应）（面积）
     nvl(fma_nfy_third_supply_number, nfy_third_supply_number) AS "nfy_third_supply_number", ---（公式）2025三季度（供应）（套数）
     nvl(fma_nfy_third_supply_amount, nfy_third_supply_amount) AS "nfy_third_supply_amount", ---（公式）2025三季度（供应）（金额）
     nvl(fma_nfy_third_sale_area, nfy_third_sale_area) AS "nfy_third_sale_area", ---（公式）2025三季度（销售）（面积）
     nvl(fma_nfy_third_sale_number, nfy_third_sale_number) AS "nfy_third_sale_number", ---（公式）2025三季度（销售）（套数）
     nvl(fma_nfy_third_sale_amount, nfy_third_sale_amount) AS "nfy_third_sale_amount", ---（公式）2025三季度（销售）（金额）
     nvl(fma_nfy_fourth_supply_area, nfy_fourth_supply_area) AS "nfy_fourth_supply_area", ---（公式）2025四季度（供应）（面积）
     nvl(fma_nfy_fourth_supply_number, nfy_fourth_supply_number) AS "nfy_fourth_supply_number", ---（公式）2025四季度（供应）（套数）
     nvl(fma_nfy_fourth_supply_amount, nfy_fourth_supply_amount) AS "nfy_fourth_supply_amount", ---（公式）2025四季度（供应）（金额）
     nvl(fma_nfy_fourth_sale_area, nfy_fourth_sale_area) AS "nfy_fourth_sale_area", ---（公式）2025四季度（销售）（面积）
     nvl(fma_nfy_fourth_sale_number, nfy_fourth_sale_number) AS "nfy_fourth_sale_number", ---（公式）2025四季度（销售）（套数）
     nvl(fma_nfy_fourth_sale_amount, nfy_fourth_sale_amount) AS "nfy_fourth_sale_amount" ---（公式）2025四季度（销售）（金额）
FROM
    opm_region_inventory_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END P_OPM_ED_REGION_INVENTORY;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ED_REGION_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ED_REGION_OPERATING" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
groupsheet1 OUT SYS_REFCURSOR--2、sheet1 经营计划
) AS
-- 
--- 注意：
---1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
OPEN groupsheet1 FOR 
SELECT
    id AS "id",
    plan_year, ---计划年份
    parent_id, ---父级id
    level_code, ---层级
    order_code, ---顺序
    object_type, ---类型（公司、项目、总计）
    object_id, ---对象ID（公司ID、项目ID）
    object_name, ---对象名称（城市/项目名称）
    nvl(fma_railway_bool, railway_bool) AS "railway_bool", ---（公式）是否并表（中国铁建）
    nvl(fma_estate_bool, estate_bool) AS "estate_bool", ---是否并表（地产集团）
    nvl(fma_estate_ratio, estate_ratio) AS "estate_ratio", ---地产集团所占股权比例
    nvl(fma_railway_ratio, railway_ratio) AS "railway_ratio", ---中国铁建所占股权比例
    nvl(fma_build_land_area, build_land_area) AS "build_land_area", ---建设用地面积（过规版方案指标）
    nvl(fma_surface_total_area, surface_total_area) AS "surface_total_area", ---总建筑面积
    nvl(fma_above_ground_area, above_ground_area) AS "above_ground_area", ---地上建筑面积（万平方米）
    nvl(fma_construction_stage, construction_stage) AS "construction_stage", --- 建设阶段（竣工/在建／未开工）
    nvl(fma_total_investment, total_investment) AS "total_investment", --- 总投资
    nvl(fma_total_saleable_area, total_saleable_area) AS "total_saleable_area", --- 总可售面积
    nvl(fma_total_value, total_value) AS "total_value", --- 总货值
    nvl(fma_last_started_area, last_started_area) AS "last_started_area", ---工程数据，截止2020年开累(开工面积)（去年）
    nvl(fma_last_completed_area, last_completed_area) AS "last_completed_area", ---工程数据，截止2020年开累(竣工面积)（去年）
    nvl(fma_this_started_area, this_started_area) AS "this_started_area", ---工程数据，2021年当年（开工面积）（今年）
    nvl(fma_this_completed_area, this_completed_area) AS "this_completed_area", ---工程数据，2021年当年（竣工面积）（今年）
    nvl(fma_todec_due_time, todec_due_time) AS "todec_due_time", ---工程数据，2021年10~12月（交付时间）（今年）
    nvl(fma_todec_delivery_installment, todec_delivery_installment) AS "todec_delivery_installment", ---工程数据，2021年10~12月（交付分期及相应楼栋）（今年）
    nvl(fma_cutoff_started_area, cutoff_started_area) AS "cutoff_started_area", ---截止2021年开累（开工面积）（今年）
    nvl(fma_cutoff_completed_area, cutoff_completed_area) AS "cutoff_completed_area", ---（公式）截止2021年开累（竣工面积）（今年）
    nvl(fma_next_started_area, next_started_area) AS "next_started_area", --- 2022年当年（开工面积）
    nvl(fma_next_completed_area, next_completed_area) AS "next_completed_area", --- 2022年当年（竣工面积）
    nvl(fma_next_due_time, next_due_time) AS "next_due_time", --- （公式）2022年交付项目（交付时间） 
    nvl(fma_next_delivery_installment, next_delivery_installment) AS "next_delivery_installment", --- （公式）2022年交付项目（交付分期及相应楼栋）
    nvl(fma_cutoff_last_started_area, cutoff_last_started_area) AS "cutoff_last_started_area", --- （公式）截止2020年开累（开工面积）
    nvl(fma_cutoff_last_completed_area, cutoff_last_completed_area) AS "cutoff_last_completed_area", --- （公式）截止2020年开累（竣工面积）
    nvl(fma_cutoff_sales_area, cutoff_sales_area) AS "cutoff_sales_area", ---（公式）截止2020年开累（销售面积）
    nvl(fma_cotoff_sales_amount, cotoff_sales_amount) AS "cotoff_sales_amount", --- （公式）截止2020年开累（销售金额）
    nvl(fma_remaining_value_area, remaining_value_area) AS "remaining_value_area", --- （公式）截止2020年开累（剩余货值面积）
    nvl(fma_remaining_value_amount, remaining_value_amount) AS "remaining_value_amount", --- （公式）截止2020年开累（剩余货值金额）
    nvl(fma_added_supply_area, added_supply_area) AS "added_supply_area", --- （公式）2021年预计完成（新增供货面积）
    nvl(fma_added_supply_amount, added_supply_amount) AS "added_supply_amount", --- （公式）2021年预计完成（新增供货金额）
    nvl(fma_expected_sales_area, expected_sales_area) AS "expected_sales_area", --- （公式）2021年预计完成（销售面积）
    nvl(fma_expected_sales_amount, expected_sales_amount) AS "expected_sales_amount", --- （公式）2021年预计完成（销售金额）
    nvl(fma_equity_sales_amount, equity_sales_amount) AS "equity_sales_amount", --- （公式）2021年预计完成（权益销售金额）
    nvl(fma_tired_supply_area, tired_supply_area) AS "tired_supply_area", --- （公式）截止2021年开累（开累供货（取预售证口径）面积）
    nvl(fma_tired_supply_amount, tired_supply_amount) AS "tired_supply_amount", --- （公式）截止2021年开累（开累供货（取预售证口径）金额）
    nvl(fma_tired_sales_area, tired_sales_area) AS "tired_sales_area", --- （公式）截止2021年开累（销售面积）
    nvl(fma_tired_sales_amount, tired_sales_amount) AS "tired_sales_amount", --- （公式）截止2021年开累（销售金额）
    nvl(fma_tired_stock_area, tired_stock_area) AS "tired_stock_area", --- （公式）截止2021年开累（已取预售证库存面积）
    nvl(fma_tired_stock_amount, tired_stock_amount) AS "tired_stock_amount", --- （公式）截止2021年开累（已取预售证库存金额）
    nvl(fma_tired_remaining_area, tired_remaining_area) AS "tired_remaining_area", --- （公式）截止2021年开累（剩余货值面积）
    nvl(fma_tired_remaining_amount, tired_remaining_amount) AS "tired_remaining_amount", --- （公式）截止2021年开累（剩余货值金额）
    nvl(fma_forecast_supply_area, forecast_supply_area) AS "forecast_supply_area", --- （公式）2022年预计完成（新增供货（取预售证口径）面积）
    nvl(fma_forecast_supply_amount, forecast_supply_amount) AS "forecast_supply_amount", --- （公式）2022年预计完成（新增供货（取预售证口径）金额）
    nvl(fma_forecast_sales_area, forecast_sales_area) AS "forecast_sales_area", --- （公式）2022年预计完成（销售面积）
    nvl(fma_forecast_sales_amount, forecast_sales_amount) AS "forecast_sales_amount", --- （公式）2022年预计完成（销售金额）
    nvl(fma_forecast_equity_amount, forecast_equity_amount) AS "forecast_equity_amount", --- （公式）2022年预计完成（权益销售金额）
    nvl(fma_forecast_tired_area, forecast_tired_area) AS "forecast_tired_area", --- （公式）截止2022年开累（已取预售证面积）
    nvl(fma_forecast_tired_amount, forecast_tired_amount) AS "forecast_tired_amount", --- （公式）截止2022年开累（已取预售证金额）
    nvl(fma_forecast_cotoff_area, forecast_cotoff_area) AS "forecast_cotoff_area", --- （公式）截止2022年开累（销售面积）
    nvl(fma_forecast_cotoff_amount, forecast_cotoff_amount) AS "forecast_cotoff_amount", --- （公式）截止2022年开累（销售金额）
    nvl(fma_forecast_stock_area, forecast_stock_area) AS "forecast_stock_area", --- （公式）截止2022年开累（已取预售证库存面积）
    nvl(fma_forecast_stock_amount, forecast_stock_amount) AS "forecast_stock_amount", --- （公式）截止2022年开累（已取预售证库存金额）
    nvl(fma_forecast_remaining_area, forecast_remaining_area) AS "forecast_remaining_area", --- （公式）截止2022年开累（剩余货值面积）
    nvl(fma_forecast_remaining_amount, forecast_remaining_amount) AS "forecast_remaining_amount", --- （公式）截止2022年开累（剩余货值金额）
    nvl(fma_sac_last_sale_amount, sac_last_sale_amount) AS "sac_last_sale_amount", --- （公式）销售回款（截止2020年开累，销售回款）
    nvl(fma_sac_last_unpaid_amount, sac_last_unpaid_amount) AS "sac_last_unpaid_amount", --- （公式）销售回款（截止2020年开累，已售未回款金额）
    nvl(fma_sac_then_sale_amount, sac_then_sale_amount) AS "sac_then_sale_amount", --- （公式）销售回款（2021年当年，销售回款）
    nvl(fma_sac_then_equity_sale, sac_then_equity_sale) AS "sac_then_equity_sale", --- （公式）销售回款（2021年当年，权益销售回款）
    nvl(fma_tried_sale_amount, tried_sale_amount) AS "tried_sale_amount", --- （公式）销售回款（截止2021年开累，销售回款）
    nvl(fma_tried_unpaid_amount, tried_unpaid_amount) AS "tried_unpaid_amount", --- （公式）销售回款（截止2021年开累，已售未回款金额）
    nvl(fma_sac_next_sale_amount, sac_next_sale_amount) AS "sac_next_sale_amount", --- （公式）销售回款（2022年当年，销售回款）
    nvl(fma_sac_next_equity_sale, sac_next_equity_sale) AS "sac_next_equity_sale", --- （公式）销售回款（2022年当年，权益销售回款）
    nvl(fma_sac_tried_sale_amount, sac_tried_sale_amount) AS "sac_tried_sale_amount", --- （公式）销售回款（截止2022年开累，销售回款）
    nvl(fma_sac_tried_unpaid_amount, sac_tried_unpaid_amount) AS "sac_tried_unpaid_amount", --- （公式）销售回款（截止2022年开累，已售未回款金额）
    nvl(fma_inv_last_investment, inv_last_investment) AS "inv_last_investment", --- （公式）投资、资金计划（截止2020年开累（总投资））
    nvl(fma_inv_then_actual, inv_then_actual) AS "inv_then_actual", --- （公式）投资、资金计划（2021年当年，实际完成投资）
    nvl(fma_inv_then_payment, inv_then_payment) AS "inv_then_payment", --- （公式）投资、资金计划（2021年当年，实际支付资金）
    nvl(fma_inv_invest_firm, inv_invest_firm) AS "inv_invest_firm", --- （公式）投资、资金计划（2021年当年，按照资金来源（企业自有资金））
    nvl(fma_inv_external_financing, inv_external_financing) AS "inv_external_financing", --- （公式）投资、资金计划（2021年当年，按照资金来源（外部融资））
    nvl(fma_inv_sales_collection, inv_sales_collection) AS "inv_sales_collection", --- （公式）投资、资金计划（2021年当年，按照资金来源（销售回款））
    nvl(fma_inv_land_price, inv_land_price) AS "inv_land_price", --- （公式）投资、资金计划（2021年当年，其中土地价款支付资金）
    nvl(fma_inv_then_investment, inv_then_investment) AS "inv_then_investment", --- （公式）投资、资金计划（截止2021年开累，总投资）
    nvl(fma_inv_plan_investment, inv_plan_investment) AS "inv_plan_investment", --- （公式）投资、资金计划（2022年当年，计划投资）
    nvl(fma_inv_invest_funds, inv_invest_funds) AS "inv_invest_funds", --- （公式）投资、资金计划（2022年当年，计划投入资金）
    nvl(fma_inv_next_invest_funds, inv_next_invest_funds) AS "inv_next_invest_funds", --- （公式）投资、资金计划（2022年当年，按照资金来源（企业自有资金））
    nvl(fma_inv_next_external_finan, inv_next_external_finan) AS "inv_next_external_finan", --- （公式）投资、资金计划（2022年当年，按照资金来源（外部融资））
    nvl(fma_inv_next_sales_collection, inv_next_sales_collection) AS "inv_next_sales_collection", --- （公式）投资、资金计划（2022年当年，按照资金来源（销售回款））
    nvl(fma_inv_next_land_price, inv_next_land_price) AS "inv_next_land_price", --- （公式）投资、资金计划（2022年当年，其中土地价款支付资金）
    nvl(fma_inv_next_investment, inv_next_investment) AS "inv_next_investment", --- （公式）投资、资金计划（截止2022年开累，总投资）
    nvl(fma_ltopera_income, ltopera_income) AS "ltopera_income", --- （公式）财务数据（截止2020年开累，营业收入）
    nvl(fma_ltopera_income_outside, ltopera_income_outside) AS "ltopera_income_outside", --- （公式）财务数据（截止2020年开累，营业收入（表外））
    nvl(fma_ltopera_income_inside, ltopera_income_inside) AS "ltopera_income_inside", --- （公式）财务数据（截止2020年开累，营业收入（表内+表外））
    nvl(fma_lttotal_profit, lttotal_profit) AS "lttotal_profit", --- （公式）财务数据（截止2020年开累，利润总额（全口径））
    nvl(fma_ltprofit_inside, ltprofit_inside) AS "ltprofit_inside", --- （公式）财务数据（截止2020年开累，净利润（表内））
    nvl(fma_ltprofit_outside, ltprofit_outside) AS "ltprofit_outside", --- （公式）财务数据（截止2020年开累，净利润（表外））
    nvl(fma_ltprofit_outside_equity, ltprofit_outside_equity) AS "ltprofit_outside_equity", --- （公式）财务数据（截止2020年开累，净利润（表外权益））
    nvl(fma_ltprofit_inside_equity, ltprofit_inside_equity) AS "ltprofit_inside_equity", --- （公式）财务数据（截止2020年开累，净利润（表内+表外权益））
    nvl(fma_thopera_income, thopera_income) AS "thopera_income", --- （公式）财务数据（2021年当年，营业收入（表内））
    nvl(fma_thopera_income_outside, thopera_income_outside) AS "thopera_income_outside", --- （公式）财务数据（2021年当年，营业收入（表外））
    nvl(fma_thopera_income_inside, thopera_income_inside) AS "thopera_income_inside", --- （公式）财务数据（2021年当年，营业收入（表内+表外））
    nvl(fma_thtotal_profit, thtotal_profit) AS "thtotal_profit", --- （公式）财务数据（2021年当年，利润总额（全口径））
    nvl(fma_thprofit_inside, thprofit_inside) AS "thprofit_inside", --- （公式）财务数据（2021年当年，净利润（表内））
    nvl(fma_thprofit_outside, thprofit_outside) AS "thprofit_outside", --- （公式）财务数据（2021年当年，净利润（表外））
    nvl(fma_thprofit_outside_equity, thprofit_outside_equity) AS "thprofit_outside_equity", --- （公式）财务数据（2021年当年，净利润（表外权益））
    nvl(fma_thprofit_inside_equity, thprofit_inside_equity) AS "thprofit_inside_equity", --- （公式）财务数据（2021年当年，净利润（表内+表外权益））
    nvl(fma_end_opera_income, end_opera_income) AS "end_opera_income", --- （公式）财务数据（截止2021年开累，营业收入（表内））
    nvl(fma_end_opera_income_outside, end_opera_income_outside) AS "end_opera_income_outside", --- （公式）财务数据（截止2021年开累，营业收入（表外））
    nvl(fma_end_opera_income_inside, end_opera_income_inside) AS "end_opera_income_inside", --- （公式）财务数据（截止2021年开累，营业收入（表内+表外））
    nvl(fma_end_total_profit, end_total_profit) AS "end_total_profit", --- （公式）财务数据（截止2021年开累，利润总额（全口径））
    nvl(fma_end_profit_inside, end_profit_inside) AS "end_profit_inside", --- （公式）财务数据（截止2021年开累，净利润（表内））
    nvl(fma_end_profit_outside, end_profit_outside) AS "end_profit_outside", --- （公式）财务数据（截止2021年开累，净利润（表外））
    nvl(fma_end_profit_outside_equity, end_profit_outside_equity) AS "end_profit_outside_equity", --- （公式）财务数据（截止2021年开累，净利润（表外权益））
    nvl(fma_end_profit_inside_equity, end_profit_inside_equity) AS "end_profit_inside_equity", --- （公式）财务数据（截止2021年开累，净利润（表内+表外权益））
    nvl(fma_ntprofit_inside_equity, ntprofit_inside_equity) AS "ntprofit_inside_equity", --- （公式）财务数据（2022年当年，营业收入（表内））
    nvl(fma_ntopera_income_outside, ntopera_income_outside) AS "ntopera_income_outside", --- （公式）财务数据（2022年当年，营业收入（表外））
    nvl(fma_ntopera_income_inside, ntopera_income_inside) AS "ntopera_income_inside", --- （公式）财务数据（2022年当年，营业收入（表内+表外））
    nvl(fma_nttotal_profit, nttotal_profit) AS "nttotal_profit", --- （公式）财务数据（2022年当年，利润总额（全口径））
    nvl(fma_ntprofit_inside, ntprofit_inside) AS "ntprofit_inside", --- （公式）财务数据（2022年当年，净利润（表内））
    nvl(fma_ntprofit_outside, ntprofit_outside) AS "ntprofit_outside", --- （公式）财务数据（2022年当年，净利润（表外））
    nvl(fma_ntprofit_outside_equity, ntprofit_outside_equity) AS "ntprofit_outside_equity", --- （公式）财务数据（2022年当年，净利润（表外权益））
    nvl(fma_ntprofit_rights_equity, ntprofit_rights_equity) AS "ntprofit_rights_equity", --- （公式）财务数据（2022年当年，净利润（表内+表外权益））
    nvl(fma_entnt_opera_income, entnt_opera_income) AS "entnt_opera_income", --- （公式）财务数据（截止2022年开累，营业收入（表内））
    nvl(fma_entnt_opera_income_out, entnt_opera_income_out) AS "entnt_opera_income_out", --- （公式）财务数据（截止2022年开累，营业收入（表外））
    nvl(fma_entnt_opera_income_ins, entnt_opera_income_ins) AS "entnt_opera_income_ins", --- （公式）财务数据（截止2022年开累，营业收入（表内+表外））
    nvl(fma_entnt_total_profit, entnt_total_profit) AS "entnt_total_profit", --- （公式）财务数据（截止2022年开累，利润总额（全口径））
    nvl(fma_entnt_profit_inside, entnt_profit_inside) AS "entnt_profit_inside", --- （公式）财务数据（截止2022年开累，净利润（表内））
    nvl(fma_entnt_profit_outside, entnt_profit_outside) AS "entnt_profit_outside", --- （公式）财务数据（截止2022年开累，净利润（表外））
    nvl(fma_entnt_profit_out_equity, entnt_profit_out_equity) AS "entnt_profit_out_equity", --- （公式）财务数据（截止2022年开累，净利润（表外权益））
    nvl(fma_entnt_profit_ins_equity, entnt_profit_ins_equity) AS "entnt_profit_ins_equity", --- （公式）财务数据（截止2022年开累，净利润（表内+表外权益））
    nvl(fma_own_return_time, own_return_time) AS "own_return_time", --- （公式）财务数据（自有资金回正时间）
    nvl(fma_full_return_time, full_return_time) AS "full_return_time", --- （公式）财务数据（全投资回正时间）
    nvl(fma_freed_value, freed_value) AS "freed_value", --- （公式）财务数据（未来两年产值释放计划，）
    nvl(fma_tomar_opera_income, tomar_opera_income) AS "tomar_opera_income", --- （公式）财务数据（2023年，营业收入）
    nvl(fma_tomar_opera_income_ins, tomar_opera_income_ins) AS "tomar_opera_income_ins", --- （公式）财务数据（2023年，营业收入（表内））
    nvl(fma_tomar_total_profit, tomar_total_profit) AS "tomar_total_profit", --- （公式）财务数据（2023年，利润总额（全口径））
    nvl(fma_tomar_profit_inside, tomar_profit_inside) AS "tomar_profit_inside", --- （公式）财务数据（2023年，净利润）
    nvl(fma_tomar_profit_equity, tomar_profit_equity) AS "tomar_profit_equity", --- （公式）财务数据（2023年，净利润（表内+表外权益））
    nvl(fma_toapr_opera_income, toapr_opera_income) AS "toapr_opera_income", --- （公式）财务数据（2024年、营业收入）
    nvl(fma_toapr_opera_income_ins, toapr_opera_income_ins) AS "toapr_opera_income_ins", --- （公式）财务数据（2024年、营业收入（表内））
    nvl(fma_toapr_total_profit, toapr_total_profit) AS "toapr_total_profit", --- （公式）财务数据（2024年、利润总额（全口径））
    nvl(fma_toapr_profit_inside, toapr_profit_inside) AS "toapr_profit_inside", --- （公式）财务数据（2024年、净利润）
    nvl(fma_toapr_profit_equity, toapr_profit_equity) AS "toapr_profit_equity", --- （公式）财务数据（2024年、净利润（表内+表外权益））
    created, --- 创建时间
    creator_id, ---创建人ID
    creator, ---创建人
    modified, --- 最近修改时间
    modifier_id, ---最近修改人ID
    modifier  ---最近修改人
FROM
    opm_region_operating_plan
WHERE
    plan_year = planyear
ORDER BY
    lpad(order_code, 10, '0');

END P_OPM_ED_REGION_OPERATING;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ES_GROUP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ES_GROUP" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
excel OUT SYS_REFCURSOR,--excel信息
sheets OUT SYS_REFCURSOR,--1、sheet页集合 【根据集合顺序】
sheetsFields OUT SYS_REFCURSOR--2、sheet页的表头集合
) AS
-- Export structure 经营计划-集团级导出结构定义  sheetID 不允许调整，用于sheet列、获取sheet页数据建立关联；
-- 注意：列分组是按复合表头来分组。https://blog.csdn.net/lipinganq/article/details/53560931?locationNum=10&fps=1
--作者：chenl
--日期：2021/08/24 https://blog.csdn.net/qq_27937043/article/details/72779442/
  FIELDSINFO SYS_REFCURSOR;
begin
--- 0、excel
Open excel For 
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "excelName" from dual;
--- 1、sheet页集合 
---Select 'groupsheet1' "sheetID",'总表1-集团、区域经营计划汇总表 +利润总额+回正时间2个' "seetName",'' "excelTitle",'表头背景颜色' "headerBgColor",'表头字体颜色' "HeaderFontColor",1 "SheetOrder",'是否使用行收折' "IsUseRowCollapse",'是否默认收折行' "IsDefaultCollapseRow",'冻结行索引' As "trozenRowindex",'冻结列索引' As "frozenColumnindex",'公式背景色' As "formulaBgColor",'顶部描述背景色' "topDescriptionBgColor",'顶部描述文本颜色' "topDescriptionFontColor",'顶部描述文本对齐方式（left、center、right）' "topDescriptionTextalign",'顶部描述字体大小' "topDescriptionTextSize" From Dual
Open Sheets For 
With Base As(
Select 'groupsheet1' "sheetID",'总表1-经营计划汇总表 +利润总额+回正时间2个' "sheetName",'2022集团经营计划汇总表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,0 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual
Union All
Select 'groupsheet2' "sheetID",'总表2-现金流合计表' "sheetName",'2022年度各子公司动态现金流表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,0 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual
Union All
Select 'groupsheet3' "sheetID",'总表3-供销存计划表（示例，线上直接导出）' "sheetName",'集团公司2021年度供销存计划明细分解表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow" ,0 As "frozenRowindex",3 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual  
)
Select * From Base Order By "sheetOrder";
--- 2、sheet页的表头集合 
---SELECT 'groupsheet1' "sheetID", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "wide",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并' "isColumnMerge"  From Dual
BEGIN P_OPM_FIELD_GROUP (USERID=> USERID,STATIONID=> STATIONID,DEPARTMENTID=> DEPARTMENTID,COMPANYID=> COMPANYID,PLANYEAR=> PLANYEAR,Sheetsfields=> Sheetsfields); END;

END P_OPM_ES_GROUP;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ES_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ES_PROJ" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--本公司
planyear in number,--计划年
projectid in VARCHAR2,---所属项目id
excel OUT SYS_REFCURSOR,--excel信息
sheets OUT SYS_REFCURSOR,--1、sheet页集合 【根据集合顺序】
sheetsFields OUT SYS_REFCURSOR--2、sheet页的表头集合
) AS
  FIELDSINFO SYS_REFCURSOR;
begin
--- 0、excel
Open excel For 
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "excelName" from dual;
--- 1、sheet页集合 
---Select 'groupsheet1' "sheetID",'总表1-集团、区域经营计划汇总表 +利润总额+回正时间2个' "seetName",'' "excelTitle",'表头背景颜色' "headerBgColor",'表头字体颜色' "HeaderFontColor",1 "SheetOrder",'是否使用行收折' "IsUseRowCollapse",'是否默认收折行' "IsDefaultCollapseRow",'冻结行索引' As "trozenRowindex",'冻结列索引' As "frozenColumnindex",'公式单元格背景色' As "formulaBgColor",'顶部描述背景色' "topDescriptionBgColor",'顶部描述文本颜色' "topDescriptionFontColor",'顶部描述文本对齐方式（left、center、right）' "topDescriptionTextalign",'顶部描述字体大小' "topDescriptionTextSize" From Dual
Open Sheets For 
With Base As(
Select 'projsheet1' "sheetID",'附表1-项目供销存计划表（示例，线上直接导出）' "sheetName",'集团公司2021年度供销存计划明细分解表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,0 As "frozenRowindex",3 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet2' "sheetID",'附表2-项目投资计划表' "sheetName",'投资计划表' "topDescription",'DARK_TEAL' "headerBgColor",'PALE_BLUE' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,0 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet3' "sheetID",'附表3-项目资金预算平衡表' "sheetName",'项目2022年度资金预算平衡表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow",0 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet4' "sheetID",'附表4-项目经营指标汇总表+分期总建面' "sheetName",'项目经营指标汇总表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",4 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow",0 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual
)
Select * From Base Order By "sheetOrder";
--- 2、sheet页的表头集合 
---SELECT 'groupsheet1' "sheetID", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "wide",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并' "isColumnMerge"  From Dual
BEGIN P_OPM_FIELD_PROJ (
USERID=> USERID,
STATIONID=> STATIONID,
DEPARTMENTID=> DEPARTMENTID,
COMPANYID=> COMPANYID,
projectid=> projectid,
PLANYEAR=> PLANYEAR,
Sheetsfields=> Sheetsfields
); END;

END P_OPM_ES_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_ES_REGION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_ES_REGION" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
excel OUT SYS_REFCURSOR,--excel信息
sheets OUT SYS_REFCURSOR,--1、sheet页集合 【根据集合顺序】
sheetsFields OUT SYS_REFCURSOR--2、sheet页的表头集合
) AS
-- Export structure 经营计划-集团级导出结构定义  sheetID 不允许调整，用于sheet列、获取sheet页数据建立关联；
-- 注意：列分组是按复合表头来分组。https://blog.csdn.net/lipinganq/article/details/53560931?locationNum=10&fps=1
--作者：chenl
--日期：2021/08/24 https://blog.csdn.net/qq_27937043/article/details/72779442/
  FIELDSINFO SYS_REFCURSOR;
begin
P_OPM_ES_GROUP(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
    EXCEL => EXCEL,
    SHEETS => SHEETS,
    SHEETSFIELDS => SHEETSFIELDS
  );
END P_OPM_ES_REGION;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_FIELD_GROUP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_FIELD_GROUP" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
Sheetsfields OUT SYS_REFCURSOR--字段2集合
) AS
---CREATE OR REPLACE FORCE VIEW "V_OPM_GROUP_FIELDS"  AS 
-- operate plan 经营计划-集团级导出所有sheet页字段导出定义；
---注意：
---1、field值同sheet页唯一;//程序导出导入唯一识别列的标识。
---2、fieldId值同sheet页唯一;//用于建立符合表头
--作者：chenl
--日期：2021/08/24 --截至'||to_char(planyear-1)||'年底
---事例 SELECT 'sheet页id，使用P_OPM_ES_GROUP中定义的sheetId，不允许改变' "sheetID",1 "fieldLevel",0 "isHide",是否末级字段"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "width",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序（列顺序）' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并（1合并，0不合并）' "isColumnMerge"  From Dual
    currentYear_MinusFour   VARCHAR2(500):=to_char(planyear-4); 
    currentYear_MinusThree   VARCHAR2(500):=to_char(planyear-3); 
    currentYear_MinusTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_MinusOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear   VARCHAR2(50):=to_char(planyear);--当前年
    currentYear_AddOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear_AddTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_AddThree   VARCHAR2(500):=to_char(planyear-3);  
    currentYear_AddFour   VARCHAR2(500):=to_char(planyear-4);  
begin
OPEN Sheetsfields FOR 
---------------------------------sheet1
with groupsheet1 as  (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet1'
)
---------------------------------sheet2
,groupsheet2 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet2'
)
,groupsheet3 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet3'
)
,resultdata as(
select groupsheet1.* from groupsheet1
union all
select groupsheet2.* from groupsheet2
union all
select groupsheet3.* from groupsheet3)

SELECT "sheetID"
,replace(replace(replace(replace(replace(replace(replace(replace("lable"
    , '{currentYear_MinusFour}', currentYear_MinusFour)
    , '{currentYear_MinusThree}', currentYear_MinusThree)
    , '{currentYear_MinusTwo}', currentYear_MinusTwo)
    , '{currentYear_MinusOne}', currentYear_MinusOne)
    , '{currentYear}', currentYear)
    , '{currentYear_AddOne}', currentYear_AddOne)
    , '{currentYear_AddThree}', currentYear_AddThree)
    , '{currentYear_AddFour}', currentYear_AddFour)"lable"  
,"fieldLevel","isHide","isEnd","headerBgColor","headerFontColor","fieldId","field","width","align","dataFormat","fieldOrder","parentId","textAlign","isColumnMerge", "dataColumnBgcolor"
from resultdata order by "fieldOrder";

END P_OPM_FIELD_GROUP;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_FIELD_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_FIELD_PROJ" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
projectid IN VARCHAR2,--所属项目id
planyear in number,--计划年
Sheetsfields OUT SYS_REFCURSOR--字段2集合
) AS 
currentYear_MinusFour   VARCHAR2(500):=to_char(planyear-4); 
    currentYear_MinusThree   VARCHAR2(500):=to_char(planyear-3); 
    currentYear_MinusTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_MinusOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear   VARCHAR2(50):=to_char(planyear);--当前年
    currentYear_AddOne  VARCHAR2(36):=to_char(planyear+1);
    currentYear_AddTwo   VARCHAR2(500):=to_char(planyear+2);
    currentYear_AddThree   VARCHAR2(500):=to_char(planyear+3);  
    currentYear_AddFour   VARCHAR2(500):=to_char(planyear+4);  
BEGIN
OPEN Sheetsfields FOR 
---------------------------------sheet1
with projsheet1 as  (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet1'
)
---------------------------------sheet2
,projsheet2 as (
SELECT
    'projsheet2'                AS "sheetID",
    "a_level"             AS "fieldLevel",
    0 AS "isHide",
    "isEnd"                  AS "isEnd",
    'PALE_BLUE'          AS "headerBgColor",
    'GREY_80_PERCENT'        AS "headerFontColor",
    id                AS "fieldId",
    "object_name"             AS "lable",
    id             AS "field",
    'auto'             AS "width",
    'left'             AS "align",
    '#,##0.00'        AS "dataFormat",
    order_code             AS "fieldOrder",
    parent_id          AS "parentId",
    'left'         AS "textAlign",
    1  AS "isColumnMerge"
FROM
    (
    SELECT
    level as "a_level",
    parent_id,
    id,
    order_code,
    belong_proj_id,
    nvl(object_level_name_one, object_level_name_two) AS "object_name",
    CASE
        WHEN id IN (
            SELECT
                parent_id
            FROM
                opm_proj_investment_plan
        ) THEN
            0
        ELSE
            1
    END AS "isEnd"
FROM
    opm_proj_investment_plan
START WITH
    parent_id IS NULL
CONNECT BY
    PRIOR id = parent_id
    ) temp
WHERE
    BELONG_PROJ_ID = projectid       
)
---------------------------------sheet3
,projsheet3 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet3'
)
---------------------------------sheet4
,projsheet4 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet4'
)
,resultdata as(
select projsheet1.* from projsheet1
union all
select projsheet2.* from projsheet2
union all
select projsheet3.* from projsheet3
union all
select projsheet4.* from projsheet4)
SELECT "sheetID"
,replace(replace(replace(replace(replace(replace(replace(replace("lable"
    , '{currentYear_MinusThree}', currentYear_MinusThree)
    , '{currentYear_MinusTwo}', currentYear_MinusTwo)
    , '{currentYear_MinusOne}', currentYear_MinusOne)
    , '{currentYear}', currentYear)
    , '{currentYear_AddOne}', currentYear_AddOne)
    , '{currentYear_AddTwo}', currentYear_AddTwo)
    , '{currentYear_AddThree}', currentYear_AddThree)
    , '{currentYear_AddFour}', currentYear_AddFour)"lable"  
,"fieldLevel","isHide","isEnd","headerBgColor","headerFontColor","fieldId","field","width","align","dataFormat","fieldOrder","parentId","textAlign","isColumnMerge"
from resultdata order by "fieldOrder";
END P_OPM_FIELD_PROJ;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_FIELD_REGION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_FIELD_REGION" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
Sheetsfields OUT SYS_REFCURSOR--字段2集合
) AS
---CREATE OR REPLACE FORCE VIEW "V_OPM_REGION_FIELDS"  AS 
-- operate plan 经营计划-集团级导出所有sheet页字段导出定义；
---注意：
---1、field值同sheet页唯一;//程序导出导入唯一识别列的标识。
---2、fieldId值同sheet页唯一;//用于建立符合表头
--作者：chenl
--日期：2021/08/24
---事例 SELECT 'sheet页id，使用P_OPM_ES_GROUP中定义的sheetId，不允许改变' "sheetID",1 "fieldLevel",0 "isHide",是否墨迹字段 "isEnd", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "width",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序（列顺序）' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并（1合并，0不合并）' "isColumnMerge"  From Dual
begin
P_OPM_FIELD_GROUP(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPARTMENTID => DEPARTMENTID,
    COMPANYID => COMPANYID,
    PLANYEAR => PLANYEAR,
    SHEETSFIELDS => SHEETSFIELDS
  );
END P_OPM_FIELD_REGION;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT" (planyear IN number
--计划年
) AS-- 按年初始化所有的数据
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
plan_year   VARCHAR2(500):=(case when planyear is null or planyear='' then  to_char(sysdate, 'yyyy' ) else planyear end); 
BEGIN 
-----------------------------------集团级
  BEGIN
  P_OPM_INIT_GROUP(
    PLANYEAR => PLANYEAR
  );
--rollback; 
END;
-----------------------------------区域级
  begin
  P_OPM_INIT_REGION(
    PLANYEAR => plan_year,
    REGIONCOMPANYID => null
  );
  end;
-----------------------------------项目级
 BEGIN
  P_OPM_INIT_PROJ(
    PLANYEAR => PLANYEAR,
    REGIONORGID => null
  );
--rollback; 
END;
-----------------------------------
END P_OPM_INIT;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_GROUP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_GROUP" (planyear IN number--计划年
) AS-- 根据模板初始化年度【集团级数据】
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------现金流
  begin
  P_OPM_INIT_GROUP_CASH(
    PLANYEAR => PLANYEAR
  );
  end;
-----------------------------------供销存
  begin
  P_OPM_INIT_GROUP_INVENTORY(
    PLANYEAR => PLANYEAR
  );
  end;
-----------------------------------
-----------------------------------经营计划
  begin
   P_OPM_INIT_GROUP_OPERATING(
    PLANYEAR => PLANYEAR
  );
  end;
-----------------------------------
END P_OPM_INIT_GROUP;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_GROUP_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_GROUP_CASH" (planyear IN number--计划年
) AS-- 根据模板初始化年度【集团级数据】---现金流
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------现金流
--删除该年；
DELETE FROM opm_group_cash WHERE plan_year=planyear;
--根据模板初始化该年
INSERT INTO opm_group_cash (id,plan_year,parent_id,level_code,order_code,object_type,object_id,object_status,object_name,remaining_amount,sour_sales_collection,sour_rental_income,sour_increase_loan,sour_collection_loan,sour_shareholder_input,sour_investment_input,sour_other_input,sour_total_funds,util_land_cost,util_engineering_expenditure,util_development_overhead,util_expenses_the_period,util_taxes,util_pre_payment,util_other_expenses,util_current_expenditure,util_subtotal_fund,cash_flow_funds,cash_remaining_amount,cash_available_funds,created,creator_id,creator,modified,modifier_id,modifier,fma_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_cash_remaining_amount,fma_available_funds) 
select sys_guid(),planyear,parent_id,level_code,order_code,object_type,id,'未提交',object_name,remaining_amount,sour_sales_collection,sour_rental_income,sour_increase_loan,sour_collection_loan,sour_shareholder_input,sour_investment_input,sour_other_input,sour_total_funds,util_land_cost,util_engineering_expenditure,util_development_overhead,util_expenses_the_period,util_taxes,util_pre_payment,util_other_expenses,util_current_expenditure,util_subtotal_fund,cash_flow_funds,cash_remaining_amount,cash_available_funds,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_cash_remaining_amount,fma_available_funds
from opm_t_group_cash;
-----------------------------------现金流
-----------------------------------
END P_OPM_INIT_GROUP_CASH;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_GROUP_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_GROUP_INVENTORY" (planyear IN number--计划年
) AS-- 根据模板初始化年度【集团级数据】---供销存
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------供销存
--删除该年；
DELETE FROM OPM_GROUP_INVENTORY_PLAN WHERE plan_year=planyear;

INSERT INTO opm_group_inventory_plan (id,plan_year,parent_id,level_code,order_code,object_id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,created,creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount)
SELECT sys_guid(),planyear,parent_id,level_code,order_code,id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount 
FROM opm_t_group_inventory_plan;
-----------------------------------供销存
END P_OPM_INIT_GROUP_INVENTORY;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_GROUP_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_GROUP_OPERATING" (planyear IN number--计划年
) AS-- 根据模板初始化年度【集团级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
------------
INSERT INTO opm_group_operating_plan (id,plan_year,parent_id,level_code,order_code,object_type,object_id,object_name,railway_bool,estate_bool,estate_ratio,railway_ratio,build_land_area,surface_total_area,above_ground_area,construction_stage,total_investment,total_saleable_area,total_value,last_started_area,last_completed_area,this_started_area,this_completed_area,todec_due_time,todec_delivery_installment,cutoff_started_area,cutoff_completed_area,next_started_area,next_completed_area,next_due_time,next_delivery_installment,cutoff_last_started_area,cutoff_last_completed_area,cutoff_sales_area,cotoff_sales_amount,remaining_value_area,remaining_value_amount,added_supply_area,added_supply_amount,expected_sales_area,expected_sales_amount,equity_sales_amount,tired_supply_area,tired_supply_amount,tired_sales_area,tired_sales_amount,tired_stock_area,tired_stock_amount,tired_remaining_area,tired_remaining_amount,forecast_supply_area,forecast_supply_amount,forecast_sales_area,forecast_sales_amount,forecast_equity_amount,forecast_tired_area,forecast_tired_amount,forecast_cotoff_area,forecast_cotoff_amount,forecast_stock_area,forecast_stock_amount,forecast_remaining_area,forecast_remaining_amount,sac_last_sale_amount,sac_last_unpaid_amount,sac_then_sale_amount,sac_then_equity_sale,tried_sale_amount,tried_unpaid_amount,sac_next_sale_amount,sac_next_equity_sale,sac_tried_sale_amount,sac_tried_unpaid_amount,inv_last_investment,inv_then_actual,inv_then_payment,inv_invest_firm,inv_external_financing,inv_sales_collection,inv_land_price,inv_then_investment,inv_plan_investment,inv_invest_funds,inv_next_invest_funds,inv_next_external_finan,inv_next_sales_collection,inv_next_land_price,inv_next_investment,ltopera_income,ltopera_income_outside,ltopera_income_inside,lttotal_profit,ltprofit_inside,ltprofit_outside,ltprofit_outside_equity,ltprofit_inside_equity,thopera_income,thopera_income_outside,thopera_income_inside,thtotal_profit,thprofit_inside,thprofit_outside,thprofit_outside_equity,thprofit_inside_equity,end_opera_income,end_opera_income_outside,end_opera_income_inside,end_total_profit,end_profit_inside,end_profit_outside,end_profit_outside_equity,end_profit_inside_equity,ntprofit_inside_equity,ntopera_income_outside,ntopera_income_inside,nttotal_profit,ntprofit_inside,ntprofit_outside,ntprofit_outside_equity,ntprofit_rights_equity,entnt_opera_income,entnt_opera_income_out,entnt_opera_income_ins,entnt_total_profit,entnt_profit_inside,entnt_profit_outside,entnt_profit_out_equity,entnt_profit_ins_equity,own_return_time,full_return_time,freed_value,tomar_opera_income,tomar_opera_income_ins,tomar_total_profit,tomar_profit_inside,tomar_profit_equity,toapr_opera_income,toapr_opera_income_ins,toapr_total_profit,toapr_profit_inside,toapr_profit_equity,created,creator_id,creator,modified,modifier_id,modifier,fma_construction_stage,fma_total_investment,fma_total_saleable_area,fma_total_value,fma_last_started_area,fma_last_completed_area,fma_this_started_area,fma_this_completed_area,fma_todec_due_time,fma_todec_delivery_installment,fma_cutoff_started_area,fma_cutoff_completed_area,fma_next_started_area,fma_next_completed_area,fma_next_due_time,fma_next_delivery_installment,fma_cutoff_last_started_area,fma_cutoff_last_completed_area,fma_cutoff_sales_area,fma_cotoff_sales_amount,fma_remaining_value_area,fma_remaining_value_amount,fma_added_supply_area,fma_added_supply_amount,fma_expected_sales_area,fma_expected_sales_amount,fma_equity_sales_amount,fma_tired_supply_area,fma_tired_supply_amount,fma_tired_sales_area,fma_tired_sales_amount,fma_tired_stock_area,fma_tired_stock_amount,fma_tired_remaining_area,fma_tired_remaining_amount,fma_forecast_supply_area,fma_forecast_supply_amount,fma_forecast_sales_area,fma_forecast_sales_amount,fma_forecast_equity_amount,fma_forecast_tired_area,fma_forecast_tired_amount,fma_forecast_cotoff_area,fma_forecast_cotoff_amount,fma_forecast_stock_area,fma_forecast_stock_amount,fma_forecast_remaining_area,fma_forecast_remaining_amount,fma_sac_last_sale_amount,fma_sac_last_unpaid_amount,fma_sac_then_sale_amount,fma_sac_then_equity_sale,fma_tried_sale_amount,fma_tried_unpaid_amount,fma_sac_next_sale_amount,fma_sac_next_equity_sale,fma_sac_tried_sale_amount,fma_sac_tried_unpaid_amount,fma_inv_last_investment,fma_inv_then_actual,fma_inv_then_payment,fma_inv_invest_firm,fma_inv_external_financing,fma_inv_sales_collection,fma_inv_land_price,fma_inv_then_investment,fma_inv_plan_investment,fma_inv_invest_funds,fma_inv_next_invest_funds,fma_inv_next_external_finan,fma_inv_next_sales_collection,fma_inv_next_land_price,fma_inv_next_investment,fma_ltopera_income,fma_ltopera_income_outside,fma_ltopera_income_inside,fma_lttotal_profit,fma_ltprofit_inside,fma_ltprofit_outside,fma_ltprofit_outside_equity,fma_ltprofit_inside_equity,fma_thopera_income,fma_thopera_income_outside,fma_thopera_income_inside,fma_thtotal_profit,fma_thprofit_inside,fma_thprofit_outside,fma_thprofit_outside_equity,fma_thprofit_inside_equity,fma_end_opera_income,fma_end_opera_income_outside,fma_end_opera_income_inside,fma_end_total_profit,fma_end_profit_inside,fma_end_profit_outside,fma_end_profit_outside_equity,fma_end_profit_inside_equity,fma_ntprofit_inside_equity,fma_ntopera_income_outside,fma_ntopera_income_inside,fma_nttotal_profit,fma_ntprofit_inside,fma_ntprofit_outside,fma_ntprofit_outside_equity,fma_ntprofit_rights_equity,fma_entnt_opera_income,fma_entnt_opera_income_out,fma_entnt_opera_income_ins,fma_entnt_total_profit,fma_entnt_profit_inside,fma_entnt_profit_outside,fma_entnt_profit_out_equity,fma_entnt_profit_ins_equity,fma_own_return_time,fma_full_return_time,fma_freed_value,fma_tomar_opera_income,fma_tomar_opera_income_ins,fma_tomar_total_profit,fma_tomar_profit_inside,fma_tomar_profit_equity,fma_toapr_opera_income,fma_toapr_opera_income_ins,fma_toapr_total_profit,fma_toapr_profit_inside,fma_toapr_profit_equity,fma_railway_bool,fma_estate_bool,fma_estate_ratio,fma_railway_ratio,fma_build_land_area,fma_surface_total_area,fma_above_ground_area)
SELECT sys_guid(),planyear,parent_id,level_code,order_code,object_type,id,object_name,railway_bool,estate_bool,estate_ratio,railway_ratio,build_land_area,surface_total_area,above_ground_area,construction_stage,total_investment,total_saleable_area,total_value,last_started_area,last_completed_area,this_started_area,this_completed_area,todec_due_time,todec_delivery_installment,cutoff_started_area,cutoff_completed_area,next_started_area,next_completed_area,next_due_time,next_delivery_installment,cutoff_last_started_area,cutoff_last_completed_area,cutoff_sales_area,cotoff_sales_amount,remaining_value_area,remaining_value_amount,added_supply_area,added_supply_amount,expected_sales_area,expected_sales_amount,equity_sales_amount,tired_supply_area,tired_supply_amount,tired_sales_area,tired_sales_amount,tired_stock_area,tired_stock_amount,tired_remaining_area,tired_remaining_amount,forecast_supply_area,forecast_supply_amount,forecast_sales_area,forecast_sales_amount,forecast_equity_amount,forecast_tired_area,forecast_tired_amount,forecast_cotoff_area,forecast_cotoff_amount,forecast_stock_area,forecast_stock_amount,forecast_remaining_area,forecast_remaining_amount,sac_last_sale_amount,sac_last_unpaid_amount,sac_then_sale_amount,sac_then_equity_sale,tried_sale_amount,tried_unpaid_amount,sac_next_sale_amount,sac_next_equity_sale,sac_tried_sale_amount,sac_tried_unpaid_amount,inv_last_investment,inv_then_actual,inv_then_payment,inv_invest_firm,inv_external_financing,inv_sales_collection,inv_land_price,inv_then_investment,inv_plan_investment,inv_invest_funds,inv_next_invest_funds,inv_next_external_finan,inv_next_sales_collection,inv_next_land_price,inv_next_investment,ltopera_income,ltopera_income_outside,ltopera_income_inside,lttotal_profit,ltprofit_inside,ltprofit_outside,ltprofit_outside_equity,ltprofit_inside_equity,thopera_income,thopera_income_outside,thopera_income_inside,thtotal_profit,thprofit_inside,thprofit_outside,thprofit_outside_equity,thprofit_inside_equity,end_opera_income,end_opera_income_outside,end_opera_income_inside,end_total_profit,end_profit_inside,end_profit_outside,end_profit_outside_equity,end_profit_inside_equity,ntprofit_inside_equity,ntopera_income_outside,ntopera_income_inside,nttotal_profit,ntprofit_inside,ntprofit_outside,ntprofit_outside_equity,ntprofit_rights_equity,entnt_opera_income,entnt_opera_income_out,entnt_opera_income_ins,entnt_total_profit,entnt_profit_inside,entnt_profit_outside,entnt_profit_out_equity,entnt_profit_ins_equity,own_return_time,full_return_time,freed_value,tomar_opera_income,tomar_opera_income_ins,tomar_total_profit,tomar_profit_inside,tomar_profit_equity,toapr_opera_income,toapr_opera_income_ins,toapr_total_profit,toapr_profit_inside,toapr_profit_equity,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_construction_stage,fma_total_investment,fma_total_saleable_area,fma_total_value,fma_last_started_area,fma_last_completed_area,fma_this_started_area,fma_this_completed_area,fma_todec_due_time,fma_todec_delivery_installment,fma_cutoff_started_area,fma_cutoff_completed_area,fma_next_started_area,fma_next_completed_area,fma_next_due_time,fma_next_delivery_installment,fma_cutoff_last_started_area,fma_cutoff_last_completed_area,fma_cutoff_sales_area,fma_cotoff_sales_amount,fma_remaining_value_area,fma_remaining_value_amount,fma_added_supply_area,fma_added_supply_amount,fma_expected_sales_area,fma_expected_sales_amount,fma_equity_sales_amount,fma_tired_supply_area,fma_tired_supply_amount,fma_tired_sales_area,fma_tired_sales_amount,fma_tired_stock_area,fma_tired_stock_amount,fma_tired_remaining_area,fma_tired_remaining_amount,fma_forecast_supply_area,fma_forecast_supply_amount,fma_forecast_sales_area,fma_forecast_sales_amount,fma_forecast_equity_amount,fma_forecast_tired_area,fma_forecast_tired_amount,fma_forecast_cotoff_area,fma_forecast_cotoff_amount,fma_forecast_stock_area,fma_forecast_stock_amount,fma_forecast_remaining_area,fma_forecast_remaining_amount,fma_sac_last_sale_amount,fma_sac_last_unpaid_amount,fma_sac_then_sale_amount,fma_sac_then_equity_sale,fma_tried_sale_amount,fma_tried_unpaid_amount,fma_sac_next_sale_amount,fma_sac_next_equity_sale,fma_sac_tried_sale_amount,fma_sac_tried_unpaid_amount,fma_inv_last_investment,fma_inv_then_actual,fma_inv_then_payment,fma_inv_invest_firm,fma_inv_external_financing,fma_inv_sales_collection,fma_inv_land_price,fma_inv_then_investment,fma_inv_plan_investment,fma_inv_invest_funds,fma_inv_next_invest_funds,fma_inv_next_external_finan,fma_inv_next_sales_collection,fma_inv_next_land_price,fma_inv_next_investment,fma_ltopera_income,fma_ltopera_income_outside,fma_ltopera_income_inside,fma_lttotal_profit,fma_ltprofit_inside,fma_ltprofit_outside,fma_ltprofit_outside_equity,fma_ltprofit_inside_equity,fma_thopera_income,fma_thopera_income_outside,fma_thopera_income_inside,fma_thtotal_profit,fma_thprofit_inside,fma_thprofit_outside,fma_thprofit_outside_equity,fma_thprofit_inside_equity,fma_end_opera_income,fma_end_opera_income_outside,fma_end_opera_income_inside,fma_end_total_profit,fma_end_profit_inside,fma_end_profit_outside,fma_end_profit_outside_equity,fma_end_profit_inside_equity,fma_ntprofit_inside_equity,fma_ntopera_income_outside,fma_ntopera_income_inside,fma_nttotal_profit,fma_ntprofit_inside,fma_ntprofit_outside,fma_ntprofit_outside_equity,fma_ntprofit_rights_equity,fma_entnt_opera_income,fma_entnt_opera_income_out,fma_entnt_opera_income_ins,fma_entnt_total_profit,fma_entnt_profit_inside,fma_entnt_profit_outside,fma_entnt_profit_out_equity,fma_entnt_profit_ins_equity,fma_own_return_time,fma_full_return_time,fma_freed_value,fma_tomar_opera_income,fma_tomar_opera_income_ins,fma_tomar_total_profit,fma_tomar_profit_inside,fma_tomar_profit_equity,fma_toapr_opera_income,fma_toapr_opera_income_ins,fma_toapr_total_profit,fma_toapr_profit_inside,fma_toapr_profit_equity,fma_railway_bool,fma_estate_bool,fma_estate_ratio,fma_railway_ratio,fma_build_land_area,fma_surface_total_area,fma_above_ground_area 
FROM opm_t_group_operating_plan;
-----------------------经营计划
--删除该年；
DELETE FROM OPM_GROUP_INVENTORY_PLAN WHERE plan_year=planyear;


-----------------------------------经营计划
-----------------------------------经营计划
END P_OPM_INIT_GROUP_OPERATING;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------现金流
  begin
  P_OPM_INIT_PROJ_BUDGET(
    PLANYEAR => PLANYEAR
    ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------供销存
  begin
  P_OPM_INIT_PROJ_INVENTORY(
    PLANYEAR => PLANYEAR
     ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------
-----------------------------------经营计划
  begin
   P_OPM_INIT_PROJ_OPERATING(
    PLANYEAR => PLANYEAR
     ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------
END P_OPM_INIT_PROJ;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_PROJ_BUDGET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ_BUDGET" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】---现金流   operational plan
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------现金流
--删除该年；
DELETE FROM OPM_PROJ_BUDGET WHERE (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;
--根据模板初始化该年
INSERT INTO opm_proj_budget (id,plan_year,order_code,object_main_name,object_sub_name,belong_proj_id,previous_total,tosep_budget_total,todec_budget_total,last_declaration_total,last_cumulative_amount,plan_amount,cumulative_amount,remark,created,creator_id,creator,modified,modifier_id,modifier,fma_previous_total,fma_tosep_budget_total,fma_todec_budget_total,fma_last_declaration_total,fma_last_cumulative_amount,fma_plan_amount,fma_cumulative_amount,object_type,object_id)
SELECT sys_guid (),planyear,order_code,object_main_name,object_sub_name,belong_proj_id,previous_total,tosep_budget_total,todec_budget_total,last_declaration_total,last_cumulative_amount,plan_amount,cumulative_amount,remark,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_previous_total,fma_tosep_budget_total,fma_todec_budget_total,fma_last_declaration_total,fma_last_cumulative_amount,fma_plan_amount,fma_cumulative_amount,object_type,id 
FROM  OPM_T_PROJ_BUDGET  WHERE BELONG_PROJ_ID=regionOrgId or 1=init_all;
-----------------------------------现金流
END P_OPM_INIT_PROJ_BUDGET;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_PROJ_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ_INVENTORY" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】---供销存
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------供销存
--删除该年；
DELETE FROM OPM_PROJ_INVENTORY_PLAN WHERE (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;
INSERT INTO opm_proj_inventory_plan (id,plan_year,parent_id,level_code,order_code,belong_proj_id,object_id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,created,creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,belong_proj_id,id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount 
FROM  opm_t_PROJ_inventory_plan WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------供销存
END P_OPM_INIT_PROJ_INVENTORY;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_PROJ_INVESTMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ_INVESTMENT" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------经营计划
--删除该年；
DELETE FROM OPM_PROJ_INVENTORY_PLAN WHERE  (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;

INSERT INTO opm_proj_investment_plan (id,plan_year,parent_id,level_code,order_code,object_id,object_name,object_type,kf_land_cost,kf_land_transfer_fee,kf_land_payment,kf_land_municipal_support,kf_land_deed_tax,kf_land_compensation,kf_land_other,kf_policy_charge,kf_proj_costs,kf_facil_fee,kf_landscap_road,ja_proj_costs,ja_basic_proj,ja_underground_structure,ja_ontheground_structure,ja_exterior,ja_initial_decoration,ja_public_exquisite,ja_indoor_exquisite,ja_drainage,ja_strong_current,ja_heating,ja_airiness,ja_fire_control,ja_elevator,ja_weak_current,ja_other,pc_support_construct_fee,pc_development_overhead,pc_property_subsidy,pc_resear_expenses,pc_other,sa_sales_expense,sa_manage_expense,sa_finance_expense,sa_capitali_interest,sa_expensed_interest,sa_other,ld_the_tax,ld_urban_construc_tax,ld_advance,ld_payment,ld_land_use_tax,ld_stamp_duty,ld_other,total_investment,controllable_costs,fma_kf_land_cost,fma_kf_land_transfer_fee,fma_kf_land_payment,fma_kf_land_municipal_support,fma_kf_land_deed_tax,fma_kf_land_compensation,fma_kf_land_other,fma_kf_policy_charge,fma_kf_proj_costs,fma_kf_facil_fee,fma_kf_landscap_road,fma_ja_proj_costs,fma_ja_basic_proj,fma_ja_underground_structure,fma_ja_ontheground_structure,fma_ja_exterior,fma_ja_initial_decoration,fma_ja_public_exquisite,fma_ja_indoor_exquisite,fma_ja_drainage,fma_ja_strong_current,fma_ja_heating,fma_ja_airiness,fma_ja_fire_control,fma_ja_elevator,fma_ja_weak_current,fma_ja_other,fma_pc_support_construct_fee,fma_pc_development_overhead,fma_pc_property_subsidy,fma_pc_resear_expenses,fma_pc_other,fma_sa_sales_expense,fma_sa_manage_expense,fma_sa_finance_expense,fma_sa_capitali_interest,fma_sa_expensed_interest,fma_sa_other,fma_ld_the_tax,fma_ld_urban_construc_tax,fma_ld_advance,fma_ld_payment,fma_ld_land_use_tax,fma_ld_stamp_duty,fma_ld_other,fma_total_investment,fma_controllable_costs,created,creator_id,creator,modified,modifier_id,modifier,belong_proj_id,OBJECT_LEVEL_NAME_ONE,OBJECT_LEVEL_NAME_TWO)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,id,object_name,object_type,kf_land_cost,kf_land_transfer_fee,kf_land_payment,kf_land_municipal_support,kf_land_deed_tax,kf_land_compensation,kf_land_other,kf_policy_charge,kf_proj_costs,kf_facil_fee,kf_landscap_road,ja_proj_costs,ja_basic_proj,ja_underground_structure,ja_ontheground_structure,ja_exterior,ja_initial_decoration,ja_public_exquisite,ja_indoor_exquisite,ja_drainage,ja_strong_current,ja_heating,ja_airiness,ja_fire_control,ja_elevator,ja_weak_current,ja_other,pc_support_construct_fee,pc_development_overhead,pc_property_subsidy,pc_resear_expenses,pc_other,sa_sales_expense,sa_manage_expense,sa_finance_expense,sa_capitali_interest,sa_expensed_interest,sa_other,ld_the_tax,ld_urban_construc_tax,ld_advance,ld_payment,ld_land_use_tax,ld_stamp_duty,ld_other,total_investment,controllable_costs,fma_kf_land_cost,fma_kf_land_transfer_fee,fma_kf_land_payment,fma_kf_land_municipal_support,fma_kf_land_deed_tax,fma_kf_land_compensation,fma_kf_land_other,fma_kf_policy_charge,fma_kf_proj_costs,fma_kf_facil_fee,fma_kf_landscap_road,fma_ja_proj_costs,fma_ja_basic_proj,fma_ja_underground_structure,fma_ja_ontheground_structure,fma_ja_exterior,fma_ja_initial_decoration,fma_ja_public_exquisite,fma_ja_indoor_exquisite,fma_ja_drainage,fma_ja_strong_current,fma_ja_heating,fma_ja_airiness,fma_ja_fire_control,fma_ja_elevator,fma_ja_weak_current,fma_ja_other,fma_pc_support_construct_fee,fma_pc_development_overhead,fma_pc_property_subsidy,fma_pc_resear_expenses,fma_pc_other,fma_sa_sales_expense,fma_sa_manage_expense,fma_sa_finance_expense,fma_sa_capitali_interest,fma_sa_expensed_interest,fma_sa_other,fma_ld_the_tax,fma_ld_urban_construc_tax,fma_ld_advance,fma_ld_payment,fma_ld_land_use_tax,fma_ld_stamp_duty,fma_ld_other,fma_total_investment,fma_controllable_costs,sysdate(),creator_id,creator,modified,modifier_id,modifier,belong_proj_id
,(case when object_type='之前实际完成合计' then planyear-1||OBJECT_LEVEL_NAME_ONE 
when object_type='1-9月实际完成' then planyear||OBJECT_LEVEL_NAME_ONE
when object_type='10-12月预计完成' then planyear||OBJECT_LEVEL_NAME_ONE
when object_type='本年合计' then planyear||OBJECT_LEVEL_NAME_ONE
when object_type='计划实施面积（按全案基本情况计费基数口径）' then planyear||OBJECT_LEVEL_NAME_ONE
else OBJECT_LEVEL_NAME_ONE end
)
as OBJECT_LEVEL_NAME_ONE

,OBJECT_LEVEL_NAME_TWO
FROM  OPM_T_PROJ_INVESTMENT_PLAN  WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------经营计划
END P_OPM_INIT_PROJ_INVESTMENT;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_PROJ_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ_OPERATING" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------经营计划
--删除该年；
DELETE FROM opm_proj_operating_index WHERE  (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;

INSERT INTO opm_proj_operating_index (id,plan_year,order_code,object_staging,object_type,belong_proj_id,delivery_date,construction_area_total,value_total,saleable_area_total,operating_income_total,profit_total,expect_total,last_started_area,last_completed_area,last_sales_amount,last_sales_area,last_sales_collection,last_unpaid_collection,last_operating_income,last_carryover_area,last_total_profit,last_net_profit,tosep_started_area,tosep_completed_area,tosep_sales_amount,tosep_sales_area,tosep_sales_collection,tosep_operating_income,tosep_carryover_area,tosep_total_profit,tosep_net_profit,todec_started_area,todec_completed_area,todec_sales_amount,todec_sales_area,todec_sales_collection,todec_operating_income,todec_carryover_area,todec_total_profit,todec_net_profit,started_area_total,completed_area_total,sales_amount_total,sales_area_total,sales_collection_total,expect_income_total,carryover_area_total,total_profit_total,net_profit_total,tired_started_area,tired_completed_area,tired_sales_amount,tired_sales_area,tired_sales_collection,tired_unpaid_collection,tired_operating_income,tired_carryover_area,tired_total_profit,tired_net_profit,ntstarted_area,ntcompleted_area,ntsales_amount,ntsales_area,ntunpaid_collection,ntsales_collection,ntcollection_total,ntoperating_income,ntcarryover_area,nttotal_profit,ntnet_profit,nttired_started_area,nttired_completed_area,nt_tired_sales_amount,ntired_sales_area,nttired_sales_collection,nttired_unpaid_collection,nttired_operating_income,nttired_carryover_area,nttired_total_profit,nttired_net_profit,tomar_release_revenue,tomar_release_profit,toapr_release_revenue,toapr_release_profit,remark,created,creator_id,creator,modified,modifier_id,modifier,fma_delivery_date,fma_construction_area_total,fma_value_total,fma_saleable_area_total,fma_operating_income_total,fma_profit_total,fma_expect_total,fma_last_started_area,fma_last_completed_area,fma_last_sales_amount,fma_last_sales_area,fma_last_sales_collection,fma_last_unpaid_collection,fma_last_operating_income,fma_last_carryover_area,fma_last_total_profit,fma_last_net_profit,fma_tosep_started_area,fma_tosep_completed_area,fma_tosep_sales_amount,fma_tosep_sales_area,fma_tosep_sales_collection,fma_tosep_operating_income,fma_tosep_carryover_area,fma_tosep_total_profit,fma_tosep_net_profit,fma_todec_started_area,fma_todec_completed_area,fma_todec_sales_amount,fma_todec_sales_area,fma_todec_sales_collection,fma_todec_operating_income,fma_todec_carryover_area,fma_todec_total_profit,fma_todec_net_profit,fma_started_area_total,fma_completed_area_total,fma_sales_amount_total,fma_sales_area_total,fma_sales_collection_total,fma_expect_income_total,fma_carryover_area_total,fma_total_profit_total,fma_net_profit_total,fma_tired_started_area,fma_tired_completed_area,fma_tired_sales_amount,fma_tired_sales_area,fma_tired_sales_collection,fma_tired_unpaid_collection,fma_tired_operating_income,fma_tired_carryover_area,fma_tired_total_profit,fma_tired_net_profit,fma_ntstarted_area,fma_ntcompleted_area,fma_ntsales_amount,fma_ntsales_area,fma_ntunpaid_collection,fma_ntsales_collection,fma_ntcollection_total,fma_ntoperating_income,fma_ntcarryover_area,fma_nttotal_profit,fma_ntnet_profit,fma_nttired_started_area,fma_nttired_completed_area,fma_nt_tired_sales_amount,fma_ntired_sales_area,fma_nttired_sales_collection,fma_nttired_unpaid_collection,fma_nttired_operating_income,fma_nttired_carryover_area,fma_nttired_total_profit,fma_nttired_net_profit,fma_tomar_release_revenue,fma_tomar_release_profit,fma_toapr_release_revenue,fma_toapr_release_profit,object_id)
SELECT sys_guid (),planyear,order_code,object_staging,object_type,belong_proj_id,delivery_date,construction_area_total,value_total,saleable_area_total,operating_income_total,profit_total,expect_total,last_started_area,last_completed_area,last_sales_amount,last_sales_area,last_sales_collection,last_unpaid_collection,last_operating_income,last_carryover_area,last_total_profit,last_net_profit,tosep_started_area,tosep_completed_area,tosep_sales_amount,tosep_sales_area,tosep_sales_collection,tosep_operating_income,tosep_carryover_area,tosep_total_profit,tosep_net_profit,todec_started_area,todec_completed_area,todec_sales_amount,todec_sales_area,todec_sales_collection,todec_operating_income,todec_carryover_area,todec_total_profit,todec_net_profit,started_area_total,completed_area_total,sales_amount_total,sales_area_total,sales_collection_total,expect_income_total,carryover_area_total,total_profit_total,net_profit_total,tired_started_area,tired_completed_area,tired_sales_amount,tired_sales_area,tired_sales_collection,tired_unpaid_collection,tired_operating_income,tired_carryover_area,tired_total_profit,tired_net_profit,ntstarted_area,ntcompleted_area,ntsales_amount,ntsales_area,ntunpaid_collection,ntsales_collection,ntcollection_total,ntoperating_income,ntcarryover_area,nttotal_profit,ntnet_profit,nttired_started_area,nttired_completed_area,nt_tired_sales_amount,ntired_sales_area,nttired_sales_collection,nttired_unpaid_collection,nttired_operating_income,nttired_carryover_area,nttired_total_profit,nttired_net_profit,tomar_release_revenue,tomar_release_profit,toapr_release_revenue,toapr_release_profit,remark,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_delivery_date,fma_construction_area_total,fma_value_total,fma_saleable_area_total,fma_operating_income_total,fma_profit_total,fma_expect_total,fma_last_started_area,fma_last_completed_area,fma_last_sales_amount,fma_last_sales_area,fma_last_sales_collection,fma_last_unpaid_collection,fma_last_operating_income,fma_last_carryover_area,fma_last_total_profit,fma_last_net_profit,fma_tosep_started_area,fma_tosep_completed_area,fma_tosep_sales_amount,fma_tosep_sales_area,fma_tosep_sales_collection,fma_tosep_operating_income,fma_tosep_carryover_area,fma_tosep_total_profit,fma_tosep_net_profit,fma_todec_started_area,fma_todec_completed_area,fma_todec_sales_amount,fma_todec_sales_area,fma_todec_sales_collection,fma_todec_operating_income,fma_todec_carryover_area,fma_todec_total_profit,fma_todec_net_profit,fma_started_area_total,fma_completed_area_total,fma_sales_amount_total,fma_sales_area_total,fma_sales_collection_total,fma_expect_income_total,fma_carryover_area_total,fma_total_profit_total,fma_net_profit_total,fma_tired_started_area,fma_tired_completed_area,fma_tired_sales_amount,fma_tired_sales_area,fma_tired_sales_collection,fma_tired_unpaid_collection,fma_tired_operating_income,fma_tired_carryover_area,fma_tired_total_profit,fma_tired_net_profit,fma_ntstarted_area,fma_ntcompleted_area,fma_ntsales_amount,fma_ntsales_area,fma_ntunpaid_collection,fma_ntsales_collection,fma_ntcollection_total,fma_ntoperating_income,fma_ntcarryover_area,fma_nttotal_profit,fma_ntnet_profit,fma_nttired_started_area,fma_nttired_completed_area,fma_nt_tired_sales_amount,fma_ntired_sales_area,fma_nttired_sales_collection,fma_nttired_unpaid_collection,fma_nttired_operating_income,fma_nttired_carryover_area,fma_nttired_total_profit,fma_nttired_net_profit,fma_tomar_release_revenue,fma_tomar_release_profit,fma_toapr_release_revenue,fma_toapr_release_profit,id 
FROM  opm_t_proj_operating_index  WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------经营计划
END P_OPM_INIT_PROJ_OPERATING;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_REGION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_REGION" (planyear IN number--计划年
,regionCompanyId IN VARCHAR2--区域公司id
) AS-- 根据模板初始化年度【区域级数据】
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------现金流
  begin
  P_OPM_INIT_REGION_CASH(
    PLANYEAR => PLANYEAR
    ,regionCompanyId=>regionCompanyId
  );
  end;
-----------------------------------供销存
  begin
  P_OPM_INIT_REGION_INVENTORY(
    PLANYEAR => PLANYEAR
     ,regionCompanyId=>regionCompanyId
  );
  end;
-----------------------------------
-----------------------------------经营计划
  begin
   P_OPM_INIT_REGION_OPERATING(
    PLANYEAR => PLANYEAR
     ,regionCompanyId=>regionCompanyId
  );
  end;
-----------------------------------
END P_OPM_INIT_REGION;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_REGION_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_REGION_CASH" (planyear IN number--计划年
,regionCompanyId IN VARCHAR2--区域公司id
) AS-- 根据模板初始化年度【区域级数据】---现金流
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionCompanyId is null or regionCompanyId='' then 1 else 0 end); 
BEGIN 
-----------------------------------现金流
--删除该年；
DELETE FROM opm_REGION_cash WHERE (BELONG_REGION_ID=regionCompanyId or 1=init_all) and plan_year=planyear ;
--根据模板初始化该年
INSERT INTO opm_region_cash (id,plan_year,parent_id,level_code,order_code,object_type,object_id,object_name,remaining_amount,sour_sales_collection,sour_rental_income,sour_increase_loan,sour_collection_loan,sour_shareholder_input,sour_investment_input,sour_other_input,sour_total_funds,util_land_cost,util_engineering_expenditure,util_development_overhead,util_expenses_the_period,util_taxes,util_pre_payment,util_other_expenses,util_current_expenditure,util_subtotal_fund,cash_flow_funds,cash_remaining_amount,cash_available_funds,fma_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_cash_remaining_amount,fma_available_funds,belong_region_id,created,creator_id,creator,modified,modifier,modifier_id)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,object_type,id,object_name,remaining_amount,sour_sales_collection,sour_rental_income,sour_increase_loan,sour_collection_loan,sour_shareholder_input,sour_investment_input,sour_other_input,sour_total_funds,util_land_cost,util_engineering_expenditure,util_development_overhead,util_expenses_the_period,util_taxes,util_pre_payment,util_other_expenses,util_current_expenditure,util_subtotal_fund,cash_flow_funds,cash_remaining_amount,cash_available_funds,fma_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_cash_remaining_amount,fma_available_funds,belong_region_id,sysdate(),creator_id,creator,modified,modifier,modifier_id 
FROM opm_t_REGION_cash  WHERE BELONG_REGION_ID=regionCompanyId or 1=init_all ;
-----------------------------------现金流
END P_OPM_INIT_REGION_CASH;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_REGION_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_REGION_INVENTORY" (planyear IN number--计划年
,regionCompanyId IN VARCHAR2--区域公司id
) AS-- 根据模板初始化年度【区域级数据】---供销存
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionCompanyId is null or regionCompanyId='' then 1 else 0 end); 
BEGIN 
-----------------------------------供销存
--删除该年；
DELETE FROM OPM_REGION_INVENTORY_PLAN WHERE (BELONG_REGION_ID=regionCompanyId or 1=init_all) and plan_year=planyear ;
INSERT INTO opm_region_inventory_plan (id,plan_year,parent_id,level_code,order_code,object_id,object_name,object_type,belong_region_id,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,created,creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,id,object_name,object_type,belong_region_id,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount 
FROM  opm_t_REGION_inventory_plan WHERE  BELONG_REGION_ID=regionCompanyId or 1=init_all ;
-----------------------------------供销存
END P_OPM_INIT_REGION_INVENTORY;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_INIT_REGION_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_INIT_REGION_OPERATING" (planyear IN number--计划年
,regionCompanyId IN VARCHAR2--区域公司id
) AS-- 根据模板初始化年度【区域级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionCompanyId is null or regionCompanyId='' then 1 else 0 end); 
BEGIN 
-----------------------------------经营计划
--删除该年；
DELETE FROM OPM_REGION_INVENTORY_PLAN WHERE  (BELONG_REGION_ID=regionCompanyId or 1=init_all) and plan_year=planyear ;

INSERT INTO opm_region_operating_plan (id,plan_year,parent_id,level_code,order_code,object_type,belong_region_id,object_id,object_name,railway_bool,estate_bool,estate_ratio,railway_ratio,build_land_area,surface_total_area,above_ground_area,construction_stage,total_investment,total_saleable_area,total_value,last_started_area,last_completed_area,this_started_area,this_completed_area,todec_due_time,todec_delivery_installment,cutoff_started_area,cutoff_completed_area,next_started_area,next_completed_area,next_due_time,next_delivery_installment,cutoff_last_started_area,cutoff_last_completed_area,cutoff_sales_area,cotoff_sales_amount,remaining_value_area,remaining_value_amount,added_supply_area,added_supply_amount,expected_sales_area,expected_sales_amount,equity_sales_amount,tired_supply_area,tired_supply_amount,tired_sales_area,tired_sales_amount,tired_stock_area,tired_stock_amount,tired_remaining_area,tired_remaining_amount,forecast_supply_area,forecast_supply_amount,forecast_sales_area,forecast_sales_amount,forecast_equity_amount,forecast_tired_area,forecast_tired_amount,forecast_cotoff_area,forecast_cotoff_amount,forecast_stock_area,forecast_stock_amount,forecast_remaining_area,forecast_remaining_amount,sac_last_sale_amount,sac_last_unpaid_amount,sac_then_sale_amount,sac_then_equity_sale,tried_sale_amount,tried_unpaid_amount,sac_next_sale_amount,sac_next_equity_sale,sac_tried_sale_amount,sac_tried_unpaid_amount,inv_last_investment,inv_then_actual,inv_then_payment,inv_invest_firm,inv_external_financing,inv_sales_collection,inv_land_price,inv_then_investment,inv_plan_investment,inv_invest_funds,inv_next_invest_funds,inv_next_external_finan,inv_next_sales_collection,inv_next_land_price,inv_next_investment,ltopera_income,ltopera_income_outside,ltopera_income_inside,lttotal_profit,ltprofit_inside,ltprofit_outside,ltprofit_outside_equity,ltprofit_inside_equity,thopera_income,thopera_income_outside,thopera_income_inside,thtotal_profit,thprofit_inside,thprofit_outside,thprofit_outside_equity,thprofit_inside_equity,end_opera_income,end_opera_income_outside,end_opera_income_inside,end_total_profit,end_profit_inside,end_profit_outside,end_profit_outside_equity,end_profit_inside_equity,ntprofit_inside_equity,ntopera_income_outside,ntopera_income_inside,nttotal_profit,ntprofit_inside,ntprofit_outside,ntprofit_outside_equity,ntprofit_rights_equity,entnt_opera_income,entnt_opera_income_out,entnt_opera_income_ins,entnt_total_profit,entnt_profit_inside,entnt_profit_outside,entnt_profit_out_equity,entnt_profit_ins_equity,own_return_time,full_return_time,freed_value,tomar_opera_income,tomar_opera_income_ins,tomar_total_profit,tomar_profit_inside,tomar_profit_equity,toapr_opera_income,toapr_opera_income_ins,toapr_total_profit,toapr_profit_inside,toapr_profit_equity,created,creator_id,creator,modified,modifier_id,modifier,fma_construction_stage,fma_total_investment,fma_total_saleable_area,fma_total_value,fma_last_started_area,fma_last_completed_area,fma_this_started_area,fma_this_completed_area,fma_todec_due_time,fma_todec_delivery_installment,fma_cutoff_started_area,fma_cutoff_completed_area,fma_next_started_area,fma_next_completed_area,fma_next_due_time,fma_next_delivery_installment,fma_cutoff_last_started_area,fma_cutoff_last_completed_area,fma_cutoff_sales_area,fma_cotoff_sales_amount,fma_remaining_value_area,fma_remaining_value_amount,fma_added_supply_area,fma_added_supply_amount,fma_expected_sales_area,fma_expected_sales_amount,fma_equity_sales_amount,fma_tired_supply_area,fma_tired_supply_amount,fma_tired_sales_area,fma_tired_sales_amount,fma_tired_stock_area,fma_tired_stock_amount,fma_tired_remaining_area,fma_tired_remaining_amount,fma_forecast_supply_area,fma_forecast_supply_amount,fma_forecast_sales_area,fma_forecast_sales_amount,fma_forecast_equity_amount,fma_forecast_tired_area,fma_forecast_tired_amount,fma_forecast_cotoff_area,fma_forecast_cotoff_amount,fma_forecast_stock_area,fma_forecast_stock_amount,fma_forecast_remaining_area,fma_forecast_remaining_amount,fma_sac_last_sale_amount,fma_sac_last_unpaid_amount,fma_sac_then_sale_amount,fma_sac_then_equity_sale,fma_tried_sale_amount,fma_tried_unpaid_amount,fma_sac_next_sale_amount,fma_sac_next_equity_sale,fma_sac_tried_sale_amount,fma_sac_tried_unpaid_amount,fma_inv_last_investment,fma_inv_then_actual,fma_inv_then_payment,fma_inv_invest_firm,fma_inv_external_financing,fma_inv_sales_collection,fma_inv_land_price,fma_inv_then_investment,fma_inv_plan_investment,fma_inv_invest_funds,fma_inv_next_invest_funds,fma_inv_next_external_finan,fma_inv_next_sales_collection,fma_inv_next_land_price,fma_inv_next_investment,fma_ltopera_income,fma_ltopera_income_outside,fma_ltopera_income_inside,fma_lttotal_profit,fma_ltprofit_inside,fma_ltprofit_outside,fma_ltprofit_outside_equity,fma_ltprofit_inside_equity,fma_thopera_income,fma_thopera_income_outside,fma_thopera_income_inside,fma_thtotal_profit,fma_thprofit_inside,fma_thprofit_outside,fma_thprofit_outside_equity,fma_thprofit_inside_equity,fma_end_opera_income,fma_end_opera_income_outside,fma_end_opera_income_inside,fma_end_total_profit,fma_end_profit_inside,fma_end_profit_outside,fma_end_profit_outside_equity,fma_end_profit_inside_equity,fma_ntprofit_inside_equity,fma_ntopera_income_outside,fma_ntopera_income_inside,fma_nttotal_profit,fma_ntprofit_inside,fma_ntprofit_outside,fma_ntprofit_outside_equity,fma_ntprofit_rights_equity,fma_entnt_opera_income,fma_entnt_opera_income_out,fma_entnt_opera_income_ins,fma_entnt_total_profit,fma_entnt_profit_inside,fma_entnt_profit_outside,fma_entnt_profit_out_equity,fma_entnt_profit_ins_equity,fma_own_return_time,fma_full_return_time,fma_freed_value,fma_tomar_opera_income,fma_tomar_opera_income_ins,fma_tomar_total_profit,fma_tomar_profit_inside,fma_tomar_profit_equity,fma_toapr_opera_income,fma_toapr_opera_income_ins,fma_toapr_total_profit,fma_toapr_profit_inside,fma_toapr_profit_equity,fma_railway_bool,fma_estate_bool,fma_estate_ratio,fma_railway_ratio,fma_build_land_area,fma_surface_total_area,fma_above_ground_area)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,object_type,belong_region_id,id,object_name,railway_bool,estate_bool,estate_ratio,railway_ratio,build_land_area,surface_total_area,above_ground_area,construction_stage,total_investment,total_saleable_area,total_value,last_started_area,last_completed_area,this_started_area,this_completed_area,todec_due_time,todec_delivery_installment,cutoff_started_area,cutoff_completed_area,next_started_area,next_completed_area,next_due_time,next_delivery_installment,cutoff_last_started_area,cutoff_last_completed_area,cutoff_sales_area,cotoff_sales_amount,remaining_value_area,remaining_value_amount,added_supply_area,added_supply_amount,expected_sales_area,expected_sales_amount,equity_sales_amount,tired_supply_area,tired_supply_amount,tired_sales_area,tired_sales_amount,tired_stock_area,tired_stock_amount,tired_remaining_area,tired_remaining_amount,forecast_supply_area,forecast_supply_amount,forecast_sales_area,forecast_sales_amount,forecast_equity_amount,forecast_tired_area,forecast_tired_amount,forecast_cotoff_area,forecast_cotoff_amount,forecast_stock_area,forecast_stock_amount,forecast_remaining_area,forecast_remaining_amount,sac_last_sale_amount,sac_last_unpaid_amount,sac_then_sale_amount,sac_then_equity_sale,tried_sale_amount,tried_unpaid_amount,sac_next_sale_amount,sac_next_equity_sale,sac_tried_sale_amount,sac_tried_unpaid_amount,inv_last_investment,inv_then_actual,inv_then_payment,inv_invest_firm,inv_external_financing,inv_sales_collection,inv_land_price,inv_then_investment,inv_plan_investment,inv_invest_funds,inv_next_invest_funds,inv_next_external_finan,inv_next_sales_collection,inv_next_land_price,inv_next_investment,ltopera_income,ltopera_income_outside,ltopera_income_inside,lttotal_profit,ltprofit_inside,ltprofit_outside,ltprofit_outside_equity,ltprofit_inside_equity,thopera_income,thopera_income_outside,thopera_income_inside,thtotal_profit,thprofit_inside,thprofit_outside,thprofit_outside_equity,thprofit_inside_equity,end_opera_income,end_opera_income_outside,end_opera_income_inside,end_total_profit,end_profit_inside,end_profit_outside,end_profit_outside_equity,end_profit_inside_equity,ntprofit_inside_equity,ntopera_income_outside,ntopera_income_inside,nttotal_profit,ntprofit_inside,ntprofit_outside,ntprofit_outside_equity,ntprofit_rights_equity,entnt_opera_income,entnt_opera_income_out,entnt_opera_income_ins,entnt_total_profit,entnt_profit_inside,entnt_profit_outside,entnt_profit_out_equity,entnt_profit_ins_equity,own_return_time,full_return_time,freed_value,tomar_opera_income,tomar_opera_income_ins,tomar_total_profit,tomar_profit_inside,tomar_profit_equity,toapr_opera_income,toapr_opera_income_ins,toapr_total_profit,toapr_profit_inside,toapr_profit_equity,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_construction_stage,fma_total_investment,fma_total_saleable_area,fma_total_value,fma_last_started_area,fma_last_completed_area,fma_this_started_area,fma_this_completed_area,fma_todec_due_time,fma_todec_delivery_installment,fma_cutoff_started_area,fma_cutoff_completed_area,fma_next_started_area,fma_next_completed_area,fma_next_due_time,fma_next_delivery_installment,fma_cutoff_last_started_area,fma_cutoff_last_completed_area,fma_cutoff_sales_area,fma_cotoff_sales_amount,fma_remaining_value_area,fma_remaining_value_amount,fma_added_supply_area,fma_added_supply_amount,fma_expected_sales_area,fma_expected_sales_amount,fma_equity_sales_amount,fma_tired_supply_area,fma_tired_supply_amount,fma_tired_sales_area,fma_tired_sales_amount,fma_tired_stock_area,fma_tired_stock_amount,fma_tired_remaining_area,fma_tired_remaining_amount,fma_forecast_supply_area,fma_forecast_supply_amount,fma_forecast_sales_area,fma_forecast_sales_amount,fma_forecast_equity_amount,fma_forecast_tired_area,fma_forecast_tired_amount,fma_forecast_cotoff_area,fma_forecast_cotoff_amount,fma_forecast_stock_area,fma_forecast_stock_amount,fma_forecast_remaining_area,fma_forecast_remaining_amount,fma_sac_last_sale_amount,fma_sac_last_unpaid_amount,fma_sac_then_sale_amount,fma_sac_then_equity_sale,fma_tried_sale_amount,fma_tried_unpaid_amount,fma_sac_next_sale_amount,fma_sac_next_equity_sale,fma_sac_tried_sale_amount,fma_sac_tried_unpaid_amount,fma_inv_last_investment,fma_inv_then_actual,fma_inv_then_payment,fma_inv_invest_firm,fma_inv_external_financing,fma_inv_sales_collection,fma_inv_land_price,fma_inv_then_investment,fma_inv_plan_investment,fma_inv_invest_funds,fma_inv_next_invest_funds,fma_inv_next_external_finan,fma_inv_next_sales_collection,fma_inv_next_land_price,fma_inv_next_investment,fma_ltopera_income,fma_ltopera_income_outside,fma_ltopera_income_inside,fma_lttotal_profit,fma_ltprofit_inside,fma_ltprofit_outside,fma_ltprofit_outside_equity,fma_ltprofit_inside_equity,fma_thopera_income,fma_thopera_income_outside,fma_thopera_income_inside,fma_thtotal_profit,fma_thprofit_inside,fma_thprofit_outside,fma_thprofit_outside_equity,fma_thprofit_inside_equity,fma_end_opera_income,fma_end_opera_income_outside,fma_end_opera_income_inside,fma_end_total_profit,fma_end_profit_inside,fma_end_profit_outside,fma_end_profit_outside_equity,fma_end_profit_inside_equity,fma_ntprofit_inside_equity,fma_ntopera_income_outside,fma_ntopera_income_inside,fma_nttotal_profit,fma_ntprofit_inside,fma_ntprofit_outside,fma_ntprofit_outside_equity,fma_ntprofit_rights_equity,fma_entnt_opera_income,fma_entnt_opera_income_out,fma_entnt_opera_income_ins,fma_entnt_total_profit,fma_entnt_profit_inside,fma_entnt_profit_outside,fma_entnt_profit_out_equity,fma_entnt_profit_ins_equity,fma_own_return_time,fma_full_return_time,fma_freed_value,fma_tomar_opera_income,fma_tomar_opera_income_ins,fma_tomar_total_profit,fma_tomar_profit_inside,fma_tomar_profit_equity,fma_toapr_opera_income,fma_toapr_opera_income_ins,fma_toapr_total_profit,fma_toapr_profit_inside,fma_toapr_profit_equity,fma_railway_bool,fma_estate_bool,fma_estate_ratio,fma_railway_ratio,fma_build_land_area,fma_surface_total_area,fma_above_ground_area 
FROM opm_t_region_operating_plan  WHERE  BELONG_REGION_ID=regionCompanyId or 1=init_all ;
-----------------------------------经营计划
END P_OPM_INIT_REGION_OPERATING;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_PROJ_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_PROJ_LIST" (
    userid         IN             VARCHAR2, --当前用户id
    stationid      IN             VARCHAR2, --当前用户岗位id
    departmentid   IN             VARCHAR2, --当前用户部门id
    companyid      IN             VARCHAR2, --当前用户公司id
    unitid         IN             VARCHAR2, --选择公司id
    isoperate      IN             VARCHAR2,--是否操盘
    tabsindex      IN             INT, --选择选项卡。1开始
    info           OUT            SYS_REFCURSOR--返回结果
) AS
--年度经营计划列表
--作者：wuy
--日期：2021/08/31
    data_auth_spid   VARCHAR2(200);
    bizcode          VARCHAR2(200);
    unitid_val       VARCHAR2(200);
BEGIN 
    --权限编码
    unitid_val:=nvl(unitid,'003200000000000000000000000000');
    bizcode := 'DWM.DTHZGL.03';
    p_sys_get_company_proj_spid(userid => userid, stationid => stationid, deptid => departmentid, companyid => companyid, bizcode
    => bizcode, data_auth_spid => data_auth_spid);

    IF tabsindex = 1 THEN
        dbms_output.put_line('所有业态!');
    ELSIF tabsindex = 2 THEN
        dbms_output.put_line('住宅及商办!');
    ELSIF tabsindex = 3 THEN
        dbms_output.put_line('住宅!');
    ELSIF tabsindex = 4 THEN
        dbms_output.put_line('商办!');
    ELSIF tabsindex = 5 THEN
        dbms_output.put_line('车位!');
    ELSIF tabsindex = 6 THEN
        dbms_output.put_line('剩余货量表!');
        OPEN info FOR 
				WITH TEMP_DT_VALUE (ID,COMPANY_ID, ORG_NAME, OBJ_TYPE, VALUE_DT_ALL, VALUE_REMAIN, VALUE_HAVED_SALE, VALUE_RESERVE, VALUE_IN_PROCESS, VALUE_ALLOW_SALE, VALUE_STOCK,
       VALUE_NOT_PLANNING_PERMIT, VALUE_NOT_CONSTRUCTION_PERMIT, VALUE_NOT_SALE_PERMIT, VALUE_NOT_COMPLETION, VALUE_YES_COMPLETION, VALUE_YES_SETTLEMENT, AREA_DT_ALL, AREA_REMAIN,
       AREA_HAVED_SALE, AREA_RESERVE, AREA_IN_PROCESS, AREA_ALLOW_SALE, AREA_STOCK, AREA_NOT_PLANNING_PERMIT, AREA_NOT_CONSTRUCTION_PERMIT, AREA_NOT_SALE_PERMIT, AREA_NOT_COMPLETION,
       AREA_YES_COMPLETION, AREA_YES_SETTLEMENT, TMP_1KY_VALUE, TMP_1KY_AREA, TMP_1KY_PRICE, TMP_2QP_VALUE, TMP_2QP_AREA, TMP_2QP_PRICE, TMP_3DT_TARGETVALUE, TMP_3DT_TARGETAREA,
       TMP_3DT_TARGETPRICE, CW_VALUE_DT_ALL, CW_VALUE_REMAIN, CW_VALUE_HAVED_SALE, CW_VALUE_RESERVE, CW_VALUE_IN_PROCESS, CW_VALUE_ALLOW_SALE, CW_VALUE_STOCK,
       CW_VALUE_NOT_PLANNING_PERMIT, CW_VALUE_NOT_CONSTRUCTION_PER, CW_VALUE_NOT_SALE_PERMIT, CW_VALUE_NOT_COMPLETION, CW_VALUE_YES_COMPLETION, CW_VALUE_YES_SETTLEMENT, CW_AREA_DT_ALL,
       CW_AREA_REMAIN, CW_AREA_HAVED_SALE, CW_AREA_RESERVE, CW_AREA_IN_PROCESS, CW_AREA_ALLOW_SALE, CW_AREA_STOCK, CW_AREA_NOT_PLANNING_PERMIT, CW_AREA_NOT_CONSTRUCTION_PER,
       CW_AREA_NOT_SALE_PERMIT, CW_AREA_NOT_COMPLETION, CW_AREA_YES_COMPLETION, CW_AREA_YES_SETTLEMENT, ZZ_VALUE_DT_ALL, ZZ_VALUE_REMAIN, ZZ_VALUE_HAVED_SALE, ZZ_VALUE_RESERVE,
       ZZ_VALUE_IN_PROCESS, ZZ_VALUE_ALLOW_SALE, ZZ_VALUE_STOCK, ZZ_VALUE_NOT_PLANNING_PERMIT, ZZ_VALUE_NOT_CONSTRUCTION_PER, ZZ_VALUE_NOT_SALE_PERMIT, ZZ_VALUE_NOT_COMPLETION,
       ZZ_VALUE_YES_COMPLETION, ZZ_VALUE_YES_SETTLEMENT, ZZ_AREA_DT_ALL, ZZ_AREA_REMAIN, ZZ_AREA_HAVED_SALE, ZZ_AREA_RESERVE, ZZ_AREA_IN_PROCESS, ZZ_AREA_ALLOW_SALE, ZZ_AREA_STOCK,
       ZZ_AREA_NOT_PLANNING_PERMIT, ZZ_AREA_NOT_CONSTRUCTION_PER, ZZ_AREA_NOT_SALE_PERMIT, ZZ_AREA_NOT_COMPLETION, ZZ_AREA_YES_COMPLETION, ZZ_AREA_YES_SETTLEMENT, SY_VALUE_DT_ALL,
       SY_VALUE_REMAIN, SY_VALUE_HAVED_SALE, SY_VALUE_RESERVE, SY_VALUE_IN_PROCESS, SY_VALUE_ALLOW_SALE, SY_VALUE_STOCK, SY_VALUE_NOT_PLANNING_PERMIT, SY_VALUE_NOT_CONSTRUCTION_PER,
       SY_VALUE_NOT_SALE_PERMIT, SY_VALUE_NOT_COMPLETION, SY_VALUE_YES_COMPLETION, SY_VALUE_YES_SETTLEMENT, SY_AREA_DT_ALL, SY_AREA_REMAIN, SY_AREA_HAVED_SALE, SY_AREA_RESERVE,
       SY_AREA_IN_PROCESS, SY_AREA_ALLOW_SALE, SY_AREA_STOCK, SY_AREA_NOT_PLANNING_PERMIT, SY_AREA_NOT_CONSTRUCTION_PER, SY_AREA_NOT_SALE_PERMIT, SY_AREA_NOT_COMPLETION,
       SY_AREA_YES_COMPLETION, SY_AREA_YES_SETTLEMENT, PROJ_ID, TARGET_NOW_NAME, TARGET_A_ID, TARGET_A1_ID, TARGET_A2_ID, TARGET_A3_ID, TARGET_A_VALUE, TARGET_A1_VALUE,
       TARGET_A2_VALUE, TARGET_A3_VALUE, TARGET_A_VALUE_DIFF,PARENT_ID,PROJ_COOPERATE,TAKE_DATE,IS_COMPANY,ORG_LEVEL,ORDER_HIERARCHY_CODE) AS 
       (     
SELECT A1.ID,A1.COMPANY_ID, B1.OBJ_NAME, B1.OBJ_TYPE, B1.VALUE_DT_ALL, B1.VALUE_REMAIN, B1.VALUE_HAVED_SALE, B1.VALUE_RESERVE, B1.VALUE_IN_PROCESS, B1.VALUE_ALLOW_SALE, B1.VALUE_STOCK,
       B1.VALUE_NOT_PLANNING_PERMIT, B1.VALUE_NOT_CONSTRUCTION_PERMIT, B1.VALUE_NOT_SALE_PERMIT, B1.VALUE_NOT_COMPLETION, B1.VALUE_YES_COMPLETION, B1.VALUE_YES_SETTLEMENT, B1.AREA_DT_ALL, B1.AREA_REMAIN,
       B1.AREA_HAVED_SALE, B1.AREA_RESERVE, B1.AREA_IN_PROCESS, B1.AREA_ALLOW_SALE, B1.AREA_STOCK, B1.AREA_NOT_PLANNING_PERMIT, B1.AREA_NOT_CONSTRUCTION_PERMIT, B1.AREA_NOT_SALE_PERMIT, B1.AREA_NOT_COMPLETION,
       B1.AREA_YES_COMPLETION, B1.AREA_YES_SETTLEMENT, B1.TMP_1KY_VALUE, B1.TMP_1KY_AREA, B1.TMP_1KY_PRICE, B1.TMP_2QP_VALUE, B1.TMP_2QP_AREA, B1.TMP_2QP_PRICE, B1.TMP_3DT_TARGETVALUE, B1.TMP_3DT_TARGETAREA,
       B1.TMP_3DT_TARGETPRICE, B1.CW_VALUE_DT_ALL, B1.CW_VALUE_REMAIN, B1.CW_VALUE_HAVED_SALE, B1.CW_VALUE_RESERVE, B1.CW_VALUE_IN_PROCESS, B1.CW_VALUE_ALLOW_SALE, B1.CW_VALUE_STOCK,
       B1.CW_VALUE_NOT_PLANNING_PERMIT, B1.CW_VALUE_NOT_CONSTRUCTION_PER, B1.CW_VALUE_NOT_SALE_PERMIT, B1.CW_VALUE_NOT_COMPLETION, B1.CW_VALUE_YES_COMPLETION, B1.CW_VALUE_YES_SETTLEMENT, B1.CW_AREA_DT_ALL,
       B1.CW_AREA_REMAIN, B1.CW_AREA_HAVED_SALE, B1.CW_AREA_RESERVE, B1.CW_AREA_IN_PROCESS, B1.CW_AREA_ALLOW_SALE, B1.CW_AREA_STOCK, B1.CW_AREA_NOT_PLANNING_PERMIT, B1.CW_AREA_NOT_CONSTRUCTION_PER,
       B1.CW_AREA_NOT_SALE_PERMIT, B1.CW_AREA_NOT_COMPLETION, B1.CW_AREA_YES_COMPLETION, B1.CW_AREA_YES_SETTLEMENT, B1.ZZ_VALUE_DT_ALL, B1.ZZ_VALUE_REMAIN, B1.ZZ_VALUE_HAVED_SALE, B1.ZZ_VALUE_RESERVE,
       B1.ZZ_VALUE_IN_PROCESS, B1.ZZ_VALUE_ALLOW_SALE, B1.ZZ_VALUE_STOCK, B1.ZZ_VALUE_NOT_PLANNING_PERMIT, B1.ZZ_VALUE_NOT_CONSTRUCTION_PER, B1.ZZ_VALUE_NOT_SALE_PERMIT, B1.ZZ_VALUE_NOT_COMPLETION,
       B1.ZZ_VALUE_YES_COMPLETION, B1.ZZ_VALUE_YES_SETTLEMENT, B1.ZZ_AREA_DT_ALL, B1.ZZ_AREA_REMAIN, B1.ZZ_AREA_HAVED_SALE, B1.ZZ_AREA_RESERVE, B1.ZZ_AREA_IN_PROCESS, B1.ZZ_AREA_ALLOW_SALE, B1.ZZ_AREA_STOCK,
       B1.ZZ_AREA_NOT_PLANNING_PERMIT, B1.ZZ_AREA_NOT_CONSTRUCTION_PER, B1.ZZ_AREA_NOT_SALE_PERMIT, B1.ZZ_AREA_NOT_COMPLETION, B1.ZZ_AREA_YES_COMPLETION, B1.ZZ_AREA_YES_SETTLEMENT, B1.SY_VALUE_DT_ALL,
       B1.SY_VALUE_REMAIN, B1.SY_VALUE_HAVED_SALE, B1.SY_VALUE_RESERVE, B1.SY_VALUE_IN_PROCESS, B1.SY_VALUE_ALLOW_SALE, B1.SY_VALUE_STOCK, B1.SY_VALUE_NOT_PLANNING_PERMIT, B1.SY_VALUE_NOT_CONSTRUCTION_PER,
       B1.SY_VALUE_NOT_SALE_PERMIT, B1.SY_VALUE_NOT_COMPLETION, B1.SY_VALUE_YES_COMPLETION, B1.SY_VALUE_YES_SETTLEMENT, B1.SY_AREA_DT_ALL, B1.SY_AREA_REMAIN, B1.SY_AREA_HAVED_SALE, B1.SY_AREA_RESERVE,
       B1.SY_AREA_IN_PROCESS, B1.SY_AREA_ALLOW_SALE, B1.SY_AREA_STOCK, B1.SY_AREA_NOT_PLANNING_PERMIT, B1.SY_AREA_NOT_CONSTRUCTION_PER, B1.SY_AREA_NOT_SALE_PERMIT, B1.SY_AREA_NOT_COMPLETION,
       B1.SY_AREA_YES_COMPLETION, B1.SY_AREA_YES_SETTLEMENT, B1.PROJ_ID, B1.TARGET_NOW_NAME, B1.TARGET_A_ID, B1.TARGET_A1_ID, B1.TARGET_A2_ID, B1.TARGET_A3_ID, B1.TARGET_A_VALUE, B1.TARGET_A1_VALUE,
       B1.TARGET_A2_VALUE, B1.TARGET_A3_VALUE, B1.TARGET_A_VALUE_DIFF,A1.COMPANY_ID AS PARENT_ID,NVL(A1.PROJ_COOPERATE,'操盘'),TO_CHAR(A1.PROJECT_GET_TIME,'YYYY-MM-DD') AS TAKE_DATE,0,4,a1.ORDER_HIERARCHY_CODE
FROM   MDM_PROJECT A1
INNER  JOIN DWM_DT_VALUE B1
ON     A1.ID = B1.OBJ_ID AND B1.OBJ_TYPE = '项目'
WHERE  a1.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a1.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END) 
UNION ALL
SELECT B2.ID,A2.PARENT_ID, B2.ORG_NAME, '公司', A2.VALUE_DT_ALL, A2.VALUE_REMAIN, A2.VALUE_HAVED_SALE, A2.VALUE_RESERVE, A2.VALUE_IN_PROCESS, A2.VALUE_ALLOW_SALE, A2.VALUE_STOCK,
       A2.VALUE_NOT_PLANNING_PERMIT, A2.VALUE_NOT_CONSTRUCTION_PERMIT, A2.VALUE_NOT_SALE_PERMIT, A2.VALUE_NOT_COMPLETION, A2.VALUE_YES_COMPLETION, A2.VALUE_YES_SETTLEMENT, A2.AREA_DT_ALL, A2.AREA_REMAIN,
       A2.AREA_HAVED_SALE, A2.AREA_RESERVE, A2.AREA_IN_PROCESS, A2.AREA_ALLOW_SALE, A2.AREA_STOCK, A2.AREA_NOT_PLANNING_PERMIT, A2.AREA_NOT_CONSTRUCTION_PERMIT, A2.AREA_NOT_SALE_PERMIT, A2.AREA_NOT_COMPLETION,
       A2.AREA_YES_COMPLETION, A2.AREA_YES_SETTLEMENT, A2.TMP_1KY_VALUE, A2.TMP_1KY_AREA, A2.TMP_1KY_PRICE, A2.TMP_2QP_VALUE, A2.TMP_2QP_AREA, A2.TMP_2QP_PRICE, A2.TMP_3DT_TARGETVALUE, A2.TMP_3DT_TARGETAREA,
       A2.TMP_3DT_TARGETPRICE, A2.CW_VALUE_DT_ALL, A2.CW_VALUE_REMAIN, A2.CW_VALUE_HAVED_SALE, A2.CW_VALUE_RESERVE, A2.CW_VALUE_IN_PROCESS, A2.CW_VALUE_ALLOW_SALE, A2.CW_VALUE_STOCK,
       A2.CW_VALUE_NOT_PLANNING_PERMIT, A2.CW_VALUE_NOT_CONSTRUCTION_PER, A2.CW_VALUE_NOT_SALE_PERMIT, A2.CW_VALUE_NOT_COMPLETION, A2.CW_VALUE_YES_COMPLETION, A2.CW_VALUE_YES_SETTLEMENT, A2.CW_AREA_DT_ALL,
       A2.CW_AREA_REMAIN, A2.CW_AREA_HAVED_SALE, A2.CW_AREA_RESERVE, A2.CW_AREA_IN_PROCESS, A2.CW_AREA_ALLOW_SALE, A2.CW_AREA_STOCK, A2.CW_AREA_NOT_PLANNING_PERMIT, A2.CW_AREA_NOT_CONSTRUCTION_PER,
       A2.CW_AREA_NOT_SALE_PERMIT, A2.CW_AREA_NOT_COMPLETION, A2.CW_AREA_YES_COMPLETION, A2.CW_AREA_YES_SETTLEMENT, A2.ZZ_VALUE_DT_ALL, A2.ZZ_VALUE_REMAIN, A2.ZZ_VALUE_HAVED_SALE, A2.ZZ_VALUE_RESERVE,
       A2.ZZ_VALUE_IN_PROCESS, A2.ZZ_VALUE_ALLOW_SALE, A2.ZZ_VALUE_STOCK, A2.ZZ_VALUE_NOT_PLANNING_PERMIT, A2.ZZ_VALUE_NOT_CONSTRUCTION_PER, A2.ZZ_VALUE_NOT_SALE_PERMIT, A2.ZZ_VALUE_NOT_COMPLETION,
       A2.ZZ_VALUE_YES_COMPLETION, A2.ZZ_VALUE_YES_SETTLEMENT, A2.ZZ_AREA_DT_ALL, A2.ZZ_AREA_REMAIN, A2.ZZ_AREA_HAVED_SALE, A2.ZZ_AREA_RESERVE, A2.ZZ_AREA_IN_PROCESS, A2.ZZ_AREA_ALLOW_SALE, A2.ZZ_AREA_STOCK,
       A2.ZZ_AREA_NOT_PLANNING_PERMIT, A2.ZZ_AREA_NOT_CONSTRUCTION_PER, A2.ZZ_AREA_NOT_SALE_PERMIT, A2.ZZ_AREA_NOT_COMPLETION, A2.ZZ_AREA_YES_COMPLETION, A2.ZZ_AREA_YES_SETTLEMENT, A2.SY_VALUE_DT_ALL,
       A2.SY_VALUE_REMAIN, A2.SY_VALUE_HAVED_SALE, A2.SY_VALUE_RESERVE, A2.SY_VALUE_IN_PROCESS, A2.SY_VALUE_ALLOW_SALE, A2.SY_VALUE_STOCK, A2.SY_VALUE_NOT_PLANNING_PERMIT, A2.SY_VALUE_NOT_CONSTRUCTION_PER,
       A2.SY_VALUE_NOT_SALE_PERMIT, A2.SY_VALUE_NOT_COMPLETION, A2.SY_VALUE_YES_COMPLETION, A2.SY_VALUE_YES_SETTLEMENT, A2.SY_AREA_DT_ALL, A2.SY_AREA_REMAIN, A2.SY_AREA_HAVED_SALE, A2.SY_AREA_RESERVE,
       A2.SY_AREA_IN_PROCESS, A2.SY_AREA_ALLOW_SALE, A2.SY_AREA_STOCK, A2.SY_AREA_NOT_PLANNING_PERMIT, A2.SY_AREA_NOT_CONSTRUCTION_PER, A2.SY_AREA_NOT_SALE_PERMIT, A2.SY_AREA_NOT_COMPLETION,
       A2.SY_AREA_YES_COMPLETION, A2.SY_AREA_YES_SETTLEMENT, A2.PROJ_ID, A2.TARGET_NOW_NAME, A2.TARGET_A_ID, A2.TARGET_A1_ID, A2.TARGET_A2_ID, A2.TARGET_A3_ID, A2.TARGET_A_VALUE, A2.TARGET_A1_VALUE,
       A2.TARGET_A2_VALUE, A2.TARGET_A3_VALUE, A2.TARGET_A_VALUE_DIFF,B2.PARENT_ID,'','',1,B2.LEVEL_RANK,b2.ORDER_HIERARCHY_CODE
FROM TEMP_DT_VALUE A2
INNER JOIN SYS_BUSINESS_UNIT B2 ON A2.PARENT_ID = B2.ID AND B2.IS_COMPANY = 1
)


				SELECT
                          a.id          AS "orgId",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id   AS "parentId",--父级id（生成树父级id）
                          ORG_LEVEL AS "orgLevel",
                          0 AS "itemsNum",
                          0 AS "submitNum",
                          CASE
                              WHEN ORG_LEVEL = 1 THEN
                                  '' || org_name
                              WHEN ORG_LEVEL = 2 THEN
                                  '        ' || org_name
                              WHEN ORG_LEVEL = 3 THEN
                                  '                ' || org_name
                              WHEN ORG_LEVEL = 4 THEN
                                  '                        ' || org_name
                              ELSE
                                  '                                '|| org_name
                          END AS "treeOrgName",--文本前面加空格模仿树
                          org_name      AS "orgName"--公司/项目
                      FROM
                         TEMP_DT_VALUE A
												 INNER JOIN (SELECT p.ID FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 START WITH p.id = '' || unitid_val || '' CONNECT BY PRIOR p.ID = p.PARENT_ID
						           UNION ALL
											 SELECT M.ID FROM SYS_PROJECT M WHERE EXISTS (SELECT 1 FROM SYS_BUSINESS_UNIT N WHERE N.IS_COMPANY = 1 AND N.ID = M.UNIT_ID START WITH N.id = '' || unitid_val || '' CONNECT BY PRIOR N.ID = N.PARENT_ID)) b ON a.id = b.id
                       --WHERE  a.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END)    
						GROUP BY A.ID,A.ORG_NAME,A.PARENT_ID,A.IS_COMPANY,A.PROJ_COOPERATE，A.TAKE_DATE,ORG_LEVEL,A.ORDER_HIERARCHY_CODE order by ORDER_HIERARCHY_CODE;

    END IF;

    IF tabsindex = 1 OR tabsindex = 2  THEN
        OPEN info FOR 
				WITH TEMP_DT_VALUE (ID,COMPANY_ID, ORG_NAME, OBJ_TYPE, VALUE_DT_ALL, VALUE_REMAIN, VALUE_HAVED_SALE, VALUE_RESERVE, VALUE_IN_PROCESS, VALUE_ALLOW_SALE, VALUE_STOCK,
       VALUE_NOT_PLANNING_PERMIT, VALUE_NOT_CONSTRUCTION_PERMIT, VALUE_NOT_SALE_PERMIT, VALUE_NOT_COMPLETION, VALUE_YES_COMPLETION, VALUE_YES_SETTLEMENT, AREA_DT_ALL, AREA_REMAIN,
       AREA_HAVED_SALE, AREA_RESERVE, AREA_IN_PROCESS, AREA_ALLOW_SALE, AREA_STOCK, AREA_NOT_PLANNING_PERMIT, AREA_NOT_CONSTRUCTION_PERMIT, AREA_NOT_SALE_PERMIT, AREA_NOT_COMPLETION,
       AREA_YES_COMPLETION, AREA_YES_SETTLEMENT, TMP_1KY_VALUE, TMP_1KY_AREA, TMP_1KY_PRICE, TMP_2QP_VALUE, TMP_2QP_AREA, TMP_2QP_PRICE, TMP_3DT_TARGETVALUE, TMP_3DT_TARGETAREA,
       TMP_3DT_TARGETPRICE, CW_VALUE_DT_ALL, CW_VALUE_REMAIN, CW_VALUE_HAVED_SALE, CW_VALUE_RESERVE, CW_VALUE_IN_PROCESS, CW_VALUE_ALLOW_SALE, CW_VALUE_STOCK,
       CW_VALUE_NOT_PLANNING_PERMIT, CW_VALUE_NOT_CONSTRUCTION_PER, CW_VALUE_NOT_SALE_PERMIT, CW_VALUE_NOT_COMPLETION, CW_VALUE_YES_COMPLETION, CW_VALUE_YES_SETTLEMENT, CW_AREA_DT_ALL,
       CW_AREA_REMAIN, CW_AREA_HAVED_SALE, CW_AREA_RESERVE, CW_AREA_IN_PROCESS, CW_AREA_ALLOW_SALE, CW_AREA_STOCK, CW_AREA_NOT_PLANNING_PERMIT, CW_AREA_NOT_CONSTRUCTION_PER,
       CW_AREA_NOT_SALE_PERMIT, CW_AREA_NOT_COMPLETION, CW_AREA_YES_COMPLETION, CW_AREA_YES_SETTLEMENT, ZZ_VALUE_DT_ALL, ZZ_VALUE_REMAIN, ZZ_VALUE_HAVED_SALE, ZZ_VALUE_RESERVE,
       ZZ_VALUE_IN_PROCESS, ZZ_VALUE_ALLOW_SALE, ZZ_VALUE_STOCK, ZZ_VALUE_NOT_PLANNING_PERMIT, ZZ_VALUE_NOT_CONSTRUCTION_PER, ZZ_VALUE_NOT_SALE_PERMIT, ZZ_VALUE_NOT_COMPLETION,
       ZZ_VALUE_YES_COMPLETION, ZZ_VALUE_YES_SETTLEMENT, ZZ_AREA_DT_ALL, ZZ_AREA_REMAIN, ZZ_AREA_HAVED_SALE, ZZ_AREA_RESERVE, ZZ_AREA_IN_PROCESS, ZZ_AREA_ALLOW_SALE, ZZ_AREA_STOCK,
       ZZ_AREA_NOT_PLANNING_PERMIT, ZZ_AREA_NOT_CONSTRUCTION_PER, ZZ_AREA_NOT_SALE_PERMIT, ZZ_AREA_NOT_COMPLETION, ZZ_AREA_YES_COMPLETION, ZZ_AREA_YES_SETTLEMENT, SY_VALUE_DT_ALL,
       SY_VALUE_REMAIN, SY_VALUE_HAVED_SALE, SY_VALUE_RESERVE, SY_VALUE_IN_PROCESS, SY_VALUE_ALLOW_SALE, SY_VALUE_STOCK, SY_VALUE_NOT_PLANNING_PERMIT, SY_VALUE_NOT_CONSTRUCTION_PER,
       SY_VALUE_NOT_SALE_PERMIT, SY_VALUE_NOT_COMPLETION, SY_VALUE_YES_COMPLETION, SY_VALUE_YES_SETTLEMENT, SY_AREA_DT_ALL, SY_AREA_REMAIN, SY_AREA_HAVED_SALE, SY_AREA_RESERVE,
       SY_AREA_IN_PROCESS, SY_AREA_ALLOW_SALE, SY_AREA_STOCK, SY_AREA_NOT_PLANNING_PERMIT, SY_AREA_NOT_CONSTRUCTION_PER, SY_AREA_NOT_SALE_PERMIT, SY_AREA_NOT_COMPLETION,
       SY_AREA_YES_COMPLETION, SY_AREA_YES_SETTLEMENT, PROJ_ID, TARGET_NOW_NAME, TARGET_A_ID, TARGET_A1_ID, TARGET_A2_ID, TARGET_A3_ID, TARGET_A_VALUE, TARGET_A1_VALUE,
       TARGET_A2_VALUE, TARGET_A3_VALUE, TARGET_A_VALUE_DIFF,PARENT_ID,PROJ_COOPERATE,TAKE_DATE,IS_COMPANY,ORG_LEVEL,ORDER_HIERARCHY_CODE) AS 
       (     
SELECT A1.ID,A1.COMPANY_ID, B1.OBJ_NAME, B1.OBJ_TYPE, B1.VALUE_DT_ALL, B1.VALUE_REMAIN, B1.VALUE_HAVED_SALE, B1.VALUE_RESERVE, B1.VALUE_IN_PROCESS, B1.VALUE_ALLOW_SALE, B1.VALUE_STOCK,
       B1.VALUE_NOT_PLANNING_PERMIT, B1.VALUE_NOT_CONSTRUCTION_PERMIT, B1.VALUE_NOT_SALE_PERMIT, B1.VALUE_NOT_COMPLETION, B1.VALUE_YES_COMPLETION, B1.VALUE_YES_SETTLEMENT, B1.AREA_DT_ALL, B1.AREA_REMAIN,
       B1.AREA_HAVED_SALE, B1.AREA_RESERVE, B1.AREA_IN_PROCESS, B1.AREA_ALLOW_SALE, B1.AREA_STOCK, B1.AREA_NOT_PLANNING_PERMIT, B1.AREA_NOT_CONSTRUCTION_PERMIT, B1.AREA_NOT_SALE_PERMIT, B1.AREA_NOT_COMPLETION,
       B1.AREA_YES_COMPLETION, B1.AREA_YES_SETTLEMENT, B1.TMP_1KY_VALUE, B1.TMP_1KY_AREA, B1.TMP_1KY_PRICE, B1.TMP_2QP_VALUE, B1.TMP_2QP_AREA, B1.TMP_2QP_PRICE, B1.TMP_3DT_TARGETVALUE, B1.TMP_3DT_TARGETAREA,
       B1.TMP_3DT_TARGETPRICE, B1.CW_VALUE_DT_ALL, B1.CW_VALUE_REMAIN, B1.CW_VALUE_HAVED_SALE, B1.CW_VALUE_RESERVE, B1.CW_VALUE_IN_PROCESS, B1.CW_VALUE_ALLOW_SALE, B1.CW_VALUE_STOCK,
       B1.CW_VALUE_NOT_PLANNING_PERMIT, B1.CW_VALUE_NOT_CONSTRUCTION_PER, B1.CW_VALUE_NOT_SALE_PERMIT, B1.CW_VALUE_NOT_COMPLETION, B1.CW_VALUE_YES_COMPLETION, B1.CW_VALUE_YES_SETTLEMENT, B1.CW_AREA_DT_ALL,
       B1.CW_AREA_REMAIN, B1.CW_AREA_HAVED_SALE, B1.CW_AREA_RESERVE, B1.CW_AREA_IN_PROCESS, B1.CW_AREA_ALLOW_SALE, B1.CW_AREA_STOCK, B1.CW_AREA_NOT_PLANNING_PERMIT, B1.CW_AREA_NOT_CONSTRUCTION_PER,
       B1.CW_AREA_NOT_SALE_PERMIT, B1.CW_AREA_NOT_COMPLETION, B1.CW_AREA_YES_COMPLETION, B1.CW_AREA_YES_SETTLEMENT, B1.ZZ_VALUE_DT_ALL, B1.ZZ_VALUE_REMAIN, B1.ZZ_VALUE_HAVED_SALE, B1.ZZ_VALUE_RESERVE,
       B1.ZZ_VALUE_IN_PROCESS, B1.ZZ_VALUE_ALLOW_SALE, B1.ZZ_VALUE_STOCK, B1.ZZ_VALUE_NOT_PLANNING_PERMIT, B1.ZZ_VALUE_NOT_CONSTRUCTION_PER, B1.ZZ_VALUE_NOT_SALE_PERMIT, B1.ZZ_VALUE_NOT_COMPLETION,
       B1.ZZ_VALUE_YES_COMPLETION, B1.ZZ_VALUE_YES_SETTLEMENT, B1.ZZ_AREA_DT_ALL, B1.ZZ_AREA_REMAIN, B1.ZZ_AREA_HAVED_SALE, B1.ZZ_AREA_RESERVE, B1.ZZ_AREA_IN_PROCESS, B1.ZZ_AREA_ALLOW_SALE, B1.ZZ_AREA_STOCK,
       B1.ZZ_AREA_NOT_PLANNING_PERMIT, B1.ZZ_AREA_NOT_CONSTRUCTION_PER, B1.ZZ_AREA_NOT_SALE_PERMIT, B1.ZZ_AREA_NOT_COMPLETION, B1.ZZ_AREA_YES_COMPLETION, B1.ZZ_AREA_YES_SETTLEMENT, B1.SY_VALUE_DT_ALL,
       B1.SY_VALUE_REMAIN, B1.SY_VALUE_HAVED_SALE, B1.SY_VALUE_RESERVE, B1.SY_VALUE_IN_PROCESS, B1.SY_VALUE_ALLOW_SALE, B1.SY_VALUE_STOCK, B1.SY_VALUE_NOT_PLANNING_PERMIT, B1.SY_VALUE_NOT_CONSTRUCTION_PER,
       B1.SY_VALUE_NOT_SALE_PERMIT, B1.SY_VALUE_NOT_COMPLETION, B1.SY_VALUE_YES_COMPLETION, B1.SY_VALUE_YES_SETTLEMENT, B1.SY_AREA_DT_ALL, B1.SY_AREA_REMAIN, B1.SY_AREA_HAVED_SALE, B1.SY_AREA_RESERVE,
       B1.SY_AREA_IN_PROCESS, B1.SY_AREA_ALLOW_SALE, B1.SY_AREA_STOCK, B1.SY_AREA_NOT_PLANNING_PERMIT, B1.SY_AREA_NOT_CONSTRUCTION_PER, B1.SY_AREA_NOT_SALE_PERMIT, B1.SY_AREA_NOT_COMPLETION,
       B1.SY_AREA_YES_COMPLETION, B1.SY_AREA_YES_SETTLEMENT, B1.PROJ_ID, B1.TARGET_NOW_NAME, B1.TARGET_A_ID, B1.TARGET_A1_ID, B1.TARGET_A2_ID, B1.TARGET_A3_ID, B1.TARGET_A_VALUE, B1.TARGET_A1_VALUE,
       B1.TARGET_A2_VALUE, B1.TARGET_A3_VALUE, B1.TARGET_A_VALUE_DIFF,A1.COMPANY_ID AS PARENT_ID,NVL(A1.PROJ_COOPERATE,'操盘'),TO_CHAR(A1.PROJECT_GET_TIME,'YYYY-MM-DD') AS TAKE_DATE,0,4,a1.ORDER_HIERARCHY_CODE
FROM   MDM_PROJECT A1
INNER  JOIN DWM_DT_VALUE B1
ON     A1.ID = B1.OBJ_ID AND B1.OBJ_TYPE = '项目'
WHERE  a1.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a1.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END) 
UNION ALL
SELECT B2.ID,A2.PARENT_ID, B2.ORG_NAME, '公司', A2.VALUE_DT_ALL, A2.VALUE_REMAIN, A2.VALUE_HAVED_SALE, A2.VALUE_RESERVE, A2.VALUE_IN_PROCESS, A2.VALUE_ALLOW_SALE, A2.VALUE_STOCK,
       A2.VALUE_NOT_PLANNING_PERMIT, A2.VALUE_NOT_CONSTRUCTION_PERMIT, A2.VALUE_NOT_SALE_PERMIT, A2.VALUE_NOT_COMPLETION, A2.VALUE_YES_COMPLETION, A2.VALUE_YES_SETTLEMENT, A2.AREA_DT_ALL, A2.AREA_REMAIN,
       A2.AREA_HAVED_SALE, A2.AREA_RESERVE, A2.AREA_IN_PROCESS, A2.AREA_ALLOW_SALE, A2.AREA_STOCK, A2.AREA_NOT_PLANNING_PERMIT, A2.AREA_NOT_CONSTRUCTION_PERMIT, A2.AREA_NOT_SALE_PERMIT, A2.AREA_NOT_COMPLETION,
       A2.AREA_YES_COMPLETION, A2.AREA_YES_SETTLEMENT, A2.TMP_1KY_VALUE, A2.TMP_1KY_AREA, A2.TMP_1KY_PRICE, A2.TMP_2QP_VALUE, A2.TMP_2QP_AREA, A2.TMP_2QP_PRICE, A2.TMP_3DT_TARGETVALUE, A2.TMP_3DT_TARGETAREA,
       A2.TMP_3DT_TARGETPRICE, A2.CW_VALUE_DT_ALL, A2.CW_VALUE_REMAIN, A2.CW_VALUE_HAVED_SALE, A2.CW_VALUE_RESERVE, A2.CW_VALUE_IN_PROCESS, A2.CW_VALUE_ALLOW_SALE, A2.CW_VALUE_STOCK,
       A2.CW_VALUE_NOT_PLANNING_PERMIT, A2.CW_VALUE_NOT_CONSTRUCTION_PER, A2.CW_VALUE_NOT_SALE_PERMIT, A2.CW_VALUE_NOT_COMPLETION, A2.CW_VALUE_YES_COMPLETION, A2.CW_VALUE_YES_SETTLEMENT, A2.CW_AREA_DT_ALL,
       A2.CW_AREA_REMAIN, A2.CW_AREA_HAVED_SALE, A2.CW_AREA_RESERVE, A2.CW_AREA_IN_PROCESS, A2.CW_AREA_ALLOW_SALE, A2.CW_AREA_STOCK, A2.CW_AREA_NOT_PLANNING_PERMIT, A2.CW_AREA_NOT_CONSTRUCTION_PER,
       A2.CW_AREA_NOT_SALE_PERMIT, A2.CW_AREA_NOT_COMPLETION, A2.CW_AREA_YES_COMPLETION, A2.CW_AREA_YES_SETTLEMENT, A2.ZZ_VALUE_DT_ALL, A2.ZZ_VALUE_REMAIN, A2.ZZ_VALUE_HAVED_SALE, A2.ZZ_VALUE_RESERVE,
       A2.ZZ_VALUE_IN_PROCESS, A2.ZZ_VALUE_ALLOW_SALE, A2.ZZ_VALUE_STOCK, A2.ZZ_VALUE_NOT_PLANNING_PERMIT, A2.ZZ_VALUE_NOT_CONSTRUCTION_PER, A2.ZZ_VALUE_NOT_SALE_PERMIT, A2.ZZ_VALUE_NOT_COMPLETION,
       A2.ZZ_VALUE_YES_COMPLETION, A2.ZZ_VALUE_YES_SETTLEMENT, A2.ZZ_AREA_DT_ALL, A2.ZZ_AREA_REMAIN, A2.ZZ_AREA_HAVED_SALE, A2.ZZ_AREA_RESERVE, A2.ZZ_AREA_IN_PROCESS, A2.ZZ_AREA_ALLOW_SALE, A2.ZZ_AREA_STOCK,
       A2.ZZ_AREA_NOT_PLANNING_PERMIT, A2.ZZ_AREA_NOT_CONSTRUCTION_PER, A2.ZZ_AREA_NOT_SALE_PERMIT, A2.ZZ_AREA_NOT_COMPLETION, A2.ZZ_AREA_YES_COMPLETION, A2.ZZ_AREA_YES_SETTLEMENT, A2.SY_VALUE_DT_ALL,
       A2.SY_VALUE_REMAIN, A2.SY_VALUE_HAVED_SALE, A2.SY_VALUE_RESERVE, A2.SY_VALUE_IN_PROCESS, A2.SY_VALUE_ALLOW_SALE, A2.SY_VALUE_STOCK, A2.SY_VALUE_NOT_PLANNING_PERMIT, A2.SY_VALUE_NOT_CONSTRUCTION_PER,
       A2.SY_VALUE_NOT_SALE_PERMIT, A2.SY_VALUE_NOT_COMPLETION, A2.SY_VALUE_YES_COMPLETION, A2.SY_VALUE_YES_SETTLEMENT, A2.SY_AREA_DT_ALL, A2.SY_AREA_REMAIN, A2.SY_AREA_HAVED_SALE, A2.SY_AREA_RESERVE,
       A2.SY_AREA_IN_PROCESS, A2.SY_AREA_ALLOW_SALE, A2.SY_AREA_STOCK, A2.SY_AREA_NOT_PLANNING_PERMIT, A2.SY_AREA_NOT_CONSTRUCTION_PER, A2.SY_AREA_NOT_SALE_PERMIT, A2.SY_AREA_NOT_COMPLETION,
       A2.SY_AREA_YES_COMPLETION, A2.SY_AREA_YES_SETTLEMENT, A2.PROJ_ID, A2.TARGET_NOW_NAME, A2.TARGET_A_ID, A2.TARGET_A1_ID, A2.TARGET_A2_ID, A2.TARGET_A3_ID, A2.TARGET_A_VALUE, A2.TARGET_A1_VALUE,
       A2.TARGET_A2_VALUE, A2.TARGET_A3_VALUE, A2.TARGET_A_VALUE_DIFF,B2.PARENT_ID,'','',1,B2.LEVEL_RANK,b2.ORDER_HIERARCHY_CODE
FROM TEMP_DT_VALUE A2
INNER JOIN SYS_BUSINESS_UNIT B2 ON A2.PARENT_ID = B2.ID AND B2.IS_COMPANY = 1
)
				SELECT
                          a.id          AS "orgId",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id   AS "parentId",--父级id（生成树父级id）
                          ORG_LEVEL AS "orgLevel",
                          0 AS "itemsNum",
                          0 AS "submitNum",
                          CASE
                              WHEN ORG_LEVEL = 1 THEN
                                  '' || org_name
                              WHEN ORG_LEVEL = 2 THEN
                                  '        ' || org_name
                              WHEN ORG_LEVEL = 3 THEN
                                  '                ' || org_name
                              WHEN ORG_LEVEL = 4 THEN
                                  '                        ' || org_name
                              ELSE
                                  '                                '|| org_name
                          END AS "treeOrgName",--文本前面加空格模仿树
                          org_name      AS "orgName"--项目/分期/业态/楼栋
                      FROM
                          TEMP_DT_VALUE A
												 INNER JOIN (SELECT p.ID FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 START WITH p.id = '' || unitid_val || '' CONNECT BY PRIOR p.ID = p.PARENT_ID
						           UNION ALL
											 SELECT M.ID FROM SYS_PROJECT M WHERE EXISTS (SELECT 1 FROM SYS_BUSINESS_UNIT N WHERE N.IS_COMPANY = 1 AND N.ID = M.UNIT_ID START WITH N.id = '' || unitid_val || '' CONNECT BY PRIOR N.ID = N.PARENT_ID)) b ON a.id = b.id
                      -- WHERE  a.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END)    
						GROUP BY A.ID,A.ORG_NAME,A.PARENT_ID,A.IS_COMPANY,A.PROJ_COOPERATE，A.TAKE_DATE,ORG_LEVEL,A.ORDER_HIERARCHY_CODE order by ORDER_HIERARCHY_CODE; 


    ELSIF tabsindex = 3  THEN
        OPEN info FOR 
				WITH TEMP_DT_VALUE (ID,COMPANY_ID, ORG_NAME, OBJ_TYPE, VALUE_DT_ALL, VALUE_REMAIN, VALUE_HAVED_SALE, VALUE_RESERVE, VALUE_IN_PROCESS, VALUE_ALLOW_SALE, VALUE_STOCK,
       VALUE_NOT_PLANNING_PERMIT, VALUE_NOT_CONSTRUCTION_PERMIT, VALUE_NOT_SALE_PERMIT, VALUE_NOT_COMPLETION, VALUE_YES_COMPLETION, VALUE_YES_SETTLEMENT, AREA_DT_ALL, AREA_REMAIN,
       AREA_HAVED_SALE, AREA_RESERVE, AREA_IN_PROCESS, AREA_ALLOW_SALE, AREA_STOCK, AREA_NOT_PLANNING_PERMIT, AREA_NOT_CONSTRUCTION_PERMIT, AREA_NOT_SALE_PERMIT, AREA_NOT_COMPLETION,
       AREA_YES_COMPLETION, AREA_YES_SETTLEMENT, TMP_1KY_VALUE, TMP_1KY_AREA, TMP_1KY_PRICE, TMP_2QP_VALUE, TMP_2QP_AREA, TMP_2QP_PRICE, TMP_3DT_TARGETVALUE, TMP_3DT_TARGETAREA,
       TMP_3DT_TARGETPRICE, CW_VALUE_DT_ALL, CW_VALUE_REMAIN, CW_VALUE_HAVED_SALE, CW_VALUE_RESERVE, CW_VALUE_IN_PROCESS, CW_VALUE_ALLOW_SALE, CW_VALUE_STOCK,
       CW_VALUE_NOT_PLANNING_PERMIT, CW_VALUE_NOT_CONSTRUCTION_PER, CW_VALUE_NOT_SALE_PERMIT, CW_VALUE_NOT_COMPLETION, CW_VALUE_YES_COMPLETION, CW_VALUE_YES_SETTLEMENT, CW_AREA_DT_ALL,
       CW_AREA_REMAIN, CW_AREA_HAVED_SALE, CW_AREA_RESERVE, CW_AREA_IN_PROCESS, CW_AREA_ALLOW_SALE, CW_AREA_STOCK, CW_AREA_NOT_PLANNING_PERMIT, CW_AREA_NOT_CONSTRUCTION_PER,
       CW_AREA_NOT_SALE_PERMIT, CW_AREA_NOT_COMPLETION, CW_AREA_YES_COMPLETION, CW_AREA_YES_SETTLEMENT, ZZ_VALUE_DT_ALL, ZZ_VALUE_REMAIN, ZZ_VALUE_HAVED_SALE, ZZ_VALUE_RESERVE,
       ZZ_VALUE_IN_PROCESS, ZZ_VALUE_ALLOW_SALE, ZZ_VALUE_STOCK, ZZ_VALUE_NOT_PLANNING_PERMIT, ZZ_VALUE_NOT_CONSTRUCTION_PER, ZZ_VALUE_NOT_SALE_PERMIT, ZZ_VALUE_NOT_COMPLETION,
       ZZ_VALUE_YES_COMPLETION, ZZ_VALUE_YES_SETTLEMENT, ZZ_AREA_DT_ALL, ZZ_AREA_REMAIN, ZZ_AREA_HAVED_SALE, ZZ_AREA_RESERVE, ZZ_AREA_IN_PROCESS, ZZ_AREA_ALLOW_SALE, ZZ_AREA_STOCK,
       ZZ_AREA_NOT_PLANNING_PERMIT, ZZ_AREA_NOT_CONSTRUCTION_PER, ZZ_AREA_NOT_SALE_PERMIT, ZZ_AREA_NOT_COMPLETION, ZZ_AREA_YES_COMPLETION, ZZ_AREA_YES_SETTLEMENT, SY_VALUE_DT_ALL,
       SY_VALUE_REMAIN, SY_VALUE_HAVED_SALE, SY_VALUE_RESERVE, SY_VALUE_IN_PROCESS, SY_VALUE_ALLOW_SALE, SY_VALUE_STOCK, SY_VALUE_NOT_PLANNING_PERMIT, SY_VALUE_NOT_CONSTRUCTION_PER,
       SY_VALUE_NOT_SALE_PERMIT, SY_VALUE_NOT_COMPLETION, SY_VALUE_YES_COMPLETION, SY_VALUE_YES_SETTLEMENT, SY_AREA_DT_ALL, SY_AREA_REMAIN, SY_AREA_HAVED_SALE, SY_AREA_RESERVE,
       SY_AREA_IN_PROCESS, SY_AREA_ALLOW_SALE, SY_AREA_STOCK, SY_AREA_NOT_PLANNING_PERMIT, SY_AREA_NOT_CONSTRUCTION_PER, SY_AREA_NOT_SALE_PERMIT, SY_AREA_NOT_COMPLETION,
       SY_AREA_YES_COMPLETION, SY_AREA_YES_SETTLEMENT, PROJ_ID, TARGET_NOW_NAME, TARGET_A_ID, TARGET_A1_ID, TARGET_A2_ID, TARGET_A3_ID, TARGET_A_VALUE, TARGET_A1_VALUE,
       TARGET_A2_VALUE, TARGET_A3_VALUE, TARGET_A_VALUE_DIFF,PARENT_ID,PROJ_COOPERATE,TAKE_DATE,IS_COMPANY,ORG_LEVEL,ORDER_HIERARCHY_CODE) AS 
       (     
SELECT A1.ID,A1.COMPANY_ID, B1.OBJ_NAME, B1.OBJ_TYPE, B1.VALUE_DT_ALL, B1.VALUE_REMAIN, B1.VALUE_HAVED_SALE, B1.VALUE_RESERVE, B1.VALUE_IN_PROCESS, B1.VALUE_ALLOW_SALE, B1.VALUE_STOCK,
       B1.VALUE_NOT_PLANNING_PERMIT, B1.VALUE_NOT_CONSTRUCTION_PERMIT, B1.VALUE_NOT_SALE_PERMIT, B1.VALUE_NOT_COMPLETION, B1.VALUE_YES_COMPLETION, B1.VALUE_YES_SETTLEMENT, B1.AREA_DT_ALL, B1.AREA_REMAIN,
       B1.AREA_HAVED_SALE, B1.AREA_RESERVE, B1.AREA_IN_PROCESS, B1.AREA_ALLOW_SALE, B1.AREA_STOCK, B1.AREA_NOT_PLANNING_PERMIT, B1.AREA_NOT_CONSTRUCTION_PERMIT, B1.AREA_NOT_SALE_PERMIT, B1.AREA_NOT_COMPLETION,
       B1.AREA_YES_COMPLETION, B1.AREA_YES_SETTLEMENT, B1.TMP_1KY_VALUE, B1.TMP_1KY_AREA, B1.TMP_1KY_PRICE, B1.TMP_2QP_VALUE, B1.TMP_2QP_AREA, B1.TMP_2QP_PRICE, B1.TMP_3DT_TARGETVALUE, B1.TMP_3DT_TARGETAREA,
       B1.TMP_3DT_TARGETPRICE, B1.CW_VALUE_DT_ALL, B1.CW_VALUE_REMAIN, B1.CW_VALUE_HAVED_SALE, B1.CW_VALUE_RESERVE, B1.CW_VALUE_IN_PROCESS, B1.CW_VALUE_ALLOW_SALE, B1.CW_VALUE_STOCK,
       B1.CW_VALUE_NOT_PLANNING_PERMIT, B1.CW_VALUE_NOT_CONSTRUCTION_PER, B1.CW_VALUE_NOT_SALE_PERMIT, B1.CW_VALUE_NOT_COMPLETION, B1.CW_VALUE_YES_COMPLETION, B1.CW_VALUE_YES_SETTLEMENT, B1.CW_AREA_DT_ALL,
       B1.CW_AREA_REMAIN, B1.CW_AREA_HAVED_SALE, B1.CW_AREA_RESERVE, B1.CW_AREA_IN_PROCESS, B1.CW_AREA_ALLOW_SALE, B1.CW_AREA_STOCK, B1.CW_AREA_NOT_PLANNING_PERMIT, B1.CW_AREA_NOT_CONSTRUCTION_PER,
       B1.CW_AREA_NOT_SALE_PERMIT, B1.CW_AREA_NOT_COMPLETION, B1.CW_AREA_YES_COMPLETION, B1.CW_AREA_YES_SETTLEMENT, B1.ZZ_VALUE_DT_ALL, B1.ZZ_VALUE_REMAIN, B1.ZZ_VALUE_HAVED_SALE, B1.ZZ_VALUE_RESERVE,
       B1.ZZ_VALUE_IN_PROCESS, B1.ZZ_VALUE_ALLOW_SALE, B1.ZZ_VALUE_STOCK, B1.ZZ_VALUE_NOT_PLANNING_PERMIT, B1.ZZ_VALUE_NOT_CONSTRUCTION_PER, B1.ZZ_VALUE_NOT_SALE_PERMIT, B1.ZZ_VALUE_NOT_COMPLETION,
       B1.ZZ_VALUE_YES_COMPLETION, B1.ZZ_VALUE_YES_SETTLEMENT, B1.ZZ_AREA_DT_ALL, B1.ZZ_AREA_REMAIN, B1.ZZ_AREA_HAVED_SALE, B1.ZZ_AREA_RESERVE, B1.ZZ_AREA_IN_PROCESS, B1.ZZ_AREA_ALLOW_SALE, B1.ZZ_AREA_STOCK,
       B1.ZZ_AREA_NOT_PLANNING_PERMIT, B1.ZZ_AREA_NOT_CONSTRUCTION_PER, B1.ZZ_AREA_NOT_SALE_PERMIT, B1.ZZ_AREA_NOT_COMPLETION, B1.ZZ_AREA_YES_COMPLETION, B1.ZZ_AREA_YES_SETTLEMENT, B1.SY_VALUE_DT_ALL,
       B1.SY_VALUE_REMAIN, B1.SY_VALUE_HAVED_SALE, B1.SY_VALUE_RESERVE, B1.SY_VALUE_IN_PROCESS, B1.SY_VALUE_ALLOW_SALE, B1.SY_VALUE_STOCK, B1.SY_VALUE_NOT_PLANNING_PERMIT, B1.SY_VALUE_NOT_CONSTRUCTION_PER,
       B1.SY_VALUE_NOT_SALE_PERMIT, B1.SY_VALUE_NOT_COMPLETION, B1.SY_VALUE_YES_COMPLETION, B1.SY_VALUE_YES_SETTLEMENT, B1.SY_AREA_DT_ALL, B1.SY_AREA_REMAIN, B1.SY_AREA_HAVED_SALE, B1.SY_AREA_RESERVE,
       B1.SY_AREA_IN_PROCESS, B1.SY_AREA_ALLOW_SALE, B1.SY_AREA_STOCK, B1.SY_AREA_NOT_PLANNING_PERMIT, B1.SY_AREA_NOT_CONSTRUCTION_PER, B1.SY_AREA_NOT_SALE_PERMIT, B1.SY_AREA_NOT_COMPLETION,
       B1.SY_AREA_YES_COMPLETION, B1.SY_AREA_YES_SETTLEMENT, B1.PROJ_ID, B1.TARGET_NOW_NAME, B1.TARGET_A_ID, B1.TARGET_A1_ID, B1.TARGET_A2_ID, B1.TARGET_A3_ID, B1.TARGET_A_VALUE, B1.TARGET_A1_VALUE,
       B1.TARGET_A2_VALUE, B1.TARGET_A3_VALUE, B1.TARGET_A_VALUE_DIFF,A1.COMPANY_ID AS PARENT_ID,NVL(A1.PROJ_COOPERATE,'操盘'),TO_CHAR(A1.PROJECT_GET_TIME,'YYYY-MM-DD') AS TAKE_DATE,0,4,a1.ORDER_HIERARCHY_CODE
FROM   MDM_PROJECT A1
INNER  JOIN DWM_DT_VALUE B1
ON     A1.ID = B1.OBJ_ID AND B1.OBJ_TYPE = '项目'
WHERE  a1.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a1.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END) 
UNION ALL
SELECT B2.ID,A2.PARENT_ID, B2.ORG_NAME, '公司', A2.VALUE_DT_ALL, A2.VALUE_REMAIN, A2.VALUE_HAVED_SALE, A2.VALUE_RESERVE, A2.VALUE_IN_PROCESS, A2.VALUE_ALLOW_SALE, A2.VALUE_STOCK,
       A2.VALUE_NOT_PLANNING_PERMIT, A2.VALUE_NOT_CONSTRUCTION_PERMIT, A2.VALUE_NOT_SALE_PERMIT, A2.VALUE_NOT_COMPLETION, A2.VALUE_YES_COMPLETION, A2.VALUE_YES_SETTLEMENT, A2.AREA_DT_ALL, A2.AREA_REMAIN,
       A2.AREA_HAVED_SALE, A2.AREA_RESERVE, A2.AREA_IN_PROCESS, A2.AREA_ALLOW_SALE, A2.AREA_STOCK, A2.AREA_NOT_PLANNING_PERMIT, A2.AREA_NOT_CONSTRUCTION_PERMIT, A2.AREA_NOT_SALE_PERMIT, A2.AREA_NOT_COMPLETION,
       A2.AREA_YES_COMPLETION, A2.AREA_YES_SETTLEMENT, A2.TMP_1KY_VALUE, A2.TMP_1KY_AREA, A2.TMP_1KY_PRICE, A2.TMP_2QP_VALUE, A2.TMP_2QP_AREA, A2.TMP_2QP_PRICE, A2.TMP_3DT_TARGETVALUE, A2.TMP_3DT_TARGETAREA,
       A2.TMP_3DT_TARGETPRICE, A2.CW_VALUE_DT_ALL, A2.CW_VALUE_REMAIN, A2.CW_VALUE_HAVED_SALE, A2.CW_VALUE_RESERVE, A2.CW_VALUE_IN_PROCESS, A2.CW_VALUE_ALLOW_SALE, A2.CW_VALUE_STOCK,
       A2.CW_VALUE_NOT_PLANNING_PERMIT, A2.CW_VALUE_NOT_CONSTRUCTION_PER, A2.CW_VALUE_NOT_SALE_PERMIT, A2.CW_VALUE_NOT_COMPLETION, A2.CW_VALUE_YES_COMPLETION, A2.CW_VALUE_YES_SETTLEMENT, A2.CW_AREA_DT_ALL,
       A2.CW_AREA_REMAIN, A2.CW_AREA_HAVED_SALE, A2.CW_AREA_RESERVE, A2.CW_AREA_IN_PROCESS, A2.CW_AREA_ALLOW_SALE, A2.CW_AREA_STOCK, A2.CW_AREA_NOT_PLANNING_PERMIT, A2.CW_AREA_NOT_CONSTRUCTION_PER,
       A2.CW_AREA_NOT_SALE_PERMIT, A2.CW_AREA_NOT_COMPLETION, A2.CW_AREA_YES_COMPLETION, A2.CW_AREA_YES_SETTLEMENT, A2.ZZ_VALUE_DT_ALL, A2.ZZ_VALUE_REMAIN, A2.ZZ_VALUE_HAVED_SALE, A2.ZZ_VALUE_RESERVE,
       A2.ZZ_VALUE_IN_PROCESS, A2.ZZ_VALUE_ALLOW_SALE, A2.ZZ_VALUE_STOCK, A2.ZZ_VALUE_NOT_PLANNING_PERMIT, A2.ZZ_VALUE_NOT_CONSTRUCTION_PER, A2.ZZ_VALUE_NOT_SALE_PERMIT, A2.ZZ_VALUE_NOT_COMPLETION,
       A2.ZZ_VALUE_YES_COMPLETION, A2.ZZ_VALUE_YES_SETTLEMENT, A2.ZZ_AREA_DT_ALL, A2.ZZ_AREA_REMAIN, A2.ZZ_AREA_HAVED_SALE, A2.ZZ_AREA_RESERVE, A2.ZZ_AREA_IN_PROCESS, A2.ZZ_AREA_ALLOW_SALE, A2.ZZ_AREA_STOCK,
       A2.ZZ_AREA_NOT_PLANNING_PERMIT, A2.ZZ_AREA_NOT_CONSTRUCTION_PER, A2.ZZ_AREA_NOT_SALE_PERMIT, A2.ZZ_AREA_NOT_COMPLETION, A2.ZZ_AREA_YES_COMPLETION, A2.ZZ_AREA_YES_SETTLEMENT, A2.SY_VALUE_DT_ALL,
       A2.SY_VALUE_REMAIN, A2.SY_VALUE_HAVED_SALE, A2.SY_VALUE_RESERVE, A2.SY_VALUE_IN_PROCESS, A2.SY_VALUE_ALLOW_SALE, A2.SY_VALUE_STOCK, A2.SY_VALUE_NOT_PLANNING_PERMIT, A2.SY_VALUE_NOT_CONSTRUCTION_PER,
       A2.SY_VALUE_NOT_SALE_PERMIT, A2.SY_VALUE_NOT_COMPLETION, A2.SY_VALUE_YES_COMPLETION, A2.SY_VALUE_YES_SETTLEMENT, A2.SY_AREA_DT_ALL, A2.SY_AREA_REMAIN, A2.SY_AREA_HAVED_SALE, A2.SY_AREA_RESERVE,
       A2.SY_AREA_IN_PROCESS, A2.SY_AREA_ALLOW_SALE, A2.SY_AREA_STOCK, A2.SY_AREA_NOT_PLANNING_PERMIT, A2.SY_AREA_NOT_CONSTRUCTION_PER, A2.SY_AREA_NOT_SALE_PERMIT, A2.SY_AREA_NOT_COMPLETION,
       A2.SY_AREA_YES_COMPLETION, A2.SY_AREA_YES_SETTLEMENT, A2.PROJ_ID, A2.TARGET_NOW_NAME, A2.TARGET_A_ID, A2.TARGET_A1_ID, A2.TARGET_A2_ID, A2.TARGET_A3_ID, A2.TARGET_A_VALUE, A2.TARGET_A1_VALUE,
       A2.TARGET_A2_VALUE, A2.TARGET_A3_VALUE, A2.TARGET_A_VALUE_DIFF,B2.PARENT_ID,'','',1,B2.LEVEL_RANK,b2.ORDER_HIERARCHY_CODE
FROM TEMP_DT_VALUE A2
INNER JOIN SYS_BUSINESS_UNIT B2 ON A2.PARENT_ID = B2.ID AND B2.IS_COMPANY = 1
)
				SELECT
                          a.id          AS "orgId",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id   AS "parentId",--父级id（生成树父级id）
                          ORG_LEVEL AS "orgLevel",
                          0 AS "itemsNum",
                          0 AS "submitNum",
                          CASE
                              WHEN ORG_LEVEL = 1 THEN
                                  '' || org_name
                              WHEN ORG_LEVEL = 2 THEN
                                  '        ' || org_name
                              WHEN ORG_LEVEL = 3 THEN
                                  '                ' || org_name
                              WHEN ORG_LEVEL = 4 THEN
                                  '                        ' || org_name
                              ELSE
                                  '                                '|| org_name
                          END AS "treeOrgName",--文本前面加空格模仿树
                          org_name      AS "orgName"--项目/分期/业态/楼栋
                      FROM   TEMP_DT_VALUE A
            INNER JOIN (SELECT p.ID FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 START WITH p.id = '' || unitid_val || '' CONNECT BY PRIOR p.ID = p.PARENT_ID
						           UNION ALL
											 SELECT M.ID FROM SYS_PROJECT M WHERE EXISTS (SELECT 1 FROM SYS_BUSINESS_UNIT N WHERE N.IS_COMPANY = 1 AND N.ID = M.UNIT_ID START WITH N.id = '' || unitid_val || '' CONNECT BY PRIOR N.ID = N.PARENT_ID)) b ON a.id = b.id
                       --WHERE  a.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END)    
						GROUP BY A.ID,A.ORG_NAME,A.PARENT_ID,A.IS_COMPANY,A.PROJ_COOPERATE，A.TAKE_DATE,ORG_LEVEL,A.ORDER_HIERARCHY_CODE order by ORDER_HIERARCHY_CODE;

ELSIF tabsindex = 4  THEN
        OPEN info FOR 
				WITH TEMP_DT_VALUE (ID,COMPANY_ID, ORG_NAME, OBJ_TYPE, VALUE_DT_ALL, VALUE_REMAIN, VALUE_HAVED_SALE, VALUE_RESERVE, VALUE_IN_PROCESS, VALUE_ALLOW_SALE, VALUE_STOCK,
       VALUE_NOT_PLANNING_PERMIT, VALUE_NOT_CONSTRUCTION_PERMIT, VALUE_NOT_SALE_PERMIT, VALUE_NOT_COMPLETION, VALUE_YES_COMPLETION, VALUE_YES_SETTLEMENT, AREA_DT_ALL, AREA_REMAIN,
       AREA_HAVED_SALE, AREA_RESERVE, AREA_IN_PROCESS, AREA_ALLOW_SALE, AREA_STOCK, AREA_NOT_PLANNING_PERMIT, AREA_NOT_CONSTRUCTION_PERMIT, AREA_NOT_SALE_PERMIT, AREA_NOT_COMPLETION,
       AREA_YES_COMPLETION, AREA_YES_SETTLEMENT, TMP_1KY_VALUE, TMP_1KY_AREA, TMP_1KY_PRICE, TMP_2QP_VALUE, TMP_2QP_AREA, TMP_2QP_PRICE, TMP_3DT_TARGETVALUE, TMP_3DT_TARGETAREA,
       TMP_3DT_TARGETPRICE, CW_VALUE_DT_ALL, CW_VALUE_REMAIN, CW_VALUE_HAVED_SALE, CW_VALUE_RESERVE, CW_VALUE_IN_PROCESS, CW_VALUE_ALLOW_SALE, CW_VALUE_STOCK,
       CW_VALUE_NOT_PLANNING_PERMIT, CW_VALUE_NOT_CONSTRUCTION_PER, CW_VALUE_NOT_SALE_PERMIT, CW_VALUE_NOT_COMPLETION, CW_VALUE_YES_COMPLETION, CW_VALUE_YES_SETTLEMENT, CW_AREA_DT_ALL,
       CW_AREA_REMAIN, CW_AREA_HAVED_SALE, CW_AREA_RESERVE, CW_AREA_IN_PROCESS, CW_AREA_ALLOW_SALE, CW_AREA_STOCK, CW_AREA_NOT_PLANNING_PERMIT, CW_AREA_NOT_CONSTRUCTION_PER,
       CW_AREA_NOT_SALE_PERMIT, CW_AREA_NOT_COMPLETION, CW_AREA_YES_COMPLETION, CW_AREA_YES_SETTLEMENT, ZZ_VALUE_DT_ALL, ZZ_VALUE_REMAIN, ZZ_VALUE_HAVED_SALE, ZZ_VALUE_RESERVE,
       ZZ_VALUE_IN_PROCESS, ZZ_VALUE_ALLOW_SALE, ZZ_VALUE_STOCK, ZZ_VALUE_NOT_PLANNING_PERMIT, ZZ_VALUE_NOT_CONSTRUCTION_PER, ZZ_VALUE_NOT_SALE_PERMIT, ZZ_VALUE_NOT_COMPLETION,
       ZZ_VALUE_YES_COMPLETION, ZZ_VALUE_YES_SETTLEMENT, ZZ_AREA_DT_ALL, ZZ_AREA_REMAIN, ZZ_AREA_HAVED_SALE, ZZ_AREA_RESERVE, ZZ_AREA_IN_PROCESS, ZZ_AREA_ALLOW_SALE, ZZ_AREA_STOCK,
       ZZ_AREA_NOT_PLANNING_PERMIT, ZZ_AREA_NOT_CONSTRUCTION_PER, ZZ_AREA_NOT_SALE_PERMIT, ZZ_AREA_NOT_COMPLETION, ZZ_AREA_YES_COMPLETION, ZZ_AREA_YES_SETTLEMENT, SY_VALUE_DT_ALL,
       SY_VALUE_REMAIN, SY_VALUE_HAVED_SALE, SY_VALUE_RESERVE, SY_VALUE_IN_PROCESS, SY_VALUE_ALLOW_SALE, SY_VALUE_STOCK, SY_VALUE_NOT_PLANNING_PERMIT, SY_VALUE_NOT_CONSTRUCTION_PER,
       SY_VALUE_NOT_SALE_PERMIT, SY_VALUE_NOT_COMPLETION, SY_VALUE_YES_COMPLETION, SY_VALUE_YES_SETTLEMENT, SY_AREA_DT_ALL, SY_AREA_REMAIN, SY_AREA_HAVED_SALE, SY_AREA_RESERVE,
       SY_AREA_IN_PROCESS, SY_AREA_ALLOW_SALE, SY_AREA_STOCK, SY_AREA_NOT_PLANNING_PERMIT, SY_AREA_NOT_CONSTRUCTION_PER, SY_AREA_NOT_SALE_PERMIT, SY_AREA_NOT_COMPLETION,
       SY_AREA_YES_COMPLETION, SY_AREA_YES_SETTLEMENT, PROJ_ID, TARGET_NOW_NAME, TARGET_A_ID, TARGET_A1_ID, TARGET_A2_ID, TARGET_A3_ID, TARGET_A_VALUE, TARGET_A1_VALUE,
       TARGET_A2_VALUE, TARGET_A3_VALUE, TARGET_A_VALUE_DIFF,PARENT_ID,PROJ_COOPERATE,TAKE_DATE,IS_COMPANY,ORG_LEVEL,ORDER_HIERARCHY_CODE) AS 
       (     
SELECT A1.ID,A1.COMPANY_ID, B1.OBJ_NAME, B1.OBJ_TYPE, B1.VALUE_DT_ALL, B1.VALUE_REMAIN, B1.VALUE_HAVED_SALE, B1.VALUE_RESERVE, B1.VALUE_IN_PROCESS, B1.VALUE_ALLOW_SALE, B1.VALUE_STOCK,
       B1.VALUE_NOT_PLANNING_PERMIT, B1.VALUE_NOT_CONSTRUCTION_PERMIT, B1.VALUE_NOT_SALE_PERMIT, B1.VALUE_NOT_COMPLETION, B1.VALUE_YES_COMPLETION, B1.VALUE_YES_SETTLEMENT, B1.AREA_DT_ALL, B1.AREA_REMAIN,
       B1.AREA_HAVED_SALE, B1.AREA_RESERVE, B1.AREA_IN_PROCESS, B1.AREA_ALLOW_SALE, B1.AREA_STOCK, B1.AREA_NOT_PLANNING_PERMIT, B1.AREA_NOT_CONSTRUCTION_PERMIT, B1.AREA_NOT_SALE_PERMIT, B1.AREA_NOT_COMPLETION,
       B1.AREA_YES_COMPLETION, B1.AREA_YES_SETTLEMENT, B1.TMP_1KY_VALUE, B1.TMP_1KY_AREA, B1.TMP_1KY_PRICE, B1.TMP_2QP_VALUE, B1.TMP_2QP_AREA, B1.TMP_2QP_PRICE, B1.TMP_3DT_TARGETVALUE, B1.TMP_3DT_TARGETAREA,
       B1.TMP_3DT_TARGETPRICE, B1.CW_VALUE_DT_ALL, B1.CW_VALUE_REMAIN, B1.CW_VALUE_HAVED_SALE, B1.CW_VALUE_RESERVE, B1.CW_VALUE_IN_PROCESS, B1.CW_VALUE_ALLOW_SALE, B1.CW_VALUE_STOCK,
       B1.CW_VALUE_NOT_PLANNING_PERMIT, B1.CW_VALUE_NOT_CONSTRUCTION_PER, B1.CW_VALUE_NOT_SALE_PERMIT, B1.CW_VALUE_NOT_COMPLETION, B1.CW_VALUE_YES_COMPLETION, B1.CW_VALUE_YES_SETTLEMENT, B1.CW_AREA_DT_ALL,
       B1.CW_AREA_REMAIN, B1.CW_AREA_HAVED_SALE, B1.CW_AREA_RESERVE, B1.CW_AREA_IN_PROCESS, B1.CW_AREA_ALLOW_SALE, B1.CW_AREA_STOCK, B1.CW_AREA_NOT_PLANNING_PERMIT, B1.CW_AREA_NOT_CONSTRUCTION_PER,
       B1.CW_AREA_NOT_SALE_PERMIT, B1.CW_AREA_NOT_COMPLETION, B1.CW_AREA_YES_COMPLETION, B1.CW_AREA_YES_SETTLEMENT, B1.ZZ_VALUE_DT_ALL, B1.ZZ_VALUE_REMAIN, B1.ZZ_VALUE_HAVED_SALE, B1.ZZ_VALUE_RESERVE,
       B1.ZZ_VALUE_IN_PROCESS, B1.ZZ_VALUE_ALLOW_SALE, B1.ZZ_VALUE_STOCK, B1.ZZ_VALUE_NOT_PLANNING_PERMIT, B1.ZZ_VALUE_NOT_CONSTRUCTION_PER, B1.ZZ_VALUE_NOT_SALE_PERMIT, B1.ZZ_VALUE_NOT_COMPLETION,
       B1.ZZ_VALUE_YES_COMPLETION, B1.ZZ_VALUE_YES_SETTLEMENT, B1.ZZ_AREA_DT_ALL, B1.ZZ_AREA_REMAIN, B1.ZZ_AREA_HAVED_SALE, B1.ZZ_AREA_RESERVE, B1.ZZ_AREA_IN_PROCESS, B1.ZZ_AREA_ALLOW_SALE, B1.ZZ_AREA_STOCK,
       B1.ZZ_AREA_NOT_PLANNING_PERMIT, B1.ZZ_AREA_NOT_CONSTRUCTION_PER, B1.ZZ_AREA_NOT_SALE_PERMIT, B1.ZZ_AREA_NOT_COMPLETION, B1.ZZ_AREA_YES_COMPLETION, B1.ZZ_AREA_YES_SETTLEMENT, B1.SY_VALUE_DT_ALL,
       B1.SY_VALUE_REMAIN, B1.SY_VALUE_HAVED_SALE, B1.SY_VALUE_RESERVE, B1.SY_VALUE_IN_PROCESS, B1.SY_VALUE_ALLOW_SALE, B1.SY_VALUE_STOCK, B1.SY_VALUE_NOT_PLANNING_PERMIT, B1.SY_VALUE_NOT_CONSTRUCTION_PER,
       B1.SY_VALUE_NOT_SALE_PERMIT, B1.SY_VALUE_NOT_COMPLETION, B1.SY_VALUE_YES_COMPLETION, B1.SY_VALUE_YES_SETTLEMENT, B1.SY_AREA_DT_ALL, B1.SY_AREA_REMAIN, B1.SY_AREA_HAVED_SALE, B1.SY_AREA_RESERVE,
       B1.SY_AREA_IN_PROCESS, B1.SY_AREA_ALLOW_SALE, B1.SY_AREA_STOCK, B1.SY_AREA_NOT_PLANNING_PERMIT, B1.SY_AREA_NOT_CONSTRUCTION_PER, B1.SY_AREA_NOT_SALE_PERMIT, B1.SY_AREA_NOT_COMPLETION,
       B1.SY_AREA_YES_COMPLETION, B1.SY_AREA_YES_SETTLEMENT, B1.PROJ_ID, B1.TARGET_NOW_NAME, B1.TARGET_A_ID, B1.TARGET_A1_ID, B1.TARGET_A2_ID, B1.TARGET_A3_ID, B1.TARGET_A_VALUE, B1.TARGET_A1_VALUE,
       B1.TARGET_A2_VALUE, B1.TARGET_A3_VALUE, B1.TARGET_A_VALUE_DIFF,A1.COMPANY_ID AS PARENT_ID,NVL(A1.PROJ_COOPERATE,'操盘'),TO_CHAR(A1.PROJECT_GET_TIME,'YYYY-MM-DD') AS TAKE_DATE,0,4,a1.ORDER_HIERARCHY_CODE
FROM   MDM_PROJECT A1
INNER  JOIN DWM_DT_VALUE B1
ON     A1.ID = B1.OBJ_ID AND B1.OBJ_TYPE = '项目'
WHERE  a1.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a1.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END) 
UNION ALL
SELECT B2.ID,A2.PARENT_ID, B2.ORG_NAME, '公司', A2.VALUE_DT_ALL, A2.VALUE_REMAIN, A2.VALUE_HAVED_SALE, A2.VALUE_RESERVE, A2.VALUE_IN_PROCESS, A2.VALUE_ALLOW_SALE, A2.VALUE_STOCK,
       A2.VALUE_NOT_PLANNING_PERMIT, A2.VALUE_NOT_CONSTRUCTION_PERMIT, A2.VALUE_NOT_SALE_PERMIT, A2.VALUE_NOT_COMPLETION, A2.VALUE_YES_COMPLETION, A2.VALUE_YES_SETTLEMENT, A2.AREA_DT_ALL, A2.AREA_REMAIN,
       A2.AREA_HAVED_SALE, A2.AREA_RESERVE, A2.AREA_IN_PROCESS, A2.AREA_ALLOW_SALE, A2.AREA_STOCK, A2.AREA_NOT_PLANNING_PERMIT, A2.AREA_NOT_CONSTRUCTION_PERMIT, A2.AREA_NOT_SALE_PERMIT, A2.AREA_NOT_COMPLETION,
       A2.AREA_YES_COMPLETION, A2.AREA_YES_SETTLEMENT, A2.TMP_1KY_VALUE, A2.TMP_1KY_AREA, A2.TMP_1KY_PRICE, A2.TMP_2QP_VALUE, A2.TMP_2QP_AREA, A2.TMP_2QP_PRICE, A2.TMP_3DT_TARGETVALUE, A2.TMP_3DT_TARGETAREA,
       A2.TMP_3DT_TARGETPRICE, A2.CW_VALUE_DT_ALL, A2.CW_VALUE_REMAIN, A2.CW_VALUE_HAVED_SALE, A2.CW_VALUE_RESERVE, A2.CW_VALUE_IN_PROCESS, A2.CW_VALUE_ALLOW_SALE, A2.CW_VALUE_STOCK,
       A2.CW_VALUE_NOT_PLANNING_PERMIT, A2.CW_VALUE_NOT_CONSTRUCTION_PER, A2.CW_VALUE_NOT_SALE_PERMIT, A2.CW_VALUE_NOT_COMPLETION, A2.CW_VALUE_YES_COMPLETION, A2.CW_VALUE_YES_SETTLEMENT, A2.CW_AREA_DT_ALL,
       A2.CW_AREA_REMAIN, A2.CW_AREA_HAVED_SALE, A2.CW_AREA_RESERVE, A2.CW_AREA_IN_PROCESS, A2.CW_AREA_ALLOW_SALE, A2.CW_AREA_STOCK, A2.CW_AREA_NOT_PLANNING_PERMIT, A2.CW_AREA_NOT_CONSTRUCTION_PER,
       A2.CW_AREA_NOT_SALE_PERMIT, A2.CW_AREA_NOT_COMPLETION, A2.CW_AREA_YES_COMPLETION, A2.CW_AREA_YES_SETTLEMENT, A2.ZZ_VALUE_DT_ALL, A2.ZZ_VALUE_REMAIN, A2.ZZ_VALUE_HAVED_SALE, A2.ZZ_VALUE_RESERVE,
       A2.ZZ_VALUE_IN_PROCESS, A2.ZZ_VALUE_ALLOW_SALE, A2.ZZ_VALUE_STOCK, A2.ZZ_VALUE_NOT_PLANNING_PERMIT, A2.ZZ_VALUE_NOT_CONSTRUCTION_PER, A2.ZZ_VALUE_NOT_SALE_PERMIT, A2.ZZ_VALUE_NOT_COMPLETION,
       A2.ZZ_VALUE_YES_COMPLETION, A2.ZZ_VALUE_YES_SETTLEMENT, A2.ZZ_AREA_DT_ALL, A2.ZZ_AREA_REMAIN, A2.ZZ_AREA_HAVED_SALE, A2.ZZ_AREA_RESERVE, A2.ZZ_AREA_IN_PROCESS, A2.ZZ_AREA_ALLOW_SALE, A2.ZZ_AREA_STOCK,
       A2.ZZ_AREA_NOT_PLANNING_PERMIT, A2.ZZ_AREA_NOT_CONSTRUCTION_PER, A2.ZZ_AREA_NOT_SALE_PERMIT, A2.ZZ_AREA_NOT_COMPLETION, A2.ZZ_AREA_YES_COMPLETION, A2.ZZ_AREA_YES_SETTLEMENT, A2.SY_VALUE_DT_ALL,
       A2.SY_VALUE_REMAIN, A2.SY_VALUE_HAVED_SALE, A2.SY_VALUE_RESERVE, A2.SY_VALUE_IN_PROCESS, A2.SY_VALUE_ALLOW_SALE, A2.SY_VALUE_STOCK, A2.SY_VALUE_NOT_PLANNING_PERMIT, A2.SY_VALUE_NOT_CONSTRUCTION_PER,
       A2.SY_VALUE_NOT_SALE_PERMIT, A2.SY_VALUE_NOT_COMPLETION, A2.SY_VALUE_YES_COMPLETION, A2.SY_VALUE_YES_SETTLEMENT, A2.SY_AREA_DT_ALL, A2.SY_AREA_REMAIN, A2.SY_AREA_HAVED_SALE, A2.SY_AREA_RESERVE,
       A2.SY_AREA_IN_PROCESS, A2.SY_AREA_ALLOW_SALE, A2.SY_AREA_STOCK, A2.SY_AREA_NOT_PLANNING_PERMIT, A2.SY_AREA_NOT_CONSTRUCTION_PER, A2.SY_AREA_NOT_SALE_PERMIT, A2.SY_AREA_NOT_COMPLETION,
       A2.SY_AREA_YES_COMPLETION, A2.SY_AREA_YES_SETTLEMENT, A2.PROJ_ID, A2.TARGET_NOW_NAME, A2.TARGET_A_ID, A2.TARGET_A1_ID, A2.TARGET_A2_ID, A2.TARGET_A3_ID, A2.TARGET_A_VALUE, A2.TARGET_A1_VALUE,
       A2.TARGET_A2_VALUE, A2.TARGET_A3_VALUE, A2.TARGET_A_VALUE_DIFF,B2.PARENT_ID,'','',1,B2.LEVEL_RANK,b2.ORDER_HIERARCHY_CODE
FROM TEMP_DT_VALUE A2
INNER JOIN SYS_BUSINESS_UNIT B2 ON A2.PARENT_ID = B2.ID AND B2.IS_COMPANY = 1
)
				SELECT
                          a.id          AS "orgId",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id   AS "parentId",--父级id（生成树父级id）
                          ORG_LEVEL AS "orgLevel",
                          0 AS "itemsNum",
                          0 AS "submitNum",
                          CASE
                              WHEN ORG_LEVEL = 1 THEN
                                  '' || org_name
                              WHEN ORG_LEVEL = 2 THEN
                                  '        ' || org_name
                              WHEN ORG_LEVEL = 3 THEN
                                  '                ' || org_name
                              WHEN ORG_LEVEL = 4 THEN
                                  '                        ' || org_name
                              ELSE
                                  '                                '|| org_name
                          END AS "treeOrgName",--文本前面加空格模仿树
                          org_name      AS "orgName"--项目/分期/业态/楼栋
                      FROM   TEMP_DT_VALUE A
            INNER JOIN (SELECT p.ID FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 START WITH p.id = '' || unitid_val || '' CONNECT BY PRIOR p.ID = p.PARENT_ID
						           UNION ALL
											 SELECT M.ID FROM SYS_PROJECT M WHERE EXISTS (SELECT 1 FROM SYS_BUSINESS_UNIT N WHERE N.IS_COMPANY = 1 AND N.ID = M.UNIT_ID START WITH N.id = '' || unitid_val || '' CONNECT BY PRIOR N.ID = N.PARENT_ID)) b ON a.id = b.id
                      -- WHERE  a.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END)    
						GROUP BY A.ID,A.ORG_NAME,A.PARENT_ID,A.IS_COMPANY,A.PROJ_COOPERATE，A.TAKE_DATE,ORG_LEVEL,A.ORDER_HIERARCHY_CODE order by ORDER_HIERARCHY_CODE;

ELSIF tabsindex = 5  THEN
        OPEN info FOR 
				WITH TEMP_DT_VALUE (ID,COMPANY_ID, ORG_NAME, OBJ_TYPE, VALUE_DT_ALL, VALUE_REMAIN, VALUE_HAVED_SALE, VALUE_RESERVE, VALUE_IN_PROCESS, VALUE_ALLOW_SALE, VALUE_STOCK,
       VALUE_NOT_PLANNING_PERMIT, VALUE_NOT_CONSTRUCTION_PERMIT, VALUE_NOT_SALE_PERMIT, VALUE_NOT_COMPLETION, VALUE_YES_COMPLETION, VALUE_YES_SETTLEMENT, AREA_DT_ALL, AREA_REMAIN,
       AREA_HAVED_SALE, AREA_RESERVE, AREA_IN_PROCESS, AREA_ALLOW_SALE, AREA_STOCK, AREA_NOT_PLANNING_PERMIT, AREA_NOT_CONSTRUCTION_PERMIT, AREA_NOT_SALE_PERMIT, AREA_NOT_COMPLETION,
       AREA_YES_COMPLETION, AREA_YES_SETTLEMENT, TMP_1KY_VALUE, TMP_1KY_AREA, TMP_1KY_PRICE, TMP_2QP_VALUE, TMP_2QP_AREA, TMP_2QP_PRICE, TMP_3DT_TARGETVALUE, TMP_3DT_TARGETAREA,
       TMP_3DT_TARGETPRICE, CW_VALUE_DT_ALL, CW_VALUE_REMAIN, CW_VALUE_HAVED_SALE, CW_VALUE_RESERVE, CW_VALUE_IN_PROCESS, CW_VALUE_ALLOW_SALE, CW_VALUE_STOCK,
       CW_VALUE_NOT_PLANNING_PERMIT, CW_VALUE_NOT_CONSTRUCTION_PER, CW_VALUE_NOT_SALE_PERMIT, CW_VALUE_NOT_COMPLETION, CW_VALUE_YES_COMPLETION, CW_VALUE_YES_SETTLEMENT, CW_AREA_DT_ALL,
       CW_AREA_REMAIN, CW_AREA_HAVED_SALE, CW_AREA_RESERVE, CW_AREA_IN_PROCESS, CW_AREA_ALLOW_SALE, CW_AREA_STOCK, CW_AREA_NOT_PLANNING_PERMIT, CW_AREA_NOT_CONSTRUCTION_PER,
       CW_AREA_NOT_SALE_PERMIT, CW_AREA_NOT_COMPLETION, CW_AREA_YES_COMPLETION, CW_AREA_YES_SETTLEMENT, ZZ_VALUE_DT_ALL, ZZ_VALUE_REMAIN, ZZ_VALUE_HAVED_SALE, ZZ_VALUE_RESERVE,
       ZZ_VALUE_IN_PROCESS, ZZ_VALUE_ALLOW_SALE, ZZ_VALUE_STOCK, ZZ_VALUE_NOT_PLANNING_PERMIT, ZZ_VALUE_NOT_CONSTRUCTION_PER, ZZ_VALUE_NOT_SALE_PERMIT, ZZ_VALUE_NOT_COMPLETION,
       ZZ_VALUE_YES_COMPLETION, ZZ_VALUE_YES_SETTLEMENT, ZZ_AREA_DT_ALL, ZZ_AREA_REMAIN, ZZ_AREA_HAVED_SALE, ZZ_AREA_RESERVE, ZZ_AREA_IN_PROCESS, ZZ_AREA_ALLOW_SALE, ZZ_AREA_STOCK,
       ZZ_AREA_NOT_PLANNING_PERMIT, ZZ_AREA_NOT_CONSTRUCTION_PER, ZZ_AREA_NOT_SALE_PERMIT, ZZ_AREA_NOT_COMPLETION, ZZ_AREA_YES_COMPLETION, ZZ_AREA_YES_SETTLEMENT, SY_VALUE_DT_ALL,
       SY_VALUE_REMAIN, SY_VALUE_HAVED_SALE, SY_VALUE_RESERVE, SY_VALUE_IN_PROCESS, SY_VALUE_ALLOW_SALE, SY_VALUE_STOCK, SY_VALUE_NOT_PLANNING_PERMIT, SY_VALUE_NOT_CONSTRUCTION_PER,
       SY_VALUE_NOT_SALE_PERMIT, SY_VALUE_NOT_COMPLETION, SY_VALUE_YES_COMPLETION, SY_VALUE_YES_SETTLEMENT, SY_AREA_DT_ALL, SY_AREA_REMAIN, SY_AREA_HAVED_SALE, SY_AREA_RESERVE,
       SY_AREA_IN_PROCESS, SY_AREA_ALLOW_SALE, SY_AREA_STOCK, SY_AREA_NOT_PLANNING_PERMIT, SY_AREA_NOT_CONSTRUCTION_PER, SY_AREA_NOT_SALE_PERMIT, SY_AREA_NOT_COMPLETION,
       SY_AREA_YES_COMPLETION, SY_AREA_YES_SETTLEMENT, PROJ_ID, TARGET_NOW_NAME, TARGET_A_ID, TARGET_A1_ID, TARGET_A2_ID, TARGET_A3_ID, TARGET_A_VALUE, TARGET_A1_VALUE,
       TARGET_A2_VALUE, TARGET_A3_VALUE, TARGET_A_VALUE_DIFF,PARENT_ID,PROJ_COOPERATE,TAKE_DATE,IS_COMPANY,ORG_LEVEL,ORDER_HIERARCHY_CODE) AS 
       (     
SELECT A1.ID,A1.COMPANY_ID, B1.OBJ_NAME, B1.OBJ_TYPE, B1.VALUE_DT_ALL, B1.VALUE_REMAIN, B1.VALUE_HAVED_SALE, B1.VALUE_RESERVE, B1.VALUE_IN_PROCESS, B1.VALUE_ALLOW_SALE, B1.VALUE_STOCK,
       B1.VALUE_NOT_PLANNING_PERMIT, B1.VALUE_NOT_CONSTRUCTION_PERMIT, B1.VALUE_NOT_SALE_PERMIT, B1.VALUE_NOT_COMPLETION, B1.VALUE_YES_COMPLETION, B1.VALUE_YES_SETTLEMENT, B1.AREA_DT_ALL, B1.AREA_REMAIN,
       B1.AREA_HAVED_SALE, B1.AREA_RESERVE, B1.AREA_IN_PROCESS, B1.AREA_ALLOW_SALE, B1.AREA_STOCK, B1.AREA_NOT_PLANNING_PERMIT, B1.AREA_NOT_CONSTRUCTION_PERMIT, B1.AREA_NOT_SALE_PERMIT, B1.AREA_NOT_COMPLETION,
       B1.AREA_YES_COMPLETION, B1.AREA_YES_SETTLEMENT, B1.TMP_1KY_VALUE, B1.TMP_1KY_AREA, B1.TMP_1KY_PRICE, B1.TMP_2QP_VALUE, B1.TMP_2QP_AREA, B1.TMP_2QP_PRICE, B1.TMP_3DT_TARGETVALUE, B1.TMP_3DT_TARGETAREA,
       B1.TMP_3DT_TARGETPRICE, B1.CW_VALUE_DT_ALL, B1.CW_VALUE_REMAIN, B1.CW_VALUE_HAVED_SALE, B1.CW_VALUE_RESERVE, B1.CW_VALUE_IN_PROCESS, B1.CW_VALUE_ALLOW_SALE, B1.CW_VALUE_STOCK,
       B1.CW_VALUE_NOT_PLANNING_PERMIT, B1.CW_VALUE_NOT_CONSTRUCTION_PER, B1.CW_VALUE_NOT_SALE_PERMIT, B1.CW_VALUE_NOT_COMPLETION, B1.CW_VALUE_YES_COMPLETION, B1.CW_VALUE_YES_SETTLEMENT, B1.CW_AREA_DT_ALL,
       B1.CW_AREA_REMAIN, B1.CW_AREA_HAVED_SALE, B1.CW_AREA_RESERVE, B1.CW_AREA_IN_PROCESS, B1.CW_AREA_ALLOW_SALE, B1.CW_AREA_STOCK, B1.CW_AREA_NOT_PLANNING_PERMIT, B1.CW_AREA_NOT_CONSTRUCTION_PER,
       B1.CW_AREA_NOT_SALE_PERMIT, B1.CW_AREA_NOT_COMPLETION, B1.CW_AREA_YES_COMPLETION, B1.CW_AREA_YES_SETTLEMENT, B1.ZZ_VALUE_DT_ALL, B1.ZZ_VALUE_REMAIN, B1.ZZ_VALUE_HAVED_SALE, B1.ZZ_VALUE_RESERVE,
       B1.ZZ_VALUE_IN_PROCESS, B1.ZZ_VALUE_ALLOW_SALE, B1.ZZ_VALUE_STOCK, B1.ZZ_VALUE_NOT_PLANNING_PERMIT, B1.ZZ_VALUE_NOT_CONSTRUCTION_PER, B1.ZZ_VALUE_NOT_SALE_PERMIT, B1.ZZ_VALUE_NOT_COMPLETION,
       B1.ZZ_VALUE_YES_COMPLETION, B1.ZZ_VALUE_YES_SETTLEMENT, B1.ZZ_AREA_DT_ALL, B1.ZZ_AREA_REMAIN, B1.ZZ_AREA_HAVED_SALE, B1.ZZ_AREA_RESERVE, B1.ZZ_AREA_IN_PROCESS, B1.ZZ_AREA_ALLOW_SALE, B1.ZZ_AREA_STOCK,
       B1.ZZ_AREA_NOT_PLANNING_PERMIT, B1.ZZ_AREA_NOT_CONSTRUCTION_PER, B1.ZZ_AREA_NOT_SALE_PERMIT, B1.ZZ_AREA_NOT_COMPLETION, B1.ZZ_AREA_YES_COMPLETION, B1.ZZ_AREA_YES_SETTLEMENT, B1.SY_VALUE_DT_ALL,
       B1.SY_VALUE_REMAIN, B1.SY_VALUE_HAVED_SALE, B1.SY_VALUE_RESERVE, B1.SY_VALUE_IN_PROCESS, B1.SY_VALUE_ALLOW_SALE, B1.SY_VALUE_STOCK, B1.SY_VALUE_NOT_PLANNING_PERMIT, B1.SY_VALUE_NOT_CONSTRUCTION_PER,
       B1.SY_VALUE_NOT_SALE_PERMIT, B1.SY_VALUE_NOT_COMPLETION, B1.SY_VALUE_YES_COMPLETION, B1.SY_VALUE_YES_SETTLEMENT, B1.SY_AREA_DT_ALL, B1.SY_AREA_REMAIN, B1.SY_AREA_HAVED_SALE, B1.SY_AREA_RESERVE,
       B1.SY_AREA_IN_PROCESS, B1.SY_AREA_ALLOW_SALE, B1.SY_AREA_STOCK, B1.SY_AREA_NOT_PLANNING_PERMIT, B1.SY_AREA_NOT_CONSTRUCTION_PER, B1.SY_AREA_NOT_SALE_PERMIT, B1.SY_AREA_NOT_COMPLETION,
       B1.SY_AREA_YES_COMPLETION, B1.SY_AREA_YES_SETTLEMENT, B1.PROJ_ID, B1.TARGET_NOW_NAME, B1.TARGET_A_ID, B1.TARGET_A1_ID, B1.TARGET_A2_ID, B1.TARGET_A3_ID, B1.TARGET_A_VALUE, B1.TARGET_A1_VALUE,
       B1.TARGET_A2_VALUE, B1.TARGET_A3_VALUE, B1.TARGET_A_VALUE_DIFF,A1.COMPANY_ID AS PARENT_ID,NVL(A1.PROJ_COOPERATE,'操盘'),TO_CHAR(A1.PROJECT_GET_TIME,'YYYY-MM-DD') AS TAKE_DATE,0,4,a1.ORDER_HIERARCHY_CODE
FROM   MDM_PROJECT A1
INNER  JOIN DWM_DT_VALUE B1
ON     A1.ID = B1.OBJ_ID AND B1.OBJ_TYPE = '项目'
WHERE  a1.PROJ_COOPERATE =  (CASE WHEN ISOPERATE = '所有' THEN a1.PROJ_COOPERATE WHEN ISOPERATE = '操盘' THEN  '操盘' ELSE '不操盘' END) 
UNION ALL
SELECT B2.ID,A2.PARENT_ID, B2.ORG_NAME, '公司', A2.VALUE_DT_ALL, A2.VALUE_REMAIN, A2.VALUE_HAVED_SALE, A2.VALUE_RESERVE, A2.VALUE_IN_PROCESS, A2.VALUE_ALLOW_SALE, A2.VALUE_STOCK,
       A2.VALUE_NOT_PLANNING_PERMIT, A2.VALUE_NOT_CONSTRUCTION_PERMIT, A2.VALUE_NOT_SALE_PERMIT, A2.VALUE_NOT_COMPLETION, A2.VALUE_YES_COMPLETION, A2.VALUE_YES_SETTLEMENT, A2.AREA_DT_ALL, A2.AREA_REMAIN,
       A2.AREA_HAVED_SALE, A2.AREA_RESERVE, A2.AREA_IN_PROCESS, A2.AREA_ALLOW_SALE, A2.AREA_STOCK, A2.AREA_NOT_PLANNING_PERMIT, A2.AREA_NOT_CONSTRUCTION_PERMIT, A2.AREA_NOT_SALE_PERMIT, A2.AREA_NOT_COMPLETION,
       A2.AREA_YES_COMPLETION, A2.AREA_YES_SETTLEMENT, A2.TMP_1KY_VALUE, A2.TMP_1KY_AREA, A2.TMP_1KY_PRICE, A2.TMP_2QP_VALUE, A2.TMP_2QP_AREA, A2.TMP_2QP_PRICE, A2.TMP_3DT_TARGETVALUE, A2.TMP_3DT_TARGETAREA,
       A2.TMP_3DT_TARGETPRICE, A2.CW_VALUE_DT_ALL, A2.CW_VALUE_REMAIN, A2.CW_VALUE_HAVED_SALE, A2.CW_VALUE_RESERVE, A2.CW_VALUE_IN_PROCESS, A2.CW_VALUE_ALLOW_SALE, A2.CW_VALUE_STOCK,
       A2.CW_VALUE_NOT_PLANNING_PERMIT, A2.CW_VALUE_NOT_CONSTRUCTION_PER, A2.CW_VALUE_NOT_SALE_PERMIT, A2.CW_VALUE_NOT_COMPLETION, A2.CW_VALUE_YES_COMPLETION, A2.CW_VALUE_YES_SETTLEMENT, A2.CW_AREA_DT_ALL,
       A2.CW_AREA_REMAIN, A2.CW_AREA_HAVED_SALE, A2.CW_AREA_RESERVE, A2.CW_AREA_IN_PROCESS, A2.CW_AREA_ALLOW_SALE, A2.CW_AREA_STOCK, A2.CW_AREA_NOT_PLANNING_PERMIT, A2.CW_AREA_NOT_CONSTRUCTION_PER,
       A2.CW_AREA_NOT_SALE_PERMIT, A2.CW_AREA_NOT_COMPLETION, A2.CW_AREA_YES_COMPLETION, A2.CW_AREA_YES_SETTLEMENT, A2.ZZ_VALUE_DT_ALL, A2.ZZ_VALUE_REMAIN, A2.ZZ_VALUE_HAVED_SALE, A2.ZZ_VALUE_RESERVE,
       A2.ZZ_VALUE_IN_PROCESS, A2.ZZ_VALUE_ALLOW_SALE, A2.ZZ_VALUE_STOCK, A2.ZZ_VALUE_NOT_PLANNING_PERMIT, A2.ZZ_VALUE_NOT_CONSTRUCTION_PER, A2.ZZ_VALUE_NOT_SALE_PERMIT, A2.ZZ_VALUE_NOT_COMPLETION,
       A2.ZZ_VALUE_YES_COMPLETION, A2.ZZ_VALUE_YES_SETTLEMENT, A2.ZZ_AREA_DT_ALL, A2.ZZ_AREA_REMAIN, A2.ZZ_AREA_HAVED_SALE, A2.ZZ_AREA_RESERVE, A2.ZZ_AREA_IN_PROCESS, A2.ZZ_AREA_ALLOW_SALE, A2.ZZ_AREA_STOCK,
       A2.ZZ_AREA_NOT_PLANNING_PERMIT, A2.ZZ_AREA_NOT_CONSTRUCTION_PER, A2.ZZ_AREA_NOT_SALE_PERMIT, A2.ZZ_AREA_NOT_COMPLETION, A2.ZZ_AREA_YES_COMPLETION, A2.ZZ_AREA_YES_SETTLEMENT, A2.SY_VALUE_DT_ALL,
       A2.SY_VALUE_REMAIN, A2.SY_VALUE_HAVED_SALE, A2.SY_VALUE_RESERVE, A2.SY_VALUE_IN_PROCESS, A2.SY_VALUE_ALLOW_SALE, A2.SY_VALUE_STOCK, A2.SY_VALUE_NOT_PLANNING_PERMIT, A2.SY_VALUE_NOT_CONSTRUCTION_PER,
       A2.SY_VALUE_NOT_SALE_PERMIT, A2.SY_VALUE_NOT_COMPLETION, A2.SY_VALUE_YES_COMPLETION, A2.SY_VALUE_YES_SETTLEMENT, A2.SY_AREA_DT_ALL, A2.SY_AREA_REMAIN, A2.SY_AREA_HAVED_SALE, A2.SY_AREA_RESERVE,
       A2.SY_AREA_IN_PROCESS, A2.SY_AREA_ALLOW_SALE, A2.SY_AREA_STOCK, A2.SY_AREA_NOT_PLANNING_PERMIT, A2.SY_AREA_NOT_CONSTRUCTION_PER, A2.SY_AREA_NOT_SALE_PERMIT, A2.SY_AREA_NOT_COMPLETION,
       A2.SY_AREA_YES_COMPLETION, A2.SY_AREA_YES_SETTLEMENT, A2.PROJ_ID, A2.TARGET_NOW_NAME, A2.TARGET_A_ID, A2.TARGET_A1_ID, A2.TARGET_A2_ID, A2.TARGET_A3_ID, A2.TARGET_A_VALUE, A2.TARGET_A1_VALUE,
       A2.TARGET_A2_VALUE, A2.TARGET_A3_VALUE, A2.TARGET_A_VALUE_DIFF,B2.PARENT_ID,'','',1,B2.LEVEL_RANK,b2.ORDER_HIERARCHY_CODE
FROM TEMP_DT_VALUE A2
INNER JOIN SYS_BUSINESS_UNIT B2 ON A2.PARENT_ID = B2.ID AND B2.IS_COMPANY = 1
)
				SELECT
                          a.id          AS "orgId",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id   AS "parentId",--父级id（生成树父级id）
                          ORG_LEVEL AS "orgLevel",
                          0 AS "itemsNum",
                          0 AS "submitNum",
                          CASE
                              WHEN ORG_LEVEL = 1 THEN
                                  '' || org_name
                              WHEN ORG_LEVEL = 2 THEN
                                  '        ' || org_name
                              WHEN ORG_LEVEL = 3 THEN
                                  '                ' || org_name
                              WHEN ORG_LEVEL = 4 THEN
                                  '                        ' || org_name
                              ELSE
                                  '                                '|| org_name
                          END AS "treeOrgName",--文本前面加空格模仿树
                          org_name      AS "orgName"--项目/分期/业态/楼栋
                      FROM   TEMP_DT_VALUE A
            INNER JOIN (SELECT p.ID FROM SYS_BUSINESS_UNIT p WHERE p.IS_COMPANY = 1 START WITH p.id = '' || unitid_val || '' CONNECT BY PRIOR p.ID = p.PARENT_ID
						           UNION ALL
											 SELECT M.ID FROM SYS_PROJECT M WHERE EXISTS (SELECT 1 FROM SYS_BUSINESS_UNIT N WHERE N.IS_COMPANY = 1 AND N.ID = M.UNIT_ID START WITH N.id = '' || unitid_val || '' CONNECT BY PRIOR N.ID = N.PARENT_ID)) b ON a.id = b.id

						GROUP BY A.ID,A.ORG_NAME,A.PARENT_ID,A.IS_COMPANY,A.PROJ_COOPERATE，A.TAKE_DATE,ORG_LEVEL,A.ORDER_HIERARCHY_CODE order by ORDER_HIERARCHY_CODE;
    END IF;


END P_OPM_PROJ_LIST;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_GROUP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP" (
    planyear    IN   NUMBER,--计划年
    companyid   IN   VARCHAR2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN
    BEGIN
        p_opm_sum_group_cash(planyear => planyear, companyid => companyid);
--rollback; 
    END;
END p_opm_sum_group;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_GROUP_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_CASH" (planyear IN number--计划年
,companyid in varchar2--区域公司
--计划年
) AS-- 根据年份【汇总集团】现金流
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----获取该年下所有项目，更新项目数据
UPDATE opm_group_cash a
SET  (
a.remaining_amount,
a.sour_sales_collection,
a.sour_rental_income,
a.sour_increase_loan,
a.sour_collection_loan,
a.sour_shareholder_input,
a.sour_investment_input,
a.sour_other_input,
a.sour_total_funds,
a.util_land_cost,
a.util_engineering_expenditure,
a.util_development_overhead,
a.util_expenses_the_period,
a.util_taxes,
a.util_pre_payment,
a.util_other_expenses,
a.util_current_expenditure,
a.util_subtotal_fund,
a.cash_flow_funds,
a.cash_remaining_amount,
a.cash_available_funds
) =
       (SELECT 
b.remaining_amount,
b.sour_sales_collection,
b.sour_rental_income,
b.sour_increase_loan,
b.sour_collection_loan,
b.sour_shareholder_input,
b.sour_investment_input,
b.sour_other_input,
b.sour_total_funds,
b.util_land_cost,
b.util_engineering_expenditure,
b.util_development_overhead,
b.util_expenses_the_period,
b.util_taxes,
b.util_pre_payment,
b.util_other_expenses,
b.util_current_expenditure,
b.util_subtotal_fund,
b.cash_flow_funds,
b.cash_remaining_amount,
b.cash_available_funds     
        FROM   OPM_REGION_CASH b
        WHERE  b.object_id = a.object_id
        AND    a.plan_year=planyear);
END P_OPM_SUM_GROUP_CASH;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_GROUP_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_INVENTORY" (
    planyear    IN   NUMBER--计划年
    ,
    companyid   IN   VARCHAR2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】供销存（集团总表3）-根据区域总表3汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN
    dbms_output.put_line('初始化脚本');
    UPDATE opm_group_inventory_plan a
    SET
        ( a.ny_first_supply_area,
          a.ny_first_supply_number,
          a.ny_first_supply_amount,
          a.ny_first_sale_area,
          a.ny_first_sale_number,
          a.ny_first_sale_amount,
          a.ny_second_supply_area,
          a.ny_second_supply_number,
          a.ny_second_supply_amount,
          a.ny_second_sale_area,
          a.ny_second_sale_number,
          a.ny_second_sale_amount,
          a.ny_third_supply_area,
          a.ny_third_supply_number,
          a.ny_third_supply_amount,
          a.ny_third_sale_area,
          a.ny_third_sale_number,
          a.ny_third_sale_amount,
          a.ny_fourth_supply_area,
          a.ny_fourth_supply_number,
          a.ny_fourth_supply_amount,
          a.ny_fourth_sale_area,
          a.ny_fourth_sale_number,
          a.ny_fourth_sale_amount,
          a.ncy_first_supply_area,
          a.ncy_first_supply_number,
          a.ncy_first_supply_amount,
          a.ncy_first_sale_area,
          a.ncy_first_sale_number,
          a.ncy_first_sale_amount,
          a.ncy_second_supply_area,
          a.ncy_second_supply_number,
          a.ncy_second_supply_amount,
          a.ncy_second_sale_area,
          a.ncy_second_sale_number,
          a.ncy_second_sale_amount,
          a.ncy_third_supply_area,
          a.ncy_third_supply_number,
          a.ncy_third_supply_amount,
          a.ncy_third_sale_area,
          a.ncy_third_sale_number,
          a.ncy_third_sale_amount,
          a.ncy_fourth_supply_area,
          a.ncy_fourth_supply_number,
          a.ncy_fourth_supply_amount,
          a.ncy_fourth_sale_area,
          a.ncy_fourth_sale_number,
          a.ncy_fourth_sale_amount,
          a.nty_first_supply_area,
          a.nty_first_supply_number,
          a.nty_first_supply_amount,
          a.nty_first_sale_area,
          a.nty_first_sale_number,
          a.nty_first_sale_amount,
          a.nty_second_supply_area,
          a.nty_second_supply_number,
          a.nty_second_supply_amount,
          a.nty_second_sale_area,
          a.nty_second_sale_number,
          a.nty_second_sale_amount,
          a.nty_third_supply_area,
          a.nty_third_supply_number,
          a.nty_third_supply_amount,
          a.nty_third_sale_area,
          a.nty_third_sale_number,
          a.nty_third_sale_amount,
          a.nty_fourth_supply_area,
          a.nty_fourth_supply_number,
          a.nty_fourth_supply_amount,
          a.nty_fourth_sale_area,
          a.nty_fourth_sale_number,
          a.nty_fourth_sale_amount,
          a.nfy_first_supply_area,
          a.nfy_first_supply_number,
          a.nfy_first_supply_amount,
          a.nfy_first_sale_area,
          a.nfy_first_sale_number,
          a.nfy_first_sale_amount,
          a.nfy_second_supply_area,
          a.nfy_second_supply_number,
          a.nfy_second_supply_amount,
          a.nfy_second_sale_area,
          a.nfy_second_sale_number,
          a.nfy_second_sale_amount,
          a.nfy_third_supply_area,
          a.nfy_third_supply_number,
          a.nfy_third_supply_amount,
          a.nfy_third_sale_area,
          a.nfy_third_sale_number,
          a.nfy_third_sale_amount,
          a.nfy_fourth_supply_area,
          a.nfy_fourth_supply_number,
          a.nfy_fourth_supply_amount,
          a.nfy_fourth_sale_area,
          a.nfy_fourth_sale_number,
          a.nfy_fourth_sale_amount ) = (
            SELECT
                b.ny_first_supply_area,
                b.ny_first_supply_number,
                b.ny_first_supply_amount,
                b.ny_first_sale_area,
                b.ny_first_sale_number,
                b.ny_first_sale_amount,
                b.ny_second_supply_area,
                b.ny_second_supply_number,
                b.ny_second_supply_amount,
                b.ny_second_sale_area,
                b.ny_second_sale_number,
                b.ny_second_sale_amount,
                b.ny_third_supply_area,
                b.ny_third_supply_number,
                b.ny_third_supply_amount,
                b.ny_third_sale_area,
                b.ny_third_sale_number,
                b.ny_third_sale_amount,
                b.ny_fourth_supply_area,
                b.ny_fourth_supply_number,
                b.ny_fourth_supply_amount,
                b.ny_fourth_sale_area,
                b.ny_fourth_sale_number,
                b.ny_fourth_sale_amount,
                b.ncy_first_supply_area,
                b.ncy_first_supply_number,
                b.ncy_first_supply_amount,
                b.ncy_first_sale_area,
                b.ncy_first_sale_number,
                b.ncy_first_sale_amount,
                b.ncy_second_supply_area,
                b.ncy_second_supply_number,
                b.ncy_second_supply_amount,
                b.ncy_second_sale_area,
                b.ncy_second_sale_number,
                b.ncy_second_sale_amount,
                b.ncy_third_supply_area,
                b.ncy_third_supply_number,
                b.ncy_third_supply_amount,
                b.ncy_third_sale_area,
                b.ncy_third_sale_number,
                b.ncy_third_sale_amount,
                b.ncy_fourth_supply_area,
                b.ncy_fourth_supply_number,
                b.ncy_fourth_supply_amount,
                b.ncy_fourth_sale_area,
                b.ncy_fourth_sale_number,
                b.ncy_fourth_sale_amount,
                b.nty_first_supply_area,
                b.nty_first_supply_number,
                b.nty_first_supply_amount,
                b.nty_first_sale_area,
                b.nty_first_sale_number,
                b.nty_first_sale_amount,
                b.nty_second_supply_area,
                b.nty_second_supply_number,
                b.nty_second_supply_amount,
                b.nty_second_sale_area,
                b.nty_second_sale_number,
                b.nty_second_sale_amount,
                b.nty_third_supply_area,
                b.nty_third_supply_number,
                b.nty_third_supply_amount,
                b.nty_third_sale_area,
                b.nty_third_sale_number,
                b.nty_third_sale_amount,
                b.nty_fourth_supply_area,
                b.nty_fourth_supply_number,
                b.nty_fourth_supply_amount,
                b.nty_fourth_sale_area,
                b.nty_fourth_sale_number,
                b.nty_fourth_sale_amount,
                b.nfy_first_supply_area,
                b.nfy_first_supply_number,
                b.nfy_first_supply_amount,
                b.nfy_first_sale_area,
                b.nfy_first_sale_number,
                b.nfy_first_sale_amount,
                b.nfy_second_supply_area,
                b.nfy_second_supply_number,
                b.nfy_second_supply_amount,
                b.nfy_second_sale_area,
                b.nfy_second_sale_number,
                b.nfy_second_sale_amount,
                b.nfy_third_supply_area,
                b.nfy_third_supply_number,
                b.nfy_third_supply_amount,
                b.nfy_third_sale_area,
                b.nfy_third_sale_number,
                b.nfy_third_sale_amount,
                b.nfy_fourth_supply_area,
                b.nfy_fourth_supply_number,
                b.nfy_fourth_supply_amount,
                b.nfy_fourth_sale_area,
                b.nfy_fourth_sale_number,
                b.nfy_fourth_sale_amount
            FROM
                opm_region_inventory_plan b
            WHERE
                b.object_id = a.object_id
                AND a.plan_year = planyear
        );

END p_opm_sum_group_inventory;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_GROUP_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_OPERATING" (planyear IN number--计划年
,companyid in varchar2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】经营计划（集团总表1）-根据区域总表1汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');

END P_OPM_SUM_GROUP_OPERATING;



/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_REGION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION" (
    planyear    IN   NUMBER,
    projectid   IN   VARCHAR2
--计划年
) AS-- 根据年份按项目【汇总区域】
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN
    BEGIN
        p_opm_sum_region_cash(planyear => planyear, projectid => projectid);
--rollback; 
    END;
END p_opm_sum_region;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_REGION_CASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_CASH" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】现金流-根据附表3汇总
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
--根据年份和项目，查询该项目该年的资金预算平衡表数据。将要使用的字段合并到一列。
UPDATE OPM_REGION_CASH a
SET  (
a.REMAINING_AMOUNT,--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --OBJECT_TYPE='期末资金余额'
a.SOUR_SALES_COLLECTION,-----XXXX年资金来源计划（销售回款）
a.SOUR_COLLECTION_LOAN,-----XXXX年资金来源计划（代收款）---plan_amount>
a.SOUR_INCREASE_LOAN,-----XXXX年资金来源计划（净增贷款）---plan_amount>
a.SOUR_INVESTMENT_INPUT,-----XXXX年资金来源计划（往来投入）---plan_amount>
a.SOUR_OTHER_INPUT,-----XXXX年资金来源计划（其他投入）---plan_amount>
a.SOUR_RENTAL_INCOME,-----XXXX年资金来源计划（租金收入）---plan_amount>

a.SOUR_SHAREHOLDER_INPUT,-----XXXX年资金来源计划（股东投入）---plan_amount>
a.SOUR_TOTAL_FUNDS,-----2022年资金来源计划（资金来源合计）---plan_amount>
a.UTIL_CURRENT_EXPENDITURE,-----2022年资金运用计划（往来支出）---plan_amount>
a.UTIL_DEVELOPMENT_OVERHEAD,-----2022年资金运用计划（开发间接费）---plan_amount>
a.UTIL_ENGINEERING_EXPENDITURE,-----2022年资金运用计划（工程性支出）---plan_amount>
a.UTIL_EXPENSES_THE_PERIOD,-----2022年资金运用计划（期间费用）---plan_amount>
a.UTIL_LAND_COST,-----2022年资金运用计划（土地费用）---plan_amount>
a.UTIL_OTHER_EXPENSES,-----2022年资金运用计划（其他支出）---plan_amount>
a.UTIL_PRE_PAYMENT,-----2022年资金运用计划（代付款）---plan_amount>
a.UTIL_SUBTOTAL_FUND,-----2022年资金运用计划（资金运用小计）---plan_amount>
a.UTIL_TAXES,-----2022年资金运用计划（税金）---plan_amount>

a.cash_remaining_amount,----->2022年当年现金流情况展示窗（期末资金余额）---plan_amount>-->期末资金余额
a.CASH_AVAILABLE_FUNDS,-----2022年当年现金流情况展示窗（可动用资金）---plan_amount>--->可动用资金
a.CASH_FLOW_FUNDS-----2022年当年现金流情况展示窗（资金净流量）---plan_amount>--->资金净流量
) =
(select 

b."'年底期末资金余额'",--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --OBJECT_TYPE='期末资金余额'
b."'销售回款'",-----XXXX年资金来源计划（销售回款）
b."'代收款'",-----XXXX年资金来源计划（代收款）---plan_amount>
b."'净增贷款'",-----XXXX年资金来源计划（净增贷款）---plan_amount>
b."'往来投入'",-----XXXX年资金来源计划（往来投入）---plan_amount>
b."'其它收入'",-----XXXX年资金来源计划（其他投入）---plan_amount>--
b."'租金收入'",-----XXXX年资金来源计划（租金收入）---plan_amount>

b."'股东投入'",-----XXXX年资金来源计划（股东投入）---plan_amount>
b."'资金来源小计'",-----2022年资金来源计划（资金来源合计）---plan_amount>---
b."'往来支出'",-----2022年资金运用计划（往来支出）---plan_amount>
b."'开发间接费'",-----2022年资金运用计划（开发间接费）---plan_amount>
b."'工程性支出'",-----2022年资金运用计划（工程性支出）---plan_amount>
b."'期间费用'",-----2022年资金运用计划（期间费用）---plan_amount>
b."'土地费用'",-----2022年资金运用计划（土地费用）---plan_amount>
b."'其他支出'",-----2022年资金运用计划（其他支出）---plan_amount>
b."'代付款'",-----2022年资金运用计划（代付款）---plan_amount>
b."'资金运用小计'",-----2022年资金运用计划（资金运用小计）---plan_amount>
b."'税金'",-----2022年资金运用计划（税金）---plan_amount>

b."'期末资金余额'",----->2022年当年现金流情况展示窗（期末资金余额）---plan_amount>-->期末资金余额
b."'可动用资金'",-----2022年当年现金流情况展示窗（可动用资金）---plan_amount>--->可动用资金----
b."'资金净流量'"-----2022年当年现金流情况展示窗（资金净流量）---plan_amount>--->资金净流量
from  
(select projectid as project_id,resultdate.* from ( SELECT * FROM (SELECT OBJECT_TYPE,amount FROM 
                    (SELECT  OBJECT_TYPE, plan_amount  amount FROM OPM_PROJ_BUDGET 
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid
                          union all 
                     SELECT  '年底期末资金余额' as OBJECT_TYPE,last_cumulative_amount  amount FROM OPM_PROJ_BUDGET
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid and  OBJECT_TYPE='期末资金余额'
                    )base
            ) pivot (sum(amount) FOR OBJECT_TYPE IN ('可动用资金','年底期末资金余额','销售回款','租金收入','净增贷款','新增贷款','归还贷款','代收款','股东投入','往来投入','其它收入','资金来源小计','土地费用','工程性支出','开发间接费','期间费用','销售费用','管理费用','财务费用','税金','代付款','其他支出','往来支出','资金运用小计','资金净流量','期末资金余额','贷款监管','销售监管','其他监管')
        ))resultdate
)b     
WHERE  b.project_id = a.object_id and  a.plan_year=planyear and a.object_id=projectid);

END P_OPM_SUM_REGION_CASH;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_REGION_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_INVENTORY" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】供销存（总表3）-根据附表1汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');
UPDATE opm_region_inventory_plan a
SET  (
a.NY_FIRST_SUPPLY_AREA,
a.NY_FIRST_SUPPLY_NUMBER,
a.NY_FIRST_SUPPLY_AMOUNT,
a.NY_FIRST_SALE_AREA,
a.NY_FIRST_SALE_NUMBER,
a.NY_FIRST_SALE_AMOUNT,
a.NY_SECOND_SUPPLY_AREA,
a.NY_SECOND_SUPPLY_NUMBER,
a.NY_SECOND_SUPPLY_AMOUNT,
a.NY_SECOND_SALE_AREA,
a.NY_SECOND_SALE_NUMBER,
a.NY_SECOND_SALE_AMOUNT,
a.NY_THIRD_SUPPLY_AREA,
a.NY_THIRD_SUPPLY_NUMBER,
a.NY_THIRD_SUPPLY_AMOUNT,
a.NY_THIRD_SALE_AREA,
a.NY_THIRD_SALE_NUMBER,
a.NY_THIRD_SALE_AMOUNT,
a.NY_FOURTH_SUPPLY_AREA,
a.NY_FOURTH_SUPPLY_NUMBER,
a.NY_FOURTH_SUPPLY_AMOUNT,
a.NY_FOURTH_SALE_AREA,
a.NY_FOURTH_SALE_NUMBER,
a.NY_FOURTH_SALE_AMOUNT,
a.NCY_FIRST_SUPPLY_AREA,
a.NCY_FIRST_SUPPLY_NUMBER,
a.NCY_FIRST_SUPPLY_AMOUNT,
a.NCY_FIRST_SALE_AREA,
a.NCY_FIRST_SALE_NUMBER,
a.NCY_FIRST_SALE_AMOUNT,
a.NCY_SECOND_SUPPLY_AREA,
a.NCY_SECOND_SUPPLY_NUMBER,
a.NCY_SECOND_SUPPLY_AMOUNT,
a.NCY_SECOND_SALE_AREA,
a.NCY_SECOND_SALE_NUMBER,
a.NCY_SECOND_SALE_AMOUNT,
a.NCY_THIRD_SUPPLY_AREA,
a.NCY_THIRD_SUPPLY_NUMBER,
a.NCY_THIRD_SUPPLY_AMOUNT,
a.NCY_THIRD_SALE_AREA,
a.NCY_THIRD_SALE_NUMBER,
a.NCY_THIRD_SALE_AMOUNT,
a.NCY_FOURTH_SUPPLY_AREA,
a.NCY_FOURTH_SUPPLY_NUMBER,
a.NCY_FOURTH_SUPPLY_AMOUNT,
a.NCY_FOURTH_SALE_AREA,
a.NCY_FOURTH_SALE_NUMBER,
a.NCY_FOURTH_SALE_AMOUNT,
a.NTY_FIRST_SUPPLY_AREA,
a.NTY_FIRST_SUPPLY_NUMBER,
a.NTY_FIRST_SUPPLY_AMOUNT,
a.NTY_FIRST_SALE_AREA,
a.NTY_FIRST_SALE_NUMBER,
a.NTY_FIRST_SALE_AMOUNT,
a.NTY_SECOND_SUPPLY_AREA,
a.NTY_SECOND_SUPPLY_NUMBER,
a.NTY_SECOND_SUPPLY_AMOUNT,
a.NTY_SECOND_SALE_AREA,
a.NTY_SECOND_SALE_NUMBER,
a.NTY_SECOND_SALE_AMOUNT,
a.NTY_THIRD_SUPPLY_AREA,
a.NTY_THIRD_SUPPLY_NUMBER,
a.NTY_THIRD_SUPPLY_AMOUNT,
a.NTY_THIRD_SALE_AREA,
a.NTY_THIRD_SALE_NUMBER,
a.NTY_THIRD_SALE_AMOUNT,
a.NTY_FOURTH_SUPPLY_AREA,
a.NTY_FOURTH_SUPPLY_NUMBER,
a.NTY_FOURTH_SUPPLY_AMOUNT,
a.NTY_FOURTH_SALE_AREA,
a.NTY_FOURTH_SALE_NUMBER,
a.NTY_FOURTH_SALE_AMOUNT,
a.NFY_FIRST_SUPPLY_AREA,
a.NFY_FIRST_SUPPLY_NUMBER,
a.NFY_FIRST_SUPPLY_AMOUNT,
a.NFY_FIRST_SALE_AREA,
a.NFY_FIRST_SALE_NUMBER,
a.NFY_FIRST_SALE_AMOUNT,
a.NFY_SECOND_SUPPLY_AREA,
a.NFY_SECOND_SUPPLY_NUMBER,
a.NFY_SECOND_SUPPLY_AMOUNT,
a.NFY_SECOND_SALE_AREA,
a.NFY_SECOND_SALE_NUMBER,
a.NFY_SECOND_SALE_AMOUNT,
a.NFY_THIRD_SUPPLY_AREA,
a.NFY_THIRD_SUPPLY_NUMBER,
a.NFY_THIRD_SUPPLY_AMOUNT,
a.NFY_THIRD_SALE_AREA,
a.NFY_THIRD_SALE_NUMBER,
a.NFY_THIRD_SALE_AMOUNT,
a.NFY_FOURTH_SUPPLY_AREA,
a.NFY_FOURTH_SUPPLY_NUMBER,
a.NFY_FOURTH_SUPPLY_AMOUNT,
a.NFY_FOURTH_SALE_AREA,
a.NFY_FOURTH_SALE_NUMBER,
a.NFY_FOURTH_SALE_AMOUNT
) =
       (SELECT 
b.NY_FIRST_SUPPLY_AREA,
b.NY_FIRST_SUPPLY_NUMBER,
b.NY_FIRST_SUPPLY_AMOUNT,
b.NY_FIRST_SALE_AREA,
b.NY_FIRST_SALE_NUMBER,
b.NY_FIRST_SALE_AMOUNT,
b.NY_SECOND_SUPPLY_AREA,
b.NY_SECOND_SUPPLY_NUMBER,
b.NY_SECOND_SUPPLY_AMOUNT,
b.NY_SECOND_SALE_AREA,
b.NY_SECOND_SALE_NUMBER,
b.NY_SECOND_SALE_AMOUNT,
b.NY_THIRD_SUPPLY_AREA,
b.NY_THIRD_SUPPLY_NUMBER,
b.NY_THIRD_SUPPLY_AMOUNT,
b.NY_THIRD_SALE_AREA,
b.NY_THIRD_SALE_NUMBER,
b.NY_THIRD_SALE_AMOUNT,
b.NY_FOURTH_SUPPLY_AREA,
b.NY_FOURTH_SUPPLY_NUMBER,
b.NY_FOURTH_SUPPLY_AMOUNT,
b.NY_FOURTH_SALE_AREA,
b.NY_FOURTH_SALE_NUMBER,
b.NY_FOURTH_SALE_AMOUNT,
b.NCY_FIRST_SUPPLY_AREA,
b.NCY_FIRST_SUPPLY_NUMBER,
b.NCY_FIRST_SUPPLY_AMOUNT,
b.NCY_FIRST_SALE_AREA,
b.NCY_FIRST_SALE_NUMBER,
b.NCY_FIRST_SALE_AMOUNT,
b.NCY_SECOND_SUPPLY_AREA,
b.NCY_SECOND_SUPPLY_NUMBER,
b.NCY_SECOND_SUPPLY_AMOUNT,
b.NCY_SECOND_SALE_AREA,
b.NCY_SECOND_SALE_NUMBER,
b.NCY_SECOND_SALE_AMOUNT,
b.NCY_THIRD_SUPPLY_AREA,
b.NCY_THIRD_SUPPLY_NUMBER,
b.NCY_THIRD_SUPPLY_AMOUNT,
b.NCY_THIRD_SALE_AREA,
b.NCY_THIRD_SALE_NUMBER,
b.NCY_THIRD_SALE_AMOUNT,
b.NCY_FOURTH_SUPPLY_AREA,
b.NCY_FOURTH_SUPPLY_NUMBER,
b.NCY_FOURTH_SUPPLY_AMOUNT,
b.NCY_FOURTH_SALE_AREA,
b.NCY_FOURTH_SALE_NUMBER,
b.NCY_FOURTH_SALE_AMOUNT,
b.NTY_FIRST_SUPPLY_AREA,
b.NTY_FIRST_SUPPLY_NUMBER,
b.NTY_FIRST_SUPPLY_AMOUNT,
b.NTY_FIRST_SALE_AREA,
b.NTY_FIRST_SALE_NUMBER,
b.NTY_FIRST_SALE_AMOUNT,
b.NTY_SECOND_SUPPLY_AREA,
b.NTY_SECOND_SUPPLY_NUMBER,
b.NTY_SECOND_SUPPLY_AMOUNT,
b.NTY_SECOND_SALE_AREA,
b.NTY_SECOND_SALE_NUMBER,
b.NTY_SECOND_SALE_AMOUNT,
b.NTY_THIRD_SUPPLY_AREA,
b.NTY_THIRD_SUPPLY_NUMBER,
b.NTY_THIRD_SUPPLY_AMOUNT,
b.NTY_THIRD_SALE_AREA,
b.NTY_THIRD_SALE_NUMBER,
b.NTY_THIRD_SALE_AMOUNT,
b.NTY_FOURTH_SUPPLY_AREA,
b.NTY_FOURTH_SUPPLY_NUMBER,
b.NTY_FOURTH_SUPPLY_AMOUNT,
b.NTY_FOURTH_SALE_AREA,
b.NTY_FOURTH_SALE_NUMBER,
b.NTY_FOURTH_SALE_AMOUNT,
b.NFY_FIRST_SUPPLY_AREA,
b.NFY_FIRST_SUPPLY_NUMBER,
b.NFY_FIRST_SUPPLY_AMOUNT,
b.NFY_FIRST_SALE_AREA,
b.NFY_FIRST_SALE_NUMBER,
b.NFY_FIRST_SALE_AMOUNT,
b.NFY_SECOND_SUPPLY_AREA,
b.NFY_SECOND_SUPPLY_NUMBER,
b.NFY_SECOND_SUPPLY_AMOUNT,
b.NFY_SECOND_SALE_AREA,
b.NFY_SECOND_SALE_NUMBER,
b.NFY_SECOND_SALE_AMOUNT,
b.NFY_THIRD_SUPPLY_AREA,
b.NFY_THIRD_SUPPLY_NUMBER,
b.NFY_THIRD_SUPPLY_AMOUNT,
b.NFY_THIRD_SALE_AREA,
b.NFY_THIRD_SALE_NUMBER,
b.NFY_THIRD_SALE_AMOUNT,
b.NFY_FOURTH_SUPPLY_AREA,
b.NFY_FOURTH_SUPPLY_NUMBER,
b.NFY_FOURTH_SUPPLY_AMOUNT,
b.NFY_FOURTH_SALE_AREA,
b.NFY_FOURTH_SALE_NUMBER,
b.NFY_FOURTH_SALE_AMOUNT
        FROM   OPM_PROJ_INVENTORY_PLAN b
        WHERE  b.object_id = a.object_id
        AND    a.plan_year=planyear);
END P_OPM_SUM_REGION_INVENTORY;

/
--------------------------------------------------------
--  DDL for Procedure P_OPM_SUM_REGION_OPERATING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_OPERATING" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】经营计划（总表1）-根据附表4、附表2汇总
-- 注意：
--作者： 王一博负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');
END P_OPM_SUM_REGION_OPERATING;


/
--------------------------------------------------------
--  DDL for Procedure P_OPM_TREE_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_OPM_TREE_LIST" (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    orgtype          IN               VARCHAR2,
    orgid          IN                  VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
    --获取有权限的公司树
    ruleValue   VARCHAR2(50);
    ruleOrgId        VARCHAR2(36);--使用临时表的批次号
    orgIdValue   VARCHAR2(500);
BEGIN
    SELECT isolation_rule_value INTO rulevalue FROM sys_data_auth_biz WHERE biz_obj_code = bizcode;
    if orgid is null then
        orgIdValue := '003200000000000000000000000000';
    end if;
    if orgid is not null then
        orgIdValue := orgid;
    end if;
    if ruleValue = '全集团' then
        ruleOrgId := '003200000000000000000000000000';
    end if;
    if ruleValue = '本公司' then
        ruleOrgId := companyId;
    end if;
    if ruleValue = '本部门' then
        ruleOrgId := deptid;
    end if;
    
    if orgtype = '0' then
            open data_auth_info for with t1 as (
        -- 获取所有权限公司id
        select *
        from SYS_DATA_AUTH sda
        where instr(userId||','|| stationId || ',' || deptId || ',' || companyId, sda.AUTH_OWNER_ID) > 0
          and nvl(sda.AUTH_TYPE, '项目') = '项目' and sda.AUTH_BIZ_CODE=bizCode
    ), t2 as (
        -- 加上隔离规则id
        select AUTH_SCOPE_ID from t1
        union
        select ruleOrgId from dual
    ), t3 as (
        -- 查询公司的下面所有子公司
        select distinct *
        from SYS_BUSINESS_UNIT sbu
        where IS_COMPANY = 1
        start with sbu.id in (select AUTH_SCOPE_ID from t2)
        connect by prior sbu.id = sbu.PARENT_ID
    )
    ,t31 as (
        -- 查询公司的下面所有子公司
        select distinct *
        from SYS_BUSINESS_UNIT sbu
        where IS_COMPANY = 1
        start with sbu.id in (select ID from t3 where t3.ID = orgIdValue )
        connect by prior sbu.id = sbu.PARENT_ID
    )
    ,t4 as (
        --查询项目不为空的公司ID
        select  distinct mp.id mid, mp.PROJECT_NAME, mp.UNIT_ID mParentId,
            nvl(mp.ORDER_HIERARCHY_CODE, mp.PROJECT_CODE)  as pCode,
            t31.*
        from t31 left join SYS_PROJECT mp on t31.ID = mp.UNIT_ID
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
    end if;
    if orgtype = '10' then
            open data_auth_info for with t1 as (
        -- 获取所有权限公司id
        select *
        from SYS_DATA_AUTH sda
        where instr(userId||','|| stationId || ',' || deptId || ',' || companyId, sda.AUTH_OWNER_ID) > 0
          and nvl(sda.AUTH_TYPE, '项目') = '项目' and sda.AUTH_BIZ_CODE=bizCode
    ), t2 as (
        -- 加上隔离规则id
        select AUTH_SCOPE_ID from t1
        union
        select ruleOrgId from dual
    ), t3 as (
        -- 查询公司的下面所有子公司
        select distinct *
        from SYS_BUSINESS_UNIT sbu
        where IS_COMPANY = 1
        start with sbu.id in (select AUTH_SCOPE_ID from t2)
        connect by prior sbu.id = sbu.PARENT_ID
    )
    ,t31 as (
        -- 查询公司的下面所有子公司
        select distinct *
        from SYS_BUSINESS_UNIT sbu
        where IS_COMPANY = 1
        start with sbu.id in (select ID from t3 where t3.ID = orgid )
        connect by prior sbu.id = sbu.PARENT_ID
    )
    ,t4 as (
        --查询项目不为空的公司ID
        select  distinct mp.id mid, mp.PROJECT_NAME, mp.UNIT_ID mParentId,
            nvl(mp.ORDER_HIERARCHY_CODE, mp.PROJECT_CODE)  as pCode,
            t3.*
        from t3 left join SYS_PROJECT mp on t3.ID = mp.UNIT_ID
        where mp.id = orgIdValue
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
    end if;

END P_OPM_TREE_LIST;

/
