---delete from opm_t_group_cash;

select * from opm_t_group_cash order by lpad( order_code, 10, '0' );

---更新公司类型
update opm_t_group_cash set object_type='公司'  where object_name is null;
update opm_t_group_cash set object_type='总计'  where id like '%总计%' ;
update opm_t_group_cash set object_type='项目'  where object_name is not null ;
-----------------------------

update opm_t_group_cash set level_code=1 where object_type='公司' or object_type='总计';
update opm_t_group_cash set level_code=2 where object_type='项目';

select ' update opm_t_group_cash set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''项目'';' from  opm_t_group_cash where id like '%公司%' order by lpad( order_code, 10, '0' );

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
  




    
 
