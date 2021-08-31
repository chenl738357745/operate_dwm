--------------------------------------------------------
--  文件已创建 - 星期三-三月-31-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_MDM_EXT_STAGE_BUILDING_TREE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "POM"."P_MDM_EXT_STAGE_BUILDING_TREE" (
    info out sys_refcursor
)
-- 注意isParent的值为字符串 避免java接收到BigDecimal
--同步组织架构及用户
--作者：韩金明
--修改者：陈丽 20210318 chenl 
--背景：三亚东岸单元人才公寓项目（暂定），查询无楼栋数据 。//使用了外部映射项目字段关联分期，导致分期下的楼栋inner join不能被查询出来
--调整方式：①项目数据，最后查询，再关联映射id。②楼栋项目id关联项目映射id
    is
begin
    open info for
    -- 公司
        with
            unit as (
                select
                    '1' as "isParent",
                    sbu.ORG_NAME as "name",
                    UPPER(sbu.PARENT_ID) as "pId",
                    null as "unitName",
                    null as "cityCode",
                    null as "cityName",
                    null as "unitId",
                    null as "parentType",
                    null as "stageId",
                    null as "sn",
                    UPPER(sbu.ID) as "id",
                    'unit' as "nodeType",
                    null as "projectId"
                from SYS_BUSINESS_UNIT sbu
                where IS_COMPANY=1 order by ORDER_HIERARCHY_CODE
            ),
            -- 项目
            project as (
                select
                    '1' as "isParent",
                    sp.PROJECT_NAME as "name",
                    UPPER(sp.UNIT_ID) as "pId",
                    sp.UNIT_NAME as "unitName",
                    sp.CITY_CODE as "cityCode",
                    sp.CITY_NAME as "cityName",
                    UPPER(sp.UNIT_ID) as "unitId",
                    null as "parentType",
                    null as "stageId",
                    sp.SN*1 as "sn",
                    sp.ID as "id",
                   -- mpm.R_PROJ_ID as "id",
                    'project' as "nodeType",
                    null as "projectId"
                from SYS_PROJECT sp
               -- left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(sp.ID)
                inner join unit on UPPER(sp.UNIT_ID) = UPPER(unit."id") order by  SN
            ),
            -- 分期
            stage as (
                select
                    '1' as "isParent",
                    sps.STAGE_NAME as "name",
                    sps.PROJECT_ID as "pId",
                    --mpm.R_PROJ_ID as "pId",
                    null as "unitName",
                    null as "cityCode",
                    null as "cityName",
                    null as "unitId",
                    null as "parentType",
                    null as "stageId",
                    sps.SN as "sn",
                    sps.ID as "id",
                    'stage' as "nodeType",
                    count(*) over (partition by sps.PROJECT_ID) cnt,
                    null as "projectId"
                from SYS_PROJECT_STAGE sps
               -- left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(sps.PROJECT_ID)
                inner join project on sps.PROJECT_ID = project."id" order by SN
            ),
            --楼栋
            building as (
                select
                    '0' as "isParent",
                    BUILD_NAME as "name",
                    (case when cnt=1 and stage."name"='无分期' then stage."pId" else sb.PERIOD_ID end) as "pId",
                    null as "unitName",
                    null as "cityCode",
                    null as "cityName",
                    null as "unitId",
                    (case when cnt=1 and stage."name" = '无分期' then 'project' else 'stage' end) as "parentType",
                    stage."id" as  "stageId",
                    null as "sn",
                    sb.id as "id",
                    'building' as "nodeType",
                     sb.PROJ_ID as "projectId"
                from SYS_BUILD sb
                inner join stage on UPPER(sb.PERIOD_ID) = UPPER(stage."id") order by ORDER_HIERARCHY_CODE
            )
            
            ,resultdata as(
        select * from unit 
        union all
        select  proj."isParent",
                    proj."name",
                    proj."pId",
                    proj."unitName",
                    proj."cityCode",
                    proj."cityName",
                    proj."unitId",
                    proj."parentType",
                    proj."stageId",
                    proj."sn",
                    mpm.R_PROJ_ID as "id",
                    proj."nodeType",
                    mpm.R_PROJ_ID from project proj
        left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(proj."id")
        union all
        select stage."isParent", msm.period_name as "name", mpm.R_PROJ_ID as "pId", stage."unitName", stage."cityCode", stage."cityName", stage."unitId", stage."parentType",
               stage."stageId", stage."sn",  msm.R_PERIOD_ID AS "id", stage."nodeType", stage."projectId"
        from stage stage
        left join MDM_PERIOD_MAPPING msm on UPPER(msm.PERIOD_ORIGINAL_ID) = UPPER(stage."id")
        left join MDM_PROJ_MAPPING mpm on UPPER(stage."pId") = UPPER(mpm.PROJECT_ORIGINAL_ID)
        where cnt != 1 or "name" != '无分期'
        union all select b."isParent",
                    mbm.BUILD_NAME AS "name",
                    --分期使用映射的分期id。 无分期，使用楼栋已处理的父级分期id（项目id）
                    (case when "parentType"='stage' then msm.R_PERIOD_ID else b."pId"  end) as "pId",
                    b."unitName",
                    b."cityCode",
                    b."cityName",
                    b."unitId",
                    b."parentType",
                    --分期使用映射的分期id。 无分期 null
                   (case when "parentType"='stage' then msm.R_PERIOD_ID else null  end)  "stageId",
                    b."sn",
                    mbm.R_BUILD_ID AS "id",
                    b."nodeType",
                    mpm.R_PROJ_ID   from building b
        LEFT JOIN MDM_BUILD_MAPPING mbm on   UPPER(b."id") =UPPER(mbm.BUILD_ID)
        --关联分期，获取楼栋父级id（分期id）
        left join MDM_PERIOD_MAPPING msm on  UPPER(b."pId") = UPPER(msm.PERIOD_ORIGINAL_ID)
        --关联项目，获取楼栋所属项目id
        left join MDM_PROJ_MAPPING mpm on UPPER(b."projectId") = UPPER(mpm.PROJECT_ORIGINAL_ID))
        
        select * from resultdata
        ;
        
end;

/
