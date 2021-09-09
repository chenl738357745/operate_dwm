--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-22-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_COMPANY" (
    ---��������
    companyid IN VARCHAR2,--��������˾Ϊ����˾id
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
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
    ---���
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
-----������֯�����в���
where_auth_sql:=case when companyid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on ������id=wh.orgid' else '' end;

where_auth_c_sql:=case when companyid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on �����Ŷ�Ӧ��˾id=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_COMPANY;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_DEPT" (
    ---��������
    deptid IN VARCHAR2,--���������ţ�����id
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
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
    ---���
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
-----������֯�����в���
where_auth_sql:=case when deptid is not  null then ' left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 0 
                start with sbu.id = '''||deptid||'''
connect by prior sbu.id = sbu.PARENT_ID) wh on ������id=wh.orgid' else '' end;

where_auth_c_sql:=case when deptid is not  null then ' and wh.orgid is not null ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on ������id=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_DEPT;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PROJ" (
    ---��������
    companyid IN VARCHAR2,--������˾id
    projid IN VARCHAR2,--������Ŀid
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
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
    ---���
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
-----������֯��������Ŀ
-----��˾id��Ϊ�գ���ĿidΪ�� ���ݹ�˾����
where_auth_sql:=case when (companyid is not null and projid is null) then ' left join (select proj.id as projId from sys_project proj
left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 1 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) org on  proj.UNIT_ID=org.orgid
where org.orgid is not null) wh on �ڵ�������Ŀid=wh.projId' 
-----��˾id��Ϊ�գ���Ŀid��Ϊ�� ������Ŀid�������Ƿ���Ҳ��������Ŀ������
when (companyid is not null and projid is not null) then '' else '' end;

where_auth_c_sql:=case when (companyid is not null and projid is null) then ' and wh.projId is not null ' 
when (projid is not null) then ' and  instr(�ڵ�������Ŀ�ͷ���id,'''||projid||''')>0  ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on �ڵ�������Ŀid=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PROJ;




/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENT_PSRSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENT_PSRSON" (
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
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
    ---���
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
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ��������sql
            where 1=1  and instr(������id,'''||userId||''')>0
            --- like����
           ' ||v_where_like_sql||'';
end;
END P_POM_SMART_CURRENT_PSRSON;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTCOMPANY_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTCOMPANY_TBS" (
    --orgtype IN VARCHAR2, --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,,����
    condition IN VARCHAR2, --�����������˾id
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR
) IS
--����˾��������-tabs
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => condition,
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;

END P_POM_SMART_CURRENTCOMPANY_TBS;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTDEPT_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTDEPT_TBS" (
    condition IN VARCHAR2, --�������������id
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR) IS --��������tabs��������ͳ������Դ
--���ߣ�������tabͳ��
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_DEPT(
     DEPTID => condition,
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;
end;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPROJ_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPROJ_TBS" (
    companyid  IN            VARCHAR2,--���������ѡ��˾
    condition IN VARCHAR2, --�����������Ŀid
    currentuserid IN VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid IN VARCHAR2,--��ǰ�û���˾
    currentdeptid IN VARCHAR2,--��ǰ�û�����
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode IN VARCHAR2,---Ȩ��code
    searchcondition IN VARCHAR2,--ģ����ѯ����
    item OUT SYS_REFCURSOR
) IS
    --�������ı���Ŀͳ��
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_PROJ(
    companyid => companyid,
    projid => condition,
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => currentuserid,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;
END P_POM_SMART_CURRENTPROJ_TBS;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_CURRENTPSRSON_TBS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_CURRENTPSRSON_TBS" ( 
		condition IN VARCHAR2, --�����������ǰ�û�ID
		searchcondition IN VARCHAR2, --ģ����ѯ����
		item OUT SYS_REFCURSOR ) IS --��������tabs��������ͳ������Դ
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

P_POM_SMART_CURRENT_PSRSON(
    CONDITIONSBBIZTYPE => 'tabͳ��',
    CURRENTCOMPANYID => '',
    USERID => condition,
    CURRENTSTATIONID => '',
    CURRENTDEPTID => '',
    BIZCODE => '',
    CURRENTTYPE => '',
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||'
                UNION All
          '||special_noed_sql;
          ---ͳ���ֶ������� ӳ��
v_sql_exec:=' select ccount as acount,bcount, dcount as ccount  from ( select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||')';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
-- OPEN item FOR select v_sql_exec ACOUNT from dual ;
 OPEN item FOR  v_sql_exec ;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;


END P_POM_SMART_CURRENTPSRSON_TBS;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_KEY_NODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_KEY_NODE" (
    ---��������
    companyid IN VARCHAR2,--������˾id
    projid IN VARCHAR2,--������Ŀid
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------base��ʼ------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,

    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ------------------------------------base����------���ƴ�ӽű�20210417 
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---�����������
    join_where_sql OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql CLOB;
    ---���������ű� 
    fb_sql CLOB;
    ---����Ȩ�޽ű� 
    auth_data_sql CLOB;
    ---��ע�ű�
    watch_sql CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql CLOB;
    ---------------------------------����sql
    ---�ؼ�������
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
    ---���
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
proj_noed_sql:=proj_noed_sql||' and p.PLAN_TYPE=''�ؼ��ڵ�ƻ�''';
-----������֯��������Ŀ
-----��˾id��Ϊ�գ���ĿidΪ�� ���ݹ�˾����
where_auth_sql:=case when (companyid is not null and projid is null) then ' left join (select proj.id as projId from sys_project proj
left join (select sbu.id as orgid
                from SYS_BUSINESS_UNIT sbu  WHERE is_company = 1 
                start with sbu.id = '''||companyid||'''
connect by prior sbu.id = sbu.PARENT_ID) org on  proj.UNIT_ID=org.orgid
where org.orgid is not null) wh on �ڵ�������Ŀid=wh.projId' 
-----��˾id��Ϊ�գ���Ŀid��Ϊ�� ������Ŀid�������Ƿ���Ҳ��������Ŀ������
when (companyid is not null and projid is not null) then '' else '' end;

where_auth_c_sql:=case when (companyid is not null and projid is null) then ' and wh.projId is not null ' 
when (projid is not null) then ' and  instr(�ڵ�������Ŀ�ͷ���id,'''||projid||''')>0  ' else '' end;

join_where_sql:='                        
            --- ������
            left join ('||node_Principal_sql||')pr  on �ڵ�id=�����˽ڵ�id
            --- ��������
            left join ('||fb_sql||')  f on �����ڵ�ԭʼid=�ڵ�ԭʼid
            --- ������ע
            left join ('||watch_sql||')  w on �ڵ�ԭʼid=��עҵ��id
            --- ����Ȩ��
            left join ('||auth_data_sql||') tal on �ڵ�������Ŀid=orgid
            --- ��������sql
            '||where_auth_sql||'
            where 1=1 and tal.orgid is not null '||where_auth_c_sql||'
            --- like����
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
   , --�����������Ŀ
    PAGEINDEX   IN INT
   ,PAGESIZES   IN INT
   ,CURRENTTYPE IN VARCHAR2
   , --��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    userid        IN            VARCHAR2,--�û�id���ڹ��˹�ע������
    currentcompanyid     IN     VARCHAR2,--��ǰ�û��Ĺ�˾
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    bizcode       IN            VARCHAR2,---Ȩ��code
    ITEMS       OUT SYS_REFCURSOR
   ,TOTAL       OUT INT
) IS
--��������,�ؼ��ڵ�ƻ�
 --���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;

    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;

    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
 P_POM_SMART_KEY_NODE(
    COMPANYID => COMPANYID,
    PROJID => PROJID,
    CONDITIONSBBIZTYPE =>  '��ҳ����',
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
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL;
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
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
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
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
   , --��ѯ���ͣ������жϹ��� 0,��˾|1,����|2,��Ŀ|3,����
    CONDITION IN VARCHAR2
   , --�����������˾id | ����id | ��Ŀid | ��ǰ�û�ID
    userid        IN            VARCHAR2,--�û�id���ڹ��˹�ע������
    currentcompanyid     IN     VARCHAR2,--��ǰ�û��Ĺ�˾
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid        IN            VARCHAR2,---��ǰ�û��Ĳ���
    bizcode       IN            VARCHAR2,---Ȩ��code
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    ITEM      OUT SYS_REFCURSOR
) IS
 --��������tabs��������ͳ������Դ,�ؼ��ڵ�ƻ�
  --���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   testmsg             CLOB;
   ---�ƻ��ڵ�
    noed_sql           CLOB;
    ------------------------------------------20210417
    ---------------------------------------20210417
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---�����������
    join_where_sql         CLOB;
    ---------------------------------
    ---------------------------------
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;
   ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql         CLOB;
    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;
BEGIN
     ------------------------------------------20210417

   P_POM_SMART_KEY_NODE(
    COMPANYID => COMPANYID,
    PROJID => CONDITION,
    CONDITIONSBBIZTYPE =>  'tabͳ��',
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
-------------------------------------------------------------------------------------------����
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql;
v_sql_exec:=' select '||tab_filed_expression_sql||' from                       
             ('||noed_sql||') node 
            ' ||join_where_sql||'';
-------------------------------------------------------------------------------------------��ҳ��ȡ����

BEGIN
 OPEN item FOR v_sql_exec;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec;
            OPEN item FOR SELECT '---tabͳ���쳣��=��' 
            || testmsg plan_name FROM dual;
END;
END P_POM_SMART_KEY_NODE_PLAN_TBS;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_BASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_BASE" (
    ---��������
    conditionsbBizType in VARCHAR2,--��������(��ҳ����,tabͳ��)
    ----------------------------------------ͳһ����
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    ------------------------------------------���ƴ�ӽű�20210417
    -------------------------------�ڵ�sql
    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           OUT   CLOB,
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql           OUT   CLOB,
    --------------------------------�ֶ���ʾ�ж�sql
    ---���ƴ�ʽ
    light_up_plan_expression_sql OUT   CLOB,
    
    ---tabҳ�����ֶ�ͳ��sql
    tab_filed_expression_sql OUT   CLOB,
    ---��ע�жϽű� 
    watch_filed_sql OUT   CLOB,
    ---����������ʾ���ʽ
    node_name_filed_sql OUT   CLOB,
    ---------------------------------����sql
    ---�ؼ�������
    v_where_like_sql       OUT   CLOB,
    ---tabҳ����sql
    tab_where_sql OUT   CLOB,
    ---------------------------------������ѯsql
    ---���������˱��ʽ
    node_Principal_sql  OUT   CLOB,
    ---���������ű� 
    fb_sql     OUT   CLOB,
    ---����Ȩ�޽ű� 
    auth_data_sql    OUT   CLOB,
    ---��ע�ű�
    watch_sql   OUT   CLOB
) IS
--��������ƴ�ӽű�
--���ߣ�����
--���ڣ�2021/04/17
  ---����Ȩ����֤spid
    v_spid              VARCHAR2(200);
BEGIN
     ------------------------------------------20210417
    ------����Ȩ�ޣ���Ȩ�޵Ĳ��ź���Ŀ
    ------�ؼ��ڵ�ƻ�����Ŀ����ƻ���ר��ƻ�
    ------�������񡢳���δ�����������δ���������������������������񡢴������񡢱��������񡢱�������
--------------------------------------------------------------------------------------------------------��ȡ�б�����ʹ��-------------------------------------------------------------------------------------20210417
--1.���ƹ�����������---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��plan_type��node_level
---
 IF conditionsbBizType='��ҳ����' THEN
        FOR item IN (
            SELECT s.expression, vv.node_level, vv.plan_type
            FROM pom_rule_set s
            LEFT JOIN (
            ---���ݽڵ����ͺͼƻ����ͷ���ȡ��ȡ�����һ������
                SELECT MAX(s.created_time) AS t, node_level, plan_type
                FROM pom_rule_set             s
                LEFT JOIN pom_rule_set_plan_type   pt ON s.id = pt.rule_id
                WHERE rule_type = '���ƹ���'
                AND s.is_disable = 0
                GROUP BY node_level, plan_type
            ) vv ON s.created_time = vv.t --AND s.node_level = vv.node_level
            WHERE vv.t IS NOT NULL
            ) LOOP
                ---ƴ���ַ���
                light_up_plan_expression_sql := light_up_plan_expression_sql
                || ' when plan_type='''||  item.plan_type || ''' and node_level=''' || item.node_level  
                || ''' then (' ||item.expression||')' ;
            END LOOP;
        --�������0ƴ��������case when ���
        IF length(light_up_plan_expression_sql) > 0 THEN
            light_up_plan_expression_sql :='case ' || light_up_plan_expression_sql || ' else '''' end as NODE_WARNING ';
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'ACTUAL_END_DATE','�ڵ�ʵ���������');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'PLAN_END_DATE','�ڵ�ƻ��������');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'plan_type','�ƻ�������ʾ��');
            light_up_plan_expression_sql:=replace(light_up_plan_expression_sql,'node_level','�ڵ�ȼ�');
            ---- ��֤���ʽ�Ƿ���ȷ,����ȷ���⴦��ȷ��Ԥ�ƹ���Ӱ�������������ݲ�ѯ
            BEGIN
            execute immediate 'select '||light_up_plan_expression_sql||' from (select sysdate �ڵ�ƻ��������, sysdate �ڵ�ʵ���������,''����'' �ƻ�������ʾ��,''����'' �ڵ�ȼ� from dual) test';
            EXCEPTION
            WHEN OTHERS THEN
             ---- ��֤���ʽ��ͨ�����ػ�ɫ����
            light_up_plan_expression_sql:='''<p style=" font-size: 40px;color:#e8e6e6;margin-bottom: 0px;">��</p>''  as NODE_WARNING ';
            END;
        ELSE
            --�޹���������ʾ��
            light_up_plan_expression_sql := '''''';
        END IF;

--1.���ƹ�����������---���----------------------------------------------------------------------------------------------20210417
--5.NODE_NAMEƴ��������ں�״̬---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�����id���ڵ�name���������͡�����Ԥ��������ڡ�����ʵ��������ڡ�����״̬
node_name_filed_sql:='( CASE
                        WHEN ����id IS NULL THEN �ڵ�����
                        WHEN ����id IS NOT NULL AND �������� <> ''CARRY_OUT''
                            THEN �ڵ�����||''��Ԥ���������:''||to_char(����Ԥ���������,''yyyy-MM-dd'')||''��''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''δ���''
                            THEN �ڵ�����||''����ɷ���δ����''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''����ɷ�������С�''
                        WHEN ����id IS NOT NULL AND �������� = ''CARRY_OUT'' AND �������״̬=''�����''
                            THEN �ڵ�����||''��ʵ���������:''||to_char(����ʵ���������,''yyyy-MM-dd'')||''��''
                    END) ';
--5.NODE_NAMEƴ��������ں�״̬---���----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid,�Ƿ�ȡ��,�ڵ�ʵ���������
--------�ṩWACTH��HASTEN��W_Url
watch_filed_sql:='�Ƿ�ȡ�� as IS_UN_WATCH 
                   ,(case when �Ƿ�ȡ��=0 then ''ȡ��'' else ''��ע'' end) as WACTH
                   ,(case when �ڵ�ʵ��������� is null then ''�߰�'' else null end) as HASTEN
                   ,(case when �Ƿ�ȡ��=0
                     then ''/pom/biz-watch/bizwatch-unfollow?cancelType=0=400=70=''||�ڵ�ԭʼid
                    else ''/pom/biz-watch/bizwatch-setting?cancelType=0=724=300=''||�ڵ�ԭʼid end) as W_Url';
--3.tab����---��ʼ----------------------------------------------------------------------------------------------20210417
----��Ҫ�ؼ��֣�ACTUAL_END_DATE��SYSDATE��PLAN_END_DATE��ACTUAL_END_DATE
 IF currenttype = '��������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and (n.PLAN_END_DATE>=trunc(sysdate, ''month'') and n.PLAN_END_DATE<=trunc(last_day(sysdate))) ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null and to_char(sysdate, ''yyyy-mm-dd'')>to_char(n.PLAN_END_DATE, ''yyyy-mm-dd'') ';
        ELSIF currenttype = '����δ�������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is null ';
        ELSIF currenttype = '�������������' THEN
            tab_where_sql := ' and n.ACTUAL_END_DATE is not null ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=last_day(trunc(sysdate))+1
                       and n.PLAN_END_DATE<=last_day(last_day(trunc(sysdate))+1))';
        ELSIF currenttype = '����������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''Q'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''Q''), 3) - 1) ';
        ELSIF currenttype = '��������' THEN
            tab_where_sql := ' and (n.PLAN_END_DATE>=trunc(sysdate, ''yyyy'')
                       and n.PLAN_END_DATE<=add_months(trunc(sysdate, ''yyyy''), 12) - 1)  ';
        ELSE
            tab_where_sql := ' and 1=2';
        END IF;
--3.tab����---���----------------------------------------------------------------------------------------------20210417 
 END IF;
 -------
tab_filed_expression_sql:='NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND (�ڵ�ƻ�������� >= trunc(SYSDATE, ''month'') AND �ڵ�ƻ�������� <= trunc(last_day(SYSDATE)))
                              THEN  1 ELSE 0 END), 0)AS ACOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL AND TO_CHAR(SYSDATE, ''yyyy-mm-dd'') > TO_CHAR(�ڵ�ƻ��������, ''yyyy-mm-dd'')
                              THEN 1 ELSE 0 END),0)AS BCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NULL THEN 1 ELSE 0 END),0) AS CCOUNT,
						NVL(SUM(CASE WHEN node.�ڵ�ʵ��������� IS NOT NULL THEN 1 ELSE 0 END),0) AS DCOUNT,
						COUNT(1) AS ECOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= last_day( trunc( SYSDATE ) ) + 1
								AND �ڵ�ƻ�������� <= last_day( last_day( trunc( SYSDATE ) ) + 1 )
								) THEN 1 ELSE 0 END),0) AS FCOUNT,
						NVL(SUM(CASE WHEN  (�ڵ�ƻ��������>= trunc( SYSDATE, ''Q'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''Q'' ), 3 ) - 1
								) THEN 1 ELSE 0 END),0) AS GCOUNT,
						NVL(SUM(CASE WHEN (�ڵ�ƻ�������� >= trunc( SYSDATE, ''yyyy'' )
								AND �ڵ�ƻ�������� <= add_months( trunc( SYSDATE, ''yyyy'' ), 12 ) - 1
								) THEN 1 ELSE 0 END),0) AS HCOUNT';
--------------------------------------------------------------------------------------------------------��ȡ�б�����ʹ��-------------------------------------------------------------------------------------20210417

--2.Ȩ�޻�ȡ---��ʼ----------------------------------------------------------------------------------------------20210417
   BEGIN
--��������Ȩ����֤�洢����
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
             ---- ��֤���ʽ��ͨ�����ػ�ɫ����
            v_spid:='ִ��Ȩ�޴���';
    END;

--2.Ȩ�޻�ȡ---���----------------------------------------------------------------------------------------------20210417



--4.�ؼ�������---��ʼ----------------------------------------------------------------------------------------------20210417 
--------��Ҫ�ؼ��֣�NODE_NAME��PLAN_NAME��PROJ_NAME��DUTY_DEPARTMENT��charge_person
-----������ؼ��ֲ�Ϊ��ʱ
        IF searchcondition is not null THEN
            v_where_like_sql := ' and (instr(node.�ڵ�����,'''||searchcondition||''')>0 OR instr(node.�ƻ�����,'''||searchcondition||''')>0
              OR instr(node.������Ŀ,'''||searchcondition||''')>0 OR instr(node.������,'''||searchcondition||''')>0
              OR instr(������,'''||searchcondition||''')>0 )';
        ELSE
            v_where_like_sql := '';
        END IF;

--4.�ؼ�������---���----------------------------------------------------------------------------------------------20210417   


--6.����������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�id
node_Principal_sql:='                  
                           SELECT node_id as �����˽ڵ�id,
                    LISTAGG( to_char(charge_person), '','') WITHIN GROUP(ORDER BY charge_person) AS ������
                    ,LISTAGG( to_char(CHARGE_PERSON_ID), '','') WITHIN GROUP(ORDER BY charge_person) AS ������id
                    FROM POM_NODE_CHARGE_PERSON group by node_id
                    ';
--6.����������---���----------------------------------------------------------------------------------------------20210417  
--7.��������---��ʼ----------------------------------------------------------------------------------------------20210417  
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
fb_sql:=' (SELECT B.*FROM ( SELECT A.id as ����id,a.feedback_node_id as �����ڵ�id,a.feedback_node_original_id as �����ڵ�ԭʼid
                            ,a.approval_status as �������״̬,a.actual_end_time as ����ʵ���������,ESTIMATE_END_TIME as ����Ԥ���������
                            ,feedback_type as ��������
                            ,ROW_NUMBER() OVER(partition by a.feedback_node_original_id order by A.CREATED desc nulls last) rn
                            FROM POM_NODE_FEEDBACK A
                        ) B WHERE RN = 1) ';
--7.��������---���----------------------------------------------------------------------------------------------20210417  
--8.����Ȩ��---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣�����id����Ŀid
auth_data_sql:='select DISTINCT org_id AS orgid from  TMP_AUTH_LIST where id = '''||v_spid||'''';
--8.����Ȩ��---���----------------------------------------------------------------------------------------------20210417

--9.ҵ���ע---��ʼ----------------------------------------------------------------------------------------------20210417
--------��Ҫ�ؼ��֣��ڵ�ԭʼid
watch_sql:='(
            SELECT biz_id as ��עҵ��id,watcher_id as ��ע��,is_un_watch as �Ƿ�ȡ�� FROM SYS_BIZ_WATCH where WATCHER_ID='''||userid||'''
           ) ';
--9.ҵ���ע---���----------------------------------------------------------------------------------------------20210417

-------------------------------------------------------------------------------------------����
special_noed_sql:=' SELECT
                    n.ID   AS �ڵ�id,
                    p.id as �ƻ�ԭʼid,
                    n.original_node_id   AS �ڵ�ԭʼid,
                    n.PLAN_ID as �ƻ�id,
                    2  as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.PREDICT_END_DATE as �ڵ�Ԥ���������,
                    n.CORRESPONDING_PROJ_NAME AS     ������Ŀ,
                    ''ר��ƻ�'' AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    ''ר��ƻ���'' AS �ڵ�ȼ�,
                    0 AS ��׼��ֵ,
                    n.CORRESPONDING_PROJ_ID as �ڵ�������Ŀid,
                    n.CORRESPONDING_PROJ_ID as �ڵ�������Ŀ�ͷ���id
                FROM POM_SPECIAL_PLAN_NODE n
                ---�����ƻ�
                LEFT JOIN POM_SPECIAL_PLAN p ON n.PLAN_ID = p.ID
                ---����˵ļƻ�
                WHERE p.APPROVAL_STATUS=''�����'' AND (n.is_DELETE=0 or n.is_DELETE is null)';
proj_noed_sql:='                
                SELECT
                    n.ID  AS �ڵ�id,
                    p.ORIGINAL_PLAN_ID  as �ƻ�ԭʼid,
                    n.ORIGINAL_NODE_ID  AS �ڵ�ԭʼid,
                    n.PROJ_PLAN_ID as �ƻ�id,
                    (CASE p.PLAN_TYPE WHEN ''�ؼ��ڵ�ƻ�'' THEN 0 WHEN ''��Ŀ����ƻ�'' THEN 1 END) as �ƻ�����,
                    n.NODE_NAME as �ڵ�����,
                    p.PLAN_NAME as �ƻ�����, 
                    n.PLAN_START_DATE as �ڵ�ƻ���ʼ����,
                    n.PLAN_END_DATE as �ڵ�ƻ��������,
                    n.ACTUAL_END_DATE as �ڵ�ʵ���������,
                    n.ESTIMATE_END_DATE as �ڵ�Ԥ���������,
                    p.PROJ_NAME AS     ������Ŀ,
                    p.PLAN_TYPE AS   �ƻ�������ʾ��,
                    n.DUTY_DEPARTMENT as  ������,
                    n.DUTY_DEPARTMENT_ID as ������id,
                    n.COMPANY_ID as  �����Ŷ�Ӧ��˾id,
                    n.NODE_LEVEL AS �ڵ�ȼ�,
                    n.STANDARD_SCORE  AS ��׼��ֵ,
                    ps.PROJECT_ID as �ڵ�������Ŀid,
                    p.PROJ_ID||ps.PROJECT_ID as �ڵ�������Ŀ�ͷ���id
                FROM POM_PROJ_PLAN_NODE n
                LEFT JOIN POM_PROJ_PLAN p ON n.PROJ_PLAN_ID = p.ID
                left join SYS_PROJECT_STAGE ps on p.PROJ_ID=ps.id
                WHERE (p.PLAN_TYPE=''��Ŀ����ƻ�'' or p.PLAN_TYPE=''�ؼ��ڵ�ƻ�'') and p.APPROVAL_STATUS=''�����''
                    AND (n.IS_DISABLE=0 or n.IS_DISABLE is null) AND (n.is_DELETE=0 or n.is_DELETE is null) ';
END P_POM_SMART_MY_CURRENT_BASE;

/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_COMPANY" (
    companyid IN VARCHAR2,--�����������˾id
    currentcompanyid IN VARCHAR2,--��ǰ�û��Ĺ�˾
    userid  IN VARCHAR2,--��ǰ�û���id
    currentstationid IN VARCHAR2,---��ǰ�û��ĸ�λ
    currentdeptid IN VARCHAR2,---��ǰ�û��Ĳ���
    bizcode IN VARCHAR2,---Ȩ��code
    pageindex IN INT,
    pagesizes IN INT,
    currenttype IN VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN VARCHAR2,--ģ����ѯ����
    items OUT SYS_REFCURSOR,
    total OUT INT
) IS
--����˾��������
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;

    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;

    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_COMPANY(
    COMPANYID => COMPANYID,
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
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
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_company;



/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_DEPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_DEPT" (
    userid        IN            VARCHAR,--�û�id�����ڹ��˹�ע������
    deptid        IN            VARCHAR2,--�������������
    currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
    currentdeptid        IN            VARCHAR2,--��ǰ�û�����
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode       IN            VARCHAR2,---Ȩ��code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
--    auth          OUT           SYS_REFCURSOR
) IS
    --�����Ÿ��������
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;

    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;

    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_DEPT(
    DEPTID => deptid,
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
OPEN items FOR v_sql_exec_paging;
--  OPEN items FOR SELECT '--��=��'|| v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_dept;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PERSON
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PERSON" (
    userid        IN            VARCHAR2,--����������û�ID
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ����ͣ�����δ��ɣ�����δ��ɣ���������ɣ�
    searchcondition IN          VARCHAR2,
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --�Ҹ��������  �ؼ��ڵ�ƻ�����Ŀ����ƻ���ר��ƻ�
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;

    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;

    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_PSRSON(
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => '',
    USERID => USERID,
    CURRENTSTATIONID => '',
    CURRENTDEPTID =>'',
    BIZCODE =>'',
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                          --------���ƹ���
                         ,'||light_up_plan_expression_sql||'
                      from (select * from (
                         ' || v_sql_exec|| '
                        )where rownum <= ' || pageindex * pagesizes || '
                      ) a where a.rowno > ' || pagesizes * ( pageindex - 1 ) || '';

BEGIN
 OPEN items FOR v_sql_exec_paging;
-- OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
--            || v_sql_exec_paging plan_name FROM dual;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||v_sql_exec_paging;
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_person;


/
--------------------------------------------------------
--  DDL for Procedure P_POM_SMART_MY_CURRENT_PROJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_POM_SMART_MY_CURRENT_PROJ" (
    projid        IN            VARCHAR2,--�����������Ŀ
    companyid  IN            VARCHAR2,--���������ѡ��˾
    userid        IN 			VARCHAR2,--�û�id�����ڹ��˹�ע������
    currentcompanyid     IN            VARCHAR2,--��ǰ�û���˾
    currentdeptid        IN            VARCHAR2,--��ǰ�û�����
    currentstationid     IN            VARCHAR2,---��ǰ�û��ĸ�λ
    bizcode       IN            VARCHAR2,---Ȩ��code
    pageindex     IN            INT,
    pagesizes     IN            INT,
    currenttype   IN            VARCHAR2,--��ɽڵ�����(��������,����δ�������,����δ�������,�������������,��������,��������,����������,��������)
    searchcondition IN          VARCHAR2,--ģ����ѯ����
    items         OUT           SYS_REFCURSOR,
    total         OUT           INT
) IS
    --�����Ÿ��������
--���ߣ�����
--���ڣ�2021/04/17
   v_sql_exec          CLOB;
   v_sql_exec_paging   CLOB;
   testmsg             CLOB;
-----------------------------------��ʼ---base�������-20210417
    ---���ƴ�ʽ
    light_up_plan_expression_sql         CLOB;
    ---tabҳ����sql
    TAB_WHERE_SQL          CLOB;

    ---��ע�жϽű� 
    watch_filed_sql         CLOB;
    ---����������ʾ���ʽ
    node_name_filed_sql         CLOB;

    ---��Ŀ��ؼƻ��ڵ㼯��sql���ؼ��ڵ�ƻ�����Ŀ����ƻ���
    proj_noed_sql           CLOB;
    ---ר��ƻ��ڵ㼯��sql 
    special_noed_sql          CLOB;
    ---�����������
    join_where_sql         CLOB;
-----------------------------------����---base�������-20210417
    ---�ƻ��ڵ�
    noed_sql           CLOB;
    ---�������sql 
    join_where_exec  Clob;

    ---tabҳ�����ֶ�ͳ��sql ��ʹ��
    tab_filed_expression_sql         CLOB;
BEGIN
     ------------------------------------------20210417
       BEGIN
P_POM_SMART_CURRENT_PROJ(
    companyid => companyid,
    projid => projid,
    CONDITIONSBBIZTYPE => '��ҳ����',
    CURRENTCOMPANYID => CURRENTCOMPANYID,
    USERID => USERID,
    CURRENTSTATIONID => CURRENTSTATIONID,
    CURRENTDEPTID => CURRENTDEPTID,
    BIZCODE => BIZCODE,
    CURRENTTYPE => CURRENTTYPE,
    SEARCHCONDITION => SEARCHCONDITION,
    ---���
    PROJ_NOED_SQL => PROJ_NOED_SQL,
    SPECIAL_NOED_SQL => SPECIAL_NOED_SQL,
    LIGHT_UP_PLAN_EXPRESSION_SQL => LIGHT_UP_PLAN_EXPRESSION_SQL,
    WATCH_FILED_SQL => WATCH_FILED_SQL,
    NODE_NAME_FILED_SQL => NODE_NAME_FILED_SQL,
    TAB_FILED_EXPRESSION_SQL => TAB_FILED_EXPRESSION_SQL,
    TAB_WHERE_SQL => TAB_WHERE_SQL,
    JOIN_WHERE_SQL => JOIN_WHERE_SQL
  );
-------------------------------------------------------------------------------------------����
noed_sql:=proj_noed_sql||TAB_WHERE_SQL||'
                UNION All
          '||special_noed_sql||TAB_WHERE_SQL||' ';
join_where_exec:='                        
             ('||noed_sql||') node 
             ' ||join_where_sql||'';
end;

-------------------------------------------------------------------------------------------��ҳ��ȡ����
--3.ƴ���������
v_sql_exec :='select  rownum as rowno,node.*,pr.*,f.*,w.*
                         from'
               ||join_where_exec||' ORDER BY node.�ڵ�ƻ�������� ';
v_sql_exec_paging :=
                    ' select �ڵ�id as ID,
                        �ڵ�ԭʼid as ORIGINAL_NODE_ID,
                        �ƻ�ԭʼid as ORIGINAL_PLAN_ID,
                        �ƻ�id as PLAN_ID,
                        �ƻ����� as PLAN_TYPE_INT,
                        '||node_name_filed_sql||' as NODE_NAME,
                        �ƻ����� as PLAN_NAME,
                        ������Ŀ as PROJ_NAME,
                        �ƻ�������ʾ�� as PLAN_TYPE,
                        ������ as DUTY_DEPARTMENT,
                        ������     CHARGE_PERSON,
                        �ڵ�ȼ� NODE_LEVEL,
                        ��׼��ֵ  STANDARD_SCORE,
                         TO_CHAR(�ڵ�ƻ���ʼ����, ''YYYY-MM-DD'') PLAN_START_DATE ,
                         TO_CHAR(�ڵ�ƻ��������, ''YYYY-MM-DD'') PLAN_END_DATE,
                         TO_CHAR(�ڵ�ʵ���������, ''YYYY-MM-DD'') ACTUAL_END_DATE,
                         TO_CHAR(�ڵ�Ԥ���������, ''YYYY-MM-DD'') PREDICT_END_DATE,
                         case when �ڵ�ʵ��������� is null then ''δ���'' else ''�����'' end as COMPLETION_STATUS
                         --------��ע���߰�
                         ,'||watch_filed_sql||'
                         --------���ƹ���
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
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            || testmsg plan_name FROM dual;
END;
BEGIN
--------------------------------------------------------------------------------------------��������
 EXECUTE IMMEDIATE 'SELECT count(1) from(select * from '  || join_where_exec || ') a ' INTO total;
    EXCEPTION
        WHEN OTHERS THEN
            testmsg:=sqlerrm||'SELECT count(1) from(select * from '  || join_where_exec || ') a ';
            OPEN items FOR SELECT '---��ȡ�����쳣��=��' 
            ||testmsg  plan_name FROM dual;
END;
END p_pom_smart_my_current_proj;


/

