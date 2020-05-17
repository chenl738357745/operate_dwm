-- ------------------------ 未完成的任务和bug
SELECT 外部唯一标识（关键字）
,类型
,result.禅道编号
,优先级
,CONCAT('【',产品,'】','-【',IFNULL(模块名,''),'】-',任务名称) as 任务名称
,资源名称
,剩余工时
,产品
,模块名
, case when  状态='done' then '已完成'
when  状态='closed' then  '关闭'
when 状态='wait' then '未开始'
when  状态='doing' then '进行中'
when  状态='active' then  '激活'
else 状态 end as "任务状态"
,创建时间
,完成时间
,解决人
,CONCAT(备注,';',action.过程备注) as "备注描述"
 FROM (
 /*bug*/
SELECT zt_bug.id AS "禅道编号",keywords AS "外部唯一标识（关键字）",'bug' AS "类型",zt_bug.STATUS AS "状态",zt_project.NAME AS "产品",zt_bug.title AS "任务名称",0 AS "剩余工时",zt_user.realname AS "资源名称",'' AS "备注",zt_bug.pri AS "优先级",zt_bug.openedDate AS '创建时间',zt_bug.closedDate as '完成时间' ,zt_module.name as '模块名',zt_module.id as '模块id',resolvedByu.realname as '解决人'
FROM zt_bug LEFT JOIN zt_project ON zt_bug.product=zt_project.id 
LEFT JOIN zt_user ON zt_bug.assignedTo=zt_user.account
LEFT JOIN zt_user resolvedByu ON zt_bug.resolvedBy=resolvedByu.account
left join zt_module on zt_bug.module=zt_module.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1 
AND zt_bug.STATUS='active' 
AND zt_bug.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')
-- - --------------------------------------------------------------------------------------------------
UNION ALL
/*zt_task*/
SELECT zt_task.id AS "禅道编号",case when zt_task.NAME like '[20%' then LEFT(zt_task.NAME,22) ELSE '' end AS "关键字（外部唯一标识）"
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
,zt_task.STATUS AS "状态",zt_project.NAME AS "产品",zt_task.NAME AS "任务名称"
-- ,cast(zt_task.consumed as decimal(16,2))+cast(zt_task.left as decimal(16,2)) as "工时"
,cast(zt_task.LEFT AS DECIMAL (16,2)) AS "剩余工时",zt_user.realname AS "资源",zt_task.DESC AS "备注",zt_task.pri AS "优先级",zt_task.openedDate AS '创建时间',zt_task.finishedDate '完成时间',zt_module.name as '模块名',zt_module.id as '模块id'
, finishedByu.realname as '完成人'
FROM zt_task LEFT JOIN zt_project ON zt_task.project=zt_project.id 
LEFT JOIN zt_user ON zt_task.assignedTo=zt_user.account
LEFT JOIN zt_user finishedByu ON zt_task.finishedBy=finishedByu.account
left join zt_module on zt_task.module=zt_module.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1 
and zt_task.STATUS IN ('wait','doing') 
AND zt_task.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')
-- - --------------------------------------------------------------------------------------------------
) AS result 
-- -----------------------任务过程
LEFT JOIN (
	SELECT objectID,GROUP_CONCAT(CONCAT(zt_action.extra,":",zt_action.`comment`) SEPARATOR '；') as "过程备注" FROM zt_action
	where zt_action.`comment`<>'' and zt_action.`comment` is not null
	group by objectID ) AS action ON result.禅道编号=action.objectID
order by result.产品,result.模块id,result.类型,result.禅道编号 




