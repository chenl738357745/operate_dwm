create or replace PROCEDURE P_MDM_GET_BUILDS_BY_PROJECT
(
		PROJECTID IN VARCHAR2
	 ,ITEMS     OUT SYS_REFCURSOR
) IS
		--������ϵͳץȡ�������� ����������ĿID��ȡ¥�����ݴ洢����
		--���ߣ�������
		--���ڣ�2020/01/13
BEGIN
OPEN ITEMS FOR 
WITH  builds as(select id from(
                                --------------------Сд
                                SELECT lower(Translate(r_build_id USING CHAR_CS)) as id FROM MDM_BUILD
                                union all 
                                SELECT lower(Translate(id USING CHAR_CS)) as id FROM MDM_BUILD
                                union all
                                ----------------------��д
                                SELECT Translate(r_build_id USING CHAR_CS) as id FROM MDM_BUILD
                                union all 
                                SELECT Translate(id USING CHAR_CS) as id FROM MDM_BUILD
                                )group by id order by id)
,base as (select* from (select id,rownum rowsn  from builds)),

��һ���� AS (
select id from base where rowsn<=1000
	   
		)
,�ڶ����� as (
select id from base  where rowsn>1000 and rowsn<=2000
		)
,�������� as (
select id from base where rowsn>2000 and rowsn<=3000
		 )
,�������� as (
select id from base where rowsn>3000 and rowsn<=4000
		)
,�������� as (
select id from base  where rowsn>4000 and rowsn<=5000
		)
,���� as (select 'c7603a8392f24b93adee1ff02583f5fb' as id  from  dual)

select id as id from (
select * from ��һ���� where 1=1
union all 
select * from �ڶ����� where 1=1
union all 
select * from �������� where 1=2
union all 
select * from �������� where 1=2
union all 
select * from �������� where 1=2
union all 
select * from ����  where 1=1)
;

		--select '3c9f8ee72ab84ba9be19b7ea92e49e8f' as "id" from dual; 
END P_MDM_GET_BUILDS_BY_PROJECT;
-------------------------���� 
---��ձ�
delete MDM_ROOM_BAK;
delete from MDM_ROOM_FROM_SMS;
----��ѯ����
select count(room_id) from MDM_ROOM_FROM_SMS
union all
select count(*) from MDM_ROOM_BAK;
---ȥ�ز�ѯ
select count(*) from(
select room_id,count(*) from MDM_ROOM_FROM_SMS group by room_id order by count(*) desc);
----Ŀ��췿���ѯ
select count(*) from (
select building_id,count(*) from MDM_ROOM_BAK group by building_id)


select * from MDM_ROOM_BAK where building_id='ff714a2e7e654a8f9ac04ccaaab1281f'

select * from mdm_build where id='ff714a2e7e654a8f9ac04ccaaab1281f'

select * from mdm_build where r_build_id='ff714a2e7e654a8f9ac04ccaaab1281f'
