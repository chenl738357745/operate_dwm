create or replace PROCEDURE "P_OPM_INIT" (planyear IN number
--计划年
) AS-- 按年初始化所有的数据
-- 注意：初始化结构顺序及公式、具体值由区域级提交后汇总
--作者： chenl--日期： 2021/08/24 FIELDSINFO SYS_REFCURSOR;
plan_year   VARCHAR2(500):=(case when planyear is null or planyear='' then  to_char(sysdate, 'yyyy' ) else planyear end); 
BEGIN 
-----------------------------------集团级
  BEGIN
  P_OPM_INIT_GROUP(
    PLANYEAR => PLANYEAR
  );
--rollback; 
END;
-----------------------------------区域级
  begin
  P_OPM_INIT_REGION(
    PLANYEAR => plan_year,
    REGIONCOMPANYID => null
  );
  end;
-----------------------------------项目级
 BEGIN
  P_OPM_INIT_PROJ(
    PLANYEAR => PLANYEAR,
    REGIONORGID => null
  );
--rollback; 
END;
-----------------------------------
END P_OPM_INIT;

