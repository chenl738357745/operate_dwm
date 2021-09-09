CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_INVENTORY" (planyear IN number,projectid in varchar2
--�ƻ���
) AS-- ������ݰ���Ŀ���������򡿹����棨�ܱ�3��-���ݸ���1����
-- ע�⣺
--���ߣ� ������ʵ��
--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('��ʼ���ű�');
END P_OPM_SUM_REGION_INVENTORY;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_OPERATING" (planyear IN number,projectid in varchar2
--�ƻ���
) AS-- ������ݰ���Ŀ���������򡿾�Ӫ�ƻ����ܱ�1��-���ݸ���4������2����
-- ע�⣺
--���ߣ� ��һ������ʵ��
--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
DBMS_OUTPUT.PUT_LINE('��ʼ���ű�');
END P_OPM_SUM_REGION_OPERATING;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION_CASH" (planyear IN number,projectid in varchar2
--�ƻ���
) AS-- ������ݰ���Ŀ�����������ֽ���-���ݸ���3����
-- ע�⣺
--���ߣ� chenl--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
BEGIN 
--������ݺ���Ŀ����ѯ����Ŀ������ʽ�Ԥ��ƽ������ݡ���Ҫʹ�õ��ֶκϲ���һ�С�
UPDATE OPM_REGION_CASH a
SET  (
a.REMAINING_AMOUNT,--����XXXX��ף���ĩ�ʽ�����ȥ�꣩--->last_cumulative_amount --OBJECT_TYPE='��ĩ�ʽ����'
a.SOUR_SALES_COLLECTION,-----XXXX���ʽ���Դ�ƻ������ۻؿ
a.SOUR_COLLECTION_LOAN,-----XXXX���ʽ���Դ�ƻ������տ---plan_amount>
a.SOUR_INCREASE_LOAN,-----XXXX���ʽ���Դ�ƻ����������---plan_amount>
a.SOUR_INVESTMENT_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>
a.SOUR_OTHER_INPUT,-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>
a.SOUR_RENTAL_INCOME,-----XXXX���ʽ���Դ�ƻ���������룩---plan_amount>

a.SOUR_SHAREHOLDER_INPUT,-----XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩---plan_amount>
a.SOUR_TOTAL_FUNDS,-----2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�---plan_amount>
a.UTIL_CURRENT_EXPENDITURE,-----2022���ʽ����üƻ�������֧����---plan_amount>
a.UTIL_DEVELOPMENT_OVERHEAD,-----2022���ʽ����üƻ���������ӷѣ�---plan_amount>
a.UTIL_ENGINEERING_EXPENDITURE,-----2022���ʽ����üƻ���������֧����---plan_amount>
a.UTIL_EXPENSES_THE_PERIOD,-----2022���ʽ����üƻ����ڼ���ã�---plan_amount>
a.UTIL_LAND_COST,-----2022���ʽ����üƻ������ط��ã�---plan_amount>
a.UTIL_OTHER_EXPENSES,-----2022���ʽ����üƻ�������֧����---plan_amount>
a.UTIL_PRE_PAYMENT,-----2022���ʽ����üƻ��������---plan_amount>
a.UTIL_SUBTOTAL_FUND,-----2022���ʽ����üƻ����ʽ�����С�ƣ�---plan_amount>
a.UTIL_TAXES,-----2022���ʽ����üƻ���˰��---plan_amount>

a.cash_remaining_amount,----->2022�굱���ֽ������չʾ������ĩ�ʽ���---plan_amount>-->��ĩ�ʽ����
a.CASH_AVAILABLE_FUNDS,-----2022�굱���ֽ������չʾ�����ɶ����ʽ�---plan_amount>--->�ɶ����ʽ�
a.CASH_FLOW_FUNDS-----2022�굱���ֽ������չʾ�����ʽ�������---plan_amount>--->�ʽ�����
) =
(select 

b."'�����ĩ�ʽ����'",--����XXXX��ף���ĩ�ʽ�����ȥ�꣩--->last_cumulative_amount --OBJECT_TYPE='��ĩ�ʽ����'
b."'���ۻؿ�'",-----XXXX���ʽ���Դ�ƻ������ۻؿ
b."'���տ�'",-----XXXX���ʽ���Դ�ƻ������տ---plan_amount>
b."'��������'",-----XXXX���ʽ���Դ�ƻ����������---plan_amount>
b."'����Ͷ��'",-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>
b."'��������'",-----XXXX���ʽ���Դ�ƻ�������Ͷ�룩---plan_amount>--
b."'�������'",-----XXXX���ʽ���Դ�ƻ���������룩---plan_amount>

b."'�ɶ�Ͷ��'",-----XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩---plan_amount>
b."'�ʽ���ԴС��'",-----2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�---plan_amount>---
b."'����֧��'",-----2022���ʽ����üƻ�������֧����---plan_amount>
b."'������ӷ�'",-----2022���ʽ����üƻ���������ӷѣ�---plan_amount>
b."'������֧��'",-----2022���ʽ����üƻ���������֧����---plan_amount>
b."'�ڼ����'",-----2022���ʽ����üƻ����ڼ���ã�---plan_amount>
b."'���ط���'",-----2022���ʽ����üƻ������ط��ã�---plan_amount>
b."'����֧��'",-----2022���ʽ����üƻ�������֧����---plan_amount>
b."'������'",-----2022���ʽ����üƻ��������---plan_amount>
b."'�ʽ�����С��'",-----2022���ʽ����üƻ����ʽ�����С�ƣ�---plan_amount>
b."'˰��'",-----2022���ʽ����üƻ���˰��---plan_amount>

b."'��ĩ�ʽ����'",----->2022�굱���ֽ������չʾ������ĩ�ʽ���---plan_amount>-->��ĩ�ʽ����
b."'�ɶ����ʽ�'",-----2022�굱���ֽ������չʾ�����ɶ����ʽ�---plan_amount>--->�ɶ����ʽ�----
b."'�ʽ�����'"-----2022�굱���ֽ������չʾ�����ʽ�������---plan_amount>--->�ʽ�����
from  
(select projectid as project_id,resultdate.* from ( SELECT * FROM (SELECT OBJECT_TYPE,amount FROM 
                    (SELECT  OBJECT_TYPE, plan_amount  amount FROM OPM_PROJ_BUDGET 
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid
                          union all 
                     SELECT  '�����ĩ�ʽ����' as OBJECT_TYPE,last_cumulative_amount  amount FROM OPM_PROJ_BUDGET
                     WHERE plan_year=planyear AND BELONG_PROJ_ID=projectid and  OBJECT_TYPE='��ĩ�ʽ����'
                    )base
            ) pivot (sum(amount) FOR OBJECT_TYPE IN ('�ɶ����ʽ�','�����ĩ�ʽ����','���ۻؿ�','�������','��������','��������','�黹����','���տ�','�ɶ�Ͷ��','����Ͷ��','��������','�ʽ���ԴС��','���ط���','������֧��','������ӷ�','�ڼ����','���۷���','�������','�������','˰��','������','����֧��','����֧��','�ʽ�����С��','�ʽ�����','��ĩ�ʽ����','������','���ۼ��','�������')
        ))resultdate
)b     
WHERE  b.project_id = a.object_id and  a.plan_year=planyear and a.object_id=projectid);

END P_OPM_SUM_REGION_CASH;
/
CREATE OR REPLACE PROCEDURE "P_OPM_SUM_REGION" (planyear IN number,projectid in varchar2
--�ƻ���
) AS-- ������ݰ���Ŀ����������
-- ע�⣺
--���ߣ� chenl--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
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