create or replace PROCEDURE "P_OPM_ED_GROUP_INVENTORY" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
groupsheet3 OUT SYS_REFCURSOR--2��sheet3 ������
) AS
-- 
--- ע�⣺
---1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_GROUP�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
---2�����ؽ�����ֶ����ƣ�������P_OPM_ES_GROUP��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
---3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
--���ߣ�chenl
--���ڣ�2021/08/24
begin
OPEN groupsheet3 FOR 
SELECT 1 from dual;

END P_OPM_ED_GROUP_INVENTORY;
/
create or replace PROCEDURE "P_OPM_ED_GROUP_OPERATING" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
groupsheet1 OUT SYS_REFCURSOR--2��sheet1 ��Ӫ�ƻ�
) AS
-- 
--- ע�⣺
---1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_GROUP�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
---2�����ؽ�����ֶ����ƣ�������P_OPM_ES_GROUP��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
---3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
--���ߣ�chenl
--���ڣ�2021/08/24
begin
OPEN groupsheet1 FOR 
SELECT 1 from dual;

END P_OPM_ED_GROUP_OPERATING;

/
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
--���ڣ�2021/08/24
---���� SELECT 'sheetҳid��ʹ��P_OPM_ES_GROUP�ж����sheetId��������ı�' "sheetID",1 "fieldLevel",0 "isHide",�Ƿ�ī���ֶ� "isEnd", '�ֶ�id' "fieldId",'�ֶ�������' "lable",'�ֶ�����' "field",'���' "width",'���뷽ʽ' "align",'��Ԫ���ʽ�����桢���֡��ٷֱȣ�' "dataType",'��������˳��' "fieldOrder",'�����ֶ�Id' "parentId",'���뷽ʽ(left��right��center)' "textAlign",'ͬ���ݺϲ���1�ϲ���0���ϲ���' "isColumnMerge"  From Dual
begin
OPEN Sheetsfields FOR 
---�����
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", 'groupsheet2ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT 'groupsheet1' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", '�㼶' "fieldId",'�㼶' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---------------------------------sheet2
---��һ��
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",1 "isHide",1 "isEnd", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd", 'groupsheet2���id' "fieldId",'���' "lable",'groupsheet2���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd",'����/��Ŀ����' "fieldId",'����/��Ŀ����' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",1 "fieldLevel",0 "isHide",0 "isEnd",'2021�꼯�ţ����򣩶�̬�ֽ���' "fieldId",planyear||'�꼯�ţ����򣩶�̬�ֽ���' "lable",'2021�꼯�ţ����򣩶�̬�ֽ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---�ڶ���
union all
SELECT 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd", '����2021���' "fieldId",'����'||to_char(planyear-1)||'���' "lable",'����2021���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022���ʽ���Դ�ƻ�' "fieldId",planyear||'���ʽ���Դ�ƻ�' "lable",'2022���ʽ���Դ�ƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022���ʽ����üƻ�' "fieldId",planyear||'���ʽ����üƻ�' "lable",'2022���ʽ����üƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",2 "fieldLevel",0 "isHide",0 "isEnd",'2022�굱���ֽ������չʾ��' "fieldId",planyear||'�굱���ֽ������չʾ��' "lable",'2022�굱���ֽ������չʾ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---������
union all
SELECT 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd", '2021���-��ĩ�ʽ����' "fieldId",'2021���-��ĩ�ʽ����' "lable",'���-��ĩ�ʽ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'����2021���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'���ۻؿ�' "fieldId",'���ۻؿ�' "lable",'���ۻؿ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�������' "fieldId",'�������' "lable",'�������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",310 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'��������' "fieldId",'��������' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",410 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'���տ�' "fieldId",'���տ�' "lable",'���տ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",510 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ɶ�Ͷ��' "fieldId",'�ɶ�Ͷ��' "lable",'�ɶ�Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",610 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'����Ͷ��' "fieldId",'����Ͷ��' "lable",'����Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'����Ͷ��' "fieldId",'����Ͷ��' "lable",'����Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ʽ���Դ�ϼ�' "fieldId",'�ʽ���Դ�ϼ�' "lable",'�ʽ���Դ�ϼ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'���ط���' "fieldId",'���ط���' "lable",'���ط���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'������֧��' "fieldId",'������֧��' "lable",'������֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1110 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'������ӷ�' "fieldId",'������ӷ�' "lable",'������ӷ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1210 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ڼ����' "fieldId",'�ڼ����' "lable",'�ڼ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1310 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'˰��' "fieldId",'˰��' "lable",'˰��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1410 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'������' "fieldId",'������' "lable",'������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1510 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'����֧��' "fieldId",'����֧��' "lable",'����֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1610 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'����֧��' "fieldId",'����֧��' "lable",'����֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1710 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ʽ�����С��' "fieldId",'�ʽ�����С��' "lable",'�ʽ�����С��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1810 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual

union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ʽ�����' "fieldId",'�ʽ�����' "lable",'�ʽ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1910 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'չʾ��-��ĩ�ʽ����' "fieldId",'��ĩ�ʽ����' "lable",'չʾ��-��ĩ�ʽ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2010 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
Select 'groupsheet2' "sheetID",3 "fieldLevel",0 "isHide",1 "isEnd",'�ɶ����ʽ�' "fieldId",'�ɶ����ʽ�' "lable",'�ɶ����ʽ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2110 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
---------------------------------sheet3
union all
Select 'groupsheet3' "sheetID",1 "fieldLevel",0 "isHide",1 "isEnd",'groupsheet3���id' "fieldId",'���' "lable",'groupsheet3���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
;
END P_OPM_FIELD_GROUP;