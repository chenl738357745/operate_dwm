CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_BY_ORG"  AS
		--��˾������ȥ���ʣ�����=����ʱ��������
		--���ߣ�����
		--���ڣ�2020-04-10

    PROJ_SPID NVARCHAR2(200);
    sys_created       DATE := SYSDATE;
    spid_tree              VARCHAR2(360); --ʹ����ʱ������κ�
    spid_sum              VARCHAR2(360); --ʹ����ʱ������κ�
    spid_result              VARCHAR2(360); --ʹ����ʱ������κ�
    dwm_remark        VARCHAR2(200) := '����-chenl';
    p_X_AXIS_PERIOD  VARCHAR2(200):=to_char(sysdate, 'yyyy') ||'-'||to_char(sysdate, 'MM' );
BEGIN
delete tmp_sale_rate_by_org;
--------������ʱ�����κ�
    SELECT
        get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_sum,spid_result
    FROM
        dual;  

------��Ŀ������Ϣ
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(0,
    PROJ_SPID => PROJ_SPID
  );
END;

----��װ��
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--��  2����ĿID
        org_name,--��  3����Ŀ����
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--��  4���׿�ȥ������
        fo_sale_count,--��  5���׿���������
        fo_sale_out_area,--��  7���׿�ȥ�����
        fo_sale_area,--��  8���׿��������
        fo_sale_out_money,--�� 10���׿�ȥ����ֵ
        fo_sale_money,--�� 11���׿����ۻ�ֵ
        fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
        po_sale_out_count,--�� 14��ȫ��ȥ������
        po_sale_count,--�� 15��ȫ����������
        po_sale_out_area,--�� 17��ȫ��ȥ�����
        po_sale_area,--�� 18��ȫ���������
        po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
        po_sale_money,--�� 21��ȫ�����ۻ�ֵ
        po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
        eh_sale_out_count,--�� 24���ַ�ȥ������
        eh_sale_count,--�� 25���ַ���������
        eh_sale_out_area,--�� 27���ַ�ȥ�����
        eh_sale_area,--�� 28���ַ��������
        eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
        eh_sale_money,--�� 31���ַ����ۻ�ֵ
        eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
        si_sale_out_count,--�� 34������Կ��ȥ������
        si_sale_count,--�� 35������Կ����������
        si_sale_out_area,--�� 37������Կ��ȥ�����
        si_sale_area,--�� 38������Կ���������
        si_sale_out_money,--�� 40������Կ��ȥ����ֵ
        si_sale_money,--�� 41������Կ�����ۻ�ֵ
        si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
    )
        SELECT
            spid_tree,
            id AS org_id,
            org_name,
            parent_id,
            IS_COMPANY,
            LEVEL_RANK,
            0 AS fo_sale_out_count,--��  4���׿�ȥ������
            0 AS fo_sale_count,--��  5���׿���������
            0 AS fo_sale_out_area,--��  7���׿�ȥ�����
            0 AS fo_sale_area,--��  8���׿��������
            0 AS fo_sale_out_money,--�� 10���׿�ȥ����ֵ
            0 AS fo_sale_money,--�� 11���׿����ۻ�ֵ
            0 AS fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
            0 AS po_sale_out_count,--�� 14��ȫ��ȥ������
            0 AS po_sale_count,--�� 15��ȫ����������
            0 AS po_sale_out_area,--�� 17��ȫ��ȥ�����
            0 AS po_sale_area,--�� 18��ȫ���������
            0 AS po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
            0 AS po_sale_money,--�� 21��ȫ�����ۻ�ֵ
            0 AS po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
            0 AS eh_sale_out_count,--�� 24���ַ�ȥ������
            0 AS eh_sale_count,--�� 25���ַ���������
            0 AS eh_sale_out_area,--�� 27���ַ�ȥ�����
            0 AS eh_sale_area,--�� 28���ַ��������
            0 AS eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
            0 AS eh_sale_money,--�� 31���ַ����ۻ�ֵ
            0 AS eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
            0 AS si_sale_out_count,--�� 34������Կ��ȥ������
            0 AS si_sale_count,--�� 35������Կ����������
            0 AS si_sale_out_area,--�� 37������Կ��ȥ�����
            0 AS si_sale_area,--�� 38������Կ���������
            0 AS si_sale_out_money,--�� 40������Կ��ȥ����ֵ
            0 AS si_sale_money,--�� 41������Կ�����ۻ�ֵ
            0 AS si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
        FROM
            sys_business_unit where IS_COMPANY=1
        UNION ALL
        SELECT
            spid_tree,
            project_id,
            org_name,
            org_id AS parent_id,
            0,
            null,
            fo_sale_out_count,--��  4���׿�ȥ������
            fo_sale_count,--��  5���׿���������
            fo_sale_out_area,--��  7���׿�ȥ�����
            fo_sale_area,--��  8���׿��������
            fo_sale_out_money,--�� 10���׿�ȥ����ֵ
            fo_sale_money,--�� 11���׿����ۻ�ֵ
            fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
            po_sale_out_count,--�� 14��ȫ��ȥ������
            po_sale_count,--�� 15��ȫ����������
            po_sale_out_area,--�� 17��ȫ��ȥ�����
            po_sale_area,--�� 18��ȫ���������
            po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
            po_sale_money,--�� 21��ȫ�����ۻ�ֵ
            po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
            eh_sale_out_count,--�� 24���ַ�ȥ������
            eh_sale_count,--�� 25���ַ���������
            eh_sale_out_area,--�� 27���ַ�ȥ�����
            eh_sale_area,--�� 28���ַ��������
            eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
            eh_sale_money,--�� 31���ַ����ۻ�ֵ
            eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
            si_sale_out_count,--�� 34������Կ��ȥ������
            si_sale_count,--�� 35������Կ����������
            si_sale_out_area,--�� 37������Կ��ȥ�����
            si_sale_area,--�� 38������Կ���������
            si_sale_out_money,--�� 40������Կ��ȥ����ֵ
            si_sale_money,--�� 41������Կ�����ۻ�ֵ
            si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
        FROM
            tmp_sale_rate_by_project where id=proj_spid;           
----����          
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--��  2����ĿID
        org_name,--��  3����Ŀ����
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--��  4���׿�ȥ������
        fo_sale_count,--��  5���׿���������
        fo_sale_out_area,--��  7���׿�ȥ�����
        fo_sale_area,--��  8���׿��������
        fo_sale_out_money,--�� 10���׿�ȥ����ֵ
        fo_sale_money,--�� 11���׿����ۻ�ֵ
        fo_surplus_sale_money,--�� 13���׿�ʣ���ֵ
        po_sale_out_count,--�� 14��ȫ��ȥ������
        po_sale_count,--�� 15��ȫ����������
        po_sale_out_area,--�� 17��ȫ��ȥ�����
        po_sale_area,--�� 18��ȫ���������
        po_sale_out_money,--�� 20��ȫ��ȥ����ֵ
        po_sale_money,--�� 21��ȫ�����ۻ�ֵ
        po_surplus_sale_money,--�� 23��ȫ��ʣ���ֵ
        eh_sale_out_count,--�� 24���ַ�ȥ������
        eh_sale_count,--�� 25���ַ���������
        eh_sale_out_area,--�� 27���ַ�ȥ�����
        eh_sale_area,--�� 28���ַ��������
        eh_sale_out_money,--�� 30���ַ�ȥ����ֵ
        eh_sale_money,--�� 31���ַ����ۻ�ֵ
        eh_surplus_sale_money,--�� 33���ַ�ʣ���ֵ
        si_sale_out_count,--�� 34������Կ��ȥ������
        si_sale_count,--�� 35������Կ����������
        si_sale_out_area,--�� 37������Կ��ȥ�����
        si_sale_area,--�� 38������Կ���������
        si_sale_out_money,--�� 40������Կ��ȥ����ֵ
        si_sale_money,--�� 41������Կ�����ۻ�ֵ
        si_surplus_sale_money--�� 43������Կ��ʣ���ֵ
    )
 select spid_sum,org_id,org_name,parent_id,IS_COMPANY,LEVEL_RANK
,(select sum(FO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_COUNT
,(select sum(FO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_COUNT
,(select sum(FO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_AREA
,(select sum(FO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_AREA
,(select sum(FO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_MONEY
,(select sum(FO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_MONEY
,(select sum(FO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SURPLUS_SALE_MONEY
,(select sum(PO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_COUNT
,(select sum(PO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_COUNT
,(select sum(PO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_AREA
,(select sum(PO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_AREA
,(select sum(PO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_MONEY
,(select sum(PO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_MONEY
,(select sum(PO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SURPLUS_SALE_MONEY
,(select sum(EH_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_COUNT
,(select sum(EH_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_COUNT
,(select sum(EH_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_AREA
,(select sum(EH_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_AREA
,(select sum(EH_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_MONEY
,(select sum(EH_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_MONEY
,(select sum(EH_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SURPLUS_SALE_MONEY
,(select sum(SI_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_COUNT
,(select sum(SI_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_COUNT
,(select sum(SI_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_AREA
,(select sum(SI_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_AREA
,(select sum(SI_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_MONEY
,(select sum(SI_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_MONEY
,(select sum(SI_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SURPLUS_SALE_MONEY
from tmp_sale_rate_by_org s where id=spid_tree
order by org_id  ; 
----������
INSERT INTO tmp_sale_rate_by_org (
ID,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
LEVEL_RANK,
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
"REMARK" )
select spid_result,ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
LEVEL_RANK,
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end as  FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end as  FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end as FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SALE_MONEY-FO_SALE_OUT_MONEY as FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
case when FO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end as PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end as PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end as PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SALE_MONEY-PO_SALE_OUT_MONEY as PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end as EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end  as EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end  as EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SALE_MONEY-EH_SALE_OUT_MONEY as EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end  as SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end  as SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end  as SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SALE_MONEY-SI_SALE_OUT_MONEY as SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
p_X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
sys_created,--��45������ʱ��
dwm_remark--��46����ע��Ϣ
from tmp_sale_rate_by_org where IS_COMPANY=1 and id=spid_sum and LEVEL_RANK<=2
;
----���뵽Ŀ���

   DELETE FROM dwm_sale_rate_by_org where  X_AXIS_PERIOD=p_X_AXIS_PERIOD;
   --and REMARK=dwm_REMARK;

   INSERT INTO dwm_sale_rate_by_org (
ID,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
"REMARK" )
select get_uuid,--��1������
ORG_ID,--��2����ĿID
ORG_NAME,--��3����Ŀ����
FO_SALE_OUT_COUNT,--��4���׿�ȥ������
FO_SALE_COUNT,--��5���׿���������
FO_SALE_RATE_BY_COUNT,--��6���׿�ȥ����(������)
FO_SALE_OUT_AREA,--��7���׿�ȥ�����
FO_SALE_AREA,--��8���׿��������
FO_SALE_RATE_BY_AREA,--��9���׿�ȥ����(�����)
FO_SALE_OUT_MONEY,--��10���׿�ȥ����ֵ
FO_SALE_MONEY,--��11���׿����ۻ�ֵ
FO_SALE_RATE_BY_MONEY,--��12���׿�ȥ����(����ֵ)
FO_SURPLUS_SALE_MONEY,--��13���׿�ʣ���ֵ
PO_SALE_OUT_COUNT,--��14��ȫ��ȥ������
PO_SALE_COUNT,--��15��ȫ����������
PO_SALE_RATE_BY_COUNT,--��16��ȫ��ȥ����(������)
PO_SALE_OUT_AREA,--��17��ȫ��ȥ�����
PO_SALE_AREA,--��18��ȫ���������
PO_SALE_RATE_BY_AREA,--��19��ȫ��ȥ����(�����)
PO_SALE_OUT_MONEY,--��20��ȫ��ȥ����ֵ
PO_SALE_MONEY,--��21��ȫ�����ۻ�ֵ
PO_SALE_RATE_BY_MONEY,--��22��ȫ��ȥ����(����ֵ)
PO_SURPLUS_SALE_MONEY,--��23��ȫ��ʣ���ֵ
EH_SALE_OUT_COUNT,--��24���ַ�ȥ������
EH_SALE_COUNT,--��25���ַ���������
EH_SALE_RATE_BY_COUNT,--��26���ַ�ȥ����(������)
EH_SALE_OUT_AREA,--��27���ַ�ȥ�����
EH_SALE_AREA,--��28���ַ��������
EH_SALE_RATE_BY_AREA,--��29���ַ�ȥ����(�����)
EH_SALE_OUT_MONEY,--��30���ַ�ȥ����ֵ
EH_SALE_MONEY,--��31���ַ����ۻ�ֵ
EH_SALE_RATE_BY_MONEY,--��32���ַ�ȥ����(����ֵ)
EH_SURPLUS_SALE_MONEY,--��33���ַ�ʣ���ֵ
SI_SALE_OUT_COUNT,--��34������Կ��ȥ������
SI_SALE_COUNT,--��35������Կ����������
SI_SALE_RATE_BY_COUNT,--��36������Կ��ȥ����(������)
SI_SALE_OUT_AREA,--��37������Կ��ȥ�����
SI_SALE_AREA,--��38������Կ���������
SI_SALE_RATE_BY_AREA,--��39������Կ��ȥ����(�����)
SI_SALE_OUT_MONEY,--��40������Կ��ȥ����ֵ
SI_SALE_MONEY,--��41������Կ�����ۻ�ֵ
SI_SALE_RATE_BY_MONEY,--��42������Կ��ȥ����(����ֵ)
SI_SURPLUS_SALE_MONEY,--��43������Կ��ʣ���ֵ
X_AXIS_PERIOD,--��44��ʱ�䣨�����꣩
CREATED,--��45������ʱ��
"REMARK"
from tmp_sale_rate_by_org where id=spid_result;
commit;

    
END p_dwm_sale_rate_by_org;