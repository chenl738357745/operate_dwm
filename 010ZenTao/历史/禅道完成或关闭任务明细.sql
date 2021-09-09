-- ------------------------ 未完成的任务和bug
SELECT result.*
,CONCAT(备注,';',action.过程备注) as "备注描述"
 FROM (
 /*zt_task*/
SELECT zt_task.id AS "禅道编号"
, finishedByu.realname as '完成人',zt_task.finishedDate as '完成时间'
,zt_task.estimate as '预计工时'
,cast(zt_task.consumed as decimal(16,2))+cast(zt_task.left as decimal(16,2)) as "实际工时"

,CONCAT(case when zt_task.parent=0  then '任务' else '子任务' end,'-',
case when zt_task.type='design' then '设计'
 when zt_task.type= 'devel' then '开发'
 when zt_task.type= 'document' then '文档'
 when zt_task.type= 'manager' then '项目管理'
 when zt_task.type= 'research' then '研究'
 when zt_task.type= 'review' then '评审'
 when zt_task.type= 'test' then '测试'
else zt_task.type end)
AS "类型"
, case when  zt_task.STATUS='done' then '已完成'
when  zt_task.STATUS='closed' then  '关闭'
when zt_task.STATUS='wait' then '未开始'
when  zt_task.STATUS='doing' then '进行中'
when  zt_task.STATUS='active' then  '激活' else zt_task.STATUS end as "任务状态" 
,zt_project.NAME AS "产品"
,cast(zt_task.LEFT AS DECIMAL (16,2)) AS "剩余工时"
,zt_user.realname AS "资源名称"
,zt_story.title as "需求标题"
,zt_task.pri AS "优先级"
,zt_task.openedDate AS '创建时间'
,zt_task.deadline '最晚时间'
,zt_task.NAME AS "任务名称"
,zt_task.DESC AS "备注",zt_module.name as '模块名',zt_module.id as '模块id'
,case when zt_task.NAME like '[20%' then LEFT(zt_task.NAME,22) ELSE '' end AS "关键字（外部唯一标识）"
FROM zt_task LEFT JOIN zt_project ON zt_task.project=zt_project.id 
LEFT JOIN zt_user ON zt_task.assignedTo=zt_user.account
LEFT JOIN zt_user finishedByu ON zt_task.finishedBy=finishedByu.account
left join zt_module on zt_task.module=zt_module.id
left join zt_story on zt_task.story=zt_story.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1
and zt_task.STATUS IN ('done','closed') 
AND zt_task.deleted='0'
-- 关闭时间在本月
and DATE_FORMAT( zt_task.finishedDate, '%Y%m' ) = DATE_FORMAT( CURDATE() , '%Y%m' )
-- 关闭时间在上月
-- and PERIOD_DIFF( date_format( now() , '%Y%m' ) ,date_format( zt_task.finishedDate, '%Y%m' ) ) =1
-- 完成时间在本月
-- - --------------------------------------------------------------------------------------------------
) AS result 
-- -----------------------任务过程
LEFT JOIN (
	SELECT objectID,GROUP_CONCAT(CONCAT(zt_action.extra,":",zt_action.`comment`) SEPARATOR '；') as "过程备注" FROM zt_action
	where zt_action.`comment`<>'' and zt_action.`comment` is not null 
	group by objectID ) AS action ON result.禅道编号=action.objectID
	-- where   result.任务名称 like '%集团测试%'
	order by result.产品,result.完成时间
	

	



