create or replace PROCEDURE P_DWM_����������Ŀ��
(
INFO OUT SYS_REFCURSOR
) AS
BEGIN

   OPEN INFO FOR 
  select 
   ---PARENTID��'PARENTID','ORGID','ORGNAME'
   feasiblew_dtl.obj_parent_id as PARENTID,
   feasiblew_dtl.obj_id as ORGID,
   feasiblew_dtl.obj_name as ORGNAME,
   feasiblew.id as wid,
   p.id as projid,p.PROJECT_NAME,feasiblew_dtl.TOTAL_SALES_AREA as "����-���",feasiblew_dtl.AVERAGE_PRICE as "����-����",feasiblew_dtl.WORTH  as "����-���"
   from sys_project p
----- ������Ŀ�Ŀ��н׶λ�ֵ
   left join DWM_TARGET_WORTH feasiblew on p.id=feasiblew.proj_id and feasiblew.TARGET_WORTH_PHASE=0 and feasiblew.IS_DELETE=0 and feasiblew.APPROVAL_STATUS='�����'
   left join DWM_TARGET_WORTH_DTL feasiblew_dtl on feasiblew.id=feasiblew_dtl.TARGET_WORTH_id
   
--left join DWM_TARGET_WORTH wholew on p.id=wholew.proj_id and wholew.TARGET_WORTH_PHASE=10 and wholew.IS_DELETE=0 and wholew.APPROVAL_STATUS='�����'
--left join DWM_TARGET_WORTH_DTL wholew_dtl on wholew.id=wholew_dtl.TARGET_WORTH_id

   where feasiblew_dtl.obj_id is not null 
  -- and  feasiblew.id in('a451e27c-0386-207d-e053-8606160a4b03','55a0dcba-4028-4e6e-ae80-f2d07b76d5d3')
   ;
   
  -- select * from DWM_TARGET_WORTH wholew where wholew.TARGET_WORTH_PHASE=10 and wholew.IS_DELETE=0
   
   ----- ��װ��Ŀ-����-ҵ̬-¥����
----- ��ȡ¥��ȡ֤ʱ��

--select p.id,p.PROJECT_NAME,feasiblew_dtl.TOTAL_SALES_AREA as "����-���",feasiblew_dtl.AVERAGE_PRICE as "����-����",feasiblew_dtl.WORTH  as "����-���" from sys_project p
------- ������Ŀ�Ŀ��н׶λ�ֵ
--left join DWM_TARGET_WORTH feasiblew on p.id=feasiblew.proj_id and feasiblew.TARGET_WORTH_PHASE=0 and feasiblew.IS_DELETE=0 and feasiblew.APPROVAL_STATUS='�����'
--left join DWM_TARGET_WORTH_DTL feasiblew_dtl on feasiblew.id=feasiblew_dtl.TARGET_WORTH_id 
------- ������Ŀ��ȫ�̽׶λ�ֵ
--left join DWM_TARGET_WORTH wholew on p.id=wholew.proj_id and wholew.TARGET_WORTH_PHASE=10 and wholew.IS_DELETE=0 and wholew.APPROVAL_STATUS='�����'
--left join DWM_TARGET_WORTH_DTL wholew_dtl on wholew.id=wholew_dtl.TARGET_WORTH_id
--
------- ������Ŀ�����°��ֵ
--left join DWM_TARGET_WORTH dynamicw on p.id=dynamicw.proj_id
------- ������Ŀ�����°��ֵ
END P_DWM_����������Ŀ��;

----��Ŀ���ڼ�

----ҵ̬��id
select proj.id||'|'||PRODUCT_TYPE.id,proj.PROJECT_NAME,PRODUCT_TYPE.PRODUCT_TYPE_NAME
from  sys_project proj cross join (select * from
MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE;

----����ĩ��ҵ̬��Ӧ����ҵ̬
----¥����
select substr('333-4444-AAA-BBB',1,instr('333-4444-AAA-BBB','-',1,1)-1) ֵ from dual;
select instr('4444-AAA-BBB','-',1,1) ֵ from dual;

---ĩ��ҵ̬�������õ�����ҵ̬����ĩ��ҵ̬������������(¥��/��Ŀ/����)
select dtl.obj_id
,dtl.obj_name as "��������"
,product_type.id as "����ҵ̬id"
,product_type.product_type_short_name as "����ҵ̬"
,objtype.OBJ_TYPE as "ҵ̬���󸸼�����"
,dtl.obj_parent_id as "ҵ̬���󸸼�id"
,proj.id  as "��Ŀid"
,proj.PROJECT_NAME as "��Ŀ����"
from (select * from DWM_TARGET_WORTH_DTL where OBJ_TYPE=40) dtl
--����ҵ̬ �ҵ�ҵ̬����
left join MDM_BUILD_PRODUCT_TYPE PRODUCT_TYPE 
on substr(dtl.obj_name,1,instr(dtl.obj_name,'/',1,1)-1)=PRODUCT_TYPE.product_type_name
--���������ҵ�ҵ̬�ĸ������� ����
left join DWM_TARGET_WORTH_DTL objtype on dtl.obj_parent_id=objtype.obj_id
--������������������Ŀ��������
left join DWM_TARGET_WORTH w on dtl.TARGET_WORTH_ID=w.id
--������Ŀ�����Ŀid
left join sys_project proj on w.PROJ_ID=proj.id
order by objtype.OBJ_TYPE 



select * from DWM_TARGET_WORTH_DTL where obj_id='a2f3dee3-a8d1-4429-b7f0-7f1484ca0425'

select * from MDM_BUILD_PRODUCT_TYPE obj_parent_id

select orgid,count(orgid) from(
select 
   ---PARENTID��'PARENTID','ORGID','ORGNAME'
   feasiblew_dtl.obj_parent_id as PARENTID,
   case when feasiblew_dtl.OBJ_TYPE=40 then feasiblew_dtl.obj_parent_id||'|'||feasiblew_dtl.obj_id else feasiblew_dtl.obj_id end as ORGID,
   feasiblew_dtl.obj_name as ORGNAME,
   feasiblew.id as wid,
   p.id as projid,p.PROJECT_NAME,feasiblew_dtl.TOTAL_SALES_AREA as "����-���",feasiblew_dtl.AVERAGE_PRICE as "����-����",feasiblew_dtl.WORTH  as "����-���"
   from sys_project p
----- ������Ŀ�Ŀ��н׶λ�ֵ
   left join DWM_TARGET_WORTH feasiblew on p.id=feasiblew.proj_id and feasiblew.TARGET_WORTH_PHASE=0 and feasiblew.IS_DELETE=0 and feasiblew.APPROVAL_STATUS='�����'
   left join DWM_TARGET_WORTH_DTL feasiblew_dtl on feasiblew.id=feasiblew_dtl.TARGET_WORTH_id)
   left join MDM_BUILD_PRODUCT_TYPE RODUCT_TYPE on  feasiblew_dtl.obj_id=RODUCT_TYPE.id 
   group by orgid order by count(orgid) desc
   
   




    
    select * from DWM_TARGET_WORTH_DTL where obj_id='70a169db-3bd8-4115-a0f4-78525a058fc6' 
    and obj_parent_id='10b61187-0e4b-4c67-b45c-11f65aa3f51c'
    
    select * from DWM_TARGET_WORTH where id='a17d93be-35de-1df6-e053-8606160a7086'
   