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