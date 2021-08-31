--------------------------------------------------------
--  文件已创建 - 星期五-四月-16-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CL_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "CL_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --输入变量：部门id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR) IS --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07
--修改人：chenl
--修改日期：2021/03/02

    v_spid VARCHAR2(200);
BEGIN
    P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    OPEN item for
    with base as (
    select * from(
            select DISTINCT  n.ID,
                    p.ORIGINAL_PLAN_ID,
                    n.ORIGINAL_NODE_ID,
                    n.NODE_NAME,
                    n.PROJ_PLAN_ID,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值 from V_POM_PROJ_PLAN_NODE node                  
                   FROM V_POM_PROJ_PLAN_NODE n
                LEFT JOIN V_POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                LEFT JOIN (
                    SELECT B.*FROM (
                        SELECT A.*, ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A
                    ) B WHERE RN = 1
                ) f on f.feedback_node_id=n.id
                inner join (
                     select DISTINCT org_id AS orgid
                     from TMP_AUTH_LIST
                     where id = v_spid) tal on instr(sps.PROJECT_ID||p.proj_id||DUTY_DEPARTMENT_ID,tal.orgId) > 0
                WHERE  (p.PLAN_TYPE='项目主项计划' or p.PLAN_TYPE='关键节点计划' or p.PLAN_TYPE='专项计划')
                and p.APPROVAL_STATUS='已审核'  AND n.IS_DISABLE=0 AND n.IS_DELETE=0
                and (condition is null or DUTY_DEPARTMENT_ID=condition)
            ) n 
            left join (
                SELECT node_id,
                LISTAGG( to_char(charge_person), ',') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                FROM POM_NODE_CHARGE_PERSON group by node_id
            ) cp on n.id=cp.NODE_ID
            WHERE (n.NODE_NAME LIKE '%'||searchcondition||'%' OR  n.PLAN_NAME LIKE '%'||searchcondition||'%'
            OR n.PROJ_NAME LIKE '%'||searchcondition||'%' OR n. DUTY_DEPARTMENT LIKE '%'||searchcondition||'%'
            OR cp.charge_person like '%'||searchcondition||'%' )
    )
        SELECT SUM(nvl(ACOUNT, 0)) AS ACOUNT,
               SUM(nvl(BCOUNT, 0)) AS BCOUNT,
               SUM(nvl(CCOUNT, 0)) AS CCOUNT,
               SUM(nvl(DCOUNT, 0)) AS DCOUNT,
               SUM(nvl(ECOUNT, 0)) AS ECOUNT,
               SUM(nvl(FCOUNT, 0)) AS FCOUNT,
               SUM(nvl(GCOUNT, 0)) AS GCOUNT,
               SUM(nvl(HCOUNT, 0)) AS HCOUNT
        FROM (
                 SELECT
                     sum(CASE WHEN trunc(node.PLAN_END_DATE, 'month') = trunc(SYSDATE, 'month')
                         and node.ACTUAL_END_DATE is null THEN 1 ELSE 0 END)                                                                              AS                           ACOUNT,
                     SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END) BCOUNT,
                     SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END)     AS                           CCOUNT,
                     SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) AS                           DCOUNT,
                     COUNT(*)                                                          AS                           ECOUNT,
                     SUM(CASE WHEN (node.PLAN_END_DATE >= last_day(trunc(SYSDATE)) + 1
                         AND node.PLAN_END_DATE <= last_day(last_day(trunc(SYSDATE)) + 1)
                         ) THEN 1 ELSE 0 END)                                      AS                           FCOUNT,
                     SUM(CASE WHEN( node.PLAN_END_DATE >= trunc(SYSDATE, 'Q')
                         AND node.PLAN_END_DATE <= add_months(trunc(SYSDATE, 'Q'), 3) - 1
                         ) THEN 1 ELSE 0 END)                                      AS                           GCOUNT,
                     SUM(CASE WHEN (node.PLAN_END_DATE >= trunc(SYSDATE, 'yyyy')
                         AND node.PLAN_END_DATE <= add_months(trunc(SYSDATE, 'yyyy'), 12) - 1
                         ) THEN 1 ELSE 0 END) AS HCOUNT
                 FROM base  node
             );
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
    --orgtype IN VARCHAR2, --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,,本人
    condition IN VARCHAR2, --输入变量：公司id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
    --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07
    v_spid              VARCHAR2(200);
BEGIN
    --调用数据权限验证存储过程
    P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );

    OPEN item FOR
        SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
        FROM(
            SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                                  (node.PLAN_END_DATE >= trunc(SYSDATE, 'month') AND node.PLAN_END_DATE <= trunc(last_day(SYSDATE)))
                                 THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL
                    AND TO_CHAR(SYSDATE, 'yyyy-mm-dd') > TO_CHAR(node.PLAN_END_DATE, 'yyyy-mm-dd')
                                 THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
                NVL(SUM(CASE WHEN (
                            node.PLAN_END_DATE >= last_day( trunc( SYSDATE ) ) + 1
                        AND node.PLAN_END_DATE <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
                    ) THEN 1 ELSE 0 END),0) AS FCOUNT,
                NVL(SUM(CASE WHEN  (
                            node.PLAN_END_DATE >= trunc( SYSDATE, 'Q' )
                        AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
                    ) THEN 1 ELSE 0 END),0) AS GCOUNT,
                NVL(SUM(CASE WHEN (
                            node.PLAN_END_DATE >= trunc( SYSDATE, 'yyyy' )
                        AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
                    ) THEN 1 ELSE 0 END),0) AS HCOUNT
            FROM POM_PROJ_PLAN_NODE node
            LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
            LEFT JOIN (
                SELECT node_id,LISTAGG( to_char(charge_person), ',')
                                        WITHIN GROUP(ORDER BY charge_person) AS charge_person
                FROM POM_NODE_CHARGE_PERSON group by node_id
            ) person on node.id=person.NODE_ID
            LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
            LEFT JOIN (
                select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||''
            ) tal ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
            WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '项目主项计划' OR plan.PLAN_TYPE = '关键节点计划' )
              AND plan.APPROVAL_STATUS = '已审核' AND node.IS_DISABLE=0
              AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
              AND (condition is null or node.COMPANY_ID in (
                select sbu.id from SYS_BUSINESS_UNIT sbu
                start with sbu.id = '' || condition ||'' connect by prior sbu.id = sbu.PARENT_ID)
                )
            UNION ALL
            SELECT
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                                  ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                                 THEN  1 ELSE 0 END), 0)AS ACOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                COUNT(*) AS ECOUNT,
                NVL(SUM(CASE WHEN (
                            node.PLAN_END_DATE >= last_day( trunc( SYSDATE ) ) + 1
                        AND node.PLAN_END_DATE <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
                    ) THEN 1 ELSE 0 END),0) AS FCOUNT,
                NVL(SUM(CASE WHEN  (
                            node.PLAN_END_DATE >= trunc( SYSDATE, 'Q' )
                        AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
                    ) THEN 1 ELSE 0 END),0) AS GCOUNT,
                NVL(SUM(CASE WHEN (
                            node.PLAN_END_DATE >= trunc( SYSDATE, 'yyyy' )
                        AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
                    ) THEN 1 ELSE 0 END),0) AS HCOUNT
            FROM POM_SPECIAL_PLAN_NODE node
            LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
            LEFT JOIN (SELECT node_id,LISTAGG( to_char(charge_person), ',') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                       FROM POM_NODE_CHARGE_PERSON group by node_id) person on node.id=person.NODE_ID
            LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=node.COMPANY_ID
            WHERE tal.orgid is not null AND node.ACTUAL_END_DATE IS NULL
              AND plan.APPROVAL_STATUS = '已审核' AND	node.IS_DELETE=0
              AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
              AND (condition is null or node.COMPANY_ID in (
                select sbu.id from SYS_BUSINESS_UNIT sbu
                start with sbu.id = '' || condition ||'' connect by prior sbu.id = sbu.PARENT_ID
            )
                )
--                UNION ALL
--                SELECT
--                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
--                ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
--                THEN  1 ELSE 0 END), 0)AS ACOUNT,
--                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
--                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
--                NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
--                COUNT(*) AS ECOUNT,
--                NVL(SUM(CASE WHEN (
--						node.PLAN_END_DATE >= last_day( trunc( SYSDATE ) ) + 1
--						AND node.PLAN_END_DATE <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
--					) THEN 1 ELSE 0 END),0) AS FCOUNT,
--                NVL(SUM(CASE WHEN  (
--						node.PLAN_END_DATE >= trunc( SYSDATE, 'Q' )
--						AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
--					) THEN 1 ELSE 0 END),0) AS GCOUNT,
--                NVL(SUM(CASE WHEN (
--						node.PLAN_END_DATE >= trunc( SYSDATE, 'yyyy' )
--						AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
--					) THEN 1 ELSE 0 END),0) AS HCOUNT
--                FROM
--                pom_dept_monthly_plan_node node
--					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
--                    LEFT JOIN (SELECT node_id,LISTAGG( to_char(charge_person), ',') WITHIN GROUP(ORDER BY charge_person) AS charge_person
--                    FROM POM_NODE_CHARGE_PERSON group by node_id) person on node.id=person.NODE_ID
--                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'')  tal on tal.orgid=plan.DEPT_ID or tal.orgid=plan.COMPANY_ID
--                    WHERE tal.orgid is not null
--					AND APPROVE_STATUS = '已审核'
--					AND (node.IS_DEL=0 OR node.IS_DEL=null)
--                     AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
--                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
--					AND plan.COMPANY_ID in (select sbu.id
--                            from SYS_BUSINESS_UNIT sbu
--                            start with sbu.id = '' || condition ||''
--                            connect by prior sbu.id = sbu.PARENT_ID)

        );

END P_POM_SMART_CURRENTCOMPANY_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --输入变量：部门id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR) IS --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07

    v_spid VARCHAR2(200);
BEGIN
    P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    OPEN item for
        SELECT SUM(nvl(ACOUNT, 0)) AS ACOUNT,
               SUM(nvl(BCOUNT, 0)) AS BCOUNT,
               SUM(nvl(CCOUNT, 0)) AS CCOUNT,
               SUM(nvl(DCOUNT, 0)) AS DCOUNT,
               SUM(nvl(ECOUNT, 0)) AS ECOUNT,
               SUM(nvl(FCOUNT, 0)) AS FCOUNT,
               SUM(nvl(GCOUNT, 0)) AS GCOUNT,
               SUM(nvl(HCOUNT, 0)) AS HCOUNT
        FROM (
            SELECT
                sum(CASE WHEN trunc(node.PLAN_END_DATE, 'month') = trunc(SYSDATE, 'month')
                    and node.ACTUAL_END_DATE is null THEN 1 ELSE 0 END)                                                                              AS                           ACOUNT,
                SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END) BCOUNT,
                SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END)     AS                           CCOUNT,
                SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END) AS                           DCOUNT,
                COUNT(*)                                                          AS                           ECOUNT,
                SUM(CASE WHEN (node.PLAN_END_DATE >= last_day(trunc(SYSDATE)) + 1
                    AND node.PLAN_END_DATE <= last_day(last_day(trunc(SYSDATE)) + 1)
                    ) THEN 1 ELSE 0 END)                                      AS                           FCOUNT,
                SUM(CASE WHEN( node.PLAN_END_DATE >= trunc(SYSDATE, 'Q')
                    AND node.PLAN_END_DATE <= add_months(trunc(SYSDATE, 'Q'), 3) - 1
                    ) THEN 1 ELSE 0 END)                                      AS                           GCOUNT,
                SUM(CASE WHEN (node.PLAN_END_DATE >= trunc(SYSDATE, 'yyyy')
                    AND node.PLAN_END_DATE <= add_months(trunc(SYSDATE, 'yyyy'), 12) - 1
                    ) THEN 1 ELSE 0 END) AS HCOUNT
            FROM V_POM_PROJ_PLAN_NODE node
            LEFT JOIN V_POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
            LEFT JOIN (
                SELECT listagg(CHARGE_PERSON, ',') within GROUP (order by CHARGE_PERSON ) CHARGE_PERSON, NODE_ID
                FROM POM_NODE_CHARGE_PERSON
                GROUP BY NODE_ID
            ) person ON node.ID = person.NODE_ID
            LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id = sps.id
            INNER JOIN (
                select DISTINCT org_id AS orgid
                from TMP_AUTH_LIST
                where id = v_spid
            ) tal ON instr(node.DUTY_DEPARTMENT_ID, tal.orgId) > 0
            WHERE (plan.PLAN_TYPE = '项目主项计划' OR plan.PLAN_TYPE = '关键节点计划' OR plan.PLAN_TYPE='专项计划')
              AND plan.APPROVAL_STATUS = '已审核' AND node.IS_DISABLE = 0 and node.IS_DELETE = 0
              AND (searchcondition is null or instr(node.node_name||'$#$'||plan.plan_name||'$#$'
                                                        ||plan.PROJ_NAME||'$#$'||node.DUTY_DEPARTMENT||'$#$'||person.CHARGE_PERSON||'$#$',
                                                    searchcondition||'$#$') > 0)
              AND (condition is null or node.DUTY_DEPARTMENT_ID = condition)
        );
end;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
    --orgtype IN VARCHAR2, --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,,本人
    condition IN VARCHAR2, --输入变量：项目id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
    --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07
    v_spid              VARCHAR2(200);
BEGIN
    --调用数据权限验证存储过程
    P_SYS_AUTH_DATA_RULE_SPID(
            USERID => currentuserid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    OPEN item FOR
        SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT,
            SUM(DCOUNT) AS DCOUNT,
            SUM(ECOUNT) AS ECOUNT,
            SUM(FCOUNT) AS FCOUNT,
            SUM(GCOUNT) AS GCOUNT,
            SUM(HCOUNT) AS HCOUNT
        FROM(
            SELECT NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND
                                     ( node.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND node.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                                    THEN  1 ELSE 0 END), 0)AS ACOUNT,
                   NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                   NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
                   NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
                   COUNT(node.id) AS ECOUNT,
                   NVL(SUM(CASE WHEN (
                               node.PLAN_END_DATE >= last_day( trunc( SYSDATE ) ) + 1
                           AND node.PLAN_END_DATE <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
                       ) THEN 1 ELSE 0 END),0) AS FCOUNT,
                   NVL(SUM(CASE WHEN  (
                               node.PLAN_END_DATE >= trunc( SYSDATE, 'Q' )
                           AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'Q' ), 3 ) - 1
                       ) THEN 1 ELSE 0 END),0) AS GCOUNT,
                   NVL(SUM(CASE WHEN (
                               node.PLAN_END_DATE >= trunc( SYSDATE, 'yyyy' )
                           AND node.PLAN_END_DATE <= add_months( trunc( SYSDATE, 'yyyy' ), 12 ) - 1
                       ) THEN 1 ELSE 0 END),0) AS HCOUNT
            FROM
                POM_PROJ_PLAN_NODE node
                LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                LEFT JOIN (
                    SELECT  listagg(CHARGE_PERSON,',') within GROUP(order by CHARGE_PERSON ) CHARGE_PERSON,NODE_ID
                    FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID
                )  person ON node.ID=person.NODE_ID
                LEFT JOIN SYS_PROJECT_STAGE sps on plan.proj_id=sps.id
                LEFT JOIN (
                    select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||''
                ) tal ON (case when sps.id is not null then sps.PROJECT_ID else plan.proj_id end)=tal.orgId
            WHERE tal.orgid is not null AND ( plan.PLAN_TYPE = '项目主项计划' OR plan.PLAN_TYPE = '关键节点计划' )
              AND plan.APPROVAL_STATUS = '已审核'
              AND node.IS_DISABLE=0
              AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%'
                OR person.CHARGE_PERSON like '%'||searchcondition||'%')
              AND (condition is null or (plan.PROJ_ID=''||condition||'' OR plan.PROJ_ID IN(
                SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''||condition||'')))
        );
END P_POM_SMART_CURRENTPROJ_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPSRSON_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" (
		condition IN VARCHAR2, --输入变量：当前用户ID
        searchcondition IN          VARCHAR2,--模糊查询条件
        item OUT SYS_REFCURSOR ) IS --任务中心tabs任务条数统计数据源
--作者：yedr
--日期：2020/04/07

    v_spid              VARCHAR2(200);
	BEGIN
    OPEN item FOR SELECT
            SUM(ACOUNT) AS ACOUNT,
            SUM(BCOUNT) AS BCOUNT,
            SUM(CCOUNT) AS CCOUNT
            FROM(
                SELECT
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS ACOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS CCOUNT
                    FROM
                    POM_PROJ_PLAN_NODE node
                    LEFT JOIN POM_PROJ_PLAN plan ON node.PROJ_PLAN_ID = plan.ID
                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
                    WHERE  (plan.PLAN_TYPE = '项目主项计划' OR  plan.PLAN_TYPE = '关键节点计划')
                    AND plan.APPROVAL_STATUS = '已审核'
                    AND node.IS_DISABLE=0
                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
                    OR plan.PROJ_NAME like '%'||searchcondition||'%' OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
                    AND person.CHARGE_PERSON_ID = '' || condition || ''
--                UNION ALL
--                SELECT
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS ACOUNT,
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS CCOUNT
--                    FROM POM_SPECIAL_PLAN_NODE node
--					LEFT JOIN POM_SPECIAL_PLAN plan ON node.PLAN_ID = plan.ID
--                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
--                    WHERE node.ACTUAL_END_DATE IS NULL
--					AND plan.APPROVAL_STATUS = '已审核'
--					AND	node.IS_DELETE=0
--                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
--                    OR node.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')
--                    AND person.CHARGE_PERSON_ID = '' || condition || ''
--                UNION ALL
--                SELECT
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NULL AND SYSDATE > node.PLAN_END_DATE THEN 1 ELSE 0 END),0)AS BCOUNT,
--                    NVL(SUM(CASE WHEN node.ACTUAL_END_DATE IS NOT NULL THEN 1 ELSE 0 END),0) AS ECOUNT
--                    FROM pom_dept_monthly_plan_node node
--					LEFT JOIN pom_dept_monthly_plan plan ON node.dept_monthly_plan_id = plan.id
--                    LEFT JOIN POM_NODE_CHARGE_PERSON person ON node.ID = person.node_id
--                    WHERE APPROVE_STATUS = '已审核'
--					AND (node.IS_DEL=0 OR node.IS_DEL=null)
--                    AND person.CHARGE_PERSON_ID = '' || condition || ''
--                    AND (node.node_name like '%'||searchcondition||'%' OR plan.plan_name like '%'||searchcondition||'%'
--                    OR plan.DEPT_NAME like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%')

            );

END P_POM_SMART_CURRENTPSRSON_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid IN VARCHAR2,--输入变量：公司id
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--用户id用于过滤关注的任务
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    pageindex IN INT,
    pagesizes IN INT,
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    items OUT SYS_REFCURSOR,
    total OUT INT
--  spiditems         OUT           SYS_REFCURSOR
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2019/11/15
    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content       CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    v_spid              VARCHAR2(200);--数据权限验证spid
    testmsg             CLOB;
    v_where_like       CLOB;
    v_next_line VARCHAR(30);
    company_ids        CLOB;
    spcil_sql           CLOB;
    plan_expression     varchar2(4000);
BEGIN
    ----------------------------------------------------统一解析
    testmsg := 'companyid:'
        || companyid
        || '；pageindex:'
        || pageindex
        || '；pagesizes:'
        || pagesizes
        || '；currenttype:'
        || currenttype;

    --通过id获取三级子公司
    company_ids :=
                'select sbu.id
                from SYS_BUSINESS_UNIT sbu
                start with sbu.id = ''' || companyid || '''
        connect by prior sbu.id = sbu.PARENT_ID';

    BEGIN
        total := 1000;
        v_next_line := '';
        v_sql_start := v_next_line || 'case ';
        v_sql_content := v_next_line;
        v_sql_end := v_next_line || ' else '''' end  ';
        --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );

        --1.拼接查询语句
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                  --AND plan_type = '关键节点计划'
                  AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划'
                THEN plan_expression := '
                    then (''' || item.expression || ''') ';
                ELSE plan_expression := '
                    then (' || item.expression || ') ';
                END IF ;
                ---拼接字符串
                v_sql_content := v_sql_content || 'when plan_type='''
                    || CASE item.plan_type WHEN '项目全景计划' THEN '项目主项计划' ELSE item.plan_type END
                    || '''
                and node_level=''' || item.node_level  || '''' ||plan_expression ||v_next_line;
            END LOOP;

        --dbms_output.put_line('123333');
        --dbms_output.put_line(v_sql_content);
        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start || v_sql_content || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------内容
        IF currenttype = '本月任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'')
                       and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            v_where := ' ';
        ELSIF currenttype = '次月任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;
        --当输入条件部位空时
        IF searchcondition is not null THEN
            v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(charge_person,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like := '';
        END IF;
        spcil_sql :='
            UNION ALL
                SELECT
                    n.ID   AS id,
                     p.id as ORIGINAL_PLAN_ID,
                    n.ID   AS ORIGINAL_NODE_ID,
                    n.PLAN_ID,
                    2 AS PLAN_TYPE_INT,
                    CASE
                        WHEN f.id IS NULL THEN n.NODE_NAME
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                            THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                            THEN n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                            THEN n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                            THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.PREDICT_END_DATE,
                    ''所属项目'' AS E,
                    ''专项计划'' AS F,
                    n.DUTY_DEPARTMENT,
                    cp.CHARGE_PERSON,
                    ''专项计划级'' AS M,
                    0 AS N
                FROM POM_SPECIAL_PLAN_NODE n
                    LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                    left join (
                        SELECT node_id,LISTAGG( to_char(charge_person), '','')
                        WITHIN GROUP(ORDER BY charge_person) AS charge_person
                        FROM POM_NODE_CHARGE_PERSON group by node_id
                    ) cp on n.id=cp.NODE_ID
                    LEFT JOIN (
                        SELECT B.*FROM (
                            SELECT A.*,
                            ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1
                    ) f on f.feedback_node_id=n.id
                    inner JOIN (
                        select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
        ) tal on n.COMPANY_ID in tal.orgid
        WHERE p.APPROVAL_STATUS=''已审核'' AND (n.IS_DELETE=0 or n.is_DELETE is null)' ||
                    ' and (p.COMPANY_ID in ('|| company_ids || ') or '''|| companyid ||''' is null)' || v_where
        --                     ||
--                     'UNION ALL
--             SELECT    n.id,
--                p.ORIGINAL_PLAN_ID,
--                n.original_node_id,
--                dept_monthly_plan_id,
--                3 as  PLAN_TYPE_INT,
--                node_name,
--                p.PLAN_NAME,
--                PLAN_START_DATE,
--                PLAN_END_DATE,
--                ACTUAL_END_DATE,
--                ESTIMATE_END_DATE,           --预计完成时间
--                ''无'' as PROJ_NAME,          --所属项目
--                ''部门月度计划'' as  PLAN_TYPE,        --计划类型显示名
--                p.DEPT_NAME,          --主责部门
--                cp.CHARGE_PERSON,
--                node_Type,           --任务等级
--                stand_SCORE          --标准分值
--             FROM pom_dept_monthly_plan_node n
--                 left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
--                 left join (
--                     SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person)
--                     AS charge_person
--                     FROM POM_NODE_CHARGE_PERSON group by node_id
--                 ) cp on n.id=cp.NODE_ID
--                 inner JOIN (
--                     select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
--                 )  tal on p.COMPANY_ID in tal.orgid
--                WHERE (IS_DEL=0 OR IS_DEL is null) and APPROVE_STATUS=''已审核''
--                 and (p.COMPANY_ID in ( '|| company_ids || ' ) or ''' || companyid ||''' is null)'
--                     || v_where
        ;
        --3.拼接完整语句
        v_sql_exec :=
                    'select  rownum as rowno,ID,
                         ORIGINAL_NODE_ID,
                         ORIGINAL_PLAN_ID,
                         PROJ_PLAN_ID as PLAN_ID,
                         PLAN_TYPE_INT,
                         NODE_NAME,
                         PLAN_NAME,
                         TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when ACTUAL_END_DATE is null then ''未完成''
                         else ''已完成'' end as COMPLETION_STATUS,
                         PROJ_NAME,
                         PLAN_TYPE,
                         DUTY_DEPARTMENT,
                             CHARGE_PERSON,
                         NODE_LEVEL,
                         STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,
                         ' || v_sql || ' as NODE_WARNING
            from (
                select
                    n.*,w.IS_UN_WATCH
                    ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
                    ,case when n.ACTUAL_END_DATE is null then ''催办'' else null end as HASTEN
                    ,case when w.IS_UN_WATCH=0
                        then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||ORIGINAL_NODE_ID
                        else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||ORIGINAL_NODE_ID end as W_Url
                from(
                    SELECT
                    n.ID,
                    p.ORIGINAL_PLAN_ID,
                    n.ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''关键节点计划'' THEN 0
                        WHEN ''项目主项计划'' THEN 1
                    END AS PLAN_TYPE_INT,
                    CASE
                        WHEN f.id IS NULL THEN n.NODE_NAME
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                            THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                            THEN n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                            THEN n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                            THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    cp.CHARGE_PERSON,
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join (
                    SELECT node_id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                ) cp on n.id=cp.NODE_ID left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                LEFT JOIN (
                    SELECT B.*
                    FROM (
                        SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A
                    ) B WHERE RN = 1
                ) f on f.feedback_node_id=n.id
                inner JOIN (
                    select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
                ) tal on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
                    AND	n.IS_DISABLE=0 and (n.COMPANY_ID in ( '|| company_ids || ' ) or '''|| companyid||''' is null)'
                    || v_where || '
                   '|| spcil_sql || '
           )n left join (
            SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||'''
           ) w on n.ORIGINAL_NODE_ID=w.BIZ_ID
           ' ||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
-------------------------------------------------------------------------------------------内容
        v_sql_exec_paging :=
                    ' select a.*
                      from (
                         ' || v_sql_exec|| '
                        where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';
----获取总条数
        INSERT INTO TEST(ID,PROJ_NAME,SQL_STR) values(GET_UUID(), 'sql', v_sql_exec);
        EXECUTE IMMEDIATE 'SELECT count(rowno) from(' || v_sql_exec || ') a ' INTO total;
        OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT '失败咯' || testmsg plan_name FROM dual;
    END;
END p_pom_smart_my_current_company;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PERSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PERSON" (
    userid        IN            VARCHAR2,--输入变量：用户ID
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型（所有未完成，超期未完成，所有已完成）
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --我负责的任务  关键节点计划、项目主项计划、专项计划
--作者：陈丽
--日期：2019/11/15
    v_sql_start          CLOB;
    v_sql_end           CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    testmsg             CLOB;
    v_where_like       CLOB;
    spcil_sql           CLOB;
    plan_expression     varchar2(4000);
BEGIN
    total := 1000;
    v_sql_start := ' case ';
    v_sql_content := '';
    v_sql_end := '  else '''' end  ';
    BEGIN
        --1.拼接查询语句
        FOR item IN (
            SELECT
                s.expression,
                vv.node_level,
                vv.plan_type
            FROM
                pom_rule_set s
                    LEFT JOIN (
                    SELECT
                        MAX(s.created_time) AS t,
                        node_level,
                        plan_type
                    FROM
                        pom_rule_set             s
                            LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                    WHERE
                            rule_type = '亮灯规则'
                      --AND plan_type != '关键节点计划'
                      AND s.is_disable = 0
                    GROUP BY
                        node_level,
                        plan_type
                ) vv ON s.created_time = vv.t
                    AND s.node_level = vv.node_level
            WHERE
                    vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划' THEN
                    plan_expression := ''' then ('''
                        || item.expression
                        || ''') ';
                ELSE
                    plan_expression := ''' then ('
                        || item.expression
                        || ') ';
                END IF ;
                ---拼接字符串
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type
                           WHEN '项目全景计划' THEN '项目主项计划'
                           ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                || v_sql_content
                || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------内容
        IF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and sysdate>PLAN_END_DATE  and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSE
            v_where := '' ;
        END IF;
        --当输入条件不为空时
        IF searchcondition is not null THEN
            v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(n.charge_person,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like := '' ;
        END IF;
        spcil_sql := ' UNION ALL
                SELECT
                    n.ID   AS id,
                     p.id as ORIGINAL_PLAN_ID,
                    n.ID   AS ORIGINAL_NODE_ID,
                    n.PLAN_ID,
                    2 AS PLAN_TYPE_INT,
                    CASE WHEN f.id IS NULL THEN
                            n.NODE_NAME
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
                            n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
                            n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
                            n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
                            n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.PREDICT_END_DATE,
                    ''所属项目'' AS E,
                    ''专项计划'' AS F,
                    n.DUTY_DEPARTMENT,
                        person.CHARGE_PERSON,
                    ''专项计划级'' AS M,
                    0 AS N
                FROM
                    POM_SPECIAL_PLAN_NODE n
                        LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A) B
                        WHERE RN = 1) f on f.feedback_node_id=n.id
                        where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''已审核''
                        AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || '';
        --专项计划已启用，但是部门月度计划还未启用、需要启用部门月度计划时，取消下面的sql即可
--                UNION ALL
--                    SELECT    n.id,
--                    p.ORIGINAL_PLAN_ID,
--                    n.original_node_id,
--                    dept_monthly_plan_id,
--                    3 as  PLAN_TYPE_INT,
--
--                    n.node_name,
--                    p.PLAN_NAME,
--                    PLAN_START_DATE,
--                    PLAN_END_DATE,
--
--                    ACTUAL_END_DATE,
--                    ESTIMATE_END_DATE,           --预计完成时间
--                    ''无'' as PROJ_NAME,          --所属项目
--                    ''部门月度计划'' as  PLAN_TYPE,        --计划类型显示名
--                    p.DEPT_NAME,          --主责部门
--                        person.CHARGE_PERSON,
--                    node_Type,           --任务等级
--                    stand_SCORE          --标准分值
--                FROM
--                    pom_dept_monthly_plan_node n
--                    left join pom_dept_monthly_plan p on n.dept_monthly_plan_id=p.id
--                        LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
--                    where n.IS_DEL=0 and APPROVE_STATUS=''已审核''
--                        AND CHARGE_PERSON_ID='''||userid||'''  '
--                                      || v_where;
--3.拼接完整语句
        v_sql_exec := ' select  rownum as rowno,ID,
    ORIGINAL_NODE_ID,
    ORIGINAL_PLAN_ID,
    PROJ_PLAN_ID as PLAN_ID,
    PLAN_TYPE_INT,
    NODE_NAME,
    PLAN_NAME,
    TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
    case when ACTUAL_END_DATE is null then ''未完成''
    else ''已完成'' end as COMPLETION_STATUS,
    PROJ_NAME,
    PLAN_TYPE,
    DUTY_DEPARTMENT,
    NODE_LEVEL,
		CHARGE_PERSON,
    STANDARD_SCORE ,WACTH,HASTEN,'
            || v_sql
            || ' as NODE_WARNING from (select n.*,''关注'' as WACTH,''催办'' as HASTEN from(SELECT
    n.ID,
     p.ORIGINAL_PLAN_ID,
    n.ORIGINAL_NODE_ID,
    n.PROJ_PLAN_ID,
    CASE p.PLAN_TYPE
        WHEN ''关键节点计划''   THEN
            0
        WHEN ''项目主项计划''   THEN
            1
    END AS PLAN_TYPE_INT,
    CASE WHEN f.id IS NULL THEN
        n.NODE_NAME
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
        n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
        n.NODE_NAME||''【完成反馈未发起】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
        n.NODE_NAME||''【完成反馈审核中】''
    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
        n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
    END AS NODE_NAME,
    p.PLAN_NAME,--计划名称
    n.PLAN_START_DATE,
    n.PLAN_END_DATE,

    n.ACTUAL_END_DATE,
    n.ESTIMATE_END_DATE,           --预计完成时间
    p.PROJ_NAME,          --所属项目
    p.PLAN_TYPE,        --计划类型显示名
    n.DUTY_DEPARTMENT,          --主责部门
		person.CHARGE_PERSON,
    n.NODE_LEVEL,           --任务等级
    n.STANDARD_SCORE          --标准分值
FROM
    POM_PROJ_PLAN_NODE n
		LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
		LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
        LEFT JOIN (SELECT B.*FROM (SELECT A.*,
        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
        FROM POM_NODE_FEEDBACK A) B
        WHERE RN = 1) f on f.feedback_node_id=n.id
		WHERE (p.PLAN_TYPE=''项目主项计划'' OR p.PLAN_TYPE=''关键节点计划'') AND n.IS_DISABLE=0  and p.APPROVAL_STATUS=''已审核''
		AND CHARGE_PERSON_ID='''||userid||'''  '
            || v_where
            || spcil_sql
            || ')n '||v_where_like||'
   ORDER BY n.PLAN_END_DATE  ) a  ';-- left join POM_NODE_CHARGE_PERSON cp on n.id=cp.NODE_ID where CHARGE_PERSON_ID='''||userid||'''
-------------------------------------------------------------------------------------------内容
        -- dbms_output.put_line(v_sql_exec);
        v_sql_exec_paging := '
select a.* from ( '
            || v_sql_exec
            || ' where rownum <= '
            || pageindex * pagesizes
            || ' ) a where a.rowno > '
            || pagesizes * ( pageindex - 1 )
            || '';
----获取总条数
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
            || v_sql_exec
            || ') a '
            INTO total;
        dbms_output.put_line(v_sql_exec_paging);
-- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN items FOR v_sql_exec_paging;
--SELECT '' A FROM DUAL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN items FOR SELECT '失败咯' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_person;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_DEPT" (
    userid        IN            VARCHAR,--用户id，用于过滤关注的任务
    deptid        IN            VARCHAR2,--输入变量：部门
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--    auth          OUT           SYS_REFCURSOR
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2019/11/15

    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_spid              CLOB;
    deptidwhere         CLOB;
    testmsg         CLOB;
    v_where              CLOB;
    v_nextLine           CLOB;
    plan_expression     varchar2(4000);
--    test_sql        CLOB;
BEGIN
    --统一解析
    deptidwhere := deptid;
    BEGIN
        total := 1000;
        v_sql_start := ' case ';
        v_sql_content := '';
        v_sql_end := '  else '''' end ';

        --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
        --1.拼接查询语句
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set s LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则' AND s.is_disable = 0
                  -- AND plan_type != '关键节点计划'
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划' THEN
                    plan_expression := ''' then
                            (''' || item.expression || ''') ';
                ELSE
                    plan_expression := ''' then
                           (' || item.expression || ') ';
                END IF ;

                --拼接字符串
                v_sql_content := v_sql_content
                    || '  when plan_type=''' ||
                                 CASE item.plan_type WHEN '项目全景计划' THEN '项目主项计划' ELSE item.plan_type END
                    || ''' and node_level=''' || item.node_level || plan_expression;
            END LOOP;

        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start || v_sql_content || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;

        IF currenttype = '本月任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and sysdate>n.PLAN_END_DATE and n.ACTUAL_END_DATE is null';
        ELSIF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            v_where := ' ';
        ELSIF currenttype = '次月任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1 and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;

        v_sql_exec := '
        select
            distinct rownum as rowno,ID,
            ORIGINAL_NODE_ID,
            ORIGINAL_PLAN_ID,
            PROJ_PLAN_ID as PLAN_ID,
            PLAN_TYPE_INT,
            NODE_NAME,
            PLAN_NAME,
            TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
            TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
            TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
            TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
            case when ACTUAL_END_DATE is null then ''未完成''
            else ''已完成'' end as COMPLETION_STATUS,
            PROJ_NAME,
            PLAN_TYPE,
            DUTY_DEPARTMENT,
            NODE_LEVEL,
            STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,charge_person,'
            || v_sql
            || ' as NODE_WARNING from (select n.*,charge_person,w.IS_UN_WATCH
            ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
            ,case when n.ACTUAL_END_DATE is null then ''催办''
            else null end as HASTEN
            from(
                SELECT
                    n.ID,
                    p.ORIGINAL_PLAN_ID,
                    n.ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''关键节点计划'' THEN 0
                        WHEN ''项目主项计划'' THEN 1
                    END AS PLAN_TYPE_INT,
                    CASE WHEN f.id IS NULL THEN n.NODE_NAME
                         WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
                            n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
                            n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
                            n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
                            n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
                FROM V_POM_PROJ_PLAN_NODE n
                LEFT JOIN V_POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                LEFT JOIN (
                    SELECT B.*FROM (
                        SELECT A.*, ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A
                    ) B WHERE RN = 1
                ) f on f.feedback_node_id=n.id
                inner join (
                    select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
                ) tal on instr(DUTY_DEPARTMENT_ID,tal.orgId) > 0
                WHERE  (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'' or p.PLAN_TYPE=''专项计划'')
                and p.APPROVAL_STATUS=''已审核''  AND n.IS_DISABLE=0 AND n.IS_DELETE=0
                and ('''||deptidwhere||''' is null or DUTY_DEPARTMENT_ID='''|| deptidwhere|| ''')'|| v_where ||'
            ) n left join (
                SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||'''
            ) w on n.ORIGINAL_NODE_ID=w.BIZ_ID
            left join (
                SELECT node_id,
                LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                FROM POM_NODE_CHARGE_PERSON group by node_id
            ) cp on n.id=cp.NODE_ID
            WHERE (n.NODE_NAME LIKE ''%'||searchcondition||'%'' OR  n.PLAN_NAME LIKE ''%'||searchcondition||'%''
            OR n.PROJ_NAME LIKE ''%'||searchcondition||'%'' OR n. DUTY_DEPARTMENT LIKE ''%'||searchcondition||'%''
            OR cp.charge_person like ''%'||searchcondition||'%'' )
            ORDER BY n.PLAN_END_DATE
        ) a ';
        insert into TEST(ID, PROJ_NAME, SQL_STR) values (GET_UUID(), 'dept', v_sql_exec);
        v_sql_exec_paging := '
        select a.*
        from ( '
            || v_sql_exec
            || ' where rownum <= '
            || pageindex * pagesizes
            || '
        ) a where a.rowno > '|| pagesizes * ( pageindex - 1 )|| '';
        --获取总条数
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('|| v_sql_exec || ') a ' INTO total;
        OPEN items FOR v_sql_exec_paging;
    EXCEPTION WHEN OTHERS THEN
        testmsg := sqlerrm;
        OPEN items FOR
            SELECT '失败咯' || testmsg plan_name FROM dual;
    END;
END p_pom_smart_my_current_dept;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PROJ" (
    projid        IN            VARCHAR2,--输入变量：项目
    userid        IN 			VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,--模糊查询条件
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2019/11/15
    v_sql_start          CLOB;
    v_sql_end            CLOB;
    v_sql_content        CLOB;
    v_sql               CLOB;
    v_sql_exec          CLOB;
    v_sql_exec_paging   CLOB;
    v_where              CLOB;
    v_spid              CLOB;
    spcil_sql              CLOB;
    testmsg              CLOB;
    v_where_like       CLOB;
    plan_expression     varchar2(4000);
BEGIN
    ----------------------------------------------------统一解析
    testmsg := 'projid:'
        || projid
        || '；pageindex:'
        || pageindex
        || '；pagesizes:'
        || pagesizes
        || '；currenttype:'
        || currenttype;

    BEGIN
        total := 1000;
        v_sql_start := ' case ';
        v_sql_content := '';
        v_sql_end := '  else '''' end  ';
        --调用数据权限验证存储过程
        P_AUTH_BLOCK_PROJ_COMPANY(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_SPID_ID => v_spid
            );
        --1.拼接查询语句
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                  -- AND plan_type != '关键节点计划'
                  AND s.is_disable = 0
                GROUP BY  node_level,  plan_type
            ) vv ON s.created_time = vv.t AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                IF item.plan_type = '专项计划'
                THEN plan_expression := ''' then (''' || item.expression || ''') ';
                ELSE plan_expression := ''' then (' || item.expression || ') ';
                END IF ;
                ---拼接字符串
                v_sql_content := v_sql_content
                    || '  when plan_type='''
                    || CASE item.plan_type WHEN '项目全景计划' THEN '项目主项计划' ELSE item.plan_type END
                    || ''' and node_level='''
                    || item.node_level
                    || plan_expression;
            END LOOP;
        --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start || v_sql_content || v_sql_end;
        ELSE
            --无规则亮灯显示空
            v_sql := '''''';
        END IF;
-------------------------------------------------------------------------------------------内容
        IF currenttype = '本月任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            v_where := ' and sysdate>n.PLAN_END_DATE and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有未完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            v_where := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            v_where := ' ';
        ELSIF currenttype = '次月任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1 and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            v_where := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'') and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            v_where := ' and 1=2';
        END IF;
        --当输入条件部位空时
        IF searchcondition is not null THEN
            v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(cp.charge_person,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like := '';
        END IF;
        spcil_sql :=
                    'UNION ALL
                     SELECT
                         n.ID   AS id,
                         p.id as ORIGINAL_PLAN_ID,
                         n.ID   AS ORIGINAL_NODE_ID,
                         n.PLAN_ID,
                         2 AS PLAN_TYPE_INT,
                         ''backid'' backid,
                         CASE
                             WHEN f.id IS NULL THEN n.NODE_NAME
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                                 THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                                 THEN n.NODE_NAME||''【完成反馈未发起】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                                 THEN n.NODE_NAME||''【完成反馈审核中】''
                             WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                                  THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                         END AS NODE_NAME,
                         p.PLAN_NAME,--计划名称
                         n.PLAN_START_DATE,
                         n.PLAN_END_DATE,
                         n.ACTUAL_END_DATE,
                         n.PREDICT_END_DATE,
                         ''所属项目'' AS PROJ_NAME,
                         ''专项计划'' AS PLAN_TYPE,
                         n.DUTY_DEPARTMENT,
                         ''专项计划级'' AS NODE_LEVEL,
                         0 AS STANDARD_SCORE
                         FROM POM_SPECIAL_PLAN_NODE n
                             LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                             LEFT JOIN POM_NODE_CHARGE_PERSON person ON n.ID=person.NODE_ID
                             LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                             ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                             FROM POM_NODE_FEEDBACK A) B
                             WHERE RN = 1) f on f.feedback_node_id=n.id
                             where n.IS_DELETE=0 AND p.APPROVAL_STATUS=''已审核'' AND CHARGE_PERSON_ID='''||userid||'''  '
                    || v_where
                    || '';
        --3.拼接完整语句
        --         if projid <> '111' then
        v_sql_exec :=
                    'select
                         rownum as rowno,ID,
                         ORIGINAL_NODE_ID,
                         ORIGINAL_PLAN_ID,
                         PROJ_PLAN_ID as PLAN_ID,
                         PLAN_TYPE_INT,
                         NODE_NAME,
                         PLAN_NAME,
                         TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when ACTUAL_END_DATE is null then ''未完成''
                         else ''已完成'' end as COMPLETION_STATUS,
                         PROJ_NAME,
                         PLAN_TYPE,
                         DUTY_DEPARTMENT,
                         CHARGE_PERSON,
                         NODE_LEVEL,
                         STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,'
                    || v_sql
                    || ' as NODE_WARNING
            from (
                select
                    n.*,charge_person,w.IS_UN_WATCH
                    ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
                    ,case when n.ACTUAL_END_DATE is null then ''催办''
                    else null end as HASTEN
                    ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0&windowWidth=724&windowHeight=300&bizId=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0&windowWidth=724&windowHeight=300&bizId=&bizId=''||ORIGINAL_NODE_ID end as w_Url
                from(
                    SELECT
                        n.ID,
                        p.ORIGINAL_PLAN_ID,
                        n.ORIGINAL_NODE_ID,
                        n.PROJ_PLAN_ID,
                        CASE p.PLAN_TYPE
                            WHEN ''关键节点计划'' THEN 0
                            WHEN ''项目主项计划'' THEN 1
                        END AS PLAN_TYPE_INT,
                        f.id as backId,
                    CASE
                        WHEN f.id IS NULL THEN n.NODE_NAME
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT''
                            THEN n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核''
                            THEN n.NODE_NAME||''【完成反馈未发起】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中''
                            THEN n.NODE_NAME||''【完成反馈审核中】''
                        WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核''
                            THEN n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,
                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
                FROM POM_PROJ_PLAN_NODE n
		        LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                LEFT JOIN (
                    SELECT B.*
                    FROM (
                        SELECT A.*,
                        ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                        FROM POM_NODE_FEEDBACK A
                    ) B WHERE RN = 1
                ) f on f.feedback_node_id=n.id
                inner JOIN (
                    select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''
                ) tal on (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
		        AND n.IS_DISABLE=0
		        AND ('''||projid||''' is null or (p.PROJ_ID='''||projid||''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID='''
                    ||projid||''')))  '||v_where|| spcil_sql ||'
            )n left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID
            left join (
                SELECT node_id,
                LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                FROM POM_NODE_CHARGE_PERSON group by node_id
            ) cp on n.id=cp.NODE_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
        -------------------------------------------------------------------------------------------内容
        v_sql_exec_paging :=
                    'select a.*
                     from (
                        ' || v_sql_exec || '
                where rownum <= ' || pageindex * pagesizes || '
             ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

        dbms_output.put_line(v_sql_exec_paging);
        ----获取总条数
        EXECUTE IMMEDIATE 'SELECT count(rowno) from('
            || v_sql_exec
            || ') a '
            INTO total;
        OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||testmsg;
            OPEN items FOR SELECT '失败咯' || testmsg plan_name FROM dual;
            dbms_output.put_line(sqlerrm);
    END;
END p_pom_smart_my_current_proj;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_TBS" 
(
    ORGTYPE   IN VARCHAR2
   , --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,本人
    CONDITION IN VARCHAR2
   , --输入变量：公司id | 部门id | 项目id | 当前用户ID
    userid        IN            VARCHAR2,--用户id用于过滤关注的任务
    currentcompanyid     IN     VARCHAR2,--当前用户的公司
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    currentdeptid        IN            VARCHAR2,---当前用户的部门
    bizcode       IN            VARCHAR2,---权限code
    searchcondition IN          VARCHAR2,--模糊查询条件
    ITEM      OUT SYS_REFCURSOR
) IS
    --任务中心tabs任务条数统计数据源
    --作者：yedr
    --日期：2019/12/25
    v_spid              VARCHAR2(200);--数据权限验证spid
BEGIN

    --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
    IF CONDITION<>'222' THEN
        OPEN ITEM FOR
            SELECT NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                               AND ( B.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND B.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) ) THEN
                                1
                               ELSE
                                0
                           END), 0) AS ACOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                                    AND TRUNC(SYSDATE) > B.PLAN_END_DATE THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS BCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS CCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS DCOUNT,
                   COUNT(*) AS ECOUNT
            FROM  POM_PROJ_PLAN_NODE B
            LEFT JOIN  POM_PROJ_PLAN A ON  A.ID = B.PROJ_PLAN_ID
            LEFT JOIN (
						
		SELECT  listagg(CHARGE_PERSON,',') within GROUP(order by CHARGE_PERSON ) CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID
							
						
						)  person ON B.ID=person.NODE_ID
            LEFT JOIN  SYS_PROJECT_STAGE sps on A.proj_id=sps.id
            LEFT JOIN  (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
            on (case when sps.id is not null then sps.PROJECT_ID else A.proj_id end)=tal.orgId
            WHERE
                   tal.orgId is not null and
                   A.APPROVAL_STATUS = '已审核' AND
                   A.PLAN_TYPE = '关键节点计划' AND
                   NVL(B.IS_DISABLE, 0) <> 1 AND
                   (A.PROJ_ID = '' || CONDITION || '' OR A.PROJ_ID IN (SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID = '' || CONDITION || ''))
                   AND (b.node_name like '%'||searchcondition||'%' OR a.plan_name like '%'||searchcondition||'%'
                   OR a.PROJ_NAME like '%'||searchcondition||'%' OR b.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%');
        ELSE
             OPEN ITEM FOR
             SELECT NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                               AND ( B.PLAN_END_DATE >= trunc( SYSDATE, 'month' ) AND B.PLAN_END_DATE <= trunc( last_day( SYSDATE ) ) )
                               THEN
                                1
                               ELSE
                                0
                           END), 0) AS ACOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL
                                    AND TRUNC(SYSDATE) > B.PLAN_END_DATE THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS BCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS CCOUNT,
                   NVL(SUM(CASE
                               WHEN B.ACTUAL_END_DATE IS NOT NULL THEN
                                1
                               ELSE
                                0
                           END),
                       0) AS DCOUNT,
                   COUNT(*) AS ECOUNT
            FROM  POM_PROJ_PLAN_NODE B
            LEFT JOIN  POM_PROJ_PLAN A ON  A.ID = B.PROJ_PLAN_ID
            LEFT JOIN (
						
		SELECT  listagg(CHARGE_PERSON,',') within GROUP(order by CHARGE_PERSON ) CHARGE_PERSON,NODE_ID FROM POM_NODE_CHARGE_PERSON GROUP BY NODE_ID
							
						
						)  person ON B.ID=person.NODE_ID
            LEFT JOIN  SYS_PROJECT_STAGE sps on A.proj_id=sps.id
            LEFT JOIN  (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = ''||v_spid||'') tal
            on (case when sps.id is not null then sps.PROJECT_ID else A.proj_id end)=tal.orgId
            WHERE
                   tal.orgId is not null and
                   A.APPROVAL_STATUS = '已审核' AND
                   A.PLAN_TYPE = '关键节点计划' AND
                   NVL(B.IS_DISABLE, 0) <> 1
                  AND (b.node_name like '%'||searchcondition||'%' OR a.plan_name like '%'||searchcondition||'%'
                   OR a.PROJ_NAME like '%'||searchcondition||'%' OR b.DUTY_DEPARTMENT like '%'||searchcondition||'%' OR person.CHARGE_PERSON like '%'||searchcondition||'%');
                  --AND (A.PROJ_ID = '' || CONDITION || '' OR A.PROJ_ID IN (SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID = '' || CONDITION || ''))
        END IF;
END P_POM_SMART_KEY_NODE_PLAN_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_PROJ" 
(
    PROJID      IN VARCHAR2
   , --输入变量：项目
    PAGEINDEX   IN INT
   ,PAGESIZES   IN INT
   ,CURRENTTYPE IN VARCHAR2
   , --完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    userid        IN            VARCHAR2,--用户id用于过滤关注的任务
    currentcompanyid     IN     VARCHAR2,--当前用户的公司
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    currentdeptid        IN            VARCHAR2,---当前用户的部门
    searchcondition IN          VARCHAR2,--模糊查询条件
    bizcode       IN            VARCHAR2,---权限code
    ITEMS       OUT SYS_REFCURSOR
   ,TOTAL       OUT INT
) IS
    --本部门负责的任务
    --作者：陈丽
    --日期：2019/11/15

    V_SQL_START       CLOB;
    V_SQL_END         CLOB;
    V_SQL_CONTENT     CLOB;
    V_SQL             CLOB;
    V_SQL_EXEC        CLOB;
    V_SQL_EXEC_PAGING CLOB;
    V_WHERE           VARCHAR2(500);
    TESTMSG           NVARCHAR2(200);
    v_spid              VARCHAR2(200);--数据权限验证spid
    v_where_like       CLOB;
    v_test_land        CLOB;
    plan_expression     varchar2(4000);
BEGIN
    ----------------------------------------------------统一解析
    TESTMSG := 'projid:' || PROJID || '；pageindex:' || PAGEINDEX || '；pagesizes:' || PAGESIZES || '；currenttype:' || CURRENTTYPE;

    BEGIN
        TOTAL         := 1000;
        V_SQL_START   := ' case ';
        V_SQL_CONTENT := '';
        V_SQL_END     := '  else '''' end  ';


        --调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
            USERID => userid,
            STATIONID => currentstationid,
            DEPTID => currentdeptid,
            COMPANYID => currentcompanyid,
            BIZCODE => bizcode,
            DATA_AUTH_SPID => v_spid
        );
        --1.拼接查询语句
        FOR ITEM IN (SELECT S.EXPRESSION, VV.NODE_LEVEL, VV.PLAN_TYPE
                     FROM   POM_RULE_SET S
                     LEFT   JOIN (SELECT MAX(S.CREATED_TIME) AS T, NODE_LEVEL, PLAN_TYPE
                                 FROM   POM_RULE_SET S
                                 LEFT   JOIN POM_RULE_SET_PLAN_TYPE PT
                                 ON     S.ID = PT.RULE_ID
                                 WHERE  RULE_TYPE = '亮灯规则'
                                       -- AND plan_type != '关键节点计划'
                                        AND
                                        S.IS_DISABLE = 0
                                 GROUP  BY NODE_LEVEL, PLAN_TYPE) VV
                     ON     S.CREATED_TIME = VV.T AND
                            S.NODE_LEVEL = VV.NODE_LEVEL
                     WHERE  VV.T IS NOT NULL)
        LOOP

        IF ITEM.plan_type = '专项计划' THEN
            plan_expression := ''' then ('''
                                || ITEM.expression
                                || ''') ';
        ELSE
            plan_expression := ''' then ('
                                || ITEM.expression
                                || ') ';
        END IF ;

            ---拼接字符串
            V_SQL_CONTENT := V_SQL_CONTENT || '  when plan_type=''' || CASE ITEM.PLAN_TYPE
                                 WHEN '项目全景计划' THEN
                                  '项目主项计划'
                                 ELSE
                                  ITEM.PLAN_TYPE
                             END || ''' and node_level='''
                                 || ITEM.NODE_LEVEL
                                 || plan_expression;
        END LOOP;

        --dbms_output.put_line('123333');
        --dbms_output.put_line(v_sql_content);
        --规则内容大于0才拼规则语句

        IF LENGTH(V_SQL_CONTENT) > 0
        THEN
            V_SQL := V_SQL_START || V_SQL_CONTENT || V_SQL_END;
        ELSE
            --无规则亮灯显示空
            V_SQL := '''''';
        END IF;

        -------------------------------------------------------------------------------------------内容


        IF CURRENTTYPE = '本月任务'
        THEN
            V_WHERE := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF CURRENTTYPE = '超期未完成任务'
        THEN
            V_WHERE := ' and TRUNC(SYSDATE) > n.PLAN_END_DATE and n.ACTUAL_END_DATE is null';
        ELSIF CURRENTTYPE = '所有未完成任务'
        THEN
            V_WHERE := ' and n.ACTUAL_END_DATE is null ';
        ELSIF CURRENTTYPE = '所有已完成任务'
        THEN
            V_WHERE := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF CURRENTTYPE = '所有任务'
        THEN
            V_WHERE := ' ';
        ELSE
            V_WHERE := ' and 1=2';
        END IF;

        --当输入条件部位空时
        IF searchcondition is not null THEN
          v_where_like := 'WHERE (instr(n.NODE_NAME,'''||searchcondition||''')>0 OR instr(n.PLAN_NAME,'''||searchcondition||''')>0
              OR instr(n.PROJ_NAME,'''||searchcondition||''')>0 OR instr(n.DUTY_DEPARTMENT,'''||searchcondition||''')>0
              OR instr(charge_person,'''||searchcondition||''')>0 )';
        ELSE
          v_where_like := '';
        END IF;

        --3.拼接完整语句
        IF PROJID<>'111' THEN
        V_SQL_EXEC := ' select  rownum as rowno,ID,
                    ORIGINAL_NODE_ID,
                    ORIGINAL_PLAN_ID,
                    PROJ_PLAN_ID as PLAN_ID,
                    PLAN_TYPE_INT,
                    NODE_NAME,
                    PLAN_NAME,
                    TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
                    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
                    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
                    case when ACTUAL_END_DATE is null then ''未完成''
                    else ''已完成'' end as COMPLETION_STATUS,
                    PROJ_NAME,
                    PLAN_TYPE,
                    DUTY_DEPARTMENT,
                    CHARGE_PERSON,
                    NODE_LEVEL,
                    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,' || V_SQL || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
                ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
                ,case when n.ACTUAL_END_DATE IS NOT NULL THEN NULL
                ELSE ''催办'' END as HASTEN
                ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0=724=300=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300==''||ORIGINAL_NODE_ID end as w_Url

                                      from(SELECT
                    n.ID,
                     p.ORIGINAL_PLAN_ID,
                    n.ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''关键节点计划''   THEN
                            0
                        WHEN ''项目主项计划''   THEN
                            1
                    END AS PLAN_TYPE_INT,

                    CASE WHEN f.id IS NULL THEN
                        n.NODE_NAME
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
                        n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
                        n.NODE_NAME||''【完成反馈未发起】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
                        n.NODE_NAME||''【完成反馈审核中】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
                        n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,

                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    cp.CHARGE_PERSON,
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
                FROM
                    POM_PROJ_PLAN_NODE n LEFT
                    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                    LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                    ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                    FROM POM_NODE_FEEDBACK A) B
                    WHERE RN = 1) f on f.feedback_node_id=n.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                    WHERE tal.orgId is not null
                    and p.PLAN_TYPE=''关键节点计划'' AND NVL(n.IS_DISABLE,0) <> 1 and p.APPROVAL_STATUS=''已审核''
                    AND (p.PROJ_ID=''' || PROJID || ''' OR p.PROJ_ID IN( SELECT ID FROM SYS_PROJECT_STAGE WHERE PROJECT_ID=''' || PROJID || '''))  ' || V_WHERE || '
                )n
                    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE)  a ';

        ELSE
            V_SQL_EXEC := 'select  rownum as rowno,ID,
                    ORIGINAL_NODE_ID,
                    ORIGINAL_PLAN_ID,
                    PROJ_PLAN_ID as PLAN_ID,
                    PLAN_TYPE_INT,
                    NODE_NAME,
                    PLAN_NAME,
                    TO_CHAR(PLAN_START_DATE, ''YYYY-MM-DD'') PLAN_START_DATE ,
                    TO_CHAR(PLAN_END_DATE, ''YYYY-MM-DD'') PLAN_END_DATE,
                    TO_CHAR(ACTUAL_END_DATE, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                    TO_CHAR(ESTIMATE_END_DATE, ''YYYY-MM-DD'') PREDICT_END_DATE,
                    case when ACTUAL_END_DATE is null then ''未完成''
                    else ''已完成'' end as COMPLETION_STATUS,
                    PROJ_NAME,
                    PLAN_TYPE,
                    DUTY_DEPARTMENT,
                    CHARGE_PERSON,
                    NODE_LEVEL,
                    STANDARD_SCORE ,WACTH,HASTEN,IS_UN_WATCH,w_Url,' || V_SQL || ' as NODE_WARNING from (select n.*,w.IS_UN_WATCH
                ,case when w.IS_UN_WATCH=0 then ''取关'' else ''关注'' end as WACTH
                ,case when n.ACTUAL_END_DATE IS NOT NULL THEN NULL
                ELSE ''催办'' END as HASTEN
                ,case when w.IS_UN_WATCH=0 then ''/api/pom/planfollow/unfollow?cancelType=0=724=300=''||ORIGINAL_NODE_ID else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300==''||ORIGINAL_NODE_ID end as w_Url

                                      from(SELECT
                    n.ID,
                    p.ORIGINAL_PLAN_ID,
                    n.ORIGINAL_NODE_ID,
                    n.PROJ_PLAN_ID,
                    CASE p.PLAN_TYPE
                        WHEN ''关键节点计划''   THEN
                            0
                        WHEN ''项目主项计划''   THEN
                            1
                    END AS PLAN_TYPE_INT,

                    CASE WHEN f.id IS NULL THEN
                        n.NODE_NAME
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE <> ''CARRY_OUT'' THEN
                        n.NODE_NAME||''【预计完成日期:''||to_char(f.ESTIMATE_END_TIME,''yyyy-MM-dd'')||''】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''未审核'' THEN
                        n.NODE_NAME||''【完成反馈未发起】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''审核中'' THEN
                        n.NODE_NAME||''【完成反馈审核中】''
                    WHEN f.id IS NOT NULL AND f.FEEDBACK_TYPE = ''CARRY_OUT'' AND f.APPROVAL_STATUS=''已审核'' THEN
                        n.NODE_NAME||''【实际完成日期:''||to_char(f.ACTUAL_END_TIME,''yyyy-MM-dd'')||''】''
                    END AS NODE_NAME,
                    p.PLAN_NAME,--计划名称
                    n.PLAN_START_DATE,
                    n.PLAN_END_DATE,

                    n.ACTUAL_END_DATE,
                    n.ESTIMATE_END_DATE,           --预计完成时间
                    p.PROJ_NAME,          --所属项目
                    p.PLAN_TYPE,        --计划类型显示名
                    n.DUTY_DEPARTMENT,          --主责部门
                    cp.CHARGE_PERSON,
                    n.NODE_LEVEL,           --任务等级
                    n.STANDARD_SCORE          --标准分值
                FROM
                    POM_PROJ_PLAN_NODE n LEFT
                    JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                    left join (SELECT node_id,LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS charge_person
                    FROM POM_NODE_CHARGE_PERSON group by node_id) cp on n.id=cp.NODE_ID
                    LEFT JOIN SYS_PROJECT_STAGE sps on p.proj_id=sps.id
                    LEFT JOIN (SELECT B.*FROM (SELECT A.*,
                    ROW_NUMBER() OVER(partition by a.feedback_node_id order by A.CREATED desc nulls last) rn
                    FROM POM_NODE_FEEDBACK A) B
                    WHERE RN = 1) f on f.feedback_node_id=n.id
                    LEFT JOIN (select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||''')  tal
                    ON (case when sps.id is not null then sps.PROJECT_ID else p.proj_id end)=tal.orgId
                    WHERE tal.orgId is not null
                    and p.PLAN_TYPE=''关键节点计划'' AND NVL(n.IS_DISABLE,0) <> 1 and p.APPROVAL_STATUS=''已审核''
                     ' || V_WHERE || '
                )n
                    left join (SELECT * FROM SYS_BIZ_WATCH WHERE WATCHER_ID='''||userid||''') w on n.ORIGINAL_NODE_ID=w.BIZ_ID '||v_where_like||' ORDER BY n.PLAN_END_DATE) a ';
        END IF;
        -------------------------------------------------------------------------------------------内容

        V_SQL_EXEC_PAGING := '
select a.* from ( ' || V_SQL_EXEC || ' where rownum <= ' || PAGEINDEX * PAGESIZES || ' ) a where a.rowno > ' || PAGESIZES * (PAGEINDEX - 1) || '';

        DBMS_OUTPUT.PUT_LINE(V_SQL_EXEC);
        ----获取总条数
        EXECUTE IMMEDIATE 'SELECT count(rowno) from(' || V_SQL_EXEC || ') a '
            INTO TOTAL;

        -- execute immediate 'SELECT ' || v_sql_exec ||' FROM dual' into nodes;
        OPEN ITEMS FOR V_SQL_EXEC_PAGING;
        --SELECT '' A FROM DUAL;

    EXCEPTION
        WHEN OTHERS THEN
            TESTMSG := SQLERRM || TESTMSG;
            OPEN ITEMS FOR
                SELECT '失败咯' || TESTMSG PLAN_NAME FROM DUAL;

            DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;

END P_POM_SMART_KEY_NODE_PLAN_PROJ;


/
