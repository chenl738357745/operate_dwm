----- select * from opm_group_cash order by plan_year,lpad( order_code, 10, '0' ); delete from opm_group_cash
CREATE OR REPLACE PROCEDURE "P_OPM_INITIAL_GROUP" (planyear IN number--计划年
) AS-- 根据模板初始化年度集团级数据
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
--删除该年；
DELETE FROM opm_group_cash WHERE plan_year=planyear;
--根据模板初始化该年
INSERT INTO opm_group_cash (id,plan_year,parent_id,object_id,object_name,object_type,order_code,level_code,fma_cash_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_remaining_amount,fma_available_funds)
SELECT sys_guid (),planyear,parent_id,object_id,object_name,object_type,order_code,level_code,fma_cash_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_remaining_amount,fma_available_funds FROM opm_t_group_cash; 
END P_OPM_INITIAL_GROUP;
/
CREATE OR REPLACE PROCEDURE "P_OPM_INITIAL_REGION" (planyear IN number--计划年
,companyid in varchar2---公司
) AS-- 根据模板初始化年度集团级数据
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
--删除该年；
DELETE FROM opm_region_cash WHERE plan_year=planyear and BELONG_REGION_ID=companyid;
--根据模板初始化该年
INSERT INTO opm_REGION_cash (id,plan_year,BELONG_REGION_ID,parent_id,object_id,object_name,object_type,order_code,level_code,fma_cash_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_remaining_amount,fma_available_funds)
SELECT sys_guid(),planyear,companyid,parent_id,object_id,object_name,object_type,order_code,level_code,fma_cash_remaining_amount,fma_sales_collection,fma_rental_income,fma_increase_loan,fma_collection_loan,fma_shareholder_input,fma_investment_input,fma_other_input,fma_total_source_funds,fma_land_cost,fma_engineering_expenditure,fma_development_overhead,fma_expenses_the_period,fma_taxes,fma_pre_payment,fma_other_expenses,fma_current_expenditure,fma_subtotal_fund,fma_flow_funds,fma_remaining_amount,fma_available_funds 
FROM opm_t_region_cash; 
END P_OPM_INITIAL_REGION;


