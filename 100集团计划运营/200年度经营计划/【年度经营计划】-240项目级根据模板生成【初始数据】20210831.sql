----- select * from opm_PROJ_cash order by plan_year,lpad( order_code, 10, '0' ); delete from opm_PROJ_cash
create or replace PROCEDURE "P_OPM_INIT_PROJ_BUDGET" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】---现金流
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------现金流
--删除该年；
DELETE FROM OPM_PROJ_BUDGET WHERE (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;
--根据模板初始化该年
INSERT INTO opm_proj_budget (id,plan_year,order_code,object_main_name,object_sub_name,belong_proj_id,previous_total,tosep_budget_total,todec_budget_total,last_declaration_total,last_cumulative_amount,plan_amount,cumulative_amount,remark,created,creator_id,creator,modified,modifier_id,modifier,fma_previous_total,fma_tosep_budget_total,fma_todec_budget_total,fma_last_declaration_total,fma_last_cumulative_amount,fma_plan_amount,fma_cumulative_amount,object_type,object_id)
SELECT sys_guid (),planyear,order_code,object_main_name,object_sub_name,belong_proj_id,previous_total,tosep_budget_total,todec_budget_total,last_declaration_total,last_cumulative_amount,plan_amount,cumulative_amount,remark,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_previous_total,fma_tosep_budget_total,fma_todec_budget_total,fma_last_declaration_total,fma_last_cumulative_amount,fma_plan_amount,fma_cumulative_amount,object_type,id 
FROM  OPM_T_PROJ_BUDGET  WHERE BELONG_PROJ_ID=regionOrgId or 1=init_all;
-----------------------------------现金流
END P_OPM_INIT_PROJ_BUDGET;
/
----- select * from opm_PROJ_cash order by plan_year,lpad( order_code, 10, '0' ); delete from opm_PROJ_cash
CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ_INVENTORY" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】---供销存
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------供销存
--删除该年；
DELETE FROM OPM_PROJ_INVENTORY_PLAN WHERE (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;
INSERT INTO opm_proj_inventory_plan (id,plan_year,parent_id,level_code,order_code,belong_proj_id,object_id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,created,creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,belong_proj_id,id,object_name,object_type,saleable_area,saleable_number,saleable_amount,saleable_price,tired_sale_area,tired_sale_number,tired_sale_amount,tired_sale_price,tired_complete_area,tired_complete_number,tired_complete_amount,tired_complete_price,stock_area,stock_number,stock_amount,stock_price,sale_area,sale_sleeve,sale_amount,sale_price,supply_area,supply_sleeve,supply_amount,supply_price,sales_area,sales_sleeve,sales_amount,sales_price,jan_supply_area,jan_supply_sleeve,jan_supply_amount,jan_sales_area,jan_sales_sleeve,jan_sales_amount,feb_supply_area,feb_supply_sleeve,feb_supply_amount,feb_sales_area,feb_sales_sleeve,feb_sales_amount,mar_supply_area,mar_supply_sleeve,mar_supply_amount,mar_sales_area,mar_sales_sleeve,mar_sales_amount,apr_supply_area,apr_supply_sleeve,apr_supply_amount,apr_sales_area,apr_sales_sleeve,apr_sales_amount,may_supply_area,may_supply_sleeve,may_supply_amount,may_sales_area,may_sales_sleeve,may_sales_amount,june_supply_area,june_supply_sleeve,june_supply_amount,june_sales_area,june_sales_sleeve,june_sales_amount,july_supply_area,july_supply_sleeve,july_supply_amount,july_sales_area,july_sales_sleeve,july_sales_amount,aug_supply_area,aug_supply_sleeve,aug_supply_amount,aug_sales_area,aug_sales_sleeve,aug_sales_amount,sep_supply_area,sep_supply_sleeve,sep_supply_amount,sep_sales_area,sep_sales_sleeve,sep_sales_amount,oct_supply_area,oct_supply_sleeve,oct_supply_amount,oct_sales_area,oct_sales_sleeve,oct_sales_amount,nov_supply_area,nov_supply_sleeve,nov_supply_amount,nov_sales_area,nov_sales_sleeve,nov_sales_amount,dec_supply_area,dec_supply_sleeve,dec_supply_amount,dec_sales_area,dec_sales_sleeve,dec_sales_amount,supply_one_amount,supply_one_ratio,supply_two_amount,supply_two_ratio,supply_three_amount,supply_three_ratio,supply_four_amount,supply_four_ratio,sales_one_amount,sales_one_ratio,sales_two_amount,sales_two_ratio,sales_three_amount,sales_three_ratio,sales_four_amount,sales_four_ratio,desalination_rate,ny_first_supply_area,ny_first_supply_number,ny_first_supply_amount,ny_first_sale_area,ny_first_sale_number,ny_first_sale_amount,ny_second_supply_area,ny_second_supply_number,ny_second_supply_amount,ny_second_sale_area,ny_second_sale_number,ny_second_sale_amount,ny_third_supply_area,ny_third_supply_number,ny_third_supply_amount,ny_third_sale_area,ny_third_sale_number,ny_third_sale_amount,ny_fourth_supply_area,ny_fourth_supply_number,ny_fourth_supply_amount,ny_fourth_sale_area,ny_fourth_sale_number,ny_fourth_sale_amount,ncy_first_supply_area,ncy_first_supply_number,ncy_first_supply_amount,ncy_first_sale_area,ncy_first_sale_number,ncy_first_sale_amount,ncy_second_supply_area,ncy_second_supply_number,ncy_second_supply_amount,ncy_second_sale_area,ncy_second_sale_number,ncy_second_sale_amount,ncy_third_supply_area,ncy_third_supply_number,ncy_third_supply_amount,ncy_third_sale_area,ncy_third_sale_number,ncy_third_sale_amount,ncy_fourth_supply_area,ncy_fourth_supply_number,ncy_fourth_supply_amount,ncy_fourth_sale_area,ncy_fourth_sale_number,ncy_fourth_sale_amount,nty_first_supply_area,nty_first_supply_number,nty_first_supply_amount,nty_first_sale_area,nty_first_sale_number,nty_first_sale_amount,nty_second_supply_area,nty_second_supply_number,nty_second_supply_amount,nty_second_sale_area,nty_second_sale_number,nty_second_sale_amount,nty_third_supply_area,nty_third_supply_number,nty_third_supply_amount,nty_third_sale_area,nty_third_sale_number,nty_third_sale_amount,nty_fourth_supply_area,nty_fourth_supply_number,nty_fourth_supply_amount,nty_fourth_sale_area,nty_fourth_sale_number,nty_fourth_sale_amount,nfy_first_supply_area,nfy_first_supply_number,nfy_first_supply_amount,nfy_first_sale_area,nfy_first_sale_number,nfy_first_sale_amount,nfy_second_supply_area,nfy_second_supply_number,nfy_second_supply_amount,nfy_second_sale_area,nfy_second_sale_number,nfy_second_sale_amount,nfy_third_supply_area,nfy_third_supply_number,nfy_third_supply_amount,nfy_third_sale_area,nfy_third_sale_number,nfy_third_sale_amount,nfy_fourth_supply_area,nfy_fourth_supply_number,nfy_fourth_supply_amount,nfy_fourth_sale_area,nfy_fourth_sale_number,nfy_fourth_sale_amount,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_saleable_area,fma_saleable_number,fma_saleable_amount,fma_saleable_price,fma_tired_sale_area,fma_tired_sale_number,fma_tired_sale_amount,fma_tired_sale_price,fma_tired_complete_area,fma_tired_complete_number,fma_tired_complete_amount,fma_tired_complete_price,fma_stock_area,fma_stock_number,fma_stock_amount,fma_stock_price,fma_sale_area,fma_sale_sleeve,fma_sale_amount,fma_sale_price,fma_supply_area,fma_supply_sleeve,fma_supply_amount,fma_supply_price,fma_sales_area,fma_sales_sleeve,fma_sales_amount,fma_sales_price,fma_jan_supply_area,fma_jan_supply_sleeve,fma_jan_supply_amount,fma_jan_sales_area,fma_jan_sales_sleeve,fma_jan_sales_amount,fma_feb_supply_area,fma_feb_supply_sleeve,fma_feb_supply_amount,fma_feb_sales_area,fma_feb_sales_sleeve,fma_feb_sales_amount,fma_mar_supply_area,fma_mar_supply_sleeve,fma_mar_supply_amount,fma_mar_sales_area,fma_mar_sales_sleeve,fma_mar_sales_amount,fma_apr_supply_area,fma_apr_supply_sleeve,fma_apr_supply_amount,fma_apr_sales_area,fma_apr_sales_sleeve,fma_apr_sales_amount,fma_may_supply_area,fma_may_supply_sleeve,fma_may_supply_amount,fma_may_sales_area,fma_may_sales_sleeve,fma_may_sales_amount,fma_june_supply_area,fma_june_supply_sleeve,fma_june_supply_amount,fma_june_sales_area,fma_june_sales_sleeve,fma_june_sales_amount,fma_july_supply_area,fma_july_supply_sleeve,fma_july_supply_amount,fma_july_sales_area,fma_july_sales_sleeve,fma_july_sales_amount,fma_aug_supply_area,fma_aug_supply_sleeve,fma_aug_supply_amount,fma_aug_sales_area,fma_aug_sales_sleeve,fma_aug_sales_amount,fma_sep_supply_area,fma_sep_supply_sleeve,fma_sep_supply_amount,fma_sep_sales_area,fma_sep_sales_sleeve,fma_sep_sales_amount,fma_oct_supply_area,fma_oct_supply_sleeve,fma_oct_supply_amount,fma_oct_sales_area,fma_oct_sales_sleeve,fma_oct_sales_amount,fma_nov_supply_area,fma_nov_supply_sleeve,fma_nov_supply_amount,fma_nov_sales_area,fma_nov_sales_sleeve,fma_nov_sales_amount,fma_dec_supply_area,fma_dec_supply_sleeve,fma_dec_supply_amount,fma_dec_sales_area,fma_dec_sales_sleeve,fma_dec_sales_amount,fma_supply_one_amount,fma_supply_one_ratio,fma_supply_two_amount,fma_supply_two_ratio,fma_supply_three_amount,fma_supply_three_ratio,fma_supply_four_amount,fma_supply_four_ratio,fma_sales_one_amount,fma_sales_one_ratio,fma_sales_two_amount,fma_sales_two_ratio,fma_sales_three_amount,fma_sales_three_ratio,fma_sales_four_amount,fma_sales_four_ratio,fma_desalination_rate,fma_ny_first_supply_area,fma_ny_first_supply_number,fma_ny_first_supply_amount,fma_ny_first_sale_area,fma_ny_first_sale_number,fma_ny_first_sale_amount,fma_ny_second_supply_area,fma_ny_second_supply_number,fma_ny_second_supply_amount,fma_ny_second_sale_area,fma_ny_second_sale_number,fma_ny_second_sale_amount,fma_ny_third_supply_area,fma_ny_third_supply_number,fma_ny_third_supply_amount,fma_ny_third_sale_area,fma_ny_third_sale_number,fma_ny_third_sale_amount,fma_ny_fourth_supply_area,fma_ny_fourth_supply_number,fma_ny_fourth_supply_amount,fma_ny_fourth_sale_area,fma_ny_fourth_sale_number,fma_ny_fourth_sale_amount,fma_ncy_first_supply_area,fma_ncy_first_supply_number,fma_ncy_first_supply_amount,fma_ncy_first_sale_area,fma_ncy_first_sale_number,fma_ncy_first_sale_amount,fma_ncy_second_supply_area,fma_ncy_second_supply_number,fma_ncy_second_supply_amount,fma_ncy_second_sale_area,fma_ncy_second_sale_number,fma_ncy_second_sale_amount,fma_ncy_third_supply_area,fma_ncy_third_supply_number,fma_ncy_third_supply_amount,fma_ncy_third_sale_area,fma_ncy_third_sale_number,fma_ncy_third_sale_amount,fma_ncy_fourth_supply_area,fma_ncy_fourth_supply_number,fma_ncy_fourth_supply_amount,fma_ncy_fourth_sale_area,fma_ncy_fourth_sale_number,fma_ncy_fourth_sale_amount,fma_nty_first_supply_area,fma_nty_first_supply_number,fma_nty_first_supply_amount,fma_nty_first_sale_area,fma_nty_first_sale_number,fma_nty_first_sale_amount,fma_nty_second_supply_area,fma_nty_second_supply_number,fma_nty_second_supply_amount,fma_nty_second_sale_area,fma_nty_second_sale_number,fma_nty_second_sale_amount,fma_nty_third_supply_area,fma_nty_third_supply_number,fma_nty_third_supply_amount,fma_nty_third_sale_area,fma_nty_third_sale_number,fma_nty_third_sale_amount,fma_nty_fourth_supply_area,fma_nty_fourth_supply_number,fma_nty_fourth_supply_amount,fma_nty_fourth_sale_area,fma_nty_fourth_sale_number,fma_nty_fourth_sale_amount,fma_nfy_first_supply_area,fma_nfy_first_supply_number,fma_nfy_first_supply_amount,fma_nfy_first_sale_area,fma_nfy_first_sale_number,fma_nfy_first_sale_amount,fma_nfy_second_supply_area,fma_nfy_second_supply_number,fma_nfy_second_supply_amount,fma_nfy_second_sale_area,fma_nfy_second_sale_number,fma_nfy_second_sale_amount,fma_nfy_third_supply_area,fma_nfy_third_supply_number,fma_nfy_third_supply_amount,fma_nfy_third_sale_area,fma_nfy_third_sale_number,fma_nfy_third_sale_amount,fma_nfy_fourth_supply_area,fma_nfy_fourth_supply_number,fma_nfy_fourth_supply_amount,fma_nfy_fourth_sale_area,fma_nfy_fourth_sale_number,fma_nfy_fourth_sale_amount 
FROM  opm_t_PROJ_inventory_plan WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------供销存
END P_OPM_INIT_PROJ_INVENTORY;

/
----- select * from opm_PROJ_cash order by plan_year,lpad( order_code, 10, '0' ); delete from opm_PROJ_cash
create or replace PROCEDURE "P_OPM_INIT_PROJ_INVESTMENT" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------经营计划
--删除该年；
DELETE FROM OPM_PROJ_INVENTORY_PLAN WHERE  (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;

INSERT INTO opm_proj_investment_plan (id,plan_year,parent_id,level_code,order_code,object_id,object_name,object_type,kf_land_cost,kf_land_transfer_fee,kf_land_payment,kf_land_municipal_support,kf_land_deed_tax,kf_land_compensation,kf_land_other,kf_policy_charge,kf_proj_costs,kf_facil_fee,kf_landscap_road,ja_proj_costs,ja_basic_proj,ja_underground_structure,ja_ontheground_structure,ja_exterior,ja_initial_decoration,ja_public_exquisite,ja_indoor_exquisite,ja_drainage,ja_strong_current,ja_heating,ja_airiness,ja_fire_control,ja_elevator,ja_weak_current,ja_other,pc_support_construct_fee,pc_development_overhead,pc_property_subsidy,pc_resear_expenses,pc_other,sa_sales_expense,sa_manage_expense,sa_finance_expense,sa_capitali_interest,sa_expensed_interest,sa_other,ld_the_tax,ld_urban_construc_tax,ld_advance,ld_payment,ld_land_use_tax,ld_stamp_duty,ld_other,total_investment,controllable_costs,fma_kf_land_cost,fma_kf_land_transfer_fee,fma_kf_land_payment,fma_kf_land_municipal_support,fma_kf_land_deed_tax,fma_kf_land_compensation,fma_kf_land_other,fma_kf_policy_charge,fma_kf_proj_costs,fma_kf_facil_fee,fma_kf_landscap_road,fma_ja_proj_costs,fma_ja_basic_proj,fma_ja_underground_structure,fma_ja_ontheground_structure,fma_ja_exterior,fma_ja_initial_decoration,fma_ja_public_exquisite,fma_ja_indoor_exquisite,fma_ja_drainage,fma_ja_strong_current,fma_ja_heating,fma_ja_airiness,fma_ja_fire_control,fma_ja_elevator,fma_ja_weak_current,fma_ja_other,fma_pc_support_construct_fee,fma_pc_development_overhead,fma_pc_property_subsidy,fma_pc_resear_expenses,fma_pc_other,fma_sa_sales_expense,fma_sa_manage_expense,fma_sa_finance_expense,fma_sa_capitali_interest,fma_sa_expensed_interest,fma_sa_other,fma_ld_the_tax,fma_ld_urban_construc_tax,fma_ld_advance,fma_ld_payment,fma_ld_land_use_tax,fma_ld_stamp_duty,fma_ld_other,fma_total_investment,fma_controllable_costs,created,creator_id,creator,modified,modifier_id,modifier,belong_proj_id)
SELECT sys_guid (),planyear,parent_id,level_code,order_code,id,object_name,object_type,kf_land_cost,kf_land_transfer_fee,kf_land_payment,kf_land_municipal_support,kf_land_deed_tax,kf_land_compensation,kf_land_other,kf_policy_charge,kf_proj_costs,kf_facil_fee,kf_landscap_road,ja_proj_costs,ja_basic_proj,ja_underground_structure,ja_ontheground_structure,ja_exterior,ja_initial_decoration,ja_public_exquisite,ja_indoor_exquisite,ja_drainage,ja_strong_current,ja_heating,ja_airiness,ja_fire_control,ja_elevator,ja_weak_current,ja_other,pc_support_construct_fee,pc_development_overhead,pc_property_subsidy,pc_resear_expenses,pc_other,sa_sales_expense,sa_manage_expense,sa_finance_expense,sa_capitali_interest,sa_expensed_interest,sa_other,ld_the_tax,ld_urban_construc_tax,ld_advance,ld_payment,ld_land_use_tax,ld_stamp_duty,ld_other,total_investment,controllable_costs,fma_kf_land_cost,fma_kf_land_transfer_fee,fma_kf_land_payment,fma_kf_land_municipal_support,fma_kf_land_deed_tax,fma_kf_land_compensation,fma_kf_land_other,fma_kf_policy_charge,fma_kf_proj_costs,fma_kf_facil_fee,fma_kf_landscap_road,fma_ja_proj_costs,fma_ja_basic_proj,fma_ja_underground_structure,fma_ja_ontheground_structure,fma_ja_exterior,fma_ja_initial_decoration,fma_ja_public_exquisite,fma_ja_indoor_exquisite,fma_ja_drainage,fma_ja_strong_current,fma_ja_heating,fma_ja_airiness,fma_ja_fire_control,fma_ja_elevator,fma_ja_weak_current,fma_ja_other,fma_pc_support_construct_fee,fma_pc_development_overhead,fma_pc_property_subsidy,fma_pc_resear_expenses,fma_pc_other,fma_sa_sales_expense,fma_sa_manage_expense,fma_sa_finance_expense,fma_sa_capitali_interest,fma_sa_expensed_interest,fma_sa_other,fma_ld_the_tax,fma_ld_urban_construc_tax,fma_ld_advance,fma_ld_payment,fma_ld_land_use_tax,fma_ld_stamp_duty,fma_ld_other,fma_total_investment,fma_controllable_costs,sysdate(),creator_id,creator,modified,modifier_id,modifier,belong_proj_id
FROM  OPM_T_PROJ_INVESTMENT_PLAN  WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------经营计划
END P_OPM_INIT_PROJ_INVESTMENT;

/
create or replace PROCEDURE "P_OPM_INIT_PROJ_OPERATING" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】--经营计划
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
--是否引入全部模板
init_all   VARCHAR2(500):=(case when regionOrgId is null or regionOrgId='' then 1 else 0 end); 
BEGIN 
-----------------------------------经营计划
--删除该年；
DELETE FROM opm_proj_operating_index WHERE  (BELONG_PROJ_ID=regionOrgId or 1=init_all) and plan_year=planyear ;

INSERT INTO opm_proj_operating_index (id,plan_year,order_code,object_staging,object_type,belong_proj_id,delivery_date,construction_area_total,value_total,saleable_area_total,operating_income_total,profit_total,expect_total,last_started_area,last_completed_area,last_sales_amount,last_sales_area,last_sales_collection,last_unpaid_collection,last_operating_income,last_carryover_area,last_total_profit,last_net_profit,tosep_started_area,tosep_completed_area,tosep_sales_amount,tosep_sales_area,tosep_sales_collection,tosep_operating_income,tosep_carryover_area,tosep_total_profit,tosep_net_profit,todec_started_area,todec_completed_area,todec_sales_amount,todec_sales_area,todec_sales_collection,todec_operating_income,todec_carryover_area,todec_total_profit,todec_net_profit,started_area_total,completed_area_total,sales_amount_total,sales_area_total,sales_collection_total,expect_income_total,carryover_area_total,total_profit_total,net_profit_total,tired_started_area,tired_completed_area,tired_sales_amount,tired_sales_area,tired_sales_collection,tired_unpaid_collection,tired_operating_income,tired_carryover_area,tired_total_profit,tired_net_profit,ntstarted_area,ntcompleted_area,ntsales_amount,ntsales_area,ntunpaid_collection,ntsales_collection,ntcollection_total,ntoperating_income,ntcarryover_area,nttotal_profit,ntnet_profit,nttired_started_area,nttired_completed_area,nt_tired_sales_amount,ntired_sales_area,nttired_sales_collection,nttired_unpaid_collection,nttired_operating_income,nttired_carryover_area,nttired_total_profit,nttired_net_profit,tomar_release_revenue,tomar_release_profit,toapr_release_revenue,toapr_release_profit,remark,created,creator_id,creator,modified,modifier_id,modifier,fma_delivery_date,fma_construction_area_total,fma_value_total,fma_saleable_area_total,fma_operating_income_total,fma_profit_total,fma_expect_total,fma_last_started_area,fma_last_completed_area,fma_last_sales_amount,fma_last_sales_area,fma_last_sales_collection,fma_last_unpaid_collection,fma_last_operating_income,fma_last_carryover_area,fma_last_total_profit,fma_last_net_profit,fma_tosep_started_area,fma_tosep_completed_area,fma_tosep_sales_amount,fma_tosep_sales_area,fma_tosep_sales_collection,fma_tosep_operating_income,fma_tosep_carryover_area,fma_tosep_total_profit,fma_tosep_net_profit,fma_todec_started_area,fma_todec_completed_area,fma_todec_sales_amount,fma_todec_sales_area,fma_todec_sales_collection,fma_todec_operating_income,fma_todec_carryover_area,fma_todec_total_profit,fma_todec_net_profit,fma_started_area_total,fma_completed_area_total,fma_sales_amount_total,fma_sales_area_total,fma_sales_collection_total,fma_expect_income_total,fma_carryover_area_total,fma_total_profit_total,fma_net_profit_total,fma_tired_started_area,fma_tired_completed_area,fma_tired_sales_amount,fma_tired_sales_area,fma_tired_sales_collection,fma_tired_unpaid_collection,fma_tired_operating_income,fma_tired_carryover_area,fma_tired_total_profit,fma_tired_net_profit,fma_ntstarted_area,fma_ntcompleted_area,fma_ntsales_amount,fma_ntsales_area,fma_ntunpaid_collection,fma_ntsales_collection,fma_ntcollection_total,fma_ntoperating_income,fma_ntcarryover_area,fma_nttotal_profit,fma_ntnet_profit,fma_nttired_started_area,fma_nttired_completed_area,fma_nt_tired_sales_amount,fma_ntired_sales_area,fma_nttired_sales_collection,fma_nttired_unpaid_collection,fma_nttired_operating_income,fma_nttired_carryover_area,fma_nttired_total_profit,fma_nttired_net_profit,fma_tomar_release_revenue,fma_tomar_release_profit,fma_toapr_release_revenue,fma_toapr_release_profit,object_id)
SELECT sys_guid (),planyear,order_code,object_staging,object_type,belong_proj_id,delivery_date,construction_area_total,value_total,saleable_area_total,operating_income_total,profit_total,expect_total,last_started_area,last_completed_area,last_sales_amount,last_sales_area,last_sales_collection,last_unpaid_collection,last_operating_income,last_carryover_area,last_total_profit,last_net_profit,tosep_started_area,tosep_completed_area,tosep_sales_amount,tosep_sales_area,tosep_sales_collection,tosep_operating_income,tosep_carryover_area,tosep_total_profit,tosep_net_profit,todec_started_area,todec_completed_area,todec_sales_amount,todec_sales_area,todec_sales_collection,todec_operating_income,todec_carryover_area,todec_total_profit,todec_net_profit,started_area_total,completed_area_total,sales_amount_total,sales_area_total,sales_collection_total,expect_income_total,carryover_area_total,total_profit_total,net_profit_total,tired_started_area,tired_completed_area,tired_sales_amount,tired_sales_area,tired_sales_collection,tired_unpaid_collection,tired_operating_income,tired_carryover_area,tired_total_profit,tired_net_profit,ntstarted_area,ntcompleted_area,ntsales_amount,ntsales_area,ntunpaid_collection,ntsales_collection,ntcollection_total,ntoperating_income,ntcarryover_area,nttotal_profit,ntnet_profit,nttired_started_area,nttired_completed_area,nt_tired_sales_amount,ntired_sales_area,nttired_sales_collection,nttired_unpaid_collection,nttired_operating_income,nttired_carryover_area,nttired_total_profit,nttired_net_profit,tomar_release_revenue,tomar_release_profit,toapr_release_revenue,toapr_release_profit,remark,sysdate(),creator_id,creator,modified,modifier_id,modifier,fma_delivery_date,fma_construction_area_total,fma_value_total,fma_saleable_area_total,fma_operating_income_total,fma_profit_total,fma_expect_total,fma_last_started_area,fma_last_completed_area,fma_last_sales_amount,fma_last_sales_area,fma_last_sales_collection,fma_last_unpaid_collection,fma_last_operating_income,fma_last_carryover_area,fma_last_total_profit,fma_last_net_profit,fma_tosep_started_area,fma_tosep_completed_area,fma_tosep_sales_amount,fma_tosep_sales_area,fma_tosep_sales_collection,fma_tosep_operating_income,fma_tosep_carryover_area,fma_tosep_total_profit,fma_tosep_net_profit,fma_todec_started_area,fma_todec_completed_area,fma_todec_sales_amount,fma_todec_sales_area,fma_todec_sales_collection,fma_todec_operating_income,fma_todec_carryover_area,fma_todec_total_profit,fma_todec_net_profit,fma_started_area_total,fma_completed_area_total,fma_sales_amount_total,fma_sales_area_total,fma_sales_collection_total,fma_expect_income_total,fma_carryover_area_total,fma_total_profit_total,fma_net_profit_total,fma_tired_started_area,fma_tired_completed_area,fma_tired_sales_amount,fma_tired_sales_area,fma_tired_sales_collection,fma_tired_unpaid_collection,fma_tired_operating_income,fma_tired_carryover_area,fma_tired_total_profit,fma_tired_net_profit,fma_ntstarted_area,fma_ntcompleted_area,fma_ntsales_amount,fma_ntsales_area,fma_ntunpaid_collection,fma_ntsales_collection,fma_ntcollection_total,fma_ntoperating_income,fma_ntcarryover_area,fma_nttotal_profit,fma_ntnet_profit,fma_nttired_started_area,fma_nttired_completed_area,fma_nt_tired_sales_amount,fma_ntired_sales_area,fma_nttired_sales_collection,fma_nttired_unpaid_collection,fma_nttired_operating_income,fma_nttired_carryover_area,fma_nttired_total_profit,fma_nttired_net_profit,fma_tomar_release_revenue,fma_tomar_release_profit,fma_toapr_release_revenue,fma_toapr_release_profit,id 
FROM  opm_t_proj_operating_index  WHERE  BELONG_PROJ_ID=regionOrgId or 1=init_all ;
-----------------------------------经营计划
END P_OPM_INIT_PROJ_OPERATING;
/
CREATE OR REPLACE PROCEDURE "P_OPM_INIT_PROJ" (planyear IN number--计划年
,regionOrgId IN VARCHAR2--项目id
) AS-- 根据模板初始化年度【项目级数据】
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
-----------------------------------现金流
  begin
  P_OPM_INIT_PROJ_BUDGET(
    PLANYEAR => PLANYEAR
    ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------供销存
  begin
  P_OPM_INIT_PROJ_INVENTORY(
    PLANYEAR => PLANYEAR
     ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------
-----------------------------------经营计划
  begin
   P_OPM_INIT_PROJ_OPERATING(
    PLANYEAR => PLANYEAR
     ,regionOrgId=>regionOrgId
  );
  end;
-----------------------------------
END P_OPM_INIT_PROJ;


