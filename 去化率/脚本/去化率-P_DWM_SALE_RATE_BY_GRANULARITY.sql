create or replace PROCEDURE "P_DWM_SALE_RATE_BY_GRANULARITY" (
    spid_info   OUT  SYS_REFCURSOR,
    t_room_info   OUT  SYS_REFCURSOR ,
    spid_tree_info   OUT  SYS_REFCURSOR
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
  spid_tree VARCHAR2(360); --ʹ����ʱ������κ�
  dwm_REMARK VARCHAR2(200):='����-chenl';
  
  ----------------------
  v_sql clob;
  v_sql_start VARCHAR2(2000):= ' case ';
  v_sql_content clob:= '';
  v_sql_end VARCHAR2(2000):= '  else ''�������������'' end  ';
BEGIN

---------------------------
--------------------------------------------------------������ʱ�����κ�
    SELECT
        get_uuid(),get_uuid()
    INTO spid,spid_tree
    FROM
        dual;  
---------------------------------------------����ҵ̬�����1.ƴ�Ӳ�ѯ���
 FOR item IN (
   select 
    ' when '||l.lower_limit_value||l.lower_limit_type||'room.NEW_BLD_AREA and room.NEW_BLD_AREA '||l.upper_limit_type||l.upper_limit_value
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
    --dbms_output.put_line('123333');
    --dbms_output.put_line(v_sql_content);
    --�������ݴ���0��ƴ�������
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                     || v_sql_content
                     || v_sql_end;
        ELSE
            v_sql := '''''';
        END IF;
        
       v_sql:= 'INSERT INTO TMP_ROOM(id,room_ID,BLD_AREA,ROOM_NAME,PRODUCT_NAME,AREA_LEVEL) select '''||spid||''',id,NEW_BLD_AREA,room_name,case when room.product_name<>''סլ'' then ''���̼�����'' else ''סլ'' end,'
       ||v_sql|| ' as NODE_WARNING from mdm_room room';
         dbms_output.put_line(v_sql);
       execute immediate v_sql;
        
        OPEN t_room_info FOR select * from TMP_ROOM;  
------------------------------------------------------------��Ŀ������Ϣ
BEGIN

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
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,null as parentId 
,b."ҵ̬" as text   
 from (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
(select 
   case when l.attribute_name<>'סլ' then '���̼�����' else 'סլ' end  as "ҵ̬"  from mdm_attribute_area_level l where parent_id is null) b
   union all
-----�����
select spid_tree
,proj.PROJECT_ID||ptype||a.areaStage as GRANULARITY_ID
,proj.PROJECT_ID as projectId
,proj.PROJECT_NAME
,proj.PROJECT_ID||ptype as parentId 
,a.areaStage as text
from  (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
( select 
    l.attribute_name as areaStage,case when p.attribute_name<>'סլ' then '���̼�����' else 'סլ' end  as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null) a;
    
OPEN spid_tree_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid_tree;  
------------------------------------------------------��������� spid

 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---��1������
,GRANULARITY_ID
,PROJECT_ID---��2����ĿID
,PROJECT_NAME
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,PARENT_ID  
,DATA_GRANULARITY
,PRODUCT_NAME
,CREATED---��51����������
,REMARK
)select 
spid as ID---��1������
,project_id||PRODUCT_NAME||AREA_LEVEL
,project_id as PROJECT_ID---��2����ĿID
,project_name
-----------------------------------K1���׿�ȥ���ʿ�ʼ--------------------
,"�׿�ȥ������" as FO_SALE_OUT_COUNT---��3���׿�ȥ������
,"�׿���������" as FO_SALE_COUNT---��4���׿���������
,case when �׿���������=0 then 0 else round("�׿�ȥ������"/"�׿���������",4)  end as FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,"�׿�ȥ�����" as FO_SALE_OUT_AREA---��6���׿�ȥ�����
,"�׿��������" as FO_SALE_AREA---��7���׿��������
,case when �׿��������=0 then 0 else round("�׿�ȥ�����"/"�׿��������",4)  end as FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,"�׿�ȥ����ֵ" as FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,"�׿����ۻ�ֵ" as FO_SALE_MONEY---��10���׿����ۻ�ֵ
,case when �׿����ۻ�ֵ=0 then 0 else round("�׿�ȥ����ֵ"/"�׿����ۻ�ֵ",4)  end as FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,"�׿����ۻ�ֵ"-"�׿�ȥ����ֵ" as FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,case when �׿��������=0 then 0 else round("�׿����ۻ�ֵ"/"�׿��������",4)  end  as FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,case when �׿�ȥ�����=0 then 0 else round("�׿�ȥ����ֵ"/"�׿�ȥ�����",4)  end as FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
-----------------------------------K3��ȫ��ȥ���� ����λ��%��--------------------
,"ȫ����ȥ������" as PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,"ȫ������֤����" as PO_SALE_COUNT---��16��ȫ����������
,case when ȫ������֤����=0 then 0 else round("ȫ����ȥ������"/"ȫ������֤����",4)  end as PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,"ȫ����ȥ�����" as PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,"ȫ������֤���" as PO_SALE_AREA---��19��ȫ���������
,case when ȫ������֤���=0 then 0 else round("ȫ����ȥ�����"/"ȫ������֤���",4)  end as PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,"ȫ����ȥ����ֵ" as PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,"ȫ������֤��ֵ" as PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,case when ȫ������֤��ֵ=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ������֤��ֵ",4)  end  as PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,"ȫ������֤��ֵ"-"ȫ����ȥ����ֵ" as PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,case when ȫ������֤���=0 then 0 else round("ȫ������֤��ֵ"/"ȫ������֤���",4)  end  as PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,case when ȫ����ȥ�����=0 then 0 else round("ȫ����ȥ����ֵ"/"ȫ����ȥ�����",4)  end   PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
-----------------------------------K4���ַ�ȥ���� ����λ��%��--------------------
,"�ַ�ȥ������" as EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,"�ַ���������" as EH_SALE_COUNT---��28���ַ���������
,case when �ַ���������=0 then 0 else  round("�ַ�ȥ������"/"�ַ���������",4) end as EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,"�ַ�ȥ�����" as EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,"�ַ��������" as EH_SALE_AREA---��31���ַ��������
,case when �ַ��������=0 then 0 else  round("�ַ�ȥ�����"/"�ַ��������",4) end as EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,"�ַ�ȥ�����" as EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,"�ַ����۽��" as EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,case when �ַ����۽��=0 then 0 else  round("�ַ�ȥ�����"/"�ַ����۽��",4) end as EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,"�ַ����۽��"-"�ַ�ȥ�����" as EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,case when �ַ��������=0 then 0 else  round("�ַ����۽��"/"�ַ��������",4) end  as EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,case when �ַ�ȥ�����=0 then 0 else  round("�ַ�ȥ�����"/"�ַ�ȥ�����",4) end  as EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
-----------------------------------K5������Կ��ȥ���� ����λ��%��--------------------
,"���ȥ������" as SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,"�����������" as SI_SALE_COUNT---��40������Կ����������
,case when �����������=0 then 0 else  round("���ȥ������"/"�����������",4) end as SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,"���ȥ�����" as SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,"����������" as SI_SALE_AREA---��43������Կ���������
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end  as SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,"���ȥ�����" as SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,"������۽��" as SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,case when ������۽��=0 then 0 else  round("���ȥ�����"/"������۽��",4) end as SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,"������۽��"-"���ȥ�����" SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,case when ����������=0 then 0 else  round("������۽��"/"����������",4) end as SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,case when ����������=0 then 0 else  round("���ȥ�����"/"����������",4) end as SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
-------------------- ҵ̬��������� start
,project_id||PRODUCT_NAME  as PARENT_ID  
,AREA_LEVEL as DATA_GRANULARITY
,PRODUCT_NAME    
,sys_created as CREATED---��51����������
,dwm_REMARK
-------------------- ҵ̬��������� end
from 
(select 
------�״ο���30���ڵ�ǩԼ���׿�ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ
sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "�׿�ȥ����ֵ"
------�״ο�����ȡ֤��ֵ���׿����ۻ�ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when room.SALE_STATE='ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "�׿����ۻ�ֵ"
------�״ο���30���ڵ�ǩԼ������׿�ȥ�������:
---------->���䡰���½��������
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "�׿�ȥ�����"
------�״ο��̵���ȡ֤������׿����������:
---------->���䡰���½��������
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "�׿��������"
------�״ο���30���ڵ�ǩԼ�������׿�ȥ��������:
---------->���䡰���ܡ�
---------->"��Ŀ����"��ʵ��������� <��ͬǩԼ����<"��Ŀ����"��ʵ��������� +30��
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "�׿�ȥ������"
------�״ο��̵���ȡ֤�������׿�����������:
---------->���䡰���ܡ�
---------->����������¥��Ԥ�����֤��ȡ���ڡ�<"��Ŀ����"��ʵ��������� 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "�׿���������"

------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ��------ȫ�� 
------ȫ������ȥ����ֵ��: 
---------->���䡰��ͬ�ɽ��ܼۡ�
---------->���䡰����״̬��=ǩԼ
,sum(case when room.SALE_STATE='ǩԼ' then room.TRADE_TOTAL else 0 end ) as "ȫ����ȥ����ֵ"
,sum(case when room.SALE_STATE='ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.TRADE_TOTAL  else 0 end ) as "��ǩԼ����ȡ֤"
------ȫ��������֤��ֵ����
---------->���䡰��۱�׼�ܼۡ�:�ڼ��㡰��ֵȥ���ʡ�ʱ������ǩԼ���䣨�п��ܳ����Żݴ��ۣ������ӷ�ĸ������ǩԼ�����㡰��ֵȥ���ʡ���
,sum(case when room.SALE_STATE='ǩԼ'  then room.TRADE_TOTAL  
when build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "ȫ������֤��ֵ"
------ȫ������ȥ�������:
---------->���䡰���½��������
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ'  then room.NEW_BLD_AREA else 0 end ) as "ȫ����ȥ�����"
------ȫ��������֤�����:
---------->���䡰���½��������
,sum(case when build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "ȫ������֤���"
------ȫ������ȥ������):
---------->���䡰���ܡ�
---------->���䡰����״̬��=ǩԼ  
,sum(case when room.SALE_STATE='ǩԼ' then 1 else 0 end ) as "ȫ����ȥ������"
------ȫ��������֤����):
---------->���䡰���ܡ�
,sum(case when build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "ȫ������֤����"
------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�------�ַ�
----�ַ�ȥ�����
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "�ַ�ȥ�����" ,
----�ַ��������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as �ַ��������,
----�ַ�ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  �ַ�ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----�ַ����۽��
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> 'ǩԼ'   then room.BZ_TOTAL  when room.SALE_STATE = 'ǩԼ' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as �ַ����۽��,
----�ַ�ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  �ַ�ȥ������,
----�ַ���������
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> 'ǩԼ' or  (room.SALE_STATE = 'ǩԼ' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as �ַ���������
------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��------����Կ��
----����������
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as ���ȥ�����,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then room.NEW_BLD_AREA else 0 end) as ����������,
----���ȥ�����
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  ���ȥ�����,
--���۽����Ҫ���ݷ����Ƿ��Ѿ�ǩԼ���ж�ȡǩԼ���Ǳ�׼���
----������۽��
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') then room.TRADE_TOTAL  --�Ѿ��ڽ���ǩԼ����ǩԼ���
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> 'ǩԼ' then room.BZ_TOTAL  else 0 end) as ������۽��,  --δǩԼ����У׼�ܼ�
----���ȥ������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = 'ǩԼ' and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  ���ȥ������,
----�����������
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> 'סլ' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = 'ǩԼ') or  room.SALE_STATE <> 'ǩԼ') then 1 else 0 end) as �����������
,proj.project_id,
proj.project_name,
proj.org_id,
proj.org_name,
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
proj.is_construction_began
,t_room.AREA_LEVEL
,t_room.PRODUCT_NAME 
from tmp_proj_base proj
left join MDM_ROOM room  on proj.project_id=room.project_id  and  proj.id = PROJ_BASE_SPID
left join TMP_ROOM t_room on  room.id=t_room.room_id
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
-------------------- ҵ̬��������� start
    ,t_room.AREA_LEVEL
    ,t_room.PRODUCT_NAME
----------------------ҵ̬��������� end
    ,proj.project_name,
    proj.org_id,
    proj.org_name,
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
    proj.is_construction_began
    ) result 
-------------------- ҵ̬��������� start
   where  PRODUCT_NAME  is not null
----------------------ҵ̬��������� end
;
   
OPEN spid_info FOR select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid;  
------------------------------------------------------���ݲ����
DELETE FROM DWM_SALE_RATE_BY_GRANULARITY where REMARK=dwm_REMARK;

INSERT INTO DWM_SALE_RATE_BY_GRANULARITY (
ID---��1������
,PROJECT_ID---��2����ĿID
,FO_SALE_OUT_COUNT---��3���׿�ȥ������
,FO_SALE_COUNT---��4���׿���������
,FO_SALE_RATE_BY_COUNT---��5���׿�ȥ����(������)��3/4��
,FO_SALE_OUT_AREA---��6���׿�ȥ�����
,FO_SALE_AREA---��7���׿��������
,FO_SALE_RATE_BY_AREA---��8���׿�ȥ����(�����)��6/7��
,FO_SALE_OUT_MONEY---��9���׿�ȥ����ֵ
,FO_SALE_MONEY---��10���׿����ۻ�ֵ
,FO_SALE_RATE_BY_MONEY---��11���׿�ȥ����(����ֵ)��9/10��
,FO_SURPLUS_SALE_MONEY---��12���׿�ʣ���ֵ(10-9)
,FO_SALE_AVERAGE_MONEY---��13���׿���׼����(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---��14���׿�ǩԼ����(9/6)
,PO_SALE_OUT_COUNT---��15��ȫ��ȥ������
,PO_SALE_COUNT---��16��ȫ����������
,PO_SALE_RATE_BY_COUNT---��17��ȫ��ȥ����(������)(15/16)
,PO_SALE_OUT_AREA---��18��ȫ��ȥ�����
,PO_SALE_AREA---��19��ȫ���������
,PO_SALE_RATE_BY_AREA---��20��ȫ��ȥ����(�����)(18/19)
,PO_SALE_OUT_MONEY---��21��ȫ��ȥ����ֵ
,PO_SALE_MONEY---��22��ȫ�����ۻ�ֵ
,PO_SALE_RATE_BY_MONEY---��23��ȫ��ȥ����(����ֵ)(21/22)
,PO_SURPLUS_SALE_MONEY---��24��ȫ��ʣ���ֵ(22-21)
,PO_SALE_AVERAGE_MONEY---��25��ȫ����׼����(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---��26��ȫ��ǩԼ����(21/18)
,EH_SALE_OUT_COUNT---��27���ַ�ȥ������
,EH_SALE_COUNT---��28���ַ���������
,EH_SALE_RATE_BY_COUNT---��29���ַ�ȥ����(������)(27/28)
,EH_SALE_OUT_AREA---��30���ַ�ȥ�����
,EH_SALE_AREA---��31���ַ��������
,EH_SALE_RATE_BY_AREA---��32���ַ�ȥ����(�����)(30/31)
,EH_SALE_OUT_MONEY---��33���ַ�ȥ����ֵ
,EH_SALE_MONEY---��34���ַ����ۻ�ֵ
,EH_SALE_RATE_BY_MONEY---��35���ַ�ȥ����(����ֵ)(33/34)
,EH_SURPLUS_SALE_MONEY---��36���ַ�ʣ���ֵ(34-33)
,EH_SALE_AVERAGE_MONEY---��37���ַ���׼����(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---��38���ַ�ǩԼ����(33/30)
,SI_SALE_OUT_COUNT---��39������Կ��ȥ������
,SI_SALE_COUNT---��40������Կ����������
,SI_SALE_RATE_BY_COUNT---��41������Կ��ȥ����(������)(39/40)
,SI_SALE_OUT_AREA---��42������Կ��ȥ�����
,SI_SALE_AREA---��43������Կ���������
,SI_SALE_RATE_BY_AREA---��44������Կ��ȥ����(�����)(42/43)
,SI_SALE_OUT_MONEY---��45������Կ��ȥ����ֵ
,SI_SALE_MONEY---��46������Կ�����ۻ�ֵ
,SI_SALE_RATE_BY_MONEY---��47������Կ��ȥ����(����ֵ)(45/46)
,SI_SURPLUS_SALE_MONEY---��48������Կ��ʣ���ֵ(46-45)
,SI_SALE_AVERAGE_MONEY---��49������Կ���׼����(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---��50������Կ��ǩԼ����(45/42)
,PARENT_ID  
,DATA_GRANULARITY 
,CREATED---��51����������
,REMARK---��52����ע��Ϣ
        )
   select  tree.GRANULARITY_ID--������id---��1������
,tree.PROJECT_ID,---��2����ĿID
nvl(apdata.fo_sale_out_count,0),
nvl(apdata.fo_sale_count,0),
nvl(apdata.fo_sale_rate_by_count,0),
nvl(apdata.fo_sale_out_area,0),
nvl(apdata.fo_sale_area,0),
nvl(apdata.fo_sale_rate_by_area,0),
nvl(apdata.fo_sale_out_money,0),
nvl(apdata.fo_sale_money,0),
nvl(apdata.fo_sale_rate_by_money,0),
nvl(apdata.fo_surplus_sale_money,0),
nvl(apdata.fo_sale_average_money,0),
nvl(apdata.fo_sale_out_average_money,0),
nvl(apdata.po_sale_out_count,0),
nvl(apdata.po_sale_count,0),
nvl(apdata.po_sale_rate_by_count,0),
nvl(apdata.po_sale_out_area,0),
nvl(apdata.po_sale_area,0),
nvl(apdata.po_sale_rate_by_area,0),
nvl(apdata.po_sale_out_money,0),
nvl(apdata.po_sale_money,0),
nvl(apdata.po_sale_rate_by_money,0),
nvl(apdata.po_surplus_sale_money,0),
nvl(apdata.po_sale_average_money,0),
nvl(apdata.po_sale_out_average_money,0),
nvl(apdata.eh_sale_out_count,0),
nvl(apdata.eh_sale_count,0),
nvl(apdata.eh_sale_rate_by_count,0),
nvl(apdata.eh_sale_out_area,0),
nvl(apdata.eh_sale_area,0),
nvl(apdata.eh_sale_rate_by_area,0),
nvl(apdata.eh_sale_out_money,0),
nvl(apdata.eh_sale_money,0),
nvl(apdata.eh_sale_rate_by_money,0),
nvl(apdata.eh_surplus_sale_money,0),
nvl(apdata.eh_sale_average_money,0),
nvl(apdata.eh_sale_out_average_money,0),
nvl(apdata.si_sale_out_count,0),
nvl(apdata.si_sale_count,0),
nvl(apdata.si_sale_rate_by_count,0),
nvl(apdata.si_sale_out_area,0),
nvl(apdata.si_sale_area,0),
nvl(apdata.si_sale_rate_by_area,0),
nvl(apdata.si_sale_out_money,0),
nvl(apdata.si_sale_money,0),
nvl(apdata.si_sale_rate_by_money,0),
nvl(apdata.si_surplus_sale_money,0),
nvl(apdata.si_sale_average_money,0),
nvl(apdata.si_sale_out_average_money,0)
,tree.PARENT_ID---����id
,tree.DATA_GRANULARITY--����������
,sys_created
,dwm_REMARK
from 
( select * from TMP_SALE_RATE_BY_GRANULARITY where id=spid_tree) tree
left join 
( 
    select  parent_id||data_granularity as id,
    project_id,
    fo_sale_out_count,
    fo_sale_count,
    fo_sale_rate_by_count,
    fo_sale_out_area,
    fo_sale_area,
    fo_sale_rate_by_area,
    fo_sale_out_money,
    fo_sale_money,
    fo_sale_rate_by_money,
    fo_surplus_sale_money,
    fo_sale_average_money,
    fo_sale_out_average_money,
    po_sale_out_count,
    po_sale_count,
    po_sale_rate_by_count,
    po_sale_out_area,
    po_sale_area,
    po_sale_rate_by_area,
    po_sale_out_money,
    po_sale_money,
    po_sale_rate_by_money,
    po_surplus_sale_money,
    po_sale_average_money,
    po_sale_out_average_money,
    eh_sale_out_count,
    eh_sale_count,
    eh_sale_rate_by_count,
    eh_sale_out_area,
    eh_sale_area,
    eh_sale_rate_by_area,
    eh_sale_out_money,
    eh_sale_money,
    eh_sale_rate_by_money,
    eh_surplus_sale_money,
    eh_sale_average_money,
    eh_sale_out_average_money,
    si_sale_out_count,
    si_sale_count,
    si_sale_rate_by_count,
    si_sale_out_area,
    si_sale_area,
    si_sale_rate_by_area,
    si_sale_out_money,
    si_sale_money,
    si_sale_rate_by_money,
    si_surplus_sale_money,
    si_sale_average_money,
    si_sale_out_average_money
 from  TMP_SALE_RATE_BY_GRANULARITY where id=spid
union all 
select  project_id||PRODUCT_NAME
,project_id,
sum(FO_SALE_OUT_COUNT),--��3���׿�ȥ������
sum(FO_SALE_COUNT),--��4���׿��������� 
case when sum(FO_SALE_COUNT)=0 then 0 else  round(sum(FO_SALE_OUT_COUNT)/sum(FO_SALE_COUNT),4) end,--��5���׿�ȥ����(������)��3/4��
sum(FO_SALE_OUT_AREA),--��6���׿�ȥ�����
sum(FO_SALE_AREA),--��7���׿��������
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_AREA)/sum(FO_SALE_AREA),4) end,--��8���׿�ȥ����(�����)��6/7��
sum(FO_SALE_OUT_MONEY),--��9���׿�ȥ����ֵ
sum(FO_SALE_MONEY),--��10���׿����ۻ�ֵ
case when sum(FO_SALE_MONEY)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_MONEY),4) end,--��11���׿�ȥ����(����ֵ)��9/10��
sum(FO_SURPLUS_SALE_MONEY),--��12���׿�ʣ���ֵ(10-9)
case when sum(FO_SALE_AREA)=0 then 0 else  round(sum(FO_SALE_MONEY)/sum(FO_SALE_AREA),4) end,--��13���׿���׼����(10/7)
case when sum(FO_SALE_OUT_AREA)=0 then 0 else  round(sum(FO_SALE_OUT_MONEY)/sum(FO_SALE_OUT_AREA),4) end,--��14���׿�ǩԼ����(9/6)
sum(PO_SALE_OUT_COUNT),--��15��ȫ��ȥ������
sum(PO_SALE_COUNT),--��16��ȫ����������
case when sum(PO_SALE_COUNT)=0 then 0 else  round(sum(PO_SALE_OUT_COUNT)/sum(PO_SALE_COUNT),4) end,--��17��ȫ��ȥ����(������)(15/16)
sum(PO_SALE_OUT_AREA),--��18��ȫ��ȥ�����
sum(PO_SALE_AREA),--��19��ȫ���������
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_AREA)/sum(PO_SALE_AREA),4) end,--��20��ȫ��ȥ����(�����)(18/19)
sum(PO_SALE_OUT_MONEY),--��21��ȫ��ȥ����ֵ
sum(PO_SALE_MONEY),--��22��ȫ�����ۻ�ֵ
case when sum(PO_SALE_MONEY)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_MONEY),4) end,--��23��ȫ��ȥ����(����ֵ)(21/22)
sum(PO_SURPLUS_SALE_MONEY),--��24��ȫ��ʣ���ֵ(22-21)
case when sum(PO_SALE_AREA)=0 then 0 else  round(sum(PO_SALE_MONEY)/sum(PO_SALE_AREA),4) end,--��25��ȫ����׼����(22/19)
case when sum(PO_SALE_OUT_AREA)=0 then 0 else  round(sum(PO_SALE_OUT_MONEY)/sum(PO_SALE_OUT_AREA),4) end,--��26��ȫ��ǩԼ����(21/18)
sum(EH_SALE_OUT_COUNT),--��27���ַ�ȥ������
sum(EH_SALE_COUNT),--��28���ַ���������
case when sum(EH_SALE_COUNT)=0 then 0 else  round(sum(EH_SALE_OUT_COUNT)/sum(EH_SALE_COUNT),4) end,--��29���ַ�ȥ����(������)(27/28)
sum(EH_SALE_OUT_AREA),--��30���ַ�ȥ�����
sum(EH_SALE_AREA),--��31���ַ��������
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_AREA)/sum(EH_SALE_AREA),4) end,--��32���ַ�ȥ����(�����)(30/31)
sum(EH_SALE_OUT_MONEY),--��33���ַ�ȥ����ֵ
sum(EH_SALE_MONEY),--��34���ַ����ۻ�ֵ
case when sum(EH_SALE_MONEY)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_MONEY),4) end,--��35���ַ�ȥ����(����ֵ)(33/34)
sum(EH_SURPLUS_SALE_MONEY),--��36���ַ�ʣ���ֵ(34-33)
case when sum(EH_SALE_AREA)=0 then 0 else  round(sum(EH_SALE_MONEY)/sum(EH_SALE_AREA),4) end,--��37���ַ���׼����(34/31)
case when sum(EH_SALE_OUT_AREA)=0 then 0 else  round(sum(EH_SALE_OUT_MONEY)/sum(EH_SALE_OUT_AREA),4) end,--��38���ַ�ǩԼ����(33/30)
sum(SI_SALE_OUT_COUNT),--��39������Կ��ȥ������
sum(SI_SALE_COUNT),--��40������Կ����������
case when sum(SI_SALE_COUNT)=0 then 0 else  round(sum(SI_SALE_OUT_COUNT)/sum(SI_SALE_COUNT),4) end,--��41������Կ��ȥ����(������)(39/40)
sum(SI_SALE_OUT_AREA),--��42������Կ��ȥ�����
sum(SI_SALE_AREA),--��43������Կ���������
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_AREA)/sum(SI_SALE_AREA),4) end,--��44������Կ��ȥ����(�����)(42/43)
sum(SI_SALE_OUT_MONEY),--��45������Կ��ȥ����ֵ
sum(SI_SALE_MONEY),--��46������Կ�����ۻ�ֵ
case when sum(SI_SALE_MONEY)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_MONEY),4) end,--��47������Կ��ȥ����(����ֵ)(45/46)
sum(SI_SURPLUS_SALE_MONEY),--��48������Կ��ʣ���ֵ(46-45)
case when sum(SI_SALE_AREA)=0 then 0 else  round(sum(SI_SALE_MONEY)/sum(SI_SALE_AREA),4) end,--��49������Կ���׼����(46/43)
case when sum(SI_SALE_OUT_AREA)=0 then 0 else  round(sum(SI_SALE_OUT_MONEY)/sum(SI_SALE_OUT_AREA),4) end--��50������Կ��ǩԼ����(45/42)
 from  TMP_SALE_RATE_BY_GRANULARITY where id=spid group by project_id,
 parent_id,PRODUCT_NAME) apdata  
on tree.GRANULARITY_ID=apdata.id order by apdata.project_id;
commit;

END P_DWM_SALE_RATE_BY_GRANULARITY;