SET DEFINE OFF;

create or replace PROCEDURE  P_chenl_һ����
(
    companyGUID IN VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id clob;
    --��ǰ����
    nowdate date:=trunc(sysdate);
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '0001';
    ELSE
        v_id := companyGUID;
    END IF;
    -- ���ͼ��ַ
    --/pom/plan-assess/node-monitoring/plan-nodes?companyid=''|| sp.unit_id ||''&ppid=''|| sp.id ||''&planType=�ؼ��ڵ�ƻ�''
    open items for   
    WITH
     ���� as(
     select ps.id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,sum(case when STAGE_NAME='�޷���' then 1 else 0 end) �޷��ڸ��� 
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     group by ps.id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,proj.UNIT_ID
     )
    ,basedata AS(
    ---��ѯ����˵ķ��� �ؼ��ڵ�ƻ� ������Ϣ
   select 
   plan.PROJ_ID
   -- ����δɾ����δ���õĽڵ�
   ,count(node.id) as ��Ч�ڵ���
   ---
   ,sum(case when  node.PLAN_END_DATE<=nowdate then node.STANDARD_SCORE else 0 end) as Ӧ���ܷ�
  
--    case 
-- --δ���ڲ�����
-- WHEN    ACTUAL_END_DATE IS NULL AND  TRUNC( SYSDATE )-trunc(PLAN_END_DATE)<=0  THEN ''
-- --���ڵ�������ɷ���
-- when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE)) <= 0
-- then '<p style=" font-size: 40px;color: green;margin-bottom: 0px;">��</p>'
--  --����1-5������ɷ���
-- when  ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( ACTUAL_END_DATE)-trunc(PLAN_END_DATE))   BETWEEN 1 and 5
-- then '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>'
-- --����δ�����Ƶ� 
-- WHEN  ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(PLAN_END_DATE))  BETWEEN 1 and 5
-- THEN  '<p style=" font-size: 40px;color: yellow;margin-bottom: 0px;">��</p>' 
--  --���ڳ���5��δ������� 
-- WHEN  ACTUAL_END_DATE IS NULL  and   ((trunc(SYSDATE)-trunc(PLAN_END_DATE)) >5) 
-- THEN  '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>' 
-- ELSE '<p style=" font-size: 40px;color: red;margin-bottom: 0px;">��</p>' END
 
   --�̵ƣ����ڵ�������ɷ�������ƣ��ٵ��ڳ���5��δ�����ڳ��ڷ���
   
   ,sum( case 
     --δ���ڲ�����
     WHEN  node.ACTUAL_END_DATE IS NULL AND  TRUNC(SYSDATE)-trunc(node.PLAN_END_DATE)<=0  THEN 0
     --���ڵ�������ɷ���
     when  node.ACTUAL_END_DATE IS  not  NULL   and  (TRUNC( node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE)) <= 0
     then 1
     ELSE  0 END
     ) as �̵�
     --1-5���ڷ��� �Ƶƣ��ٵ���1-5������ɷ������ڵ���15����δ������
   ,sum(    case 
     --δ���ڲ�����
     WHEN  node.ACTUAL_END_DATE IS  not  NULL   and  (TRUNC(node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE))   BETWEEN 1 and 5
     then 1
     --����δ�����Ƶ� 
     WHEN  node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE))  BETWEEN 1 and 5
     THEN  1 
     ELSE  0 END
     ) as �Ƶ�
   -- �������췴������������δ����
   ,sum(    case 
     --δ���ڲ�����
     WHEN  node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE)) >5 
     THEN  1
     ELSE  0 END
     ) as ���
   
   -- ��̱��ڵ㡢�ƻ����ʱ��<=���������� �� 2020-05-25
   ,sum(case when node.NODE_LEVEL='��̱�' and node.PLAN_END_DATE<=nowdate then 1 else 0 end) as ��̱�Ӧ���
   -- ��̱��ڵ㡢ʵ�����ʱ�䲻Ϊ��
   ,sum(case when node.NODE_LEVEL='��̱�' and node.ACTUAL_END_DATE is not null then 1 else 0 end) as ��̱������
   -- ��̱��ڵ� and �ƻ����ʱ��<=���������� and ʵ�����ʱ��Ϊ��
   ,sum(case when node.NODE_LEVEL='��̱�' and node.PLAN_END_DATE<=nowdate and node.ACTUAL_END_DATE is null then 1 else 0 end) as ��̱�δ���

   ,sum(case when node.NODE_LEVEL='һ���ڵ�' and node.PLAN_END_DATE<=nowdate then 1 else 0 end) as һ��Ӧ���
   ,sum(case when node.NODE_LEVEL='һ���ڵ�' and node.ACTUAL_END_DATE is not null then 1 else 0 end) as һ�������
   ,sum(case when node.NODE_LEVEL='һ���ڵ�' and node.PLAN_END_DATE<=nowdate and node.ACTUAL_END_DATE is null then 1 else 0 end) as һ��δ���


   from  POM_PROJ_PLAN_NODE node
   left join POM_PROJ_PLAN plan on node.PROJ_PLAN_ID=plan.id
   --- δ����һ���ڵ��ظ��������
   left join POM_NODE_EXAMINATION nodee on node.ORIGINAL_NODE_ID=nodee.ORIGINAL_NODE_ID

   ---����ˡ��ؼ��ڵ�ƻ���δ���ýڵ�
   where plan.APPROVAL_STATUS='�����' 
   and plan.PLAN_TYPE='�ؼ��ڵ�ƻ�'
   and node.id is not null
   and node.IS_DISABLE=0
   and node.IS_DELETE=0
   group by plan.PROJ_ID )
   
   
   ,��Ŀ_���� as(
   select basedata.PROJ_ID
   ,case when ����.�޷��ڸ���=1 then ����.PROJECT_NAME else ����.STAGE_NAME end as name 
    --ͳ�Ƶĸ����ֶδ����޷�����Ŀ�����ǹ�˾���з�����Ŀ��������Ŀ
   ,case when ����.�޷��ڸ���=1 then ����.UNIT_ID else PROJECT_ID end parent_id
   ,��Ч�ڵ���,Ӧ���ܷ�
   ,�̵�,�Ƶ�,���
   ,��̱�Ӧ���,��̱������,��̱�δ���
   ,һ��Ӧ���,һ�������,һ��δ���
   ,'/pom/plan-assess/node-monitoring/plan-nodes?companyid='|| ����.UNIT_ID ||'&ppid='|| case when ����.�޷��ڸ���=1 then PROJECT_ID else ����.id end ||'&planType=�ؼ��ڵ�ƻ�' as url
   from basedata
   left join ���� on basedata.PROJ_ID=����.id
   union all 
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,0 ��Ч�ڵ���,0 Ӧ���ܷ�
   ,0 �̵�,0 �Ƶ�,0 ���
   ,0 ��̱�Ӧ���,0 ��̱������,0 ��̱�δ���
   ,0 һ��Ӧ���,0 һ�������,0 һ��δ���
   ,'' as url
   from sys_project proj
   left join (select * from ���� where �޷��ڸ���=1) s on proj.id=s.project_id
   where s.id is null
   )

   ,ƴ����Ŀ��˾�� as(
   select * from (
   select 
   id
   ,ORG_NAME as name
   ,parent_id
   ,0 ��Ч�ڵ���,0 Ӧ���ܷ�
   ,0 �̵�,0 �Ƶ�,0 ���
   ,0 ��̱�Ӧ���,0 ��̱������,0 ��̱�δ���
   ,0 һ��Ӧ���,0 һ�������,0 һ��δ���
   ,'' url
   FROM
   sys_business_unit where IS_COMPANY=1
   START WITH id IN (
                            SELECT DISTINCT ��Ŀ_����.PROJ_ID FROM ��Ŀ_����) 
                            CONNECT BY parent_id=id 
   union all
    select PROJ_ID as id
   ,name
   ,parent_id
   ,��Ч�ڵ���,Ӧ���ܷ�
   ,�̵�,�Ƶ�,���
   ,��̱�Ӧ���,��̱������,��̱�δ���
   ,һ��Ӧ���,һ�������,һ��δ���,url FROM ��Ŀ_����)start with id=companyGUID connect by prior id=parent_id
    )
--    
   ,���� as(select 
   id
   ,name
   ,parent_id
   ,url
  -- ,��Ч�ڵ���,Ӧ���ܷ�
,(select sum(��Ч�ڵ���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ��Ч�ڵ���
,(select sum(Ӧ���ܷ�) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) Ӧ���ܷ�
--,�̵�,�Ƶ�,���
,(select sum(�̵�) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) �̵�
,(select sum(�Ƶ�) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) �Ƶ�
,(select sum(���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ���

--,��̱�Ӧ���,��̱������,��̱�δ���
,(select sum(��̱�Ӧ���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ��̱�Ӧ���
,(select sum(��̱������) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ��̱������
,(select sum(��̱�δ���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ��̱�δ���

--,һ��Ӧ���,һ�������,һ��δ���
,(select sum(һ��Ӧ���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) һ��Ӧ���
,(select sum(һ�������) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) һ�������
,(select sum(һ��δ���) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) һ��δ���
 from ƴ����Ŀ��˾�� s)
--    
  ,���� as(select '' from dual)

   select  id
   ,name as name
   ,url
   ,parent_id
   ,case when (��̱�Ӧ���+һ��Ӧ���)=0 then 0 else  round((��̱������+һ�������)/(��̱�Ӧ���+һ��Ӧ���),4)*100 end �����
   ,��Ч�ڵ���
   ,��̱�Ӧ���+һ��Ӧ��� as Ӧ���
   ,��̱������+һ������� as �����
   ,��̱�δ���+һ��δ��� as δ���
 
   ,Ӧ���ܷ�,0 ʵ�ʵ÷�,0 ��̬�÷�
   ,�̵�,�Ƶ�,���
   ,��̱�Ӧ���,��̱������,��̱�δ���
   ,һ��Ӧ���,һ�������,һ��δ���
  
   from ����  ;

END P_chenl_һ����;