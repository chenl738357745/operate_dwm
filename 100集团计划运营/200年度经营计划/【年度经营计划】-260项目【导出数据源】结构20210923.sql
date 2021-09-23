create or replace PROCEDURE "P_OPM_ES_PROJ" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--����˾
planyear in number,--�ƻ���
projectid in VARCHAR2,---������Ŀid
excel OUT SYS_REFCURSOR,--excel��Ϣ
sheets OUT SYS_REFCURSOR,--1��sheetҳ���� �����ݼ���˳��
sheetsFields OUT SYS_REFCURSOR--2��sheetҳ�ı�ͷ����
) AS
  FIELDSINFO SYS_REFCURSOR;
begin
--- 0��excel
Open excel For 
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "excelName" from dual;
--- 1��sheetҳ���� 
---Select 'groupsheet1' "sheetID",'�ܱ�1-���š�����Ӫ�ƻ����ܱ� +�����ܶ�+����ʱ��2��' "seetName",'' "excelTitle",'��ͷ������ɫ' "headerBgColor",'��ͷ������ɫ' "HeaderFontColor",1 "SheetOrder",'�Ƿ�ʹ��������' "IsUseRowCollapse",'�Ƿ�Ĭ��������' "IsDefaultCollapseRow",'����������' As "trozenRowindex",'����������' As "frozenColumnindex",'��ʽ��Ԫ�񱳾�ɫ' As "formulaBgColor",'������������ɫ' "topDescriptionBgColor",'���������ı���ɫ' "topDescriptionFontColor",'���������ı����뷽ʽ��left��center��right��' "topDescriptionTextalign",'�������������С' "topDescriptionTextSize" From Dual
Open Sheets For 
With Base As(
Select 'projsheet1' "sheetID",'����1-��Ŀ������ƻ���ʾ��������ֱ�ӵ�����' "sheetName",'���Ź�˾2021��ȹ�����ƻ���ϸ�ֽ��' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,5 As "frozenRowindex",3 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet2' "sheetID",'����2-��ĿͶ�ʼƻ���' "sheetName",'              ��˾       ��Ŀ '||planyear||' ��ȷ��ز�������ĿͶ�ʼƻ���' "topDescription",'DARK_TEAL' "headerBgColor",'PALE_BLUE' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" ,5 As "frozenRowindex",2 As "frozenColumnindex",'GREY_25_PERCENT' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet3' "sheetID",'����3-��Ŀ�ʽ�Ԥ��ƽ���' "sheetName",'��Ŀ2022����ʽ�Ԥ��ƽ���' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow",5 As "frozenRowindex",5 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize" From Dual
Union All
Select 'projsheet4' "sheetID",'����4-��Ŀ��Ӫָ����ܱ�+�����ܽ���' "sheetName",'��Ŀ��Ӫָ����ܱ�' "topDescription",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",4 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow",5 As "frozenRowindex",2 As "frozenColumnindex",'LIGHT_YELLOW' As "formulaBgColor",'WHITE' "topDescriptionBgColor",'BLACK' "topDescriptionFontColor",'center' "topDescriptionTextalign",'15' "topDescriptionTextSize"  From Dual
)
Select * From Base Order By "sheetOrder";
--- 2��sheetҳ�ı�ͷ���� 
---SELECT 'groupsheet1' "sheetID", '�ֶ�id' "fieldId",'�ֶ�������' "lable",'�ֶ�����' "field",'���' "wide",'���뷽ʽ' "align",'��Ԫ���ʽ�����桢���֡��ٷֱȣ�' "dataType",'������' "fieldOrder",'�����ֶ�Id' "parentId",'���뷽ʽ(left��right��center)' "textAlign",'ͬ���ݺϲ�' "isColumnMerge"  From Dual
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