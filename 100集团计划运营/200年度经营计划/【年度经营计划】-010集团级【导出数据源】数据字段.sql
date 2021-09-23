--create or replace PROCEDURE "P_OPM_ED_GROUP_INVENTORY" (
--userid IN VARCHAR2,--��ǰ�û�id
--stationid IN VARCHAR2,--��ǰ�û���λid
--departmentid IN VARCHAR2,--��ǰ�û�����id
--companyid IN VARCHAR2,--��ǰ�û���˾id
--planyear in number,--�ƻ���
--groupsheet3 OUT SYS_REFCURSOR--2��sheet3 ������
--) AS
---- 
----- ע�⣺
-----1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_GROUP�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
-----2�����ؽ�����ֶ����ƣ�������P_OPM_ES_GROUP��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
-----3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
----���ߣ�chenl
----���ڣ�2021/08/24
--begin
--OPEN groupsheet3 FOR 
--SELECT 1 from dual;
--
--END P_OPM_ED_GROUP_INVENTORY;
--/
--create or replace PROCEDURE "P_OPM_ED_GROUP_OPERATING" (
--userid IN VARCHAR2,--��ǰ�û�id
--stationid IN VARCHAR2,--��ǰ�û���λid
--departmentid IN VARCHAR2,--��ǰ�û�����id
--companyid IN VARCHAR2,--��ǰ�û���˾id
--planyear in number,--�ƻ���
--groupsheet1 OUT SYS_REFCURSOR--2��sheet1 ��Ӫ�ƻ�
--) AS
---- 
----- ע�⣺
-----1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_GROUP�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
-----2�����ؽ�����ֶ����ƣ�������P_OPM_ES_GROUP��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
-----3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
----���ߣ�chenl
----���ڣ�2021/08/24
--begin
--OPEN groupsheet1 FOR 
--SELECT 1 from dual;
--
--END P_OPM_ED_GROUP_OPERATING;
--
--/
create or replace PROCEDURE "P_OPM_ED_GROUP_CASH" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
groupsheet2 OUT SYS_REFCURSOR--2��sheetҳ������Դ���� �����ݼ���˳��
) AS
-- operate plan ��Ӫ�ƻ�-���ż����������ݡ�
--- ע�⣺
---1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_GROUP�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
---2�����ؽ�����ֶ����ƣ�������P_OPM_ES_GROUP��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
---3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
--���ߣ�chenl
--���ڣ�2021/08/24
begin
OPEN groupsheet2 FOR 
SELECT
ID as "id",--- ����  
LEVEL_CODE,--- �㼶��1��ʼ
--OBJECT_ID,--- ����ID
OBJECT_NAME,--- �������ƣ�����/��Ŀ���ƣ�
--OBJECT_TYPE,--- ���ͣ���˾����Ŀ�����˾�����»�ȡ��Ŀ���ܼƣ�
--ORDER_CODE,--- ˳��
PARENT_ID,--- ����ID
PLAN_YEAR,--- �ƻ����
NVL(FMA_AVAILABLE_FUNDS,CASH_AVAILABLE_FUNDS) as "�ɶ����ʽ�",--- 2022�굱���ֽ������չʾ�����ɶ����ʽ�
NVL(fma_flow_funds,CASH_FLOW_FUNDS) as "�ʽ�����",--- 2022�굱���ֽ������չʾ�����ʽ�������
NVL(FMA_CASH_REMAINING_AMOUNT,CASH_REMAINING_AMOUNT) as "չʾ��-��ĩ�ʽ����",--- 2022�굱���ֽ������չʾ������ĩ�ʽ���
NVL(FMA_REMAINING_AMOUNT,REMAINING_AMOUNT) as "���-��ĩ�ʽ����",--- ����XXXX��ף���ĩ�ʽ�����ȥ�꣩
NVL(FMA_COLLECTION_LOAN,SOUR_COLLECTION_LOAN) as "���տ�",--- XXXX���ʽ���Դ�ƻ������տ
NVL(FMA_INCREASE_LOAN,SOUR_INCREASE_LOAN) as "��������",--- XXXX���ʽ���Դ�ƻ����������
NVL(FMA_INVESTMENT_INPUT,SOUR_INVESTMENT_INPUT) as "����Ͷ��",--- XXXX���ʽ���Դ�ƻ�������Ͷ�룩
NVL(FMA_OTHER_INPUT,SOUR_OTHER_INPUT) as "����Ͷ��",--- XXXX���ʽ���Դ�ƻ�������Ͷ�룩
NVL(FMA_RENTAL_INCOME,SOUR_RENTAL_INCOME) as "�������",--- XXXX���ʽ���Դ�ƻ���������룩
NVL(FMA_SALES_COLLECTION,SOUR_SALES_COLLECTION)as "���ۻؿ�",--- XXXX���ʽ���Դ�ƻ������ۻؿ
NVL(fma_shareholder_input,SOUR_SHAREHOLDER_INPUT)as "�ɶ�Ͷ��",--- XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩
NVL(fma_total_source_funds,SOUR_TOTAL_FUNDS) as "�ʽ���Դ�ϼ�",--- 2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�
NVL(FMA_CURRENT_EXPENDITURE,UTIL_CURRENT_EXPENDITURE) as "����֧��",--- 2022���ʽ����üƻ�������֧����
NVL(FMA_DEVELOPMENT_OVERHEAD,UTIL_DEVELOPMENT_OVERHEAD) as "������ӷ�",--- 2022���ʽ����üƻ���������ӷѣ�
NVL(fma_engineering_expenditure,UTIL_ENGINEERING_EXPENDITURE) as "������֧��",--- 2022���ʽ����üƻ���������֧����
NVL(FMA_EXPENSES_THE_PERIOD,UTIL_EXPENSES_THE_PERIOD)as "�ڼ����",--- 2022���ʽ����üƻ����ڼ���ã�
NVL(FMA_LAND_COST,UTIL_LAND_COST) as "���ط���",--- 2022���ʽ����üƻ������ط��ã�
NVL(FMA_OTHER_EXPENSES,UTIL_OTHER_EXPENSES) as "����֧��",--- 2022���ʽ����üƻ�������֧����
NVL(FMA_PRE_PAYMENT,UTIL_PRE_PAYMENT) as "������",--- 2022���ʽ����üƻ��������
NVL(fma_subtotal_Fund,UTIL_SUBTOTAL_FUND) as "�ʽ�����С��",--- 2022���ʽ����üƻ����ʽ�����С�ƣ�
NVL(fma_taxes,UTIL_TAXES) as "˰��"--- 2022���ʽ����üƻ���˰��
FROM    opm_group_cash where PLAN_YEAR=planyear order by LPAD(order_code,10,'0');
END P_OPM_ED_GROUP_CASH;
------------------------------------------------
/
create or replace PROCEDURE "P_OPM_FIELD_GROUP" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
Sheetsfields OUT SYS_REFCURSOR--�ֶ�2����
) AS
---CREATE OR REPLACE FORCE VIEW "V_OPM_GROUP_FIELDS"  AS 
-- operate plan ��Ӫ�ƻ�-���ż���������sheetҳ�ֶε������壻
---ע�⣺
---1��fieldֵͬsheetҳΨһ;//���򵼳�����Ψһʶ���еı�ʶ��
---2��fieldIdֵͬsheetҳΨһ;//���ڽ������ϱ�ͷ
--���ߣ�chenl
--���ڣ�2021/08/24 --����'||to_char(planyear-1)||'���
---���� SELECT 'sheetҳid��ʹ��P_OPM_ES_GROUP�ж����sheetId��������ı�' "sheetID",1 "fieldLevel",0 "isHide",�Ƿ�ĩ���ֶ�"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�ֶ�id' "fieldId",'�ֶ�������' "lable",'�ֶ�����' "field",'���' "width",'���뷽ʽ' "align",'��Ԫ���ʽ�����桢���֡��ٷֱȣ�' "dataType",'��������˳��' "fieldOrder",'�����ֶ�Id' "parentId",'���뷽ʽ(left��right��center)' "textAlign",'ͬ���ݺϲ���1�ϲ���0���ϲ���' "isColumnMerge"  From Dual
    currentYear_MinusFour   VARCHAR2(500):=to_char(planyear-4); 
    currentYear_MinusThree   VARCHAR2(500):=to_char(planyear-3); 
    currentYear_MinusTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_MinusOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear   VARCHAR2(50):=to_char(planyear);--��ǰ��
    currentYear_AddOne  VARCHAR2(36):=to_char(planyear-1);
    currentYear_AddTwo   VARCHAR2(500):=to_char(planyear-2);
    currentYear_AddThree   VARCHAR2(500):=to_char(planyear-3);  
    currentYear_AddFour   VARCHAR2(500):=to_char(planyear-4);  
begin
OPEN Sheetsfields FOR 
---------------------------------sheet1
with groupsheet1 as  (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet1'  and EXCEL_TYPE='�ܱ�'
)
---------------------------------sheet2
,groupsheet2 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet2'  and EXCEL_TYPE='�ܱ�'
)
,groupsheet3 as (
SELECT sheet_id AS "sheetID",field_level AS "fieldLevel",is_hide AS "isHide",is_end AS "isEnd",header_bgcolor AS "headerBgColor",header_fontcolor AS "headerFontColor",field_id AS "fieldId",field_lable AS "lable",field_field AS "field",field_width AS "width",field_align AS "align",field_dataformat AS "dataFormat",field_order AS "fieldOrder",field_parentid AS "parentId",field_textalign AS "textAlign",is_columnmerge_column AS "isColumnMerge" ,data_column_bgcolor  AS "dataColumnBgcolor"
FROM OPM_EXCEL_FILED WHERE SHEET_ID='groupsheet3'  and EXCEL_TYPE='�ܱ�'
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