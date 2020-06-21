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
	commit;-->提交数据
	DELETE
	FROM
udp_procedure_parameter
	WHERE
CREATOR = d_createName;

---数据源注册
	INSERT INTO udp_component_data_source ( id, data_source, data_source_type, parent_field, CHILD_FIELD,pk_field, lable_field, CREATOR )
	VALUES
( d_table_dataSource, 'pom_get_proj_tree', 'procedure', 'PARENTID','ORGID', 'ORGID', 'ORGNAME', d_createName );
---存储过程注册
INSERT INTO udp_procedure_registration (id,name,code,state,creator) 
VALUES (d_table_dataSource_procedure,'p_pom_get_proj_tree','pom_get_proj_tree',1,d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'bizcode','bizcode','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'USERID','本人','',d_createName);

INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'STATIONID','本岗位','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'DEPTID','本部门','',d_createName);
INSERT INTO udp_procedure_parameter (procedure_registration_id, parameter_name, data_source_keyword, parameter_default,creator) 
VALUES (d_table_dataSource_procedure,'COMPANYID','本公司','',d_createName);
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
--获取有权限的项目树
--作者：谷国斌
--日期：2019/12/14
    rulevalue   VARCHAR2(50);
    authcount   INT;--用于判断当前公司、部门是否与数据授权的主体有关系
    spid        VARCHAR2(36);--使用临时表的批次号
BEGIN
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;

--获取隔离规则：

    SELECT
        isolation_rule_value
    INTO rulevalue
    FROM
        sys_data_auth_biz
    WHERE
        biz_obj_code = bizcode;

    IF rulevalue = '全集团' THEN
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
--插入本公司的项目
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

--插入数据授权的数据：

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
                AND nvl(auth_type, '项目') = '项目';

        BEGIN   

            --打开游标
            OPEN cursor_company;
            LOOP
                FETCH cursor_company INTO
                    ownerid,
                    oenertype;
                EXIT WHEN cursor_company%notfound;

                --过滤当前用户有权限的授权对象：
                IF oenertype = '公司' OR oenertype = '集团' THEN
                   --AUTHCOUNT不等于0说明授权的公司包含有该公司，以下语句为递归查找所有子公司                
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

                IF oenertype = '部门' THEN
                   --AUTHCOUNT不等于0说明授权的部门包含有该部门，以下语句为递归查找所有子部门                
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

                IF ( oenertype = '岗位' AND ownerid = stationid ) OR ( oenertype = '人员' AND ownerid = userid ) THEN
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

          --获取有权限的公司及其父级：            

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

                    --打开游标
            OPEN cursor_auth;
            LOOP
                FETCH cursor_auth INTO ownerid2;
                EXIT WHEN cursor_auth%notfound;


                            --授权对象为公司：
                            --取授权公司的子级：
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
                                            '公司',
                                            '集团'
                                        )
                                        AND nvl(auth_type, '项目') = '项目'
                                )
                            CONNECT BY
                                PRIOR id = parent_id
                        );



                               --授权对应为项目：

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
                                AND auth_scope_type = '项目'
                                AND nvl(auth_type, '项目') = '项目'
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
