SET DEFINE OFF;
DECLARE--functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 (100) :='cb75fa62-f53f-1f4b-e053-0100007f29d7'; 
d_table_dataSource_procedure VARCHAR2 (100) :='cb75fa62-f540-1f4b-e053-0100007f29d7'; 
d_createName VARCHAR2 (100) :='chenl' || d_table_dataSource; 

d_table_dataSource1 VARCHAR2 (100) :='cb75fa62-f541-1f4b-e053-0100007f29d7'; 
d_table_dataSource_procedure1 VARCHAR2 (100) :='cb75fa62-f542-1f4b-e053-0100007f29d7'; 
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
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource,'STRUCT_REGION','procedure','','','id','',d_createName);---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure,'P_OPM_ES_REGION','STRUCT_REGION',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'userid','本人','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'stationid','本岗位','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'departmentid','本部门','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'companyid','本公司','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'planyear','planyear','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'regionCompanyId','regionCompanyId','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'excel','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheets','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsFields','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsStyle','','',d_createName);

----- 先删除注册数据
DELETE FROM udp_component_data_source WHERE CREATOR=d_createName1; commit;-->提交数据源注册
DELETE FROM udp_procedure_registration WHERE CREATOR=d_createName1; commit;-->提交数据
DELETE FROM udp_procedure_parameter WHERE CREATOR=d_createName1;---数据源注册
------ 插入
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource1,'DATA_REGION','procedure','','','id','',d_createName1);---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure1,'P_OPM_ED_REGION','DATA_REGION',1,d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'userid','本人','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'stationid','本岗位','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'departmentid','本部门','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'companyid','本公司','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'planyear','planyear','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'regionCompanyId','regionCompanyId','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet1','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet2','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet3','','',d_createName1);
END;
/

create or replace PROCEDURE "P_OPM_ES_REGION" (
userid IN VARCHAR2,--当前用户id
stationid IN VARCHAR2,--当前用户岗位id
departmentid IN VARCHAR2,--当前用户部门id
companyid IN VARCHAR2,--当前用户公司id
planyear in number,--计划年
regionCompanyId in VARCHAR2,---计划区域公司
excel OUT SYS_REFCURSOR,--excel信息
sheets OUT SYS_REFCURSOR,--1、sheet页集合 【根据集合顺序】
sheetsFields OUT SYS_REFCURSOR,--2、sheet页的表头集合
sheetsStyle OUT SYS_REFCURSOR--3、sheet页的样式
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
BEGIN P_OPM_FIELD_GROUP (USERID=> USERID,STATIONID=> STATIONID,DEPARTMENTID=> DEPARTMENTID,COMPANYID=> COMPANYID,PLANYEAR=> PLANYEAR,Sheetsfields=> Sheetsfields); END;
--- 3、sheet页的样式
----Select 'groupsheet1' "sheetID",'冻结行索引' As "trozenRowindex",'冻结列索引' As "frozenColumnindex" From Dual
Open Sheetsstyle For 
Select 'groupsheet1' "sheetID",2 As "frozenRowindex",3 As "frozenColumnindex" From Dual
Union All 
Select 'groupsheet2' "sheetID",2 As "frozenRowindex",3 As "frozenColumnindex" From Dual
Union All 
Select 'groupsheet3' Sheetid,2 As "frozenRowindex",3 As "frozenColumnindex" From Dual
; 
END P_OPM_ES_REGION;
/
create or replace PROCEDURE "P_OPM_ED_REGION" (
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

