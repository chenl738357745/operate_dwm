SET DEFINE OFF;

create or replace PROCEDURE  P_chenl_一览表
(
    companyGUID IN VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id clob;
    --当前日期
    nowdate date:=trunc(sysdate);
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '0001';
    ELSE
        v_id := companyGUID;
    END IF;
    -- 轨道图地址
    --/pom/plan-assess/node-monitoring/plan-nodes?companyid=''|| sp.unit_id ||''&ppid=''|| sp.id ||''&planType=关键节点计划''
    open items for   
    WITH
     分期 as(
     select ps.id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,sum(case when STAGE_NAME='无分期' then 1 else 0 end) 无分期个数 
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     group by ps.id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,proj.UNIT_ID
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
     WHEN  node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE)) >5 
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
   select basedata.PROJ_ID
   ,case when 分期.无分期个数=1 then 分期.PROJECT_NAME else 分期.STAGE_NAME end as name 
    --统计的父级字段处理，无分期项目父级是公司，有分期项目父级是项目
   ,case when 分期.无分期个数=1 then 分期.UNIT_ID else PROJECT_ID end parent_id
   ,有效节点数,应得总分
   ,绿灯,黄灯,红灯
   ,里程碑应完成,里程碑已完成,里程碑未完成
   ,一级应完成,一级已完成,一级未完成
   ,'/pom/plan-assess/node-monitoring/plan-nodes?companyid='|| 分期.UNIT_ID ||'&ppid='|| case when 分期.无分期个数=1 then PROJECT_ID else 分期.id end ||'&planType=关键节点计划' as url
   from basedata
   left join 分期 on basedata.PROJ_ID=分期.id
   union all 
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,0 有效节点数,0 应得总分
   ,0 绿灯,0 黄灯,0 红灯
   ,0 里程碑应完成,0 里程碑已完成,0 里程碑未完成
   ,0 一级应完成,0 一级已完成,0 一级未完成
   ,'' as url
   from sys_project proj
   left join (select * from 分期 where 无分期个数=1) s on proj.id=s.project_id
   where s.id is null
   )

   ,拼接项目公司树 as(
   select * from (
   select 
   id
   ,ORG_NAME as name
   ,parent_id
   ,0 有效节点数,0 应得总分
   ,0 绿灯,0 黄灯,0 红灯
   ,0 里程碑应完成,0 里程碑已完成,0 里程碑未完成
   ,0 一级应完成,0 一级已完成,0 一级未完成
   ,'' url
   FROM
   sys_business_unit where IS_COMPANY=1
   START WITH id IN (
                            SELECT DISTINCT 项目_分期.PROJ_ID FROM 项目_分期) 
                            CONNECT BY parent_id=id 
   union all
    select PROJ_ID as id
   ,name
   ,parent_id
   ,有效节点数,应得总分
   ,绿灯,黄灯,红灯
   ,里程碑应完成,里程碑已完成,里程碑未完成
   ,一级应完成,一级已完成,一级未完成,url FROM 项目_分期)start with id=companyGUID connect by prior id=parent_id
    )
--    
   ,汇总 as(select 
   id
   ,name
   ,parent_id
   ,url
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
 from 拼接项目公司树 s)
--    
  ,计算 as(select '' from dual)

   select  id
   ,name as name
   ,url
   ,parent_id
   ,case when (里程碑应完成+一级应完成)=0 then 0 else  round((里程碑已完成+一级已完成)/(里程碑应完成+一级应完成),4)*100 end 完成率
   ,有效节点数
   ,里程碑应完成+一级应完成 as 应完成
   ,里程碑已完成+一级已完成 as 已完成
   ,里程碑未完成+一级未完成 as 未完成
 
   ,应得总分,0 实际得分,0 动态得分
   ,绿灯,黄灯,红灯
   ,里程碑应完成,里程碑已完成,里程碑未完成
   ,一级应完成,一级已完成,一级未完成
  
   from 汇总  ;

END P_chenl_一览表;