create or replace PROCEDURE "P_DWM_SALE_RATE_BY_PROJ" (
    is_photograph_p in number:=0,
    proj_info   OUT              SYS_REFCURSOR,
    proj_SPID  out NVARCHAR2
    
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
BEGIN
--------创建临时表批次号
    SELECT
        get_uuid()
    INTO spid
    FROM
        dual;  
proj_SPID:=spid;
------项目基本信息
BEGIN
  IS_PHOTOGRAPH := is_photograph_p;

  P_DWM_SALE_RATE_PROJ(
    IS_PHOTOGRAPH => 0,
    PROJ_BASE_INFO => PROJ_BASE_INFO,
    PROJ_DATE_INFO => PROJ_DATE_INFO,
    PROJ_BASE_SPID => PROJ_BASE_SPID
  );
    END;
 ----- 
 INSERT INTO TMP_SALE_RATE_BY_PROJECT (ID---【1】主键
,PROJECT_ID---【2】项目ID
,PROJECT_NAME
,ORG_ID
,ORG_NAME
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
)select 
spid as ID---【1】主键
,project_id as PROJECT_ID---【2】项目ID
,project_name
,ORG_ID
,ORG_NAME
-----------------------------------K1、首开去化率开始--------------------
,"首开去化套数" as FO_SALE_OUT_COUNT---【3】首开去化套数
,"首开推售套数" as FO_SALE_COUNT---【4】首开推售套数
,case when 首开推售套数=0 then 0 else round("首开去化套数"/"首开推售套数",4)  end as FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,"首开去化面积" as FO_SALE_OUT_AREA---【6】首开去化面积
,"首开推售面积" as FO_SALE_AREA---【7】首开推售面积
,case when 首开推售面积=0 then 0 else round("首开去化面积"/"首开推售面积",4)  end as FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,"首开去化货值" as FO_SALE_OUT_MONEY---【9】首开去化货值
,"首开推售货值" as FO_SALE_MONEY---【10】首开推售货值
,case when 首开推售货值=0 then 0 else round("首开去化货值"/"首开推售货值",4)  end as FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,"首开推售货值"-"首开去化货值" as FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,case when 首开推售面积=0 then 0 else round("首开推售货值"/"首开推售面积",4)  end  as FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,case when 首开去化面积=0 then 0 else round("首开去化货值"/"首开去化面积",4)  end as FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
-----------------------------------K3、全案去化率 （单位：%）--------------------
,"全案已去化套数" as PO_SALE_OUT_COUNT---【15】全案去化套数
,"全案已领证套数" as PO_SALE_COUNT---【16】全案推售套数
,case when 全案已领证套数=0 then 0 else round("全案已去化套数"/"全案已领证套数",4)  end as PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,"全案已去化面积" as PO_SALE_OUT_AREA---【18】全案去化面积
,"全案已领证面积" as PO_SALE_AREA---【19】全案推售面积
,case when 全案已领证面积=0 then 0 else round("全案已去化面积"/"全案已领证面积",4)  end as PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,"全案已去化货值" as PO_SALE_OUT_MONEY---【21】全案去化货值
,"全案已领证货值" as PO_SALE_MONEY---【22】全案推售货值
,case when 全案已领证货值=0 then 0 else round("全案已去化货值"/"全案已领证货值",4)  end  as PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,"全案已领证货值"-"全案已去化货值" as PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,case when 全案已领证面积=0 then 0 else round("全案已领证货值"/"全案已领证面积",4)  end  as PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,case when 全案已去化面积=0 then 0 else round("全案已去化货值"/"全案已去化面积",4)  end   PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
-----------------------------------K4、现房去化率 （单位：%）--------------------
,"现房去化套数" as EH_SALE_OUT_COUNT---【27】现房去化套数
,"现房推售套数" as EH_SALE_COUNT---【28】现房推售套数
,case when 现房推售套数=0 then 0 else  round("现房去化套数"/"现房推售套数",4) end as EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,"现房去化面积" as EH_SALE_OUT_AREA---【30】现房去化面积
,"现房推售面积" as EH_SALE_AREA---【31】现房推售面积
,case when 现房推售面积=0 then 0 else  round("现房去化面积"/"现房推售面积",4) end as EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,"现房去化金额" as EH_SALE_OUT_MONEY---【33】现房去化货值
,"现房推售金额" as EH_SALE_MONEY---【34】现房推售货值
,case when 现房推售金额=0 then 0 else  round("现房去化金额"/"现房推售金额",4) end as EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,"现房推售金额"-"现房去化金额" as EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,case when 现房推售面积=0 then 0 else  round("现房推售金额"/"现房推售面积",4) end  as EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,case when 现房去化面积=0 then 0 else  round("现房去化金额"/"现房去化面积",4) end  as EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
-----------------------------------K5、顽固性库存去化率 （单位：%）--------------------
,"顽固去化套数" as SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,"顽固推售套数" as SI_SALE_COUNT---【40】顽固性库存推售套数
,case when 顽固推售套数=0 then 0 else  round("顽固去化套数"/"顽固推售套数",4) end as SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,"顽固去化面积" as SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,"顽固推售面积" as SI_SALE_AREA---【43】顽固性库存推售面积
,case when 顽固推售面积=0 then 0 else  round("顽固去化面积"/"顽固推售面积",4) end  as SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,"顽固去化金额" as SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,"顽固推售金额" as SI_SALE_MONEY---【46】顽固性库存推售货值
,case when 顽固推售金额=0 then 0 else  round("顽固去化金额"/"顽固推售金额",4) end as SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,"顽固推售金额"-"顽固去化金额" SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,case when 顽固推售面积=0 then 0 else  round("顽固推售金额"/"顽固推售面积",4) end as SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,case when 顽固推售面积=0 then 0 else  round("顽固去化金额"/"顽固推售面积",4) end as SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,sys_created as CREATED---【51】创建日期
from 
(select 
------首次开盘30天内的签约金额（首开去化货值）: 
---------->房间“合同成交总价”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约
sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then room.TRADE_TOTAL else 0 end ) as "首开去化货值"
------首次开盘已取证货值（首开推售货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when room.SALE_STATE='签约' and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.TRADE_TOTAL 
when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.BZ_TOTAL else 0 end )  as "首开推售货值"
------首次开盘30天内的签约面积（首开去化面积）:
---------->房间“最新建筑面积”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30  then room.NEW_BLD_AREA else 0 end ) as "首开去化面积"
------首次开盘的已取证面积（首开推售面积）:
---------->房间“最新建筑面积”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then room.NEW_BLD_AREA  else 0 end )  as "首开推售面积"
------首次开盘30天内的签约套数（首开去化套数）:
---------->房间“汇总”
---------->"项目开盘"的实际完成日期 <合同签约日期<"项目开盘"的实际完成日期 +30天
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' and proj.first_open_date<build.GET_PRE_SALE_PERMIT_DATE and build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date +30 then 1 else 0 end ) as "首开去化套数"
------首次开盘的已取证套数（首开推售套数）:
---------->房间“汇总”
---------->房间所属“楼栋预售许可证获取日期”<"项目开盘"的实际完成日期 
,sum(case when build.GET_PRE_SALE_PERMIT_DATE<proj.first_open_date then 1 else 0 end )  as "首开推售套数"

------全案------全案------全案------全案------全案------全案------全案 
------全案（已去化货值）: 
---------->房间“合同成交总价”
---------->房间“销售状态”=签约
,sum(case when room.SALE_STATE='签约' then room.TRADE_TOTAL else 0 end ) as "全案已去化货值"
,sum(case when room.SALE_STATE='签约' and build.GET_PRE_SALE_PERMIT_DATE is not null then room.TRADE_TOTAL  else 0 end ) as "已签约且已取证"
------全案（已领证货值）：
---------->房间“面价标准总价”:在计算“货值去化率”时，对已签约房间（有可能出现优惠打折），分子分母均按“签约金额”计算“货值去化率”。
,sum(case when room.SALE_STATE='签约'  then room.TRADE_TOTAL  
when build.GET_PRE_SALE_PERMIT_DATE is not null then room.BZ_TOTAL else 0 end )  as "全案已领证货值"
------全案（已去化面积）:
---------->房间“最新建筑面积”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约'  then room.NEW_BLD_AREA else 0 end ) as "全案已去化面积"
------全案（已领证面积）:
---------->房间“最新建筑面积”
,sum(case when build.GET_PRE_SALE_PERMIT_DATE is not null then room.NEW_BLD_AREA  else 0 end )  as "全案已领证面积"
------全案（已去化套数):
---------->房间“汇总”
---------->房间“销售状态”=签约  
,sum(case when room.SALE_STATE='签约' then 1 else 0 end ) as "全案已去化套数"
------全案（已领证套数):
---------->房间“汇总”
,sum(case when build.GET_PRE_SALE_PERMIT_DATE is not null then 1 else 0 end )  as "全案已领证套数"
------现房------现房------现房------现房------现房------现房------现房------现房------现房
----现房去化面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.NEW_BLD_AREA else 0 end) as "现房去化面积" ,
----现房推售面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then room.NEW_BLD_AREA else 0 end) as 现房推售面积,
----现房去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  room.TRADE_TOTAL else 0 end) as  现房去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----现房推售金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE <> '签约'   then room.BZ_TOTAL  when room.SALE_STATE = '签约' and proj.COMPLETION_RECORD_DATE is not null and  build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then room.TRADE_TOTAL else 0 end) as 现房推售金额,
----现房去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE then  1 else 0 end) as  现房去化套数,
----现房推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null and  (room.SALE_STATE <> '签约' or  (room.SALE_STATE = '签约' and build.GET_PRE_SALE_PERMIT_DATE>proj.COMPLETION_RECORD_DATE) )  then 1 else 0 end) as 现房推售套数
------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存------顽固性库存
----顽固推售面积
,sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  room.NEW_BLD_AREA else 0 end) as 顽固去化面积,
----顽固去化面积
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then room.NEW_BLD_AREA else 0 end) as 顽固推售面积,
----顽固去化金额
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  then  room.TRADE_TOTAL else 0 end) as  顽固去化金额,
--推售金额需要根据房间是否已经签约来判断取签约金额还是标准金额
----顽固推售金额
sum(case  when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') 
and (TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') then room.TRADE_TOTAL  --已经在今年签约的算签约金额
 when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  room.SALE_STATE <> '签约' then room.BZ_TOTAL  else 0 end) as 顽固推售金额,  --未签约的算校准总价
----顽固去化套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and room.SALE_STATE = '签约' and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and build.GET_PRE_SALE_PERMIT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate then  1 else 0 end) as  顽固去化套数,
----顽固推售套数
sum(case when  proj.COMPLETION_RECORD_DATE is not null  and  room.PRODUCT_NAME <> '住宅' and proj.COMPLETION_RECORD_DATE<to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and ((TRADE_CONTRACT_DATE>to_date(extract(year from sysdate)||'-01-01','yy-mm-dd') and  build.GET_PRE_SALE_PERMIT_DATE<sysdate  and room.SALE_STATE = '签约') or  room.SALE_STATE <> '签约') then 1 else 0 end) as 顽固推售套数
,proj.project_id,
proj.project_name,
proj.org_id,
proj.org_name,
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
proj.is_construction_began
from tmp_proj_base proj left join  MDM_ROOM room  
on proj.project_id=room.project_id  and  proj.id = PROJ_BASE_SPID
left join  mdm_build build on room.BUILDING_ID=build.id 
group by proj.project_id
    ,proj.project_name,
    proj.org_id,
    proj.org_name,
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
    proj.is_construction_began) result  order by "全案已去化货值" asc
;

-- 
IF is_photograph <> 0 THEN
----先将表数据移入，历史的项目数据，后插入新的数据
        
--    INSERT INTO  DWM_SALE_RATE_PROJECT_HISTORY
--    select * from  DWM_SALE_RATE_BY_PROJECT where REMARK=dwm_REMARK;
    DELETE FROM DWM_SALE_RATE_BY_PROJECT ;
    --where REMARK=dwm_REMARK;

        INSERT INTO DWM_SALE_RATE_BY_PROJECT (
ID---【1】主键
,PROJECT_ID---【2】项目ID
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
,REMARK---【52】备注信息
        )
            SELECT
PROJECT_ID      ID---【1】主键
,PROJECT_ID---【2】项目ID
,FO_SALE_OUT_COUNT---【3】首开去化套数
,FO_SALE_COUNT---【4】首开推售套数
,FO_SALE_RATE_BY_COUNT---【5】首开去化率(按套数)（3/4）
,FO_SALE_OUT_AREA---【6】首开去化面积
,FO_SALE_AREA---【7】首开推售面积
,FO_SALE_RATE_BY_AREA---【8】首开去化率(按面积)（6/7）
,FO_SALE_OUT_MONEY---【9】首开去化货值
,FO_SALE_MONEY---【10】首开推售货值
,FO_SALE_RATE_BY_MONEY---【11】首开去化率(按货值)（9/10）
,FO_SURPLUS_SALE_MONEY---【12】首开剩余货值(10-9)
,FO_SALE_AVERAGE_MONEY---【13】首开标准均价(10/7)
,FO_SALE_OUT_AVERAGE_MONEY---【14】首开签约均价(9/6)
,PO_SALE_OUT_COUNT---【15】全案去化套数
,PO_SALE_COUNT---【16】全案推售套数
,PO_SALE_RATE_BY_COUNT---【17】全案去化率(按套数)(15/16)
,PO_SALE_OUT_AREA---【18】全案去化面积
,PO_SALE_AREA---【19】全案推售面积
,PO_SALE_RATE_BY_AREA---【20】全案去化率(按面积)(18/19)
,PO_SALE_OUT_MONEY---【21】全案去化货值
,PO_SALE_MONEY---【22】全案推售货值
,PO_SALE_RATE_BY_MONEY---【23】全案去化率(按货值)(21/22)
,PO_SURPLUS_SALE_MONEY---【24】全案剩余货值(22-21)
,PO_SALE_AVERAGE_MONEY---【25】全案标准均价(22/19)
,PO_SALE_OUT_AVERAGE_MONEY---【26】全案签约均价(21/18)
,EH_SALE_OUT_COUNT---【27】现房去化套数
,EH_SALE_COUNT---【28】现房推售套数
,EH_SALE_RATE_BY_COUNT---【29】现房去化率(按套数)(27/28)
,EH_SALE_OUT_AREA---【30】现房去化面积
,EH_SALE_AREA---【31】现房推售面积
,EH_SALE_RATE_BY_AREA---【32】现房去化率(按面积)(30/31)
,EH_SALE_OUT_MONEY---【33】现房去化货值
,EH_SALE_MONEY---【34】现房推售货值
,EH_SALE_RATE_BY_MONEY---【35】现房去化率(按货值)(33/34)
,EH_SURPLUS_SALE_MONEY---【36】现房剩余货值(34-33)
,EH_SALE_AVERAGE_MONEY---【37】现房标准均价(34/31)
,EH_SALE_OUT_AVERAGE_MONEY---【38】现房签约均价(33/30)
,SI_SALE_OUT_COUNT---【39】顽固性库存去化套数
,SI_SALE_COUNT---【40】顽固性库存推售套数
,SI_SALE_RATE_BY_COUNT---【41】顽固性库存去化率(按套数)(39/40)
,SI_SALE_OUT_AREA---【42】顽固性库存去化面积
,SI_SALE_AREA---【43】顽固性库存推售面积
,SI_SALE_RATE_BY_AREA---【44】顽固性库存去化率(按面积)(42/43)
,SI_SALE_OUT_MONEY---【45】顽固性库存去化货值
,SI_SALE_MONEY---【46】顽固性库存推售货值
,SI_SALE_RATE_BY_MONEY---【47】顽固性库存去化率(按货值)(45/46)
,SI_SURPLUS_SALE_MONEY---【48】顽固性库存剩余货值(46-45)
,SI_SALE_AVERAGE_MONEY---【49】顽固性库存标准均价(46/43)
,SI_SALE_OUT_AVERAGE_MONEY---【50】顽固性库存签约均价(45/42)
,CREATED---【51】创建日期
,dwm_REMARK---【52】备注信息
            FROM
                TMP_SALE_RATE_BY_PROJECT where id=spid;
commit;
    END IF;
OPEN proj_info FOR 
select rownum,p.* from  TMP_SALE_RATE_BY_PROJECT p where id=spid;


END P_DWM_SALE_RATE_BY_PROJ;