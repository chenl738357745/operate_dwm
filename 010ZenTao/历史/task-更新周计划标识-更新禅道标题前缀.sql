update zt_task a set deadline=(select b.id1  from 
(select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1327' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1492' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1496' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1497' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1498' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1499' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1507' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1508' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1509' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1510' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1511' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1512' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1513' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1514' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1515' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1516' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1517' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1518' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1519' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1520' id   )b  where  a.id=b.id)
WHERE  a.id  in (select b.id from 
(select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1327' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1492' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1496' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1497' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1498' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1499' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1507' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1508' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1509' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1510' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1511' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1512' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1513' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1514' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1515' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'1516' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'1517' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1518' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'1519' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'1520' id  )
 b)
;


select deadline from zt_task


-- update zt_bug set title = Replace(title,'[20200511-20200515]','')  where title like '[20200511-20200515]%'
-- select * from zt_bug