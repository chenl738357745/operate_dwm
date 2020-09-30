
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'a76cac38-254e-5588-e053-8606160af5c8';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'a76cac38-254e-5588-e053-8606160af5c8';
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
( d_table_dataSource, 'w_proj_main_tree', 'procedure', 'parentId','orgId', 'orgId', '', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_pom_w_proj_main_tree','w_proj_main_tree',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'USERID','����','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'STATIONID','����λ','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'DEPTID','������','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'COMPANYID','����˾','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'info','','',d_createName);

end;