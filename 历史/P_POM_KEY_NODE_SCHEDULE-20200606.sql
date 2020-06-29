set define off;
create or replace PROCEDURE  P_POM_KEY_NODE_SCHEDULE
(
    companyGUID IN VARCHAR2,
    USERID VARCHAR2,
    STATIONID VARCHAR2,
    DEPTID VARCHAR2,
    COMPANYID VARCHAR2,
    items OUT SYS_REFCURSOR
)IS
    v_sql clob;
    v_id varchar2(100);
    --��ǰ����
    nowdate date:=trunc(sysdate);
    BIZCODE VARCHAR2(200):='POM.JHJKYKHPH.01';
    DATA_AUTH_SPID VARCHAR2(200);
BEGIN
    IF companyGUID IS NULL THEN
        v_id := '003200000000000000000000000000';
    ELSE
        v_id := companyGUID;
    END IF;

    DECLARE


BEGIN
  P_SYS_GET_COMPANY_PROJ_SPID(
    USERID => USERID,
    STATIONID => STATIONID,
    DEPTID => DEPTID,
    COMPANYID => COMPANYID,
    BIZCODE => BIZCODE,
    DATA_AUTH_SPID => DATA_AUTH_SPID
  );
END;

    -- ���ͼ��ַ
    --/pom/plan-assess/node-monitoring/plan-nodes?companyid=''|| sp.unit_id ||''&ppid=''|| sp.id ||''&planType=�ؼ��ڵ�ƻ�''
    open items for
    WITH
     ���� as(
     select  case when �ܷ�������=0 then get_uuid else ps.id end as id,ps.STAGE_NAME,ps.PROJECT_ID,proj.PROJECT_NAME,UNIT_ID,to_char(ps.sn,'0.0') as sn
     ,case when �޷�������=1 and �ܷ�������=1 then 1 else 0 end ���޷���
     from SYS_PROJECT_STAGE ps
     left join SYS_PROJECT proj on ps.PROJECT_ID=proj.id
     left join (select PROJECT_ID,sum(case when STAGE_NAME='�޷���' then 1 else 0 end) as �޷�������,count(PROJECT_ID) as �ܷ������� from SYS_PROJECT_STAGE group by PROJECT_ID)  pcount
     on proj.id=pcount.PROJECT_ID
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
     WHEN  (node.ACTUAL_END_DATE IS NULL  and   (trunc(SYSDATE)-trunc(node.PLAN_END_DATE)) >5)
     or ( (trunc(node.ACTUAL_END_DATE)-trunc(node.PLAN_END_DATE)) >5)
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
   ,sum(case when nodee.NEW_EXAMINATION_SCORE is null  then 0 else nodee.NEW_EXAMINATION_SCORE end) as ʵ�ʵ÷�


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
   select ����.id
   ,case when ����.���޷���=1 then ����.PROJECT_NAME else ����.PROJECT_NAME||'-'||����.STAGE_NAME end as name
    --ͳ�Ƶĸ����ֶδ����޷�����Ŀ�����ǹ�˾���з�����Ŀ��������Ŀ
   ,case when ����.���޷���=1 then ����.UNIT_ID else PROJECT_ID end parent_id
   ,��Ч�ڵ���,Ӧ���ܷ�
   ,�̵�,�Ƶ�,���
   ,��̱�Ӧ���,��̱������,��̱�δ���
   ,һ��Ӧ���,һ�������,һ��δ���,ʵ�ʵ÷�
   ,'/pom/plan-assess/node-monitoring/plan-nodes?companyid='|| ����.UNIT_ID ||'&ppid='|| case when ����.���޷���=1 then PROJECT_ID else ����.id end ||'&planType=�ؼ��ڵ�ƻ�' as url
   ,����.UNIT_ID
   ,����.sn
   ,case when 
(case when (��̱�Ӧ���+һ��Ӧ���)=0 then 0 else  round((��̱������+һ�������)/(��̱�Ӧ���+һ��Ӧ���),4)*100 end)<90 then 1
else 0 end as "isWarning"
   from basedata
   left join ���� on basedata.PROJ_ID=����.id
   union all
   select proj.id
   ,proj.project_name as name
   ,proj.UNIT_ID  as parent_id
   ,0 ��Ч�ڵ���,0 Ӧ���ܷ�
   ,0 �̵�,0 �Ƶ�,0 ���
   ,0 ��̱�Ӧ���,0 ��̱������,0 ��̱�δ���
   ,0 һ��Ӧ���,0 һ�������,0 һ��δ���,0 ʵ�ʵ÷�
   ,'' as url
   ,proj.UNIT_ID
   ,proj.sn,0 "isWarning"
   from sys_project proj
   left join (select * from ���� where ���޷���=1) s on proj.id=s.project_id
   where s.id is null
   )

   ,ƴ����Ŀ��˾�� as(
 select * from (
   SELECT DISTINCT
   org_id       AS id,
   org_name     AS name,
   parent_id    AS parent_id,
   0 ��Ч�ڵ���,0 Ӧ���ܷ�
   ,0 �̵�,0 �Ƶ�,0 ���
   ,0 ��̱�Ӧ���,0 ��̱������,0 ��̱�δ���
   ,0 һ��Ӧ���,0 һ�������,0 һ��δ���,0 ʵ�ʵ÷�
   ,'' url
   ,order_code as sn,0 "isWarning"
                           FROM
                               tmp_company_tree
                           WHERE
                               id = DATA_AUTH_SPID
                               AND org_id IN (
                                   SELECT DISTINCT
                                       id
                                   FROM
                                       sys_business_unit
                                   START WITH
                                       id IN (
                                           SELECT
                                               id
                                           FROM
                                               (
                                                   SELECT
                                                       unit_id AS id
                                                   FROM
                                                       sys_project
                                                   UNION
                                                   SELECT
                                                       subordinate_company_id AS id
                                                   FROM
                                                       cdb_feasible_project_config
                                               ) ds
                                       )
                                   CONNECT BY
                                       PRIOR parent_id = id
                               )
--                               )   start with id=v_id connect by prior id=parent_id

   union all
    select id
   ,name
   ,parent_id
   ,��Ч�ڵ���,Ӧ���ܷ�
   ,�̵�,�Ƶ�,���
   ,��̱�Ӧ���,��̱������,��̱�δ���
   ,һ��Ӧ���,һ�������,һ��δ���,ʵ�ʵ÷�,url,sn,"isWarning"  FROM ��Ŀ_����)
   start with id=v_id connect by prior id=parent_id)

--
   ,���� as(select
   id
   ,name
   ,parent_id
   ,url
   ,sn
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
,(select sum(ʵ�ʵ÷�) from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) ʵ�ʵ÷�
,(select sum("isWarning") from ƴ����Ŀ��˾�� start with id=s.id connect by prior id=parent_id ) 
as "isWarning" 
 from ƴ����Ŀ��˾�� s)
--
  ,���� as(select '' from dual)

   select  id as "id",sn
   ,case when url is not null then  '<span style="color:#409eff">'||name||'</span>' else   name end as "company"
   ,url as "jumpUrl"
   ,parent_id as "parentId"
   ,case when (��̱�Ӧ���+һ��Ӧ���)=0 then 0 else  round((��̱������+һ�������)/(��̱�Ӧ���+һ��Ӧ���),4)*100 end||'%'  as "completionRate"
   ,��Ч�ڵ��� as "validTasks"
   ,��̱�Ӧ���+һ��Ӧ��� as "completeNum"
   ,��̱������+һ������� as "completed"
   ,��̱�δ���+һ��δ��� as "unfinished"

   ,Ӧ���ܷ� as "needResult"
   ,case when (Ӧ���ܷ�)=0 then 0 else  round((ʵ�ʵ÷�)/(Ӧ���ܷ�),4)*100 end "dynamicResult"
   ,ʵ�ʵ÷� "realResult"
   ,�̵� as "greenLight",�Ƶ� as "yellowLight",��� as  "redLight"
   ,��̱�Ӧ��� as "miCompleteNum",��̱������ as "miCompleted",��̱�δ��� as "miUnfinished"
   ,һ��Ӧ��� as "olCompleteNum",һ������� as "olCompleted",һ��δ��� as "olUnfinished"
   ,'<span style="font-size:14px">Ԥ��˵������˾������Ŀ����ʵ���90%����ʾԤ��ͼ��</span>' as "remark"
   ,case when ("isWarning">=1 and id<>'003200000000000000000000000000') then 1 else "isWarning" end as "isWarning"
   --,"isWarning"
   from ���� where 1=1 and ��Ч�ڵ���>0

   order by LPAD(sn,10,'0')
   ;

END P_POM_KEY_NODE_SCHEDULE;

