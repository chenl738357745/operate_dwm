create or replace PROCEDURE "P_DWM_SALE_RATE_BY_GRANULARITY" (
    is_photograph_p in number:=0,
    proj_info   OUT  SYS_REFCURSOR,
    spid_tree_info   OUT  SYS_REFCURSOR,
    SPID_AREA_STAGE_INFO   OUT  SYS_REFCURSOR,
    spid_sum_info   OUT  SYS_REFCURSOR,
    p_room  out  SYS_REFCURSOR
) AS
		--去化率试算
		--作者：陈丽
		--日期：2020-04-10
  PROJ_BASE_INFO SYS_REFCURSOR;
  PROJ_DATE_INFO SYS_REFCURSOR;
  PROJ_BASE_SPID VARCHAR2(2000);
  IS_PHOTOGRAPH  number;
  sys_created date:=sysdate;
  spid VARCHAR2(360); --使用临时表的批次号
  dwm_REMARK VARCHAR2(200):='测试-chenl';
  spid_tree              VARCHAR2(360); --使用临时表的批次号
  spid_area_stage              VARCHAR2(360); --使用临时表的批次号
  spid_sum     VARCHAR2(360); --使用临时表的批次号
  spid_result              VARCHAR2(360); --使用临时表的批次号
  
  ----------------------
  v_sql clob;
  v_sql_start VARCHAR2(2000):= ' case ';
  v_sql_content clob:= '';
  v_sql_end VARCHAR2(2000):= '  else ''主数据面积段外'' end  ';
BEGIN

---------------------------
--------------------------------------------------------创建临时表批次号
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
    SELECT
        get_uuid(),get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_area_stage,spid_sum,spid_result
    FROM
        dual;  
---------------------------------------------计算业态面积段1.拼接查询语句
 FOR item IN (
   select 
    ' when '||l.lower_limit_value||l.upper_limit_type||'room.NEW_BLD_AREA and room.NEW_BLD_AREA '||l.lower_limit_type||l.upper_limit_value
    ||' and (case when room.PRODUCT_NAME<>''住宅'' then ''商铺及其他'' else ''住宅'' end)='''||p.attribute_name||''' then ''' ||l.attribute_name||''' ' as aa,
    l.upper_limit_type,
    l.lower_limit_type,
    l.upper_limit_value,
    p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null
        ) LOOP 
    ---拼接字符串
         v_sql_content := v_sql_content||item.aa;
        END LOOP;
    --规则内容大于0才拼规则语句
        IF length(v_sql_content) > 0 THEN
            v_sql := v_sql_start
                     || v_sql_content
                     || v_sql_end;
        ELSE
            v_sql := '''''';
        END IF;
        
       v_sql:= 'INSERT INTO TMP_ROOM(id,room_ID,ROOM_NAME,PRODUCT_NAME,AREA_LEVEL) select '''||spid||''',id,room_name,room.product_name,'
       ||v_sql|| ' as NODE_WARNING from mdm_room room';
         dbms_output.put_line(v_sql);
       execute immediate v_sql;
        
OPEN p_room FOR select * from TMP_ROOM;
------------------------------------------------------------项目基本信息
BEGIN
  IS_PHOTOGRAPH := is_photograph_p;

  P_DWM_SALE_RATE_PROJ(
    IS_PHOTOGRAPH => 0,
    PROJ_BASE_INFO => PROJ_BASE_INFO,
    PROJ_DATE_INFO => PROJ_DATE_INFO,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;   
------------------------------------------------------------业态面积段树拼接 spid_tree
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
,GRANULARITY_ID--颗粒度id
,PROJECT_ID---【2】项目ID
,PROJECT_NAME--项目名称
,PARENT_ID---父级id
,DATA_GRANULARITY--颗粒度名称
)
-----业态
select spid_tree
,proj.PROJECT_ID||b."业态" as GRANULARITY_ID
,proj.PROJECT_NAME
,proj.PROJECT_ID as projectId
,null as parentId 
,b."业态" as text   
 from (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
(select 
   l.attribute_name as "业态"  from mdm_attribute_area_level l where parent_id is null) b
   union all
-----面积段
select spid_tree
,proj.PROJECT_ID||ptype||a.areaStage as GRANULARITY_ID
,proj.PROJECT_NAME
,proj.PROJECT_ID as projectId
,proj.PROJECT_ID||ptype as parentId 
,a.areaStage as text
from  (select * from tmp_proj_base where id = PROJ_BASE_SPID) proj cross join
( select 
    l.attribute_name as areaStage,p.attribute_name as ptype from mdm_attribute_area_level l
    left join mdm_attribute_area_level p on l.parent_id=p.id 
    where p.id is not null) a;
    
 OPEN spid_tree_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_tree ;
------------------------------------------------------------计算面积段指标 spid_area_stage
 INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
,GRANULARITY_ID--颗粒度id
,PROJECT_NAME
,PROJECT_ID---【2】项目ID
,DATA_GRANULARITY 
,PARENT_ID  

,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值

,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值

,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值

,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值

)
select spid_area_stage as id
,tree.GRANULARITY_ID--颗粒度id
,tree.PROJECT_ID---【2】项目ID
,tree.PROJECT_NAME--项目名称
,tree.DATA_GRANULARITY--颗粒度名称
,tree.PARENT_ID---父级id

,area_stage.首开去化套数
,area_stage.首开推售套数
,area_stage.首开去化面积
,area_stage.首开推售面积
,area_stage.首开去化货值
,area_stage.首开推售货值

,area_stage.全案去化套数
,area_stage.全案领证套数
,area_stage.全案去化面积
,area_stage.全案领证面积
,area_stage.全案去化货值
,area_stage.全案领证货值

,area_stage.现房去化套数
,area_stage.现房推售套数
,area_stage.现房去化面积
,area_stage.现房推售面积
,area_stage.现房去化货值
,area_stage.现房推售货值

,area_stage.顽固去化套数
,area_stage.顽固推售套数
,area_stage.顽固去化面积
,area_stage.顽固推售面积
,area_stage.顽固去化货值
,area_stage.顽固推售货值
  from 
(select * from TMP_SALE_RATE_BY_GRANULARITY where id =spid_tree) tree
left join 
(select 
proj.project_id||t_room.PRODUCT_NAME||t_room.AREA_LEVEL as GRANULARITY_ID--颗粒度id
,proj.project_id
,proj.project_name
,proj.project_id||t_room.PRODUCT_NAME as PARENT_ID
,t_room.AREA_LEVEL
------首次开盘30天内的签约套数（首开去化套数）:
---------->房间“汇总”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end )
as "首开去化套数"
------首次开盘的已取证套数（首开推售套数）:
---------->房间“汇总”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then 1 else 0 end )
as "首开推售套数"
------首次开盘30天内的签约面积（首开去化面积）:
---------->房间“最新建筑面积”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end )
as "首开去化面积"
------首次开盘的已取证面积（首开推售面积）:
---------->房间“最新建筑面积”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end ) 
as "首开推售面积"
------首次开盘30天内的签约金额（首开去化货值）: 
---------->房间“合同成交总价”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end )
as "首开去化货值"
------首次开盘已取证货值（首开推售货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.SALE_STATE='签约' and room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when room.PRE_SELL_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )
as "首开推售货值"

------全案------全案------全案------全案------全案------全案------全案 
------全案（已去化套数):
---------->房间“汇总”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' then 1 else 0 end )
as "全案去化套数"
------全案（已领证套数):
---------->房间“汇总”
,sum(case when room.PRE_SELL_PERMIT_DATE is not null then 1 else 0 end )
as "全案领证套数"
------全案（已去化面积）:
---------->房间“最新建筑面积”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约'  then room.NEW_BLD_AREA else 0 end )
as "全案去化面积"
------全案（已领证面积）:
---------->房间“最新建筑面积”
,sum(case when room.PRE_SELL_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end ) 
as "全案领证面积"
------全案（已去化货值）: 
---------->房间“合同成交总价”
---------->房间“销售状态”=签约
,sum(case when room.SALE_STATE='签约' then room.TRADE_TOTAL else 0 end )
as "全案去化货值"
------全案（已领证货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
,sum(case when room.SALE_STATE='签约'  then room.TRADE_TOTAL  
when room.PRE_SELL_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )
as "全案领证货值"
------现房------现房------现房------现房------现房------现房------现房------现房------现房
----现房去化套数
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end)
as  现房去化套数
----现房推售套数
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or  (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) 
as 现房推售套数
----现房去化面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end)
as "现房去化面积" 
----现房推售面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end)
as 现房推售面积
----现房去化金额
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end)
as  现房去化货值
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----现房推售金额
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> '签约'   then room.BZ_TOTAL  when room.SALE_STATE = '签约' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end)
as 现房推售货值
------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存
----顽固去化套数
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end)
as  顽固去化套数
----顽固推售套数
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then 1 else 0 end) 
as 顽固推售套数
----顽固推售面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) 
as 顽固去化面积
----顽固去化面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then room.NEW_BLD_AREA else 0 end)
as 顽固推售面积
----顽固去化金额
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) 
as  顽固去化货值
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----顽固推售金额
,sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') then room.TRADE_TOTAL  --已经在今年签约的算签约金额
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> '签约' then room.BZ_TOTAL  else 0 end) 
 as 顽固推售货值  --未签约的算校准总价

from  MDM_ROOM room
left join  tmp_proj_base proj on room.project_id=proj.project_id and  proj.id = PROJ_BASE_SPID
left join TMP_ROOM t_room on  room.id=t_room.room_id
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
-------------------- 业态面积段特有 start
    ,t_room.AREA_LEVEL
    ,t_room.PRODUCT_NAME
----------------------业态面积段特有 end
    ,proj.project_name,
    proj.first_open_date,
    proj.obtain_date,
    proj.COMPLETION_RECORD_DATE,
    proj.take_land_date,
    proj.plan_first_open_date,
    proj.first_open_duration_by_tl,
    proj.first_open_duration_by_plan,
    proj.new_plan_first_open_date,
    proj.exhibition_area_open_date,
    proj.plan_approval_date,
    proj.is_operate,
    proj.is_construction_began) area_stage 
    on tree.GRANULARITY_ID=area_stage.PARENT_ID  
;
OPEN spid_area_stage_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_area_stage ;
------------------------------------------------------------计算面积段指标spid_sum
--INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
--,GRANULARITY_ID--颗粒度id
--,PROJECT_ID---【2】项目ID
--,PROJECT_NAME
--,PARENT_ID  
--,DATA_GRANULARITY 
--
--,FO_SALE_OUT_COUNT---【3】首开去化套数
--,FO_SALE_COUNT---【4】首开推售套数
--,FO_SALE_OUT_AREA---【6】首开去化面积
--,FO_SALE_AREA---【7】首开推售面积
--,FO_SALE_OUT_MONEY---【9】首开去化货值
--,FO_SALE_MONEY---【10】首开推售货值
--
--,PO_SALE_OUT_COUNT---【15】全案去化套数
--,PO_SALE_COUNT---【16】全案推售套数
--,PO_SALE_OUT_AREA---【18】全案去化面积
--,PO_SALE_AREA---【19】全案推售面积
--,PO_SALE_OUT_MONEY---【21】全案去化货值
--,PO_SALE_MONEY---【22】全案推售货值
--
--,EH_SALE_OUT_COUNT---【27】现房去化套数
--,EH_SALE_COUNT---【28】现房推售套数
--,EH_SALE_OUT_AREA---【30】现房去化面积
--,EH_SALE_AREA---【31】现房推售面积
--,EH_SALE_OUT_MONEY---【33】现房去化货值
--,EH_SALE_MONEY---【34】现房推售货值
--
--,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
--,SI_SALE_COUNT---【40】顽固性库存推售套数
--,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
--,SI_SALE_AREA---【43】顽固性库存推售面积
--,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
--,SI_SALE_MONEY---【46】顽固性库存推售货值
--)
-- select spid_sum,GRANULARITY_ID--颗粒度id
--,PROJECT_ID---【2】项目ID
--,PROJECT_NAME--项目名称
--,PARENT_ID---父级id
--,DATA_GRANULARITY--颗粒度名称
--,(select sum(FO_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【3】首开去化套数
--,(select sum(FO_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【4】首开推售套数
--,(select sum(FO_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【6】首开去化面积
--,(select sum(FO_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【7】首开推售面积
--,(select sum(FO_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【9】首开去化货值
--,(select sum(FO_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【10】首开推售货值
--
--,(select sum(PO_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【15】全案去化套数
--,(select sum(PO_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【16】全案推售套数
--,(select sum(PO_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【18】全案去化面积
--,(select sum(PO_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【19】全案推售面积
--,(select sum(PO_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【21】全案去化货值
--,(select sum(PO_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【22】全案推售货值
--
--,(select sum(EH_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【27】现房去化套数
--,(select sum(EH_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【28】现房推售套数
--,(select sum(EH_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【30】现房去化面积
--,(select sum(EH_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【31】现房推售面积
--,(select sum(EH_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【33】现房去化货值
--,(select sum(EH_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【34】现房推售货值
--
--,(select sum(SI_SALE_OUT_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【39】顽固性库存去化套数
--,(select sum(SI_SALE_COUNT) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【40】顽固性库存推售套数
--,(select sum(SI_SALE_OUT_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【42】顽固性库存去化面积
--,(select sum(SI_SALE_AREA) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【43】顽固性库存推售面积
--,(select sum(SI_SALE_OUT_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【45】顽固性库存去化货值
--,(select sum(SI_SALE_MONEY) from TMP_SALE_RATE_BY_GRANULARITY start with GRANULARITY_ID=s.GRANULARITY_ID connect by prior GRANULARITY_ID=parent_id and GRANULARITY_ID!=parent_id) ---【46】顽固性库存推售货值
--
--from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_area_stage order by GRANULARITY_ID  ; 
OPEN spid_sum_info FOR select rownum,s.* from TMP_SALE_RATE_BY_GRANULARITY s where id=spid_sum ;
------------------------------------------------------------计算面积段指标spid_result
--INSERT INTO TMP_SALE_RATE_BY_GRANULARITY (ID---【1】主键
--,GRANULARITY_ID--颗粒度id
--,PROJECT_ID---【2】项目ID
--,PROJECT_NAME--项目名称
--,PARENT_ID---父级id
--,DATA_GRANULARITY--颗粒度名称
--
--,FO_SALE_OUT_COUNT---【3】首开去化套数
--,FO_SALE_COUNT---【4】首开推售套数
--,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
--,FO_SALE_OUT_AREA---【6】首开去化面积
--,FO_SALE_AREA---【7】首开推售面积
--,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
--,FO_SALE_OUT_MONEY---【9】首开去化货值
--,FO_SALE_MONEY---【10】首开推售货值
--,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
--,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
--,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
--,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
--,PO_SALE_OUT_COUNT---【15】全案去化套数
--,PO_SALE_COUNT---【16】全案推售套数
--,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
--,PO_SALE_OUT_AREA---【18】全案去化面积
--,PO_SALE_AREA---【19】全案推售面积
--,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
--,PO_SALE_OUT_MONEY---【21】全案去化货值
--,PO_SALE_MONEY---【22】全案推售货值
--,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
--,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
--,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
--,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
--,EH_SALE_OUT_COUNT---【27】现房去化套数
--,EH_SALE_COUNT---【28】现房推售套数
--,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
--,EH_SALE_OUT_AREA---【30】现房去化面积
--,EH_SALE_AREA---【31】现房推售面积
--,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
--,EH_SALE_OUT_MONEY---【33】现房去化货值
--,EH_SALE_MONEY---【34】现房推售货值
--,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
--,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
--,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
--,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
--,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
--,SI_SALE_COUNT---【40】顽固性库存推售套数
--,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
--,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
--,SI_SALE_AREA---【43】顽固性库存推售面积
--,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
--,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
--,SI_SALE_MONEY---【46】顽固性库存推售货值
--,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
--,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
--,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
--,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
--)
OPEN proj_info FOR
select  rownum,spid_result as id
,GRANULARITY_ID--颗粒度id
,PROJECT_ID---【2】项目ID
,PROJECT_NAME--项目名称
,PARENT_ID---父级id
,DATA_GRANULARITY--颗粒度名称

FO_SALE_OUT_COUNT,--【3】首开去化套数
FO_SALE_COUNT,--【4】首开推售套数 
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end,--【5】首开去化率(按套数)（3/4）
FO_SALE_OUT_AREA,--【6】首开去化面积
FO_SALE_AREA,--【7】首开推售面积
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end,--【8】首开去化率(按面积)（6/7）
FO_SALE_OUT_MONEY,--【9】首开去化货值
FO_SALE_MONEY,--【10】首开推售货值
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end,--【11】首开去化率(按货值)（9/10）
FO_SURPLUS_SALE_MONEY,--【12】首开剩余货值(10-9)
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_MONEY/FO_SALE_AREA,4) end,--【13】首开标准均价(10/7)
case when FO_SALE_OUT_AREA=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_OUT_AREA,4) end,--【14】首开签约均价(9/6)
PO_SALE_OUT_COUNT,--【15】全案去化套数
PO_SALE_COUNT,--【16】全案推售套数
case when PO_SALE_COUNT=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end,--【17】全案去化率(按套数)(15/16)
PO_SALE_OUT_AREA,--【18】全案去化面积
PO_SALE_AREA,--【19】全案推售面积
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end,--【20】全案去化率(按面积)(18/19)
PO_SALE_OUT_MONEY,--【21】全案去化货值
PO_SALE_MONEY,--【22】全案推售货值
case when PO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end,--【23】全案去化率(按货值)(21/22)
PO_SURPLUS_SALE_MONEY,--【24】全案剩余货值(22-21)
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_MONEY/PO_SALE_AREA,4) end,--【25】全案标准均价(22/19)
case when PO_SALE_OUT_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_OUT_AREA,4) end,--【26】全案签约均价(21/18)
EH_SALE_OUT_COUNT,--【27】现房去化套数
EH_SALE_COUNT,--【28】现房推售套数
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end,--【29】现房去化率(按套数)(27/28)
EH_SALE_OUT_AREA,--【30】现房去化面积
EH_SALE_AREA,--【31】现房推售面积
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end,--【32】现房去化率(按面积)(30/31)
EH_SALE_OUT_MONEY,--【33】现房去化货值
EH_SALE_MONEY,--【34】现房推售货值
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end,--【35】现房去化率(按货值)(33/34)
EH_SURPLUS_SALE_MONEY,--【36】现房剩余货值(34-33)
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_MONEY/EH_SALE_AREA,4) end,--【37】现房标准均价(34/31)
case when EH_SALE_OUT_AREA=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_OUT_AREA,4) end,--【38】现房签约均价(33/30)
SI_SALE_OUT_COUNT,--【39】顽固性库存去化套数
SI_SALE_COUNT,--【40】顽固性库存推售套数
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end,--【41】顽固性库存去化率(按套数)(39/40)
SI_SALE_OUT_AREA,--【42】顽固性库存去化面积
SI_SALE_AREA,--【43】顽固性库存推售面积
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end,--【44】顽固性库存去化率(按面积)(42/43)
SI_SALE_OUT_MONEY,--【45】顽固性库存去化货值
SI_SALE_MONEY,--【46】顽固性库存推售货值
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end,--【47】顽固性库存去化率(按货值)(45/46)
SI_SURPLUS_SALE_MONEY,--【48】顽固性库存剩余货值(46-45)
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_MONEY/SI_SALE_AREA,4) end,--【49】顽固性库存标准均价(46/43)
case when SI_SALE_OUT_AREA=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_OUT_AREA,4) end--【50】顽固性库存签约均价(45/42)
from  TMP_SALE_RATE_BY_GRANULARITY 
where id=spid_sum ;



END P_DWM_SALE_RATE_BY_GRANULARITY;