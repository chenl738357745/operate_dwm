---delete from OPM_T_REGION_CASH;

select * from OPM_T_REGION_CASH order by lpad( order_code, 10, '0' );

---���¹�˾����
update OPM_T_REGION_CASH set object_type='��˾'  where object_name is null;
update OPM_T_REGION_CASH set object_type='�ܼ�'  where id like '%�ܼ�%' ;
update OPM_T_REGION_CASH set object_type='��Ŀ'  where object_name is not null ;
-----------------------------

update OPM_T_REGION_CASH set level_code=1 where object_type='��˾' or object_type='�ܼ�';
update OPM_T_REGION_CASH set level_code=2 where object_type='��Ŀ';

select ' update OPM_T_REGION_CASH set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''��Ŀ'';' from  OPM_T_REGION_CASH where id like '%��˾%' order by lpad( order_code, 10, '0' );

   update OPM_T_REGION_CASH set parent_id='һ������˾'  where order_code>1 and  object_type='��Ŀ';
 
 select '    
   update OPM_T_REGION_CASH set '||ut.COLUMN_NAME||'='''' where '||ut.COLUMN_NAME||' not like ''=%'';',
      ut.COLUMN_NAME||',-----',--�ֶ�����
      uc.comments,--�ֶ�ע��
      ut.DATA_TYPE,--�ֵ�����
      ut.DATA_LENGTH,--�ֵ䳤��
      ut.NULLABLE--�Ƿ�Ϊ��
from user_tab_columns  ut
inner JOIN user_col_comments uc
on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name
where ut.Table_Name='OPM_T_REGION_CASH' and ut.COLUMN_NAME like '%FMA%'
order by ut.column_name;

    
      
   update OPM_T_REGION_CASH set FMA_AVAILABLE_FUNDS='' where FMA_AVAILABLE_FUNDS not like '=%';
    
   update OPM_T_REGION_CASH set FMA_CASH_REMAINING_AMOUNT='' where FMA_CASH_REMAINING_AMOUNT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_COLLECTION_LOAN='' where FMA_COLLECTION_LOAN not like '=%';
    
   update OPM_T_REGION_CASH set FMA_CURRENT_EXPENDITURE='' where FMA_CURRENT_EXPENDITURE not like '=%';
    
   update OPM_T_REGION_CASH set FMA_DEVELOPMENT_OVERHEAD='' where FMA_DEVELOPMENT_OVERHEAD not like '=%';
    
   update OPM_T_REGION_CASH set FMA_ENGINEERING_EXPENDITURE='' where FMA_ENGINEERING_EXPENDITURE not like '=%';
    
   update OPM_T_REGION_CASH set FMA_EXPENSES_THE_PERIOD='' where FMA_EXPENSES_THE_PERIOD not like '=%';
    
   update OPM_T_REGION_CASH set FMA_FLOW_FUNDS='' where FMA_FLOW_FUNDS not like '=%';
    
   update OPM_T_REGION_CASH set FMA_INCREASE_LOAN='' where FMA_INCREASE_LOAN not like '=%';
    
   update OPM_T_REGION_CASH set FMA_INVESTMENT_INPUT='' where FMA_INVESTMENT_INPUT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_LAND_COST='' where FMA_LAND_COST not like '=%';
    
   update OPM_T_REGION_CASH set FMA_OTHER_EXPENSES='' where FMA_OTHER_EXPENSES not like '=%';
    
   update OPM_T_REGION_CASH set FMA_OTHER_INPUT='' where FMA_OTHER_INPUT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_PRE_PAYMENT='' where FMA_PRE_PAYMENT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_REMAINING_AMOUNT='' where FMA_REMAINING_AMOUNT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_RENTAL_INCOME='' where FMA_RENTAL_INCOME not like '=%';
    
   update OPM_T_REGION_CASH set FMA_SALES_COLLECTION='' where FMA_SALES_COLLECTION not like '=%';
    
   update OPM_T_REGION_CASH set FMA_SHAREHOLDER_INPUT='' where FMA_SHAREHOLDER_INPUT not like '=%';
    
   update OPM_T_REGION_CASH set FMA_SUBTOTAL_FUND='' where FMA_SUBTOTAL_FUND not like '=%';
    
   update OPM_T_REGION_CASH set FMA_TAXES='' where FMA_TAXES not like '=%';
    
   update OPM_T_REGION_CASH set BELONG_REGION_ID=2 where BELONG_REGION_ID not like '=%';
   
   select * from OPM_T_REGION_CASH
   
   



    
 
