--select get_uuid() from dual;
--set define off;
DECLARE--functionguid
d_functionId VARCHAR2 ( 100 ) := '890d8de7-5d73-421c-b46f-17e94851b9e7';
--ģ��id
d_layout_template_id VARCHAR2 ( 100 ) := 'defaultViewTemplate';
d_createName VARCHAR2 ( 100 ) := 'chenl' || d_functionId;
--=============================�������
--main-content ����  view-condition ��ͼ����  view-btn  ��ť  tob-condition ��������  view ��ͼ view-statistics ͳ��
d_view_condition VARCHAR2 ( 100 ) := 'view-condition';
d_view_btn VARCHAR2 ( 100 ) := 'view-btn';
d_view VARCHAR2 ( 100 ) := 'view';
d_view_statistics VARCHAR2 ( 100 ) := 'view-statistics';
--=============================���
--table���id
d_table1 VARCHAR2 ( 100 ) := '890d8de7-5d73-421c-b46f-13e94851b9e7';
d_table_dataSource VARCHAR2 ( 100 ) := 'bd2c9f3c-8f1d-4275-9ca2-9da8f0557cb4';
--=============================�������Դ���id
BEGIN--=============================================================ҳ��
-- ɾ����ҳ������������
	DELETE 
	FROM
		udp_page 
	WHERE
		CREATOR = d_createName;
	commit;
-->�ύ����
--����ҳ������
	INSERT INTO udp_page ( ID, layout_template_id, CREATOR )
	VALUES
		( d_functionId, d_layout_template_id, d_createName );
--=============================================================���ʵ������
	DELETE 
	FROM
		UDP_LAYOUT 
	WHERE
		CREATOR = d_createName;
	commit;
--table
	INSERT INTO udp_layout ( page_id, layout_template_id, component_id, layout_area_template_id, CREATOR )
	VALUES
		( d_functionId, d_layout_template_id, d_table1, d_view, d_createName );
		commit;
--=============================================================ҳ�����
	DELETE 
	FROM
		udp_component 
	WHERE
		CREATOR = d_createName;
	commit;
-->�ύ����
---table
	INSERT INTO udp_component ( ID, page_id, component_data_source_id, component_high, component_wide, component_order, component_name, component_lable, component_type, placeholder, CREATOR )
	VALUES
		( d_table1, d_functionId, d_table_dataSource, NULL, NULL, 0, 'TableList1', '', 'TemplateTreetable', '', d_createName );
	

--=============================================================table�������
	DELETE 
	FROM
		udp_component_table 
	WHERE
		CREATOR = d_createName;
	commit;-->�ύ����
	DELETE 
	FROM
		udp_component_table_column 
	WHERE
		CREATOR = d_createName;
	commit;-->�ύ����
	INSERT INTO udp_component_table ( ID, detail_url, CREATOR )
	VALUES
		( d_table1, NULL, d_createName );
	INSERT INTO udp_component_table_column ( component_table_id, column_lable, column_field, column_wide, column_align, column_fixed, column_number_float, column_data_type, jump_url, open_mode, COLUMN_ORDER, CREATOR, IS_USE_HTML )
	VALUES
		( d_table1, 'Ԥ��״̬', 'ORGID', '90px', 'center', 'left', NULL, '', '', '', 1, d_createName, 1 );
	commit;
    INSERT INTO udp_component_table_column ( component_table_id, column_lable, column_field, column_wide, column_align, column_fixed, column_number_float, column_data_type, jump_url, open_mode, COLUMN_ORDER, CREATOR, IS_USE_HTML )
	VALUES
		( d_table1, '����', 'ORGNAME', '90px', 'center', 'left', NULL, '', '', '', 1, d_createName, 1 );
	commit;
END;