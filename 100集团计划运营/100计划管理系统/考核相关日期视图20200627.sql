CREATE OR REPLACE FORCE VIEW v_pom_month_quarter_year as
	    ----���㵱ǰʱ�䣬���꣬�����ȣ����µĿ�ʼʱ��ͽ���ʱ��
		--���ߣ�����
		--���ڣ�2020-06-27
with examination_day as (SELECT
         fn_pom_examination_day() - 1 as examination_day    FROM        dual)
 --��ǰ--�¿��˽�������
,now_m_end as (SELECT  trunc(SYSDATE, 'month') + examination_day- numtodsinterval(1/1000,'second') as d FROM examination_day) 
 --��ǰ--�¿��˽�������
,now_quarter_end as (SELECT  add_months(trunc(SYSDATE, 'Q'), 2) + examination_day- numtodsinterval(1/1000,'second')  as d   FROM  examination_day)       
 --��ǰ--�¿��˽�������
,now_year_end as (SELECT add_months(trunc(SYSDATE, 'yyyy'), 11) + examination_day- numtodsinterval(1/1000,'second')  as d   FROM  examination_day)
 --��һ��--�¿��˽�������
,next_m_end as (select add_months(d,1) as nd from now_m_end )
 --��һ��--�����˽�������
,next_quarter_end as (SELECT add_months(d, 3)  as nd  FROM  now_quarter_end)
 --��һ��--�꿼�˽�������
,next_year_end as (SELECT add_months(d, 12)  as nd  FROM   now_year_end)

---�ϲ�������ʱ��ϲ���һ��
,o_all_end as (select m.d as md,nm.nd as nmd
,q.d as qd,nq.nd as nqd
,y.d as yd ,ny.nd  as nyd
from 
(select * from now_m_end) m
 cross join
(select * from next_m_end ) nm
 cross join
(select * from now_quarter_end ) q
 cross join
(select * from next_quarter_end ) nq
 cross join
(select * from now_year_end ) y
 cross join
(select * from next_year_end ) ny
)
,�������ʱ�� as (select 
case when SYSDATE < md then md else  nmd end as m_end
,case when SYSDATE < qd then qd else  nqd end as quarter_end
,case when SYSDATE < yd then yd else  nyd end as year_end
from o_all_end)
,�꼾�� as (
select �������ʱ��.*
,add_months(m_end, -1) as m_begin
,add_months(quarter_end, -3) as quarter_begin
,add_months(year_end, -12) as year_begin from �������ʱ��)

select * from �꼾��;