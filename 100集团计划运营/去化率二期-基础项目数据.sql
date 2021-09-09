create or replace PROCEDURE "P_DWM_SALE_RATE_PROJ" (
    is_photograph    IN               NUMBER ,
    proj_base_spid   OUT              VARCHAR2
--    
--        ,proj_base out SYS_REFCURSOR
--         ,proj_plan out SYS_REFCURSOR
) AS
		--ȥ������Ŀ��������ˢ��;����=>ȥ�������ݶ�ʱ���¡�
        --���÷�Χ��P_DWM_SALE_RATE_BY_PROJ,P_DWM_SALE_RATE_BY_GRANULARITY,����proj_base_spidʹ��tmp_proj_base����
		--���ߣ�����
		--���ڣ�2020-04-10
    spid VARCHAR2(36); --ʹ����ʱ������κ�
plan_stage VARCHAR2(360):= '1��,һ��,�޷���';
node_exhibit_open_type VARCHAR2(50):='node_exhibit_open';
node_plan_approval_type VARCHAR2(50):='node_plan_approval';
node_get_land_type VARCHAR2(50):='node_get_land';
node_start_work_type VARCHAR2(50):='node_start_work';
node_completed_permit_type VARCHAR2(50):='node_completed_permit';
node_project_open_type VARCHAR2(50):='node_project_open';
completion_record_date_type VARCHAR2(50):='completion_record_date';

node_exhibit_open VARCHAR2(50):='988e38a7-77ef-77eb-e053-0100007f3dda';	--��ע--չʾ�����ţ�����¥��������䣩
node_plan_approval VARCHAR2(50):='988e38a7-77fa-77eb-e053-0100007f3dda';	--��ע--�滮��������
node_get_land VARCHAR2(50):='988e38a7-77c3-77eb-e053-0100007f3dda';	--��ע--���ػ�ȡ
node_start_work VARCHAR2(50):='988e38a7-7813-77eb-e053-0100007f3dda';	--��ע--�׿�¥����������
node_completed_permit VARCHAR2(50):='988e38a7-7878-77eb-e053-0100007f3dda';	--��ע--��������
node_project_open VARCHAR2(50):='988e38a7-7827-77eb-e053-0100007f3dda';	--��ע--��Ŀ����
dwm_REMARK VARCHAR2(200):='����-chenl';
sys_created date:=sysdate;
BEGIN
delete tmp_proj_related_date;
delete tmp_proj_base;
commit;
--------������ʱ�����κ�
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
--select * from (select obj_phase.*,row_number() over(partition by obj_id order by PHASE_ORDER desc) as order_num from obj_phase )obj_phase_order where order_num = 1
---------------------------------------------------��ע--չʾ�����ţ�����¥��������䣩
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
    select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��
    SELECT spid,ps.project_id,node_exhibit_open_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_exhibit_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))   )                        
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name
    ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  ------------------------------------------------��ע
---------------------------------------------------��ע--�滮��������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)

    select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��
    SELECT spid,ps.project_id,node_plan_approval_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_plan_approval                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name ------------------------------------------------��ע
    ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  

---------------------------------------------------��ע--���ػ�ȡ
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��

    SELECT spid,ps.project_id,node_get_land_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_get_land                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))     )                      
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------��ע
    ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  
---------------------------------------------------��ע--�׿�¥����������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��

    SELECT spid,ps.project_id,node_start_work_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_start_work                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�' and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------��ע
 ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  
---------------------------------------------------��ע--��������
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
     select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��

    SELECT spid,ps.project_id,node_completed_permit_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_completed_permit                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'
        and fission_source_original_id is null  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------��ע
 ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  
---------------------------------------------------��ע--��Ŀ����
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
       select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----project_id��������ȡ��һ��

    SELECT spid,ps.project_id,node_project_open_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   ------------------------------------------------��ע
 ---project_id��������ȡ��һ��
        )obj) where order_num = 1;  
---------------------------------------------------��ע20201209--��Ŀ���ڿ������ڣ�ȡ������������������¥�����������һ��¥����������֤���ڣ�
--������ڣ�ȡ���һ�����ڵĿ����������ڡ�
  INSERT INTO tmp_proj_related_date (id,project_id,project_date_type,plan_end_date,actual_end_date,estimate_end_date,remark)
       select spid,project_id,nType,plan_end_date,actual_end_date,estimate_end_date,node_name
    from (select obj.*,row_number() over(partition by project_id order by plan_end_date) as order_num 
    from ( 
    ----ȡ���µ�һ������
    SELECT spid,ps.project_id,completion_record_date_type as nType,plan_end_date,actual_end_date,estimate_end_date,nodestartsales.node_name
    FROM   pom_proj_plan plan 
    LEFT JOIN pom_proj_plan_node  nodestartsales ON plan.id = nodestartsales.PROJ_PLAN_ID  AND nodestartsales.standard_node_id = node_project_open                           
    left join sys_project_stage  ps ON ps.id = plan.proj_id  and (ps.IS_FIRST_OPEN_PERIOD=1 or  stage_name IN (SELECT column_value FROM TABLE ( split(plan_stage) ))  )                         
        WHERE   plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�'  and IS_DELETE=0 and IS_DISABLE=0 
        GROUP BY ps.project_id,plan_end_date,actual_end_date,estimate_end_date,node_name   
------------------------------------------------��ע
---project_id��������ȡ��һ��
        )obj) where order_num = 1;  

    INSERT INTO tmp_proj_base (
        ID,--����
        PROJECT_ID,--��ĿID
        PROJECT_NAME,--��Ŀ����
        ORG_ID,--������ҵ��ID
        ORG_NAME,--������ҵ��
        FIRST_OPEN_DATE,--�׿�����
        OBTAIN_DATE,--��Ŀ�������
        COMPLETION_RECORD_DATE,--�״ο�������
        TAKE_LAND_DATE,--�õ�����
        PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        PLAN_APPROVAL_DATE,--������������
        PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        IS_OPERATE,--�Ƿ����
        IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���

        CREATED,--��������
        REMARK--��ע��Ϣ
    )
        SELECT
            spid                          AS id,
            project.project_original_id   AS project_id,--��ĿID
            project.project_name          AS project_name,--��Ŀ����
            project.company_id            AS org_id,--������ҵ��ID
            project.company_name          AS org_name,--������ҵ��
            node_project_open1.actual_end_date     AS first_open_date,--ʵ���׿�ʱ��----1
            node_get_land1.actual_end_date      AS obtain_date,--��Ŀ��ȡ����
            node_completed_permit1.actual_end_date     AS first_completion_record_date,--�״ο�������------2
            node_get_land1.actual_end_date     AS take_land_date,--�õ�����----3
            node_project_open1.plan_end_date     AS plan_first_open_date,--�ƻ��׿�����-----4
            node_project_open1.plan_end_date - node_get_land1.actual_end_date AS first_open_duration_by_plan,--ԭ�ƻ��׿�ʱ��
            node_project_open1.actual_end_date - node_get_land1.actual_end_date AS first_open_duration_by_tl,--�õ����׿�ʱ��
            node_project_open1.estimate_end_date      AS new_plan_first_open_date,--����Ԥ���׿�����----5
            node_exhibit_open1.actual_end_date     AS exhibition_area_open_date,--ʵ��չʾ������ʱ��---6
            node_exhibit_open1.plan_end_date ,--�ƻ�չʾ������ʱ��----7
            node_plan_approval1.actual_end_date     AS plan_approval_date,--��������ʱ��----7
            node_plan_approval1.plan_end_date  ,--�ƻ���������ʱ��----7 
            CASE
                WHEN project.proj_cooperate = '����' THEN
                    1
                ELSE
                    0
            END AS is_operate,--as project.PROJ_COOPERATE �Ƿ����
            CASE
                WHEN node_start_work1.actual_end_date is not null THEN
                    1
                ELSE
                    0
            END     AS is_construction_began,--�Ƿ񿪹�----7

            sys_created,
            '����' AS remark
        FROM
            mdm_project             project  
--��ע--չʾ�����ţ�����¥��������䣩	
LEFT JOIN tmp_proj_related_date   node_exhibit_open1 ON project.project_original_id = node_exhibit_open1.project_id AND node_exhibit_open1.project_date_type = node_exhibit_open_type
--��ע--�滮��������	
LEFT JOIN tmp_proj_related_date   node_plan_approval1 ON project.project_original_id = node_plan_approval1.project_id AND node_plan_approval1.project_date_type = node_plan_approval_type
--��ע--���ػ�ȡ	
LEFT JOIN tmp_proj_related_date   node_get_land1 ON project.project_original_id = node_get_land1.project_id AND node_get_land1.project_date_type = node_get_land_type
--��ע--�׿�¥����������	
LEFT JOIN tmp_proj_related_date   node_start_work1 ON project.project_original_id = node_start_work1.project_id AND node_start_work1.project_date_type = node_start_work_type
--��ע--��������	
LEFT JOIN tmp_proj_related_date   node_completed_permit1 ON project.project_original_id = node_completed_permit1.project_id AND node_completed_permit1.project_date_type = node_completed_permit_type
--��ע--��Ŀ����	
LEFT JOIN tmp_proj_related_date   node_project_open1 ON project.project_original_id = node_project_open1.project_id AND node_project_open1.project_date_type = node_project_open_type
WHERE project.approval_status = '�����';

    IF is_photograph <> 0 THEN
--��ɾ������ʷ����Ŀ���ݣ�������µ�����
        DELETE FROM dwm_sale_rate_project  where CREATED<sys_created;

        INSERT INTO dwm_sale_rate_project (
            ID,--����
        PROJECT_ID,--��ĿID
        PROJECT_NAME,--��Ŀ����
        ORG_ID,--������ҵ��ID
        ORG_NAME,--������ҵ��
        FIRST_OPEN_DATE,--�׿�����
        OBTAIN_DATE,--��Ŀ�������
        COMPLETION_RECORD_DATE,--�״ο�������
        TAKE_LAND_DATE,--�õ�����
        PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        PLAN_APPROVAL_DATE,--������������
        PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        IS_OPERATE,--�Ƿ����
        IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���
        HAS_FIRST_PHASE_KEY_PLAN,--�Ƿ������߹ؼ��ڵ�ƻ�
        CREATED,--��������
        REMARK--��ע��Ϣ
        )
            SELECT
        get_uuid,
        base.PROJECT_ID,--��ĿID
        base.PROJECT_NAME,--��Ŀ����
        base.ORG_ID,--������ҵ��ID
        base.ORG_NAME,--������ҵ��
        base.FIRST_OPEN_DATE,--�׿�����
        base.OBTAIN_DATE,--��Ŀ�������
        base.COMPLETION_RECORD_DATE,--�״ο�������
        base.TAKE_LAND_DATE,--�õ�����
        base.PLAN_FIRST_OPEN_DATE,--�ƻ��׿�����
        base.FIRST_OPEN_DURATION_BY_PLAN,--ԭ�ƻ��׿�ʱ��(10-9)
        base.FIRST_OPEN_DURATION_BY_TL,--�õ����׿�ʱ��(6-9)
        base.NEW_PLAN_FIRST_OPEN_DATE,--����Ԥ���׿�����
        base.EXHIBITION_AREA_OPEN_DATE,--չʾ����������
        base.EXHIBITION_AREA_OPEN_BY_PLAN,--չʾ�����żƻ�����
        base.PLAN_APPROVAL_DATE,--������������
        base.PLAN_APPROVAL_DATE_BY_PLAN,--���������ƻ�����
        base.IS_OPERATE,--�Ƿ����
        base.IS_CONSTRUCTION_BEGAN,--�Ƿ��ѿ���
        CASE
                WHEN FIRST_OPEN.id is not null THEN
                    1
                ELSE
                    0
        END     AS is_FIRST_OPEN,--�Ƿ����Ϲؼ��ڵ�ƻ� 
        base.CREATED,--��������
        dwm_REMARK--��ע��Ϣ
    FROM tmp_proj_base base
    left join (SELECT ps.id,ps.project_id
    FROM  sys_project_stage  ps
    left join   pom_proj_plan plan  ON ps.id = plan.proj_id  where  ps.IS_FIRST_OPEN_PERIOD=1
    and  plan.approval_status = '�����'   AND plan.plan_type = '�ؼ��ڵ�ƻ�')
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

