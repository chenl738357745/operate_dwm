
SELECT 外部唯一标识（关键字）
,类型

,result.禅道编号
,优先级
,任务名称
,资源名称
,剩余工时
,产品
, case when 状态='wait' then '未开始'
when  状态='doing' then '进行中'
when  状态='active' then  '激活'
else '其他' end as "任务状态"
,创建时间
,CONCAT(备注,';',action.过程备注) as "备注描述"
 FROM (
 /*bug*/
SELECT zt_bug.id AS "禅道编号",keywords AS "外部唯一标识（关键字）",'bug' AS "类型",zt_bug.STATUS AS "状态",zt_project.NAME AS "产品",CONCAT(zt_project.NAME,':',zt_bug.title) AS "任务名称",0.3 AS "剩余工时",zt_user.realname AS "资源名称",'' AS "备注",zt_bug.pri AS "优先级",zt_bug.openedDate AS '创建时间' FROM zt_bug LEFT JOIN zt_project ON zt_bug.product=zt_project.id LEFT JOIN zt_user ON zt_bug.assignedTo=zt_user.account-- -------------------激活bug
WHERE 1=1 AND zt_bug.STATUS='closed' AND zt_bug.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')
and date_format(zt_bug.lastEditedDate ,'%Y-%m-%d')between current_date()-7 and sysdate()
AND zt_bug.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')
UNION ALL
/*zt_task*/
SELECT zt_task.id AS "禅道编号",'' AS "关键字（外部唯一标识）",'任务' AS "类型",zt_task.STATUS AS "状态",zt_project.NAME AS "产品",CONCAT(zt_project.NAME,':',zt_task.NAME) AS "任务名称"-- ,cast(zt_task.consumed as decimal(16,2))+cast(zt_task.left as decimal(16,2)) as "工时"
,cast(zt_task.LEFT AS DECIMAL (16,2)) AS "剩余工时",zt_user.realname AS "资源",zt_task.DESC AS "备注",zt_task.pri AS "优先级",zt_task.openedDate AS '创建时间' FROM zt_task LEFT JOIN zt_project ON zt_task.project=zt_project.id LEFT JOIN zt_user ON zt_task.assignedTo=zt_user.account-- ---------------- 未开始，进行中的任务
WHERE zt_task.STATUS IN ('wait','doing') AND zt_task.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')-- order by zt_task.status
) AS result 
-- -----------------------任务过程
LEFT JOIN (
	SELECT objectID,GROUP_CONCAT(CONCAT(zt_action.extra,":",zt_action.`comment`) SEPARATOR '；') as "过程备注" FROM zt_action
	where zt_action.`comment`<>'' and zt_action.`comment` is not null
	group by objectID ) AS action ON result.禅道编号=action.objectID
order by result.类型,result.状态,result.禅道编号 





SELECT*FROM zt_storyspec
SELECT STATUS,count(*) FROM zt_task GROUP BY STATUS-- update zt_task set consumed=0.5 where id='1477'
SELECT*FROM zt_bug WHERE id='2872' openedDate-- update zt_bug set  title=CONCAT(title,'=>update-chenltest') where id='1483'
SELECT*FROM zt_product ORDER BY date DESC
SELECT*FROM zt_project WHERE action='estimate'