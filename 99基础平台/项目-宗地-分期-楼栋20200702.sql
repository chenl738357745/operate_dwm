CREATE OR
REPLACE PROCEDURE P_SYS_PROJ_SYNCHRONIZATION AS
--ͬ������������---��Ŀ���ڵ� ǿ��������һ��ͬ��
--����ԭ�򣺳�������ά���⣬�����ط�ʹ����Ŀ����ҡ�������ά����ʹ����Ŀ����ƣ�Ӧ�ƻ�ͳһ����ʹ�� ���ڡ�¥��sys_project,sys_project_stage,sys_build,sys_PARCEL
--���ߣ�����
--���ڣ�2020-06-19
BEGIN------ͬ����������Ŀ

------������Ŀȫ·��
update mdm_project set ORDER_HIERARCHY_CODE=(
select code from (
select p.id,u.ORDER_HIERARCHY_CODE||'.'||PROJECT_CODE as code from  mdm_project p
left join SYS_BUSINESS_UNIT u on  p.COMPANY_ID=u.id) s where mdm_project.id=s.id );
commit;
----ɾ����Ŀ;
DELETE sys_project;
COMMIT;----������Ŀ;
INSERT INTO sys_project (sn,---����
id,---����
project_name,---��Ŀ����
update_date,---����ʱ��
project_code,---��Ŀ���
----------------
unit_id,---��˾id
unit_name,---��˾����
project_state,---��Ŀ״̬
address,---��ַ
city_code,---���б��
----------------
city_name,---��������
update_user_id,---������id
update_user,---������
take_date,---�������
order_hierarchy_code,---ȫ·���������//��ΰ1227����
----------------
project_reply_name,---��Ŀ��������///����20200619����
project_popularize_name,---��Ŀ�ƹ�����///����20200619����
is_cooperate---�Ƿ������Ŀ///����20200619����
---------------------- ��������
) WITH proj AS (
    SELECT d.id,d.project_original_id,d.project_name,d.modified,d.project_code,---------------------
    d.company_id,d.company_name,e.phase_name,d.proj_address,d.city_id,d.city_name,d.modifier_id,d.modifier,d.project_get_time,d.order_hierarchy_code,---------------------
    d.project_reply_name,d.project_popularize_name,d.is_cooperate FROM mdm_project d LEFT JOIN (
    SELECT v.proj_id,v.phase_name FROM (
    SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv ON v.proj_id=vv.proj_id AND v.phase_order=vv.max) e ON d.project_original_id=e.proj_id WHERE d.approval_status='�����' ORDER BY d.project_code)
SELECT ROWNUM sn,project_original_id AS id,project_name AS name,modified AS updatedate,project_code AS code,company_id AS unitid,company_name AS unitname,phase_name AS state,proj_address AS address,city_id AS citycode,city_name AS cityname,modifier_id AS updateuserid,modifier AS updateuser,project_get_time AS takedate,order_hierarchy_code,project_reply_name,project_popularize_name,is_cooperate FROM proj ORDER BY ROWNUM;
COMMIT;--ɾ���ڵ�
DELETE SYS_PARCEL;---ͬ���ڵ�
INSERT INTO sys_parcel (id,parcel_name,project_id,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id)
WITH proj AS (
    SELECT d.id FROM mdm_project d LEFT JOIN (
    SELECT v.proj_id,v.phase_name FROM (
    SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv ON v.proj_id=vv.proj_id AND v.phase_order=vv.max) e ON d.project_original_id=e.proj_id WHERE d.approval_status='�����' ORDER BY d.project_code)
SELECT PARCEL_ORIGINAL_ID,parcel_name,PROJECT_ORIGINAL_ID,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id FROM MDM_PARCEL pa LEFT JOIN proj p ON pa.PROJECT_ID=p.id where  p.id is not null and PARCEL_ORIGINAL_ID  is not null;
commit;
END P_SYS_PROJ_SYNCHRONIZATION;
/
CREATE OR
REPLACE PROCEDURE P_SYS_PERIOD_SYNCHRONIZATION AS
--ͬ������������--����/�����ڵع�ϵ�� ǿ��������һ��ͬ��
--����ԭ�򣺳�������ά���⣬�����ط�ʹ����Ŀ����ҡ�������ά����ʹ����Ŀ����ƣ�Ӧ�ƻ�ͳһ����ʹ�� ���ڡ�¥��sys_project,sys_project_stage,sys_build,sys_PARCEL
--���ߣ�����
--���ڣ�2020-06-19
BEGIN------ͬ����������Ŀ
----ɾ����Ŀ;
DELETE sys_project_stage;
COMMIT;----������Ŀ;
INSERT INTO sys_project_stage (id,stage,stage_name,project_state,project_id,is_first_open_period,stage_full_name)
WITH period AS (
    SELECT DISTINCT d.id,d.period_original_id,d.period_name,e.phase_name,f.project_original_id,d.is_first_open_period FROM mdm_period d LEFT JOIN mdm_period_version f ON d.period_version_id=f.id LEFT JOIN (
    SELECT v.period_id,v.phase_name FROM (
    SELECT a.period_id,a.phase_order,b.phase_name FROM mdm_period_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT period_id,MAX(phase_order) max FROM mdm_period_phase GROUP BY period_id) vv ON v.period_id=vv.period_id AND v.phase_order=vv.max) e ON d.period_original_id=e.period_id WHERE f.approval_status='�����' ORDER BY f.project_original_id)
SELECT period_original_id,period_name,period_name,phase_name,project_original_id,is_first_open_period,case when period_name='�޷���' then proj.PROJECT_NAME else proj.PROJECT_NAME||period_name end  FROM period
left join sys_project  proj on period.project_original_id=proj.id;
COMMIT;
--ɾ�����ں��ڵصĹ�ϵ
DELETE sys_parcel_obj_r WHERE obj_type='����';
COMMIT;----�������ں��ڵصĹ�ϵ;
INSERT INTO sys_parcel_obj_r (id,obj_id,obj_type,parcel_id) 
WITH period AS (
    SELECT DISTINCT d.id,d.period_original_id,d.period_name,e.phase_name,f.project_original_id,d.is_first_open_period FROM mdm_period d LEFT JOIN mdm_period_version f ON d.period_version_id=f.id LEFT JOIN (
    SELECT v.period_id,v.phase_name FROM (
    SELECT a.period_id,a.phase_order,b.phase_name FROM mdm_period_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT period_id,MAX(phase_order) max FROM mdm_period_phase GROUP BY period_id) vv ON v.period_id=vv.period_id AND v.phase_order=vv.max) e ON d.period_original_id=e.period_id WHERE f.approval_status='�����' ORDER BY f.project_original_id)
SELECT get_uuid () id,period.period_original_id AS obj_id,obj_type,parcel_original_id AS PARCEL_ID FROM mdm_obj_parcel_r r LEFT JOIN period ON r.obj_id=period.id WHERE obj_type='����' AND period.id IS NOT NULL;
COMMIT;
END P_SYS_PERIOD_SYNCHRONIZATION;
/
CREATE OR
REPLACE PROCEDURE P_SYS_BUILD_SYNCHRONIZATION AS
--ͬ������������--¥ͬ��
--����ԭ�򣺳�������ά���⣬�����ط�ʹ����Ŀ����ҡ�������ά����ʹ����Ŀ����ƣ�Ӧ�ƻ�ͳһ����ʹ�� ���ڡ�¥��sys_project,sys_project_stage,sys_build,sys_PARCEL
--���ߣ�����
--���ڣ�2020-06-19
BEGIN------ͬ����������Ŀ
----ɾ��¥��;
DELETE sys_build;
INSERT INTO sys_build (id,build_name,period_id,parcel_id,proj_id,delivery_type,issue_time,is_get_con_plan_permit,con_plan_permit_date,con_plan_permit_no,is_get_constrcution_permit,constrcution_permit_date,construction_permit_no,is_get_pre_sale_permit,pre_sale_permit_date,pre_sale_permit_no,is_get_completed_permit,completed_permit_date,completed_permit_no) 
WITH build AS (
   SELECT id,build_name,period_id,parcel_id,proj_id,delivery_type,issue_time,is_get_con_plan_permit,get_con_plan_permit_date,con_plan_permit_no,is_get_constrcution_permit,get_constrcution_permit_date,construction_permit_no,is_get_pre_sale_permit,get_pre_sale_permit_date,pre_sale_permit_no,is_get_completed_permit,get_completed_permit_date,get_completed_permit_no FROM mdm_build WHERE BUILD_STATE=10
) 
SELECT*FROM build;
COMMIT;
END P_SYS_BUILD_SYNCHRONIZATION;