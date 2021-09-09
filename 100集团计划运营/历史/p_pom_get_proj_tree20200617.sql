--SET DEFINE OFF;
--
DECLARE --functionguid  select get_uuid() from dual;
d_table_dataSource VARCHAR2 ( 100 ) := 'a844aa90-d74a-400e-e053-8606160a8c0e';
d_table_dataSource_procedure VARCHAR2 ( 100 ) := 'a844aa90-d74a-400e-e053-8606160a8c0e';
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
( d_table_dataSource, 'pom_get_proj_tree', 'procedure', 'PARENTID','ORGID', 'ORGID', 'ORGNAME', d_createName );
---�洢����ע��
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_pom_get_proj_tree','pom_get_proj_tree',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'bizcode','bizcode','',d_createName);
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
end;
/

create or replace PROCEDURE p_pom_get_proj_tree (
    userid           IN               VARCHAR2,
    stationid        IN               VARCHAR2,
    deptid           IN               VARCHAR2,
    companyid        IN               VARCHAR2,
    bizcode          IN               VARCHAR2,
    data_auth_info   OUT              SYS_REFCURSOR
) AS
--��ȡ��Ȩ�޵���Ŀ��
--���ߣ��ȹ���
--���ڣ�2019/12/14
    rulevalue   VARCHAR2(50);
    authcount   INT;--�����жϵ�ǰ��˾�������Ƿ���������Ȩ�������й�ϵ
    spid        VARCHAR2(36);--ʹ����ʱ������κ�
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;

--��ȡ�������

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = 'ȫ����' THEN
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project where org_type<>11;

    ELSE 
--���뱾��˾����Ŀ
        INSERT INTO tmp_proj_tree (
            id,
            org_id,
            org_name,
            org_type,
            parent_id,
            full_name,
            is_end,
            city_name,
            company_id,
            order_code
        )
            SELECT
                spid,
                org_id,
                org_name,
                org_type,
                parent_id,
                full_name,
                is_end,
                city_name,
                company_id,
                sn
            FROM
                v_sys_project
            WHERE
                company_id = companyid and org_type<>11;

--����������Ȩ�����ݣ�

        DECLARE
            ownerid     VARCHAR2(36);
            oenertype   NVARCHAR2(50);
            CURSOR cursor_company IS
            SELECT DISTINCT
                auth_owner_id,
                auth_owner_type
            FROM
                sys_data_auth
            WHERE
                auth_biz_code = bizcode
                AND is_disabled = 0
                AND nvl(auth_type, '��Ŀ') = '��Ŀ';

        BEGIN   

            --���α�
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --���˵�ǰ�û���Ȩ�޵���Ȩ����
                IF oenertype = '��˾' OR oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĺ�˾�����иù�˾���������Ϊ�ݹ���������ӹ�˾                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 1
                        AND id = companyid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF oenertype = '����' THEN
                   --AUTHCOUNT������0˵����Ȩ�Ĳ��Ű����иò��ţ��������Ϊ�ݹ���������Ӳ���                
                    SELECT
                        COUNT(*)
                    INTO authcount
                    FROM
                        sys_business_unit
                    WHERE
                        is_company = 0
                        AND id = deptid
                    START WITH
                        id = ownerid
                    CONNECT BY
                        PRIOR id = parent_id;

                    IF authcount <> 0 THEN
                        INSERT INTO tmp_auth_owner (
                            id,
                            auth_owner_id,
                            auth_owner_type
                        ) VALUES (
                            spid,
                            ownerid,
                            oenertype
                        );

                    END IF;

                END IF;

                IF ( oenertype = '��λ' AND ownerid = stationid ) OR ( oenertype = '��Ա' AND ownerid = userid ) THEN
                    INSERT INTO tmp_auth_owner (
                        id,
                        auth_owner_id,
                        auth_owner_type
                    ) VALUES (
                        spid,
                        ownerid,
                        oenertype
                    );

                END IF;

            END LOOP;

            CLOSE cursor_company;
        END;   

          --��ȡ��Ȩ�޵Ĺ�˾���丸����            

        DECLARE
            ownerid2 VARCHAR2(36);
            CURSOR cursor_auth IS
            SELECT
                auth_owner_id
            FROM
                tmp_auth_owner
            WHERE
                id = spid;

        BEGIN   

                    --���α�
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --��Ȩ����Ϊ��˾��
                            --ȡ��Ȩ��˾���Ӽ���
                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project 
                    WHERE
                        org_type<>11 and
                        company_id IN (
                            SELECT
                                id
                            FROM
                                sys_business_unit
                            WHERE
                                is_company = 1
                            START WITH
                                id IN (
                                    SELECT DISTINCT
                                        auth_scope_id
                                    FROM
                                        sys_data_auth
                                    WHERE
                                        auth_biz_code = bizcode
                                        AND is_disabled = 0
                                        AND auth_owner_id = ownerid2
                                        AND auth_scope_type IN (
                                            '��˾',
                                            '����'
                                        )
                                        AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                                )
                            CONNECT BY
                                PRIOR id = parent_id
                        );



                               --��Ȩ��ӦΪ��Ŀ��

                INSERT INTO tmp_proj_tree (
                    id,
                    org_id,
                    org_name,
                    org_type,
                    parent_id,
                    full_name,
                    is_end,
                    city_name,
                    company_id,
                    order_code
                )
                    SELECT
                        spid,
                        org_id,
                        org_name,
                        org_type,
                        parent_id,
                        full_name,
                        is_end,
                        city_name,
                        company_id,
                        sn
                    FROM
                        v_sys_project
                    WHERE org_type<>11 and
                        project_id IN (
                            SELECT DISTINCT
                                auth_scope_id
                            FROM
                                sys_data_auth
                            WHERE
                                auth_biz_code = bizcode
                                AND is_disabled = 0
                                AND auth_owner_id = ownerid2
                                AND auth_scope_type = '��Ŀ'
                                AND nvl(auth_type, '��Ŀ') = '��Ŀ'
                        );

            END LOOP;

            CLOSE cursor_auth;
        END;

    END IF;

    OPEN data_auth_info FOR SELECT DISTINCT
                               a.org_id         AS orgid,
                               a.org_name       AS orgname,
                               a.org_type       AS orgtype,
                               a.parent_id      AS parentid,
                               a.full_name      AS fullname,
                               a.is_end         AS isend,
                               a.city_name      AS cityname,
                               a.company_id     AS companyid,
                               b.company_type   AS companytype,
                               a.order_code     AS ordercode
                           FROM
                               tmp_proj_tree       a
                               LEFT JOIN sys_business_unit   b ON a.org_id = b.id
                           ORDER BY
                               a.order_code;

END p_pom_get_proj_tree;
