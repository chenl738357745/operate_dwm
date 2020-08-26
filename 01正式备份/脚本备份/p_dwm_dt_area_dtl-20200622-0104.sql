create or replace PROCEDURE p_dwm_dt_area_dtl (
    userid         IN             VARCHAR2, --��ǰ�û�id
    stationid      IN             VARCHAR2, --��ǰ�û���λid
    departmentid   IN             VARCHAR2, --��ǰ�û�����id
    companyid      IN             VARCHAR2, --��ǰ�û���˾id
    projectid      IN             VARCHAR2, --ѡ��˾id
    tabsindex      IN             VARCHAR2, --ѡ��ѡ���1��ʼ
    isoperate      IN             VARCHAR2,--�Ƿ����
    info           OUT            SYS_REFCURSOR
) AS
--��̬��������-ȫ����̬����-��͸����
--���ߣ�����
--���ڣ�2019/12/17
    data_auth_spid   VARCHAR2(200);
    bizcode          VARCHAR2(200);
BEGIN
    IF tabsindex = 1 THEN
        dbms_output.put_line('����ҵ̬!');
    ELSIF tabsindex = 2 THEN
        dbms_output.put_line('סլ���̰�!');
    ELSIF tabsindex = 3 THEN
        dbms_output.put_line('סլ!');
    ELSIF tabsindex = 4 THEN
        dbms_output.put_line('�̰�!');
    ELSIF tabsindex = 5 THEN
        dbms_output.put_line('��λ!');
    ELSe--IF tabsindex = 6 THEN
        dbms_output.put_line('ʣ�������!');
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '' || project_name
                              WHEN level = 2 THEN
                                  '        ' || project_name
                              WHEN level = 3 THEN
                                  '                ' || project_name
                              WHEN level = 4 THEN
                                  '                        ' || project_name
                              ELSE
                                  '                                ' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          a.parent_id      AS "parentId",--����id������������id��
                          a.project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          b.ZZ_area_remain AS "projWholeDwellingArea",--��Ŀȫ��ʣ����ۻ�����S=A+B+C+D��-סլ(m2)
                           b.SY_area_remain AS "projWholeBusinessArea",--��Ŀȫ��ʣ����ۻ�����S=A+B+C+D��-��ҵ(m2)
                           b.CW_area_remain AS "projWholeCarport",--��Ŀȫ��ʣ����ۻ�����S=A+B+C+D��-��λ(��)
                          b.area_remain AS "projWholeTotalArea",--��Ŀȫ��ʣ����ۻ�����S=A+B+C+D��-�ϼ�(m2)
                           b.zz_area_not_planning_permit AS "ADwellingArea",--Aδȡ��֤�Ŀ��ۻ���-סլ(m2)
                           b.sy_area_not_planning_permit AS "ABusinessArea",--Aδȡ��֤�Ŀ��ۻ���-��ҵ(m2)
                           b.CW_Area_not_planning_permit AS "ACarport",--Aδȡ��֤�Ŀ��ۻ���-��λ(��)
                           b.Area_not_planning_permit AS "ATotalArea",--Aδȡ��֤�Ŀ��ۻ���-�ϼ�(m2)
                          b.zz_area_not_construction_per AS "BDwellingArea",--B��ȡ��֤δȡʩ��֤�Ŀ��ۻ���-סլ(m2)
                          b.SY_area_not_construction_per AS "BBusinessArea",--B��ȡ��֤δȡʩ��֤�Ŀ��ۻ���-��ҵ(m2)
                          b.CW_area_not_construction_per AS "BCarport",--B��ȡ��֤δȡʩ��֤�Ŀ��ۻ���-��λ(��)
                          b.area_not_construction_permit AS "BTotalArea",--B��ȡ��֤δȡʩ��֤�Ŀ��ۻ���-�ϼ�(m2)
                          b.zz_area_not_sale_permit "CDwellingArea",--C��ȡ��֤δȡԤ��֤�Ŀ��ۻ���-סլ(m2)
                         b.SY_area_not_sale_permit AS "CBusinessArea",--C��ȡ��֤δȡԤ��֤�Ŀ��ۻ���-��ҵ(m2)
                          b.CW_area_not_sale_permit AS "CCarport",--C��ȡ��֤δȡԤ��֤�Ŀ��ۻ���-��λ(��)
                          b.area_not_sale_permit AS "CTotalArea",--C��ȡ��֤δȡԤ��֤�Ŀ��ۻ���-�ϼ�(m2)
                          b.zz_area_stock AS "DDwellingArea",--D��ȡԤ��֤δ�۵Ŀ��ۻ���-סլ(m2)
                          b.SY_area_stock AS "DBusinessArea",--D��ȡԤ��֤δ�۵Ŀ��ۻ���-��ҵ(m2)
                          b.CW_area_stock AS "DCarport",--D��ȡԤ��֤δ�۵Ŀ��ۻ���-��λ(��)
                          b.area_Stock AS "DTotalArea"--D��ȡԤ��֤δ�۵Ŀ��ۻ���-�ϼ�(m2)
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value   b ON a.id = b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;

    IF tabsindex = 1 THEN--OR tabsindex = 2-- OR tabsindex = 3 OR tabsindex = 4 OR tabsindex = 5 THEN
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          a.parent_id      AS "parentId",--����id������������id��
                          project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          level,
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '1' || project_name
                              WHEN level = 2 THEN
                                  '        2' || project_name
                              WHEN level = 3 THEN
                                  '                3' || project_name
                              WHEN level = 4 THEN
                                  '                        4' || project_name
                              ELSE
                                  '                                5' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--���½������
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--���¿��������������λ��
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--��̬������������λ��-��̬����(A)
                          TO_CHAR(b.area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--��̬������������λ��-��������(A1)
                          TO_CHAR(b.area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--��̬������������λ��-��;����(A2)
                          TO_CHAR(b.area_stock, '999,999,999,999,999.99') AS "stockCargo",--��̬������������λ��-������(A3)
                          TO_CHAR(b.area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--��̬������������λ��-���ۻ���(A4)
                          TO_CHAR(b.area_remain, '999,999,999,999,999.99') AS "residueCargo",--ʣ�����(C=B1+B2+B3)
                          TO_CHAR(b.area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--����֤����(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.Area_stock + b.area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.area_haved_sale /(b.area_stock + b.area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--ȥ����(E=B4/D)
                          TO_CHAR(b.area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.area_not_construction_permit, '999,999,999,999,999.99') AS "PermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--��̬��������λ��-��̬����(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--��̬��������λ��-��������(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--��̬��������λ��-��;����(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--��̬��������λ��-������(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--��̬��������λ��-���ۻ���(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value  b ON a.id= b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;
    
       IF tabsindex = 2 THEN--OR tabsindex = 4 OR tabsindex = 5 THEN
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          a.parent_id      AS "parentId",--����id������������id��
                          project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          level,
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '1' || project_name
                              WHEN level = 2 THEN
                                  '        2' || project_name
                              WHEN level = 3 THEN
                                  '                3' || project_name
                              WHEN level = 4 THEN
                                  '                        4' || project_name
                              ELSE
                                  '                                5' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--���½������
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--���¿��������������λ��
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--��̬������������λ��-��̬����(A)
                          TO_CHAR(b.zz_area_reserve+b.SY_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--��̬������������λ��-��������(A1)
                          TO_CHAR(b.ZZ_area_in_process+b.SY_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--��̬������������λ��-��;����(A2)
                          TO_CHAR(b.ZZ_area_stock+ b.sy_Area_stock, '999,999,999,999,999.99') AS "stockCargo",--��̬������������λ��-������(A3)
                          TO_CHAR(b.ZZ_area_haved_sale+b.sy_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--��̬������������λ��-���ۻ���(A4)
                          TO_CHAR(b.ZZ_area_remain+b.sy_area_remain, '999,999,999,999,999.99') AS "residueCargo",--ʣ�����(C=B1+B2+B3)
                          TO_CHAR(b.ZZ_area_allow_sale+b.SY_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--����֤����(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.ZZ_Area_stock + b.ZZ_area_haved_sale +b.SY_Area_stock + b.SY_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR((b.ZZ_area_haved_sale +b.SY_area_haved_sale)/( b.ZZ_Area_stock + b.ZZ_area_haved_sale +b.SY_Area_stock + b.SY_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--ȥ����(E=B4/D)
                          TO_CHAR(b.ZZ_area_not_planning_permit+b.SY_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.ZZ_area_not_construction_per+b.SY_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.ZZ_area_not_sale_permit+b.SY_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.ZZ_area_not_completion+b.SY_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.ZZ_area_yes_completion+b.SY_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.ZZ_area_yes_settlement+b.SY_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--��̬��������λ��-��̬����(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--��̬��������λ��-��������(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--��̬��������λ��-��;����(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--��̬��������λ��-������(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--��̬��������λ��-���ۻ���(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value  b ON a.id= b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;
    
    IF tabsindex = 3 THEN--OR tabsindex = 4 OR tabsindex = 5 THEN
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          a.parent_id      AS "parentId",--����id������������id��
                          project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          level,
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '1' || project_name
                              WHEN level = 2 THEN
                                  '        2' || project_name
                              WHEN level = 3 THEN
                                  '                3' || project_name
                              WHEN level = 4 THEN
                                  '                        4' || project_name
                              ELSE
                                  '                                5' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--���½������
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--���¿��������������λ��
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--��̬������������λ��-��̬����(A)
                          TO_CHAR(b.ZZ_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--��̬������������λ��-��������(A1)
                          TO_CHAR(b.ZZ_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--��̬������������λ��-��;����(A2)
                          TO_CHAR(b.ZZ_area_stock, '999,999,999,999,999.99') AS "stockCargo",--��̬������������λ��-������(A3)
                          TO_CHAR(b.ZZ_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--��̬������������λ��-���ۻ���(A4)
                          TO_CHAR(b.ZZ_area_remain, '999,999,999,999,999.99') AS "residueCargo",--ʣ�����(C=B1+B2+B3)
                          TO_CHAR(b.ZZ_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--����֤����(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.ZZ_Area_stock + b.ZZ_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.ZZ_area_haved_sale /(b.ZZ_area_stock + b.ZZ_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--ȥ����(E=B4/D)
                          TO_CHAR(b.ZZ_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.ZZ_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.ZZ_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.ZZ_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.ZZ_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.ZZ_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--��̬��������λ��-��̬����(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--��̬��������λ��-��������(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--��̬��������λ��-��;����(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--��̬��������λ��-������(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--��̬��������λ��-���ۻ���(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value  b ON a.id= b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;
    
       IF tabsindex = 4 THEN--OR tabsindex = 4 OR tabsindex = 5 THEN
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          a.parent_id      AS "parentId",--����id������������id��
                          project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          level,
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '1' || project_name
                              WHEN level = 2 THEN
                                  '        2' || project_name
                              WHEN level = 3 THEN
                                  '                3' || project_name
                              WHEN level = 4 THEN
                                  '                        4' || project_name
                              ELSE
                                  '                                5' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--���½������
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--���¿��������������λ��
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--��̬������������λ��-��̬����(A)
                          TO_CHAR(b.SY_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--��̬������������λ��-��������(A1)
                          TO_CHAR(b.SY_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--��̬������������λ��-��;����(A2)
                          TO_CHAR(b.SY_area_stock, '999,999,999,999,999.99') AS "stockCargo",--��̬������������λ��-������(A3)
                          TO_CHAR(b.SY_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--��̬������������λ��-���ۻ���(A4)
                          TO_CHAR(b.SY_area_remain, '999,999,999,999,999.99') AS "residueCargo",--ʣ�����(C=B1+B2+B3)
                          TO_CHAR(b.SY_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--����֤����(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.SY_Area_stock + b.SY_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.SY_area_haved_sale /(b.SY_area_stock + b.SY_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--ȥ����(E=B4/D)
                          TO_CHAR(b.SY_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.SY_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.SY_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.SY_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.SY_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.SY_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--��̬��������λ��-��̬����(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--��̬��������λ��-��������(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--��̬��������λ��-��;����(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--��̬��������λ��-������(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--��̬��������λ��-���ۻ���(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value  b ON a.id= b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;
    
       IF tabsindex = 5 THEN--OR tabsindex = 4 OR tabsindex = 5 THEN
        OPEN info FOR SELECT
                          a.id             AS "id",--����id����������id��Ψһ������ҵ��id��
                          a.parent_id      AS "parentId",--����id������������id��
                          project_name   AS "orgName",--��Ŀ/����/ҵ̬/¥��
                          level,
                          level,
                          CASE
                              WHEN level = 1 THEN
                                  '#eaf6ff'
                              WHEN level = 2 THEN
                                  '#ecfbee'
                              WHEN level = 3 THEN
                                  '#f2eed4'
                              ELSE
                                  ''
                          END AS "excelRowBgColor",--�����е���excel����ɫ
                          CASE
                              WHEN level = 1 THEN
                                  '1' || project_name
                              WHEN level = 2 THEN
                                  '        2' || project_name
                              WHEN level = 3 THEN
                                  '                3' || project_name
                              WHEN level = 4 THEN
                                  '                        4' || project_name
                              ELSE
                                  '                                5' || project_name
                          END AS "excelRowTextTreeOrgName",--�ı�ǰ��ӿո�ģ����
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "newestBuildArea",--���½������
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "newestSalesArea",--���¿��������������λ��
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "dynamicCargo",--��̬������������λ��-��̬����(A)
                          TO_CHAR(b.CW_area_reserve, '999,999,999,999,999') AS "reserveCargo",--��̬������������λ��-��������(A1)
                          TO_CHAR(b.CW_area_in_process, '999,999,999,999,999') AS "inProcessTotalCargo",--��̬������������λ��-��;����(A2)
                          TO_CHAR(b.CW_area_stock, '999,999,999,999,999') AS "stockCargo",--��̬������������λ��-������(A3)
                          TO_CHAR(b.CW_area_haved_sale, '999,999,999,999,999') AS "alreadySalesCargo",--��̬������������λ��-���ۻ���(A4)
                          TO_CHAR(b.CW_area_remain, '999,999,999,999,999') AS "residueCargo",--ʣ�����(C=B1+B2+B3)
                          TO_CHAR(b.CW_area_allow_sale, '999,999,999,999,999') AS "getCargo",--����֤����(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.CW_Area_stock + b.CW_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.CW_area_haved_sale /(b.CW_area_stock + b.CW_area_haved_sale) * 100, '999,999,999,999,999'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--ȥ����(E=B4/D)
                          TO_CHAR(b.CW_area_not_planning_permit, '999,999,999,999,999') AS "noPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.CW_area_not_construction_per, '999,999,999,999,999') AS "PermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.CW_area_not_sale_permit, '999,999,999,999,999') AS "constructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.CW_area_not_completion, '999,999,999,999,999') AS "PreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.CW_area_yes_completion, '999,999,999,999,999') AS "completedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.CW_area_yes_settlement, '999,999,999,999,999') AS "carryDownPhase",--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "carportDynamicCargo",--��̬��������λ��-��̬����(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999') AS "carportReserveCargo",--��̬��������λ��-��������(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999') AS "carportInProcessTotalCargo",--��̬��������λ��-��;����(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999') AS "carportStockCargo",--��̬��������λ��-������(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999') AS "carportAlreadySalesCargo",--��̬��������λ��-���ۻ���(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999') AS "carportNoPermitObtainedPhase",--��̬�����ĸ��׶ηֲ���������λ��-0δȡ��֤
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999') AS "carportPermitObtainedOhase",--��̬�����ĸ��׶ηֲ���������λ��-1�滮���֤�׶�
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999') AS "carportConstructionPermitOhase",--��̬�����ĸ��׶ηֲ���������λ��-2ʩ�����֤�׶�
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999') AS "carportPreSalePermitPhase",--��̬�����ĸ��׶ηֲ���������λ��-3Ԥ�����֤�׶�
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999') AS "carportCompletedRecordPhase",--��̬�����ĸ��׶ηֲ���������λ��-4�����׶�
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999') AS "carportCarryDownPhase"--��̬�����ĸ��׶ηֲ���������λ��-5��ת�׶�
                      FROM
                          (
                              SELECT
                                  id,
                                  project_name,
                                  '' AS parent_id,
                                  sn AS order_code
                              FROM
                                  sys_project
                              WHERE
                                  id = ''
                                       || projectid
                                       || ''
                              UNION ALL
--����
                              SELECT
                                  id,
                                  stage_name,
                                  project_id AS parent_id,
                                  lpad(regexp_substr(stage_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  sys_project_stage
                              WHERE
                                  project_id = ''
                                               || projectid
                                               || ''
                                  AND stage_name <> '�޷���'
                              UNION ALL
--¥��
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '�޷���' THEN
                                              period_id
                                          ELSE
                                              mdm_build.proj_id
                                      END
                                  ) AS parent_id,
                                  lpad(regexp_substr(build_name, '[0-9]+'), 9, '0') AS order_code
                              FROM
                                  mdm_build left
                                  JOIN mdm_period ON mdm_build.period_id = mdm_period.id
                              WHERE
                                  proj_id = ''
                                            || projectid
                                            || ''
                                  AND build_state = 10--10�ѷ���¥��
                          ) a LEFT JOIN dwm_dt_value  b ON a.id= b.obj_id
                      START WITH
                          a.id = ''
                                 || projectid
                                 || ''
                      CONNECT BY
                          PRIOR a.id = a.parent_id
                      ORDER BY
                          substr(sys_connect_by_path(a.order_code, ','), 2);

    END IF;

END p_dwm_dt_area_dtl;