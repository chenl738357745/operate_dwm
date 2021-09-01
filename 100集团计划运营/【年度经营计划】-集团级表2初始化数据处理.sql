---delete from opm_t_group_cash;

select * from opm_t_group_cash order by lpad( order_code, 10, '0' );

---���¹�˾����
update opm_t_group_cash set object_type='��˾'  where object_name is null;
update opm_t_group_cash set object_type='�ܼ�'  where id like '%�ܼ�%' ;
update opm_t_group_cash set object_type='��Ŀ'  where object_name is not null ;
-----------------------------

update opm_t_group_cash set level_code=1 where object_type='��˾' or object_type='�ܼ�';
update opm_t_group_cash set level_code=2 where object_type='��Ŀ';

select ' update opm_t_group_cash set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''��Ŀ'';' from  opm_t_group_cash where id like '%��˾%' order by lpad( order_code, 10, '0' );

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

    
   update opm_t_group_cash set FMA_AVAILABLE_FUNDS='' where FMA_AVAILABLE_FUNDS not like '=%';
    
   update opm_t_group_cash set FMA_CASH_REMAINING_AMOUNT='' where FMA_CASH_REMAINING_AMOUNT not like '=%';
    
   update opm_t_group_cash set FMA_COLLECTION_LOAN='' where FMA_COLLECTION_LOAN not like '=%';
    
   update opm_t_group_cash set FMA_CURRENT_EXPENDITURE='' where FMA_CURRENT_EXPENDITURE not like '=%';
    
   update opm_t_group_cash set FMA_DEVELOPMENT_OVERHEAD='' where FMA_DEVELOPMENT_OVERHEAD not like '=%';
    
   update opm_t_group_cash set FMA_ENGINEERING_EXPENDITURE='' where FMA_ENGINEERING_EXPENDITURE not like '=%';
    
   update opm_t_group_cash set FMA_EXPENSES_THE_PERIOD='' where FMA_EXPENSES_THE_PERIOD not like '=%';
    
   update opm_t_group_cash set FMA_FLOW_FUNDS='' where FMA_FLOW_FUNDS not like '=%';
    
   update opm_t_group_cash set FMA_INCREASE_LOAN='' where FMA_INCREASE_LOAN not like '=%';
    
   update opm_t_group_cash set FMA_INVESTMENT_INPUT='' where FMA_INVESTMENT_INPUT not like '=%';
    
   update opm_t_group_cash set FMA_LAND_COST='' where FMA_LAND_COST not like '=%';
    
   update opm_t_group_cash set FMA_OTHER_EXPENSES='' where FMA_OTHER_EXPENSES not like '=%';
    
   update opm_t_group_cash set FMA_OTHER_INPUT='' where FMA_OTHER_INPUT not like '=%';
    
   update opm_t_group_cash set FMA_PRE_PAYMENT='' where FMA_PRE_PAYMENT not like '=%';
    
   update opm_t_group_cash set FMA_REMAINING_AMOUNT='' where FMA_REMAINING_AMOUNT not like '=%';
    
   update opm_t_group_cash set FMA_RENTAL_INCOME='' where FMA_RENTAL_INCOME not like '=%';
    
   update opm_t_group_cash set FMA_SALES_COLLECTION='' where FMA_SALES_COLLECTION not like '=%';
    
   update opm_t_group_cash set FMA_SHAREHOLDER_INPUT='' where FMA_SHAREHOLDER_INPUT not like '=%';
    
   update opm_t_group_cash set FMA_SUBTOTAL_FUND='' where FMA_SUBTOTAL_FUND not like '=%';
    
   update opm_t_group_cash set FMA_TAXES='' where FMA_TAXES not like '=%';
    
   update opm_t_group_cash set FMA_TOTAL_SOURCE_FUNDS='' where FMA_TOTAL_SOURCE_FUNDS not like '=%';
  




    
 
