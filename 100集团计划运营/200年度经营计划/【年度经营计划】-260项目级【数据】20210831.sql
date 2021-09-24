create or replace PROCEDURE "P_OPM_ED_PROJ_INVESTMENT" (
    userid         IN    VARCHAR2,--当前用户id
    stationid      IN    VARCHAR2,--当前用户岗位id
    departmentid   IN    VARCHAR2,--当前用户部门id
    companyid      IN    VARCHAR2,--当前用户公司id
    projectid      IN    VARCHAR2,--所属项目id
    planyear       IN    NUMBER,--计划年
    projsheet2     OUT   SYS_REFCURSOR--2、sheet页的数据源集合 【根据集合顺序】
) AS
-- operate plan  
--附表2-投资计划表 (2)+删除附表
--作者：chenl
--日期：2021/09/23
   fieldname clob;
   fieldname1 clob;
   v_sql_exec clob;
BEGIN
   -- SELECT 'select ''其中：土地出让金（或土地收购价）'' object_name,' || wm_concat ('''' || "kf_land_transfer_fee" || '''') || ' from dual' FROM base UNION ALL

 SELECT 'select ''主键'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "id" || '''') || ' from dual
union all
select ''土地成本'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_cost" || '''') || ' from dual
union all
select ''其中：土地出让金（或土地收购价）'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_transfer_fee" || '''') || ' from dual
union all
select ''其中：补交地价款'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_payment" || '''') || ' from dual
union all
select ''其中：大市政配套费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_municipal_support" || '''') || ' from dual
union all
select ''其中：契税'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_deed_tax" || '''') || ' from dual
union all
select ''其中：拆迁补偿费、土地熟化费用'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_compensation" || '''') || ' from dual
union all
select ''其中：其他'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_land_other" || '''') || ' from dual
union all
select ''政策性收费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_policy_charge" || '''') || ' from dual
union all
select ''前期工程费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_proj_costs" || '''') || ' from dual
union all
select ''基础设施费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_facil_fee" || '''') || ' from dual
union all
select ''园林绿化道路'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "kf_landscap_road" || '''') || ' from dual
union all
select ''建安工程费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_proj_costs" || '''') || ' from dual
union all
select ''其中：基础工程'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_basic_proj" || '''') || ' from dual
union all
select ''其中：地下结构'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_underground_structure" || '''') || ' from dual
union all
select ''其中：地上结构'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_ontheground_structure" || '''') || ' from dual
union all
select ''其中：外装'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_exterior" || '''') || ' from dual
union all
select ''其中：初装修'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_initial_decoration" || '''') || ' from dual
union all
select ''其中：公区精装修'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_public_exquisite" || '''') || ' from dual
union all
select ''其中：户内精装修'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_indoor_exquisite" || '''') || ' from dual
union all
select ''其中：给排水'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_drainage" || '''') || ' from dual
union all
select ''其中：强电'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_strong_current" || '''') || ' from dual
union all
select ''其中：采暖'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_heating" || '''') || ' from dual
union all
select ''其中：通风空调'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_airiness" || '''') || ' from dual
union all
select ''其中：消防'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_fire_control" || '''') || ' from dual
union all
select ''其中：电梯'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_elevator" || '''') || ' from dual
union all
select ''其中：弱电及智能化'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_weak_current" || '''') || ' from dual
union all
select ''其中：其他'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "ja_other" || '''') || ' from dual
union all
select ''公共配套建设费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "pc_support_construct_fee" || '''') || ' from dual
union all
select ''开发间接费'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "pc_development_overhead" || '''') || ' from dual
union all
select ''其中：物业补贴'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "pc_property_subsidy" || '''') || ' from dual
union all
select ''其中：品质提升基金、科研费用'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "pc_resear_expenses" || '''') || ' from dual
union all
select ''其中：其他'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "pc_other" || '''') || ' from dual
union all
select ''销售费用'' object_name,''期间费用'' object_name1,'|| wm_concat ('''' || "sa_sales_expense" || '''') || ' from dual
union all
select ''管理费用'' object_name,''期间费用'' object_name1,'|| wm_concat ('''' || "sa_manage_expense" || '''') || ' from dual
union all
select ''财务费用'' object_name,''期间费用'' object_name1,'|| wm_concat ('''' || "sa_finance_expense" || '''') || ' from dual
union all
select ''其中：资本化利息'' object_name,''期间费用'' object_name1,'|| wm_concat ('''' || "sa_capitali_interest" || '''') || ' from dual
union all
select ''其中：费用化利息'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "sa_expensed_interest" || '''') || ' from dual
union all
select ''其中：其他'' object_name,''开发成本'' object_name1,'|| wm_concat ('''' || "sa_other" || '''') || ' from dual
union all
select ''增值税'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_the_tax" || '''') || ' from dual
union all
select ''城市维护建设税、教育费附加及地方教育费附加'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_urban_construc_tax" || '''') || ' from dual
union all
select ''土地增值税（预缴）'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_advance" || '''') || ' from dual
union all
select ''土地增值税（清算后补缴）'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_payment" || '''') || ' from dual
union all
select ''土地使用税'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_land_use_tax" || '''') || ' from dual
union all
select ''印花税（含土地印花等）'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_stamp_duty" || '''') || ' from dual
union all
select ''其他'' object_name,''税金及附加'' object_name1,'|| wm_concat ('''' || "ld_other" || '''') || ' from dual
union all
select ''总投资（所得税前成本）'' object_name,''合计'' object_name1,'|| wm_concat ('''' || "total_investment" || '''') || ' from dual
union all
select ''其中：可控成本（所得税前成本-税金及附加-土地出让金-补交地价款-契税）'' object_name,'''' object_name1,'|| wm_concat ('''' || "controllable_costs" || '''') || ' from dual
' into v_sql_exec FROM 
(
(SELECT
    id as "id", ---
    plan_year as "plan_year", ---计划年份
    parent_id as "parent_id", ---父级ID
    level_code as "level_code", ---层级：1开始
    order_code as "order_code", ---顺序
    object_id as "object_id", ---对象ID
    object_name as "object_name", ---对象名称
    object_type as "object_type", ---对象类别
    object_level_name_one as "object_level_name_one",  
    object_level_name_one as "object_level_name_two",  
    nvl(fma_kf_land_cost, kf_land_cost) AS "kf_land_cost", ---土地成本
    nvl(fma_kf_land_transfer_fee, kf_land_transfer_fee) AS "kf_land_transfer_fee", ---其中：土地出让金（或土地收购价）
    nvl(fma_kf_land_payment, kf_land_payment) AS "kf_land_payment", ---其中：补交地价款
    nvl(fma_kf_land_municipal_support, kf_land_municipal_support) AS "kf_land_municipal_support", ---其中：大市政配套费
    nvl(fma_kf_land_deed_tax, kf_land_deed_tax) AS "kf_land_deed_tax", ---其中：契税
    nvl(fma_kf_land_compensation, kf_land_compensation) AS "kf_land_compensation", ---其中：拆迁补偿费、土地熟化费用
    nvl(fma_kf_land_other, kf_land_other) AS "kf_land_other", ---其中：其他
    nvl(fma_kf_policy_charge, kf_policy_charge) AS "kf_policy_charge", ---政策性收费
    nvl(fma_kf_proj_costs, kf_proj_costs) AS "kf_proj_costs", ---前期工程费
    nvl(fma_kf_facil_fee, kf_facil_fee) AS "kf_facil_fee", ---基础设施费
    nvl(fma_kf_landscap_road, kf_landscap_road) AS "kf_landscap_road", ---园林绿化道路
    nvl(fma_ja_proj_costs, ja_proj_costs) AS "ja_proj_costs", ---建安工程费
    nvl(fma_ja_basic_proj, ja_basic_proj) AS "ja_basic_proj", ---其中：基础工程
    nvl(fma_ja_underground_structure, ja_underground_structure) AS "ja_underground_structure", ---其中：地下结构
    nvl(fma_ja_ontheground_structure, ja_ontheground_structure) AS "ja_ontheground_structure", ---其中：地上结构
    nvl(fma_ja_exterior, ja_exterior) AS "ja_exterior", ---其中：外装
    nvl(fma_ja_initial_decoration, ja_initial_decoration) AS "ja_initial_decoration", ---其中：初装修
    nvl(fma_ja_public_exquisite, ja_public_exquisite) AS "ja_public_exquisite", ---其中：公区精装修
    nvl(fma_ja_indoor_exquisite, ja_indoor_exquisite) AS "ja_indoor_exquisite", ---其中：户内精装修
    nvl(fma_ja_drainage, ja_drainage) AS "ja_drainage", ---其中：给排水
    nvl(fma_ja_strong_current, ja_strong_current) AS "ja_strong_current", ---其中：强电
    nvl(fma_ja_heating, ja_heating) AS "ja_heating", ---其中：采暖
    nvl(fma_ja_airiness, ja_airiness) AS "ja_airiness", ---其中：通风空调
    nvl(fma_ja_fire_control, ja_fire_control) AS "ja_fire_control", ---其中：消防
    nvl(fma_ja_elevator, ja_elevator) AS "ja_elevator", ---其中：电梯
    nvl(fma_ja_weak_current, ja_weak_current) AS "ja_weak_current", ---其中：弱电及智能化
    nvl(fma_ja_other, ja_other) AS "ja_other", ---其中：其他
    nvl(fma_pc_support_construct_fee, pc_support_construct_fee) AS "pc_support_construct_fee", ---公共配套建设费
    nvl(fma_pc_development_overhead, pc_development_overhead) AS "pc_development_overhead", ---开发间接费
    nvl(fma_pc_property_subsidy, pc_property_subsidy) AS "pc_property_subsidy", ---其中：物业补贴
    nvl(fma_pc_resear_expenses, pc_resear_expenses) AS "pc_resear_expenses", ---其中：品质提升基金、科研费用
    nvl(fma_pc_other, pc_other) AS "pc_other", ---其中：其他
    nvl(fma_sa_sales_expense, sa_sales_expense) AS "sa_sales_expense", ---销售费用
    nvl(fma_sa_manage_expense, sa_manage_expense) AS "sa_manage_expense", ---管理费用
    nvl(fma_sa_finance_expense, sa_finance_expense) AS "sa_finance_expense", ---财务费用
    nvl(fma_sa_capitali_interest, sa_capitali_interest) AS "sa_capitali_interest", ---其中：资本化利息
    nvl(fma_sa_expensed_interest, sa_expensed_interest) AS "sa_expensed_interest", ---其中：费用化利息
    nvl(fma_sa_other, sa_other) AS "sa_other", ---其中：其他
    nvl(fma_ld_the_tax, ld_the_tax) AS "ld_the_tax", ---增值税
    nvl(fma_ld_urban_construc_tax, ld_urban_construc_tax) AS "ld_urban_construc_tax", ---城市维护建设税、教育费附加及地方教育费附加
    nvl(fma_ld_advance, ld_advance) AS "ld_advance", ---土地增值税（预缴）
    nvl(fma_ld_payment, ld_payment) AS "ld_payment", ---土地增值税（清算后补缴）
    nvl(fma_ld_land_use_tax, ld_land_use_tax) AS "ld_land_use_tax", ---土地使用税
    nvl(fma_ld_stamp_duty, ld_stamp_duty) AS "ld_stamp_duty", ---印花税（含土地印花等）
    nvl(fma_ld_other, ld_other) AS "ld_other", ---其他
    nvl(fma_total_investment, total_investment) AS "total_investment", ---总投资（所得税前成本）
    nvl(fma_controllable_costs, controllable_costs) AS "controllable_costs" ---其中：可控成本（所得税前成本-税金及附加-土地出让金-补交地价款-契税）
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
   OPEN projsheet2 FOR  select '失败请,联系管理员查看,【投资计划表（'||projectid||'）】'||planyear||'年是否存初始数据' as  object_name from dual;

END P_OPM_ED_PROJ_INVESTMENT;


 --   SELECT wm_concat(t."id"),wm_concat(t."object_type") FROM base t