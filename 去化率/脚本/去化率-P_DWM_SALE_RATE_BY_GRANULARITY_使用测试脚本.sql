----mssql 
select *,'sum('+�ֶ�+'),--��'+cast(��� as nvarchar(100))+'��'+���� from [dbo].[Table_filed] 
order by (case when ���� like '%/%' or ���� like '%-%'  then 1 else 0 end)