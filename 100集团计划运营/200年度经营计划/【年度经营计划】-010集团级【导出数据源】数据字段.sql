--create or replace PROCEDURE "P_OPM_ED_GROUP_INVENTORY" (
--userid IN VARCHAR2,--当前用户id
--stationid IN VARCHAR2,--当前用户岗位id
--departmentid IN VARCHAR2,--当前用户部门id
--companyid IN VARCHAR2,--当前用户公司id
--planyear in number,--计划年
--groupsheet3 OUT SYS_REFCURSOR--2、sheet3 供销存
--) AS
---- 
----- 注意：
-----1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
-----2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
-----3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
----作者：chenl
----日期：2021/08/24
--begin
--OPEN groupsheet3 FOR 
--SELECT 1 from dual;
--
--END P_OPM_ED_GROUP_INVENTORY;
--/
--create or replace PROCEDURE "P_OPM_ED_GROUP_OPERATING" (
--userid IN VARCHAR2,--当前用户id
--stationid IN VARCHAR2,--当前用户岗位id
--departmentid IN VARCHAR2,--当前用户部门id
--companyid IN VARCHAR2,--当前用户公司id
--planyear in number,--计划年
--groupsheet1 OUT SYS_REFCURSOR--2、sheet1 经营计划
--) AS
---- 
----- 注意：
-----1、每个sheet页输出数据变量，必须使用P_OPM_ES_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
-----2、返回结果列字段名称，必须与P_OPM_ES_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
-----3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
----作者：chenl
----日期：2021/08/24
--begin
--OPEN groupsheet1 FOR 
--SELECT 1 from dual;
--
--END P_OPM_ED_GROUP_OPERATING;
--
--/
create or replace PROCEDURE "P_OPM_ED_GROUP_CASH" (
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
create or replace PROCEDURE "P_OPM_FIELD_GROUP" (
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
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet1'  and EXCEL_TYPE='总表'
)
---------------------------------sheet2
,groupsheet2 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet2'  and EXCEL_TYPE='总表'
)
,groupsheet3 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet3'  and EXCEL_TYPE='总表'
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
from resultdata order by  lpad("fieldOrder",20,'0');

END P_OPM_FIELD_GROUP;