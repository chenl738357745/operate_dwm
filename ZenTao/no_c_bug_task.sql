-- ------------------------ 未完成的任务和bug
SELECT 外部唯一标识（关键字）
-- ,CONCAT('[20200525-20200529]',外部唯一标识（关键字）)
,类型
,result.禅道编号
,优先级
,CONCAT('【',产品,'】','-【',IFNULL(模块名,''),'】-',任务名称) as 任务名称
,任务名称
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
	where result.禅道编号 in (select '2091' id union all
select '3045' id union all
select '3040' id union all
select '3071' id union all
select '3073' id union all
select '3076' id union all
select '3077' id union all
select '3081' id union all
select '3060' id union all
select '3061' id union all
select '3062' id union all
select '3042' id union all
select '3055' id union all
select '3056' id union all
select '3057' id union all
select '3039' id union all
select '3046' id union all
select '3048' id union all
select '3065' id union all
select '3067' id union all
select '3083' id union all
select '3084' id union all
select '3054' id union all
select '3069' id union all
select '3080' id union all
select '2855' id union all
select '3043' id union all
select '3074' id union all
select '2992' id union all
select '2786' id union all
select '3058' id union all
select '3082' id union all
select '3036' id union all
select '3049' id union all
select '3050' id union all
select '3064' id union all
select '2362' id union all
select '2783' id union all
select '3066' id union all
select '3078' id union all
select '2937' id union all
select '3068' id union all
select '2922' id union all
select '2854' id union all
select '3014' id union all
select '3019' id union all
select '3020' id union all
select '3024' id union all
select '3025' id union all
select '2983' id union all
select '2985' id union all
select '2988' id union all
select '2989' id union all
select '2990' id union all
select '2994' id union all
select '2997' id union all
select '2998' id union all
select '3004' id union all
select '3041' id union all
select '3059' id union all
select '3013' id union all
select '3012' id union all
select '3021' id union all
select '3026' id union all
select '3007' id union all
select '3017' id union all
select '3032' id union all
select '3034' id union all
select '3037' id union all
select '2777' id union all
select '3027' id union all
select '3028' id union all
select '2930' id union all
select '2977' id union all
select '3047' id union all
select '3053' id)
order by result.类型,result.优先级,result.产品,result.模块id,result.禅道编号



