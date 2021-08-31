--------------------------------------------------------
--  文件已创建 - 星期四-四月-22-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_COMPANY" (
    ---特殊条件
    companyid IN VARCHAR2,--条件本公司为，公司id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----传入组织下所有部门
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on 主责部门id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门对应公司id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_COMPANY;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_DEPT" (
    ---特殊条件
    deptid IN VARCHAR2,--条件本部门，部门id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----传入组织下所有部门
where_auth_sql:=case when deptid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||deptid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on 主责部门id=wh.orgid' else '' end;

where_auth_c_sql:=case when deptid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 主责部门id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_DEPT;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PROJ" (
    ---特殊条件
    companyid IN VARCHAR2,--条件公司id
    projid IN VARCHAR2,--条件项目id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
-----传入组织下所有项目
-----公司id不为空，项目id为空 根据公司过滤
where_auth_sql:=case when (companyid is not null and projid is null) then ' left join (select proj.id as projId from sys_project proj
left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 1 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) org on  proj.UNIT_ID=org.orgid
where org.orgid is not null) wh on 节点所属项目id=wh.projId' 
-----公司id不为空，项目id不为空 根据项目id（可能是分期也可能是项目）过滤
when (companyid is not null and projid is not null) then '' else '' end;

where_auth_c_sql:=case when (companyid is not null and projid is null) then ' and wh.projId is not null ' 
when (projid is not null) then ' and  instr(节点所属项目和分期id,'''||projid||''')>0  ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 节点所属项目id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PROJ;




/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PSRSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PSRSON" (
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联条件sql
            where 1=1  and instr(主责人id,'''||userId||''')>0
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PSRSON;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
    --orgtype IN VARCHAR2, --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,,本人
    condition IN VARCHAR2, --输入变量：公司id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
--本公司负责任务-tabs
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => condition,
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;

END P_POM_SMART_CURRENTCOMPANY_TBS;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --输入变量：部门id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR) IS --任务中心tabs任务条数统计数据源
--作者：本部门tab统计
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_DEPT(
     DEPTID => condition,
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;
end;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
    companyid  IN            VARCHAR2,--输入变量：选择公司
    condition IN VARCHAR2, --输入变量：项目id
    currentuserid IN VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid IN VARCHAR2,--当前用户公司
    currentdeptid IN VARCHAR2,--当前用户部门
    currentstationid IN VARCHAR2,---当前用户的岗位
    bizcode IN VARCHAR2,---权限code
    searchcondition IN VARCHAR2,--模糊查询条件
    item OUT SYS_REFCURSOR
) IS
    --任务中心本项目统计
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_PROJ(
    companyid => companyid,
    projid => condition,
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;
END P_POM_SMART_CURRENTPROJ_TBS;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPSRSON_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" ( 
		condition IN VARCHAR2, --输入变量：当前用户ID
		searchcondition IN VARCHAR2, --模糊查询条件
		item OUT SYS_REFCURSOR ) IS --任务中心tabs任务条数统计数据源
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_PSRSON(
    CONDITIONSBBIZTYPE => 'tab统计',
    CURRENTCOMPANYID => '',
    USERID => condition,
    CURRENTSTATIONID => '',
    CURRENTDEPTID => '',
    BIZCODE => '',
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
          ---统计字段重命名 映射
v_sql_exec:=' select ccount as acount,bcount, dcount as ccount  from ( select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||')';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
-- OPEN item FOR select v_sql_exec ACOUNT from dual ;
 OPEN item FOR  v_sql_exec ;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;


END P_POM_SMART_CURRENTPSRSON_TBS;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE" (
    ---特殊条件
    companyid IN VARCHAR2,--条件公司id
    projid IN VARCHAR2,--条件项目id
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------base开始------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,

    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base结束------输出拼接脚本20210417 
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---关联相关数据
    join_where_sql OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql CLOB;
    ---关联反馈脚本 
    fb_sql CLOB;
    ---关联权限脚本 
    auth_data_sql CLOB;
    ---关注脚本
    watch_sql CLOB;
    ---专项计划节点集合sql 
    special_noed_sql CLOB;
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql CLOB;
     ----------------------------------------------------
    where_auth_sql CLOB;
    where_auth_c_sql CLOB;
BEGIN
     BEGIN
 P_POM_SMART_MY_CURRENT_BASE(
    CONDITIONSBBIZTYPE => CONDITIONSBBIZTYPE,
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    V_WHERE_LIKE_SQL => V_WHERE_LIKE_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    NODE_PRINCIPAL_SQL => NODE_PRINCIPAL_SQL,
    FB_SQL => FB_SQL,
    AUTH_DATA_SQL => AUTH_DATA_SQL,
    WATCH_SQL => WATCH_SQL
  );
proj_noed_sql:=proj_noed_sql||' and p.PLAN_TYPE=''关键节点计划''';
-----传入组织下所有项目
-----公司id不为空，项目id为空 根据公司过滤
where_auth_sql:=case when (companyid is not null and projid is null) then ' left join (select proj.id as projId from sys_project proj
left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 1 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) org on  proj.UNIT_ID=org.orgid
where org.orgid is not null) wh on 节点所属项目id=wh.projId' 
-----公司id不为空，项目id不为空 根据项目id（可能是分期也可能是项目）过滤
when (companyid is not null and projid is not null) then '' else '' end;

where_auth_c_sql:=case when (companyid is not null and projid is null) then ' and wh.projId is not null ' 
when (projid is not null) then ' and  instr(节点所属项目和分期id,'''||projid||''')>0  ' else '' end;

join_where_sql:='                        
            --- 关联人
            left join ('||node_Principal_sql||')pr  on 节点id=主责人节点id
            --- 关联反馈
            left join ('||fb_sql||')  f on 反馈节点原始id=节点原始id
            --- 关联关注
            left join ('||watch_sql||')  w on 节点原始id=关注业务id
            --- 关联权限
            left join ('||auth_data_sql||') tal on 节点所属项目id=orgid
            --- 关联条件sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like条件
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_KEY_NODE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_PROJ" 
(
COMPANYID  IN VARCHAR2,
    PROJID      IN VARCHAR2
   , --输入变量：项目
    PAGEINDEX   IN INT
   ,PAGESIZES   IN INT
   ,CURRENTTYPE IN VARCHAR2
   , --完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    userid        IN            VARCHAR2,--用户id用于过滤关注的任务
    currentcompanyid     IN     VARCHAR2,--当前用户的公司
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    currentdeptid        IN            VARCHAR2,---当前用户的部门
    searchcondition IN          VARCHAR2,--模糊查询条件
    bizcode       IN            VARCHAR2,---权限code
    ITEMS       OUT SYS_REFCURSOR
   ,TOTAL       OUT INT
) IS
--任务中心,关键节点计划
 --作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;

    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;

    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
 P_POM_SMART_KEY_NODE(
    COMPANYID => COMPANYID,
    PROJID => PROJID,
    CONDITIONSBBIZTYPE =>  '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL;
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
   OPEN items FOR v_sql_exec_paging;
  -- OPEN items FOR SELECT v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;

END P_POM_SMART_KEY_NODE_PLAN_PROJ;






/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE_PLAN_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE_PLAN_TBS" 
(
COMPANYID  IN VARCHAR2,
    ORGTYPE   IN VARCHAR2
   , --查询类型，用于判断过滤 0,公司|1,部门|2,项目|3,本人
    CONDITION IN VARCHAR2
   , --输入变量：公司id | 部门id | 项目id | 当前用户ID
    userid        IN            VARCHAR2,--用户id用于过滤关注的任务
    currentcompanyid     IN     VARCHAR2,--当前用户的公司
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    currentdeptid        IN            VARCHAR2,---当前用户的部门
    bizcode       IN            VARCHAR2,---权限code
    searchcondition IN          VARCHAR2,--模糊查询条件
    ITEM      OUT SYS_REFCURSOR
) IS
 --任务中心tabs任务条数统计数据源,关键节点计划
  --作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---计划节点
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;
   ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页汇总字段统计sql
    tab_filed_expression_sql         CLOB;
    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

   P_POM_SMART_KEY_NODE(
    COMPANYID => COMPANYID,
    PROJID => CONDITION,
    CONDITIONSBBIZTYPE =>  'tab统计',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------分页获取数据

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tab统计异常：=》' 
            || testmsg plan_name FROM dual;
END;
END P_POM_SMART_KEY_NODE_PLAN_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_BASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_BASE" (
    ---特殊条件
    conditionsbBizType in VARCHAR2,--输入条件(分页数据,tab统计)
    ----------------------------------------统一条件
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    ------------------------------------------输出拼接脚本20210417
    -------------------------------节点sql
    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           OUT   CLOB,
    ---专项计划节点集合sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------字段显示判断sql
    ---亮灯达式
    light_up_plan_expression_sql OUT   CLOB,
    
    ---tab页汇总字段统计sql
    tab_filed_expression_sql OUT   CLOB,
    ---关注判断脚本 
    watch_filed_sql OUT   CLOB,
    ---任务名称显示表达式
    node_name_filed_sql OUT   CLOB,
    ---------------------------------条件sql
    ---关键字条件
    v_where_like_sql       OUT   CLOB,
    ---tab页条件sql
    tab_where_sql OUT   CLOB,
    ---------------------------------关联查询sql
    ---关联主责人表达式
    node_Principal_sql  OUT   CLOB,
    ---关联反馈脚本 
    fb_sql     OUT   CLOB,
    ---关联权限脚本 
    auth_data_sql    OUT   CLOB,
    ---关注脚本
    watch_sql   OUT   CLOB
) IS
--任务中心拼接脚本
--作者：陈丽
--日期：2021/04/17
  ---数据权限验证spid
    v_spid              VARCHAR2(200);
BEGIN
     ------------------------------------------20210417
    ------数据权限，有权限的部门和项目
    ------关键节点计划、项目主项计划、专项计划
    ------本月任务、超期未完成任务、所有未完成任务、所有已完成任务、所有任务、次月任务、本季度任务、本年任务
--------------------------------------------------------------------------------------------------------获取列表数据使用-------------------------------------------------------------------------------------20210417
--1.亮灯规则条件解析---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、plan_type、node_level
---
 IF conditionsbBizType='分页数据' THEN
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---根据节点类型和计划类型分组取，取最近的一条规则
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '亮灯规则'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---拼接字符串
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --规则大于0拼接完整的case when 语句
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'ACTUAL_END_DATE','节点实际完成日期');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'PLAN_END_DATE','节点计划完成日期');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'plan_type','计划类型显示名');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'node_level','节点等级');
            ---- 验证表达式是否正确,不正确特殊处理，确保预计规则不影响任务中心数据查询
            BEGIN
            execute immediate 'select '||light_up_plan_expression_sql||' from (select sysdate 节点计划完成日期, sysdate 节点实际完成日期,''测试'' 计划类型显示名,''测试'' 节点等级 from dual) test';
            EXCEPTION
            WHEN OTHERS THEN
             ---- 验证表达式不通过返回灰色亮灯
            light_up_plan_expression_sql:='''<p style=" font-size: 40px;color:#e8e6e6;margin-bottom: 0px;">●</p>''  as NODE_WARNING ';
            END;
        ELSE
            --无规则亮灯显示空
            light_up_plan_expression_sql := '''''';
        END IF;

--1.亮灯规则条件解析---完成----------------------------------------------------------------------------------------------20210417
--5.NODE_NAME拼接完成日期和状态---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：反馈id、节点name、反馈类型、反馈预计完成日期、反馈实际完成日期、反馈状态
node_name_filed_sql:='( CASE
                        WHEN 反馈id IS NULL THEN 节点名称
                        WHEN 反馈id IS NOT NULL AND 反馈类型 <> ''CARRY_OUT''
                            THEN 节点名称||''【预计完成日期:''||to_char(反馈预计完成日期,''yyyy-MM-dd'')||''】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''未审核''
                            THEN 节点名称||''【完成反馈未发起】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''审核中''
                            THEN 节点名称||''【完成反馈审核中】''
                        WHEN 反馈id IS NOT NULL AND 反馈类型 = ''CARRY_OUT'' AND 反馈审核状态=''已审核''
                            THEN 节点名称||''【实际完成日期:''||to_char(反馈实际完成日期,''yyyy-MM-dd'')||''】''
                    END) ';
--5.NODE_NAME拼接完成日期和状态---完成----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id,是否取关,节点实际完成日期
--------提供WACTH、HASTEN、W_Url
watch_filed_sql:='是否取关 as IS_UN_WATCH 
                   ,(case when 是否取关=0 then ''取关'' else ''关注'' end) as WACTH
                   ,(case when 节点实际完成日期 is null then ''催办'' else null end) as HASTEN
                   ,(case when 是否取关=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||节点原始id
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||节点原始id end) as W_Url';
--3.tab条件---开始----------------------------------------------------------------------------------------------20210417
----需要关键字：ACTUAL_END_DATE、SYSDATE、PLAN_END_DATE、ACTUAL_END_DATE
 IF currenttype = '本月任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '超期未完成任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') ';
        ELSIF currenttype = '所有未完成任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '所有已完成任务' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '所有任务' THEN
            tab_where_sql := ' ';
        ELSIF currenttype = '次月任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '本季度任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '本年任务' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_sql := ' and 1=2';
        END IF;
--3.tab条件---完成----------------------------------------------------------------------------------------------20210417 
 END IF;
 -------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND (节点计划完成日期 >= trunc(SYSDATE, ''month'') AND 节点计划完成日期 <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(节点计划完成日期, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.节点实际完成日期 IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= last_day( trunc( SYSDATE ) ) + 1
								AND 节点计划完成日期 <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (节点计划完成日期>= trunc( SYSDATE, ''Q'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (节点计划完成日期 >= trunc( SYSDATE, ''yyyy'' )
								AND 节点计划完成日期 <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--------------------------------------------------------------------------------------------------------获取列表数据使用-------------------------------------------------------------------------------------20210417

--2.权限获取---开始----------------------------------------------------------------------------------------------20210417
   BEGIN
--调用数据权限验证存储过程
        P_SYS_AUTH_DATA_RULE_SPID(
                USERID => userid,
                STATIONID => currentstationid,
                DEPTID => currentdeptid,
                COMPANYID => currentcompanyid,
                BIZCODE => bizcode,
                DATA_AUTH_SPID => v_spid
            );
      EXCEPTION
            WHEN OTHERS THEN
             ---- 验证表达式不通过返回灰色亮灯
            v_spid:='执行权限错误';
    END;

--2.权限获取---完成----------------------------------------------------------------------------------------------20210417



--4.关键字条件---开始----------------------------------------------------------------------------------------------20210417 
--------需要关键字：NODE_NAME、PLAN_NAME、PROJ_NAME、DUTY_DEPARTMENT、charge_person
-----当输入关键字不为空时
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.节点名称,'''||searchcondition||''')>0 OR instr(node.计划名称,'''||searchcondition||''')>0
              OR instr(node.所属项目,'''||searchcondition||''')>0 OR instr(node.主责部门,'''||searchcondition||''')>0
              OR instr(主责人,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.关键字条件---完成----------------------------------------------------------------------------------------------20210417   


--6.关联主责人---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点id
node_Principal_sql:='                  
                           SELECT node_id as 主责人节点id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS 主责人
                    ,LISTAGG( to_char(CHARGE_PERSON_ID), '','') WITHIN GROUP(ORDER BY charge_person) AS 主责人id
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.关联主责人---完成----------------------------------------------------------------------------------------------20210417  
--7.关联反馈---开始----------------------------------------------------------------------------------------------20210417  
--------需要关键字：节点原始id
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as 反馈id,a.feedback_node_id as 反馈节点id,a.feedback_node_original_id as 反馈节点原始id
                            ,a.approval_status as 反馈审核状态,a.actual_end_time as 反馈实际完成日期,ESTIMATE_END_TIME as 反馈预计完成日期
                            ,feedback_type as 反馈类型
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_original_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.关联反馈---完成----------------------------------------------------------------------------------------------20210417  
--8.关联权限---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：部门id、项目id
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.关联权限---完成----------------------------------------------------------------------------------------------20210417

--9.业务关注---开始----------------------------------------------------------------------------------------------20210417
--------需要关键字：节点原始id
watch_sql:='(
            SELECT biz_id as 关注业务id,watcher_id as 关注人,is_un_watch as 是否取关 FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.业务关注---完成----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------内容
special_noed_sql:=' SELECT
                    n.ID   AS 节点id,
                    p.id as 计划原始id,
                    n.original_node_id   AS 节点原始id,
                    n.PLAN_ID as 计划id,
                    2  as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.PREDICT_END_DATE as 节点预计完成日期,
                    n.CORRESPONDING_PROJ_NAME AS     所属项目,
                    ''专项计划'' AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    ''专项计划级'' AS 节点等级,
                    0 AS 标准分值,
                    n.CORRESPONDING_PROJ_ID as 节点所属项目id,
                    n.CORRESPONDING_PROJ_ID as 节点所属项目和分期id
                FROM POM_SPECIAL_PLAN_NODE n
                ---关联计划
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---已审核的计划
                WHERE p.APPROVAL_STATUS=''已审核'' AND (n.is_DELETE=0 or n.is_DELETE is null)';
proj_noed_sql:='                
                SELECT
                    n.ID  AS 节点id,
                    p.ORIGINAL_PLAN_ID  as 计划原始id,
                    n.ORIGINAL_NODE_ID  AS 节点原始id,
                    n.PROJ_PLAN_ID as 计划id,
                    (CASE p.PLAN_TYPE WHEN ''关键节点计划'' THEN 0 WHEN ''项目主项计划'' THEN 1 END) as 计划类型,
                    n.NODE_NAME as 节点名称,
                    p.PLAN_NAME as 计划名称, 
                    n.PLAN_START_DATE as 节点计划开始日期,
                    n.PLAN_END_DATE as 节点计划完成日期,
                    n.ACTUAL_END_DATE as 节点实际完成日期,
                    n.ESTIMATE_END_DATE as 节点预计完成日期,
                    p.PROJ_NAME AS     所属项目,
                    p.PLAN_TYPE AS   计划类型显示名,
                    n.DUTY_DEPARTMENT as  主责部门,
                    n.DUTY_DEPARTMENT_ID as 主责部门id,
                    n.COMPANY_ID as  主责部门对应公司id,
                    n.NODE_LEVEL AS 节点等级,
                    n.STANDARD_SCORE  AS 标准分值,
                    ps.PROJECT_ID as 节点所属项目id,
                    p.PROJ_ID||ps.PROJECT_ID as 节点所属项目和分期id
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE ps on p.PROJ_ID=ps.id
                WHERE (p.PLAN_TYPE=''项目主项计划'' or p.PLAN_TYPE=''关键节点计划'') and p.APPROVAL_STATUS=''已审核''
                    AND (n.IS_DISABLE=0 or n.IS_DISABLE is null) AND (n.is_DELETE=0 or n.is_DELETE is null) ';
END P_POM_SMART_MY_CURRENT_BASE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid IN VARCHAR2,--输入变量：公司id
    currentcompanyid IN VARCHAR2,--当前用户的公司
    userid  IN VARCHAR2,--当前用户的id
    currentstationid IN VARCHAR2,---当前用户的岗位
    currentdeptid IN VARCHAR2,---当前用户的部门
    bizcode IN VARCHAR2,---权限code
    pageindex IN INT,
    pagesizes IN INT,
    currenttype IN VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN VARCHAR2,--模糊查询条件
    items OUT SYS_REFCURSOR,
    total OUT INT
) IS
--本公司负责任务
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;

    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;

    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => COMPANYID,
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
  OPEN items FOR v_sql_exec_paging;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_company;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_DEPT" (
    userid        IN            VARCHAR,--用户id，用于过滤关注的任务
    deptid        IN            VARCHAR2,--输入变量：部门
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--    auth          OUT           SYS_REFCURSOR
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;

    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;

    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_DEPT(
    DEPTID => deptid,
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
OPEN items FOR v_sql_exec_paging;
--  OPEN items FOR SELECT '--：=》'|| v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_dept;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PERSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PERSON" (
    userid        IN            VARCHAR2,--输入变量：用户ID
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型（所有未完成，超期未完成，所有已完成）
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --我负责的任务  关键节点计划、项目主项计划、专项计划
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;

    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;

    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_PSRSON(
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => '',
    USERID => USERID,
    CURRENTSTATIONID => '',
    CURRENTDEPTID =>'',
    BIZCODE =>'',
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                          --------亮灯规则
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
-- OPEN items FOR SELECT '---获取数据异常：=》' 
--            || v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_person;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PROJ" (
    projid        IN            VARCHAR2,--输入变量：项目
    companyid  IN            VARCHAR2,--输入变量：选择公司
    userid        IN 			VARCHAR2,--用户id，用于过滤关注的任务
    currentcompanyid     IN            VARCHAR2,--当前用户公司
    currentdeptid        IN            VARCHAR2,--当前用户部门
    currentstationid     IN            VARCHAR2,---当前用户的岗位
    bizcode       IN            VARCHAR2,---权限code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--完成节点类型(本月任务,超期未完成任务,所有未完成任务,所有已完成任务,所有任务,次月任务,本季度任务,本年任务)
    searchcondition IN          VARCHAR2,--模糊查询条件
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --本部门负责的任务
--作者：陈丽
--日期：2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------开始---base输出参数-20210417
    ---亮灯达式
    light_up_plan_expression_sql         CLOB;
    ---tab页条件sql
    TAB_WHERE_SQL          CLOB;

    ---关注判断脚本 
    watch_filed_sql         CLOB;
    ---任务名称显示表达式
    node_name_filed_sql         CLOB;

    ---项目相关计划节点集合sql（关键节点计划、项目主项计划）
    proj_noed_sql           CLOB;
    ---专项计划节点集合sql 
    special_noed_sql          CLOB;
    ---关联相关数据
    join_where_sql         CLOB;
-----------------------------------结束---base输出参数-20210417
    ---计划节点
    noed_sql           CLOB;
    ---整体关联sql 
    join_where_exec  Clob;

    ---tab页汇总字段统计sql 不使用
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_PROJ(
    companyid => companyid,
    projid => projid,
    CONDITIONSBBIZTYPE => '分页数据',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---输出
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------内容
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------分页获取数据
--3.拼接完整语句
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.节点计划完成日期 ';
v_sql_exec_paging :=
                    ' select 节点id as ID,
                        节点原始id as ORIGINAL_NODE_ID,
                        计划原始id as ORIGINAL_PLAN_ID,
                        计划id as PLAN_ID,
                        计划类型 as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        计划名称 as PLAN_NAME,
                        所属项目 as PROJ_NAME,
                        计划类型显示名 as PLAN_TYPE,
                        主责部门 as DUTY_DEPARTMENT,
                        主责人     CHARGE_PERSON,
                        节点等级 NODE_LEVEL,
                        标准分值  STANDARD_SCORE,
                         TO_CHAR(节点计划开始日期, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(节点计划完成日期, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(节点实际完成日期, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(节点预计完成日期, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when 节点实际完成日期 is null then ''未完成'' else ''已完成'' end as COMPLETION_STATUS
                         --------关注、催办
                         ,'||watch_filed_sql||'
                         --------亮灯规则
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
   OPEN items FOR v_sql_exec_paging;
  -- OPEN items FOR SELECT v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---获取数据异常：=》' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------计算总数
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---获取总数异常：=》' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_proj;


/

