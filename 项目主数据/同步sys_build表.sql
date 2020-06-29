CREATE OR
REPLACE PROCEDURE P_SYS_BUILD_SYNCHRONIZATION AS
--同步主数据数据--楼同步
--处理原因：除主数据维护外，其他地方使用项目表混乱。主数据维护外使用项目按设计，应计划统一调整使用 分期、楼栋sys_project,sys_project_stage,sys_build,sys_PARCEL
--作者：陈丽
--日期：2020-06-19
BEGIN------同步主数据项目
----删除楼栋;
DELETE sys_build;
INSERT INTO sys_build (id,build_name,period_id,parcel_id,proj_id,delivery_type,issue_time,is_get_con_plan_permit,con_plan_permit_date,con_plan_permit_no,is_get_constrcution_permit,constrcution_permit_date,construction_permit_no,is_get_pre_sale_permit,pre_sale_permit_date,pre_sale_permit_no,is_get_completed_permit,completed_permit_date,completed_permit_no) 
WITH build AS (
   SELECT id,build_name,period_id,parcel_id,proj_id,delivery_type,issue_time,is_get_con_plan_permit,get_con_plan_permit_date,con_plan_permit_no,is_get_constrcution_permit,get_constrcution_permit_date,construction_permit_no,is_get_pre_sale_permit,get_pre_sale_permit_date,pre_sale_permit_no,is_get_completed_permit,get_completed_permit_date,get_completed_permit_no FROM mdm_build WHERE BUILD_STATE=10
) 
SELECT*FROM build;
COMMIT;
END P_SYS_BUILD_SYNCHRONIZATION;