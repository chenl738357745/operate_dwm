--DELETE FROM  log_synchronous_room;
--DELETE FROM mdm_room_bak;
---------------查看过程   
SELECT sum(api_room_total),'日志房间数' as 对象 FROM    log_synchronous_room
union all 
SELECT count(api_room_total),'日志楼栋数' as 对象 FROM    log_synchronous_room
union all 
SELECT count(api_room_total),'获取明源接口房间等于0的楼栋数量'  FROM  log_synchronous_room where api_room_total=0
union all 
SELECT max(to_number(api_room_total)),'楼栋最多房间'  FROM  log_synchronous_room 
union all 
SELECT 1,'完成同步：'||remarks  FROM  log_synchronous_room where remarks like '%完成，%'
union all
select count(*),'MDM_ROOM_FROM_SMS' as 对象 from MDM_ROOM_FROM_SMS
union all
select count(*),'MDM_ROOM_BAK' as 对象 from MDM_ROOM_BAK;

select * from log_synchronous_room order by remarks;  --lpad(api_room_total,10,'0') desc;
SELECT * FROM  log_synchronous_room where remarks like '%楼栋%';
select count(*) from MDM_ROOM_BAK;
select count(*) from MDM_ROOM_FROM_SMS;

select a.r_build_id id from (SELECT nvl(lower(Translate(r_build_id USING CHAR_CS)),'kong') as r_build_id FROM MDM_BUILD where r_build_id is not null) a
where r_build_id not in (SELECT lower(Translate(BUILDING_ID USING CHAR_CS))  as id FROM  log_synchronous_room where api_room_total=0)
and r_build_id not in (select lower(Translate(BUILDING_ID USING CHAR_CS)) as id from MDM_ROOM_FROM_SMS group by BUILDING_ID)
                              

select building_id from (
select room_id,building_id,count(*) t from MDM_ROOM_FROM_SMS group by room_id,building_id)  a where a.t>1 group by building_id

--drop table MDM_ROOM_FROM_SMS_cl;
--drop table log_synchronous_room_cl;
--drop table mdm_room_bak_cl;
--create table MDM_ROOM_FROM_SMS_cl as select * from MDM_ROOM_FROM_SMS;
--create table log_synchronous_room_cl as select * from log_synchronous_room;
--create table mdm_room_bak_cl  as select * from mdm_room_bak;

select count(*) from MDM_ROOM_FROM_SMS_cl
union all
select count(*) from log_synchronous_room_cl
union all
select count(*) from mdm_room_bak_cl;
