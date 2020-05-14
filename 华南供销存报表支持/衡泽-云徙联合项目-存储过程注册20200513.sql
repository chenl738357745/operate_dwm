DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'bd2c9f3c-8f1d-4275-9ca2-9da8f0557cb4';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'bd2c9f3c-8f1d-4275-9ca2-9da8f0557cb4';
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
	commit;-->提交数据
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---数据源注册
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'DWM_huannan', 'procedure', 'PARENT_ID','ID', 'ID', 'NAME', d_createName );
---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_DWM_云徙联合项目组','DWM_huannan',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'INFO','','',d_createName);

end;