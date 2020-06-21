-- ------------------------ 未完成的任务和bug
set @rownum=0;
SELECT 
result.禅道编号
,产品
,IFNULL(模块名,'') as 模块名
,优先级
,任务名称
,创建时间
,bug关闭时间
,解决时间
,关闭人
,解决人

,CONCAT(备注,';',action.过程备注) as "备注描述"
 FROM (
 /*bug*/
SELECT zt_bug.id AS "禅道编号",keywords AS "外部唯一标识（关键字）",'bug' AS "类型",zt_bug.STATUS AS "状态",zt_project.NAME AS "产品",zt_bug.title AS "任务名称",0 AS "剩余工时",zt_user.realname AS "资源名称",'' AS "备注",zt_bug.pri AS "优先级",zt_bug.openedDate AS '创建时间' ,zt_module.name as '模块名',zt_module.id as '模块id',resolvedByu.realname as '解决人',zt_bug.resolvedDate as  '解决时间',zt_bug.closedDate as 'bug关闭时间',uClosedBy.realname as '关闭人'
FROM zt_bug LEFT JOIN zt_project ON zt_bug.product=zt_project.id 
LEFT JOIN zt_user ON zt_bug.assignedTo=zt_user.account
-- resolvedBy
LEFT JOIN zt_user resolvedByu ON zt_bug.resolvedBy=resolvedByu.account
-- closedBy
LEFT JOIN zt_user uClosedBy ON zt_bug.closedBy=uClosedBy.account
left join zt_module on zt_bug.module=zt_module.id
-- - --------------------------------------------------------------------------------------------------
WHERE 1=1 
AND zt_bug.STATUS='closed' 
-- and YEARWEEK(date_format(closedDate,'%Y-%m-%d')) = YEARWEEK(now())
and DATE_SUB(now(), INTERVAL 7 DAY) <=date(zt_bug.closedDate)
AND zt_bug.deleted='0' AND zt_project.NAME IN ('计划移动端','计划运营管理')
-- - --------------------------------------------------------------------------------------------------

-- - --------------------------------------------------------------------------------------------------
) AS result 
-- -----------------------任务过程
LEFT JOIN (
	SELECT objectID,GROUP_CONCAT(CONCAT(zt_action.extra,":",zt_action.`comment`) SEPARATOR '；') as "过程备注" FROM zt_action
	where zt_action.`comment`<>'' and zt_action.`comment` is not null
	group by objectID ) AS action ON result.禅道编号=action.objectID 
	-- 测试需要
where	result.禅道编号<>1327
order by result.模块名,result.bug关闭时间


 

