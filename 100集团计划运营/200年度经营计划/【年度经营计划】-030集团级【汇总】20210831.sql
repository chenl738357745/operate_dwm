CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_INVENTORY" (planyear IN number--计划年
,companyid in varchar2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】供销存（集团总表3）-根据区域总表3汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');
END P_OPM_SUM_GROUP_INVENTORY;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_OPERATING" (planyear IN number--计划年
,companyid in varchar2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】经营计划（集团总表1）-根据区域总表1汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');

END P_OPM_SUM_GROUP_OPERATING;

/

----汇总
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP_CASH" (planyear IN number--计划年
,companyid in varchar2--区域公司
--计划年
) AS-- 根据年份【汇总集团】现金流（集团总表2）-根据区域总表2汇总
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----获取该年下所有项目，更新项目数据
UPDATE opm_group_cash a
SET  (
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
        FROM   OPM_REGION_CASH b
        WHERE  b.object_id = a.object_id
        AND    a.plan_year=planyear and b.BELONG_REGION_ID=companyid);
END P_OPM_SUM_GROUP_CASH;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_GROUP" (planyear IN number--计划年
,companyid in varchar2--区域公司
) AS-- 根据年份按区域公司id【汇总集团级，项目数据】
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
BEGIN
  P_OPM_SUM_GROUP_CASH(
    PLANYEAR => PLANYEAR,
    COMPANYID => COMPANYID
  );
  -- 根据年份按区域公司id【汇总集团级，项目数据】供销存（集团总表3）-根据区域总表3汇总
    P_OPM_SUM_GROUP_INVENTORY(
    PLANYEAR => PLANYEAR,
    COMPANYID => COMPANYID
  );
  -- 根据年份按区域公司id【汇总集团级，项目数据】经营计划（集团总表1）-根据区域总表1汇总
  P_OPM_SUM_GROUP_OPERATING(
    PLANYEAR => PLANYEAR,
    COMPANYID => COMPANYID
  );
  commit;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
--rollback; 
END;
END P_OPM_SUM_GROUP;