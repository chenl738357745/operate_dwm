----mssql 
select *,'sum('+×Ö¶Î+'),--¡¾'+cast(ĞòºÅ as nvarchar(100))+'¡¿'+ÃèÊö from [dbo].[Table_filed] 
order by (case when ÃèÊö like '%/%' or ÃèÊö like '%-%'  then 1 else 0 end)