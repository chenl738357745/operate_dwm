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

--REMAINING_AMOUNT--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --OBJECT_TYPE='期末资金余额'
----SOUR_SALES_COLLECTION,-----XXXX年资金来源计划（销售回款）
----SOUR_COLLECTION_LOAN,-----XXXX年资金来源计划（代收款）---plan_amount>
----SOUR_INCREASE_LOAN,-----XXXX年资金来源计划（净增贷款）---plan_amount>
----SOUR_INVESTMENT_INPUT,-----XXXX年资金来源计划（往来投入）---plan_amount>
----SOUR_OTHER_INPUT,-----XXXX年资金来源计划（其他投入）---plan_amount>
----SOUR_RENTAL_INCOME,-----XXXX年资金来源计划（租金收入）---plan_amount>

----SOUR_SHAREHOLDER_INPUT,-----XXXX年资金来源计划（股东投入）---plan_amount>
----SOUR_TOTAL_FUNDS,-----2022年资金来源计划（资金来源合计）---plan_amount>
----UTIL_CURRENT_EXPENDITURE,-----2022年资金运用计划（往来支出）---plan_amount>
----UTIL_DEVELOPMENT_OVERHEAD,-----2022年资金运用计划（开发间接费）---plan_amount>
----UTIL_ENGINEERING_EXPENDITURE,-----2022年资金运用计划（工程性支出）---plan_amount>
----UTIL_EXPENSES_THE_PERIOD,-----2022年资金运用计划（期间费用）---plan_amount>
----UTIL_LAND_COST,-----2022年资金运用计划（土地费用）---plan_amount>
----UTIL_OTHER_EXPENSES,-----2022年资金运用计划（其他支出）---plan_amount>
----UTIL_PRE_PAYMENT,-----2022年资金运用计划（代付款）---plan_amount>
----UTIL_SUBTOTAL_FUND,-----2022年资金运用计划（资金运用小计）---plan_amount>
----UTIL_TAXES,-----2022年资金运用计划（税金）---plan_amount>

----cash_remaining_amount,----->2022年当年现金流情况展示窗（期末资金余额）---plan_amount>-->期末资金余额
----CASH_AVAILABLE_FUNDS,-----2022年当年现金流情况展示窗（可动用资金）---plan_amount>--->可动用资金
----CASH_FLOW_FUNDS,-----2022年当年现金流情况展示窗（资金净流量）---plan_amount>--->资金净流量

END P_OPM_SUM_CASH_REGION;