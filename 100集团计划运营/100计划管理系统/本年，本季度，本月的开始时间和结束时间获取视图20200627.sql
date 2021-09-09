CREATE OR REPLACE FORCE VIEW v_pom_month_quarter_years as
--	    ----���㵱ǰʱ�䣬���꣬�����ȣ����µĿ�ʼʱ��ͽ���ʱ��
--		--���ߣ�����
--		--���ڣ�2020-06-27
with examination_day as (SELECT
         fn_pom_examination_day()-1 as e_day
         ,TO_DATE(''||to_char(SYSDATE, 'yyyy' )||'-'||to_char(SYSDATE, 'MM' )||'-01','YYYY-MM-DD') as cmday  
         FROM dual)
 --��ǰ--�¿��˽�������
,base as (
SELECT  trunc(cmday, 'month') + e_day as m_end
,add_months(trunc(cmday, 'Q'), 3) + e_day as quarter_end
,add_months(trunc(cmday, 'yyyy'), 12) + e_day as year_end
,cmday
FROM examination_day) 

,�꼾�� as (
select base.*
,add_months(m_end, -1) as m_begin
,add_months(quarter_end, -3) as quarter_begin
,add_months(year_end, -12) as year_begin
,to_char(add_months(m_end, -1), 'MM' ) as base_mm
,to_char(add_months(m_end, -1), 'yyyy' ) as base_yyyy
from base)

,mms as(SELECT column_value+0 mm   FROM TABLE ( split('1,2,3,4,5,6,7,8,9,10,11,12') ))

,��5�꼾�� as(
select  �꼾��.*,mms.*,yyyys.*,e_day
,months_between(TO_DATE(''||yyyy||'-'||mm||'-01','yyyy-mm-dd'),TO_DATE(''||base_yyyy||'-'||base_mm||'-01','yyyy-mm-dd')) as �·ݲ� 
from �꼾��
cross join  
(select to_char(SYSDATE, 'yyyy')-1 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-2 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-3 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-4 as yyyy from dual
union all
select to_char(SYSDATE, 'yyyy' )-0 as yyyy from dual) yyyys
cross join  mms
cross join examination_day
)

select 
--��5�꼾��.cmday,
yyyy,mm,to_char(add_months(add_months(m_end, �·ݲ�), -1), 'Q' ) as Q
,add_months(m_begin, �·ݲ�) as m_begin
,add_months(m_end, �·ݲ�) as m_end
,trunc(add_months(m_begin, �·ݲ�), 'Q')+e_day as quarter_begin
,add_months(trunc(add_months(m_begin, �·ݲ�), 'Q'), 3)+e_day as quarter_end

,trunc(add_months(m_begin, �·ݲ�), 'yyyy')+e_day as year_begin
,add_months(trunc(add_months(m_begin, �·ݲ�), 'yyyy'), 12)+e_day as year_end
 from ��5�꼾�� order by yyyy,mm;

--select * from o_all_end;