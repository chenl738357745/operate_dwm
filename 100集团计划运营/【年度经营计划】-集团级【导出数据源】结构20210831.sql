SET DEFINE OFF;
DECLARE--functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 (100) :='ca4a7fbe-6e92-1f87-e053-0100007fa705'; 
d_table_dataSource_procedure VARCHAR2 (100) :='ca4a7fbe-6e94-1f87-e053-0100007fa705'; 
d_createName VARCHAR2 (100) :='chenl' || d_table_dataSource; 

d_table_dataSource1 VARCHAR2 (100) :='ca4a7fbe-6e92-1f88-e053-0100007fa705'; 
d_table_dataSource_procedure1 VARCHAR2 (100) :='ca4a7fbe-6e94-1f88-e053-0100007fa705'; 
d_createName1 VARCHAR2 (100) :='chenl' || d_table_dataSource1; 

-----------------
--select * from udp_procedure_registration where code='STRUCT_GROUP'
------------------

BEGIN
----- 先删除注册数据
DELETE FROM udp_component_data_source WHERE CREATOR=d_createName; commit;-->提交数据源注册
DELETE FROM udp_procedure_registration WHERE CREATOR=d_createName; commit;-->提交数据
DELETE FROM udp_procedure_parameter WHERE CREATOR=d_createName;---数据源注册
------ 插入
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource,'STRUCT_GROUP','procedure','','','id','',d_createName);---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure,'P_OPM_EXCEL_STRUCT_GROUP','STRUCT_GROUP',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'userid','本人','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'stationid','本岗位','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'departmentid','本部门','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'companyid','本公司','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'planyear','planyear','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'excel','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheets','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsFields','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsStyle','','',d_createName);

----- 先删除注册数据
DELETE FROM udp_component_data_source WHERE CREATOR=d_createName1; commit;-->提交数据源注册
DELETE FROM udp_procedure_registration WHERE CREATOR=d_createName1; commit;-->提交数据
DELETE FROM udp_procedure_parameter WHERE CREATOR=d_createName1;---数据源注册
------ 插入
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource1,'DATA_GROUP','procedure','','','id','',d_createName1);---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure1,'P_OPM_EXCEL_DATA_GROUP','DATA_GROUP',1,d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'userid','本人','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'stationid','本岗位','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'departmentid','本部门','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'companyid','本公司','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'planyear','planyear','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet1','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet2','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet3','','',d_createName1);
END;
/
create or replace PROCEDURE "P_OPM_EXCEL_STRUCT_GROUP" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
excel OUT SYS_REFCURSOR,--excel信息
sheets OUT SYS_REFCURSOR,--1、sheet页集合 【根据集合顺序】
sheetsFields OUT SYS_REFCURSOR,--2、sheet页的表头集合
sheetsStyle OUT SYS_REFCURSOR--3、sheet页的样式
) AS
-- operate plan 经营计划-集团级导出结构定义  sheetID 不允许调整，用于sheet列、获取sheet页数据建立关联；
-- 注意：列分组是按复合表头来分组。https://blog.csdn.net/lipinganq/article/details/53560931?locationNum=10&fps=1
--作者：chenl
--日期：2021/08/24 https://blog.csdn.net/qq_27937043/article/details/72779442/
  FIELDSINFO SYS_REFCURSOR;
begin
--- 0、excel
Open excel For 
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "excelName" from dual;
--- 1、sheet页集合 
---Select 'groupsheet1' "sheetID",'总表1-集团、区域经营计划汇总表 +利润总额+回正时间2个' "seetName",'' "excelTitle",'表头背景颜色' "headerBgColor",'表头字体颜色' "HeaderFontColor",1 "SheetOrder",'是否使用行收折' "IsUseRowCollapse",'是否默认收折行' "IsDefaultCollapseRow" From Dual
Open Sheets For 
With Base As(
Select 'groupsheet1' "sheetID",'总表1-集团经营计划汇总表 +利润总额+回正时间2个' "sheetName",'2022集团经营计划汇总表' "topDescription",'SEA_GREEN' "headerBgColor",'LIGHT_YELLOW' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" From Dual
Union All
Select 'groupsheet2' "sheetID",'总表2-集团现金流合计表' "sheetName",'2022年度各子公司动态现金流表' "topDescription",'DARK_TEAL' "headerBgColor",'LIGHT_GREEN' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" From Dual
Union All
Select 'groupsheet3' "sheetID",'总表3-供销存计划表（示例，线上直接导出）' "sheetName",'集团公司2021年度供销存计划明细分解表' "topDescription",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow" From Dual
)
Select * From Base Order By "sheetOrder";
--- 2、sheet页的表头集合
---SELECT 'groupsheet1' "sheetID", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "wide",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并' "isColumnMerge"  From Dual
BEGIN P_OPM_FIELDS_GROUP (USERID=> USERID,STATIONID=> STATIONID,DEPARTMENTID=> DEPARTMENTID,COMPANYID=> COMPANYID,PLANYEAR=> PLANYEAR,Sheetsfields=> Sheetsfields); END;

--- 3、sheet页的数据开始行集合
----Select 'groupsheet1' "sheetID",'开始索引（1开始）' "beginIndex",'冻结行索引' As "trozenRowindex",'冻结列索引' As "frozenColumnindex" From Dual
Open Sheetsstyle For 
Select 'groupsheet1' "sheetID",4 "beginIndex",2 As "trozenRowindex",3 As "frozenColumnindex" From Dual
Union All 
Select 'groupsheet2' "sheetID",4 "beginIndex",2 As "trozenRowindex",3 As "frozenColumnindex" From Dual
Union All 
Select 'groupsheet3' Sheetid,4 "beginIndex",2 As "trozenRowindex",3 As "frozenColumnindex" From Dual
; 
END P_OPM_EXCEL_STRUCT_GROUP;
/
create or replace PROCEDURE "P_OPM_EXCEL_DATA_GROUP" (
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
---1、每个sheet页输出数据变量，必须使用P_OPM_EXCEL_STRUCT_GROUP中定义的sheetId命名一致；//程序逻辑约定，用于关联sheet页与sheet页的数据建立关系。
---2、返回结果列字段名称，必须与P_OPM_EXCEL_STRUCT_GROUP中Sheetsfields返回的sheetId的字段名一致；//程序逻辑约定,用于表头与数据对应。
---3、父级id字段命名 parent_id，层级命名 row_level，必须按此命名。//程序逻辑约定，用于行分组。
--作者：chenl
--日期：2021/08/24
begin
--- group_sheet1
OPEN groupsheet1 FOR 
select 'groupsheet1序号' as "groupsheet1序号" from dual;
--- group_sheet2
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
--- group_sheet3
OPEN groupsheet3 FOR 
select 'groupsheet3序号' as "groupsheet3序号" from dual;

END P_OPM_EXCEL_DATA_GROUP;
------------------------------------------------
/
create or replace PROCEDURE "P_OPM_FIELDS_GROUP" (
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
--日期：2021/08/24
---事例 SELECT 'sheet页id，使用P_OPM_EXCEL_STRUCT_GROUP中定义的sheetId，不允许改变' "sheetID",1 "fieldLevel",0 "isHide",是否墨迹字段 "isEnd", '字段id' "fieldId",'字段中文名' "lable",'字段名称' "field",'宽度' "width",'对齐方式' "align",'单元格格式（常规、数字、百分比）' "dataType",'列排序（列顺序）' "fieldOrder",'父级字段Id' "parentId",'对齐方式(left、right、center)' "textAlign",'同内容合并（1合并，0不合并）' "isColumnMerge"  From Dual
begin
OPEN Sheetsfields FOR 
---必须层
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", 'groupsheet2ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT 'groupsheet1' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", '层级' "fieldId",'层级' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---------------------------------sheet2
---第一层
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",1 "isHide",1 "isEnd", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", 'groupsheet2序号id' "fieldId",'序号' "lable",'groupsheet2序号' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd",'城市/项目名称' "fieldId",'城市/项目名称' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",0 "isEnd",'2021年集团（区域）动态现金流' "fieldId",planyear||'年集团（区域）动态现金流' "lable",'2021年集团（区域）动态现金流' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---第二层
union all
SELECT 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd", '截至2021年底' "fieldId",'截至'||to_char(planyear-1)||'年底' "lable",'截至2021年底' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022年资金来源计划' "fieldId",planyear||'年资金来源计划' "lable",'2022年资金来源计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022年资金运用计划' "fieldId",planyear||'年资金运用计划' "lable",'2022年资金运用计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022年当年现金流情况展示窗' "fieldId",planyear||'年当年现金流情况展示窗' "lable",'2022年当年现金流情况展示窗' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---第三层
union all
SELECT 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd", '2021年底-期末资金余额' "fieldId",'2021年底-期末资金余额' "lable",'年底-期末资金余额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'截至2021年底' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'销售回款' "fieldId",'销售回款' "lable",'销售回款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'租金收入' "fieldId",'租金收入' "lable",'租金收入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",310 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'净增贷款' "fieldId",'净增贷款' "lable",'净增贷款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",410 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'代收款' "fieldId",'代收款' "lable",'代收款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",510 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'股东投入' "fieldId",'股东投入' "lable",'股东投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",610 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'往来投入' "fieldId",'往来投入' "lable",'往来投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'其他投入' "fieldId",'其他投入' "lable",'其他投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'资金来源合计' "fieldId",'资金来源合计' "lable",'资金来源合计' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'土地费用' "fieldId",'土地费用' "lable",'土地费用' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'工程性支出' "fieldId",'工程性支出' "lable",'工程性支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1110 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'开发间接费' "fieldId",'开发间接费' "lable",'开发间接费' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1210 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'期间费用' "fieldId",'期间费用' "lable",'期间费用' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1310 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'税金' "fieldId",'税金' "lable",'税金' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1410 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'代付款' "fieldId",'代付款' "lable",'代付款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1510 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'其他支出' "fieldId",'其他支出' "lable",'其他支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1610 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'往来支出' "fieldId",'往来支出' "lable",'往来支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1710 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'资金运用小计' "fieldId",'资金运用小计' "lable",'资金运用小计' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1810 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'资金净流量' "fieldId",'资金净流量' "lable",'资金净流量' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1910 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'展示窗-期末资金余额' "fieldId",'期末资金余额' "lable",'展示窗-期末资金余额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2010 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'可动用资金' "fieldId",'可动用资金' "lable",'可动用资金' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2110 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---------------------------------sheet3
union all
Select 'groupsheet3' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd",'groupsheet3序号id' "fieldId",'序号' "lable",'groupsheet3序号' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
;
END P_OPM_FIELDS_GROUP;
