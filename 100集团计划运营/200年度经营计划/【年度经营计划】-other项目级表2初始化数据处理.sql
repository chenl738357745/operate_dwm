---delete from OPM_T_REGION_CASH;

---delete from opm_t_REGION_CASH;

select * from opm_t_REGION_CASH order by lpad( order_code, 10, '0' );

---���¹�˾����
update opm_t_REGION_CASH set object_type='��˾'  where object_name is null;
update opm_t_REGION_CASH set object_type='�ܼ�'  where id like '%�ܼ�%' ;
update opm_t_REGION_CASH set object_type='��Ŀ'  where object_name is not null ;
-----------------------------

update opm_t_REGION_CASH set level_code=1 where object_type='��˾' or object_type='�ܼ�';
update opm_t_REGION_CASH set level_code=2 where object_type='��Ŀ';
update opm_t_REGION_CASH set OBJECT_NAME=id  where object_type='��˾' or object_type='�ܼ�';

--����Ŀ���Ƹ�����Ŀ id
UPDATE opm_t_REGION_CASH a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,project_name FROM (
SELECT c.object_name,sp.id,sp.project_name FROM opm_t_REGION_CASH c LEFT JOIN sys_project sp ON c.object_name='�й�������' || sp.project_name WHERE sp.id IS NOT NULL)) b WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_REGION_CASH c LEFT JOIN sys_project sp ON c.object_name='�й�������' || sp.project_name WHERE sp.id IS NOT NULL);
--������Ŀid
--����Ŀ���Ƹ�����Ŀ id
UPDATE opm_t_REGION_CASH a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,org_name FROM (
SELECT c.object_name,sp.id,sp.org_name FROM opm_t_REGION_CASH c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL)) b 
WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_REGION_CASH c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL);

select ' update opm_t_REGION_CASH set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''��Ŀ'';' from  opm_t_REGION_CASH where object_type='��˾' order by lpad( order_code, 10, '0' );

 update opm_t_REGION_CASH set parent_id='86e785dc-29ed-4686-8cc8-1bec845a5015'  where order_code>1 and  object_type='��Ŀ';
 
 select '    
   update opm_t_REGION_CASH set '||ut.COLUMN_NAME||'='''' where '||ut.COLUMN_NAME||' not like ''=%'';',
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

    
   update opm_t_REGION_CASH set FMA_AVAILABLE_FUNDS='' where FMA_AVAILABLE_FUNDS not like '=%';
    
   update opm_t_REGION_CASH set FMA_CASH_REMAINING_AMOUNT='' where FMA_CASH_REMAINING_AMOUNT not like '=%';
    
   update opm_t_REGION_CASH set FMA_COLLECTION_LOAN='' where FMA_COLLECTION_LOAN not like '=%';
    
   update opm_t_REGION_CASH set FMA_CURRENT_EXPENDITURE='' where FMA_CURRENT_EXPENDITURE not like '=%';
    
   update opm_t_REGION_CASH set FMA_DEVELOPMENT_OVERHEAD='' where FMA_DEVELOPMENT_OVERHEAD not like '=%';
    
   update opm_t_REGION_CASH set FMA_ENGINEERING_EXPENDITURE='' where FMA_ENGINEERING_EXPENDITURE not like '=%';
    
   update opm_t_REGION_CASH set FMA_EXPENSES_THE_PERIOD='' where FMA_EXPENSES_THE_PERIOD not like '=%';
    
   update opm_t_REGION_CASH set FMA_FLOW_FUNDS='' where FMA_FLOW_FUNDS not like '=%';
    
   update opm_t_REGION_CASH set FMA_INCREASE_LOAN='' where FMA_INCREASE_LOAN not like '=%';
    
   update opm_t_REGION_CASH set FMA_INVESTMENT_INPUT='' where FMA_INVESTMENT_INPUT not like '=%';
    
   update opm_t_REGION_CASH set FMA_LAND_COST='' where FMA_LAND_COST not like '=%';
    
   update opm_t_REGION_CASH set FMA_OTHER_EXPENSES='' where FMA_OTHER_EXPENSES not like '=%';
    
   update opm_t_REGION_CASH set FMA_OTHER_INPUT='' where FMA_OTHER_INPUT not like '=%';
    
   update opm_t_REGION_CASH set FMA_PRE_PAYMENT='' where FMA_PRE_PAYMENT not like '=%';
    
   update opm_t_REGION_CASH set FMA_REMAINING_AMOUNT='' where FMA_REMAINING_AMOUNT not like '=%';
    
   update opm_t_REGION_CASH set FMA_RENTAL_INCOME='' where FMA_RENTAL_INCOME not like '=%';
    
   update opm_t_REGION_CASH set FMA_SALES_COLLECTION='' where FMA_SALES_COLLECTION not like '=%';
    
   update opm_t_REGION_CASH set FMA_SHAREHOLDER_INPUT='' where FMA_SHAREHOLDER_INPUT not like '=%';
    
   update opm_t_REGION_CASH set FMA_SUBTOTAL_FUND='' where FMA_SUBTOTAL_FUND not like '=%';
    
   update opm_t_REGION_CASH set FMA_TAXES='' where FMA_TAXES not like '=%';
    
   update opm_t_REGION_CASH set FMA_TOTAL_SOURCE_FUNDS='' where FMA_TOTAL_SOURCE_FUNDS not like '=%';

    
   



    
 

   



    
 
