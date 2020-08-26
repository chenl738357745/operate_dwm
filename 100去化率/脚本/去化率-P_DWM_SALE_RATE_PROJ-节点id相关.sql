select  "参数名"||'_type VARCHAR2(50):='''||"参数名"||''';' as  "类型",
 --"参数名"||' VARCHAR2(500);' as  "标准id变量声明",
  "参数名"||' VARCHAR2(50):='''||id||''';' as  "标准变量赋值",备注,
  '----------------------------------------------'||备注||'
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,'||"参数名"||'_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = '||参数名||'                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = ''已审核''   AND plan.plan_type = ''关键节点计划''
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ' as test,
            备注,
'LEFT JOIN tmp_proj_related_date   '||"参数名"||'1 ON project.project_original_id = '||"参数名"||'1.project_id AND '||"参数名"||'1.project_date_type = '||"参数名"||'_type' as leftstr

  --,a.*
from(
SELECT
    (
        CASE
            WHEN node_name = '首开楼栋基础开工'          THEN
                'node_start_work'
            WHEN node_name = '展示区开放（含售楼部、样板间）'   THEN
                'node_exhibit_open'
            WHEN node_name = '规划方案批复'            THEN
                'node_plan_approval'
            WHEN node_name = '土地获取'              THEN
                'node_get_land'
            WHEN node_name = '项目开盘'              THEN
                'node_project_open'
            WHEN node_name = '竣工备案'              THEN
                'node_completed_permit'
        END
    ) as 参数名
    , id ,
     '--备注--'||node_name as 备注
FROM
    pom_standard_node
WHERE
    node_name IN (
        '项目开盘',
        '土地获取',
        '竣工备案',
        '展示区开放（含售楼部、样板间）',
        '规划方案批复',
        '首开楼栋基础开工'
    ))  a;