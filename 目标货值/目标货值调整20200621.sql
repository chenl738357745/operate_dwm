----------------------------------------------chenl20200621开始------修改目标货值详情表主键长度
DECLARE COLUMNEXIST  NUMBER;
BEGIN
SELECT COUNT(*) INTO COLUMNEXIST  from user_tab_columns t where t.table_name='DWM_TARGET_WORTH_DTL' and t.column_name ='WORTH_DTL_ID';
    IF COLUMNEXIST=0 THEN
        EXECUTE IMMEDIATE 'alter table DWM_TARGET_WORTH_DTL add  WORTH_DTL_ID varchar2(80)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_ID" IS ''目标货值详情对象id//20200625新增字段''';
    END IF;
end;
/
DECLARE COLUMNEXIST  NUMBER;
BEGIN
SELECT COUNT(*) INTO COLUMNEXIST  from user_tab_columns t where t.table_name='DWM_TARGET_WORTH_DTL' and t.column_name ='WORTH_DTL_PARENT_ID';
    IF COLUMNEXIST=0 THEN
        EXECUTE IMMEDIATE 'alter table DWM_TARGET_WORTH_DTL add  WORTH_DTL_PARENT_ID varchar2(80)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_PARENT_ID" IS ''目标货值详情对象父级id//20200625新增字段''';
    END IF;
end;
/
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_ID" IS '目标货值详情对象id//20200625新增字段';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_PARENT_ID" IS '目标货值详情对象父级id//20200625新增字段';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."OBJ_PARENT_ID" IS 'chenl20200621废弃字段,对象父级id';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."OLD_OBJ_ID" IS 'chenl20200621废弃字段,旧的对象id';

----------------------------------------------chenl20200621结束------修改目标货值详情表主键长度
---------备份目标货值表
----drop table DWM_TARGET_WORTH_DTL_CL;
----create table DWM_TARGET_WORTH_DTL_cl  as select * from DWM_TARGET_WORTH_DTL;
---------更新目标货值表历史数据
--项目,分期,楼栋WORTH_DTL_ID=对象id+目标货值主表id
--业态         WORTH_DTL_ID=id
--项目,分期,楼栋,业态WORTH_DTL_PARENT_ID=OBJ_PARENT_ID+目标货值主表id
update DWM_TARGET_WORTH_DTL set WORTH_DTL_ID=case when OBJ_TYPE=40 then id else obj_id||TARGET_WORTH_ID end where WORTH_DTL_ID is null;
update DWM_TARGET_WORTH_DTL set WORTH_DTL_PARENT_ID=OBJ_PARENT_ID||TARGET_WORTH_ID where WORTH_DTL_PARENT_ID is null;
--/
--------目标货值详情，查询视图

----------------------------------------------更新重新计算存储过程
create or replace PROCEDURE P_DWM_TARGET_WORTH_RECOUNT (
    targetWorthId         IN             VARCHAR2 --目标货值id
) AS
--目标货值重新计算
--作者：陈丽
--日期：2020/05/09
BEGIN
RETURN;
with 计算 as(select (case when obj_type=40 then average_price else 0 end) as average_price_temp,
    (case when obj_type=40 then nvl(average_price*(TOTAL_CARPORT+GROUND_CAN_SELL_AREA),0) else 0 end) as worth_temp,
    id,target_worth_id,
    worth_dtl_id,
    worth_dtl_parent_id from DWM_TARGET_WORTH_DTL)

 , 汇总 as( select s.*
 ,(SELECT SUM(worth_temp) FROM 计算 START WITH ID=S.ID CONNECT BY PRIOR ID=obj_parent_id ) AS  worth_yuan
 from 计算 s)

SELECT 汇总.*
,CASE WHEN (TOTAL_CARPORT+GROUND_CAN_SELL_AREA)=0 THEN 0 ELSE worth_yuan/(TOTAL_CARPORT+GROUND_CAN_SELL_AREA) END AS average_price
,WORTH_yuan/10000 AS "worth"
FROM 汇总;

END P_DWM_TARGET_WORTH_RECOUNT;
/
----------------------------------------------chenl20200621结束------从主数据刷新目标货值存储过程注册

