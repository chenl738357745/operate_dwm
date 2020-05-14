----业态级id
select proj.id||'|'||PRODUCT_TYPE.id,proj.PROJECT_NAME,PRODUCT_TYPE.PRODUCT_TYPE_NAME
from  sys_project proj cross join (select * from
MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE;

----查找末级业态对应顶级业态
----楼栋级
select substr('333-4444-AAA-BBB',1,instr('333-4444-AAA-BBB','-',1,1)-1) 值 from dual;
select instr('4444-AAA-BBB','-',1,1) 值 from dual;

----因存储数据的维度不一致，需要将数据按存储最小颗粒度业态重组业态对应的项目、分期、楼栋数据
WITH basedata AS(
---末级业态，关联得到顶级业态。及末级业态所属对象类型(楼栋/项目/分期)
select 
proj.id  as 项目id
,proj.PROJECT_NAME as 项目名称
,w.TARGET_WORTH_PHASE as 阶段类型
,proj_stage.id 分期id
,proj_stage.STAGE_NAME 分期名称
,build.id as 楼栋id
,build.BUILD_NAME as 楼栋名称
,objtype.OBJ_TYPE as 业态对象父级类型
,dtl.obj_id 末级业态id
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
--关联分期获取业态的父级对象为分期的分期数据
left join SYS_PROJECT_STAGE proj_stage on dtl.obj_parent_id=proj_stage.id
--只获取已审核的目标货值
where w.APPROVAL_STATUS='已审核'
order by objtype.OBJ_TYPE )

-- 全盘:分期-业态顶级

select id,name,parent_id,'' as 套,0 as 面积,0 as 金额,0 as 均价  from (
select proj_stage.PROJECT_ID||'|'||proj_stage.id  as id
,proj_stage.STAGE_FULL_NAME as name
,proj_stage.PROJECT_ID as parent_id
from SYS_PROJECT_STAGE proj_stage
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
,'' as 套
,总可售面积 as 面积
,总货值 as 金额
,0 as 均价 from basedata 
where 阶段类型=10;



select * from DWM_TARGET_WORTH_DTL








---分期级别
select * from SYS_PROJECT_STAGE proj_stage
union all
---分期对应业态级别
select * from (select proj.id||'|'||PRODUCT_TYPE.id,proj.PROJECT_NAME,PRODUCT_TYPE.PRODUCT_TYPE_NAME
from  sys_project proj cross join (select * from
MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)
---楼栋级别
union all
select * from mdm_build
