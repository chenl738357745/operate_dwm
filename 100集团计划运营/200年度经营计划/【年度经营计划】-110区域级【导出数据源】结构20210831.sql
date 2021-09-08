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
----- ��ɾ��ע������
DELETE FROM udp_component_data_source WHERE CREATOR=d_createName; commit;-->�ύ����Դע��
DELETE FROM udp_procedure_registration WHERE CREATOR=d_createName; commit;-->�ύ����
DELETE FROM udp_procedure_parameter WHERE CREATOR=d_createName;---����Դע��
------ ����
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource,'STRUCT_REGION','procedure','','','id','',d_createName);---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure,'P_OPM_ES_REGION','STRUCT_REGION',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'userid','����','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'stationid','����λ','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'departmentid','������','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'companyid','����˾','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'planyear','planyear','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'regionCompanyId','regionCompanyId','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'excel','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheets','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsFields','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure,'sheetsStyle','','',d_createName);

----- ��ɾ��ע������
DELETE FROM udp_component_data_source WHERE CREATOR=d_createName1; commit;-->�ύ����Դע��
DELETE FROM udp_procedure_registration WHERE CREATOR=d_createName1; commit;-->�ύ����
DELETE FROM udp_procedure_parameter WHERE CREATOR=d_createName1;---����Դע��
------ ����
INSERT INTO udp_component_data_source (id,data_source,data_source_type,parent_field,CHILD_FIELD,pk_field,lable_field,CREATOR) VALUES (d_table_dataSource1,'DATA_REGION','procedure','','','id','',d_createName1);---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) VALUES (d_table_dataSource_procedure1,'P_OPM_ED_REGION','DATA_REGION',1,d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'userid','����','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'stationid','����λ','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'departmentid','������','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'companyid','����˾','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'planyear','planyear','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'regionCompanyId','regionCompanyId','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet1','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet2','','',d_createName1);
INSERT INTO udp_procedure_parameter (procedure_registration_id,parameter_name,data_source_keyword,parameter_default,creator) VALUES (d_table_dataSource_procedure1,'groupsheet3','','',d_createName1);
END;
/

create or replace PROCEDURE "P_OPM_ES_REGION" (
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
regionCompanyId in VARCHAR2,---�ƻ�����˾
excel OUT SYS_REFCURSOR,--excel��Ϣ
sheets OUT SYS_REFCURSOR,--1��sheetҳ���� �����ݼ���˳��
sheetsFields OUT SYS_REFCURSOR,--2��sheetҳ�ı�ͷ����
sheetsStyle OUT SYS_REFCURSOR--3��sheetҳ����ʽ
) AS
-- Export structure ��Ӫ�ƻ�-���ż������ṹ����  sheetID ���������������sheet�С���ȡsheetҳ���ݽ���������
-- ע�⣺�з����ǰ����ϱ�ͷ�����顣https://blog.csdn.net/lipinganq/article/details/53560931?locationNum=10&fps=1
--���ߣ�chenl
--���ڣ�2021/08/24 https://blog.csdn.net/qq_27937043/article/details/72779442/
  FIELDSINFO SYS_REFCURSOR;
begin
--- 0��excel
Open excel For 
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') "excelName" from dual;
--- 1��sheetҳ���� 
---Select 'groupsheet1' "sheetID",'�ܱ�1-���š�����Ӫ�ƻ����ܱ� +�����ܶ�+����ʱ��2��' "seetName",'' "excelTitle",'��ͷ������ɫ' "headerBgColor",'��ͷ������ɫ' "HeaderFontColor",1 "SheetOrder",'�Ƿ�ʹ��������' "IsUseRowCollapse",'�Ƿ�Ĭ��������' "IsDefaultCollapseRow" From Dual
Open Sheets For 
With Base As(
Select 'groupsheet1' "sheetID",'�ܱ�1-���ž�Ӫ�ƻ����ܱ� +�����ܶ�+����ʱ��2��' "sheetName",'2022���ž�Ӫ�ƻ����ܱ�' "topDescription",'SEA_GREEN' "headerBgColor",'LIGHT_YELLOW' "headerFontColor",1 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" From Dual
Union All
Select 'groupsheet2' "sheetID",'�ܱ�2-�����ֽ����ϼƱ�' "sheetName",'2022��ȸ��ӹ�˾��̬�ֽ�����' "topDescription",'DARK_TEAL' "headerBgColor",'LIGHT_GREEN' "headerFontColor",2 "sheetOrder",1 "isUseRowCollapse",1 "isDefaultCollapseRow" From Dual
Union All
Select 'groupsheet3' "sheetID",'�ܱ�3-������ƻ���ʾ��������ֱ�ӵ�����' "sheetName",'���Ź�˾2021��ȹ�����ƻ���ϸ�ֽ��' "topDescription",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",3 "sheetOrder",1 "isUseRowCollapse",0 "isDefaultCollapseRow" From Dual
)
Select * From Base Order By "sheetOrder";
--- 2��sheetҳ�ı�ͷ����
---SELECT 'groupsheet1' "sheetID", '�ֶ�id' "fieldId",'�ֶ�������' "lable",'�ֶ�����' "field",'���' "wide",'���뷽ʽ' "align",'��Ԫ���ʽ�����桢���֡��ٷֱȣ�' "dataType",'������' "fieldOrder",'�����ֶ�Id' "parentId",'���뷽ʽ(left��right��center)' "textAlign",'ͬ���ݺϲ�' "isColumnMerge"  From Dual
BEGIN P_OPM_FIELD_GROUP (USERID=> USERID,STATIONID=> STATIONID,DEPARTMENTID=> DEPARTMENTID,COMPANYID=> COMPANYID,PLANYEAR=> PLANYEAR,Sheetsfields=> Sheetsfields); END;
--- 3��sheetҳ����ʽ
----Select 'groupsheet1' "sheetID",'����������' As "trozenRowindex",'����������' As "frozenColumnindex" From Dual
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
userid IN VARCHAR2,--��ǰ�û�id
stationid IN VARCHAR2,--��ǰ�û���λid
departmentid IN VARCHAR2,--��ǰ�û�����id
companyid IN VARCHAR2,--��ǰ�û���˾id
planyear in number,--�ƻ���
regionCompanyId in VARCHAR2,---�ƻ�����˾
groupsheet1 OUT SYS_REFCURSOR,--1��sheetҳ������Դ���� �����ݼ���˳��
groupsheet2 OUT SYS_REFCURSOR,--2��sheetҳ������Դ���� �����ݼ���˳��
groupsheet3 OUT SYS_REFCURSOR--3��sheetҳ������Դ���� �����ݼ���˳��
) AS
-- operate plan ��Ӫ�ƻ�-���ż����������ݡ�
--- ע�⣺
---1��ÿ��sheetҳ������ݱ���������ʹ��P_OPM_ES_REGION�ж����sheetId����һ�£�//�����߼�Լ�������ڹ���sheetҳ��sheetҳ�����ݽ�����ϵ��
---2�����ؽ�����ֶ����ƣ�������P_OPM_ES_REGION��Sheetsfields���ص�sheetId���ֶ���һ�£�//�����߼�Լ��,���ڱ�ͷ�����ݶ�Ӧ��
---3������id�ֶ����� parent_id���㼶���� row_level�����밴��������//�����߼�Լ���������з��顣
--���ߣ�chenl
--���ڣ�2021/08/24
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

