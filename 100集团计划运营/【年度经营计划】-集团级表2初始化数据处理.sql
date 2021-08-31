---delete from opm_t_group_cash;

select * from opm_t_group_cash order by lpad( order_code, 10, '0' );

---���¹�˾����
update opm_t_group_cash set object_type='��˾'  where object_name is null;
update opm_t_group_cash set object_type='�ܼ�'  where object_id like '%�ܼ�%' ;
update opm_t_group_cash set object_type='��Ŀ'  where object_name is not null ;
-----------------------------

update opm_group_cash set level_code=1 where object_type='��˾' or object_type='�ܼ�';
update opm_group_cash set level_code=2 where object_type='��Ŀ';

select ' update opm_t_group_cash set parent_id='''||object_id||'''  where order_code>'||order_code||' and  object_type=''��Ŀ'';' from  opm_t_group_cash where object_id like '%��˾%' order by lpad( order_code, 10, '0' );

 update opm_t_group_cash set parent_id='һ������˾'  where order_code>2 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='��������˾'  where order_code>30 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�����Ϲ�˾'  where order_code>66 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�����Ϲ�˾'  where order_code>96 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�廪�й�˾'  where order_code>133 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�����Ϲ�˾'  where order_code>145 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�߶�����˾'  where order_code>161 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='����ҵ��˾'  where order_code>174 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='�Ź�Ԣ��˾'  where order_code>184 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ������Ͷ�ʹ�˾'  where order_code>195 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ�����ù�˾'  where order_code>203 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ����ɳ��˾'  where order_code>207 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ����ݹ�˾'  where order_code>226 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ���۰���˾'  where order_code>243 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ�ų��з�չ��˾'  where order_code>247 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='��ʮ���Ϲ�˾'  where order_code>250 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ��ҵ��˾'  where order_code>254 and  object_type='��Ŀ';
 update opm_t_group_cash set parent_id='ʮ��Ͷ�ʹ���˾'  where order_code>256 and  object_type='��Ŀ';
 
 select '    
   update opm_t_group_cash set '||ut.COLUMN_NAME||'='''' where '||ut.COLUMN_NAME||' not like ''=%'';',
      ut.COLUMN_NAME||',-----',--�ֶ�����
      uc.comments,--�ֶ�ע��
      ut.DATA_TYPE,--�ֵ�����
      ut.DATA_LENGTH,--�ֵ䳤��
      ut.NULLABLE--�Ƿ�Ϊ��
from user_tab_columns  ut
inner JOIN user_col_comments uc
on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name
where ut.Table_Name='OPM_T_GROUP_CASH' and ut.COLUMN_NAME like '%FMA%'
order by ut.column_name;


  




    
 
 
-- --------------------------------------------------------
----  �ļ��Ѵ��� - ���ڶ�-����-31-2021   
----------------------------------------------------------
----------------------------------------------------------
----  DDL for Table OPM_T_GROUP_CASH
--
--drop table OPM_T_GROUP_CASH;
----------------------------------------------------------
--CREATE TABLE "OPM_T_GROUP_CASH" (
--ORDER_CODE NUMBER(20,4), -----˳��
--OBJECT_ID VARCHAR2(500 BYTE),-----����ID
--OBJECT_NAME VARCHAR2(500 BYTE),-----�������ƣ�����/��Ŀ���ƣ�
--FMA_CASH_REMAINING_AMOUNT VARCHAR2(500 BYTE),-----����ʽ��2022�굱���ֽ������չʾ������ĩ�ʽ���
--FMA_SALES_COLLECTION VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ������ۻؿ
--FMA_RENTAL_INCOME VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ���������룩
--
--FMA_INCREASE_LOAN VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ����������
--FMA_COLLECTION_LOAN VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ������տ
--FMA_SHAREHOLDER_INPUT VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩
--FMA_INVESTMENT_INPUT VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ�������Ͷ�룩
--
--FMA_OTHER_INPUT VARCHAR2(500 BYTE),-----����ʽ��XXXX���ʽ���Դ�ƻ�������Ͷ�룩
--FMA_TOTAL_SOURCE_FUNDS VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�
--FMA_LAND_COST VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ������ط��ã�
--FMA_ENGINEERING_EXPENDITURE VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ���������֧����
--
--FMA_DEVELOPMENT_OVERHEAD VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ���������ӷѣ�
--FMA_EXPENSES_THE_PERIOD VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ����ڼ���ã�
--FMA_TAXES VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ���˰��
--FMA_PRE_PAYMENT VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ��������
--
--FMA_OTHER_EXPENSES VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ�������֧����
--FMA_CURRENT_EXPENDITURE VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ�������֧����
--FMA_SUBTOTAL_FUND VARCHAR2(500 BYTE),-----����ʽ��2022���ʽ����üƻ����ʽ�����С�ƣ�
--FMA_FLOW_FUNDS VARCHAR2(500 BYTE),-----����ʽ��2022�굱���ֽ������չʾ�����ʽ�������
--
--FMA_REMAINING_AMOUNT VARCHAR2(500 BYTE),-----����ʽ������XXXX��ף���ĩ�ʽ���
--FMA_AVAILABLE_FUNDS VARCHAR2(500 BYTE),-----����ʽ��2022�굱���ֽ������չʾ�����ɶ����ʽ�
--
--LEVEL_CODE  NUMBER(20,4),-----�㼶��1��ʼ
--OBJECT_TYPE  VARCHAR2(500 BYTE),-----���ͣ���˾����Ŀ�����˾�����»�ȡ��Ŀ���ܼƣ�
--
--PARENT_ID  VARCHAR2(500 BYTE)-----����ID
--);
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."PARENT_ID" IS
--    '����ID';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_TYPE" IS
--    '���ͣ���˾����Ŀ�����˾�����»�ȡ��Ŀ���ܼƣ�';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."REMAINING_AMOUNT" IS '����XXXX��ף���ĩ�ʽ�����ȥ�꣩';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_INCREASE_LOAN" IS 'XXXX���ʽ���Դ�ƻ����������';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_INVESTMENT_INPUT" IS 'XXXX���ʽ���Դ�ƻ�������Ͷ�룩';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_LAND_COST" IS '2022���ʽ����üƻ������ط��ã�';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_EXPENSES_THE_PERIOD" IS '2022���ʽ����üƻ����ڼ���ã�';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_OTHER_EXPENSES" IS '2022���ʽ����üƻ�������֧����';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_FLOW_FUNDS" IS '2022�굱���ֽ������չʾ�����ʽ�������';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_REMAINING_AMOUNT" IS '2022�굱���ֽ������չʾ������ĩ�ʽ���';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."CASH_AVAILABLE_FUNDS" IS '2022�굱���ֽ������չʾ�����ɶ����ʽ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_TOTAL_SOURCE_FUNDS" IS
--    '����ʽ��2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_LAND_COST" IS
--    '����ʽ��2022���ʽ����üƻ������ط��ã�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_ENGINEERING_EXPENDITURE" IS
--    '����ʽ��2022���ʽ����üƻ���������֧����';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_DEVELOPMENT_OVERHEAD" IS
--    '����ʽ��2022���ʽ����üƻ���������ӷѣ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_EXPENSES_THE_PERIOD" IS
--    '����ʽ��2022���ʽ����üƻ����ڼ���ã�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_TAXES" IS
--    '����ʽ��2022���ʽ����üƻ���˰��';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_REMAINING_AMOUNT" IS
--    '����ʽ������XXXX��ף���ĩ�ʽ���';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SALES_COLLECTION" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ������ۻؿ';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_RENTAL_INCOME" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ���������룩';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_INCREASE_LOAN" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ����������';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_COLLECTION_LOAN" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ������տ';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SHAREHOLDER_INPUT" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_INVESTMENT_INPUT" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ�������Ͷ�룩';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_OTHER_INPUT" IS
--    '����ʽ��XXXX���ʽ���Դ�ƻ�������Ͷ�룩';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."LEVEL_CODE" IS
--    '�㼶��1��ʼ';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."ORDER_CODE" IS
--    '˳��';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_ID" IS
--    '����ID';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."OBJECT_NAME" IS
--    '�������ƣ�����/��Ŀ���ƣ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."ID" IS
--    '����';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."PLAN_YEAR" IS '�ƻ����';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_SALES_COLLECTION" IS 'XXXX���ʽ���Դ�ƻ������ۻؿ';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_RENTAL_INCOME" IS 'XXXX���ʽ���Դ�ƻ���������룩';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_COLLECTION_LOAN" IS 'XXXX���ʽ���Դ�ƻ������տ';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_SHAREHOLDER_INPUT" IS 'XXXX���ʽ���Դ�ƻ����ɶ�Ͷ�룩';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_OTHER_INPUT" IS 'XXXX���ʽ���Դ�ƻ�������Ͷ�룩';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."SOUR_TOTAL_FUNDS" IS '2022���ʽ���Դ�ƻ����ʽ���Դ�ϼƣ�';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_ENGINEERING_EXPENDITURE" IS '2022���ʽ����üƻ���������֧����';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_DEVELOPMENT_OVERHEAD" IS '2022���ʽ����üƻ���������ӷѣ�';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_TAXES" IS '2022���ʽ����üƻ���˰��';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_PRE_PAYMENT" IS '2022���ʽ����üƻ��������';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_CURRENT_EXPENDITURE" IS '2022���ʽ����üƻ�������֧����';
----   COMMENT ON COLUMN "OPM_T_GROUP_CASH"."UTIL_SUBTOTAL_FUND" IS '2022���ʽ����üƻ����ʽ�����С�ƣ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_PRE_PAYMENT" IS
--    '����ʽ��2022���ʽ����üƻ��������';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_OTHER_EXPENSES" IS
--    '����ʽ��2022���ʽ����üƻ�������֧����';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_CURRENT_EXPENDITURE" IS
--    '����ʽ��2022���ʽ����üƻ�������֧����';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_SUBTOTAL_FUND" IS
--    '����ʽ��2022���ʽ����üƻ����ʽ�����С�ƣ�';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_FLOW_FUNDS" IS
--    '����ʽ��2022�굱���ֽ������չʾ�����ʽ�������';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_CASH_REMAINING_AMOUNT" IS
--    '����ʽ��2022�굱���ֽ������չʾ������ĩ�ʽ���';
--
--COMMENT ON COLUMN "OPM_T_GROUP_CASH"."FMA_AVAILABLE_FUNDS" IS
--    '����ʽ��2022�굱���ֽ������չʾ�����ɶ����ʽ�';