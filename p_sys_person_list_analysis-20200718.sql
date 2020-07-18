create or replace PROCEDURE p_sys_person_list_analysis (
    noticePersons  IN   CLOB,     --�û�code���
    noticeGroups   IN    CLOB,    --������
    noticeProjectRoles    IN     CLOB, --��Ŀ����ɫ
    noticeorgIds    IN     CLOB,    --��֯Id
    projectId in varchar2,
    uuid out varchar2
) IS
COMPANYID varchar2(36);
row_count number;
begin
 SELECT
        get_uuid()
    INTO uuid
    FROM
        dual;
if noticePersons is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE  SELECT  splitstr(COLUMN_VALUE,2),splitstr(COLUMN_VALUE,1) as detail ,'userid' as type 
FROM table (split (noticePersons,';'));
insert into PERSON_ROLE_ANALYSIS_TABLE 
select  r.USER_CODE,uuid,'person'  from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='userid' and code  is not null) tab  left join SYS_USER r on tab.CODE=R.id where  r.USER_CODE is not null;

delete PERSON_ROLE_ANALYSIS_TABLE where type='userid';
end if;

if noticeGroups is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE SELECT splitstr(COLUMN_VALUE,1) as code,splitstr(COLUMN_VALUE,2) as detail ,'group' as type 
FROM table (split (noticeGroups,';'));

    if projectId is null then
        insert into PERSON_ROLE_ANALYSIS_TABLE 
        select r.USER_ACCOUNT,uuid,'person' from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='group' and code  is not null) tab left join SYS_ROLE_USER_RELATION_RESULT r on 
        tab.code=r.VIRTUAL_GROUP_NAME where  r.role_type=40 and r.USER_ACCOUNT is not null;
    else
        select count(1) into row_count from mdm_project where id=projectId;
        if row_count <>0 then
            select COMPANY_ID into COMPANYID from mdm_project where id=projectId and rownum=1;
                dbms_output.put_line('COMPANYID:'||COMPANYID);
            insert into PERSON_ROLE_ANALYSIS_TABLE 
            select r.USER_ACCOUNT,uuid,'person' from  SYS_ROLE_USER_RELATION_RESULT r  
            --��������λ������ȡ��ǰ��Ŀ������˾���ݹ����и�����˾���ϣ���Ŀ������˾��������λ�Ӽ���˾��������������Ŀ������˾��������λ�������ҹ�˾�㼶=3����˾id��Ϊ�����������˾��
            --�ݹ����и�����˾���ϣ������������ҹ�˾�㼶=3
            inner join  (SELECT ID FROM (select * from SYS_BUSINESS_UNIT m start with m.id=COMPANYID connect by prior m.PARENT_ID=m.id) ORG WHERE org.IS_COMPANY=1 and org.LEVEL_RANK=3
            union all
            --chenl 20200718 ��Ŀ������˾��������λ����������������λ���ӹ�˾���ƻ���Ӫ��λ��ʵ�����ļ���λ�ģ����ˡ�
            SELECT id FROM sys_business_unit m WHERE m.parent_id=COMPANYID AND m.is_company=1 AND m.level_rank=4
            )  org
            on r.COMPANY_ID=org.id where
            r.VIRTUAL_GROUP_NAME in   (select code from PERSON_ROLE_ANALYSIS_TABLE where  type='group' and code  is not null  and code like '%��������λ��%') 
            and  r.ROLE_TYPE=40  and r.USER_ACCOUNT is not null
            union
             select r.USER_ACCOUNT,uuid,'person' from  SYS_ROLE_USER_RELATION_RESULT r  
             --�ֵܽڵ�������Ӽ������ҹ�˾�㼶=3
             inner join (select ID from (select * from SYS_BUSINESS_UNIT m1
            where exists (select * from SYS_BUSINESS_UNIT m2 where m1.PARENT_ID=m2.PARENT_ID and m2.id=COMPANYID) union
            select * from SYS_BUSINESS_UNIT m start with m.id=COMPANYID connect by m.PARENT_ID=prior m.id)org  where org.IS_COMPANY=1 and org.LEVEL_RANK=3) org
             on r.COMPANY_ID=org.id where
            r.VIRTUAL_GROUP_NAME in   (select code from PERSON_ROLE_ANALYSIS_TABLE where  type='group' and code  is not null  and code like '%��������λ��%') 
            and  r.ROLE_TYPE=40  and r.USER_ACCOUNT is not null;
        else
             insert into PERSON_ROLE_ANALYSIS_TABLE 
            select r.USER_ACCOUNT,uuid,'person' from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='group' and code  is not null) tab left join SYS_ROLE_USER_RELATION_RESULT r on 
            tab.code=r.VIRTUAL_GROUP_NAME where  r.role_type=40 and r.USER_ACCOUNT is not null;
        end if;
    end if;

delete PERSON_ROLE_ANALYSIS_TABLE where type='group';
end if;

if noticeProjectRoles is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE SELECT splitstr(COLUMN_VALUE,2) as code,splitstr(COLUMN_VALUE,1) as detail ,'projectRole' as type 
FROM table (split (noticeProjectRoles,';'));

insert into PERSON_ROLE_ANALYSIS_TABLE
select r.USER_ACCOUNT,uuid,'person' from  (select * from PERSON_ROLE_ANALYSIS_TABLE where  type='projectRole'  and code  is not null) tab 
left join SYS_ROLE_USER_RELATION_RESULT r on 
tab.code=r.role_code  where r.role_type=30 and r.PROJECT_ID=projectId and r.USER_ACCOUNT is not null;

delete PERSON_ROLE_ANALYSIS_TABLE where type='projectRole';
end if;

if noticeorgIds is not null then
insert into PERSON_ROLE_ANALYSIS_TABLE SELECT splitstr(COLUMN_VALUE,2) as code,splitstr(COLUMN_VALUE,1) as detail ,'org' as type 
FROM table (split (noticeorgIds,';'));

insert into PERSON_ROLE_ANALYSIS_TABLE 
select sys_user.user_code,uuid,'person' from (select * from SYS_BUSINESS_UNIT m start with m.id in (select code from PERSON_ROLE_ANALYSIS_TABLE where type='org') connect by m.parent_id=prior m.id) tab
left join  SYS_STATION on tab.id=SYS_STATION.org_id left join SYS_STATION_TO_USER on sys_station.id=sys_station_to_user.station_id left join SYS_USER on SYS_USER.id=sys_station_to_user.user_id 
where sys_user.user_code is not null;

delete PERSON_ROLE_ANALYSIS_TABLE where type='org';
end if;

end p_sys_person_list_analysis;