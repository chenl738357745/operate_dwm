create or replace PROCEDURE P_MAP_area_unit_INOF (
    info OUT  SYS_REFCURSOR
) AS
--获取区域公司，sys_business_unit
--作者：陈丽
--日期：2021-07-28
BEGIN
OPEN info FOR
select * from sys_business_unit where level_rank =2 and is_company=1 order by order_hierarchy_code ;
END P_MAP_area_unit_INOF;
/
create or replace PROCEDURE "P_MAP_PROJ_PINDEX" (
    projid         IN             VARCHAR2 --项目名称
    ,info   OUT            SYS_REFCURSOR--
) AS
--获取项目最新指标
--作者：陈丽
--日期：2021-07-28
begin
OPEN info FOR
with max_phase as (   select * from mdm_project_phase where proj_id=projid and phase_order=(
SELECT max(phase_order) FROM
    mdm_project_phase where proj_id=projid))
    
select proj.id,proj.project_name,pindex.* from sys_project  proj 
left join max_phase pphase on proj.id=pphase.proj_id
left join mdm_obj_phase_index pindex on pphase.id=pindex.obj_phase_id
where proj.id=projid;
END P_MAP_PROJ_PINDEX;
/
CREATE OR REPLACE FORCE VIEW "V_MAP_PROJ_INOF"   AS 
  with 项目坐标 as(
select * from MDM_REGION )
---所有公司去掉集团。因为要找项目所属公司，使用查找公司根的思路查找
,除集团的公司 as (select * from sys_business_unit where is_company=1 and id<>'003200000000000000000000000000' )
----------------------------------------------------area_unit-开始
,公司root as(SELECT CONNECT_BY_ROOT(ID) as area_unit_id ,ID as unit_id FROM 除集团的公司 CONNECT BY PRIOR ID =parent_id)
,area_unit as(SELECT distinct area_unit_id,unit_id,bu.org_name,bu.org_full_name FROM 公司root
left join sys_business_unit bu on area_unit_id=bu.id where Level_rank=2)
----------------------------------------------------area_unit-结束
----以项目粒度关联坐标及区域公司
, resultdata as (
select
--经纬度及项目地址
r.longitude,r.latitude,r.mer_name
,proj.CITY_NAME,proj.PROVINCE_NAME,proj.PLACE_NAME,proj.CITY_ID,proj.PROVINCE_ID,proj.PLACE_ID
--区域公司字段
,u.area_unit_id as area_unit_id,u.org_name as area_unit_name,u.org_full_name
--项目相关字段
,proj.id,proj.project_code,project_name,proj.unit_id
from sys_project proj 
--关联坐标
left join 项目坐标 r on proj.Place_id=r.id
--关联所属区域公司
left join area_unit u on proj.unit_id=u.unit_id)
select "LONGITUDE","LATITUDE","MER_NAME","CITY_NAME","PROVINCE_NAME","PLACE_NAME","CITY_ID","PROVINCE_ID","PLACE_ID","AREA_UNIT_ID","AREA_UNIT_NAME","ORG_FULL_NAME","ID","PROJECT_CODE","PROJECT_NAME","UNIT_ID" from  resultdata
;
/
create or replace PROCEDURE "P_MAP_PROJ_INOF" (
    info OUT  SYS_REFCURSOR
) AS
--获取项目列表，包含项目所属公司、所属区域公司、经纬度
--作者：陈丽
--日期：2021-07-28
BEGIN
OPEN info FOR
select * from V_MAP_PROJ_INOF; 
END P_MAP_PROJ_INOF;