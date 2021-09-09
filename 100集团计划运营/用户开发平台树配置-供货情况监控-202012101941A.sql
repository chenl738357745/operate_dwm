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
	commit;-->提交数据
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---数据源注册
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'supply_monitor', 'procedure', 'parentId','id', 'id', 'projConstitute', d_createName );
---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'P_SWM_SUPPLY_MONITOR','supply_monitor',1,d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'userid','本人','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'stationid','本岗位','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'departmentid','本部门','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'companyid','本公司','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'unitid','unitid','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'info','','',d_createName);
end;
/

CREATE OR replace PROCEDURE "P_SWM_SUPPLY_MONITOR" (
    userid         IN             VARCHAR2, --当前用户id
    stationid      IN             VARCHAR2, --当前用户岗位id
    departmentid   IN             VARCHAR2, --当前用户部门id
    companyid      IN             VARCHAR2, --当前用户公司id
    unitid         IN             VARCHAR2, --选择公司id
    info           OUT            SYS_REFCURSOR--返回结果
) AS
--《货值管理系统》供货情况监控
--作者：chenl
--日期：2020/12/10
    data_auth_spid   VARCHAR2(200);
    bizcode          VARCHAR2(200);
    unitid_val       VARCHAR2(200);
BEGIN

    --权限编码
--    unitid_val := nvl(unitid, '003200000000000000000000000000');
--    bizcode := 'DWM.DTHZGL.03';
--    p_sys_get_company_proj_spid(userid => userid, stationid => stationid, deptid => departmentid, companyid => companyid, bizcode
--    => bizcode, data_auth_spid => data_auth_spid);
--20201210 -19:39 to 永楷 按模块需求、业务英文命名（供货节点和供销计划存在的字段翻译需要一致，参照奥霖设计的表字段）、接口命名规范(小驼峰)定义输出字段,每个字段需要加上注释（见示例）
OPEN info FOR SELECT
    '项目1' AS "projConstitute",--项目构成
    '' AS "业态类型",--业态类型
    'id' AS "id",--主键id（生成树的id，唯一可以是业务id）
    '' AS "parentId"--父级id（生成树父级id）
FROM
    dual;
END P_SWM_SUPPLY_MONITOR;

