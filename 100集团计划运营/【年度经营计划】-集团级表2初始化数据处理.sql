---delete from opm_t_group_cash;

select * from opm_t_group_cash order by lpad( order_code, 10, '0' );

---更新公司类型
update opm_t_group_cash set object_type='公司'  where object_name is null;
update opm_t_group_cash set object_type='总计'  where object_id like '%总计%' ;
update opm_t_group_cash set object_type='项目'  where object_name is not null ;
-----------------------------

update opm_group_cash set level_code=1 where object_type='公司' or object_type='总计';
update opm_group_cash set level_code=2 where object_type='项目';

select ' update opm_t_group_cash set parent_id='''||object_id||'''  where order_code>'||order_code||' and  object_type=''项目'';' from  opm_t_group_cash where object_id like '%公司%' order by lpad( order_code, 10, '0' );

 update opm_t_group_cash set parent_id='一北方公司'  where order_code>2 and  object_type='项目';
 update opm_t_group_cash set parent_id='二华东公司'  where order_code>30 and  object_type='项目';
 update opm_t_group_cash set parent_id='三华南公司'  where order_code>66 and  object_type='项目';
 update opm_t_group_cash set parent_id='四西南公司'  where order_code>96 and  object_type='项目';
 update opm_t_group_cash set parent_id='五华中公司'  where order_code>133 and  object_type='项目';
 update opm_t_group_cash set parent_id='六中南公司'  where order_code>145 and  object_type='项目';
 update opm_t_group_cash set parent_id='七东北公司'  where order_code>161 and  object_type='项目';
 update opm_t_group_cash set parent_id='八商业公司'  where order_code>174 and  object_type='项目';
 update opm_t_group_cash set parent_id='九公寓公司'  where order_code>184 and  object_type='项目';
 update opm_t_group_cash set parent_id='十二创新投资公司'  where order_code>195 and  object_type='项目';
 update opm_t_group_cash set parent_id='十三文旅公司'  where order_code>203 and  object_type='项目';
 update opm_t_group_cash set parent_id='十四南沙公司'  where order_code>207 and  object_type='项目';
 update opm_t_group_cash set parent_id='十五贵州公司'  where order_code>226 and  object_type='项目';
 update opm_t_group_cash set parent_id='十八雄安公司'  where order_code>243 and  object_type='项目';
 update opm_t_group_cash set parent_id='十九城市发展公司'  where order_code>247 and  object_type='项目';
 update opm_t_group_cash set parent_id='二十济南公司'  where order_code>250 and  object_type='项目';
 update opm_t_group_cash set parent_id='十物业公司'  where order_code>254 and  object_type='项目';
 update opm_t_group_cash set parent_id='十六投资管理公司'  where order_code>256 and  object_type='项目';
 
 select '    
   update opm_t_group_cash set '||ut.COLUMN_NAME||'='''' where '||ut.COLUMN_NAME||' not like ''=%'';',
      ut.COLUMN_NAME||',-----',--字段名称
      uc.comments,--字段注释
      ut.DATA_TYPE,--字典类型
      ut.DATA_LENGTH,--字典长度
      ut.NULLABLE--是否为空
from user_tab_columns  ut
inner JOIN user_col_comments uc
on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name
where ut.Table_Name='OPM_T_GROUP_CASH' and ut.COLUMN_NAME like '%FMA%'
order by ut.column_name;


  




    
 
 
-- --------------------------------------------------------
----  文件已创建 - 星期二-八月-31-2021   
----------------------------------------------------------
----------------------------------------------------------
----  DDL for Table OPM_T_GROUP_CASH
--
--drop table OPM_T_GROUP_CASH;
----------------------------------------------------------
--CREATE TABLE "OPM_T_GROUP_CASH" (
--ORDER_CODE NUMBER(20,4), -----顺序
--OBJECT_ID VARCHAR2(500 BYTE),-----对象ID
--OBJECT_NAME VARCHAR2(500 BYTE),-----对象名称（城市/项目名称）
--FMA_CASH_REMAINING_AMOUNT VARCHAR2(500 BYTE),-----（公式）2022年当年现金流情况展示窗（期末资金余额）
--FMA_SALES_COLLECTION VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（销售回款）
--FMA_RENTAL_INCOME VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（租金收入）
--
--FMA_INCREASE_LOAN VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（净增贷款）
--FMA_COLLECTION_LOAN VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（代收款）
--FMA_SHAREHOLDER_INPUT VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（股东投入）
--FMA_INVESTMENT_INPUT VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（往来投入）
--
--FMA_OTHER_INPUT VARCHAR2(500 BYTE),-----（公式）XXXX年资金来源计划（其他投入）
--FMA_TOTAL_SOURCE_FUNDS VARCHAR2(500 BYTE),-----（公式）2022年资金来源计划（资金来源合计）
--FMA_LAND_COST VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（土地费用）
--FMA_ENGINEERING_EXPENDITURE VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（工程性支出）
--
--FMA_DEVELOPMENT_OVERHEAD VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（开发间接费）
--FMA_EXPENSES_THE_PERIOD VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（期间费用）
--FMA_TAXES VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（税金）
--FMA_PRE_PAYMENT VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（代付款）
--
--FMA_OTHER_EXPENSES VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（其他支出）
--FMA_CURRENT_EXPENDITURE VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（往来支出）
--FMA_SUBTOTAL_FUND VARCHAR2(500 BYTE),-----（公式）2022年资金运用计划（资金运用小计）
--FMA_FLOW_FUNDS VARCHAR2(500 BYTE),-----（公式）2022年当年现金流情况展示窗（资金净流量）
--
--FMA_REMAINING_AMOUNT VARCHAR2(500 BYTE),-----（公式）截至XXXX年底（期末资金余额）
--FMA_AVAILABLE_FUNDS VARCHAR2(500 BYTE),-----（公式）2022年当年现金流情况展示窗（可动用资金）
--
--LEVEL_CODE  NUMBER(20,4),-----层级：1开始
--OBJECT_TYPE  VARCHAR2(500 BYTE),-----类型（公司、项目、补差公司、拟新获取项目、总计）
--
--PARENT_ID  VARCHAR2(500 BYTE)-----父级ID
--);
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."PARENT_ID" IS
--    '父级ID';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_TYPE" IS
--    '类型（公司、项目、补差公司、拟新获取项目、总计）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."REMAINING_AMOUNT" IS '截至XXXX年底（期末资金余额）（去年）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_INCREASE_LOAN" IS 'XXXX年资金来源计划（净增贷款）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_INVESTMENT_INPUT" IS 'XXXX年资金来源计划（往来投入）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_LAND_COST" IS '2022年资金运用计划（土地费用）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_EXPENSES_THE_PERIOD" IS '2022年资金运用计划（期间费用）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_OTHER_EXPENSES" IS '2022年资金运用计划（其他支出）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_FLOW_FUNDS" IS '2022年当年现金流情况展示窗（资金净流量）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_REMAINING_AMOUNT" IS '2022年当年现金流情况展示窗（期末资金余额）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_AVAILABLE_FUNDS" IS '2022年当年现金流情况展示窗（可动用资金）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_TOTAL_SOURCE_FUNDS" IS
--    '（公式）2022年资金来源计划（资金来源合计）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_LAND_COST" IS
--    '（公式）2022年资金运用计划（土地费用）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_ENGINEERING_EXPENDITURE" IS
--    '（公式）2022年资金运用计划（工程性支出）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_DEVELOPMENT_OVERHEAD" IS
--    '（公式）2022年资金运用计划（开发间接费）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_EXPENSES_THE_PERIOD" IS
--    '（公式）2022年资金运用计划（期间费用）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_TAXES" IS
--    '（公式）2022年资金运用计划（税金）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_REMAINING_AMOUNT" IS
--    '（公式）截至XXXX年底（期末资金余额）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SALES_COLLECTION" IS
--    '（公式）XXXX年资金来源计划（销售回款）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_RENTAL_INCOME" IS
--    '（公式）XXXX年资金来源计划（租金收入）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_INCREASE_LOAN" IS
--    '（公式）XXXX年资金来源计划（净增贷款）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_COLLECTION_LOAN" IS
--    '（公式）XXXX年资金来源计划（代收款）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SHAREHOLDER_INPUT" IS
--    '（公式）XXXX年资金来源计划（股东投入）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_INVESTMENT_INPUT" IS
--    '（公式）XXXX年资金来源计划（往来投入）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_OTHER_INPUT" IS
--    '（公式）XXXX年资金来源计划（其他投入）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."LEVEL_CODE" IS
--    '层级：1开始';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."ORDER_CODE" IS
--    '顺序';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_ID" IS
--    '对象ID';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_NAME" IS
--    '对象名称（城市/项目名称）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."ID" IS
--    '主键';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."PLAN_YEAR" IS '计划年份';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_SALES_COLLECTION" IS 'XXXX年资金来源计划（销售回款）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_RENTAL_INCOME" IS 'XXXX年资金来源计划（租金收入）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_COLLECTION_LOAN" IS 'XXXX年资金来源计划（代收款）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_SHAREHOLDER_INPUT" IS 'XXXX年资金来源计划（股东投入）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_OTHER_INPUT" IS 'XXXX年资金来源计划（其他投入）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_TOTAL_FUNDS" IS '2022年资金来源计划（资金来源合计）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_ENGINEERING_EXPENDITURE" IS '2022年资金运用计划（工程性支出）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_DEVELOPMENT_OVERHEAD" IS '2022年资金运用计划（开发间接费）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_TAXES" IS '2022年资金运用计划（税金）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_PRE_PAYMENT" IS '2022年资金运用计划（代付款）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_CURRENT_EXPENDITURE" IS '2022年资金运用计划（往来支出）';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_SUBTOTAL_FUND" IS '2022年资金运用计划（资金运用小计）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_PRE_PAYMENT" IS
--    '（公式）2022年资金运用计划（代付款）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_OTHER_EXPENSES" IS
--    '（公式）2022年资金运用计划（其他支出）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_CURRENT_EXPENDITURE" IS
--    '（公式）2022年资金运用计划（往来支出）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SUBTOTAL_FUND" IS
--    '（公式）2022年资金运用计划（资金运用小计）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_FLOW_FUNDS" IS
--    '（公式）2022年当年现金流情况展示窗（资金净流量）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_CASH_REMAINING_AMOUNT" IS
--    '（公式）2022年当年现金流情况展示窗（期末资金余额）';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_AVAILABLE_FUNDS" IS
--    '（公式）2022年当年现金流情况展示窗（可动用资金）';