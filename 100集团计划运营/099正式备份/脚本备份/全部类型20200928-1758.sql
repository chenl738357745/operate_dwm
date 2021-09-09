--------------------------------------------------------
--  文件已创建 - 星期一-九月-28-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type BLD_ID_LIST
--------------------------------------------------------

  CREATE OR REPLACE TYPE "BLD_ID_LIST" AS TABLE OF VARCHAR(36)


/
--------------------------------------------------------
--  DDL for Type BLDID_LIST
--------------------------------------------------------

  CREATE OR REPLACE TYPE "BLDID_LIST" AS OBJECT (BLDID VARCHAR (36))


/
--------------------------------------------------------
--  DDL for Type STR_SPLIT
--------------------------------------------------------

  CREATE OR REPLACE TYPE "STR_SPLIT" IS TABLE OF VARCHAR2 (4000);
CREATE OR REPLACE FUNCTION splitstr(p_string IN VARCHAR2, p_delimiter IN VARCHAR2)
    RETURN str_split 
    PIPELINED
AS
    v_length   NUMBER := LENGTH(p_string);
    v_start    NUMBER := 1;
    v_index    NUMBER;
BEGIN
    WHILE(v_start <= v_length)
    LOOP
        v_index := INSTR(p_string, p_delimiter, v_start);

        IF v_index = 0
        THEN
            PIPE ROW(SUBSTR(p_string, v_start));
            v_start := v_length + 1;
        ELSE
            PIPE ROW(SUBSTR(p_string, v_start, v_index - v_start));
            v_start := v_index + 1;
        END IF;
    END LOOP;

    RETURN;
END splitstr;


/
--------------------------------------------------------
--  DDL for Type TABLETYPE
--------------------------------------------------------

  CREATE OR REPLACE TYPE "TABLETYPE" as table of VARCHAR2(32676);

/
--------------------------------------------------------
--  DDL for Type TY_ROW_STR_SPLIT
--------------------------------------------------------

  CREATE OR REPLACE TYPE "TY_ROW_STR_SPLIT" as object (strValue VARCHAR2 (4000));


/
--------------------------------------------------------
--  DDL for Type TYPE_SPLIT
--------------------------------------------------------

  CREATE OR REPLACE TYPE "TYPE_SPLIT" IS TABLE OF VARCHAR2 (4000)


/
--------------------------------------------------------
--  DDL for Type VARCHAR2_LIST
--------------------------------------------------------

  CREATE OR REPLACE TYPE "VARCHAR2_LIST" is varray (100) of VARCHAR2(100)

/
