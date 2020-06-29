
-----------http://pom.crccre.cn/api/udp/getRegisterResult?code=user_tree_Lazy_load&bizcode=&parentid={��ѯ�Ӽ����ղ�ѯ����}
--SET DEFINE OFF;
--
DECLARE --functionguid  select get_uuid() from dual;
    d_table_datasource             VARCHAR2(100) := '5226bd7d-780a-4966-80ec-db9877d75fb3';
    d_table_datasource_procedure   VARCHAR2(100) := '5226bd7d-780a-4966-80ec-db9877d75fb3';
    d_createname                   VARCHAR2(100) := 'chenl' || d_table_datasource;
BEGIN
    DELETE FROM udp_component_data_source WHERE   creator = d_createname;
    COMMIT;
    DELETE FROM udp_procedure_registration  WHERE  creator = d_createname;
    COMMIT;-->�ύ����
    DELETE FROM udp_procedure_parameter    WHERE        creator = d_createname;

---����Դע��
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'user_tree_Lazy_load', 'procedure',
        'PARENTID',
        'ID',
        'ID',
        'ORGNAME', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_user_tree_Lazy_load','user_tree_Lazy_load',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'USERID','����','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'STATIONID','����λ','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'DEPTID','������','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'COMPANYID','����˾','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'data_auth_info','','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'parentid','parentid','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'bizcode','bizcode','',d_createName);


END;
/

CREATE OR REPLACE PROCEDURE p_user_tree_Lazy_load (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    parentid         IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ�û���
--���ߣ�����
--���ڣ�2020/06/18

    rulevalue        VARCHAR2(50);
    authcount        INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid             VARCHAR2(36);--ʹ����ʱ������κ�
    data_auth_spid   VARCHAR2(200);
    authcode         VARCHAR2(50);---- Ȩ�ޱ���
    v_id varchar2(100);
BEGIN

    IF parentid IS NULL THEN
        v_id := '0001';
    ELSE
        v_id := parentid;
    END IF;
  --�Ȳ���ȫ
    OPEN data_auth_info FOR WITH base AS (
                                SELECT
                                    *
                                FROM
                                    (
                                        SELECT DISTINCT
                                            a.id           AS id,
                                            a.id           AS objid,
                                            a.org_name     AS orgname,
                                            a.org_type     AS orgtype,
                                            a.parent_id    AS parentid,
                                            a.order_code   AS ordercode
                                        FROM
                                            sys_business_unit a
                                        UNION ALL
                                   ----��λ
                                        SELECT
                                            id,
                                            id       AS obj_id,
                                            station_name,
                                            '100' AS orgtype,
                                            org_id   AS parent_id,
                                            station_name
                                        FROM
                                            sys_station
                                        UNION ALL
                                   ----��
                                        SELECT
                                            stu.id,
                                            u.id             AS user_id,
                                            u.user_name,
                                            '110' AS orgtype,
                                            stu.station_id   AS parent_id,
                                            user_code
                                        FROM
                                            sys_station_to_user   stu
                                            LEFT JOIN sys_user              u ON stu.user_id = u.id
                                    )
                            ), ���� AS (
                                SELECT
                                    base1.id,
                                    base1.objid,
                                    base1.orgname,
                                    base1.orgtype,
                                    base1.parentid,
                                    lpad(base1.ordercode, 10, '0') AS ordercode,
                                    CASE
                                        WHEN base2.parentid IS NULL THEN
                                            1
                                        ELSE
                                            0
                                    END AS isleaf
                                FROM
                                    base base1
                                    LEFT JOIN (
                                        SELECT
                                            parentid
                                        FROM
                                            base
                                        GROUP BY
                                            parentid
                                    ) base2 ON base1.id = base2.parentid
                            )
                            SELECT  *  FROM  ���� WHERE  parentid = v_id  ORDER BY ordercode;

END p_user_tree_Lazy_load;