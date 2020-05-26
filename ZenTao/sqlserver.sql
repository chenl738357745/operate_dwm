---mysql 用于生成更新计划完成时间
select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---mysql 用于生成更新标识
select 'select '''+test2+''' id1 ,'''+test1+''' id union all' from [dbo].[Table_1];

select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];