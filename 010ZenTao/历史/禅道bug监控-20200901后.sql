-- ------------------------ bug
SELECT 
result.*
,action.过程备注 as "备注描述"
 FROM (
 /*bug*/
SELECT zt_bug.id AS "禅道编号"
,case when  zt_bug.STATUS='done' then '已完成'
when  zt_bug.STATUS='closed' then  '关闭'
when zt_bug.STATUS='wait' then '未开始'
when  zt_bug.STATUS='doing' then '进行中'
when  zt_bug.STATUS='active' then  '激活'
else zt_bug.STATUS end as "状态"
,zt_project.NAME AS "产品"
,zt_bug.title AS "任务名称"
,zt_user.realname AS "指派给"
,zt_bug.pri AS "优先级"
,zt_bug.openedDate AS '创建时间'
,zt_bug.closedDate as '完成时间' 
,zt_module.name as '模块名'
,zt_module.id as '模块id'
,resolvedByu.realname as '解决人'
,zt_bug.deadline as '最后期限'
,year(zt_bug.deadline) '年'
,month(zt_bug.deadline) '月'
,week(zt_bug.deadline) '周' 
,week(curdate()) '本周' 
,case when week(zt_bug.deadline)-week(curdate()) =0 then '本周'
when 1 then '下周'
when 2 then '下下周'
when -1 then '上周'
when -2 then '上上周'
else '' end '看周'
,case when month(zt_bug.deadline)-month(curdate()) =0 then '本月'
when 1 then '下月'
when 2 then '下下月'
when -1 then '上月'
when -2 then '上上月'
else '' end '看月'


FROM zt_bug LEFT JOIN zt_project ON zt_bug.product=zt_project.id 
LEFT JOIN zt_user ON zt_bug.openedby=zt_user.account
LEFT JOIN zt_user resolvedByu ON zt_bug.resolvedBy=resolvedByu.account
left join zt_module on zt_bug.module=zt_module.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1 
and (DATE_SUB(str_to_date('2020-09-01', '%Y-%m-%d %H'), INTERVAL -1 DAY) <=date(zt_bug.closedDate) or  zt_bug.closedDate is null)
-- - --------------------------------------------------------------------------------------------------
) AS result 
-- -----------------------任务过程
LEFT JOIN (
	SELECT objectID,GROUP_CONCAT(CONCAT(zt_action.extra,":",zt_action.`comment`) SEPARATOR '；') as "过程备注" FROM zt_action
	where zt_action.`comment`<>'' and zt_action.`comment` is not null 
	group by objectID ) AS action ON result.禅道编号=action.objectID
	-- where   result.任务名称 like '%集团测试%'
	order by result.产品,result.模块id,result.优先级,result.禅道编号



