select  "������"||'_type VARCHAR2(50):='''||"������"||''';' as  "����",
 --"������"||' VARCHAR2(500);' as  "��׼id��������",
  "������"||' VARCHAR2(50):='''||id||''';' as  "��׼������ֵ",��ע,
  '----------------------------------------------'||��ע||'
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    SELECT spid,ps.project_id,'||"������"||'_type,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = '||������||'                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  AND stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))                           
        WHERE   plan.approval_status = ''�����''   AND plan.plan_type = ''�ؼ��ڵ�ƻ�''
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name;  ' as test,
            ��ע,
'LEFT JOIN tmp_proj_related_date   '||"������"||'1 ON project.project_original_id = '||"������"||'1.project_id AND '||"������"||'1.project_date_type = '||"������"||'_type' as leftstr

  --,a.*
from(
SELECT
    (
        CASE
            WHEN node_name = '�׿�¥����������'          THEN
                'node_start_work'
            WHEN node_name = 'չʾ�����ţ�����¥��������䣩'   THEN
                'node_exhibit_open'
            WHEN node_name = '�滮��������'            THEN
                'node_plan_approval'
            WHEN node_name = '���ػ�ȡ'              THEN
                'node_get_land'
            WHEN node_name = '��Ŀ����'              THEN
                'node_project_open'
            WHEN node_name = '��������'              THEN
                'node_completed_permit'
        END
    ) as ������
    , id ,
     '--��ע--'||node_name as ��ע
FROM
    pom_standard_node
WHERE
    node_name IN (
        '��Ŀ����',
        '���ػ�ȡ',
        '��������',
        'չʾ�����ţ�����¥��������䣩',
        '�滮��������',
        '�׿�¥����������'
    ))  a;