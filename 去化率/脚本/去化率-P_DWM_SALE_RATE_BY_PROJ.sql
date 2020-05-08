create or replace PROCEDURE "P_DWM_SALE_RATE_BY_PROJ" (
    is_photograph_p in number:=0,
    proj_info   OUT              SYS_REFCURSOR,
    proj_SPID  out NVARCHAR2
    
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
BEGIN
--------������ʱ�����κ�
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
proj_SPID:=spid;
------��Ŀ������Ϣ
BEGIN
  IS_PHOTOGRAPH := is_photograph_p;

  P_DWM_SALE_RATE_PROJ(
    IS_PHOTOGRAPH => 0,
    PROJ_BASE_INFO => PROJ_BASE_INFO,
    PROJ_DATE_INFO => PROJ_DATE_INFO,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ----- 
 INSERT INTO TMP_SALE_RATE_BY_PROJECT (ID---��1������
,PROJECT_ID---��2����ĿID
,PROJECT_NAME
,ORG_ID
,ORG_NAME
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
,CREATED---��51����������
)select 
spid as ID---��1������
,project_id as PROJECT_ID---��2����ĿID
,project_name
,ORG_ID
,ORG_NAME
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
,sys_created as CREATED---��51����������
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
from tmp_proj_base proj left join  MDM_ROOM room  
on proj.project_id=room.project_id  and  proj.id = PROJ_BASE_SPID
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
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
    proj.is_construction_began) result  order by "ȫ����ȥ����ֵ" asc
;

-- 
IF is_photograph <> 0 THEN
----�Ƚ����������룬��ʷ����Ŀ���ݣ�������µ�����
        
--    INSERT INTO  DWM_SALE_RATE_PROJECT_HISTORY
--    select * from  DWM_SALE_RATE_BY_PROJECT where REMARK=dwm_REMARK;
    DELETE FROM DWM_SALE_RATE_BY_PROJECT ;
    --where REMARK=dwm_REMARK;

        INSERT INTO DWM_SALE_RATE_BY_PROJECT (
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
,CREATED---��51����������
,REMARK---��52����ע��Ϣ
        )
            SELECT
PROJECT_ID      ID---��1������
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
,CREATED---��51����������
,dwm_REMARK---��52����ע��Ϣ
            FROM
                TMP_SALE_RATE_BY_PROJECT where id=spid;
commit;
    END IF;
OPEN proj_info FOR 
select rownum,p.* from  TMP_SALE_RATE_BY_PROJECT p where id=spid;


END P_DWM_SALE_RATE_BY_PROJ;