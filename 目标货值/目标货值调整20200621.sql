----------------------------------------------chenl20200621��ʼ------�޸�Ŀ���ֵ�������������
DECLARE COLUMNEXIST  NUMBER;
BEGIN
SELECT COUNT(*) INTO COLUMNEXIST  from user_tab_columns t where t.table_name='DWM_TARGET_WORTH_DTL' and t.column_name ='WORTH_DTL_ID';
    IF COLUMNEXIST=0 THEN
        EXECUTE IMMEDIATE 'alter table DWM_TARGET_WORTH_DTL add  WORTH_DTL_ID varchar2(80)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_ID" IS ''Ŀ���ֵ�������id//20200625�����ֶ�''';
    END IF;
end;
/
DECLARE COLUMNEXIST  NUMBER;
BEGIN
SELECT COUNT(*) INTO COLUMNEXIST  from user_tab_columns t where t.table_name='DWM_TARGET_WORTH_DTL' and t.column_name ='WORTH_DTL_PARENT_ID';
    IF COLUMNEXIST=0 THEN
        EXECUTE IMMEDIATE 'alter table DWM_TARGET_WORTH_DTL add  WORTH_DTL_PARENT_ID varchar2(80)';
        EXECUTE IMMEDIATE 'COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_PARENT_ID" IS ''Ŀ���ֵ������󸸼�id//20200625�����ֶ�''';
    END IF;
end;
/
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_ID" IS 'Ŀ���ֵ�������id//20200625�����ֶ�';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."WORTH_DTL_PARENT_ID" IS 'Ŀ���ֵ������󸸼�id//20200625�����ֶ�';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."OBJ_PARENT_ID" IS 'chenl20200621�����ֶ�,���󸸼�id';
COMMENT ON COLUMN "DWM_TARGET_WORTH_DTL"."OLD_OBJ_ID" IS 'chenl20200621�����ֶ�,�ɵĶ���id';

----------------------------------------------chenl20200621����------�޸�Ŀ���ֵ�������������
---------����Ŀ���ֵ��
----drop table DWM_TARGET_WORTH_DTL_CL;
----create table DWM_TARGET_WORTH_DTL_cl  as select * from DWM_TARGET_WORTH_DTL;
---------����Ŀ���ֵ����ʷ����
--��Ŀ,����,¥��WORTH_DTL_ID=����id+Ŀ���ֵ����id
--ҵ̬         WORTH_DTL_ID=id
--��Ŀ,����,¥��,ҵ̬WORTH_DTL_PARENT_ID=OBJ_PARENT_ID+Ŀ���ֵ����id
update DWM_TARGET_WORTH_DTL set WORTH_DTL_ID=case when OBJ_TYPE=40 then id else obj_id||TARGET_WORTH_ID end where WORTH_DTL_ID is null;
update DWM_TARGET_WORTH_DTL set WORTH_DTL_PARENT_ID=OBJ_PARENT_ID||TARGET_WORTH_ID where WORTH_DTL_PARENT_ID is null;
--/
--------Ŀ���ֵ���飬��ѯ��ͼ

----------------------------------------------�������¼���洢����
create or replace PROCEDURE P_DWM_TARGET_WORTH_RECOUNT (
    targetWorthId         IN             VARCHAR2 --Ŀ���ֵid
) AS
--Ŀ���ֵ���¼���
--���ߣ�����
--���ڣ�2020/05/09
BEGIN
RETURN;
with ���� as(select (case when obj_type=40 then average_price else 0 end) as average_price_temp,
    (case when obj_type=40 then nvl(average_price*(TOTAL_CARPORT+GROUND_CAN_SELL_AREA),0) else 0 end) as worth_temp,
    id,target_worth_id,
    worth_dtl_id,
    worth_dtl_parent_id from DWM_TARGET_WORTH_DTL)

 , ���� as( select s.*
 ,(SELECT SUM(worth_temp) FROM ���� START WITH ID=S.ID CONNECT BY PRIOR ID=obj_parent_id ) AS  worth_yuan
 from ���� s)

SELECT ����.*
,CASE WHEN (TOTAL_CARPORT+GROUND_CAN_SELL_AREA)=0 THEN 0 ELSE worth_yuan/(TOTAL_CARPORT+GROUND_CAN_SELL_AREA) END AS average_price
,WORTH_yuan/10000 AS "worth"
FROM ����;

END P_DWM_TARGET_WORTH_RECOUNT;
/
----------------------------------------------chenl20200621����------��������ˢ��Ŀ���ֵ�洢����ע��

