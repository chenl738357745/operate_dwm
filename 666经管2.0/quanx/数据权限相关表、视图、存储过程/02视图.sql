
-- 用于组装项目和分期到一张表，拼装项目全称、是否末级、项目类型
CREATE OR REPLACE VIEW v_sys_project AS 

-- 获取有分期的项目数据，设置是否末级为0
SELECT
	id,
	company_id,
	city_id,
	project_code,
	project_name,
	project_code AS project_full_code,
	project_name AS project_full_name,
	company_id AS parent_id,
    id as project_id,
	0 AS is_end,
	'project' AS project_type,
	order_code 
FROM
	sys_project a
	INNER JOIN ( SELECT DISTINCT project_id FROM sys_project_stage WHERE is_disabled = 0 AND is_deleted = 0 ) b ON a.id = b.project_id 
WHERE
	is_disabled = 0 
	AND is_deleted = 0 
	UNION ALL
-- 获取无分期的项目数据，设置是否末级为1
SELECT
	id,
	company_id,
	city_id,
	project_code,
	project_name,
	project_code AS project_full_code,
	project_name AS project_full_name,
	company_id AS parent_id,
    id as project_id,
	1 AS is_end,
	'project' AS project_type,
	order_code 
FROM
	sys_project a
	LEFT JOIN ( SELECT DISTINCT project_id FROM sys_project_stage WHERE is_disabled = 0 AND is_deleted = 0 ) b ON a.id = b.project_id 
WHERE
	is_disabled = 0 
	AND is_deleted = 0 
	AND b.project_id IS NULL 
	UNION ALL
	-- 获取分期数据
SELECT
	a.id,
	b.company_id,
	b.city_id,
	a.stage_code,
	a.stage_name,
	concat( b.project_code, '.', a.stage_code ) AS project_full_code,
	concat( b.project_name, '_', a.stage_name ) AS project_full_name,
	project_id AS parent_id,
    project_id,
	1 AS is_end,
	'stage' AS project_type,
	concat( b.order_code, '.', a.order_code ) AS order_code 
FROM
	sys_project_stage a
	INNER JOIN sys_project b ON a.project_id = b.id 
WHERE
	a.is_disabled = 0 
	AND a.is_deleted = 0 
	AND b.is_disabled = 0 
	AND b.is_deleted = 0;