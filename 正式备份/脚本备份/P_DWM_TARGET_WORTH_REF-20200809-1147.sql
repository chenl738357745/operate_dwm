create or replace PROCEDURE P_DWM_TARGET_WORTH_REF (
    USERID   IN   VARCHAR2,
    STATIONID    IN  VARCHAR2,
    DEPTID   IN   VARCHAR2,
    COMPANYID IN VARCHAR2,
    i_projectId    IN               VARCHAR2,---��Ŀid
    i_target_worth_phase    IN               VARCHAR2:=0 ---��ֵ�׶Σ�0�����а�Ŀ���ֵ��10��ȫ�̿����ƻ���Ŀ���ֵ��20����̬��Ŀ���ֵ��
    ,o_target_worth out  SYS_REFCURSOR
) AS
		--��ȡĿ���ֵ�����а汾��ֵ,ȫ�̰汾Ŀ���ֵ����̬�汾Ŀ���ֵ��ֻ�ǻ�ȡ��δ�����ݿ⣩
        --���÷�Χ����ֵ����ϵͳĿ���ֵˢ��
		--���ߣ�����
		--���ڣ�2020-06-14
l_created date:=sysdate;
l_UUID varchar2(36):=GET_UUID();
BEGIN
open o_TARGET_WORTH for

with 
-------------------------------------------=======���������Ϣ����Ŀ�����ڣ�¥��
obj_base as(
select id as obj_id,PROJECT_NAME as obj_name,UNIT_ID as parent_id,'��Ŀ' as objtype from sys_project obj_base where id=i_projectId
union all
select id as obj_id,STAGE_NAME as obj_name,project_id  as parent_id,'����' as objtype from sys_project_stage where project_id=i_projectId
union all
select id as obj_id,BUILD_NAME as obj_name,period_id  as parent_id,'¥��' as objtype from sys_build where PROJ_ID=i_projectId
),
-------------------------------------------=======����˵Ķ���׶�ʵ�� ״̬��10�����δ��ˣ���15������У�19������ˣ�20���ѳ���ɣ�����������һ���汾��
obj_phase as(
select pp.ID as instance_id,pp.PROJ_ID as obj_id,proj.PROJECT_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER,'��Ŀ' as objtype from MDM_PROJECT_PHASE  pp
left join mdm_phase mp on pp.PHASE_ID=mp.id
left join sys_project proj on pp.PROJ_ID=proj.id
--��˻����Ѵ�����һ�׶�
where pp.PROJ_ID=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20)
union all
select p.ID as  instance_id,p.PERIOD_ID as obj_id,stage.STAGE_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER ,'����' as objtype from MDM_PERIOD_PHASE p
left join sys_project_stage stage on p.PERIOD_ID=stage.id
left join mdm_phase mp on p.PHASE_ID=mp.id
--��˻����Ѵ�����һ�׶�
where stage.project_id=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20)
union all
select b.ID as instance_id,b.BUILD_ID as obj_id,build.BUILD_NAME as obj_name,mp.PHASE_NAME,mp.PHASE_ORDER ,'¥��' as objtype from MDM_BUILD_PHASE b
left join sys_build build on b.BUILD_ID=build.id
left join sys_project proj on build.PROJ_ID=proj.id
left join mdm_phase mp on b.PHASE_ID=mp.id
--��˻����Ѵ�����һ�׶�
where proj.id=i_projectId and (PHASE_STATE=19 or PHASE_STATE=20) 
),
-------------------------------------------=======��������˽׶�ʵ��
obj_new_phase as
(
select * from (select obj_phase.*,row_number() over(partition by obj_id order by PHASE_ORDER desc) as order_num from obj_phase )obj_phase_order where order_num = 1
),
-------------------------------------------=======���������Ŀ���ֵ--��������������һ������˵���
latest_target_worth as
(select * from (select latest_tw.*,row_number() over(partition by OBJ_ID,obj_parent_id order by target_worth_phase,worth_v desc) as order_num from 
(select dtl.OBJ_ID,dtl.AVERAGE_PRICE,dtl.obj_parent_id,worth_v,target_worth_phase,dtl.obj_name 
,dtl.WORTH_DTL_PARENT_ID,dtl.WORTH_DTL_ID
from DWM_TARGET_WORTH_DTL dtl
left join DWM_TARGET_WORTH  w on dtl.TARGET_WORTH_ID=w.id
left join DWM_TARGET_WORTH_DTL parentdtl on dtl.obj_parent_id=parentdtl.obj_id
--����˲��ҵ���ҵ̬��
where  approval_status='�����' and dtl.OBJ_TYPE=40  and w.proj_id =i_projectId) latest_tw
)obj_phase_order where order_num = 1
),
-------------------------------------------=======��ѯ���а汾---��ѯ���а汾---��ѯ���а汾---��ѯ���а汾---��ѯ���а汾---��ѯ���а汾
���а汾���� as (
select  obj_base.obj_id||l_UUID as id,
        '���а汾' ����,
        PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        ph.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
       case when ph.objtype='��Ŀ' then 0 
        when  ph.objtype='����' then 20 
        when ph.objtype='¥��' then 30 end as
        OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��;40ҵ̬��';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID,obj_base.obj_id  as OBJ_PARENT_ID,
        '' as PRODUCT_TYPE_ID
from obj_base obj_base
--���н׶�
left join obj_phase ph on obj_base.obj_id=ph.obj_id
--�׶�ָ��
left join MDM_OBJ_PHASE_INDEX pIndex on ph.instance_id =pIndex.OBJ_PHASE_ID
--ֻ��ѯ���а汾�ƻ�
where  ph.phase_name='���а�' and obj_base.objtype='��Ŀ' 
)

,���а汾ҵ̬ as (
---��ѯ��Ŀҵָ̬��
 select 
        pIndex.id id,
         '���а汾' ����,
         PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
        40 OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��40ҵ̬��';
        ���а汾����.OBJ_PHASE_ID as OBJ_PHASE_ID,
        ���а汾����.id as WORTH_DTL_PARENT_ID,
        ���а汾����.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID
--ҵָ̬��
from MDM_OBJ_PHASE_PT_INDEX pIndex 
left join ���а汾���� ���а汾���� on pIndex.OBJ_PHASE_ID=���а汾����.OBJ_PHASE_ID
--ֻ��ѯ���� ����ҵָ̬�ꡣ
where (���а汾����.OBJ_TYPE=0 ) 
--and ���а汾����.id is not null
--ֻ��ѯ���н׶� ��Ŀ��ҵָ̬�ꡣ
--where  ph.phase_name='���а�' and ph.objtype='��Ŀ' 
),


-------------------------------------------=======ȫ�̰汾---ȫ�̰汾---ȫ�̰汾---ȫ�̰汾---ȫ�̰汾---ȫ�̰汾---ȫ�̰汾
---��Ŀ�ͷ���
ȫ�̰汾���� as (
select  obj_base.obj_id||l_UUID as id,
        'ȫ�̰汾' ����,
        PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        obj_base.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
         case when ph.objtype='��Ŀ' then 0 
        when  ph.objtype='����' then 20 
        when  ph.objtype='¥��' then 30 end as
        OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��;40ҵ̬��';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID ,obj_base.obj_id as OBJ_PARENT_ID,
       '' as PRODUCT_TYPE_ID
from obj_base obj_base
--���н׶�
left join obj_phase ph on obj_base.obj_id=ph.obj_id
--�׶�ָ��
left join MDM_OBJ_PHASE_INDEX pIndex on ph.instance_id =pIndex.OBJ_PHASE_ID
--ֻ��ѯȫ�̼ƻ��� ��Ŀ�ͷ���ָ�ꡣ
where  ph.phase_name='ȫ�̼ƻ���' and (ph.objtype='��Ŀ' or ph.objtype='����' ) and obj_base.objtype<>'¥��' ) 

,ȫ�̰汾ҵ̬ as (
---��ѯ��Ŀҵָ̬��
 select 
        pIndex.id,
         'ȫ�̰汾' ����,
         PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
        40 OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��40ҵ̬��';
        ȫ�̰汾����.OBJ_PHASE_ID as OBJ_PHASE_ID,
        ȫ�̰汾����.id as WORTH_DTL_PARENT_ID ,
        ȫ�̰汾����.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID

from  MDM_OBJ_PHASE_PT_INDEX pIndex 
left join ȫ�̰汾���� ȫ�̰汾���� on pIndex.OBJ_PHASE_ID=ȫ�̰汾����.OBJ_PHASE_ID
--ֻ��ѯȫ�̼ƻ��� ����ҵָ̬�ꡣ
where (ȫ�̰汾����.OBJ_TYPE=20 )
)
,
-------------------------------------------=======��̬�汾---��̬�汾---��̬�汾---��̬�汾---��̬�汾---��̬�汾---��̬�汾
---��Ŀ�ͷ��ں�¥��,��ȡ��������˽׶ε�����
��̬�汾����base as (
---��ѯ��������Ŀ�����ڣ�¥�����½׶ε�ָ��
select  obj_base.obj_id||l_UUID as id,
        '��̬�汾' ����,
        newph.PHASE_NAME,
        obj_base.obj_name as OBJ_NAME,
        obj_base.obj_id as OBJ_ID,
        '' as OPERATE_ATTRIBUTE_ID,
        '' as OPERATE_ATTRIBUTE_NAME,
        pIndex.OVERALL_FLOORAGE_AREA as TOTAL_BUILD_AREA,
        pIndex.TOTAL_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
        case when newph.objtype='��Ŀ' then 0 
        when  newph.objtype='����' then 20 
        when  newph.objtype='¥��' then 30 end as
        OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��;40ҵ̬��';
        pIndex.OBJ_PHASE_ID as OBJ_PHASE_ID,
        obj_base.parent_id||l_UUID as WORTH_DTL_PARENT_ID ,
        obj_base.obj_id as OBJ_PARENT_ID,
       '' as PRODUCT_TYPE_ID
from obj_base obj_base
--���½׶�
left join obj_new_phase newph on obj_base.obj_id=newph.obj_id
--���½׶�ָ��
left join MDM_OBJ_PHASE_INDEX pIndex on newph.instance_id =pIndex.OBJ_PHASE_ID)
--��̬���л�ȫ�̽׶� ��Ŀ�ͷ���
,��̬���л�ȫ�̽׶� as (select * from ��̬�汾����base where (obj_type=20 and PHASE_NAME='ȫ�̼ƻ���') 
or (obj_type=0 and PHASE_NAME='���а�') )
--ȥ������ȫ�̰����������Ӽ������ڻ�¥����
,��̬�汾���� as (select base.* from ��̬�汾����base base
left join ��̬���л�ȫ�̽׶� d on base.WORTH_DTL_PARENT_ID=d.id
where d.id is null
)

,��̬�汾ҵ̬ as (
---��ѯ��Ŀҵָ̬��
 select 
        pIndex.id,
        '��̬�汾' ����,
        ��̬�汾����.PHASE_NAME,
        pIndex.product_type_name as OBJ_NAME,
        pIndex.product_type_id as OBJ_ID,
        pIndex.OPERATE_ATTRIBUTE_ID as OPERATE_ATTRIBUTE_ID,
        pIndex.OPERATE_ATTRIBUTE_NAME as OPERATE_ATTRIBUTE_NAME,
        pIndex.GROUND_TOTAL_BUILD_AREA+pIndex.UNDERGROUND_TOTAL_BUILD_AREA as TOTAL_BUILD_AREA,--�ܽ������
        pIndex.GROUND_CAPACITY_AREA+pIndex.UNDERGROUND_CAPACITY_AREA as TOTAL_VOLUME_AREA,--'�ܼ������'
        pIndex.TOTAL_SALE_AREA as TOTAL_SALES_AREA,---'�ܿ������';
        pIndex.GROUND_SALE_AREA as GROUND_CAN_SELL_AREA,--GROUND_CAN_SELL_AREA" IS '���Ͽ������';
        pIndex.UNDERGROUND_SALE_AREA as UNDERGROUND_CAN_SELL_AREA,-- IS '���¿������';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT  as TOTAL_CARPORT,--'�ܳ�λ��';
        0 as GROUND_CARPORT,-- '���ϳ�λ��';
        pIndex.UNDERGROUND_TOTAL_SALE_CARPORT as UNDERGROUND_CARPORT,-- '���³�λ��';
        ------0 AVERAGE_PRICE,-- '���ۣ��ֶ�¼�룩'
         ------0 WORTH,-- '���ۣ��ֶ�¼�룩'
        l_UUID as TARGET_WORTH_ID,--'��ֵ����';
        40 OBJ_TYPE,-- '�������ͣ�0����Ŀ��20�����ڣ�30��¥��40ҵ̬��';
        ��̬�汾����.OBJ_PHASE_ID as OBJ_PHASE_ID,
        ��̬�汾����.id as WORTH_DTL_PARENT_ID, 
        ��̬�汾����.OBJ_ID as OBJ_PARENT_ID,
        pIndex.PRODUCT_TYPE_ID
        from MDM_OBJ_PHASE_PT_INDEX pIndex
        left join ��̬�汾���� ��̬�汾����  on pIndex.OBJ_PHASE_ID=��̬�汾����.OBJ_PHASE_ID
        where (��̬�汾����.OBJ_TYPE=30 or
        pindex.OBJ_PHASE_ID in (select OBJ_PHASE_ID from ��̬���л�ȫ�̽׶�) )
)

,���� as(select pv.*,nvl(lw.AVERAGE_PRICE,0) as AVERAGE_PRICE_temp
,nvl(lw.AVERAGE_PRICE*(pv.TOTAL_CARPORT+pv.GROUND_CAN_SELL_AREA),0) as WORTH_temp
from (
        -----����
        select * from ���а汾���� where 1=case when i_target_worth_phase=0 then 1 else 0 end
        union all
        select * from ���а汾ҵ̬ where 1=case when i_target_worth_phase=0 then 1 else 0 end
        -----ȫ��
        union all
        select * from ȫ�̰汾���� where 1=case when i_target_worth_phase=10 then 1 else 0 end
        union all
        select * from ȫ�̰汾ҵ̬ where 1=case when i_target_worth_phase=10 then 1 else 0 end
        ---��̬
        union all
        select * from ��̬�汾���� where 1=case when i_target_worth_phase=20 then 1 else 0 end
        union all
        select * from ��̬�汾ҵ̬ where 1=case when i_target_worth_phase=20 then 1 else 0 end
        ) pv left join latest_target_worth lw 
        on pv.OBJ_ID=lw.OBJ_ID and pv.obj_parent_id=lw.obj_parent_id)
--------------���ܻ�ֵ
 , ���� as( select s.*,(select sum(WORTH_temp) from ���� start with id=s.id connect by prior id=WORTH_DTL_PARENT_ID) as  WORTH_yuan
 from ���� s)

,��� as ( SELECT  GET_UUID() AS "id"
,����.TARGET_WORTH_ID AS "targetWorthId"
,����.PHASE_NAME AS "phaseName"
,����.���� AS "����"
,����.id as "worthDtlId"---��WORTH_DTL_ID����id
,����.WORTH_DTL_PARENT_ID AS "worthDtlParentId"----��WORTH_DTL_PARENT_ID�� ������id
,����.OBJ_PHASE_ID AS "objPhaseId"----"DWM_TARGET_WORTH_DTL"."OBJ_PHASE_ID" IS '����׶�id';
,����.TOTAL_BUILD_AREA AS "totalBuildArea"----"DWM_TARGET_WORTH_DTL"."TOTAL_BUILD_AREA" IS '�ܽ������';
,����.TOTAL_VOLUME_AREA AS "totalVolumeArea"----"DWM_TARGET_WORTH_DTL"."TOTAL_VOLUME_AREA" IS '�ܼ������';
,����.OBJ_PARENT_ID AS "objParentId"--"DWM_TARGET_WORTH_DTL"."OBJ_PARENT_ID" IS '���󸸼�id';
,����.OPERATE_ATTRIBUTE_NAME AS "operateAttributeName"---"DWM_TARGET_WORTH_DTL"."OPERATE_ATTRIBUTE_NAME" IS '��Ӫ��������';
,����.OBJ_NAME AS "objName"----"DWM_TARGET_WORTH_DTL"."OBJ_NAME" IS '�������ƣ���Ŀ���ơ��������ơ�ҵ̬���ƣ�';
,����.OBJ_ID AS "objId"----"DWM_TARGET_WORTH_DTL"."OBJ_ID" IS '����id';
,����.GROUND_CAN_SELL_AREA AS "groundCanSellArea"--"DWM_TARGET_WORTH_DTL"."GROUND_CAN_SELL_AREA" IS '���Ͽ������';
,����.GROUND_CARPORT AS "groundCarport"---"DWM_TARGET_WORTH_DTL"."GROUND_CARPORT" IS '���ϳ�λ��';
,����.OPERATE_ATTRIBUTE_ID AS "operateAttributeId"---."DWM_TARGET_WORTH_DTL"."OPERATE_ATTRIBUTE_ID" IS '��Ӫ����Id';
,����.UNDERGROUND_CARPORT AS "undergroundCarport"---"DWM_TARGET_WORTH_DTL"."UNDERGROUND_CARPORT" IS '���³�λ��';
,����.OBJ_TYPE AS "objType"---."DWM_TARGET_WORTH_DTL"."OBJ_TYPE" IS '�������ͣ�0����Ŀ��20�����ڣ�30��¥��40ҵ̬��';
,����.TOTAL_CARPORT AS "totalCarport"---"DWM_TARGET_WORTH_DTL"."TOTAL_CARPORT" IS '�ܳ�λ��';
,����.TOTAL_SALES_AREA AS "totalSalesArea"----."DWM_TARGET_WORTH_DTL"."TOTAL_SALES_AREA" IS '�ܿ������';
,����.UNDERGROUND_CAN_SELL_AREA AS "undergroundCanSellArea"--"DWM_TARGET_WORTH_DTL"."UNDERGROUND_CAN_SELL_AREA" IS '���¿������';
,CASE WHEN (TOTAL_CARPORT+GROUND_CAN_SELL_AREA)=0 THEN 0 ELSE WORTH_yuan/(TOTAL_CARPORT+GROUND_CAN_SELL_AREA) END
AS "averagePrice"---"DWM_TARGET_WORTH_DTL"."AVERAGE_PRICE" IS '���ۣ��ֶ�¼�룩';
,WORTH_yuan/10000 AS "worth"----"DWM_TARGET_WORTH_DTL"."WORTH" IS '��ֵ';
,pt.is_carport as "isCarport"---"DWM_TARGET_WORTH_DTL"."IS_CARPORT" IS '�Ƿ�λ,1:��,0:��';
,WORTH_yuan
FROM ����
left join MDM_BUILD_PRODUCT_TYPE pt on ����.PRODUCT_TYPE_ID=pt.id)

select * from ���
;

END P_DWM_TARGET_WORTH_REF;
----------------------------------------------chenl20200621����------��������ˢ��Ŀ���ֵ�洢����


----------------------------------------------chenl20200621��ʼ------��������ˢ��Ŀ���ֵ�洢����ע��