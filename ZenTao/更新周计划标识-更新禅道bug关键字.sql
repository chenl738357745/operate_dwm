update zt_bug a set keywords=(select b.id1  from (select '[20200511-20200515]-01' id1 ,'2865' id union all 
select '[20200511-20200515]-02' id1 ,'2797' id union all 
select '[20200511-20200515]-03' id1 ,'2746' id union all 
select '[20200511-20200515]-04' id1 ,'2871' id union all 
select '[20200511-20200515]-05' id1 ,'2874' id union all 
select '[20200511-20200515]-06' id1 ,'2877' id union all 
select '[20200511-20200515]-07' id1 ,'1486' id union all 
select '[20200511-20200515]-13' id1 ,'1492' id union all 
select '[20200511-20200515]-14' id1 ,'2793' id union all 
select '[20200511-20200515]-15' id1 ,'2774' id union all 
select '[20200511-20200515]-16' id1 ,'1389' id union all 
select '[20200511-20200515]-17' id1 ,'2807' id union all 
select '[20200511-20200515]-21' id1 ,'2733' id union all 
select '[20200511-20200515]-22' id1 ,'1145' id union all 
select '[20200511-20200515]-23' id1 ,'2761' id union all 
select '[20200511-20200515]-24' id1 ,'2587' id union all 
select '[20200511-20200515]-25' id1 ,'2864' id union all 
select '[20200511-20200515]-26' id1 ,'2494' id union all 
select '[20200511-20200515]-27' id1 ,'2782' id union all 
select '[20200511-20200515]-28' id1 ,'2803' id union all 
select '[20200511-20200515]-29' id1 ,'2492' id union all 
select '[20200511-20200515]-30' id1 ,'2440' id union all 
select '[20200511-20200515]-31' id1 ,'2785' id union all 
select '[20200511-20200515]-32' id1 ,'2560' id union all 
select '[20200511-20200515]-33' id1 ,'2091' id union all 
select '[20200511-20200515]-34' id1 ,'1490' id union all 
select '[20200511-20200515]-35' id1 ,'1491' id union all 
select '[20200511-20200515]-39' id1 ,'2730' id union all 
select '[20200511-20200515]-40' id1 ,'2763' id union all 
select '[20200511-20200515]-41' id1 ,'2787' id union all 
select '[20200511-20200515]-42' id1 ,'2662' id ) b  where  a.id=b.id)
WHERE  a.id  in (select b.id from (select '[20200511-20200515]-01' id1 ,'2865' id union all 
select '[20200511-20200515]-02' id1 ,'2797' id union all 
select '[20200511-20200515]-03' id1 ,'2746' id union all 
select '[20200511-20200515]-04' id1 ,'2871' id union all 
select '[20200511-20200515]-05' id1 ,'2874' id union all 
select '[20200511-20200515]-06' id1 ,'2877' id union all 
select '[20200511-20200515]-07' id1 ,'1486' id union all 
select '[20200511-20200515]-13' id1 ,'1492' id union all 
select '[20200511-20200515]-14' id1 ,'2793' id union all 
select '[20200511-20200515]-15' id1 ,'2774' id union all 
select '[20200511-20200515]-16' id1 ,'1389' id union all 
select '[20200511-20200515]-17' id1 ,'2807' id union all 
select '[20200511-20200515]-21' id1 ,'2733' id union all 
select '[20200511-20200515]-22' id1 ,'1145' id union all 
select '[20200511-20200515]-23' id1 ,'2761' id union all 
select '[20200511-20200515]-24' id1 ,'2587' id union all 
select '[20200511-20200515]-25' id1 ,'2864' id union all 
select '[20200511-20200515]-26' id1 ,'2494' id union all 
select '[20200511-20200515]-27' id1 ,'2782' id union all 
select '[20200511-20200515]-28' id1 ,'2803' id union all 
select '[20200511-20200515]-29' id1 ,'2492' id union all 
select '[20200511-20200515]-30' id1 ,'2440' id union all 
select '[20200511-20200515]-31' id1 ,'2785' id union all 
select '[20200511-20200515]-32' id1 ,'2560' id union all 
select '[20200511-20200515]-33' id1 ,'2091' id union all 
select '[20200511-20200515]-34' id1 ,'1490' id union all 
select '[20200511-20200515]-35' id1 ,'1491' id union all 
select '[20200511-20200515]-39' id1 ,'2730' id union all 
select '[20200511-20200515]-40' id1 ,'2763' id union all 
select '[20200511-20200515]-41' id1 ,'2787' id union all 
select '[20200511-20200515]-42' id1 ,'2662' id ) b)
;





-- update zt_bug set title = Replace(title,'[20200511-20200515]','')  where title like '[20200511-20200515]%'
-- select * from zt_bug