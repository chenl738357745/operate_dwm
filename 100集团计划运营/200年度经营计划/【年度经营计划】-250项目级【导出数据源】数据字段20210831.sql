create or replace PROCEDURE "P_OPM_FIELD_PROJ" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
projectid IN VARCHAR2,--������Ŀid
planyear in number,--�ƻ���
Sheetsfields OUT SYS_REFCURSOR--�ֶ�2����
) AS 
currentYear_MinusFour   VARCHAR2(500):=to_char(planyear-4); 
    currentYear_MinusThree   VARCHAR2(500):=to_char(planyear-3); 
    currentYear_MinusTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_MinusOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear   VARCHAR2(50):=to_char(planyear);--��ǰ��
    currentYear_AddOne  VARCHAR2(36):=to_char(planyear+1);
    currentYear_AddTwo   VARCHAR2(500):=to_char(planyear+2);
    currentYear_AddThree   VARCHAR2(500):=to_char(planyear+3);  
    currentYear_AddFour   VARCHAR2(500):=to_char(planyear+4);  
BEGIN
OPEN Sheetsfields FOR 
---------------------------------sheet1
with projsheet1 as  (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet1'  and EXCEL_TYPE='����'
)
---------------------------------sheet2

,base AS (
 SELECT object_id,object_name,object_level_name_two,object_level_name_one,ORDER_CODE 
 FROM opm_proj_investment_plan WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid
)
,base���� as (select object_level_name_two as id,object_level_name_two,object_level_name_one,'' as parentid from base where object_level_name_two is not null group by  object_level_name_two,object_level_name_one )
,baseһ�� as (select object_level_name_one as id,object_level_name_one,'' as parentid from base where object_level_name_one is not null group by  object_level_name_one)

,ĩ�� as (select base.object_id  as id,base.object_name, base����.id as parentid,ORDER_CODE  from base
left join base���� on base.object_level_name_two=base����.object_level_name_two)
,���� as (select base����.id,base����.object_level_name_two, baseһ��.id as parentid,'999' ORDER_CODE  from base����
left join baseһ�� on baseһ��.object_level_name_one=base����.object_level_name_one)
,һ�� as (select id,object_level_name_one,parentid,'9999' ORDER_CODE from baseһ��)
,projsheet2_resultdata as (
select ĩ��.* from ĩ�� union all select ����.* from ���� union all select һ��.* from һ��
)
,projsheet2 as (
select 'projsheet2' AS "sheetID",level AS "fieldLevel",0 AS "isHide",connect_by_isleaf AS "isEnd"
       ,'PALE_BLUE' AS "headerBgColor"
       ,'GREY_80_PERCENT' AS "headerFontColor"
       ,id AS "fieldId"
       ,object_name AS "lable"
       ,object_name AS "field"
       ,'aout' AS "width"
       ,'aout' AS "align"
       ,'#,##0.00' AS "dataFormat"
       ,'1'||order_code AS "fieldOrder"
       ,parentid AS "parentId"
       ,'center' AS "textAlign"
       ,0 AS "isColumnMerge" 
  from projsheet2_resultdata t
 start with t.parentid is null --��ʼ����
connect by prior id = t.parentid --�ݹ�����
union all
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet2' and EXCEL_TYPE='����'
)

--��� ��Ŀ����	��Ŀ����				
---------------------------------sheet3
,projsheet3 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet3' and EXCEL_TYPE='����'
)
---------------------------------sheet4
,projsheet4 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" 
FROM OPM_EXCEL_FILED WHERE SHEET_ID='projsheet4'  and EXCEL_TYPE='����'
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
from resultdata order by  lpad("fieldOrder",20,'0');
END P_OPM_FIELD_PROJ;