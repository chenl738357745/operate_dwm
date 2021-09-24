create or replace PROCEDURE "P_OPM_ED_PROJ_INVESTMENT" (
    userid         IN    VARCHAR2,--��ǰ�û�id
    stationid      IN    VARCHAR2,--��ǰ�û���λid
    departmentid   IN    VARCHAR2,--��ǰ�û�����id
    companyid      IN    VARCHAR2,--��ǰ�û���˾id
    projectid      IN    VARCHAR2,--������Ŀid
    planyear       IN    NUMBER,--�ƻ���
    projsheet2     OUT   SYS_REFCURSOR--2��sheetҳ������Դ���� �����ݼ���˳��
) AS
-- operate plan  
--����2-Ͷ�ʼƻ��� (2)+ɾ������
--���ߣ�chenl
--���ڣ�2021/09/23
   fieldname clob;
   fieldname1 clob;
   v_sql_exec clob;
BEGIN
   -- SELECT 'select ''���У����س��ý𣨻������չ��ۣ�'' object_name,' || wm_concat ('''' || "kf_land_transfer_fee" || '''') || ' from dual' FROM base UNION ALL

 SELECT 'select ''����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "id" || '''') || ' from dual
union all
select ''���سɱ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_cost" || '''') || ' from dual
union all
select ''���У����س��ý𣨻������չ��ۣ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_transfer_fee" || '''') || ' from dual
union all
select ''���У������ؼۿ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_payment" || '''') || ' from dual
union all
select ''���У����������׷�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_municipal_support" || '''') || ' from dual
union all
select ''���У���˰'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_deed_tax" || '''') || ' from dual
union all
select ''���У���Ǩ�����ѡ������컯����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_compensation" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_land_other" || '''') || ' from dual
union all
select ''�������շ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_policy_charge" || '''') || ' from dual
union all
select ''ǰ�ڹ��̷�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_proj_costs" || '''') || ' from dual
union all
select ''������ʩ��'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_facil_fee" || '''') || ' from dual
union all
select ''԰���̻���·'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "kf_landscap_road" || '''') || ' from dual
union all
select ''�������̷�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_proj_costs" || '''') || ' from dual
union all
select ''���У���������'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_basic_proj" || '''') || ' from dual
union all
select ''���У����½ṹ'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_underground_structure" || '''') || ' from dual
union all
select ''���У����Ͻṹ'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_ontheground_structure" || '''') || ' from dual
union all
select ''���У���װ'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_exterior" || '''') || ' from dual
union all
select ''���У���װ��'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_initial_decoration" || '''') || ' from dual
union all
select ''���У�������װ��'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_public_exquisite" || '''') || ' from dual
union all
select ''���У����ھ�װ��'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_indoor_exquisite" || '''') || ' from dual
union all
select ''���У�����ˮ'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_drainage" || '''') || ' from dual
union all
select ''���У�ǿ��'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_strong_current" || '''') || ' from dual
union all
select ''���У���ů'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_heating" || '''') || ' from dual
union all
select ''���У�ͨ��յ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_airiness" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_fire_control" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_elevator" || '''') || ' from dual
union all
select ''���У����缰���ܻ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_weak_current" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "ja_other" || '''') || ' from dual
union all
select ''�������׽����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "pc_support_construct_fee" || '''') || ' from dual
union all
select ''������ӷ�'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "pc_development_overhead" || '''') || ' from dual
union all
select ''���У���ҵ����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "pc_property_subsidy" || '''') || ' from dual
union all
select ''���У�Ʒ���������𡢿��з���'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "pc_resear_expenses" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "pc_other" || '''') || ' from dual
union all
select ''���۷���'' object_name,''�ڼ����'' object_name1,'|| wm_concat ('''' || "sa_sales_expense" || '''') || ' from dual
union all
select ''�������'' object_name,''�ڼ����'' object_name1,'|| wm_concat ('''' || "sa_manage_expense" || '''') || ' from dual
union all
select ''�������'' object_name,''�ڼ����'' object_name1,'|| wm_concat ('''' || "sa_finance_expense" || '''') || ' from dual
union all
select ''���У��ʱ�����Ϣ'' object_name,''�ڼ����'' object_name1,'|| wm_concat ('''' || "sa_capitali_interest" || '''') || ' from dual
union all
select ''���У����û���Ϣ'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "sa_expensed_interest" || '''') || ' from dual
union all
select ''���У�����'' object_name,''�����ɱ�'' object_name1,'|| wm_concat ('''' || "sa_other" || '''') || ' from dual
union all
select ''��ֵ˰'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_the_tax" || '''') || ' from dual
union all
select ''����ά������˰�������Ѹ��Ӽ��ط������Ѹ���'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_urban_construc_tax" || '''') || ' from dual
union all
select ''������ֵ˰��Ԥ�ɣ�'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_advance" || '''') || ' from dual
union all
select ''������ֵ˰������󲹽ɣ�'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_payment" || '''') || ' from dual
union all
select ''����ʹ��˰'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_land_use_tax" || '''') || ' from dual
union all
select ''ӡ��˰��������ӡ���ȣ�'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_stamp_duty" || '''') || ' from dual
union all
select ''����'' object_name,''˰�𼰸���'' object_name1,'|| wm_concat ('''' || "ld_other" || '''') || ' from dual
union all
select ''��Ͷ�ʣ�����˰ǰ�ɱ���'' object_name,''�ϼ�'' object_name1,'|| wm_concat ('''' || "total_investment" || '''') || ' from dual
union all
select ''���У��ɿسɱ�������˰ǰ�ɱ�-˰�𼰸���-���س��ý�-�����ؼۿ�-��˰��'' object_name,'''' object_name1,'|| wm_concat ('''' || "controllable_costs" || '''') || ' from dual
' into v_sql_exec FROM 
(
(SELECT
    id as "id", ---
    plan_year as "plan_year", ---�ƻ����
    parent_id as "parent_id", ---����ID
    level_code as "level_code", ---�㼶��1��ʼ
    order_code as "order_code", ---˳��
    object_id as "object_id", ---����ID
    object_name as "object_name", ---��������
    object_type as "object_type", ---�������
    object_level_name_one as "object_level_name_one",  
    object_level_name_one as "object_level_name_two",  
    nvl(fma_kf_land_cost, kf_land_cost) AS "kf_land_cost", ---���سɱ�
    nvl(fma_kf_land_transfer_fee, kf_land_transfer_fee) AS "kf_land_transfer_fee", ---���У����س��ý𣨻������չ��ۣ�
    nvl(fma_kf_land_payment, kf_land_payment) AS "kf_land_payment", ---���У������ؼۿ�
    nvl(fma_kf_land_municipal_support, kf_land_municipal_support) AS "kf_land_municipal_support", ---���У����������׷�
    nvl(fma_kf_land_deed_tax, kf_land_deed_tax) AS "kf_land_deed_tax", ---���У���˰
    nvl(fma_kf_land_compensation, kf_land_compensation) AS "kf_land_compensation", ---���У���Ǩ�����ѡ������컯����
    nvl(fma_kf_land_other, kf_land_other) AS "kf_land_other", ---���У�����
    nvl(fma_kf_policy_charge, kf_policy_charge) AS "kf_policy_charge", ---�������շ�
    nvl(fma_kf_proj_costs, kf_proj_costs) AS "kf_proj_costs", ---ǰ�ڹ��̷�
    nvl(fma_kf_facil_fee, kf_facil_fee) AS "kf_facil_fee", ---������ʩ��
    nvl(fma_kf_landscap_road, kf_landscap_road) AS "kf_landscap_road", ---԰���̻���·
    nvl(fma_ja_proj_costs, ja_proj_costs) AS "ja_proj_costs", ---�������̷�
    nvl(fma_ja_basic_proj, ja_basic_proj) AS "ja_basic_proj", ---���У���������
    nvl(fma_ja_underground_structure, ja_underground_structure) AS "ja_underground_structure", ---���У����½ṹ
    nvl(fma_ja_ontheground_structure, ja_ontheground_structure) AS "ja_ontheground_structure", ---���У����Ͻṹ
    nvl(fma_ja_exterior, ja_exterior) AS "ja_exterior", ---���У���װ
    nvl(fma_ja_initial_decoration, ja_initial_decoration) AS "ja_initial_decoration", ---���У���װ��
    nvl(fma_ja_public_exquisite, ja_public_exquisite) AS "ja_public_exquisite", ---���У�������װ��
    nvl(fma_ja_indoor_exquisite, ja_indoor_exquisite) AS "ja_indoor_exquisite", ---���У����ھ�װ��
    nvl(fma_ja_drainage, ja_drainage) AS "ja_drainage", ---���У�����ˮ
    nvl(fma_ja_strong_current, ja_strong_current) AS "ja_strong_current", ---���У�ǿ��
    nvl(fma_ja_heating, ja_heating) AS "ja_heating", ---���У���ů
    nvl(fma_ja_airiness, ja_airiness) AS "ja_airiness", ---���У�ͨ��յ�
    nvl(fma_ja_fire_control, ja_fire_control) AS "ja_fire_control", ---���У�����
    nvl(fma_ja_elevator, ja_elevator) AS "ja_elevator", ---���У�����
    nvl(fma_ja_weak_current, ja_weak_current) AS "ja_weak_current", ---���У����缰���ܻ�
    nvl(fma_ja_other, ja_other) AS "ja_other", ---���У�����
    nvl(fma_pc_support_construct_fee, pc_support_construct_fee) AS "pc_support_construct_fee", ---�������׽����
    nvl(fma_pc_development_overhead, pc_development_overhead) AS "pc_development_overhead", ---������ӷ�
    nvl(fma_pc_property_subsidy, pc_property_subsidy) AS "pc_property_subsidy", ---���У���ҵ����
    nvl(fma_pc_resear_expenses, pc_resear_expenses) AS "pc_resear_expenses", ---���У�Ʒ���������𡢿��з���
    nvl(fma_pc_other, pc_other) AS "pc_other", ---���У�����
    nvl(fma_sa_sales_expense, sa_sales_expense) AS "sa_sales_expense", ---���۷���
    nvl(fma_sa_manage_expense, sa_manage_expense) AS "sa_manage_expense", ---�������
    nvl(fma_sa_finance_expense, sa_finance_expense) AS "sa_finance_expense", ---�������
    nvl(fma_sa_capitali_interest, sa_capitali_interest) AS "sa_capitali_interest", ---���У��ʱ�����Ϣ
    nvl(fma_sa_expensed_interest, sa_expensed_interest) AS "sa_expensed_interest", ---���У����û���Ϣ
    nvl(fma_sa_other, sa_other) AS "sa_other", ---���У�����
    nvl(fma_ld_the_tax, ld_the_tax) AS "ld_the_tax", ---��ֵ˰
    nvl(fma_ld_urban_construc_tax, ld_urban_construc_tax) AS "ld_urban_construc_tax", ---����ά������˰�������Ѹ��Ӽ��ط������Ѹ���
    nvl(fma_ld_advance, ld_advance) AS "ld_advance", ---������ֵ˰��Ԥ�ɣ�
    nvl(fma_ld_payment, ld_payment) AS "ld_payment", ---������ֵ˰������󲹽ɣ�
    nvl(fma_ld_land_use_tax, ld_land_use_tax) AS "ld_land_use_tax", ---����ʹ��˰
    nvl(fma_ld_stamp_duty, ld_stamp_duty) AS "ld_stamp_duty", ---ӡ��˰��������ӡ���ȣ�
    nvl(fma_ld_other, ld_other) AS "ld_other", ---����
    nvl(fma_total_investment, total_investment) AS "total_investment", ---��Ͷ�ʣ�����˰ǰ�ɱ���
    nvl(fma_controllable_costs, controllable_costs) AS "controllable_costs" ---���У��ɿسɱ�������˰ǰ�ɱ�-˰�𼰸���-���س��ý�-�����ؼۿ�-��˰��
FROM
    opm_proj_investment_plan
WHERE
    plan_year = planyear and BELONG_PROJ_ID=projectid)
) base;
--DBMS_OUTPUT.PUT_LINE(v_sql_exec);
OPEN projsheet2 FOR  v_sql_exec;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
   OPEN projsheet2 FOR  select 'ʧ����,��ϵ����Ա�鿴,��Ͷ�ʼƻ���'||projectid||'����'||planyear||'���Ƿ���ʼ����' as  object_name from dual;

END P_OPM_ED_PROJ_INVESTMENT;


 --   SELECT wm_concat(t."id"),wm_concat(t."object_type") FROM base t