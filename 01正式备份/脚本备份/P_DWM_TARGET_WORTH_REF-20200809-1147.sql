create or replace PROCEDURE P_DWM_TARGET_WORTH_REF (
    USERID   IN   VARCHAR2,
    STATIONID    IN  VARCHAR2,
    DEPTID   IN   VARCHAR2,
    COMPANYID IN VARCHAR2,
    i_projectId    IN               VARCHAR2,---项目id
    i_target_worth_phase    IN               VARCHAR2:=0 ---货值阶段（0：可研版目标货值，10：全盘开发计划版目标货值，20：动态版目标货值）
    ,o_target_worth out  SYS_REFCURSOR
) AS
		--获取目标货值。可研版本货值,全盘版本目标货值，动态版本目标货值（只是获取，未到数据库）
        --调用范围：货值管理系统目标货值刷新
		--作者：陈丽
		--日期：2020-06-14
l_created date:=sysdate;
l_UUID varchar2(36):=GET_UUID();
BEGIN
open o_TARGET_WORTH for

with 
-------------------------------------------=======对象基本信息，项目，分期，楼栋
obj_base as(
select id as obj_id,PROJECT_NAME as obj_name,UNIT_ID as parent_id,'项目' as objtype from sys_project obj_base where id=i_projectId
union all
select id as obj_id,STAGE_NAME as obj_name,project_id  as parent_id,'分期' as objtype from sys_project_stage where project_id=i_projectId
union all
select id as obj_id,BUILD_NAME as obj_name,period_id  as parent_id,'楼栋' as objtype from sys_build where PROJ_ID=i_projectId
),
-------------------------------------------=======已审核的对象阶段实例 状态（10：激活（未审核）；15：审核中，19：已审核；20：已成完成（即创建了下一个版本）
obj_phase as(
select pp.ID as instance_id,pp.PROJ_ID as obj_id,proj.PROJECT_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER,'项目' as objtype from MDM_PROJECT_PHASE  pp
left join mdm_phase mp on pp.PHASE_ID=mp.id
left join sys_project proj on pp.PROJ_ID=proj.id
--审核或者已创建下一阶段
where pp.PROJ_ID=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20)
union all
select p.ID as  instance_id,p.PERIOD_ID as obj_id,stage.STAGE_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER ,'分期' as objtype from MDM_PERIOD_PHASE p
left join sys_project_stage stage on p.PERIOD_ID=stage.id
left join mdm_phase mp on p.PHASE_ID=mp.id
--审核或者已创建下一阶段
where stage.project_id=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20)
union all
select b.ID as instance_id,b.BUILD_ID as obj_id,build.BUILD_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER ,'楼栋' as objtype from MDM_BUILD_PHASE b
left join sys_build build on b.BUILD_ID=build.id
left join sys_project proj on build.PROJ_ID=proj.id
left join mdm_phase mp on b.PHASE_ID=mp.id
--审核或者已创建下一阶段
where proj.id=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20) 
),
-------------------------------------------=======最新已审核阶段实例
obj_new_phase as
(
select * from (select obj_phase.*,row_number() over(partition by obj_id order by PHASE_ORDER desc) as order_num from obj_phase )obj_phase_order where order_num = 1
),
-------------------------------------------=======最新已审核目标货值--用于新增引入上一个已审核单价
latest_target_worth as
(select * from (select latest_tw.*,row_number() over(partition by OBJ_ID,obj_parent_id order by target_worth_phase,worth_v desc) as order_num from 
(select dtl.OBJ_ID,dtl.AVERAGE_PRICE,dtl.obj_parent_id,worth_v,target_worth_phase,dtl.obj_name 
,dtl.WORTH_DTL_PARENT_ID,dtl.WORTH_DTL_ID
from DWM_TARGET_WORTH_DTL dtl
left join DWM_TARGET_WORTH  w on dtl.TARGET_WORTH_ID=w.id
left join DWM_TARGET_WORTH_DTL parentdtl on dtl.obj_parent_id=parentdtl.obj_id
--已审核并且等于业态的
where  approval_status='已审核' and dtl.OBJ_TYPE=40  and w.proj_id =i_projectId) latest_tw
)obj_phase_order where order_num = 1
),
-------------------------------------------=======查询可研版本---查询可研版本---查询可研版本---查询可研版本---查询可研版本---查询可研版本
可研版本对象 as (
select  obj_base.obj_id||l_UUID as id,
        '可研版本' 类型,
        PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        ph.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
       case when ph.objtype='项目' then 0 
        when  ph.objtype='分期' then 20 
        when ph.objtype='楼栋' then 30 end as
        OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋;40业态）';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID,obj_base.obj_id  as OBJ_PARENT_ID,
        '' as PRODUCT_TYPE_ID
from obj_base obj_base
--所有阶段
left join obj_phase ph on obj_base.obj_id=ph.obj_id
--阶段指标
left join MDM_OBJ_PHASE_INDEX pIndex on ph.instance_id =pIndex.OBJ_PHASE_ID
--只查询可研版本计划
where  ph.phase_name='可研版' and obj_base.objtype='项目' 
)

,可研版本业态 as (
---查询项目业态指标
 select 
        pIndex.id id,
         '可研版本' 类型,
         PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
        40 OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋40业态）';
        可研版本对象.OBJ_PHASE_ID as OBJ_PHASE_ID,
        可研版本对象.id as WORTH_DTL_PARENT_ID,
        可研版本对象.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID
--业态指标
from MDM_OBJ_PHASE_PT_INDEX pIndex 
left join 可研版本对象 可研版本对象 on pIndex.OBJ_PHASE_ID=可研版本对象.OBJ_PHASE_ID
--只查询可研 分期业态指标。
where (可研版本对象.OBJ_TYPE=0 ) 
--and 可研版本对象.id is not null
--只查询可研阶段 项目的业态指标。
--where  ph.phase_name='可研版' and ph.objtype='项目' 
),


-------------------------------------------=======全盘版本---全盘版本---全盘版本---全盘版本---全盘版本---全盘版本---全盘版本
---项目和分期
全盘版本对象 as (
select  obj_base.obj_id||l_UUID as id,
        '全盘版本' 类型,
        PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        obj_base.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
         case when ph.objtype='项目' then 0 
        when  ph.objtype='分期' then 20 
        when  ph.objtype='楼栋' then 30 end as
        OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋;40业态）';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID ,obj_base.obj_id as OBJ_PARENT_ID,
       '' as PRODUCT_TYPE_ID
from obj_base obj_base
--所有阶段
left join obj_phase ph on obj_base.obj_id=ph.obj_id
--阶段指标
left join MDM_OBJ_PHASE_INDEX pIndex on ph.instance_id =pIndex.OBJ_PHASE_ID
--只查询全盘计划版 项目和分期指标。
where  ph.phase_name='全盘计划版' and (ph.objtype='项目' or ph.objtype='分期' ) and obj_base.objtype<>'楼栋' ) 

,全盘版本业态 as (
---查询项目业态指标
 select 
        pIndex.id,
         '全盘版本' 类型,
         PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
        40 OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋40业态）';
        全盘版本对象.OBJ_PHASE_ID as OBJ_PHASE_ID,
        全盘版本对象.id as WORTH_DTL_PARENT_ID ,
        全盘版本对象.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID

from  MDM_OBJ_PHASE_PT_INDEX pIndex 
left join 全盘版本对象 全盘版本对象 on pIndex.OBJ_PHASE_ID=全盘版本对象.OBJ_PHASE_ID
--只查询全盘计划版 分期业态指标。
where (全盘版本对象.OBJ_TYPE=20 )
)
,
-------------------------------------------=======动态版本---动态版本---动态版本---动态版本---动态版本---动态版本---动态版本
---项目和分期和楼栋,获取最新已审核阶段的数据
动态版本对象base as (
---查询主数据项目，分期，楼栋最新阶段的指标
select  obj_base.obj_id||l_UUID as id,
        '动态版本' 类型,
        newph.PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        obj_base.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
        case when newph.objtype='项目' then 0 
        when  newph.objtype='分期' then 20 
        when  newph.objtype='楼栋' then 30 end as
        OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋;40业态）';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID ,
        obj_base.obj_id as OBJ_PARENT_ID,
       '' as PRODUCT_TYPE_ID
from obj_base obj_base
--最新阶段
left join obj_new_phase newph on obj_base.obj_id=newph.obj_id
--最新阶段指标
left join MDM_OBJ_PHASE_INDEX pIndex on newph.instance_id =pIndex.OBJ_PHASE_ID)
--动态可研或全盘阶段 项目和分期
,动态可研或全盘阶段 as (select * from 动态版本对象base where (obj_type=20 and PHASE_NAME='全盘计划版') 
or (obj_type=0 and PHASE_NAME='可研版') )
--去掉可研全盘版基础对象的子级（分期或楼栋）
,动态版本对象 as (select base.* from 动态版本对象base base
left join 动态可研或全盘阶段 d on base.WORTH_DTL_PARENT_ID=d.id
where d.id is null
)

,动态版本业态 as (
---查询项目业态指标
 select 
        pIndex.id,
        '动态版本' 类型,
        动态版本对象.PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,--总建筑面积
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'总计容面积'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'总可售面积';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '地上可售面积';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '地下可售面积';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'总车位数';
        0 as GROUND_CARPORT,-- '地上车位数';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '地下车位数';
        ------0 AVERAGE_PRICE,-- '均价（手动录入）'
         ------0 WORTH,-- '均价（手动录入）'
        l_UUID as TARGET_WORTH_ID,--'货值主键';
        40 OBJ_TYPE,-- '对象类型（0：项目；20：分期；30：楼栋40业态）';
        动态版本对象.OBJ_PHASE_ID as OBJ_PHASE_ID,
        动态版本对象.id as WORTH_DTL_PARENT_ID, 
        动态版本对象.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID
        from MDM_OBJ_PHASE_PT_INDEX pIndex
        left join 动态版本对象 动态版本对象  on pIndex.OBJ_PHASE_ID=动态版本对象.OBJ_PHASE_ID
        where (动态版本对象.OBJ_TYPE=30 or
        pindex.OBJ_PHASE_ID in (select OBJ_PHASE_ID from 动态可研或全盘阶段) )
)

,计算 as(select pv.*,nvl(lw.AVERAGE_PRICE,0) as AVERAGE_PRICE_temp
,nvl(lw.AVERAGE_PRICE*(pv.TOTAL_CARPORT+pv.GROUND_CAN_SELL_AREA),0) as WORTH_temp
from (
        -----可研
        select * from 可研版本对象 where 1=case when i_target_worth_phase=0 then 1 else 0 end
        union all
        select * from 可研版本业态 where 1=case when i_target_worth_phase=0 then 1 else 0 end
        -----全盘
        union all
        select * from 全盘版本对象 where 1=case when i_target_worth_phase=10 then 1 else 0 end
        union all
        select * from 全盘版本业态 where 1=case when i_target_worth_phase=10 then 1 else 0 end
        ---动态
        union all
        select * from 动态版本对象 where 1=case when i_target_worth_phase=20 then 1 else 0 end
        union all
        select * from 动态版本业态 where 1=case when i_target_worth_phase=20 then 1 else 0 end
        ) pv left join latest_target_worth lw 
        on pv.OBJ_ID=lw.OBJ_ID and pv.obj_parent_id=lw.obj_parent_id)
--------------汇总货值
 , 汇总 as( select s.*,(select sum(WORTH_temp) from 计算 start with id=s.id connect by prior id=WORTH_DTL_PARENT_ID) as  WORTH_yuan
 from 计算 s)

,结果 as ( SELECT  GET_UUID() AS "id"
,汇总.TARGET_WORTH_ID AS "targetWorthId"
,汇总.PHASE_NAME AS "phaseName"
,汇总.类型 AS "类型"
,汇总.id as "worthDtlId"---【WORTH_DTL_ID】树id
,汇总.WORTH_DTL_PARENT_ID AS "worthDtlParentId"----【WORTH_DTL_PARENT_ID】 树父级id
,汇总.OBJ_PHASE_ID AS "objPhaseId"----"DWM_TARGET_WORTH_DTL"."OBJ_PHASE_ID" IS '对象阶段id';
,汇总.TOTAL_BUILD_AREA AS "totalBuildArea"----"DWM_TARGET_WORTH_DTL"."TOTAL_BUILD_AREA" IS '总建筑面积';
,汇总.TOTAL_VOLUME_AREA AS "totalVolumeArea"----"DWM_TARGET_WORTH_DTL"."TOTAL_VOLUME_AREA" IS '总计容面积';
,汇总.OBJ_PARENT_ID AS "objParentId"--"DWM_TARGET_WORTH_DTL"."OBJ_PARENT_ID" IS '对象父级id';
,汇总.OPERATE_ATTRIBUTE_NAME AS "operateAttributeName"---"DWM_TARGET_WORTH_DTL"."OPERATE_ATTRIBUTE_NAME" IS '经营属性名称';
,汇总.OBJ_NAME AS "objName"----"DWM_TARGET_WORTH_DTL"."OBJ_NAME" IS '对象名称（项目名称、分期名称、业态名称）';
,汇总.OBJ_ID AS "objId"----"DWM_TARGET_WORTH_DTL"."OBJ_ID" IS '对象id';
,汇总.GROUND_CAN_SELL_AREA AS "groundCanSellArea"--"DWM_TARGET_WORTH_DTL"."GROUND_CAN_SELL_AREA" IS '地上可售面积';
,汇总.GROUND_CARPORT AS "groundCarport"---"DWM_TARGET_WORTH_DTL"."GROUND_CARPORT" IS '地上车位数';
,汇总.OPERATE_ATTRIBUTE_ID AS "operateAttributeId"---."DWM_TARGET_WORTH_DTL"."OPERATE_ATTRIBUTE_ID" IS '经营属性Id';
,汇总.UNDERGROUND_CARPORT AS "undergroundCarport"---"DWM_TARGET_WORTH_DTL"."UNDERGROUND_CARPORT" IS '地下车位数';
,汇总.OBJ_TYPE AS "objType"---."DWM_TARGET_WORTH_DTL"."OBJ_TYPE" IS '对象类型（0：项目；20：分期；30：楼栋40业态）';
,汇总.TOTAL_CARPORT AS "totalCarport"---"DWM_TARGET_WORTH_DTL"."TOTAL_CARPORT" IS '总车位数';
,汇总.TOTAL_SALES_AREA AS "totalSalesArea"----."DWM_TARGET_WORTH_DTL"."TOTAL_SALES_AREA" IS '总可售面积';
,汇总.UNDERGROUND_CAN_SELL_AREA AS "undergroundCanSellArea"--"DWM_TARGET_WORTH_DTL"."UNDERGROUND_CAN_SELL_AREA" IS '地下可售面积';
,CASE WHEN (TOTAL_CARPORT+GROUND_CAN_SELL_AREA)=0 THEN 0 ELSE WORTH_yuan/(TOTAL_CARPORT+GROUND_CAN_SELL_AREA) END
AS "averagePrice"---"DWM_TARGET_WORTH_DTL"."AVERAGE_PRICE" IS '均价（手动录入）';
,WORTH_yuan/10000 AS "worth"----"DWM_TARGET_WORTH_DTL"."WORTH" IS '货值';
,pt.is_carport as "isCarport"---"DWM_TARGET_WORTH_DTL"."IS_CARPORT" IS '是否车位,1:是,0:否';
,WORTH_yuan
FROM 汇总
left join MDM_BUILD_PRODUCT_TYPE pt on 汇总.PRODUCT_TYPE_ID=pt.id)

select * from 结果
;

END P_DWM_TARGET_WORTH_REF;
----------------------------------------------chenl20200621结束------从主数据刷新目标货值存储过程


----------------------------------------------chenl20200621开始------从主数据刷新目标货值存储过程注册