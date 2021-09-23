create or replace PROCEDURE "P_OPM_ES_PROJ" (
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
Select 'projsheet1' "sheetID",'附表1-项目供销存计划表（示例，线上直接导出）' "sheetName",'集团公司2021年度供销存计划明细分解表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,5 As "frozenRowindex",3 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet2' "sheetID",'附表2-项目投资计划表' "sheetName",'              公司       项目 '||planyear||' 年度房地产开发项目投资计划表' "topDescription",'DARK_TEAL' "headerBgColor",'PALE_BLUE' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,5 As "frozenRowindex",2 As "frozenColumnindex",'GREY_25_PERCENT' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet3' "sheetID",'附表3-项目资金预算平衡表' "sheetName",'项目2022年度资金预算平衡表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow",5 As "frozenRowindex",5 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet4' "sheetID",'附表4-项目经营指标汇总表+分期总建面' "sheetName",'项目经营指标汇总表' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",4 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow",5 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual
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