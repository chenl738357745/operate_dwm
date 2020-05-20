update zt_bug a set deadline=(select b.id1  from (select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2091' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2312' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2362' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'2587' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2730' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2777' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2779' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2783' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2786' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2798' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2799' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2803' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2854' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2855' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2857' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2868' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2876' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2906' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2917' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2922' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2930' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2935' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2937' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2938' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2945' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2947' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2950' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2951' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2953' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2955' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2957' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2959' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2960' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2961' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2962' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2963' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2964' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2965' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2966' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2967' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2968' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2969' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'2970' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2971' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2974' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2975' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2976' id  ) b  where  a.id=b.id)
WHERE  a.id  in (select b.id from (select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2091' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2312' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2362' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'2587' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2730' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2777' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2779' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2783' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2786' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2798' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2799' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2803' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2854' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2855' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2857' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2868' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2876' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2906' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2917' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2922' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2930' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2935' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2937' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2938' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2945' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2947' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2950' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2951' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2953' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2955' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2957' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2959' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2960' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2961' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2962' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2963' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2964' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2965' id union all 
select str_to_date('2020/5/21', '%Y/%m/%d %H') id1 ,'2966' id union all 
select str_to_date('2020/5/19', '%Y/%m/%d %H') id1 ,'2967' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2968' id union all 
select str_to_date('2020/5/20', '%Y/%m/%d %H') id1 ,'2969' id union all 
select str_to_date('2020/5/22', '%Y/%m/%d %H') id1 ,'2970' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2971' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2974' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2975' id union all 
select str_to_date('2020/5/18', '%Y/%m/%d %H') id1 ,'2976' id 
 ) b)
;


select * from zt_bug where id=2974


-- update zt_bug set title = Replace(title,'[20200511-20200515]','')  where title like '[20200511-20200515]%'
-- select * from zt_bug