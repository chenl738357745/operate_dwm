create or replace PROCEDURE "P_DWM_SALE_RATE_PROJ" (
    is_photograph    IN               NUMBER ,
    proj_base_spid   OUT              VARCHAR2
--    
--        ,proj_base out SYS_REFCURSOR
--         ,proj_plan out SYS_REFCURSOR
) AS
		--去化率项目基础数据刷新;作用=>去化率数据定时更新。
        --调用范围：P_DWM_SALE_RATE_BY_PROJ,P_DWM_SALE_RATE_BY_GRANULARITY,根据proj_base_spid使用tmp_proj_base数据
		--作者：陈丽
		--日期：2020-04-10
    spid VARCHAR2(36); --使用临时表的批次号
plan_stage VARCHAR2(360):= '1期,一期,无分期';
node_exhibit_open_type VARCHAR2(50):='node_exhibit_open';
node_plan_approval_type VARCHAR2(50):='node_plan_approval';
node_get_land_type VARCHAR2(50):='node_get_land';
node_start_work_type VARCHAR2(50):='node_start_work';
node_completed_permit_type VARCHAR2(50):='node_completed_permit';
node_project_open_type VARCHAR2(50):='node_project_open';
completion_record_date_type VARCHAR2(50):='completion_record_date';

node_exhibit_open VARCHAR2(50):='988e38a7-77ef-77eb-e053-0100007f3dda';	--备注--展示区开放（含售楼部、样板间）
node_plan_approval VARCHAR2(50):='988e38a7-77fa-77eb-e053-0100007f3dda';	--备注--规划方案批复
node_get_land VARCHAR2(50):='988e38a7-77c3-77eb-e053-0100007f3dda';	--备注--土地获取
node_start_work VARCHAR2(50):='988e38a7-7813-77eb-e053-0100007f3dda';	--备注--首开楼栋基础开工
node_completed_permit VARCHAR2(50):='988e38a7-7878-77eb-e053-0100007f3dda';	--备注--竣工备案
node_project_open VARCHAR2(50):='988e38a7-7827-77eb-e053-0100007f3dda';	--备注--项目开盘
dwm_REMARK VARCHAR2(200):='测试-chenl';
sys_created date:=sysdate;
BEGIN
delete tmp_proj_related_date;
delete tmp_proj_base;
commit;
--------创建临时表批次号
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
--select * from (select obj_phase.*,row_number() over(partition by obj_id order by PHASE_ORDER desc) as order_num from obj_phase )obj_phase_order where order_num = 1
---------------------------------------------------备注--展示区开放（含售楼部、样板间）
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条
    SELECT spid,ps.project_id,node_exhibit_open_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_exhibit_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))   )                        
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name
    ---project_id分组正序取第一条
        )obj) where order_num = 1;  ------------------------------------------------备注
---------------------------------------------------备注--规划方案批复
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)

    select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条
    SELECT spid,ps.project_id,node_plan_approval_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_plan_approval                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name ------------------------------------------------备注
    ---project_id分组正序取第一条
        )obj) where order_num = 1;  

---------------------------------------------------备注--土地获取
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条

    SELECT spid,ps.project_id,node_get_land_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_get_land                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))     )                      
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------备注
    ---project_id分组正序取第一条
        )obj) where order_num = 1;  
---------------------------------------------------备注--首开楼栋基础开工
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条

    SELECT spid,ps.project_id,node_start_work_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_start_work                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------备注
 ---project_id分组正序取第一条
        )obj) where order_num = 1;  
---------------------------------------------------备注--竣工备案
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条

    SELECT spid,ps.project_id,node_completed_permit_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_completed_permit                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'
        and fission_source_original_id is null  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------备注
 ---project_id分组正序取第一条
        )obj) where order_num = 1;  
---------------------------------------------------备注--项目开盘
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
       select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id分组正序取第一条

    SELECT spid,ps.project_id,node_project_open_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------备注
 ---project_id分组正序取第一条
        )obj) where order_num = 1;  
---------------------------------------------------备注20201209--项目分期竣工日期（取数条件，分期下所有楼栋竣工的最后一个楼栋竣工备案证日期）
--多个分期，取最后一个分期的竣工备案日期。
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
       select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----取最新的一个分期
    SELECT spid,ps.project_id,completion_record_date_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划'  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   
------------------------------------------------备注
---project_id分组正序取第一条
        )obj) where order_num = 1;  

    INSERT INTO tmp_proj_base (
        ID,--主键
        PROJECT_ID,--项目ID
        PROJECT_NAME,--项目名称
        ORG_ID,--所属事业部ID
        ORG_NAME,--所属事业部
        FIRST_OPEN_DATE,--首开日期
        OBTAIN_DATE,--项目获得日期
        COMPLETION_RECORD_DATE,--首次竣备日期
        TAKE_LAND_DATE,--拿地日期
        PLAN_FIRST_OPEN_DATE,--计划首开日期
        FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        PLAN_APPROVAL_DATE,--方案批复日期
        PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        IS_OPERATE,--是否操盘
        IS_CONSTRUCTION_BEGAN,--是否已开工

        CREATED,--创建日期
        REMARK--备注信息
    )
        SELECT
            spid                          AS id,
            project.project_original_id   AS project_id,--项目ID
            project.project_name          AS project_name,--项目名称
            project.company_id            AS org_id,--所属事业部ID
            project.company_name          AS org_name,--所属事业部
            node_project_open1.actual_end_date     AS first_open_date,--实际首开时间----1
            node_get_land1.actual_end_date      AS obtain_date,--项目获取日期
            node_completed_permit1.actual_end_date     AS first_completion_record_date,--首次竣备日期------2
            node_get_land1.actual_end_date     AS take_land_date,--拿地日期----3
            node_project_open1.plan_end_date     AS plan_first_open_date,--计划首开日期-----4
            node_project_open1.plan_end_date - node_get_land1.actual_end_date AS first_open_duration_by_plan,--原计划首开时长
            node_project_open1.actual_end_date - node_get_land1.actual_end_date AS first_open_duration_by_tl,--拿地至首开时间
            node_project_open1.estimate_end_date      AS new_plan_first_open_date,--最新预计首开日期----5
            node_exhibit_open1.actual_end_date     AS exhibition_area_open_date,--实际展示区开放时间---6
            node_exhibit_open1.plan_end_date ,--计划展示区开放时间----7
            node_plan_approval1.actual_end_date     AS plan_approval_date,--方案批复时间----7
            node_plan_approval1.plan_end_date  ,--计划方案批复时间----7 
            CASE
                WHEN project.proj_cooperate = '操盘' THEN
                    1
                ELSE
                    0
            END AS is_operate,--as project.PROJ_COOPERATE 是否操盘
            CASE
                WHEN node_start_work1.actual_end_date is not null THEN
                    1
                ELSE
                    0
            END     AS is_construction_began,--是否开工----7

            sys_created,
            '测试' AS remark
        FROM
            mdm_project             project  
--备注--展示区开放（含售楼部、样板间）	
LEFT JOIN tmp_proj_related_date   node_exhibit_open1 ON project.project_original_id = node_exhibit_open1.project_id AND node_exhibit_open1.project_date_type = node_exhibit_open_type
--备注--规划方案批复	
LEFT JOIN tmp_proj_related_date   node_plan_approval1 ON project.project_original_id = node_plan_approval1.project_id AND node_plan_approval1.project_date_type = node_plan_approval_type
--备注--土地获取	
LEFT JOIN tmp_proj_related_date   node_get_land1 ON project.project_original_id = node_get_land1.project_id AND node_get_land1.project_date_type = node_get_land_type
--备注--首开楼栋基础开工	
LEFT JOIN tmp_proj_related_date   node_start_work1 ON project.project_original_id = node_start_work1.project_id AND node_start_work1.project_date_type = node_start_work_type
--备注--竣工备案	
LEFT JOIN tmp_proj_related_date   node_completed_permit1 ON project.project_original_id = node_completed_permit1.project_id AND node_completed_permit1.project_date_type = node_completed_permit_type
--备注--项目开盘	
LEFT JOIN tmp_proj_related_date   node_project_open1 ON project.project_original_id = node_project_open1.project_id AND node_project_open1.project_date_type = node_project_open_type
WHERE project.approval_status = '已审核';

    IF is_photograph <> 0 THEN
--先删除，历史的项目数据，后插入新的数据
        DELETE FROM dwm_sale_rate_project  where CREATED<sys_created;

        INSERT INTO dwm_sale_rate_project (
            ID,--主键
        PROJECT_ID,--项目ID
        PROJECT_NAME,--项目名称
        ORG_ID,--所属事业部ID
        ORG_NAME,--所属事业部
        FIRST_OPEN_DATE,--首开日期
        OBTAIN_DATE,--项目获得日期
        COMPLETION_RECORD_DATE,--首次竣备日期
        TAKE_LAND_DATE,--拿地日期
        PLAN_FIRST_OPEN_DATE,--计划首开日期
        FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        PLAN_APPROVAL_DATE,--方案批复日期
        PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        IS_OPERATE,--是否操盘
        IS_CONSTRUCTION_BEGAN,--是否已开工
        HAS_FIRST_PHASE_KEY_PLAN,--是否已上线关键节点计划
        CREATED,--创建日期
        REMARK--备注信息
        )
            SELECT
        get_uuid,
        base.PROJECT_ID,--项目ID
        base.PROJECT_NAME,--项目名称
        base.ORG_ID,--所属事业部ID
        base.ORG_NAME,--所属事业部
        base.FIRST_OPEN_DATE,--首开日期
        base.OBTAIN_DATE,--项目获得日期
        base.COMPLETION_RECORD_DATE,--首次竣备日期
        base.TAKE_LAND_DATE,--拿地日期
        base.PLAN_FIRST_OPEN_DATE,--计划首开日期
        base.FIRST_OPEN_DURATION_BY_PLAN,--原计划首开时长(10-9)
        base.FIRST_OPEN_DURATION_BY_TL,--拿地至首开时长(6-9)
        base.NEW_PLAN_FIRST_OPEN_DATE,--最新预计首开日期
        base.EXHIBITION_AREA_OPEN_DATE,--展示区开放日期
        base.EXHIBITION_AREA_OPEN_BY_PLAN,--展示区开放计划日期
        base.PLAN_APPROVAL_DATE,--方案批复日期
        base.PLAN_APPROVAL_DATE_BY_PLAN,--方案批复计划日期
        base.IS_OPERATE,--是否操盘
        base.IS_CONSTRUCTION_BEGAN,--是否已开工
        CASE
                WHEN FIRST_OPEN.id is not null THEN
                    1
                ELSE
                    0
        END     AS is_FIRST_OPEN,--是否已上关键节点计划 
        base.CREATED,--创建日期
        dwm_REMARK--备注信息
    FROM tmp_proj_base base
    left join (SELECT ps.id,ps.project_id
    FROM  sys_project_stage  ps
    left join   pom_proj_plan plan  ON ps.id = plan.proj_id  where  ps.IS_FIRST_OPEN_PERIOD=1
    and  plan.approval_status = '已审核'   AND plan.plan_type = '关键节点计划')
    FIRST_OPEN on  base.PROJECT_ID= FIRST_OPEN.project_id 
            WHERE
                base.id = spid;
    commit;
    END IF;
--open proj_base for
--select * from tmp_proj_base;
--open proj_plan for
--select a.*,p.project_name from (
--select project_id,project_date_type,count(*) from tmp_proj_related_date group by project_id,project_date_type
--order by count(*)) a left join sys_project p on a.project_id=p.id
--where a.project_id='b425a08a-9b71-4ab3-801c-48746ac2e2dd';

    proj_base_spid := spid;
END P_DWM_SALE_RATE_PROJ;

