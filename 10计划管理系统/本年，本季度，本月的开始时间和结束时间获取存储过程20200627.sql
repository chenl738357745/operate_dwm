create or replace PROCEDURE "P_POM_MONTH_QUARTER_YEAR" (
    now_date     in      DATE := SYSDATE,
    o_m_begin         OUT               DATE,
    o_m_end           OUT               DATE,
    o_quarter_begin   OUT               DATE,
    o_quarter_end     OUT               DATE,
    o_year_begin      OUT               DATE,
    o_year_end        OUT               DATE
) AS
		----计划考核日--计算当前时间，本年，本季度，本月考核的开始时间和结束时间
		--作者：陈丽
		--日期：2020-06-14
    examination_day    NUMBER(10) := 0;

    now_m_end          DATE;
    now_quarter_end    DATE;
    now_year_end       DATE;
    next_m_end         DATE;
    next_quarter_end   DATE;
    next_year_end      DATE;
    actual_date      DATE;
BEGIN

  dbms_output.put_line('输入时间:'||now_date||';');
--考核日
    examination_day := fn_pom_examination_day() - 1;
--自然月考核
    SELECT
        trunc(now_date, 'month') + examination_day- numtodsinterval(1/1000,'second'),
        add_months(trunc(now_date, 'Q'), 2) + examination_day- numtodsinterval(1/1000,'second'),
        add_months(trunc(now_date, 'yyyy'), 11) + examination_day- numtodsinterval(1/1000,'second')
    INTO
        now_m_end,
        now_quarter_end,
        now_year_end
    FROM
        dual; --截取到月（本月的第一天）
--下一个--自然月考核

    SELECT
        add_months(now_m_end, 1),
        add_months(now_quarter_end, 3),
        add_months(now_year_end, 12)
    INTO
        next_m_end,
        next_quarter_end,
        next_year_end
    FROM
        dual; --截取到月（本月的第一天）
   dbms_output.put_line('当前月度结束时间:'||now_m_end);
   dbms_output.put_line('当前季度结束时间:'||now_quarter_end);
   dbms_output.put_line('当前年度结束时间:'||now_year_end);


    dbms_output.put_line('下月度结束时间:'||next_m_end);
    dbms_output.put_line('下季度结束时间:'||next_quarter_end);
    dbms_output.put_line('下年度结束时间:'||next_year_end);
---- 月度考核范围
    IF now_date < now_m_end THEN
        o_m_end := now_m_end;
        o_m_begin := add_months(o_m_end, -1);
    ELSE
        o_m_end := next_m_end;
        o_m_begin := add_months(o_m_end, -1);
    END IF;

    ---- 季度考核范围
    IF now_date < now_quarter_end THEN    
        o_quarter_end := now_quarter_end;
        o_quarter_begin := add_months(o_quarter_end, -3);
    ELSE
        o_quarter_end := next_quarter_end;
        o_quarter_begin := add_months(o_quarter_end, -3);
    END IF;
    ---- 年度考核范围
    IF now_date < now_year_end THEN
        o_year_end := now_year_end;
        o_year_begin := add_months(o_year_end, -12);
    ELSE
        o_year_end := next_year_end;
        o_year_begin := add_months(o_year_end, -12);
    END IF;

END P_POM_MONTH_QUARTER_YEAR;