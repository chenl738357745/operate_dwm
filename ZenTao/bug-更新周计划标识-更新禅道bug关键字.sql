update zt_bug a set keywords=(select b.id1  from (select '[20200518-20200522]-1[20200511-20200515]-28' id1 ,'2803' id union all 
select '[20200518-20200522]-2' id1 ,'2906' id union all 
select '[20200518-20200522]-3' id1 ,'2798' id union all 
select '[20200518-20200522]-4' id1 ,'2922' id union all 
select '[20200518-20200522]-5' id1 ,'2779' id union all 
select '[20200518-20200522]-6' id1 ,'2799' id union all 
select '[20200518-20200522]-7' id1 ,'2854' id union all 
select '[20200518-20200522]-8' id1 ,'2855' id union all 
select '[20200518-20200522]-9[20200511-20200515]-33' id1 ,'2091' id union all 
select '[20200518-20200522]-10[20200511-20200515]-24' id1 ,'2587' id union all 
select '[20200518-20200522]-11' id1 ,'2312' id union all 
select '[20200518-20200522]-12[20200511-20200515]-39' id1 ,'2730' id union all 
select '[20200518-20200522]-13' id1 ,'2868' id union all 
select '[20200518-20200522]-14' id1 ,'2876' id union all 
select '[20200518-20200522]-15' id1 ,'2917' id union all 
select '[20200518-20200522]-16' id1 ,'2959' id union all 
select '[20200518-20200522]-17' id1 ,'2392' id union all 
select '[20200518-20200522]-18' id1 ,'2951' id union all 
select '[20200518-20200522]-19' id1 ,'2786' id union all 
select '[20200518-20200522]-20' id1 ,'2960' id union all 
select '[20200518-20200522]-21' id1 ,'2935' id union all 
select '[20200518-20200522]-22' id1 ,'2944' id union all 
select '[20200518-20200522]-23' id1 ,'2945' id union all 
select '[20200518-20200522]-24' id1 ,'2947' id union all 
select '[20200518-20200522]-25' id1 ,'2953' id union all 
select '[20200518-20200522]-26' id1 ,'2362' id union all 
select '[20200518-20200522]-27' id1 ,'2777' id union all 
select '[20200518-20200522]-28' id1 ,'2783' id union all 
select '[20200518-20200522]-29' id1 ,'2930' id union all 
select '[20200518-20200522]-30' id1 ,'2857' id union all 
select '[20200518-20200522]-31' id1 ,'2955' id union all 
select '[20200518-20200522]-32' id1 ,'2957' id union all 
select '[20200518-20200522]-33' id1 ,'2937' id union all 
select '[20200518-20200522]-34' id1 ,'2938' id union all 
select '[20200518-20200522]-35' id1 ,'2950' id ) b  where  a.id=b.id)
WHERE  a.id  in (select b.id from (select '[20200518-20200522]-1[20200511-20200515]-28' id1 ,'2803' id union all 
select '[20200518-20200522]-2' id1 ,'2906' id union all 
select '[20200518-20200522]-3' id1 ,'2798' id union all 
select '[20200518-20200522]-4' id1 ,'2922' id union all 
select '[20200518-20200522]-5' id1 ,'2779' id union all 
select '[20200518-20200522]-6' id1 ,'2799' id union all 
select '[20200518-20200522]-7' id1 ,'2854' id union all 
select '[20200518-20200522]-8' id1 ,'2855' id union all 
select '[20200518-20200522]-9[20200511-20200515]-33' id1 ,'2091' id union all 
select '[20200518-20200522]-10[20200511-20200515]-24' id1 ,'2587' id union all 
select '[20200518-20200522]-11' id1 ,'2312' id union all 
select '[20200518-20200522]-12[20200511-20200515]-39' id1 ,'2730' id union all 
select '[20200518-20200522]-13' id1 ,'2868' id union all 
select '[20200518-20200522]-14' id1 ,'2876' id union all 
select '[20200518-20200522]-15' id1 ,'2917' id union all 
select '[20200518-20200522]-16' id1 ,'2959' id union all 
select '[20200518-20200522]-17' id1 ,'2392' id union all 
select '[20200518-20200522]-18' id1 ,'2951' id union all 
select '[20200518-20200522]-19' id1 ,'2786' id union all 
select '[20200518-20200522]-20' id1 ,'2960' id union all 
select '[20200518-20200522]-21' id1 ,'2935' id union all 
select '[20200518-20200522]-22' id1 ,'2944' id union all 
select '[20200518-20200522]-23' id1 ,'2945' id union all 
select '[20200518-20200522]-24' id1 ,'2947' id union all 
select '[20200518-20200522]-25' id1 ,'2953' id union all 
select '[20200518-20200522]-26' id1 ,'2362' id union all 
select '[20200518-20200522]-27' id1 ,'2777' id union all 
select '[20200518-20200522]-28' id1 ,'2783' id union all 
select '[20200518-20200522]-29' id1 ,'2930' id union all 
select '[20200518-20200522]-30' id1 ,'2857' id union all 
select '[20200518-20200522]-31' id1 ,'2955' id union all 
select '[20200518-20200522]-32' id1 ,'2957' id union all 
select '[20200518-20200522]-33' id1 ,'2937' id union all 
select '[20200518-20200522]-34' id1 ,'2938' id union all 
select '[20200518-20200522]-35' id1 ,'2950' id 
 ) b)
;





-- update zt_bug set title = Replace(title,'[20200511-20200515]','')  where title like '[20200511-20200515]%'
-- select * from zt_bug