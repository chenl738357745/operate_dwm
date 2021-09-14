

-- 增加用户有权限的组织-项目树关键字。
-- SELECT * FROM sys_user where id='9fbd2419-a2a6-4c9d-a0f5-96576678a924'
-- call p_sys_get_user_company_proj ('b8712cc8-f614-4431-8931-d55a5d9d1a60',3)


DROP PROCEDURE IF EXISTS p_sys_get_user_company_proj;

/*
p_type:
1：返回公司-项目-分期
2：返回公司-项目。项目为末级。
3：返回所有项目id(含分期)。
4：将用户的项目权限范围保存到tmp_user_project_right表中。//不返回结果


*/
CREATE PROCEDURE p_sys_get_user_company_proj(IN p_user_id varchar(36),IN p_type int) 
begin

drop temporary table if exists t_org;	
drop temporary table if exists t_project;	
drop temporary table if exists t_org2;	
create temporary table t_org
	
	
-- 查询用户有数据权限的公司
select co.company_id,1 as right_company,is_include_child_company from (
select a.role_id,b.company_id,a.is_include_child_company from sys_role_link_project a inner join sys_project b on a.obj_id=b.id and a.obj_type=2
where b.is_deleted=0 and b.is_disabled=0
union 
select a.role_id,a.obj_id,a.is_include_child_company from sys_role_link_project a inner join sys_organization b on a.obj_id=b.id and b.is_disabled=0 and b.is_deleted=0
 where a.obj_type=1) co
inner join 

(
	-- 查询用户所在的角色：
	
	select a.role_id from sys_role_link_member a inner join sys_organization b on a.obj_id=b.id
	and b.is_disabled=0 and b.is_deleted=0
	inner join sys_station c on b.id=c.dept_id or b.id=c.company_id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id 
	where d.user_id=p_user_id
	union 
	select a.role_id from sys_role_link_member a 
	inner join sys_station c on a.obj_id=c.id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id
	where d.user_id=p_user_id) ro on co.role_id=ro.role_id
	union 
	-- 查询用户本身所在公司，需标识为没有权限
select a.company_id,0 as right_company,0 from sys_station a inner join sys_station_link_user d on a.id=d.station_id 
where d.user_id=p_user_id and a.is_deleted=0 and a.is_disabled=0;
	

create temporary table t_org2 select * from t_org;
	
	begin
	-- 通过游标遍历父级：
	declare t_companyid varchar(36);
	declare done int DEFAULT 0; 
	declare isinclude int DEFAULT 0; 
	declare cur_org CURSOR for   
	select company_id,is_include_child_company from t_org;
	-- 游标中的内容执行完后将done设置为1  
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;  
	
	-- 打开游标  
open cur_org;  
-- 执行循环  
  orgLoop:LOOP  

-- 取游标中的值  
    FETCH  cur_org into t_companyid,isinclude;  

-- 判断是否结束循环  
        IF done=1 THEN    
      LEAVE orgLoop;  
    END IF;   		

-- 执行操作：获取父级  
	insert into t_org(company_id)
	select _id from (
 SELECT 
                @org AS _id, 
                (SELECT @org := parent_id FROM sys_organization WHERE id = _id) AS parent_id
        FROM 
                (SELECT @org := t_companyid) vars,
                sys_organization h ) o left join t_org2 t on o._id=t.company_id
where _id is not null and t.company_id is null;	

-- 如果isinclude为1，则获取所有子级：
if isinclude=1 then

insert into t_org(company_id,right_company)

select o.id,1 from (
SELECT
    t.id 
FROM
    (
    SELECT
        @id idlist,
        ( SELECT @id := GROUP_CONCAT( id SEPARATOR ',' ) FROM sys_organization WHERE FIND_IN_SET( parent_id, @id ) ) sub 
    FROM
        sys_organization,
        ( SELECT @id := t_companyid ) vars 
    WHERE
        @id IS NOT NULL 
    ) tl,
    sys_organization t 
WHERE org_type=1 and is_disabled=0 and is_deleted=0 and 
    FIND_IN_SET( t.id, tl.idlist )) o left join t_org2 t on o.id=t.company_id
	where t.company_id is null;	
    
	end if;

 END LOOP orgLoop;  
-- 释放游标  
CLOSE cur_org;   
	
	end;
	

/*
 开始解析项目权限
*/
	
	create temporary table t_project
	-- 查询项目授权信息
	select b.id,b.company_id,b.city_id,b.project_code,b.project_name,b.project_full_code,
	b.project_full_name,b.parent_id,b.project_id,is_end,project_type,order_code
	 from sys_role_link_project a inner join v_sys_project b on a.obj_id=b.project_id and a.obj_type=2
	inner join 

(
	-- 查询用户所在的角色：
	
	select a.role_id from sys_role_link_member a inner join sys_organization b on a.obj_id=b.id
	and b.is_disabled=0 and b.is_deleted=0
	inner join sys_station c on b.id=c.dept_id or b.id=c.company_id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id 
	where d.user_id=p_user_id
	union 
	select a.role_id from sys_role_link_member a 
	inner join sys_station c on a.obj_id=c.id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id
	where d.user_id=p_user_id) ro on a.role_id=ro.role_id;
	
	
	-- 增加按公司授权的项目
	insert into t_project
	select distinct a.id,a.company_id,a.city_id,a.project_code,a.project_name,a.project_full_code,
	a.project_full_name,a.parent_id,a.project_id,is_end,project_type,order_code from v_sys_project a inner join t_org b on a.company_id=b.company_id and b.right_company=1;
	
	-- 组装公司-项目树：
	

	insert into t_project
	select b.id,b.id as company_id,null as city_id,org_code,org_name,org_code,org_name,parent_id,null,0 as is_end,'company' as project_type,order_code  from t_org a inner join sys_organization b on a.company_id=b.id;

	if p_type = 1 then
	
	select distinct id,company_id,city_id,project_code as org_code,project_name as org_name,project_full_code as org_full_code,project_full_name as org_full_name,parent_id,project_id,is_end,project_type as org_type,order_code from t_project order by order_code;
	end if;
	
	if p_type = 2 then 
	
		select distinct id,company_id,city_id,project_code as org_code,project_name as org_name,project_full_code as org_full_code,project_full_name as org_full_name,parent_id,project_id,
		case when project_type='project' then 1 else 0 end as  is_end,project_type as org_type,order_code from t_project where project_type<>'stage' order by order_code;
	
	end if;
	
	if p_type=3 then 

	select distinct id from t_project where project_type<>'company';
	
	end if;

    if p_type=4 then 

    -- 删除原有的项目权限数据
    delete from sys_user_project_right where user_id=p_user_id;
    -- 
    insert into sys_user_project_right(id,user_id,company_id,project_type,project_id,update_time)
    select distinct uuid_short() as id ,p_user_id as user_id,company_id,project_type,id as project_id,CURRENT_TIMESTAMP()
    from t_project where project_type<>'company'; 

    end if ;

end;




-- 增加用户有权限的组织树关键字。
-- SELECT * FROM sys_user where id='9fbd2419-a2a6-4c9d-a0f5-96576678a924'
-- call p_sys_get_user_company ('b8712cc8-f614-4431-8931-d55a5d9d1a60')


DROP PROCEDURE IF EXISTS p_sys_get_user_company ;

CREATE PROCEDURE p_sys_get_user_company(IN p_user_id varchar(36)) 
begin

drop temporary table if exists t_org;	
drop temporary table if exists t_org2;	
create temporary table t_org
	
	
-- 查询用户有数据权限的公司
select co.company_id,1 as right_company,is_include_child_company from (
select a.role_id,b.company_id,a.is_include_child_company from sys_role_link_project a inner join sys_project b on a.obj_id=b.id and a.obj_type=2
where b.is_deleted=0 and b.is_disabled=0
union 
select a.role_id,a.obj_id,a.is_include_child_company from sys_role_link_project a inner join sys_organization b on a.obj_id=b.id and b.is_disabled=0 and b.is_deleted=0
 where a.obj_type=1) co
inner join 

(
	-- 查询用户所在的角色：
	
	select a.role_id from sys_role_link_member a inner join sys_organization b on a.obj_id=b.id
	and b.is_disabled=0 and b.is_deleted=0
	inner join sys_station c on b.id=c.dept_id or b.id=c.company_id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id 
	where d.user_id=p_user_id
	union 
	select a.role_id from sys_role_link_member a 
	inner join sys_station c on a.obj_id=c.id
	and c.is_disabled=0 and c.is_deleted=0
	inner join sys_station_link_user d on c.id=d.station_id
	where d.user_id=p_user_id) ro on co.role_id=ro.role_id
	union 
	-- 查询用户本身所在公司
select a.company_id,1 as right_company,0 from sys_station a inner join sys_station_link_user d on a.id=d.station_id 
where d.user_id=p_user_id and a.is_deleted=0 and a.is_disabled=0;
	

create temporary table t_org2 select * from t_org;
	
	begin
	-- 通过游标遍历父级：
	declare t_companyid varchar(36);
	declare done int DEFAULT 0; 
	declare isinclude int DEFAULT 0; 
	declare cur_org CURSOR for   
	select company_id,is_include_child_company from t_org;
	-- 游标中的内容执行完后将done设置为1  
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;  
	
	-- 打开游标  
open cur_org;  
-- 执行循环  
  orgLoop:LOOP  

-- 取游标中的值  
    FETCH  cur_org into t_companyid,isinclude;  

-- 判断是否结束循环  
        IF done=1 THEN    
      LEAVE orgLoop;  
    END IF;   		

-- 执行操作：获取父级  
	insert into t_org(company_id)
	select _id from (
 SELECT 
                @org AS _id, 
                (SELECT @org := parent_id FROM sys_organization WHERE id = _id) AS parent_id
        FROM 
                (SELECT @org := t_companyid) vars,
                sys_organization h ) o left join t_org2 t on o._id=t.company_id
where _id is not null and t.company_id is null;	

-- 如果isinclude为1，则获取所有子级：
if isinclude=1 then

insert into t_org(company_id,right_company)

select o.id,1 from (
SELECT
    t.id 
FROM
    (
    SELECT
        @id idlist,
        ( SELECT @id := GROUP_CONCAT( id SEPARATOR ',' ) FROM sys_organization WHERE FIND_IN_SET( parent_id, @id ) ) sub 
    FROM
        sys_organization,
        ( SELECT @id := t_companyid ) vars 
    WHERE
        @id IS NOT NULL 
    ) tl,
    sys_organization t 
WHERE org_type=1 and is_disabled=0 and is_deleted=0 and 
    FIND_IN_SET( t.id, tl.idlist )) o left join t_org2 t on o.id=t.company_id
	where t.company_id is null;	
    
	end if;

 END LOOP orgLoop;  
-- 释放游标  
CLOSE cur_org;   
	
	end;
	
 select distinct  b.id,b.org_name,b.parent_id,a.right_company,b.order_code from t_org a inner join sys_organization b on a.company_id=b.id order by b.order_code;
	-- select * from t_org;

end;


