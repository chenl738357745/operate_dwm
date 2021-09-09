create or replace PROCEDURE p_pom_w_proj_main_tree (
    USERID VARCHAR2,
    STATIONID VARCHAR2,
    DEPTID VARCHAR2,
    COMPANYID VARCHAR2,
    info OUT SYS_REFCURSOR
)IS
    v_sql clob;
    --当前日期
    nowdate date:=trunc(sysdate);
    BIZCODE VARCHAR2(200):='POM.JHJKYKHPH.01';
    DATA_AUTH_SPID VARCHAR2(200);
BEGIN
BEGIN
  P_SYS_GET_COMPANY_PROJ_SPID(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPTID => DEPTID,
    COMPANYID => COMPANYID,
    BIZCODE => BIZCODE,
    DATA_AUTH_SPID => DATA_AUTH_SPID
  );
END;
    OPEN info FOR                    
      WITH
     项目or分期 as (
    SELECT DISTINCT   B1.*
		FROM SYS_BUSINESS_UNIT A1  LEFT JOIN(
SELECT  D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%无分期%' THEN '_'||C.STAGE_NAME ELSE NULL END    AS "projectName"
,A.ID AS "planId"
,D.ID  as  "PROJECT_ID"
,A.COMPANY_ID
,COUNT(B.ID)  AS  "TOTALNODECOUNT"
,ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4) AS "completeRate"
--完成率说明：截止当前完成节点数量/截止当前应完成任务数量    亮灯规则说明：1）绿灯：完成率≥95% 2）黄灯：95%>完成率≥90% 3）红灯：完成率＜90%
,
case when COUNT(B.ID)>0 then 
CASE WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=95 THEN 3 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100>=90 then 2 
      WHEN ROUND(SUM( CASE WHEN    B.ACTUAL_END_DATE IS NOT NULL   THEN 1 ELSE 0 END)/COUNT(B.ID),4)*100 <90 then 1
      ELSE 1 
  END else 1 END  AS "completeStatus"
FROM POM_PROJ_PLAN A INNER JOIN POM_PROJ_PLAN_NODE B ON A.ID=B.PROJ_PLAN_ID
LEFT  JOIN SYS_PROJECT_STAGE C ON C.ID=PROJ_ID
INNER JOIN SYS_PROJECT D ON (D.ID=C.PROJECT_ID or PROJ_ID=d.id) 
WHERE     A.PLAN_TYPE='项目主项计划' AND A.APPROVAL_STATUS='已审核' AND B.IS_DISABLE=0  AND B.PLAN_END_DATE<=SYSDATE
AND  A.PLAN_VERSION IN ( SELECT MAX(PLAN_VERSION) FROM POM_PROJ_PLAN A1 WHERE  A1.PROJ_ID=A.PROJ_ID AND A1.APPROVAL_STATUS='已审核' )
GROUP BY D.PROJECT_NAME|| CASE WHEN C.STAGE_NAME NOT LIKE '%无分期%' THEN '_'||C.STAGE_NAME ELSE NULL END,A.COMPANY_ID,A.ID,D.ID )
B1 ON B1.COMPANY_ID=A1.ID 
LEFT JOIN(SELECT wm_concat(USER_NAME) AS USER_NAME,PROJECT_ID FROM SYS_ROLE_USER_RELATION_RESULT WHERE ROLE_CODE='pom_project_plan_manager' GROUP BY PROJECT_ID) C1 ON C1.PROJECT_ID=B1.PROJECT_ID
WHERE  NVL(B1.TOTALNODECOUNT,0)>0 AND  CONNECT_BY_ROOT ID ='003200000000000000000000000000'

CONNECT  by PRIOR   A1.ID= A1.PARENT_ID)

 ,拼接项目公司树 as(
   SELECT DISTINCT
   org_id       AS "orgId",
   org_name     AS "orgName",
   0 as  "orgType",
   parent_id    AS "parentId",
   1 as "isCompany"
   ,order_code as "orderCode"
   ,0 as "red"
    ,0 as "yellow"
    ,0 as "green"

                           FROM
                               tmp_company_tree
                           WHERE
                               id = DATA_AUTH_SPID
                               AND org_id IN (
                                   SELECT DISTINCT
                                       id
                                   FROM
                                       sys_business_unit
                                   START WITH
                                       id IN (
                                           SELECT
                                               id
                                           FROM
                                               (
                                                   SELECT
                                                       unit_id AS id
                                                   FROM
                                                       sys_project
                                                   UNION
                                                   SELECT
                                                       subordinate_company_id AS id
                                                   FROM
                                                       cdb_feasible_project_config
                                               ) ds
                                       )
                                   CONNECT BY
                                       PRIOR parent_id = id
                               )

   union all
    select    "planId"       AS "orgId",
   "projectName"     AS "orgName",
   0 as  "orgType",
   COMPANY_ID    AS "parentId",
   0 as "isCompany"
   ,'0' "orderCode"
   ,case when "completeStatus"=1 then 1 else 0 end as "red"
   ,case when "completeStatus"=2 then 1 else 0 end as "yellow"
   ,case when "completeStatus"=3 then 1 else 0 end as "green"  FROM 项目or分期)

   ,汇总 as(select
    "orgId",
    "orgName",
    "orgType",
    "parentId",
   "isCompany",
   "orderCode"
--,绿灯,黄灯,红灯
,(select sum("red") from 拼接项目公司树 start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "red"
,(select sum("yellow") from 拼接项目公司树 start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "yellow"
,(select sum("green") from 拼接项目公司树 start with "orgId"=s."orgId" connect by prior "orgId"="parentId" ) "green"
 from 拼接项目公司树 s)

   select  *
   from 汇总   where "isCompany"=1

   order by LPAD("orderCode",10,'0')
   ;

END p_pom_w_proj_main_tree;

