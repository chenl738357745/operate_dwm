---mysql �������ɸ��¼ƻ����ʱ��
select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---mysql �������ɸ��±�ʶ
select 'select '''+test2+''' id1 ,'''+test1+''' id union all' from [dbo].[Table_1];

select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];