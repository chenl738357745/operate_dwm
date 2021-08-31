----汇总
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_CASH_GROUP" (planyear IN number
--计划年
) AS-- 根据年份【汇总集团】现金流
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----获取该年下所有项目，更新项目数据
UPDATE opm_group_cash a
SET    (
a.remaining_amount,
a.sour_sales_collection,
a.sour_rental_income,
a.sour_increase_loan,
a.sour_collection_loan,
a.sour_shareholder_input,
a.sour_investment_input,
a.sour_other_input,
a.sour_total_funds,
a.util_land_cost,
a.util_engineering_expenditure,
a.util_development_overhead,
a.util_expenses_the_period,
a.util_taxes,
a.util_pre_payment,
a.util_other_expenses,
a.util_current_expenditure,
a.util_subtotal_fund,
a.cash_flow_funds,
a.cash_remaining_amount,
a.cash_available_funds
) =
       (SELECT 
b.remaining_amount,
b.sour_sales_collection,
b.sour_rental_income,
b.sour_increase_loan,
b.sour_collection_loan,
b.sour_shareholder_input,
b.sour_investment_input,
b.sour_other_input,
b.sour_total_funds,
b.util_land_cost,
b.util_engineering_expenditure,
b.util_development_overhead,
b.util_expenses_the_period,
b.util_taxes,
b.util_pre_payment,
b.util_other_expenses,
b.util_current_expenditure,
b.util_subtotal_fund,
b.cash_flow_funds,
b.cash_remaining_amount,
b.cash_available_funds     
        FROM   OPM_REGIONAL_CASH b
        WHERE  b.object_id = a.object_id
        AND    a.plan_year=planyear);
END P_OPM_SUM_CASH_GROUP;
/

----汇总
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_CASH_REGION" (planyear IN number,companyid in varchar2
--计划年
) AS-- 根据年份【汇总区域】现金流-根据附表3汇总
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----查询区域级表，查询指定年，制动公司下所有项目
select * from opm_region_cash WHERE plan_year=planyear and BELONG_REGION_ID=companyid and OBJECT_TYPE='项目';
----查询项目级表，指定年，指定项目对应汇总数据
----汇总现金流数据，到区域项目表；--不汇总公司级，因为公司级通过excel计算；

--remaining_amount--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --object_sub_name='期末资金余额'
----SOUR_SALES_COLLECTION,-----XXXX年资金来源计划（销售回款）

----CASH_AVAILABLE_FUNDS,-----2022年当年现金流情况展示窗（可动用资金）
----CASH_FLOW_FUNDS,-----2022年当年现金流情况展示窗（资金净流量）
----REMAINING_AMOUNT,-----截至XXXX年底（期末资金余额）（去年）
----SOUR_COLLECTION_LOAN,-----XXXX年资金来源计划（代收款）
----SOUR_INCREASE_LOAN,-----XXXX年资金来源计划（净增贷款）
----SOUR_INVESTMENT_INPUT,-----XXXX年资金来源计划（往来投入）
----SOUR_OTHER_INPUT,-----XXXX年资金来源计划（其他投入）
----SOUR_RENTAL_INCOME,-----XXXX年资金来源计划（租金收入）

----SOUR_SHAREHOLDER_INPUT,-----XXXX年资金来源计划（股东投入）
----SOUR_TOTAL_FUNDS,-----2022年资金来源计划（资金来源合计）
----UTIL_CURRENT_EXPENDITURE,-----2022年资金运用计划（往来支出）
----UTIL_DEVELOPMENT_OVERHEAD,-----2022年资金运用计划（开发间接费）
----UTIL_ENGINEERING_EXPENDITURE,-----2022年资金运用计划（工程性支出）
----UTIL_EXPENSES_THE_PERIOD,-----2022年资金运用计划（期间费用）
----UTIL_LAND_COST,-----2022年资金运用计划（土地费用）
----UTIL_OTHER_EXPENSES,-----2022年资金运用计划（其他支出）
----UTIL_PRE_PAYMENT,-----2022年资金运用计划（代付款）
----UTIL_SUBTOTAL_FUND,-----2022年资金运用计划（资金运用小计）
----UTIL_TAXES,-----2022年资金运用计划（税金）

END P_OPM_SUM_CASH_REGION;