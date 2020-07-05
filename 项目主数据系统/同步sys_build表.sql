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