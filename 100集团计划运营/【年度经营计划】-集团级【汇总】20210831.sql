----����
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_CASH_GROUP" (planyear IN number
--�ƻ���
) AS-- ������ݡ����ܼ��š��ֽ���
-- ע�⣺
--���ߣ� chenl--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----��ȡ������������Ŀ��������Ŀ����
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

----����
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_CASH_REGION" (planyear IN number,companyid in varchar2
--�ƻ���
) AS-- ������ݡ����������ֽ���-���ݸ���3����
-- ע�⣺
--���ߣ� chenl--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
----��ѯ���򼶱���ѯָ���꣬�ƶ���˾��������Ŀ
select * from opm_region_cash WHERE plan_year=planyear and BELONG_REGION_ID=companyid and OBJECT_TYPE='��Ŀ';
----��ѯ��Ŀ����ָ���ָ꣬����Ŀ��Ӧ��������
----�����ֽ������ݣ���������Ŀ��--�����ܹ�˾������Ϊ��˾��ͨ��excel���㣻

--remaining_amount--����XXXX��ף���ĩ�ʽ�����ȥ�꣩--->last_cumulative_amount --object_sub_name='��ĩ�ʽ����'
----SOUR_SALES_COLLECTION,-----XXXX���ʽ���Դ�ƻ������ۻؿ

----CASH_AVAILABLE_FUNDS,-----2022�굱���ֽ������չʾ�����ɶ����ʽ�
----CASH_FLOW_FUNDS,-----2022�굱���ֽ������չʾ�����ʽ�������
----REMAINING_AMOUNT,-----����XXXX��ף���ĩ�ʽ�����ȥ�꣩
----SOUR_COLLECTION_LOAN,-----XXXX���ʽ���Դ�ƻ������տ
----SOUR_INCREASE_LOAN,-----XXXX���ʽ���Դ�ƻ����������
----SOUR_INVESTMENT_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩
----SOUR_OTHER_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩
----SOUR_RENTAL_INCOME,-----XXXX���ʽ���Դ�ƻ���������룩

----SOUR_SHAREHOLDER_INPUT,-----XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩
----SOUR_TOTAL_FUNDS,-----2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�
----UTIL_CURRENT_EXPENDITURE,-----2022���ʽ����üƻ�������֧����
----UTIL_DEVELOPMENT_OVERHEAD,-----2022���ʽ����üƻ���������ӷѣ�
----UTIL_ENGINEERING_EXPENDITURE,-----2022���ʽ����üƻ���������֧����
----UTIL_EXPENSES_THE_PERIOD,-----2022���ʽ����üƻ����ڼ���ã�
----UTIL_LAND_COST,-----2022���ʽ����üƻ������ط��ã�
----UTIL_OTHER_EXPENSES,-----2022���ʽ����üƻ�������֧����
----UTIL_PRE_PAYMENT,-----2022���ʽ����üƻ��������
----UTIL_SUBTOTAL_FUND,-----2022���ʽ����üƻ����ʽ�����С�ƣ�
----UTIL_TAXES,-----2022���ʽ����üƻ���˰��

END P_OPM_SUM_CASH_REGION;