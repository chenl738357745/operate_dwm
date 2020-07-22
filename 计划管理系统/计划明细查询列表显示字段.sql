
create or replace PROCEDURE p_pom_plan_dtl_field (
    o_result out  SYS_REFCURSOR
) AS
	--�ƻ���ϸ��ѯ��ʾ��
	--���ߣ�����
	--���ڣ�2020-07-21    
BEGIN
---����
open o_result for
select  'warning' as "field",'Ԥ��״̬' as "lable",1 as "sort",1 as "isChecked",1 as "isHtml",''  as "openUrlFiled"  from dual
UNION
select  'nodeName' as "field",'��������' as "lable",2 as "sort",0 as "isChecked",0 as "isHtml",'nodeNameOpenUrl' as "openUrlFiled"  from dual
UNION
select  'nodeState' as "field",'���״̬' as "lable",2 as "sort",1 as "isChecked",0 as "isHtml",'nodeStateOpenUrl'  as "openUrlFiled"  from dual
UNION
select  'planEndDate' as "field",'�ƻ��������' as "lable",2 as "sort",1 as "isChecked",0 as "isHtml",''  as "openUrlFiled"  from dual;
END p_pom_plan_dtl_field;
/
create or replace PROCEDURE p_pom_plan_dtl_data (
    currentuserid        IN            VARCHAR,--��ǰ�û�id 
    currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
    currentdeptid        IN            VARCHAR2,--��ǰ�û�����
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    pageindex     IN            INT,
    pagesizes     IN            INT,
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) is
	--�ƻ���ϸ��ѯ����
	--���ߣ�����
	--���ڣ�2020-07-21    
BEGIN
---����
open items for
select * from (select rownum r,e. * from 
(SELECT
    '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>' as "warning",
    node_name as "nodeName",
    node_code as "nodeCode",
    case when ACTUAL_END_DATE is null then 'δ���' else '�����' end as "nodeState",
    plan_end_date as "planEndDate",
    'http://www.baidu.com' as "nodeNameOpenUrl",
    'http://dev.highzap.com:82/zentao/bug-browse-2-0-bySearch-myQueryID.html' as "nodeStateOpenUrl"
FROM
    pom_proj_plan_node)
e where rownum<=pagesizes*pageindex) t where r>pagesizes*pageindex-pagesizes ;
select count(*) into total from pom_proj_plan_node;
END p_pom_plan_dtl_data;
/
----------------------------------------------chenl20200621��ʼ------��������ˢ��Ŀ���ֵ�洢����ע��

DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'ab0084c2-0f20-66a3-e053-0100007f4fbb';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'ab0184c2-0f20-66a3-e053-0100007f4fbb';
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
( d_table_dataSource, 'p_pom_plan_dtl_field', 'procedure', '','', 'field', '', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_pom_plan_dtl_field','plan_dtl_field',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'o_result','o_result','',d_createName);
end;

/
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'ab00fe4d-db5e-295e-e053-0100007f28d8';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'ab00fe4d-db5f-295e-e053-0100007f28d8';
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
( d_table_dataSource, 'p_pom_plan_dtl_data', 'procedure', '','', 'field', '', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_pom_plan_dtl_data','plan_dtl_data',1,d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'currentuserid','����','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'currentcompanyid','����˾','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'currentdeptid','������','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'currentstationid','����λ','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'pageindex','pageindex','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'pagesizes','pagesizes','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'searchcondition','searchcondition','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'items','items','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'total','total','',d_createName);
end;


