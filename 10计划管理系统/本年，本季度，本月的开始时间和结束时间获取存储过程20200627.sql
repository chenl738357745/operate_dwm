create or replace PROCEDURE "P_POM_MONTH_QUARTER_YEAR" (
    now_date     in      DATE := SYSDATE,
    o_m_begin         OUT               DATE,
    o_m_end           OUT               DATE,
    o_quarter_begin   OUT               DATE,
    o_quarter_end     OUT               DATE,
    o_year_begin      OUT               DATE,
    o_year_end        OUT               DATE
) AS
		----�ƻ�������--���㵱ǰʱ�䣬���꣬�����ȣ����¿��˵Ŀ�ʼʱ��ͽ���ʱ��
		--���ߣ�����
		--���ڣ�2020-06-14
    examination_day    NUMBER(10) := 0;

    now_m_end          DATE;
    now_quarter_end    DATE;
    now_year_end       DATE;
    next_m_end         DATE;
    next_quarter_end   DATE;
    next_year_end      DATE;
    actual_date      DATE;
BEGIN

  dbms_output.put_line('����ʱ��:'||now_date||';');
--������
    examination_day := fn_pom_examination_day() - 1;
--��Ȼ�¿���
    SELECT
        trunc(now_date, 'month') + examination_day- numtodsinterval(1/1000,'second'),
        add_months(trunc(now_date, 'Q'), 2) + examination_day- numtodsinterval(1/1000,'second'),
        add_months(trunc(now_date, 'yyyy'), 11) + examination_day- numtodsinterval(1/1000,'second')
    INTO
        now_m_end,
        now_quarter_end,
        now_year_end
    FROM
        dual; --��ȡ���£����µĵ�һ�죩
--��һ��--��Ȼ�¿���

    SELECT
        add_months(now_m_end, 1),
        add_months(now_quarter_end, 3),
        add_months(now_year_end, 12)
    INTO
        next_m_end,
        next_quarter_end,
        next_year_end
    FROM
        dual; --��ȡ���£����µĵ�һ�죩
   dbms_output.put_line('��ǰ�¶Ƚ���ʱ��:'||now_m_end);
   dbms_output.put_line('��ǰ���Ƚ���ʱ��:'||now_quarter_end);
   dbms_output.put_line('��ǰ��Ƚ���ʱ��:'||now_year_end);


    dbms_output.put_line('���¶Ƚ���ʱ��:'||next_m_end);
    dbms_output.put_line('�¼��Ƚ���ʱ��:'||next_quarter_end);
    dbms_output.put_line('����Ƚ���ʱ��:'||next_year_end);
---- �¶ȿ��˷�Χ
    IF now_date < now_m_end THEN
        o_m_end := now_m_end;
        o_m_begin := add_months(o_m_end, -1);
    ELSE
        o_m_end := next_m_end;
        o_m_begin := add_months(o_m_end, -1);
    END IF;

    ---- ���ȿ��˷�Χ
    IF now_date < now_quarter_end THEN    
        o_quarter_end := now_quarter_end;
        o_quarter_begin := add_months(o_quarter_end, -3);
    ELSE
        o_quarter_end := next_quarter_end;
        o_quarter_begin := add_months(o_quarter_end, -3);
    END IF;
    ---- ��ȿ��˷�Χ
    IF now_date < now_year_end THEN
        o_year_end := now_year_end;
        o_year_begin := add_months(o_year_end, -12);
    ELSE
        o_year_end := next_year_end;
        o_year_begin := add_months(o_year_end, -12);
    END IF;

END P_POM_MONTH_QUARTER_YEAR;