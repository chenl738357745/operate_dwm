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

--REMAINING_AMOUNT--����XXXX��ף���ĩ�ʽ�����ȥ�꣩--->last_cumulative_amount --OBJECT_TYPE='��ĩ�ʽ����'
----SOUR_SALES_COLLECTION,-----XXXX���ʽ���Դ�ƻ������ۻؿ
----SOUR_COLLECTION_LOAN,-----XXXX���ʽ���Դ�ƻ������տ---plan_amount>
----SOUR_INCREASE_LOAN,-----XXXX���ʽ���Դ�ƻ����������---plan_amount>
----SOUR_INVESTMENT_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>
----SOUR_OTHER_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>
----SOUR_RENTAL_INCOME,-----XXXX���ʽ���Դ�ƻ���������룩---plan_amount>

----SOUR_SHAREHOLDER_INPUT,-----XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩---plan_amount>
----SOUR_TOTAL_FUNDS,-----2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�---plan_amount>
----UTIL_CURRENT_EXPENDITURE,-----2022���ʽ����üƻ�������֧����---plan_amount>
----UTIL_DEVELOPMENT_OVERHEAD,-----2022���ʽ����üƻ���������ӷѣ�---plan_amount>
----UTIL_ENGINEERING_EXPENDITURE,-----2022���ʽ����üƻ���������֧����---plan_amount>
----UTIL_EXPENSES_THE_PERIOD,-----2022���ʽ����üƻ����ڼ���ã�---plan_amount>
----UTIL_LAND_COST,-----2022���ʽ����üƻ������ط��ã�---plan_amount>
----UTIL_OTHER_EXPENSES,-----2022���ʽ����üƻ�������֧����---plan_amount>
----UTIL_PRE_PAYMENT,-----2022���ʽ����üƻ��������---plan_amount>
----UTIL_SUBTOTAL_FUND,-----2022���ʽ����üƻ����ʽ�����С�ƣ�---plan_amount>
----UTIL_TAXES,-----2022���ʽ����üƻ���˰��---plan_amount>

----cash_remaining_amount,----->2022�굱���ֽ������չʾ������ĩ�ʽ���---plan_amount>-->��ĩ�ʽ����
----CASH_AVAILABLE_FUNDS,-----2022�굱���ֽ������չʾ�����ɶ����ʽ�---plan_amount>--->�ɶ����ʽ�
----CASH_FLOW_FUNDS,-----2022�굱���ֽ������չʾ�����ʽ�������---plan_amount>--->�ʽ�����

END P_OPM_SUM_CASH_REGION;