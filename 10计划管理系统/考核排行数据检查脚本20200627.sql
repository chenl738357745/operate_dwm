
select * from (
select node.id,node.NODE_NAME,PLAN_END_DATE,ACTUAL_END_DATE,vv.*  from pom_proj_plan_node node
left join pom_proj_plan plan on node.PROJ_PLAN_ID=plan.id
cross join v_pom_month_quarter_year vv
where plan.COMPANY_ID in (
  select ID from SYS_BUSINESS_UNIT
   start with id='ada74687-f244-4664-8ba5-716e52dada22' connect by prior id=parent_id)
   and plan.APPROVAL_STATUS='ÒÑÉóºË' )a 
   where ((actual_end_date>a.m_begin and actual_end_date<a.m_end )
   or ( PLAN_END_DATE>a.m_begin and PLAN_END_DATE<a.m_end 
     and (actual_end_date is null or (actual_end_date>a.m_begin and actual_end_date<a.m_end ))
     )) 
order by PLAN_END_DATE  desc