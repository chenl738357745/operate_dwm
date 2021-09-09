set define off;
create or replace PROCEDURE  P_POM_KEY_NODE_SCHEDULE
(
    companyGUID IN VARCHAR2,
    USERID VARCHAR2,
    STATIONID VARCHAR2,
    DEPTID VARCHAR2,
    COMPANYID VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id varchar2(100);
    --当前日期
    nowdate date:=trunc(sysdate);
    BIZCODE VARCHAR2(200):='POM.JHJKYKHPH.01';
    DATA_AUTH_SPID VARCHAR2(200);
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '003200000000000000000000000000';
    ELSE
        v_id := companyGUID;
    END IF;

    DECLARE


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

    -- 轨道图地址
    --/pom/plan-assess/node-monitoring/plan-nodes?companyid=''|| sp.unit_id ||''&ppid=''|| sp.id ||''&planType=关键节点计划''
    open items for
    WITH
     分期 as(
     select  case when 总分期数量=0 then get_uuid else ps.id end as id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,to_char(ps.sn,'0.0') as sn
     ,case when 无分期数量=1 and 总分期数量=1 then 1 else 0 end 是无分期
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     left join (select PROJECT_ID,sum(case when STAGE_NAME='无分期' then 1 else 0 end) as 无分期数量,count(PROJECT_ID) as 总分期数量 from SYS_PROJECT_STAGE group by PROJECT_ID)  pcount
     on proj.id=pcount.PROJECT_ID
     )
    ,basedata AS(
    ---查询已审核的分期 关键节点计划 基础信息
   select
   plan.PROJ_ID
   -- 所有未删除，未禁用的节点
   ,count(node.id) as 有效节点数
   ---
   ,sum(case when  node.PLAN_END_DATE<=nowdate then node.STANDARD_SCORE else 0 end) as 应得总分

--    case
-- --未到期不亮灯
-- WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<=0  THEN ''
-- --到期当天内完成反馈
-- when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
-- then '<p style=" font-size: 40px;color: green;margin-bottom: 0px;">●</p>'
--  --到期1-5天内完成反馈
-- when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
-- then '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">●</p>'
-- --到期未反馈黄灯
-- WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 1 and 5
-- THEN  '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">●</p>'
--  --到期超过5天未反馈红灯
-- WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) >5)
-- THEN  '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>'
-- ELSE '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">●</p>' END

   --绿灯：到期当天内完成反馈；红灯：①到期超过5天未反馈②超期反馈

   ,sum( case
     --未到期不亮灯
     WHEN  node.ACTUAL_END_DATE IS NULL AND  TRUNC(SYSDATE)-trunc(node.PLAN_END_DATE)<=0  THEN 0
     --到期当天内完成反馈
     when  node.ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE)) <= 0
     then 1
     ELSE  0 END
     ) as 绿灯
     --1-5天内反馈 黄灯：①到期1-5天内完成反馈、②到期15天内未反馈；
   ,sum(    case
     --未到期不亮灯
     WHEN  node.ACTUAL_END_DATE IS  not  NULL   and  (TRUNC(node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE))   BETWEEN 1 and 5
     then 1
     --到期未反馈黄灯
     WHEN  node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE))  BETWEEN 1 and 5
     THEN  1
     ELSE  0 END
     ) as 黄灯
   -- 超期五天反馈，或超期五天未反馈
   ,sum(    case
     --未到期不亮灯
     WHEN  (node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE)) >5)
     or ( (trunc(node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE)) >5)
     THEN  1
     ELSE  0 END
     ) as 红灯

   -- 里程碑节点、计划完成时间<=当天年月日 如 2020-05-25
   ,sum(case when node.NODE_LEVEL='里程碑' and node.PLAN_END_DATE<=nowdate then 1 else 0 end) as 里程碑应完成
   -- 里程碑节点、实际完成时间不为空
   ,sum(case when node.NODE_LEVEL='里程碑' and node.ACTUAL_END_DATE is not null then 1 else 0 end) as 里程碑已完成
   -- 里程碑节点 and 计划完成时间<=当天年月日 and 实际完成时间为空
   ,sum(case when node.NODE_LEVEL='里程碑' and node.PLAN_END_DATE<=nowdate and node.ACTUAL_END_DATE is null then 1 else 0 end) as 里程碑未完成

   ,sum(case when node.NODE_LEVEL='一级节点' and node.PLAN_END_DATE<=nowdate then 1 else 0 end) as 一级应完成
   ,sum(case when node.NODE_LEVEL='一级节点' and node.ACTUAL_END_DATE is not null then 1 else 0 end) as 一级已完成
   ,sum(case when node.NODE_LEVEL='一级节点' and node.PLAN_END_DATE<=nowdate and node.ACTUAL_END_DATE is null then 1 else 0 end) as 一级未完成
   ,sum(case when nodee.NEW_EXAMINATION_SCORE is null  then 0 else nodee.NEW_EXAMINATION_SCORE end) as 实际得分


   from  POM_PROJ_PLAN_NODE node
   left join POM_PROJ_PLAN plan on node.PROJ_PLAN_ID=plan.id
   --- 未考虑一个节点重复考核情况
   left join POM_NODE_EXAMINATION nodee on node.ORIGINAL_NODE_ID=nodee.ORIGINAL_NODE_ID

   ---已审核、关键节点计划、未禁用节点
   where plan.APPROVAL_STATUS='已审核'
   and plan.PLAN_TYPE='关键节点计划'
   and node.id is not null
   and node.IS_DISABLE=0
   and node.IS_DELETE=0
   group by plan.PROJ_ID )


   ,项目_分期 as(
   select 分期.id
   ,case when 分期.是无分期=1 then 分期.PROJECT_NAME else 分期.PROJECT_NAME||'-'||分期.STAGE_NAME end as name
    --统计的父级字段处理，无分期项目父级是公司，有分期项目父级是项目
   ,case when 分期.是无分期=1 then 分期.UNIT_ID else PROJECT_ID end parent_id
   ,有效节点数,应得总分
   ,绿灯,黄灯,红灯
   ,里程碑应完成,里程碑已完成,里程碑未完成
   ,一级应完成,一级已完成,一级未完成,实际得分
   ,'/pom/plan-assess/node-monitoring/plan-nodes?companyid='|| 分期.UNIT_ID ||'&ppid='|| case when 分期.是无分期=1 then PROJECT_ID else 分期.id end ||'&planType=关键节点计划' as url
   ,分期.UNIT_ID
   ,分期.sn
   ,case when 
(case when (里程碑应完成+一级应完成)=0 then 0 else  round((里程碑已完成+一级已完成)/(里程碑应完成+一级应完成),4)*100 end)<90 then 1
else 0 end as "isWarning"
   from basedata
   left join 分期 on basedata.PROJ_ID=分期.id
   union all
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,0 有效节点数,0 应得总分
   ,0 绿灯,0 黄灯,0 红灯
   ,0 里程碑应完成,0 里程碑已完成,0 里程碑未完成
   ,0 一级应完成,0 一级已完成,0 一级未完成,0 实际得分
   ,'' as url
   ,proj.UNIT_ID
   ,proj.sn,0 "isWarning"
   from sys_project proj
   left join (select * from 分期 where 是无分期=1) s on proj.id=s.project_id
   where s.id is null
   )

   ,拼接项目公司树 as(
 select * from (
   SELECT DISTINCT
   org_id       AS id,
   org_name     AS name,
   parent_id    AS parent_id,
   0 有效节点数,0 应得总分
   ,0 绿灯,0 黄灯,0 红灯
   ,0 里程碑应完成,0 里程碑已完成,0 里程碑未完成
   ,0 一级应完成,0 一级已完成,0 一级未完成,0 实际得分
   ,'' url
   ,order_code as sn,0 "isWarning"
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
--                               )   start with id=v_id connect by prior id=parent_id

   union all
    select id
   ,name
   ,parent_id
   ,有效节点数,应得总分
   ,绿灯,黄灯,红灯
   ,里程碑应完成,里程碑已完成,里程碑未完成
   ,一级应完成,一级已完成,一级未完成,实际得分,url,sn,"isWarning"  FROM 项目_分期)
   start with id=v_id connect by prior id=parent_id)

--
   ,汇总 as(select
   id
   ,name
   ,parent_id
   ,url
   ,sn
  -- ,有效节点数,应得总分
,(select sum(有效节点数) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 有效节点数
,(select sum(应得总分) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 应得总分
--,绿灯,黄灯,红灯
,(select sum(绿灯) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 绿灯
,(select sum(黄灯) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 黄灯
,(select sum(红灯) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 红灯

--,里程碑应完成,里程碑已完成,里程碑未完成
,(select sum(里程碑应完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 里程碑应完成
,(select sum(里程碑已完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 里程碑已完成
,(select sum(里程碑未完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 里程碑未完成

--,一级应完成,一级已完成,一级未完成
,(select sum(一级应完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 一级应完成
,(select sum(一级已完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 一级已完成
,(select sum(一级未完成) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 一级未完成
,(select sum(实际得分) from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 实际得分
,(select sum("isWarning") from 拼接项目公司树 start with id=s.id connect by prior id=parent_id ) 
as "isWarning" 
 from 拼接项目公司树 s)
--
  ,计算 as(select '' from dual)

   select  id as "id",sn
   ,case when url is not null then  '<span style="color:#409eff">'||name||'</span>' else   name end as "company"
   ,url as "jumpUrl"
   ,parent_id as "parentId"
   ,case when (里程碑应完成+一级应完成)=0 then 0 else  round((里程碑已完成+一级已完成)/(里程碑应完成+一级应完成),4)*100 end||'%'  as "completionRate"
   ,有效节点数 as "validTasks"
   ,里程碑应完成+一级应完成 as "completeNum"
   ,里程碑已完成+一级已完成 as "completed"
   ,里程碑未完成+一级未完成 as "unfinished"

   ,应得总分 as "needResult"
   ,case when (应得总分)=0 then 0 else  round((实际得分)/(应得总分),4)*100 end "dynamicResult"
   ,实际得分 "realResult"
   ,绿灯 as "greenLight",黄灯 as "yellowLight",红灯 as  "redLight"
   ,里程碑应完成 as "miCompleteNum",里程碑已完成 as "miCompleted",里程碑未完成 as "miUnfinished"
   ,一级应完成 as "olCompleteNum",一级已完成 as "olCompleted",一级未完成 as "olUnfinished"
   ,'<span style="font-size:14px">预警说明：公司存在项目完成率低于90%，显示预警图标</span>' as "remark"
   ,case when ("isWarning">=1 and id<>'003200000000000000000000000000') then 1 else "isWarning" end as "isWarning"
   --,"isWarning"
   from 汇总 where 1=1 and 有效节点数>0

   order by LPAD(sn,10,'0')
   ;

END P_POM_KEY_NODE_SCHEDULE;

