create or replace PROCEDURE "P_OPM_ED_PROJ_CHENL" (
    userid         IN    VARCHAR2,--��ǰ�û�id
    stationid      IN    VARCHAR2,--��ǰ�û���λid
    departmentid   IN    VARCHAR2,--��ǰ�û�����id
    companyid      IN    VARCHAR2,--��ǰ�û���˾id
    projectid      IN    VARCHAR2,--������Ŀid
    planyear       IN    NUMBER,--�ƻ���
    projsheet2     OUT   SYS_REFCURSOR--2��sheetҳ������Դ���� �����ݼ���˳��
) is
   fieldname clob;
   v_sql_exec clob;
BEGIN

SELECT  wm_concat( '''' || object_name || '''' ) into fieldname  FROM opm_proj_investment_plan WHERE   plan_year = 2021 and BELONG_PROJ_ID='3d44a12d-6aef-40e1-9a5d-92e54d223878';

v_sql_exec:='
with base as(SELECT
    id as "id", ---
    plan_year as "plan_year", ---�ƻ����
    parent_id as "parent_id", ---����ID
    level_code as "level_code", ---�㼶��1��ʼ
    order_code as "order_code", ---˳��
    object_id as "object_id", ---����ID
    object_name as "object_name", ---��������
    object_type as "object_type", ---�������
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
    plan_year = 2021 and BELONG_PROJ_ID=''3d44a12d-6aef-40e1-9a5d-92e54d223878'')
    
 
    
select * from (select  "object_name" from base) pivot (sum( "object_name") for  "object_name" in ('||fieldname||'));';
OPEN projsheet2 FOR  v_sql_exec;
END P_OPM_ED_PROJ_chenl;

 
 --   SELECT wm_concat(t."id"),wm_concat(t."object_type") FROM base t
 
 
 