create or replace PROCEDURE p_sys_analysis_Virtual_persons (
    companyid        IN                   varchar2,
    deptid        IN                   varchar2,
    info     OUT             SYS_REFCURSOR
) IS
--虚拟组解析
--作者：陈丽
--日期：2020/08/25
BEGIN
OPEN info FOR 
with base as(
SELECT r.user_account,r.company_id,r.company_name,r.dept_id,r.dept_name FROM sys_role_user_relation_result r
--【三级单位】：获取当前项目所属公司，递归所有父级公司集合（项目所属公司在三级单位子级公司），包含自身（项目所属公司在三级单位），并且公司层级=3，公司 id作为虚拟组解析公司。--递归所有父级公司集合，包含自身，并且公司层级=3 
INNER JOIN 
(
SELECT id FROM (
SELECT*FROM sys_business_unit m START WITH m.id=companyid CONNECT BY PRIOR m.parent_id=m.id
) org 
WHERE org.is_company=1 AND org.level_rank=3 
UNION ALL
--chenl 20200718 项目所属公司在三级单位。期望解析三级单位的子公司，计划运营岗位（实际是四级单位的）的人。
SELECT id FROM sys_business_unit m WHERE m.parent_id=companyid AND m.is_company=1 AND m.level_rank=4
) org
ON r.company_id=org.id WHERE r.virtual_group_name LIKE '%【三级单位】%' 
AND r.role_type=40 AND r.user_account IS NOT NULL 
UNION 
SELECT r.user_account,r.company_id,r.company_name,r.dept_id,r.dept_name FROM sys_role_user_relation_result r
--兄弟节点和所有子级，并且公司层级=3 
INNER JOIN 
(
SELECT id FROM (
SELECT*FROM sys_business_unit m1 WHERE EXISTS (
SELECT*FROM sys_business_unit m2 WHERE m1.parent_id=m2.parent_id AND m2.id=companyid) 
UNION
SELECT*FROM sys_business_unit m START WITH m.id=companyid CONNECT BY m.parent_id=PRIOR m.id) org WHERE org.is_company=1 AND org.level_rank=3
) org 
ON r.company_id=org.id WHERE r.virtual_group_name   LIKE '%【二级单位】%'
AND r.role_type=40 AND r.user_account IS NOT NULL)

select u.id as "id",
    base.user_account as "userAccount",
    base.company_id as "companyId",
    base.company_name as "companyName",
    base.dept_id as "deptId", 
    base.dept_name as "deptName",
    user_name as "userName",
    mobile_phone as "mobilePhone",
    SUBSTR(org_full_name,length('中国铁建地产集团->')+1 ) as "orgFullNname"
    from base left join sys_user u on base.user_account=u.USER_CODE
    left join SYS_BUSINESS_UNIT unit on base.dept_id=unit.id
;
end;