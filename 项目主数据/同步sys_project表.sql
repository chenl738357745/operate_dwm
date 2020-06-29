CREATE OR
REPLACE PROCEDURE P_SYS_PROJ_SYNCHRONIZATION AS
--同步主数据数据---项目、宗地 强关联所以一起同步
--处理原因：除主数据维护外，其他地方使用项目表混乱。主数据维护外使用项目按设计，应计划统一调整使用 分期、楼栋sys_project,sys_project_stage,sys_build,sys_PARCEL
--作者：陈丽
--日期：2020-06-19
BEGIN------同步主数据项目
----删除项目;
DELETE sys_project;
COMMIT;----新增项目;
INSERT INTO sys_project (sn,---排序
id,---主键
project_name,---项目名称
update_date,---更新时间
project_code,---项目编号
----------------
unit_id,---公司id
unit_name,---公司名称
project_state,---项目状态
address,---地址
city_code,---城市编号
----------------
city_name,---城市名称
update_user_id,---更新人id
update_user,---更新人
take_date,---获得日期
order_hierarchy_code,---全路径排序编码//黄伟1227增加
----------------
project_reply_name,---项目批复名称///陈丽20200619新增
project_popularize_name,---项目推广名称///陈丽20200619新增
is_cooperate---是否合作项目///陈丽20200619新增
---------------------- 主数据无
) WITH proj AS (
    SELECT d.id,d.project_original_id,d.project_name,d.modified,d.project_code,---------------------
    d.company_id,d.company_name,e.phase_name,d.proj_address,d.city_id,d.city_name,d.modifier_id,d.modifier,d.project_get_time,d.order_hierarchy_code,---------------------
    d.project_reply_name,d.project_popularize_name,d.is_cooperate FROM mdm_project d LEFT JOIN (
    SELECT v.proj_id,v.phase_name FROM (
    SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv ON v.proj_id=vv.proj_id AND v.phase_order=vv.max) e ON d.project_original_id=e.proj_id WHERE d.approval_status='已审核' ORDER BY d.project_code)
SELECT ROWNUM sn,project_original_id AS id,project_name AS name,modified AS updatedate,project_code AS code,company_id AS unitid,company_name AS unitname,phase_name AS state,proj_address AS address,city_id AS citycode,city_name AS cityname,modifier_id AS updateuserid,modifier AS updateuser,project_get_time AS takedate,order_hierarchy_code,project_reply_name,project_popularize_name,is_cooperate FROM proj ORDER BY ROWNUM;
COMMIT;--删除宗地
DELETE SYS_PARCEL;---同步宗地
INSERT INTO sys_parcel (id,parcel_name,project_id,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id)
WITH proj AS (
    SELECT d.id FROM mdm_project d LEFT JOIN (
    SELECT v.proj_id,v.phase_name FROM (
    SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
    SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
    SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv ON v.proj_id=vv.proj_id AND v.phase_order=vv.max) e ON d.project_original_id=e.proj_id WHERE d.approval_status='已审核' ORDER BY d.project_code)
SELECT PARCEL_ORIGINAL_ID,parcel_name,PROJECT_ORIGINAL_ID,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id FROM MDM_PARCEL pa LEFT JOIN proj p ON pa.PROJECT_ID=p.id where  p.id is not null and PARCEL_ORIGINAL_ID  is not null;
END P_SYS_PROJ_SYNCHRONIZATION;