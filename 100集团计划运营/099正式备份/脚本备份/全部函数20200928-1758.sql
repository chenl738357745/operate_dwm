--------------------------------------------------------
--  文件已创建 - 星期一-九月-28-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function FIND_IN_SET
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FIND_IN_SET" (piv_str1 varchar2, piv_str2 varchar2, p_sep varchar2 := ',')
RETURN NUMBER IS
  l_idx    number:=0; -- 用于计算piv_str2中分隔符的位置
  str      varchar2(500);  -- 根据分隔符截取的子字符串
  piv_str  varchar2(500) := piv_str2; -- 将piv_str2赋值给piv_str
  res      number:=0; -- 返回结果
  res_place      number:=0;-- 原字符串在目标字符串中的位置
BEGIN
-- 如果字段是null 则返回0
IF piv_str2 IS NULL THEN
  RETURN res;
END IF;
-- 如果piv_str中没有分割符，直接判断piv_str1和piv_str是否相等，相等 res_place=1
IF instr(piv_str, p_sep, 1) = 0 THEN
   IF piv_str = piv_str1 THEN
      res_place:=1;
      res:= res_place;
   END IF;
ELSE
 -- 循环按分隔符截取piv_str
LOOP
    l_idx := instr(piv_str,p_sep);
    --
    res_place := res_place + 1;
    -- 当piv_str中还有分隔符时
      IF l_idx > 0 THEN
      -- 截取第一个分隔符前的字段str
         str:= substr(piv_str,1,l_idx-1);
         -- 判断 str 和piv_str1 是否相等，相等则结束循环判断
         IF str = piv_str1 THEN
           res:= res_place;
           EXIT;
         END IF;
        piv_str := substr(piv_str,l_idx+length(p_sep));
      ELSE
      -- 当截取后的piv_str 中不存在分割符时，判断piv_str和piv_str1是否相等，相等 res=res_path
        IF piv_str = piv_str1 THEN
           res:= res_place;
        END IF;
        -- 无论最后是否相等，都跳出循环
        EXIT;
      END IF;
 END LOOP;
 -- 结束循环
 END IF;
 -- 返回res
 RETURN res;
END FIND_IN_SET;


/
--------------------------------------------------------
--  DDL for Function FIND_NODE_LEVEL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FIND_NODE_LEVEL" (originalplan_id IN VARCHAR2)
    RETURN NUMBER IS 
     LEVEL NUMBER(5);
     nodeL number(5):= 0; 
     msg clob := '1';
     TOTAL NUMBER(5):=0;
    BEGIN
     SELECT COUNT(*) INTO TOTAL FROM POM_PROJ_PLAN WHERE original_plan_id = originalplan_id;
      IF TOTAL>=2 THEN
               SELECT  wm_concat( NL.NODE_LEVEL ) into msg FROM
              (
                -- 最新版本
              SELECT distinct pn.ORIGINAL_plan_ID,pn.ORIGINAL_NODE_ID,pn.NODE_LEVEL,pn.NODE_NAME,pn.PLAN_START_DATE,pn.PLAN_END_DATE 
              FROM POM_PROJ_PLAN_NODE PN WHERE pn.is_disable = 0 AND PN.PROJ_PLAN_ID = 
              (SELECT  p.id from
                      (SELECT row_number() over(partition by original_plan_id order by plan_version desc) rn, PP.* FROM  POM_PROJ_PLAN pp) p 
               where rn = 1 AND p.original_plan_id = originalplan_id) 
               MINUS 
               -- 前一版本
              SELECT distinct pn1.ORIGINAL_plan_ID,pn1.ORIGINAL_NODE_ID,pn1.NODE_LEVEL,pn1.NODE_NAME,pn1.PLAN_START_DATE,pn1.PLAN_END_DATE FROM POM_PROJ_PLAN_NODE PN1 WHERE pn1.is_disable = 0 
              AND PN1.PROJ_PLAN_ID = 
              (select p1.ID from
                      (SELECT row_number() over(partition by original_plan_id order by plan_version desc) rn, PP1.* FROM  POM_PROJ_PLAN pp1) p1 
                where rn = 2 AND p1.original_plan_id = originalplan_id )
             ) NL;
             if msg like '%里程碑%' or msg like '%一级节点%'   then nodeL := 1;
                else nodeL := 2;
            end if;
        ELSE nodeL :=0;
        END IF;
        level := nodeL;
    RETURN (LEVEL);
 END FIND_NODE_LEVEL;

/
--------------------------------------------------------
--  DDL for Function FN_BIZPARAM_CONFIG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_BIZPARAM_CONFIG" (i_param_name VARCHAR2) 
RETURN VARCHAR2
AS
--配置类业务参数获取
--作者：陈丽 20200721 配置类业务参数获取
--日期：2020-07-21
o_param_value VARCHAR2(50);
BEGIN 
    select PARAM_VALUE INTO o_param_value from SYS_BIZPARAM_REGIST r
left join SYS_BIZPARAM_OPTION o on r.id=o.PARAM_ID
where UPPER(PARAM_NAME)=UPPER(i_param_name);
    RETURN o_param_value;
END;

/
--------------------------------------------------------
--  DDL for Function FN_CN_NUMBER_CHAR_TO_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_CN_NUMBER_CHAR_TO_NUMBER" (str varchar2)
    return int
-- 中文数字字符转数值 如无(0) 一(1) 二(2)
as
    ret int := 0;
begin
    begin
        ret := TO_NUMBER(str);
    exception when others then
        ret :=
            case str when '一' then 1
                     when '二' then 2
                     when '三' then 3
                     when '四' then 4
                     when '五' then 5
                     when '六' then 6
                     when '七' then 7
                     when '八' then 8
                     when '九' then 9
                     when '十' then 10
                end;
    end;
    return ret;
end;

/
--------------------------------------------------------
--  DDL for Function FN_CONVERTDECIMALTOPERCENTAGE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_CONVERTDECIMALTOPERCENTAGE" (
	DecimalNumber  IN number
)
RETURN varchar2 AUTHID current_user
AS
PercentageNumber varchar2(50);
BEGIN
	IF DecimalNumber IS NULL THEN
		PercentageNumber:='0.00%';
	ELSE
		PercentageNumber:= to_char(floor(DecimalNumber*100),'fm9999999990')||'%';
	END IF;
	RETURN PercentageNumber;
END;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_DAY_CONVERT_MONTH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_DAY_CONVERT_MONTH" 
(
  day IN NUMBER 
) RETURN VARCHAR2 AUTHID current_user AS 
resultStr varchar2(70);
BEGIN
    if day is null then
        resultStr:='';
    elsif day <= 31 then
        resultStr := day || '天';
    elsif day > 31 then
        resultStr := to_char(trunc(day / 31, 1) ,'fm9999999990.0')|| '月';
    end if;
  RETURN resultStr;
END FN_DWM_DAY_CONVERT_MONTH;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_DEC_CONVERT_PCT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_DEC_CONVERT_PCT" 
(
  PARAM IN NUMBER 
) RETURN VARCHAR2 AUTHID current_user AS
resultStr varchar2(70);
BEGIN
--  resultStr := (PARAM * 100) || '%';
  if PARAM is null then resultStr := '0%';
  elsif PARAM = 0 then resultStr := '0%';
  else resultStr := to_char((PARAM * 100),'9999990') || '%';
  end if;
  resultStr := trim(resultStr);
  RETURN resultStr;
END FN_DWM_DEC_CONVERT_PCT;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_DURATIONDAYSDEAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_DURATIONDAYSDEAL" (
	startTime date,
    endTime date,
    param VARCHAR2
)
RETURN varchar2 AUTHID current_user
AS
resultStr varchar2(70);
resultStrHtml varchar2(70);
startDate date;
endDate date;
BEGIN
   if startTime is null or endTime is null then
         resultStrHtml:='';
         resultStr:='';
   else
        startDate:=to_date(to_char(startTime, 'YYYY-MM-DD'),'yyyy-mm-dd');
        endDate:=to_date(to_char(endTime, 'YYYY-MM-DD'),'yyyy-mm-dd');
             if startDate<endDate then
                    if  endDate-startDate>31 then
                        resultStr:='延误'||to_char(trunc(months_between(endDate,startDate),1))||'月首开';
                        resultStrHtml:='<span style="color:#FF0000;">'||resultStr||'</span>';
                    else
                             resultStr:='延误'||to_char(endDate-startDate)||'天首开';
                              if endDate-startDate>=7 then
                                 resultStrHtml:='<span style="color:#FF0000;">'||resultStr||'</span>';
                              else
                                 resultStrHtml:='<span style="color:#FF9900;">'||resultStr||'</span>';
                              end if;
                    end if;
            elsif startDate=endDate then
                resultStr:='按时完成';
                resultStrHtml:='<span style="color:#33CC99;">'||resultStr||'</span>';
            else 
                 if  startDate-endDate >31 then
                 resultStr:='提前'||to_char(trunc(months_between(startDate,endDate),1))||'月首开';
                 resultStrHtml:='<span style="color:#33CC99;">'||resultStr||'</span>';
                 else
                 resultStr:='提前'||to_char(startDate-endDate)||'天首开';
                 resultStrHtml:='<span style="color:#33CC99;">'||resultStr||'</span>';
                 end if;
            end if;
    end if;
    if   param = 'label'  then
    RETURN resultStrHtml;
    else
    RETURN resultStr;
    end if;
END;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_FONT_COLOR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_FONT_COLOR" 
(
  PARAM IN VARCHAR2 
) RETURN VARCHAR2 AUTHID current_user AS
resultStr varchar2(300);
BEGIN
    resultStr := '<span style="color: #169BD5">' || PARAM || '</span>';
  RETURN resultStr;
END FN_DWM_FONT_COLOR;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_FONT_LAYERED_COLOR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_FONT_LAYERED_COLOR" 
(
  PARAM IN NUMBER 
, criticalPoint IN NUMBER 
) RETURN VARCHAR2 AUTHID current_user AS
resultStr varchar2(200);
BEGIN
  if PARAM = 0 then 
    resultStr := '<span style="color: #169BD5">' || '0%' || '</span>';
  elsif PARAM >= criticalPoint then
    resultStr := '<span style="color: #00CC66">' || trim(to_char((PARAM * 100),'99990')) || '%' || '</span>';
  elsif PARAM < criticalPoint then
    resultStr := '<span style="color: #169BD5">' || trim(to_char((PARAM * 100),'99990')) || '%' || '</span>';   
  end if;  
  RETURN resultStr;
END FN_DWM_FONT_LAYERED_COLOR;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_MULTIPLE_AND_UNIT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_MULTIPLE_AND_UNIT" 
(
  param IN NUMBER 
, Multiple IN NUMBER 
, unit IN VARCHAR2 
) RETURN VARCHAR2 AUTHID current_user AS 
resultStr varchar2(70);
BEGIN
  if param is null then resultStr := '0.00' || unit;
  elsif param = 0 then resultStr := '0.00' || unit;
  else resultStr := to_char((param / Multiple),'99999990.00') || unit;
  end if;
  resultStr := trim(resultStr);
  RETURN resultStr;
END FN_DWM_MULTIPLE_AND_UNIT;

/
--------------------------------------------------------
--  DDL for Function FN_DWM_RISKSUMMARYDEAL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWM_RISKSUMMARYDEAL" (
	PlanTime date:='2020-3-24',
    NewPlanTime date:='2020-4-10',
    param VARCHAR2
)
RETURN varchar2 AUTHID current_user
AS
resultHtmlStr varchar2(200);
resultStr varchar2(200);
PlanDate date;
NewPlanDate date;
NowDate date;
BEGIN
NowDate:=to_date(to_char(sysdate, 'YYYY-MM-DD'),'yyyy-mm-dd');
if PlanTime is null and NewPlanTime is null then
         resultStr:='';
elsif  NewPlanTime is null then
     PlanDate:=to_date(to_char(PlanTime, 'YYYY-MM-DD'),'yyyy-mm-dd');
     if  NowDate<=PlanDate then 
         resultStr:='按时首开无风险';
         resultHtmlStr:='<span style="color:#33CC99;">'||resultStr||'</span>';
     else
         if  NowDate-PlanDate >31 then 
             resultStr:='已延时'||to_char(trunc(months_between(NowDate,PlanDate),1),'fm9999999990.0')||'月首开';
             resultHtmlStr:='<span style="color:#FF0000;">'||resultStr||'</span>';
        else
                 resultStr:='已延时'||to_char(NowDate-PlanDate)||'天首开';
                     if NowDate-PlanDate>=7 then
                        resultHtmlStr:='<span style="color:#FF0000;">'||resultStr||'</span>';
                    else
                        resultHtmlStr:='<span style="color:#FF9900;">'||resultStr||'</span>';
                    end if;
           end if;
    end if;
else
    PlanDate:=to_date(to_char(PlanTime, 'YYYY-MM-DD'),'yyyy-mm-dd');
    NewPlanDate:=to_date(to_char(NewPlanTime, 'YYYY-MM-DD'),'yyyy-mm-dd');
     if NewPlanDate=PlanDate then
         resultStr:='按时首开无风险';
         resultHtmlStr:='<span style="color:#33CC99;">'||resultStr||'</span>';
         if   param = 'label'  then
             RETURN resultHtmlStr;
        else
             RETURN resultStr;
        end if;
     end if;
   if PlanDate<NewPlanDate then
                    if  NewPlanDate-PlanDate>31 then
                        resultStr:='已延时'||to_char(trunc(months_between(NowDate,PlanDate),1),'fm9999999990.0')||'月首开，预计延时'||to_char(trunc(months_between(NewPlanDate,PlanDate),1),'fm9999999990.0')||'月首开';
                         resultHtmlStr:='<span style="color:#FF0000;">'||resultStr||'</span>';
                    else
                         if NewPlanDate-PlanDate>=7 then
                            resultStr:='已延时'||to_char(NowDate-PlanDate)||'天首开，预计延时'||to_char(NewPlanDate-PlanDate)||'天首开';
                             resultHtmlStr:='<span style="color:#FF0000;">'||resultStr||'</span>';
                          else
                             resultStr:='已延时'||to_char(NowDate-PlanDate)||'天首开，预计延时'||to_char(NewPlanDate-PlanDate)||'天首开';
                             resultHtmlStr:='<span style="color:#FF9900;">'||resultStr||'</span>';
                          end if;
                    end if;
            else 
                     if  PlanDate-NewPlanDate >31 then
                        resultStr:='提前'||to_char(trunc(months_between(PlanDate,NewPlanDate),1),'fm9999999990.0')||'月首开';
                        resultHtmlStr:='<span style="color:#33CC99;">'||resultStr||'</span>';
                     else
                        resultStr:='提前'||to_char(PlanDate-NewPlanDate)||'天首开';
                        resultHtmlStr:='<span style="color:#33CC99;">'||resultStr||'</span>';
                     end if;
            end if;
end if;
     if   param = 'label'  then
             RETURN resultHtmlStr;
        else
             RETURN resultStr;
        end if;
END;

/
--------------------------------------------------------
--  DDL for Function FN_DWN_AMOUNTTOBILLIONYUAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWN_AMOUNTTOBILLIONYUAN" (
	money  IN number
)
RETURN varchar2 AUTHID current_user
AS
BillionYuan number;
BEGIN
	IF money IS NULL THEN
		BillionYuan:=0;
	ELSE
		BillionYuan:=trunc(money/100000000,4);
	END IF;
	RETURN to_char(BillionYuan,'fm9999999990.00')||'亿';
END;

/
--------------------------------------------------------
--  DDL for Function FN_DWN_AREATO1000SQUARE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_DWN_AREATO1000SQUARE" (
	areaSquare  IN number
)
RETURN varchar AUTHID current_user
AS
Square number;
BEGIN
	IF areaSquare IS NULL THEN
		Square:=0;
	ELSE
		Square:=trunc(areaSquare/10000,2);
	END IF;
	RETURN to_char(Square,'fm9999999990.00')||'万方';
END;

/
--------------------------------------------------------
--  DDL for Function FN_GET_API_IP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_GET_API_IP" RETURN VARCHAR2
AS
BEGIN
	--正式环境id
/*	RETURN '10.22.2.25';*/
	
	
	--测试环境id
	RETURN '10.22.2.142';
END;

/
--------------------------------------------------------
--  DDL for Function FN_GET_API_KEY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_GET_API_KEY" RETURN VARCHAR2
AS
BEGIN
	--计划运营正式api_key--
	/*RETURN '20e2976a-5ac7-4b71-8d8f-0357f49f08f4';*/
	
	--计划运营测试环境API_KEY
	RETURN 'aa916b68-36c3-4745-a897-dd2c5936b478' ;
	
END;

/
--------------------------------------------------------
--  DDL for Function FN_POM_EXAMINATION_DAY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_POM_EXAMINATION_DAY" RETURN VARCHAR2
AS
BEGIN
	--计划的考核日--
	RETURN 1 ;
END;

/
--------------------------------------------------------
--  DDL for Function FN_VARCHAR_TO_DATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_VARCHAR_TO_DATE" (dateStr VARCHAR2,format VARCHAR2) return date is
BEGIN
	declare num date;
          query_sql varchar2(100);
    begin
      query_sql := 'select TO_DATE('||dateStr||','||format||') from dual';
      execute immediate query_sql into num;
      return num;
    end;
END FN_VARCHAR_TO_DATE;


/
--------------------------------------------------------
--  DDL for Function FN_VARCHAR_TO_NUMBER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FN_VARCHAR_TO_NUMBER" (SN VARCHAR2) return number is
begin
    declare num number;
            query_sql varchar2(100);
    begin
      query_sql := 'select to_number('||SN||') from dual';
      execute immediate query_sql into num;
      return num;
    end;
  end FN_VARCHAR_TO_NUMBER;


/
--------------------------------------------------------
--  DDL for Function GET_JUMP_URL_DOMAIN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_JUMP_URL_DOMAIN" (DOMAIN_TYPE VARCHAR2, DOMAIN_ID VARCHAR2) 
RETURN VARCHAR2
AS
--获取域名
--修改者：陈丽 20200626 兼容code
--日期：2020-03-31
BACK_ID VARCHAR2(36);
BEGIN
    SELECT APPLICATION_URL INTO BACK_ID FROM SYS_APPLICATION_TERMINAL 
    WHERE (UPPER(APPLICATION_ID) = UPPER(DOMAIN_ID)  or UPPER(APPLICATION_CODE)=UPPER(DOMAIN_ID))
    AND UPPER(APPLICATION_TERMINAL_CODE) = UPPER(DOMAIN_TYPE);
    RETURN BACK_ID;
END;


/
--------------------------------------------------------
--  DDL for Function GET_PYJM
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_PYJM" (P_NAME IN VARCHAR2)
    RETURN VARCHAR2
AS
    V_COMPARE   VARCHAR2 (100);
    V_RETURN    VARCHAR2 (4000);
BEGIN
    DECLARE
        FUNCTION F_NLSSORT (P_WORD IN VARCHAR2)
            RETURN VARCHAR2
        AS
        BEGIN
            RETURN NLSSORT (P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
        END;
    BEGIN
        FOR I IN 1 .. LENGTH (P_NAME)
        LOOP
            V_COMPARE := F_NLSSORT (SUBSTR (P_NAME, I, 1));

            IF     V_COMPARE >= F_NLSSORT ('吖')
               AND V_COMPARE <= F_NLSSORT ('驁')
            THEN
                V_RETURN := V_RETURN || 'A';
            ELSIF     V_COMPARE >= F_NLSSORT ('八')
                  AND V_COMPARE <= F_NLSSORT ('簿')
            THEN
                V_RETURN := V_RETURN || 'B';
            ELSIF     V_COMPARE >= F_NLSSORT ('嚓')
                  AND V_COMPARE <= F_NLSSORT ('錯')
            THEN
                V_RETURN := V_RETURN || 'C';
            ELSIF     V_COMPARE >= F_NLSSORT ('咑')
                  AND V_COMPARE <= F_NLSSORT ('鵽')
            THEN
                V_RETURN := V_RETURN || 'D';
            ELSIF     V_COMPARE >= F_NLSSORT ('妸')
                  AND V_COMPARE <= F_NLSSORT ('樲')
            THEN
                V_RETURN := V_RETURN || 'E';
            ELSIF     V_COMPARE >= F_NLSSORT ('发')
                  AND V_COMPARE <= F_NLSSORT ('猤')
            THEN
                V_RETURN := V_RETURN || 'F';
            ELSIF     V_COMPARE >= F_NLSSORT ('旮')
                  AND V_COMPARE <= F_NLSSORT ('腂')
            THEN
                V_RETURN := V_RETURN || 'G';
            ELSIF     V_COMPARE >= F_NLSSORT ('妎')
                  AND V_COMPARE <= F_NLSSORT ('夻')
            THEN
                V_RETURN := V_RETURN || 'H';
            ELSIF     V_COMPARE >= F_NLSSORT ('丌')
                  AND V_COMPARE <= F_NLSSORT ('攈')
            THEN
                V_RETURN := V_RETURN || 'J';
            ELSIF     V_COMPARE >= F_NLSSORT ('咔')
                  AND V_COMPARE <= F_NLSSORT ('穒')
            THEN
                V_RETURN := V_RETURN || 'K';
            ELSIF     V_COMPARE >= F_NLSSORT ('垃')
                  AND V_COMPARE <= F_NLSSORT ('擽')
            THEN
                V_RETURN := V_RETURN || 'L';
            ELSIF     V_COMPARE >= F_NLSSORT ('嘸')
                  AND V_COMPARE <= F_NLSSORT ('椧')
            THEN
                V_RETURN := V_RETURN || 'M';
            ELSIF     V_COMPARE >= F_NLSSORT ('拏')
                  AND V_COMPARE <= F_NLSSORT ('瘧')
            THEN
                V_RETURN := V_RETURN || 'N';
            ELSIF     V_COMPARE >= F_NLSSORT ('筽')
                  AND V_COMPARE <= F_NLSSORT ('漚')
            THEN
                V_RETURN := V_RETURN || 'O';
            ELSIF     V_COMPARE >= F_NLSSORT ('妑')
                  AND V_COMPARE <= F_NLSSORT ('曝')
            THEN
                V_RETURN := V_RETURN || 'P';
            ELSIF     V_COMPARE >= F_NLSSORT ('七')
                  AND V_COMPARE <= F_NLSSORT ('裠')
            THEN
                V_RETURN := V_RETURN || 'Q';
            ELSIF     V_COMPARE >= F_NLSSORT ('亽')
                  AND V_COMPARE <= F_NLSSORT ('鶸')
            THEN
                V_RETURN := V_RETURN || 'R';
            ELSIF     V_COMPARE >= F_NLSSORT ('仨')
                  AND V_COMPARE <= F_NLSSORT ('蜶')
            THEN
                V_RETURN := V_RETURN || 'S';
            ELSIF     V_COMPARE >= F_NLSSORT ('侤')
                  AND V_COMPARE <= F_NLSSORT ('籜')
            THEN
                V_RETURN := V_RETURN || 'T';
            ELSIF     V_COMPARE >= F_NLSSORT ('屲')
                  AND V_COMPARE <= F_NLSSORT ('鶩')
            THEN
                V_RETURN := V_RETURN || 'W';
            ELSIF     V_COMPARE >= F_NLSSORT ('夕')
                  AND V_COMPARE <= F_NLSSORT ('鑂')
            THEN
                V_RETURN := V_RETURN || 'X';
            ELSIF     V_COMPARE >= F_NLSSORT ('丫')
                  AND V_COMPARE <= F_NLSSORT ('韻')
            THEN
                V_RETURN := V_RETURN || 'Y';
            ELSIF     V_COMPARE >= F_NLSSORT ('帀')
                  AND V_COMPARE <= F_NLSSORT ('咗')
            THEN
                V_RETURN := V_RETURN || 'Z';
            END IF;
        END LOOP;

        RETURN V_RETURN;
    END;
END;

/
--------------------------------------------------------
--  DDL for Function GET_UUID
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_UUID" return varchar2 is
  v_uuid varchar(36);
begin
  v_uuid := lower(rawtohex(sys_guid()));
  v_uuid := substr(v_uuid, 1, 8) || '-' || substr(v_uuid, 9, 4) || '-' ||
            substr(v_uuid, 13, 4) || '-' || substr(v_uuid, 17, 4) || '-' ||
            substr(v_uuid, 21, 12);
  return v_uuid;
end get_uuid;

/
--------------------------------------------------------
--  DDL for Function IS_DATE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "IS_DATE" (mydate   in   varchar2)
    RETURN NUMBER IS
    tmp    DATE;
BEGIN
  tmp := TO_DATE(nvl(mydate,'00'), 'yyyy-MM-dd');
  RETURN 1;
  EXCEPTION
     WHEN OTHERS THEN
         RETURN 0;
END;

/
--------------------------------------------------------
--  DDL for Function SPLIT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SPLIT" (p_list CLOB, p_sep VARCHAR2 := ',') 
RETURN tabletype 
PIPELINED 
/************************************** 
* Function: 返回字符串被指定字符分割后的表类型。 
* Parameters: p_list: 待分割的字符串。 
p_sep: 分隔符，默认逗号，也可以指定字符或字符串。 
* Example: SELECT * 
FROM users 
WHERE u_id IN (SELECT COLUMN_VALUE 
FROM table (split ('1,2'))) 
返回u_id为1和2的两行数据。 
**************************************/ 
IS 
l_idx PLS_INTEGER; 
v_list VARCHAR2 (32676) := p_list; 
BEGIN 
LOOP 
l_idx := INSTR (v_list, p_sep); 
IF l_idx > 0 
THEN 
PIPE ROW (SUBSTR (v_list, 1, l_idx - 1)); 
v_list := SUBSTR (v_list, l_idx + LENGTH (p_sep)); 
ELSE 
PIPE ROW (v_list); 
EXIT; 
END IF; 
END LOOP; 
END; 

/
--------------------------------------------------------
--  DDL for Function SPLITSTR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SPLITSTR" (str IN CLOB, 
i IN NUMBER := 0, 
sep IN VARCHAR2 := ',' 
) 
RETURN VARCHAR2 
/************************************** 
* Function: 返回字符串被指定字符分割后的指定节点字符串。 
* Parameters: str: 待分割的字符串。 
i: 返回第几个节点。当i为0返回str中的所有字符，当i 超过可被分割的个数时返回空。 
sep: 分隔符，默认逗号，也可以指定字符或字符串。当指定的分隔符不存在于str中时返回sep中的字符。 
* Example: select splitstr('abc,def', 1) as str from dual; 得到 abc 
select splitstr('abc,def', 3) as str from dual; 得到 空 
**************************************/ 
IS 
t_i NUMBER; 
t_count NUMBER; 
t_str VARCHAR2 (4000); 
BEGIN 
IF i = 0 
THEN 
t_str := str; 
ELSIF INSTR (str, sep) = 0 
THEN 
t_str := sep; 
ELSE 
SELECT COUNT ( * ) 
INTO t_count 
FROM table (split (str, sep)); 
IF i <= t_count 
THEN 
SELECT str 
INTO t_str 
FROM (SELECT ROWNUM AS item, COLUMN_VALUE AS str 
FROM table (split (str, sep))) 
WHERE item = i; 
END IF; 
END IF; 
RETURN t_str; 
END; 

/
--------------------------------------------------------
--  DDL for Function URL_ENCODE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "URL_ENCODE" (urlEncode IN VARCHAR2)
  RETURN VARCHAR2 AS
BEGIN
  --utl_url.escape()该方法只能在函数中调用
  RETURN utl_url.escape(urlEncode, TRUE, 'utf-8');
END;

/
