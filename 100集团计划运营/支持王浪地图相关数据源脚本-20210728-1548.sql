create or replace PROCEDURE P_MAP_area_unit_INOF (
    info OUT  SYS_REFCURSOR
) AS
--��ȡ����˾��sys_business_unit
--���ߣ�����
--���ڣ�2021-07-28
BEGIN
OPEN info FOR
select * from sys_business_unit where level_rank =2 and is_company=1 order by order_hierarchy_code ;
END P_MAP_area_unit_INOF;
/
create or replace PROCEDURE "P_MAP_PROJ_PINDEX" (
    projid         IN             VARCHAR2 --��Ŀ����
    ,info   OUT            SYS_REFCURSOR--
) AS
--��ȡ��Ŀ����ָ��
--���ߣ�����
--���ڣ�2021-07-28
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
  with ��Ŀ���� as(
select * from MDM_REGION )
---���й�˾ȥ�����š���ΪҪ����Ŀ������˾��ʹ�ò��ҹ�˾����˼·����
,�����ŵĹ�˾ as (select * from sys_business_unit where is_company=1 and id<>'003200000000000000000000000000' )
----------------------------------------------------area_unit-��ʼ
,��˾root as(SELECT CONNECT_BY_ROOT(ID) as area_unit_id ,ID as unit_id FROM �����ŵĹ�˾ CONNECT BY PRIOR ID =parent_id)
,area_unit as(SELECT distinct area_unit_id,unit_id,bu.org_name,bu.org_full_name FROM ��˾root
left join sys_business_unit bu on area_unit_id=bu.id where Level_rank=2)
----------------------------------------------------area_unit-����
----����Ŀ���ȹ������꼰����˾
, resultdata as (
select
--��γ�ȼ���Ŀ��ַ
r.longitude,r.latitude,r.mer_name
,proj.CITY_NAME,proj.PROVINCE_NAME,proj.PLACE_NAME,proj.CITY_ID,proj.PROVINCE_ID,proj.PLACE_ID
--����˾�ֶ�
,u.area_unit_id as area_unit_id,u.org_name as area_unit_name,u.org_full_name
--��Ŀ����ֶ�
,proj.id,proj.project_code,project_name,proj.unit_id
from sys_project proj 
--��������
left join ��Ŀ���� r on proj.Place_id=r.id
--������������˾
left join area_unit u on proj.unit_id=u.unit_id)
select "LONGITUDE","LATITUDE","MER_NAME","CITY_NAME","PROVINCE_NAME","PLACE_NAME","CITY_ID","PROVINCE_ID","PLACE_ID","AREA_UNIT_ID","AREA_UNIT_NAME","ORG_FULL_NAME","ID","PROJECT_CODE","PROJECT_NAME","UNIT_ID" from  resultdata
;
/
create or replace PROCEDURE "P_MAP_PROJ_INOF" (
    info OUT  SYS_REFCURSOR
) AS
--��ȡ��Ŀ�б�������Ŀ������˾����������˾����γ��
--���ߣ�����
--���ڣ�2021-07-28
BEGIN
OPEN info FOR
select * from V_MAP_PROJ_INOF; 
END P_MAP_PROJ_INOF;