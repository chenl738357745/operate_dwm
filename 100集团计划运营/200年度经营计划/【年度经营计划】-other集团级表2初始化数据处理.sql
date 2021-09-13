---delete from opm_t_group_cash;

select * from opm_t_group_cash order by lpad( order_code, 10, '0' );

---更新公司类型
update opm_t_group_cash set object_type='公司'  where object_name is null;
update opm_t_group_cash set object_type='总计'  where id like '%总计%' ;
update opm_t_group_cash set object_type='项目'  where object_name is not null ;
-----------------------------

update opm_t_group_cash set level_code=1 where object_type='公司' or object_type='总计';
update opm_t_group_cash set level_code=2 where object_type='项目';
update opm_t_group_cash set OBJECT_NAME=id  where object_type='公司' or object_type='总计';

--按项目名称更新项目 id
UPDATE opm_t_group_cash a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,project_name FROM (
SELECT c.object_name,sp.id,sp.project_name FROM opm_t_group_cash c LEFT JOIN sys_project sp ON c.object_name='中国铁建·' || sp.project_name WHERE sp.id IS NOT NULL)) b WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_group_cash c LEFT JOIN sys_project sp ON c.object_name='中国铁建·' || sp.project_name WHERE sp.id IS NOT NULL);
--更新项目id
--按项目名称更新项目 id
UPDATE opm_t_group_cash a
SET (a.id)=(
SELECT b.id FROM (SELECT object_name,id,org_name FROM (
SELECT c.object_name,sp.id,sp.org_name FROM opm_t_group_cash c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL)) b 
WHERE a.object_name=b.object_name) WHERE a.object_name IN (
SELECT c.object_name FROM opm_t_group_cash c LEFT JOIN SYS_BUSINESS_UNIT sp ON ltrim(c.object_name,substr(c.object_name,1,1))=sp.org_name WHERE sp.id IS NOT NULL);

select ' update opm_t_group_cash set parent_id='''||id||'''  where order_code>'||order_code||' and  object_type=''项目'';' from  opm_t_group_cash where object_type='公司' order by lpad( order_code, 10, '0' );

  update opm_t_group_cash set parent_id='86e785dc-29ed-4686-8cc8-1bec845a5015'  where order_code>2 and  object_type='项目';
 update opm_t_group_cash set parent_id='530e42a3-5a72-4e2a-b3b3-35cd1814e6aa'  where order_code>30 and  object_type='项目';
 update opm_t_group_cash set parent_id='45e9c408-dd59-4a41-8c50-7b4eaf6c1e46'  where order_code>66 and  object_type='项目';
 update opm_t_group_cash set parent_id='a512f09f-503c-4aef-9c63-e057d8913e38'  where order_code>96 and  object_type='项目';
 update opm_t_group_cash set parent_id='21713e28-651a-4dc5-bcb5-40e3cdc09f5f'  where order_code>133 and  object_type='项目';
 update opm_t_group_cash set parent_id='379fe3db-6e83-4819-8d09-4dbe06342d6e'  where order_code>145 and  object_type='项目';
 update opm_t_group_cash set parent_id='a44081a7-417c-43ba-9e47-cbb0f661ff91'  where order_code>161 and  object_type='项目';
 update opm_t_group_cash set parent_id='7861fcbd-9f79-4ea3-bc28-daecbd6f8590'  where order_code>174 and  object_type='项目';
 update opm_t_group_cash set parent_id='0c0401a2-6fd5-435c-8091-b3a038547303'  where order_code>184 and  object_type='项目';
 update opm_t_group_cash set parent_id='十二创新投资公司'  where order_code>195 and  object_type='项目';
 update opm_t_group_cash set parent_id='十三文旅公司'  where order_code>203 and  object_type='项目';
 update opm_t_group_cash set parent_id='十四南沙公司'  where order_code>207 and  object_type='项目';
 update opm_t_group_cash set parent_id='十五贵州公司'  where order_code>226 and  object_type='项目';
 update opm_t_group_cash set parent_id='十七海外筹备组'  where order_code>240 and  object_type='项目';
 update opm_t_group_cash set parent_id='十八雄安公司'  where order_code>243 and  object_type='项目';
 update opm_t_group_cash set parent_id='十九城市发展公司'  where order_code>247 and  object_type='项目';
 update opm_t_group_cash set parent_id='二十济南公司'  where order_code>250 and  object_type='项目';
 update opm_t_group_cash set parent_id='二十一淄博项目筹备组'  where order_code>252 and  object_type='项目';
 update opm_t_group_cash set parent_id='3d1a9e95-4cbe-45d0-b13c-3ca89007669b'  where order_code>254 and  object_type='项目';
 update opm_t_group_cash set parent_id='十一设计咨询'  where order_code>255 and  object_type='项目';
 update opm_t_group_cash set parent_id='十六投资管理公司'  where order_code>256 and  object_type='项目';
 update opm_t_group_cash set parent_id='二十二集团本级'  where order_code>257 and  object_type='项目';
 
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

    
   



    
 
