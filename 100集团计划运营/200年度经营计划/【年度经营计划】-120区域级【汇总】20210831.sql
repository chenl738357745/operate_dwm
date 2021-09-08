CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_INVENTORY" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】供销存（总表3）-根据附表1汇总
-- 注意：
--作者： 吴洋负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');
END P_OPM_SUM_REGION_INVENTORY;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_OPERATING" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】经营计划（总表1）-根据附表4、附表2汇总
-- 注意：
--作者： 王一博负责实现
--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('初始化脚本');
END P_OPM_SUM_REGION_OPERATING;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_CASH" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】现金流-根据附表3汇总
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
--根据年份和项目，查询该项目该年的资金预算平衡表数据。将要使用的字段合并到一列。
UPDATE OPM_REGION_CASH a
SET  (
a.REMAINING_AMOUNT,--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --OBJECT_TYPE='期末资金余额'
a.SOUR_SALES_COLLECTION,-----XXXX年资金来源计划（销售回款）
a.SOUR_COLLECTION_LOAN,-----XXXX年资金来源计划（代收款）---plan_amount>
a.SOUR_INCREASE_LOAN,-----XXXX年资金来源计划（净增贷款）---plan_amount>
a.SOUR_INVESTMENT_INPUT,-----XXXX年资金来源计划（往来投入）---plan_amount>
a.SOUR_OTHER_INPUT,-----XXXX年资金来源计划（其他投入）---plan_amount>
a.SOUR_RENTAL_INCOME,-----XXXX年资金来源计划（租金收入）---plan_amount>

a.SOUR_SHAREHOLDER_INPUT,-----XXXX年资金来源计划（股东投入）---plan_amount>
a.SOUR_TOTAL_FUNDS,-----2022年资金来源计划（资金来源合计）---plan_amount>
a.UTIL_CURRENT_EXPENDITURE,-----2022年资金运用计划（往来支出）---plan_amount>
a.UTIL_DEVELOPMENT_OVERHEAD,-----2022年资金运用计划（开发间接费）---plan_amount>
a.UTIL_ENGINEERING_EXPENDITURE,-----2022年资金运用计划（工程性支出）---plan_amount>
a.UTIL_EXPENSES_THE_PERIOD,-----2022年资金运用计划（期间费用）---plan_amount>
a.UTIL_LAND_COST,-----2022年资金运用计划（土地费用）---plan_amount>
a.UTIL_OTHER_EXPENSES,-----2022年资金运用计划（其他支出）---plan_amount>
a.UTIL_PRE_PAYMENT,-----2022年资金运用计划（代付款）---plan_amount>
a.UTIL_SUBTOTAL_FUND,-----2022年资金运用计划（资金运用小计）---plan_amount>
a.UTIL_TAXES,-----2022年资金运用计划（税金）---plan_amount>

a.cash_remaining_amount,----->2022年当年现金流情况展示窗（期末资金余额）---plan_amount>-->期末资金余额
a.CASH_AVAILABLE_FUNDS,-----2022年当年现金流情况展示窗（可动用资金）---plan_amount>--->可动用资金
a.CASH_FLOW_FUNDS-----2022年当年现金流情况展示窗（资金净流量）---plan_amount>--->资金净流量
) =
(select 

b."'年底期末资金余额'",--截至XXXX年底（期末资金余额）（去年）--->last_cumulative_amount --OBJECT_TYPE='期末资金余额'
b."'销售回款'",-----XXXX年资金来源计划（销售回款）
b."'代收款'",-----XXXX年资金来源计划（代收款）---plan_amount>
b."'净增贷款'",-----XXXX年资金来源计划（净增贷款）---plan_amount>
b."'往来投入'",-----XXXX年资金来源计划（往来投入）---plan_amount>
b."'其它收入'",-----XXXX年资金来源计划（其他投入）---plan_amount>--
b."'租金收入'",-----XXXX年资金来源计划（租金收入）---plan_amount>

b."'股东投入'",-----XXXX年资金来源计划（股东投入）---plan_amount>
b."'资金来源小计'",-----2022年资金来源计划（资金来源合计）---plan_amount>---
b."'往来支出'",-----2022年资金运用计划（往来支出）---plan_amount>
b."'开发间接费'",-----2022年资金运用计划（开发间接费）---plan_amount>
b."'工程性支出'",-----2022年资金运用计划（工程性支出）---plan_amount>
b."'期间费用'",-----2022年资金运用计划（期间费用）---plan_amount>
b."'土地费用'",-----2022年资金运用计划（土地费用）---plan_amount>
b."'其他支出'",-----2022年资金运用计划（其他支出）---plan_amount>
b."'代付款'",-----2022年资金运用计划（代付款）---plan_amount>
b."'资金运用小计'",-----2022年资金运用计划（资金运用小计）---plan_amount>
b."'税金'",-----2022年资金运用计划（税金）---plan_amount>

b."'期末资金余额'",----->2022年当年现金流情况展示窗（期末资金余额）---plan_amount>-->期末资金余额
b."'可动用资金'",-----2022年当年现金流情况展示窗（可动用资金）---plan_amount>--->可动用资金----
b."'资金净流量'"-----2022年当年现金流情况展示窗（资金净流量）---plan_amount>--->资金净流量
from  
(select projectid as project_id,resultdate.* from ( SELECT * FROM (SELECT OBJECT_TYPE,amount FROM 
                    (SELECT  OBJECT_TYPE, plan_amount  amount FROM OPM_PROJ_BUDGET 
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid
                          union all 
                     SELECT  '年底期末资金余额' as OBJECT_TYPE,last_cumulative_amount  amount FROM OPM_PROJ_BUDGET
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid and  OBJECT_TYPE='期末资金余额'
                    )base
            ) pivot (sum(amount) FOR OBJECT_TYPE IN ('可动用资金','年底期末资金余额','销售回款','租金收入','净增贷款','新增贷款','归还贷款','代收款','股东投入','往来投入','其它收入','资金来源小计','土地费用','工程性支出','开发间接费','期间费用','销售费用','管理费用','财务费用','税金','代付款','其他支出','往来支出','资金运用小计','资金净流量','期末资金余额','贷款监管','销售监管','其他监管')
        ))resultdate
)b     
WHERE  b.project_id = a.object_id and  a.plan_year=planyear and a.object_id=projectid);

END P_OPM_SUM_REGION_CASH;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION" (planyear IN number,projectid in varchar2
--计划年
) AS-- 根据年份按项目【汇总区域】
-- 注意：
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
BEGIN
  P_OPM_SUM_REGION_CASH(
    PLANYEAR => PLANYEAR,
    PROJECTID => PROJECTID
  );
  P_OPM_SUM_REGION_INVENTORY(
    PLANYEAR => PLANYEAR,
    PROJECTID => PROJECTID
  );
  P_OPM_SUM_REGION_OPERATING(
    PLANYEAR => PLANYEAR,
    PROJECTID => PROJECTID
  );
--rollback; 
  commit;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END;
END P_OPM_SUM_REGION;