--------------------------------------------------------
--  �ļ��Ѵ��� - ����һ-����-23-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure P_SYS_PROJ_SYNCHRONIZATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "P_SYS_PROJ_SYNCHRONIZATION" AS
    --ͬ������������---��Ŀ���ڵ� ǿ��������һ��ͬ��
--����ԭ�򣺳�������ά���⣬�����ط�ʹ����Ŀ����ҡ�������ά����ʹ����Ŀ����ƣ�Ӧ�ƻ�ͳһ����ʹ�� ���ڡ�¥��sys_project,sys_project_stage,sys_build,sys_PARCEL
--���ߣ�����
--���ڣ�2020-06-19
--chenl 2021-01-05 ͬ�����ݼ��ݽ׶��ظ�������׶��ظ�ȥ�ش���
BEGIN------ͬ����������Ŀ
------������Ŀȫ·��
update mdm_project
set ORDER_HIERARCHY_CODE=(
    select code
    from (
             select p.id,u.ORDER_HIERARCHY_CODE||'.'||PROJECT_CODE as code
             from  mdm_project p
                       left join SYS_BUSINESS_UNIT u on  p.COMPANY_ID=u.id
         ) s where mdm_project.id=s.id
) where ID is not null;
commit;
----ɾ����Ŀ;
-- noinspection SqlWithoutWhere
delete from sys_project;
INSERT INTO sys_project (
    sn,---����
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
    project_record_name, ---��Ŀ��������///������20210422����
    is_cooperate,---�Ƿ������Ŀ///����20200619����

    PROJ_COOPERATE,
    PROJ_COOPERATE_ID,
---------------------- ��������
    project_get_time,
    company_id,
    company_name,
    legal_person_company_id,
    legal_person_company,
    legal_person_company_code,
    real_estate_share_ratio,
    series_ratio,
    person_liable,
    partners1,
    partners2,
    partners3,
    place_id,
    province_name,
    place_name,
    plane_figure,
    proj_address,
    approval_status,
    approval_time,
    approver_id,
    approver,
    remark,
    created,
    creator,
    creator_id,
    first_proj_approval_time,
    first_period_approval_time,
    project_original_id,
    project_version,
    province_id,
    city_id,
    create_station_id,
    create_station,
    modified,
    modifier_id,
    modifier,
    r_proj_id
) WITH
      phase as(  SELECT v.proj_id,v.phase_name FROM (
                                                        SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
                                                            SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
          SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv
                                                                                                                                    ON v.proj_id=vv.proj_id AND v.phase_order=vv.max
                 group by v.proj_id,v.phase_name),
      proj AS (
          SELECT d.id,d.project_name,d.project_code,---------------------
                 e.phase_name,d.city_name,d.order_hierarchy_code,---------------------
                 d.project_reply_name,d.project_popularize_name, d.project_record_name,d.is_cooperate,d.PROJ_COOPERATE,
                 d.PROJ_COOPERATE_ID,
                 d.Project_Get_Time,
                 d.Company_Id,
                 d.Company_Name,
                 d.Legal_Person_Company_Id,
                 d.Legal_Person_Company,
                 d.Legal_Person_Company_Code,
                 d.Real_Estate_Share_Ratio,
                 d.Series_Ratio,
                 d.Person_Liable,
                 d.Partners1,
                 d.Partners2,
                 d.Partners3,
                 d.Place_Id,
                 d.Province_Name,
                 d.Place_Name,
                 d.Plane_Figure,
                 d.Proj_Address,
                 d.Approval_Status,
                 d.Approval_Time,
                 d.Approver_Id,
                 d.Approver,
                 d.Remark,
                 d.Created,
                 d.Creator,
                 d.Creator_Id,
                 d.First_Proj_Approval_Time,
                 d.First_Period_Approval_Time,
                 d.Project_Original_Id,
                 d.Project_Version,
                 d.Province_Id,
                 d.City_Id,
                 d.Create_Station_Id,
                 d.Create_Station,
                 d.Modified,
                 d.Modifier_Id,
                 d.Modifier,r_proj_id

          FROM mdm_project d LEFT JOIN phase e ON d.project_original_id=e.proj_id WHERE d.approval_status='�����' and IS_DELETE=0 ORDER BY d.order_hierarchy_code)
SELECT ROWNUM sn,project_original_id AS id,project_name AS name,modified AS updatedate,
       project_code AS code,company_id AS unitid,company_name AS unitname,phase_name AS state,
       proj_address AS address,city_id AS citycode,city_name AS cityname,modifier_id AS updateuserid,
       modifier AS updateuser,project_get_time AS takedate,order_hierarchy_code,project_reply_name,
       project_popularize_name,project_record_name,IS_COOPERATE,PROJ_COOPERATE,PROJ_COOPERATE_ID,
       proj.project_get_time,
       proj.company_id,
       proj.company_name,
       proj.legal_person_company_id,
       proj.legal_person_company,
       proj.legal_person_company_code,
       proj.real_estate_share_ratio,
       proj.series_ratio,
       proj.person_liable,
       proj.partners1,
       proj.partners2,
       proj.partners3,
       proj.place_id,
       proj.province_name,
       proj.place_name,
       proj.plane_figure,
       proj.proj_address,
       proj.approval_status,
       proj.approval_time,
       proj.approver_id,
       proj.approver,
       proj.remark,
       proj.created,
       proj.creator,
       proj.creator_id,
       proj.first_proj_approval_time,
       proj.first_period_approval_time,
       proj.project_original_id,
       proj.project_version,
       proj.province_id,
       proj.city_id,
       proj.create_station_id,
       proj.create_station,
       proj.modified,
       proj.modifier_id,
       proj.modifier,
       proj.r_proj_id
FROM proj ORDER BY ROWNUM;
-----20210201 chenl ���·���sys_project�����ֶ�
update SYS_PROJECT
set
    corp_id=LEGAL_PERSON_COMPANY_ID,
    corp_name=LEGAL_PERSON_COMPANY,
    copr_id=LEGAL_PERSON_COMPANY_ID,
    copr_name=LEGAL_PERSON_COMPANY
where ID is not null;

-- noinspection SqlWithoutWhere
delete from SYS_PARCEL; ---ͬ���ڵ�
INSERT INTO sys_parcel (id,parcel_name,project_id,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id)
WITH
    phase as(  SELECT v.proj_id,v.phase_name FROM (
                                                      SELECT a.proj_id,a.phase_order,b.phase_name FROM mdm_project_phase a LEFT JOIN (
                                                          SELECT id,phase_name FROM mdm_phase) b ON a.phase_id=b.id) v INNER JOIN (
        SELECT proj_id,MAX(phase_order) max FROM mdm_project_phase GROUP BY proj_id) vv
                                                                                                                                  ON v.proj_id=vv.proj_id AND v.phase_order=vv.max
               group by v.proj_id,v.phase_name)
        ,
    proj AS (
        SELECT d.id FROM mdm_project d LEFT JOIN phase e ON d.project_original_id=e.proj_id WHERE d.approval_status='�����' ORDER BY d.order_hierarchy_code)
SELECT PARCEL_ORIGINAL_ID,parcel_name,PROJECT_ORIGINAL_ID,land_transfer_contract_code,contract_total_price,land_transfer_method,land_transferer,land_get_date,hand_over_date,land_state,land_address,land_useage,province_name,city_name,district_name,remarks,province_id,city_id,district_id

FROM MDM_PARCEL pa LEFT JOIN proj p ON pa.PROJECT_ID=p.id where  p.id is not null and PARCEL_ORIGINAL_ID  is not null;
----ͬ��ӳ�����,��Ŀ��ӳ���ϵ����Ŀ���ݣ�r_proj_id������ʱʹ��ԭʼid
INSERT INTO MDM_PROJ_MAPPING (project_original_id,r_proj_id,project_name)
WITH
    proj AS (select sp.id,
                    case when sp.r_proj_id is null then TO_CHAR(sp.id) else TO_CHAR(sp.r_proj_id) end  as r_proj_id
                     ,sp.project_name
             from  sys_project sp
                       left join MDM_PROJ_MAPPING pm
                                 on sp.id=pm.project_original_id where pm.project_original_id is null)
select * from proj ;
commit;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END P_SYS_PROJ_SYNCHRONIZATION;

/
