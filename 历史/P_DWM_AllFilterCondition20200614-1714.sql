create or replace PROCEDURE P_DWM_AllFilterCondition(filter OUT sys_refcursor)
as
begin
open filter for
select * from(
select 'isStart' as id, 'isStart' as "value",'是否已开工' as "lable",null as ParentId,1 as "sort",1 as "isChecked"  from dual
UNION
select 'isStart-01' as id,'1' as "value",'已开工' as "lable",'isStart' as ParentId,1 as "sort",1 as "isChecked"  from dual
UNION
select 'isStart-00' as id,'0' as "value",'未开工' as "lable",'isStart' as ParentId,2 as "sort",1 as "isChecked"  from dual

UNION
select  'opening' as id, 'opening' as "value",'是否已开盘' as "lable",null as ParentId,2 as "sort",0 as "isChecked"  from dual
UNION
select 'opening-01' as id ,'1' as "value",'是' as "lable",'opening' as ParentId,1 as "sort",1 as "isChecked"  from dual
UNION
select  'opening-00' as id,'0' as "value",'否' as "lable",'opening' as ParentId,2 as "sort",0 as "isChecked"  from dual

UNION
select 'openingYear' as id,'openingYear' as "value",'项目首开年份' as "lable",null as ParentId,3 as "sort",0 as "isChecked"  from dual
UNION
select 'openingYear-<2017' as id,'<2017' as "value" ,'2017年之前' as "lable",'openingYear' as ParentId,0 as "sort",0 as "isChecked"   from dual
UNION
select 'openingYear-'||to_char(tab.year) as id,to_char(tab.year) as "value",
to_char(tab.year)||'年' as "lable",
'openingYear' as ParentId,
ROWNUM+1 as "sort",
0 as "isChecked"
from (SELECT to_number(to_char(sysdate,'yyyy'))-ROWNUM+1 year FROM DUAL
CONNECT BY LEVEL<=4 order by year asc) tab

union
select 'isOperate' as id,'isOperate' as "value",'是否操盘' as "lable",null as ParentId,4 as "sort",0 as "isChecked"  from dual
UNION
select 'isOperate-01' as id ,'1' as "value",'是' as "lable",'isOperate' as ParentId,1 as "sort",0 as "isChecked"  from dual
UNION
select  'isOperate-00' as id,'0' as "value",'否' as "lable",'isOperate' as ParentId,2 as "sort",0 as "isChecked"  from dual

union
select 'isHasExistingHouse' as id,'isHasExistingHouse' as "value",'是否有现房存货' as "lable",null as ParentId,5 as "sort",0 as "isChecked"  from dual
UNION
select 'isHasExistingHouse-01' as id ,'1' as "value",'是' as "lable",'isHasExistingHouse' as ParentId,1 as "sort",0 as "isChecked"  from dual
UNION
select  'isHasExistingHouse-00' as id,'0' as "value",'否' as "lable",'isHasExistingHouse' as ParentId,2 as "sort",0 as "isChecked"  from dual


UNION
select 'obtainYear' as id, 'obtainYear' as "value",'项目获得年份' as "lable",null as ParentId,6 as "sort",0 as "isChecked"  from dual
UNION
select
'obtainYear-'||to_char(tab.year) as id,
case when ROWNUM=1 then '<='||to_char(tab.year) else to_char(tab.year) end "value",
case when ROWNUM=1 then to_char(tab.year)||'年之前' else to_char(tab.year)||'年' end "lable",
'obtainYear' as ParentId,
ROWNUM as "sort",
0 as "isChecked"
from (SELECT to_number(to_char(sysdate,'yyyy'))-ROWNUM+1 year FROM DUAL
CONNECT BY LEVEL<=5 order by year asc) tab


UNION
select  'org' as id, 'org' as "value",'二级单位' as "lable",null as ParentId,7 as "sort",0 as "isChecked"  from dual
UNION
select  'org-'||tab."value" as id,tab."value",tab."lable",tab."ParentId",ROWNUM as "sort",tab."isChecked" from (select id "value" ,org_name  "lable",'org' as "ParentId",ORDER_HIERARCHY_CODE as "sort",0 as "isChecked"  from (select ID,org_name,order_hierarchy_code from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK=2
        union 
        select ID,org_name,order_hierarchy_code from  (select parent_id  from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK=3) orgids 
        left join SYS_BUSINESS_UNIT on orgids.parent_id=SYS_BUSINESS_UNIT.id
        union
        select ID,org_name,order_hierarchy_code from(select * from SYS_BUSINESS_UNIT m start with m.id in (
        select sys_business_unit.ID from (select ORG_ID from DWM_SALE_RATE_PROJECT group by ORG_ID) tab left join  SYS_BUSINESS_UNIT on tab.ORG_ID=SYS_BUSINESS_UNIT.ID where SYS_BUSINESS_UNIT.LEVEL_RANK>3
        ) connect by prior m.parent_id=m.id)tab where tab.LEVEL_RANK=2 ) orgs order by orgs.order_hierarchy_code)tab

UNION
select  'hasFirstPhaseKeyPlan' as id, 'hasFirstPhaseKeyPlan' as "value",'已上线首期关键节点计划' as "lable",null as ParentId,8 as "sort",0 as "isChecked"  from dual
UNION
select 'hasFirstPhaseKeyPlan-01' as id ,'1' as "value",'是' as "lable",'hasFirstPhaseKeyPlan' as ParentId,1 as "sort",1 as "isChecked"  from dual
UNION
select  'hasFirstPhaseKeyPlan-00' as id,'0' as "value",'否' as "lable",'hasFirstPhaseKeyPlan' as ParentId,2 as "sort",0 as "isChecked"  from dual

        )filterItems order by filterItems."sort" ;
end P_DWM_AllFilterCondition;
