----ҵ̬��id
select proj.id||'|'||PRODUCT_TYPE.id,proj.PROJECT_NAME,PRODUCT_TYPE.PRODUCT_TYPE_NAME
from  sys_project proj cross join (select * from
MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE;

----����ĩ��ҵ̬��Ӧ����ҵ̬
----¥����
select substr('333-4444-AAA-BBB',1,instr('333-4444-AAA-BBB','-',1,1)-1) ֵ from dual;
select instr('4444-AAA-BBB','-',1,1) ֵ from dual;

----��洢���ݵ�ά�Ȳ�һ�£���Ҫ�����ݰ��洢��С������ҵ̬����ҵ̬��Ӧ����Ŀ�����ڡ�¥������
WITH basedata AS(
---ĩ��ҵ̬�������õ�����ҵ̬����ĩ��ҵ̬������������(¥��/��Ŀ/����)
select 
proj.id  as "��Ŀid"
,proj.PROJECT_NAME as "��Ŀ����"
,w.TARGET_WORTH_PHASE as "�׶�����"
,proj_stage.id "����id"
,proj_stage.STAGE_NAME "��������"
,build.id as "¥��id"
,build.BUILD_NAME as "¥������"
,objtype.OBJ_TYPE as "ҵ̬���󸸼�����"
,dtl.obj_id "ĩ��ҵ̬id"
,dtl.obj_name as "ĩ��ҵ̬ȫ·��"
,product_type.id as "����ҵ̬id"
,product_type.product_type_short_name as "����ҵ̬"
,dtl.obj_parent_id as "ҵ̬���󸸼�id"
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
--����¥����ȡҵ̬�ĸ�������Ϊ¥����¥������
left join mdm_build build on dtl.obj_parent_id=build.id
--�������ڻ�ȡҵ̬�ĸ�������Ϊ���ڵķ�������
left join SYS_PROJECT_STAGE proj_stage on dtl.obj_parent_id=proj_stage.id
--ֻ��ȡ����˵�Ŀ���ֵ
where w.APPROVAL_STATUS='�����'
order by objtype.OBJ_TYPE )

select * from basedata;


---���ڼ���
select * from SYS_PROJECT_STAGE proj_stage
union all
---���ڶ�Ӧҵ̬����
select * from (select proj.id||'|'||PRODUCT_TYPE.id,proj.PROJECT_NAME,PRODUCT_TYPE.PRODUCT_TYPE_NAME
from  sys_project proj cross join (select * from
MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)
---¥������
union all
select * from mdm_build
