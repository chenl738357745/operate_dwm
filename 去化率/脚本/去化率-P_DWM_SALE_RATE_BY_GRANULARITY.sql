create or replace PROCEDURE "P_DWM_SALE_RATE_BY_GRANULARITY" (
    is_photograph_p in number:=0,
    proj_info   OUT  SYS_REFCURSOR,
    spid_tree_info   OUT  SYS_REFCURSOR,
    SPID_AREA_STAGE_INFO   OUT  SYS_REFCURSOR,
    spid_sum_info   OUT  SYS_REFCURSOR,
    p_room  out  SYS_REFCURSOR
) AS
		--ȥ��������
		--���ߣ�����
		--���ڣ�2020-04-10
  PROJ_BASE_INFO SYS_REFCURSOR;
  PROJ_DATE_INFO SYS_REFCURSOR;
  PROJ_BASE_SPID VARCHAR2(2000);
  IS_PHOTOGRAPH  number;
  sys_created date:=sysdate;
  spid VARCHAR2(360); --ʹ����ʱ������κ�
  dwm_REMARK VARCHAR2(200):='����-chenl';
  spid_tree              VARCHAR2(360); --ʹ����ʱ������κ�
  spid_area_stage              VARCHAR2(360); --ʹ����ʱ������κ�
  spid_sum     VARCHAR2(360); --ʹ����ʱ������κ�
  spid_result              VARCHAR2(360); --ʹ����ʱ������κ�
  
  ----------------------
  v_sql clob;
  v_sql_start VARCHAR2(2000):= ' case ';
  v_sql_content clob:= '';
  v_sql_end VARCHAR2(2000):= '  else ''�������������'' end  ';
BEGIN

---------------------------
--------------------------------------------------------������ʱ�����κ�
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
    SELECT
        get_uuid(),get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_area_stage,spid_sum,spid_result
    FROM
        dual;  
---------------------------------------------����ҵ̬�����1.ƴ�Ӳ�ѯ���
 FOR item IN (
   select 
    ' when '||l.lower_limit_value||l.upper_limit_type||'room.NEW_BLD_AREA and room.NEW_BLD_AREA '||l.lower_limit_type||l.upper_limit_value
    ||' and (case when room.PRODUCT_NAME<>''סլ'' then ''���̼�����'' else ''סլ'' end)='''||p.attribute_name||''' then ''' ||l.attribute_name||''' ' as aa,
    l.upper_limit_type,
    l.lower_limit_type,
    l.upper_limit_value,
    p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null
        ) LOOP 
    ---ƴ���ַ���
         v_sql_content := v_sql_content||item.aa;
        END LOOP;
    --�������ݴ���0��ƴ�������
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                     || v_sql_content
                     || v_sql_end;
        ELSE
            v_sql := '''''';
        END IF;
        
       v_sql:= 'INSERT INTO TMP_ROOM(id,room_ID,ROOM_NAME,PRODUCT_NAME,AREA_LEVEL) select '''||spid||''',id,room_name,room.product_name,'
       ||v_sql|| ' as NODE_WARNING from mdm_room room';
         dbms_output.put_line(v_sql);
       execute immediate v_sql;
        
OPEN p_room FOR select * from TMP_ROOM;
------------------------------------------------------------��Ŀ������Ϣ
BEGIN
  IS_PHOTOGRAPH := is_photograph_p;

  P_DWM_SALE_RATE_PROJ(
    IS_PHOTOGRAPH => 0,
    PROJ_BASE_INFO => PROJ_BASE_INFO,
    PROJ_DATE_INFO => PROJ_DATE_INFO,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;   
------------------------------------------------------------ҵ̬�������ƴ�� spid_tree
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
,GRANULARITY_ID--������id
,PROJECT_ID---��2����ĿID
,PROJECT_NAME--��Ŀ����
,PARENT_ID---����id
,DATA_GRANULARITY--����������
)
-----ҵ̬
select spid_tree
,proj.PROJECT_ID||b."ҵ̬" as GRANULARITY_ID
,proj.PROJECT_NAME
,proj.PROJECT_ID as projectId
,null as parentId 
,b."ҵ̬" as text   
 from (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
(select 
   l.attribute_name as "ҵ̬"  from mdm_attribute_area_level l where parent_id is null) b
   union all
-----�����
select spid_tree
,proj.PROJECT_ID||ptype||a.areaStage as GRANULARITY_ID
,proj.PROJECT_NAME
,proj.PROJECT_ID as projectId
,proj.PROJECT_ID||ptype as parentId 
,a.areaStage as text
from  (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
( select 
    l.attribute_name as areaStage,p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null) a;
    
 OPEN spid_tree_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_tree ;
------------------------------------------------------------���������ָ�� spid_area_stage
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
,GRANULARITY_ID--������id
,PROJECT_NAME
,PROJECT_ID---��2����ĿID
,DATA_GRANULARITY 
,PARENT_ID  

,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ

,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ

,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ

,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ

)
select spid_area_stage as id
,tree.GRANULARITY_ID--������id
,tree.PROJECT_ID---��2����ĿID
,tree.PROJECT_NAME--��Ŀ����
,tree.DATA_GRANULARITY--����������
,tree.PARENT_ID---����id

,area_stage.�׿�ȥ������
,area_stage.�׿���������
,area_stage.�׿�ȥ�����
,area_stage.�׿��������
,area_stage.�׿�ȥ����ֵ
,area_stage.�׿����ۻ�ֵ

,area_stage.ȫ��ȥ������
,area_stage.ȫ����֤����
,area_stage.ȫ��ȥ�����
,area_stage.ȫ����֤���
,area_stage.ȫ��ȥ����ֵ
,area_stage.ȫ����֤��ֵ

,area_stage.�ַ�ȥ������
,area_stage.�ַ���������
,area_stage.�ַ�ȥ�����
,area_stage.�ַ��������
,area_stage.�ַ�ȥ����ֵ
,area_stage.�ַ����ۻ�ֵ

,area_stage.���ȥ������
,area_stage.�����������
,area_stage.���ȥ�����
,area_stage.����������
,area_stage.���ȥ����ֵ
,area_stage.������ۻ�ֵ
  from 
(select * from TMP_SALE_RATE_BY_GRANULARITY where id =spid_tree) tree
left join 
(select 
proj.project_id||t_room.PRODUCT_NAME||t_room.AREA_LEVEL as GRANULARITY_ID--������id
,proj.project_id
,proj.project_name
,proj.project_id||t_room.PRODUCT_NAME as PARENT_ID
,t_room.AREA_LEVEL
------�״ο���30���ڵ�ǩԼ�������׿�ȥ��������:
---------->���䡰���ܡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end )
as "�׿�ȥ������"
------�״ο��̵���ȡ֤�������׿�����������:
---------->���䡰���ܡ�
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then 1 else 0 end )
as "�׿���������"
------�״ο���30���ڵ�ǩԼ������׿�ȥ�������:
---------->���䡰���½��������
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end )
as "�׿�ȥ�����"
------�״ο��̵���ȡ֤������׿����������:
---------->���䡰���½��������
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end ) 
as "�׿��������"
------�״ο���30���ڵ�ǩԼ���׿�ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end )
as "�׿�ȥ����ֵ"
------�״ο�����ȡ֤��ֵ���׿����ۻ�ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.SALE_STATE='ǩԼ' and room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )
as "�׿����ۻ�ֵ"

------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ�� 
------ȫ������ȥ������):
---------->���䡰���ܡ�
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' then 1 else 0 end )
as "ȫ��ȥ������"
------ȫ��������֤����):
---------->���䡰���ܡ�
,sum(case when room.PRE_SELL_PERMIT_DATE is not null then 1 else 0 end )
as "ȫ����֤����"
------ȫ������ȥ�������:
---------->���䡰���½��������
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ'  then room.NEW_BLD_AREA else 0 end )
as "ȫ��ȥ�����"
------ȫ��������֤�����:
---------->���䡰���½��������
,sum(case when room.PRE_SELL_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end ) 
as "ȫ����֤���"
------ȫ������ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->���䡰����״̬��=ǩԼ
,sum(case when room.SALE_STATE='ǩԼ' then room.TRADE_TOTAL else 0 end )
as "ȫ��ȥ����ֵ"
------ȫ��������֤��ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
,sum(case when room.SALE_STATE='ǩԼ'  then room.TRADE_TOTAL  
when room.PRE_SELL_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )
as "ȫ����֤��ֵ"
------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�
----�ַ�ȥ������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end)
as  �ַ�ȥ������
----�ַ���������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or  (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) 
as �ַ���������
----�ַ�ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end)
as "�ַ�ȥ�����" 
----�ַ��������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end)
as �ַ��������
----�ַ�ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end)
as  �ַ�ȥ����ֵ
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----�ַ����۽��
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> 'ǩԼ'   then room.BZ_TOTAL  when room.SALE_STATE = 'ǩԼ' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end)
as �ַ����ۻ�ֵ
------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��
----���ȥ������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end)
as  ���ȥ������
----�����������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then 1 else 0 end) 
as �����������
----����������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) 
as ���ȥ�����
----���ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then room.NEW_BLD_AREA else 0 end)
as ����������
----���ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) 
as  ���ȥ����ֵ
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----������۽��
,sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') then room.TRADE_TOTAL  --�Ѿ��ڽ���ǩԼ����ǩԼ���
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> 'ǩԼ' then room.BZ_TOTAL  else 0 end) 
 as ������ۻ�ֵ  --δǩԼ����У׼�ܼ�

from  MDM_ROOM room
left join  tmp_proj_base proj on room.project_id=proj.project_id and  proj.id = PROJ_BASE_SPID
left join TMP_ROOM t_room on  room.id=t_room.room_id
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
-------------------- ҵ̬��������� start
    ,t_room.AREA_LEVEL
    ,t_room.PRODUCT_NAME
----------------------ҵ̬��������� end
    ,proj.project_name,
    proj.first_open_date,
    proj.obtain_date,
    proj.COMPLETION_RECORD_DATE,
    proj.take_land_date,
    proj.plan_first_open_date,
    proj.first_open_duration_by_tl,
    proj.first_open_duration_by_plan,
    proj.new_plan_first_open_date,
    proj.exhibition_area_open_date,
    proj.plan_approval_date,
    proj.is_operate,
    proj.is_construction_began) area_stage 
    on tree.GRANULARITY_ID=area_stage.PARENT_ID  
;
OPEN spid_area_stage_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_area_stage ;
------------------------------------------------------------���������ָ��spid_sum
--INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
--,GRANULARITY_ID--������id
--,PROJECT_ID---��2����ĿID
--,PROJECT_NAME
--,PARENT_ID  
--,DATA_GRANULARITY 
--
--,FO_SALE_OUT_COUNT---��3���׿�ȥ������
--,FO_SALE_COUNT---��4���׿���������
--,FO_SALE_OUT_AREA---��6���׿�ȥ�����
--,FO_SALE_AREA---��7���׿��������
--,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
--,FO_SALE_MONEY---��10���׿����ۻ�ֵ
--
--,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
--,PO_SALE_COUNT---��16��ȫ����������
--,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
--,PO_SALE_AREA---��19��ȫ���������
--,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
--,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
--
--,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
--,EH_SALE_COUNT---��28���ַ���������
--,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
--,EH_SALE_AREA---��31���ַ��������
--,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
--,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
--
--,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
--,SI_SALE_COUNT---��40������Կ����������
--,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
--,SI_SALE_AREA---��43������Կ���������
--,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
--,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
--)
-- select spid_sum,GRANULARITY_ID--������id
--,PROJECT_ID---��2����ĿID
--,PROJECT_NAME--��Ŀ����
--,PARENT_ID---����id
--,DATA_GRANULARITY--����������
--,(select sum(FO_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��3���׿�ȥ������
--,(select sum(FO_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��4���׿���������
--,(select sum(FO_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��6���׿�ȥ�����
--,(select sum(FO_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��7���׿��������
--,(select sum(FO_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��9���׿�ȥ����ֵ
--,(select sum(FO_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��10���׿����ۻ�ֵ
--
--,(select sum(PO_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��15��ȫ��ȥ������
--,(select sum(PO_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��16��ȫ����������
--,(select sum(PO_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��18��ȫ��ȥ�����
--,(select sum(PO_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��19��ȫ���������
--,(select sum(PO_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��21��ȫ��ȥ����ֵ
--,(select sum(PO_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��22��ȫ�����ۻ�ֵ
--
--,(select sum(EH_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��27���ַ�ȥ������
--,(select sum(EH_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��28���ַ���������
--,(select sum(EH_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��30���ַ�ȥ�����
--,(select sum(EH_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��31���ַ��������
--,(select sum(EH_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��33���ַ�ȥ����ֵ
--,(select sum(EH_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��34���ַ����ۻ�ֵ
--
--,(select sum(SI_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��39������Կ��ȥ������
--,(select sum(SI_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��40������Կ����������
--,(select sum(SI_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��42������Կ��ȥ�����
--,(select sum(SI_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��43������Կ���������
--,(select sum(SI_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��45������Կ��ȥ����ֵ
--,(select sum(SI_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---��46������Կ�����ۻ�ֵ
--
--from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_area_stage order by GRANULARITY_ID  ; 
OPEN spid_sum_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_sum ;
------------------------------------------------------------���������ָ��spid_result
--INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
--,GRANULARITY_ID--������id
--,PROJECT_ID---��2����ĿID
--,PROJECT_NAME--��Ŀ����
--,PARENT_ID---����id
--,DATA_GRANULARITY--����������
--
--,FO_SALE_OUT_COUNT---��3���׿�ȥ������
--,FO_SALE_COUNT---��4���׿���������
--,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
--,FO_SALE_OUT_AREA---��6���׿�ȥ�����
--,FO_SALE_AREA---��7���׿��������
--,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
--,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
--,FO_SALE_MONEY---��10���׿����ۻ�ֵ
--,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
--,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
--,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
--,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
--,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
--,PO_SALE_COUNT---��16��ȫ����������
--,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
--,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
--,PO_SALE_AREA---��19��ȫ���������
--,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
--,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
--,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
--,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
--,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
--,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
--,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
--,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
--,EH_SALE_COUNT---��28���ַ���������
--,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
--,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
--,EH_SALE_AREA---��31���ַ��������
--,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
--,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
--,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
--,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
--,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
--,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
--,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
--,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
--,SI_SALE_COUNT---��40������Կ����������
--,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
--,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
--,SI_SALE_AREA---��43������Կ���������
--,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
--,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
--,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
--,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
--,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
--,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
--,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
--)
OPEN proj_info FOR
select  rownum,spid_result as id
,GRANULARITY_ID--������id
,PROJECT_ID---��2����ĿID
,PROJECT_NAME--��Ŀ����
,PARENT_ID---����id
,DATA_GRANULARITY--����������

FO_SALE_OUT_COUNT,--��3���׿�ȥ������
FO_SALE_COUNT,--��4���׿��������� 
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end,--��5���׿�ȥ����(������)��3/4��
FO_SALE_OUT_AREA,--��6���׿�ȥ�����
FO_SALE_AREA,--��7���׿��������
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end,--��8���׿�ȥ����(�����)��6/7��
FO_SALE_OUT_MONEY,--��9���׿�ȥ����ֵ
FO_SALE_MONEY,--��10���׿����ۻ�ֵ
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end,--��11���׿�ȥ����(����ֵ)��9/10��
FO_SURPLUS_SALE_MONEY,--��12���׿�ʣ���ֵ(10-9)
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_MONEY/FO_SALE_AREA,4) end,--��13���׿���׼����(10/7)
case when FO_SALE_OUT_AREA=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_OUT_AREA,4) end,--��14���׿�ǩԼ����(9/6)
PO_SALE_OUT_COUNT,--��15��ȫ��ȥ������
PO_SALE_COUNT,--��16��ȫ����������
case when PO_SALE_COUNT=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end,--��17��ȫ��ȥ����(������)(15/16)
PO_SALE_OUT_AREA,--��18��ȫ��ȥ�����
PO_SALE_AREA,--��19��ȫ���������
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end,--��20��ȫ��ȥ����(�����)(18/19)
PO_SALE_OUT_MONEY,--��21��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��22��ȫ�����ۻ�ֵ
case when PO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end,--��23��ȫ��ȥ����(����ֵ)(21/22)
PO_SURPLUS_SALE_MONEY,--��24��ȫ��ʣ���ֵ(22-21)
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_MONEY/PO_SALE_AREA,4) end,--��25��ȫ����׼����(22/19)
case when PO_SALE_OUT_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_OUT_AREA,4) end,--��26��ȫ��ǩԼ����(21/18)
EH_SALE_OUT_COUNT,--��27���ַ�ȥ������
EH_SALE_COUNT,--��28���ַ���������
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end,--��29���ַ�ȥ����(������)(27/28)
EH_SALE_OUT_AREA,--��30���ַ�ȥ�����
EH_SALE_AREA,--��31���ַ��������
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end,--��32���ַ�ȥ����(�����)(30/31)
EH_SALE_OUT_MONEY,--��33���ַ�ȥ����ֵ
EH_SALE_MONEY,--��34���ַ����ۻ�ֵ
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end,--��35���ַ�ȥ����(����ֵ)(33/34)
EH_SURPLUS_SALE_MONEY,--��36���ַ�ʣ���ֵ(34-33)
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_MONEY/EH_SALE_AREA,4) end,--��37���ַ���׼����(34/31)
case when EH_SALE_OUT_AREA=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_OUT_AREA,4) end,--��38���ַ�ǩԼ����(33/30)
SI_SALE_OUT_COUNT,--��39������Կ��ȥ������
SI_SALE_COUNT,--��40������Կ����������
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end,--��41������Կ��ȥ����(������)(39/40)
SI_SALE_OUT_AREA,--��42������Կ��ȥ�����
SI_SALE_AREA,--��43������Կ���������
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end,--��44������Կ��ȥ����(�����)(42/43)
SI_SALE_OUT_MONEY,--��45������Կ��ȥ����ֵ
SI_SALE_MONEY,--��46������Կ�����ۻ�ֵ
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end,--��47������Կ��ȥ����(����ֵ)(45/46)
SI_SURPLUS_SALE_MONEY,--��48������Կ��ʣ���ֵ(46-45)
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_MONEY/SI_SALE_AREA,4) end,--��49������Կ���׼����(46/43)
case when SI_SALE_OUT_AREA=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_OUT_AREA,4) end--��50������Կ��ǩԼ����(45/42)
from  TMP_SALE_RATE_BY_GRANULARITY 
where id=spid_sum ;



END P_DWM_SALE_RATE_BY_GRANULARITY;