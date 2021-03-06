create or replace PROCEDURE P_DWM_云徙联合项目组
(
INFO OUT SYS_REFCURSOR
) AS
BEGIN

   OPEN INFO FOR 
      WITH basedata AS(
    ---末级业态，关联得到顶级业态。及末级业态所属对象关联(楼栋/项目/分期)
    select 
    proj.id  as 项目id
    ,proj.PROJECT_NAME as 项目名称
    ,w.TARGET_WORTH_PHASE as 阶段类型
    ,case when proj_stage.id is null then build_proj_stage.id else proj_stage.id end as 分期id
    ,case when proj_stage.id is null then build_proj_stage.STAGE_NAME else proj_stage.STAGE_NAME end as 分期名称
    ,build.id as 楼栋id
    ,build.BUILD_NAME as 楼栋名称
    ,objtype.OBJ_TYPE as 业态对象父级类型
    ,dtl.obj_id||GET_UUID() as 末级业态id
    ,dtl.obj_name as 末级业态全路径
    ,dtl.TOTAL_SALES_AREA as 总可售面积
    ,dtl.WORTH as 总货值
    ,product_type.id as 顶级业态id
    ,product_type.product_type_short_name as 顶级业态
    ,dtl.obj_parent_id as 业态对象父级id
    from (select * from DWM_TARGET_WORTH_DTL where OBJ_TYPE=40) dtl
    --关联业态 找到业态顶级
    left join MDM_BUILD_PRODUCT_TYPE PRODUCT_TYPE 
    on substr(dtl.obj_name,1,instr(dtl.obj_name,'/',1,1)-1)=PRODUCT_TYPE.product_type_name
    --关联自身找到业态的父级对象 类型
    left join DWM_TARGET_WORTH_DTL objtype on dtl.obj_parent_id=objtype.obj_id
    --关联主表建立用于与项目建立关联
    left join DWM_TARGET_WORTH w on dtl.TARGET_WORTH_ID=w.id
    --关联项目获得项目id
    left join sys_project proj on w.PROJ_ID=proj.id
    --关联楼栋获取业态的父级对象为楼栋的楼栋数据
    left join mdm_build build on dtl.obj_parent_id=build.id
    left join SYS_PROJECT_STAGE build_proj_stage on build.PERIOD_ID=build_proj_stage.id
    --关联分期获取业态的父级对象为分期的分期数据
    left join SYS_PROJECT_STAGE proj_stage on dtl.obj_parent_id=proj_stage.id
    --只获取已审核的目标货值
    where w.APPROVAL_STATUS='已审核' and w.is_delete=0
    order by objtype.OBJ_TYPE )
    
   ,可研 as(
    --可研:项目-业态顶级-末级业态 
    select ID,NAME,PARENT_ID,0 as 套,0 as 面积,0 as 金额,0 as 均价  from (
    select id||'|可研' id,project_name name,'可研' PARENT_ID  from SYS_PROJECT
    union all
    --业态顶级id：项目id|分期id|业态顶级id
    select proj.id||'|'||PRODUCT_TYPE.id as  id
    ,proj.project_NAME||'-'||PRODUCT_TYPE.PRODUCT_TYPE_NAME as name
    ,proj.ID||'|可研' as parent_id 
    from  SYS_PROJECT proj cross join (select * from
    MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)  
    union all 
    select 项目id||'|'||顶级业态id||'|'||末级业态id as id
    ,末级业态全路径
    ,项目id||'|'||顶级业态id as parent_id
    ,0 as 套
    ,总可售面积 as 面积
    ,总货值 as 金额
    ,0 as 均价 from basedata 
    where 阶段类型=0)
    
    ,全盘 as(
    --全盘:项目-分期-业态顶级-末级业态 
    select ID,NAME,PARENT_ID,0 as 套,10 as 面积,0 as 金额,0 as 均价  from (
    select id||'|全盘' as id,project_name name,'全盘' PARENT_ID  from SYS_PROJECT
    union all
    select proj_stage.PROJECT_ID||'|'||proj_stage.id  as Id
    ,proj_stage.STAGE_FULL_NAME as NAME
    ,proj_stage.PROJECT_ID||'|全盘' as PARENT_ID
    from SYS_PROJECT_STAGE PROJ_STAGE
    union all
    --业态顶级id：项目id|分期id|业态顶级id
    select proj_stage.PROJECT_ID||'|'||proj_stage.id||'|'||PRODUCT_TYPE.id as  id
    ,proj_stage.STAGE_FULL_NAME||'-'||PRODUCT_TYPE.PRODUCT_TYPE_NAME as name
    ,proj_stage.PROJECT_ID||'|'||proj_stage.id as parent_id 
    from  SYS_PROJECT_STAGE proj_stage cross join (select * from
    MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)  
    union all 
    select 项目id||'|'||分期id||'|'||顶级业态id||'|'||末级业态id as id
    ,末级业态全路径
    ,项目id||'|'||分期id||'|'||顶级业态id as parent_id
    ,0 as 套
    ,总可售面积 as 面积
    ,总货值 as 金额
    ,0 as 均价 from basedata 
    where 阶段类型=10)
    
     ,动态 as(
    --全盘:项目-分期-业态顶级-楼栋-末级业态
    select ID,NAME,PARENT_ID,20 as 套,0 as 面积,0 as 金额,0 as 均价  from (
    select id||'|动态' as id,project_name name,'动态' PARENT_ID  from SYS_PROJECT
    union all
    select proj_stage.PROJECT_ID||'|'||proj_stage.id||'|动态'  as Id
    ,proj_stage.STAGE_FULL_NAME as NAME
    ,proj_stage.PROJECT_ID||'|动态' as PARENT_ID
    from SYS_PROJECT_STAGE PROJ_STAGE
    union all
    --业态顶级id：项目id|分期id|业态顶级id
    select proj_stage.PROJECT_ID||'|'||proj_stage.id||'|'||PRODUCT_TYPE.id||'|动态' as  id
    ,proj_stage.STAGE_FULL_NAME||'-'||PRODUCT_TYPE.PRODUCT_TYPE_NAME as name
    ,proj_stage.PROJECT_ID||'|'||proj_stage.id||'|动态' as parent_id 
    from  SYS_PROJECT_STAGE proj_stage cross join (select * from
    MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)  
    --楼栋级：
    union all
    select 项目id||'|'||分期id||'|'||顶级业态id||'|'||楼栋id as id
    ,楼栋名称
    ,项目id||'|'||分期id||'|'||顶级业态id||'|动态' as parent_id
    ,0 as 套
    ,0 as 面积
    ,0 as 金额
    ,0 as 均价 from basedata 
    where 阶段类型=20 group by 楼栋id,项目id,分期id,顶级业态id,楼栋名称
    union all 
    select 项目id||'|'||分期id||'|'||顶级业态id||'|'||楼栋id||'|'||末级业态id as id
    ,末级业态全路径
    ,项目id||'|'||分期id||'|'||顶级业态id||'|'||楼栋id as parent_id
    ,0 as 套
    ,总可售面积 as 面积
    ,总货值 as 金额
    ,0 as 均价 from basedata 
    where 阶段类型=20)
   
   ,所有阶段树 as ( 
   select '可研' as id, '可研' as NAME,null PARENT_ID
    ,0 as 套,0 as 面积,0 as 金额,0 as 均价 from dual
    union all
   select '全盘' as id,'全盘' as NAME,null PARENT_ID
    ,0 as 套,0 as 面积,0 as 金额,0 as 均价 from dual
   union all
   select '动态' as id,'动态' as NAME,null PARENT_ID
    ,0 as 套,0 as 面积,0 as 金额,0 as 均价 from dual
   union all
   select ID,NAME,PARENT_ID,套,面积,金额,均价 from 可研
   union all
   select ID,NAME,PARENT_ID,套,面积,金额,均价 from 全盘
   union all 
   select  ID,NAME,PARENT_ID,套,面积,金额,均价 from 动态
   ),
   汇总后结果 as (
   select ID,NAME,PARENT_ID,套
  ,(select sum(面积) from 结果 m start with m.id=s.id connect by prior m.id=m.parent_id ) 面积
  ,(select sum(金额) from 结果 start with id=s.id connect by prior id=parent_id  ) 金额
  from 结果 s 
   )
   
    select ID,NAME,PARENT_ID,套,面积,金额
   ,金额/面积 as 均价
   from 汇总后结果 s ;

 
END P_DWM_云徙联合项目组;


   