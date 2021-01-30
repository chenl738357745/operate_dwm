

with base as(select
-- a.UseCases,
LEFT(a.UseCases, PATINDEX('%,UseCase%',a.UseCases)-1) UseCases---SR-FR-OM012,UseCase, ,Public,Proposed,1.0,2020/9/30,2020/10/14,衡泽软件 徐峰,
,PATINDEX('%-%',a.UseCases)-3 'LeftLength'
 from [java_基础平台11] a)  

,结果 as (select 
REPLACE(UseCases,LEFT(UseCases,LeftLength),'') as 用例编号
,LEFT(UseCases,LeftLength) as 用例名称
,case when UseCases like '%au%' then '权限管理'
when UseCases like '%AM%' then '应用中心' 
when UseCases like '%BP%' then '业务参数' 
when UseCases like '%PM%' then '项目信息设置' 
when UseCases like '%UC%' then '身份与访问'
when UseCases like '%OM%' then '组织用户管理'  
else '' end    模块
----身份与访问
,case when UseCases like '%登录%UC%' then '登录'
when UseCases like '%密码%UC%' then '密码' 
----组织用户管理
 when UseCases like '%公司%OM%' then '管理公司部门'
when UseCases like '%岗位%OM%' then '管理岗位' 
when UseCases like '%用户%OM%' then '管理用户' 
----应用中心
when UseCases like '%应用%AM%' then '管理应用'
when UseCases like '%功能%AM%' then '管理功能' 
when UseCases like '%权限点%AM%' then '管理权限点' 
----权限管理
when UseCases like '%访问控制%au%' then '管理访问控制' 
when UseCases like '%分级授权%au%' then '管理分级授权' 
when UseCases like '%角色%au%' then '管理角色' 
else '' end    分组
,*
from base)

select * from 结果
--where 用例编号 like '%OM%'
 order by 模块 desc,right(用例编号, 3) 

