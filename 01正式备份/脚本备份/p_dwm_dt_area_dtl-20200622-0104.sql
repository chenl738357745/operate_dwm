create or replace PROCEDURE p_dwm_dt_area_dtl (
    userid         IN             VARCHAR2, --当前用户id
    stationid      IN             VARCHAR2, --当前用户岗位id
    departmentid   IN             VARCHAR2, --当前用户部门id
    companyid      IN             VARCHAR2, --当前用户公司id
    projectid      IN             VARCHAR2, --选择公司id
    tabsindex      IN             VARCHAR2, --选择选项卡。1开始
    isoperate      IN             VARCHAR2,--是否操盘
    info           OUT            SYS_REFCURSOR
) AS
--动态货量管理-全案动态货量-穿透详情
--作者：陈丽
--日期：2019/12/17
    data_auth_spid   VARCHAR2(200);
    bizcode          VARCHAR2(200);
BEGIN
    IF tabsindex = 1 THEN
        dbms_output.put_line('所有业态!');
    ELSIF tabsindex = 2 THEN
        dbms_output.put_line('住宅及商办!');
    ELSIF tabsindex = 3 THEN
        dbms_output.put_line('住宅!');
    ELSIF tabsindex = 4 THEN
        dbms_output.put_line('商办!');
    ELSIF tabsindex = 5 THEN
        dbms_output.put_line('车位!');
    ELSe--IF tabsindex = 6 THEN
        dbms_output.put_line('剩余货量表!');
        OPEN info FOR SELECT
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          a.project_name   AS "orgName",--项目/分期/业态/楼栋
                          b.ZZ_area_remain AS "projWholeDwellingArea",--项目全案剩余可售货量（S=A+B+C+D）-住宅(m2)
                           b.SY_area_remain AS "projWholeBusinessArea",--项目全案剩余可售货量（S=A+B+C+D）-商业(m2)
                           b.CW_area_remain AS "projWholeCarport",--项目全案剩余可售货量（S=A+B+C+D）-车位(个)
                          b.area_remain AS "projWholeTotalArea",--项目全案剩余可售货量（S=A+B+C+D）-合计(m2)
                           b.zz_area_not_planning_permit AS "ADwellingArea",--A未取规证的可售货量-住宅(m2)
                           b.sy_area_not_planning_permit AS "ABusinessArea",--A未取规证的可售货量-商业(m2)
                           b.CW_Area_not_planning_permit AS "ACarport",--A未取规证的可售货量-车位(个)
                           b.Area_not_planning_permit AS "ATotalArea",--A未取规证的可售货量-合计(m2)
                          b.zz_area_not_construction_per AS "BDwellingArea",--B已取规证未取施工证的可售货量-住宅(m2)
                          b.SY_area_not_construction_per AS "BBusinessArea",--B已取规证未取施工证的可售货量-商业(m2)
                          b.CW_area_not_construction_per AS "BCarport",--B已取规证未取施工证的可售货量-车位(个)
                          b.area_not_construction_permit AS "BTotalArea",--B已取规证未取施工证的可售货量-合计(m2)
                          b.zz_area_not_sale_permit "CDwellingArea",--C已取规证未取预售证的可售货量-住宅(m2)
                         b.SY_area_not_sale_permit AS "CBusinessArea",--C已取规证未取预售证的可售货量-商业(m2)
                          b.CW_area_not_sale_permit AS "CCarport",--C已取规证未取预售证的可售货量-车位(个)
                          b.area_not_sale_permit AS "CTotalArea",--C已取规证未取预售证的可售货量-合计(m2)
                          b.zz_area_stock AS "DDwellingArea",--D已取预售证未售的可售货量-住宅(m2)
                          b.SY_area_stock AS "DBusinessArea",--D已取预售证未售的可售货量-商业(m2)
                          b.CW_area_stock AS "DCarport",--D已取预售证未售的可售货量-车位(个)
                          b.area_Stock AS "DTotalArea"--D已取预售证未售的可售货量-合计(m2)
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          project_name   AS "orgName",--项目/分期/业态/楼栋
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--最新建筑面积
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--最新可售面积（不含车位）
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--动态货量（不含车位）-动态货量(A)
                          TO_CHAR(b.area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--动态货量（不含车位）-储备货量(A1)
                          TO_CHAR(b.area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--动态货量（不含车位）-在途货量(A2)
                          TO_CHAR(b.area_stock, '999,999,999,999,999.99') AS "stockCargo",--动态货量（不含车位）-库存货量(A3)
                          TO_CHAR(b.area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--动态货量（不含车位）-已售货量(A4)
                          TO_CHAR(b.area_remain, '999,999,999,999,999.99') AS "residueCargo",--剩余货量(C=B1+B2+B3)
                          TO_CHAR(b.area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--已领证货量(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.Area_stock + b.area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.area_haved_sale /(b.area_stock + b.area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--去化率(E=B4/D)
                          TO_CHAR(b.area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.area_not_construction_permit, '999,999,999,999,999.99') AS "PermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--动态货量的各阶段分布（不含车位）-5结转阶段
                          TO_CHAR(b.area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--动态货量（车位）-动态货量(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--动态货量（车位）-储备货量(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--动态货量（车位）-在途货量(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--动态货量（车位）-库存货量(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--动态货量（车位）-已售货量(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--动态货量的各阶段分布（不含车位）-5结转阶段
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          project_name   AS "orgName",--项目/分期/业态/楼栋
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--最新建筑面积
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--最新可售面积（不含车位）
                          TO_CHAR(b.ZZ_area_dt_all+b.SY_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--动态货量（不含车位）-动态货量(A)
                          TO_CHAR(b.zz_area_reserve+b.SY_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--动态货量（不含车位）-储备货量(A1)
                          TO_CHAR(b.ZZ_area_in_process+b.SY_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--动态货量（不含车位）-在途货量(A2)
                          TO_CHAR(b.ZZ_area_stock+ b.sy_Area_stock, '999,999,999,999,999.99') AS "stockCargo",--动态货量（不含车位）-库存货量(A3)
                          TO_CHAR(b.ZZ_area_haved_sale+b.sy_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--动态货量（不含车位）-已售货量(A4)
                          TO_CHAR(b.ZZ_area_remain+b.sy_area_remain, '999,999,999,999,999.99') AS "residueCargo",--剩余货量(C=B1+B2+B3)
                          TO_CHAR(b.ZZ_area_allow_sale+b.SY_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--已领证货量(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.ZZ_Area_stock + b.ZZ_area_haved_sale +b.SY_Area_stock + b.SY_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR((b.ZZ_area_haved_sale +b.SY_area_haved_sale)/( b.ZZ_Area_stock + b.ZZ_area_haved_sale +b.SY_Area_stock + b.SY_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--去化率(E=B4/D)
                          TO_CHAR(b.ZZ_area_not_planning_permit+b.SY_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.ZZ_area_not_construction_per+b.SY_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.ZZ_area_not_sale_permit+b.SY_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.ZZ_area_not_completion+b.SY_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.ZZ_area_yes_completion+b.SY_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.ZZ_area_yes_settlement+b.SY_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--动态货量的各阶段分布（不含车位）-5结转阶段
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--动态货量（车位）-动态货量(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--动态货量（车位）-储备货量(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--动态货量（车位）-在途货量(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--动态货量（车位）-库存货量(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--动态货量（车位）-已售货量(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--动态货量的各阶段分布（不含车位）-5结转阶段
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          project_name   AS "orgName",--项目/分期/业态/楼栋
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--最新建筑面积
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--最新可售面积（不含车位）
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--动态货量（不含车位）-动态货量(A)
                          TO_CHAR(b.ZZ_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--动态货量（不含车位）-储备货量(A1)
                          TO_CHAR(b.ZZ_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--动态货量（不含车位）-在途货量(A2)
                          TO_CHAR(b.ZZ_area_stock, '999,999,999,999,999.99') AS "stockCargo",--动态货量（不含车位）-库存货量(A3)
                          TO_CHAR(b.ZZ_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--动态货量（不含车位）-已售货量(A4)
                          TO_CHAR(b.ZZ_area_remain, '999,999,999,999,999.99') AS "residueCargo",--剩余货量(C=B1+B2+B3)
                          TO_CHAR(b.ZZ_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--已领证货量(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.ZZ_Area_stock + b.ZZ_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.ZZ_area_haved_sale /(b.ZZ_area_stock + b.ZZ_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--去化率(E=B4/D)
                          TO_CHAR(b.ZZ_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.ZZ_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.ZZ_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.ZZ_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.ZZ_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.ZZ_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--动态货量的各阶段分布（不含车位）-5结转阶段
                          TO_CHAR(b.ZZ_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--动态货量（车位）-动态货量(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--动态货量（车位）-储备货量(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--动态货量（车位）-在途货量(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--动态货量（车位）-库存货量(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--动态货量（车位）-已售货量(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--动态货量的各阶段分布（不含车位）-5结转阶段
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          project_name   AS "orgName",--项目/分期/业态/楼栋
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestBuildArea",--最新建筑面积
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "newestSalesArea",--最新可售面积（不含车位）
                          TO_CHAR(b.SY_area_dt_all, '999,999,999,999,999.99') AS "dynamicCargo",--动态货量（不含车位）-动态货量(A)
                          TO_CHAR(b.SY_area_reserve, '999,999,999,999,999.99') AS "reserveCargo",--动态货量（不含车位）-储备货量(A1)
                          TO_CHAR(b.SY_area_in_process, '999,999,999,999,999.99') AS "inProcessTotalCargo",--动态货量（不含车位）-在途货量(A2)
                          TO_CHAR(b.SY_area_stock, '999,999,999,999,999.99') AS "stockCargo",--动态货量（不含车位）-库存货量(A3)
                          TO_CHAR(b.SY_area_haved_sale, '999,999,999,999,999.99') AS "alreadySalesCargo",--动态货量（不含车位）-已售货量(A4)
                          TO_CHAR(b.SY_area_remain, '999,999,999,999,999.99') AS "residueCargo",--剩余货量(C=B1+B2+B3)
                          TO_CHAR(b.SY_area_allow_sale, '999,999,999,999,999.99') AS "getCargo",--已领证货量(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.SY_Area_stock + b.SY_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.SY_area_haved_sale /(b.SY_area_stock + b.SY_area_haved_sale) * 100, '999,999,999,999,999.99'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--去化率(E=B4/D)
                          TO_CHAR(b.SY_area_not_planning_permit, '999,999,999,999,999.99') AS "noPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.SY_area_not_construction_per, '999,999,999,999,999.99') AS "PermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.SY_area_not_sale_permit, '999,999,999,999,999.99') AS "constructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.SY_area_not_completion, '999,999,999,999,999.99') AS "PreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.SY_area_yes_completion, '999,999,999,999,999.99') AS "completedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.SY_area_yes_settlement, '999,999,999,999,999.99') AS "carryDownPhase",--动态货量的各阶段分布（不含车位）-5结转阶段
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999.99') AS "carportDynamicCargo",--动态货量（车位）-动态货量(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999.99') AS "carportReserveCargo",--动态货量（车位）-储备货量(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999.99') AS "carportInProcessTotalCargo",--动态货量（车位）-在途货量(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999.99') AS "carportStockCargo",--动态货量（车位）-库存货量(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999.99') AS "carportAlreadySalesCargo",--动态货量（车位）-已售货量(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999.99') AS "carportNoPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999.99') AS "carportPermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999.99') AS "carportConstructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999.99') AS "carportPreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999.99') AS "carportCompletedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999.99') AS "carportCarryDownPhase"--动态货量的各阶段分布（不含车位）-5结转阶段
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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
                          a.id             AS "id",--主键id（生成树的id，唯一可以是业务id）
                          a.parent_id      AS "parentId",--父级id（生成树父级id）
                          project_name   AS "orgName",--项目/分期/业态/楼栋
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
                          END AS "excelRowBgColor",--数据行导出excel背景色
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
                          END AS "excelRowTextTreeOrgName",--文本前面加空格模仿树
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "newestBuildArea",--最新建筑面积
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "newestSalesArea",--最新可售面积（不含车位）
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "dynamicCargo",--动态货量（不含车位）-动态货量(A)
                          TO_CHAR(b.CW_area_reserve, '999,999,999,999,999') AS "reserveCargo",--动态货量（不含车位）-储备货量(A1)
                          TO_CHAR(b.CW_area_in_process, '999,999,999,999,999') AS "inProcessTotalCargo",--动态货量（不含车位）-在途货量(A2)
                          TO_CHAR(b.CW_area_stock, '999,999,999,999,999') AS "stockCargo",--动态货量（不含车位）-库存货量(A3)
                          TO_CHAR(b.CW_area_haved_sale, '999,999,999,999,999') AS "alreadySalesCargo",--动态货量（不含车位）-已售货量(A4)
                          TO_CHAR(b.CW_area_remain, '999,999,999,999,999') AS "residueCargo",--剩余货量(C=B1+B2+B3)
                          TO_CHAR(b.CW_area_allow_sale, '999,999,999,999,999') AS "getCargo",--已领证货量(D=B3+B4)
                          (
                            CASE
                                WHEN ( b.CW_Area_stock + b.CW_area_haved_sale ) = 0 THEN
                                    '-'
                                ELSE
                                    TO_CHAR(b.CW_area_haved_sale /(b.CW_area_stock + b.CW_area_haved_sale) * 100, '999,999,999,999,999'
                                    )
                                    || '%'
                            END
                        )  AS "salesRate",--去化率(E=B4/D)
                          TO_CHAR(b.CW_area_not_planning_permit, '999,999,999,999,999') AS "noPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.CW_area_not_construction_per, '999,999,999,999,999') AS "PermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.CW_area_not_sale_permit, '999,999,999,999,999') AS "constructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.CW_area_not_completion, '999,999,999,999,999') AS "PreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.CW_area_yes_completion, '999,999,999,999,999') AS "completedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.CW_area_yes_settlement, '999,999,999,999,999') AS "carryDownPhase",--动态货量的各阶段分布（不含车位）-5结转阶段
                          TO_CHAR(b.CW_area_dt_all, '999,999,999,999,999') AS "carportDynamicCargo",--动态货量（车位）-动态货量(A)
                          TO_CHAR(b.cw_area_reserve, '999,999,999,999,999') AS "carportReserveCargo",--动态货量（车位）-储备货量(A1)
                          TO_CHAR(b.cw_area_in_process, '999,999,999,999,999') AS "carportInProcessTotalCargo",--动态货量（车位）-在途货量(A2)
                          TO_CHAR(b.cw_area_stock, '999,999,999,999,999') AS "carportStockCargo",--动态货量（车位）-库存货量(A3)
                          TO_CHAR(b.cw_area_haved_sale, '999,999,999,999,999') AS "carportAlreadySalesCargo",--动态货量（车位）-已售货量(A4)
                          TO_CHAR(b.cw_area_not_planning_permit, '999,999,999,999,999') AS "carportNoPermitObtainedPhase",--动态货量的各阶段分布（不含车位）-0未取规证
                          TO_CHAR(b.cw_area_not_construction_per, '999,999,999,999,999') AS "carportPermitObtainedOhase",--动态货量的各阶段分布（不含车位）-1规划许可证阶段
                          TO_CHAR(b.cw_area_not_sale_permit, '999,999,999,999,999') AS "carportConstructionPermitOhase",--动态货量的各阶段分布（不含车位）-2施工许可证阶段
                          TO_CHAR(b.cw_area_not_completion, '999,999,999,999,999') AS "carportPreSalePermitPhase",--动态货量的各阶段分布（不含车位）-3预售许可证阶段
                          TO_CHAR(b.cw_value_yes_completion, '999,999,999,999,999') AS "carportCompletedRecordPhase",--动态货量的各阶段分布（不含车位）-4竣备阶段
                          TO_CHAR(b.cw_area_yes_settlement, '999,999,999,999,999') AS "carportCarryDownPhase"--动态货量的各阶段分布（不含车位）-5结转阶段
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
--分期
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
                                  AND stage_name <> '无分期'
                              UNION ALL
--楼栋
                              SELECT
                                  mdm_build.id,
                                  build_name,
                                  (
                                      CASE
                                          WHEN mdm_period.period_name <> '无分期' THEN
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
                                  AND build_state = 10--10已发布楼栋
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