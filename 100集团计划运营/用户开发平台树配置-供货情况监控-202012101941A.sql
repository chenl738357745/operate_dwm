SET DEFINE OFF;
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'b61b5186-d4dd-4b12-e053-0100007f78ce';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'b61b5186-d4dd-4b12-e053-0100007f78ce';
d_createName  VARCHAR2 ( 100 ) := 'chenl'||d_table_dataSource;
begin
	DELETE
	FROM
udp_component_data_source
	WHERE
CREATOR = d_createName;
commit;
DELETE
	FROM
udp_procedure_registration
	WHERE
CREATOR = d_createName;
	commit;-->�ύ����
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---����Դע��
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'supply_monitor', 'procedure', 'parentId','id', 'id', 'projConstitute', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_SWM_SUPPLY_MONITOR','supply_monitor',1,d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'userid','����','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'stationid','����λ','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'departmentid','������','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'companyid','����˾','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'unitid','unitid','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'info','','',d_createName);
end;
/

CREATE OR replace PROCEDURE "P_SWM_SUPPLY_MONITOR" (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    unitid         IN             VARCHAR2, --ѡ��˾id
    info           OUT            SYS_REFCURSOR--���ؽ��
) AS
--����ֵ����ϵͳ������������
--���ߣ�chenl
--���ڣ�2020/12/10
    data_auth_spid   VARCHAR2(200);
    bizcode          VARCHAR2(200);
    unitid_val       VARCHAR2(200);
BEGIN

    --Ȩ�ޱ���
--    unitid_val := nvl(unitid, '003200000000000000000000000000');
--    bizcode := 'DWM.DTHZGL.03';
--    p_sys_get_company_proj_spid(userid => userid, stationid => stationid, deptid => departmentid, companyid => companyid, bizcode
--    => bizcode, data_auth_spid => data_auth_spid);
--20201210 -19:39 to ���� ��ģ������ҵ��Ӣ�������������ڵ�͹����ƻ����ڵ��ֶη�����Ҫһ�£����հ�����Ƶı��ֶΣ����ӿ������淶(С�շ�)��������ֶ�,ÿ���ֶ���Ҫ����ע�ͣ���ʾ����
OPEN info FOR SELECT
    '��Ŀ1' AS "projConstitute",--��Ŀ����
    '' AS "ҵ̬����",--ҵ̬����
    'id' AS "id",--����id����������id��Ψһ������ҵ��id��
    '' AS "parentId"--����id������������id��
FROM
    dual;
END P_SWM_SUPPLY_MONITOR;

