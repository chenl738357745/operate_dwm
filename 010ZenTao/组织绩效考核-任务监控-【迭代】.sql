-- ------------------------ 未完成的任务和bug
SELECT result.*
,CONCAT(备注,';',action.过程备注) as "备注描述"
 FROM (
 /*zt_task*/
SELECT zt_task.id AS "禅道编号"
,case when YEARWEEK(DATE_FORMAT(zt_task.deadline,'%Y-%m-%d'))=YEARWEEK(CURDATE())
then '本周'
when YEARWEEK(DATE_FORMAT(zt_task.deadline,'%Y-%m-%d')) = YEARWEEK(CURDATE()) + 1 
then '下周'
when YEARWEEK(DATE_FORMAT(zt_task.deadline,'%Y-%m-%d'))<YEARWEEK(CURDATE())
then '本周前'
else '下周后' end as '预计完成周'
, finishedByu.realname as '完成人',zt_task.finishedDate as '完成时间'
,zt_task.estimate as '预计工时'
,cast(zt_task.consumed as decimal(16,2)) as "实际工时"

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
,cast(zt_task.LEFT AS DECIMAL (16,2)) AS "剩余工时"
,zt_user.realname AS "资源名称"
,zt_task.openedDate AS '创建时间'
,zt_task.lastEditedDate as '最后修改时间'
,zt_task.deadline '最晚时间'

,zt_task.NAME AS "任务名称"
,zt_story.title as "需求标题"
,zt_project.NAME AS "产品"
,zt_task.pri AS "优先级"

,zt_task.DESC AS "备注",zt_module.name as '模块名',zt_module.id as '模块id'
,case when zt_task.NAME like '[20%' then LEFT(zt_task.NAME,22) ELSE '' end AS "关键字（外部唯一标识）"
FROM zt_task LEFT JOIN zt_project ON zt_task.project=zt_project.id 
LEFT JOIN zt_user ON zt_task.assignedTo=zt_user.account
LEFT JOIN zt_user finishedByu ON zt_task.finishedBy=finishedByu.account
left join zt_module on zt_task.module=zt_module.id
left join zt_story on zt_task.story=zt_story.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1
-- and zt_task.STATUS IN ('done','closed') 
AND zt_task.deleted='0'
-- 关闭时间大于 xxx
and (DATE_SUB(str_to_date('2020-8-01', '%Y-%m-%d %H'), INTERVAL -1 DAY) <=date(zt_task.closedDate) or  zt_task.closedDate is null)
-- 本周 或 下周
-- and (
-- YEARWEEK(DATE_FORMAT(zt_task.finishedDate,'%Y-%m-%d')) = YEARWEEK(NOW())
-- or YEARWEEK(DATE_FORMAT(zt_task.deadline,'%Y-%m-%d')) = YEARWEEK(CURDATE())
-- or YEARWEEK(DATE_FORMAT(zt_task.deadline,'%Y-%m-%d')) = YEARWEEK(CURDATE()) + 1)
-- 
-- 当天
-- and (date(zt_task.finishedDate) = curdate() or date(zt_task.openedDate) = curdate() or  date(zt_task.lastEditedDate) = curdate())
-- 关闭时间在本月
-- and DATE_FORMAT( zt_task.finishedDate, '%Y%m' ) = DATE_FORMAT( CURDATE() , '%Y%m' )
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
	 where  1=1 -- and result.产品 like '%【组织绩效考核】专项开发-西南ERP计划系统%'
	order by result.产品,result.完成时间 desc,result.最后修改时间 desc ,result.创建时间 desc