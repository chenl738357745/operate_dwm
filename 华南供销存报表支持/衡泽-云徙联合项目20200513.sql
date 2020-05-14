create or replace PROCEDURE P_DWM_����������Ŀ��
(
INFO OUT SYS_REFCURSOR
) AS
BEGIN

   OPEN INFO FOR 
    ----���ݴ洢���ݵ�ά�Ȳ�һ�£���Ҫ�����ݰ��洢��С������ҵ̬����ҵ̬��Ӧ����Ŀ�����ڡ�¥������
    WITH basedata AS(
    ---ĩ��ҵ̬�������õ�����ҵ̬����ĩ��ҵ̬�����������(¥��/��Ŀ/����)
    select 
    proj.id  as ��Ŀid
    ,proj.PROJECT_NAME as ��Ŀ����
    ,w.TARGET_WORTH_PHASE as �׶�����
    ,proj_stage.id ����id
    ,proj_stage.STAGE_NAME ��������
    ,build.id as ¥��id
    ,build.BUILD_NAME as ¥������
    ,objtype.OBJ_TYPE as ҵ̬���󸸼�����
    ,dtl.obj_id||GET_UUID() as ĩ��ҵ̬id
    ,dtl.obj_name as ĩ��ҵ̬ȫ·��
    ,dtl.TOTAL_SALES_AREA as �ܿ������
    ,dtl.WORTH as �ܻ�ֵ
    ,product_type.id as ����ҵ̬id
    ,product_type.product_type_short_name as ����ҵ̬
    ,dtl.obj_parent_id as ҵ̬���󸸼�id
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
    
    ,���� as(
  --ȫ��:��Ŀ-ҵ̬���� 
    select ID,NAME,PARENT_ID
    ,'' as ��,0 as ���,0 as ���,0 as ����  from (
    select id,project_name name,'����' PARENT_ID,'' as ��,0 as ���,0 as ���,0 as ����  from SYS_PROJECT
    union all
   --ҵ̬����id����Ŀid|ҵ̬����id
    select proj.id||'|'||PRODUCT_TYPE.id as id
    ,proj.PROJECT_NAME||'-'||PRODUCT_TYPE.PRODUCT_TYPE_NAME as name
    ,proj.id as PARENT_ID
    ,'' as ��,0 as ���,0 as ���,0 as ����
    from  sys_project proj cross join (select * from
    MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE
    union all 
    select ��Ŀid||'|'||����id||'|'||����ҵ̬id||'|'||ĩ��ҵ̬id as id
    ,ĩ��ҵ̬ȫ·��
    ,��Ŀid||'|'||����id||'|'||����ҵ̬id as parent_id
    ,'' as ��
    ,�ܿ������ as ���
    ,�ܻ�ֵ as ���
    ,0 as ���� from basedata 
    where �׶�����=0))
    
    ,ȫ�� as(
    --ȫ��:��Ŀ-����-ҵ̬���� 
    select ID,NAME,PARENT_ID,'' as ��,0 as ���,0 as ���,0 as ����  from (
    select id,project_name name,'ȫ��' PARENT_ID  from SYS_PROJECT
    union all
    select proj_stage.PROJECT_ID||'|'||proj_stage.id  as Id
    ,proj_stage.STAGE_FULL_NAME as NAME
    ,proj_stage.PROJECT_ID as PARENT_ID
    from SYS_PROJECT_STAGE PROJ_STAGE
    union all
    --ҵ̬����id����Ŀid|����id|ҵ̬����id
    select proj_stage.PROJECT_ID||'|'||proj_stage.id||'|'||PRODUCT_TYPE.id as  id
    ,proj_stage.STAGE_FULL_NAME||'-'||PRODUCT_TYPE.PRODUCT_TYPE_NAME as name
    ,proj_stage.PROJECT_ID||'|'||proj_stage.id as parent_id 
    from  SYS_PROJECT_STAGE proj_stage cross join (select * from
    MDM_BUILD_PRODUCT_TYPE where product_type_level=1) PRODUCT_TYPE)  
    union all 
    select ��Ŀid||'|'||����id||'|'||����ҵ̬id||'|'||ĩ��ҵ̬id as id
    ,ĩ��ҵ̬ȫ·��
    ,��Ŀid||'|'||����id||'|'||����ҵ̬id as parent_id
    ,'' as ��
    ,�ܿ������ as ���
    ,�ܻ�ֵ as ���
    ,0 as ���� from basedata 
    where �׶�����=10)
    
   select '����' as id, '����' as NAME,null PARENT_ID
    ,'' as ��,0 as ���,0 as ���,0 as ���� from dual
   union all
   select 'ȫ��' as id,'ȫ��' as NAME,null PARENT_ID
    ,'' as ��,0 as ���,0 as ���,0 as ���� from dual
   union all
   select ID,NAME,PARENT_ID,��,���,0���,���� from ����
   union all
   select ID,NAME,PARENT_ID,��,���,0���,���� from ȫ��
     ;

    
    
    
    
END P_DWM_����������Ŀ��;


   