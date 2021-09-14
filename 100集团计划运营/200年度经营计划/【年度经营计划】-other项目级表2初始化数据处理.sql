---delete from OPM_T_REGION_CASH;

---delete from opm_t_REGION_CASH;

select * from opm_t_REGION_CASH order by lpad( order_code, 10, '0' );

---更新公司类型
update opm_t_REGION_CASH set object_type='公司'  where object_name is null;
update opm_t_REGION_CASH set object_type='总计'  where id like '%总计%' ;
update opm_t_REGION_CASH set object_type='项目'  where object_name is not null ;
-----------------------------

update opm_t_REGION_CASH set level_code=1 where object_type='公司' or object_type='总计';
update opm_t_REGION_CASH set level_code=2 where object_type='项目';
update opm_t_REGION_CASH set OBJECT_NAME=id  where object_type='公司' or object_type='总计';

--按项目名称更新项目 id
UPDATE opm_t_REGION_CASH a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,project_name FROM (
SELECT c.object_name,sp.id,sp.project_name FROM opm_t_REGION_CASH c LEFT JOIN sys_project sp ON c.object_name='中国铁建·' || sp.project_name WHERE sp.id IS NOT NULL)) b WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_REGION_CASH c LEFT JOIN sys_project sp ON c.object_name='中国铁建·' || sp.project_name WHERE sp.id IS NOT NULL);
--更新项目id
--按项目名称更新公司 id
UPDATE opm_t_REGION_CASH a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,org_name FROM (
SELECT c.object_name,sp.id,sp.org_name FROM opm_t_REGION_CASH c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL)) b 
WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_REGION_CASH c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL);


update opm_t_REGION_CASH set BELONG_REGION_ID='86e785dc-29ed-4686-8cc8-1bec845a5015';


select ' update opm_t_REGION_CASH set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''项目'';' from  opm_t_REGION_CASH where object_type='公司' order by lpad( order_code, 10, '0' );

  update opm_t_REGION_CASH set parent_id='86e785dc-29ed-4686-8cc8-1bec845a5015'  where order_code>1 and  object_type='项目';
 
 select '    
   update opm_t_REGION_CASH set '||ut.COLUMN_NAME||'='''' where '||ut.COLUMN_NAME||' not like ''=%'';',
      ut.COLUMN_NAME||',-----',--字段名称
      uc.comments,--字段注释
      ut.DATA_TYPE,--字典类型
      ut.DATA_LENGTH,--字典长度
      ut.NULLABLE--是否为空
from user_tab_columns  ut
inner JOIN user_col_comments uc
on ut.TABLE_NAME  = uc.table_name and ut.COLUMN_NAME = uc.column_name
where ut.Table_Name='OPM_T_REGION_CASH' and ut.COLUMN_NAME like '%FMA%'
order by ut.column_name;

    
       
  

    
   



    
 

   



    
 
