CREATE OR REPLACE PROCEDURE "P_DWM_SALE_RATE_BY_ORG"  AS
		--公司颗粒度去化率；作用=》定时任务拍照
		--作者：陈丽
		--日期：2020-04-10

    PROJ_SPID NVARCHAR2(200);
    sys_created       DATE := SYSDATE;
    spid_tree              VARCHAR2(360); --使用临时表的批次号
    spid_sum              VARCHAR2(360); --使用临时表的批次号
    spid_result              VARCHAR2(360); --使用临时表的批次号
    dwm_remark        VARCHAR2(200) := '测试-chenl';
    p_X_AXIS_PERIOD  VARCHAR2(200):=to_char(sysdate, 'yyyy') ||'-'||to_char(sysdate, 'MM' );
BEGIN
delete tmp_sale_rate_by_org;
--------创建临时表批次号
    SELECT
        get_uuid(),get_uuid(),get_uuid()
    INTO spid_tree,spid_sum,spid_result
    FROM
        dual;  

------项目基本信息
BEGIN
  P_DWM_SALE_RATE_BY_PROJ(0,
    PROJ_SPID => PROJ_SPID
  );
END;

----组装树
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--【  2】项目ID
        org_name,--【  3】项目名称
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--【  4】首开去化套数
        fo_sale_count,--【  5】首开推售套数
        fo_sale_out_area,--【  7】首开去化面积
        fo_sale_area,--【  8】首开推售面积
        fo_sale_out_money,--【 10】首开去化货值
        fo_sale_money,--【 11】首开推售货值
        fo_surplus_sale_money,--【 13】首开剩余货值
        po_sale_out_count,--【 14】全案去化套数
        po_sale_count,--【 15】全案推售套数
        po_sale_out_area,--【 17】全案去化面积
        po_sale_area,--【 18】全案推售面积
        po_sale_out_money,--【 20】全案去化货值
        po_sale_money,--【 21】全案推售货值
        po_surplus_sale_money,--【 23】全案剩余货值
        eh_sale_out_count,--【 24】现房去化套数
        eh_sale_count,--【 25】现房推售套数
        eh_sale_out_area,--【 27】现房去化面积
        eh_sale_area,--【 28】现房推售面积
        eh_sale_out_money,--【 30】现房去化货值
        eh_sale_money,--【 31】现房推售货值
        eh_surplus_sale_money,--【 33】现房剩余货值
        si_sale_out_count,--【 34】顽固性库存去化套数
        si_sale_count,--【 35】顽固性库存推售套数
        si_sale_out_area,--【 37】顽固性库存去化面积
        si_sale_area,--【 38】顽固性库存推售面积
        si_sale_out_money,--【 40】顽固性库存去化货值
        si_sale_money,--【 41】顽固性库存推售货值
        si_surplus_sale_money--【 43】顽固性库存剩余货值
    )
        SELECT
            spid_tree,
            id AS org_id,
            org_name,
            parent_id,
            IS_COMPANY,
            LEVEL_RANK,
            0 AS fo_sale_out_count,--【  4】首开去化套数
            0 AS fo_sale_count,--【  5】首开推售套数
            0 AS fo_sale_out_area,--【  7】首开去化面积
            0 AS fo_sale_area,--【  8】首开推售面积
            0 AS fo_sale_out_money,--【 10】首开去化货值
            0 AS fo_sale_money,--【 11】首开推售货值
            0 AS fo_surplus_sale_money,--【 13】首开剩余货值
            0 AS po_sale_out_count,--【 14】全案去化套数
            0 AS po_sale_count,--【 15】全案推售套数
            0 AS po_sale_out_area,--【 17】全案去化面积
            0 AS po_sale_area,--【 18】全案推售面积
            0 AS po_sale_out_money,--【 20】全案去化货值
            0 AS po_sale_money,--【 21】全案推售货值
            0 AS po_surplus_sale_money,--【 23】全案剩余货值
            0 AS eh_sale_out_count,--【 24】现房去化套数
            0 AS eh_sale_count,--【 25】现房推售套数
            0 AS eh_sale_out_area,--【 27】现房去化面积
            0 AS eh_sale_area,--【 28】现房推售面积
            0 AS eh_sale_out_money,--【 30】现房去化货值
            0 AS eh_sale_money,--【 31】现房推售货值
            0 AS eh_surplus_sale_money,--【 33】现房剩余货值
            0 AS si_sale_out_count,--【 34】顽固性库存去化套数
            0 AS si_sale_count,--【 35】顽固性库存推售套数
            0 AS si_sale_out_area,--【 37】顽固性库存去化面积
            0 AS si_sale_area,--【 38】顽固性库存推售面积
            0 AS si_sale_out_money,--【 40】顽固性库存去化货值
            0 AS si_sale_money,--【 41】顽固性库存推售货值
            0 AS si_surplus_sale_money--【 43】顽固性库存剩余货值
        FROM
            sys_business_unit where IS_COMPANY=1
        UNION ALL
        SELECT
            spid_tree,
            project_id,
            org_name,
            org_id AS parent_id,
            0,
            null,
            fo_sale_out_count,--【  4】首开去化套数
            fo_sale_count,--【  5】首开推售套数
            fo_sale_out_area,--【  7】首开去化面积
            fo_sale_area,--【  8】首开推售面积
            fo_sale_out_money,--【 10】首开去化货值
            fo_sale_money,--【 11】首开推售货值
            fo_surplus_sale_money,--【 13】首开剩余货值
            po_sale_out_count,--【 14】全案去化套数
            po_sale_count,--【 15】全案推售套数
            po_sale_out_area,--【 17】全案去化面积
            po_sale_area,--【 18】全案推售面积
            po_sale_out_money,--【 20】全案去化货值
            po_sale_money,--【 21】全案推售货值
            po_surplus_sale_money,--【 23】全案剩余货值
            eh_sale_out_count,--【 24】现房去化套数
            eh_sale_count,--【 25】现房推售套数
            eh_sale_out_area,--【 27】现房去化面积
            eh_sale_area,--【 28】现房推售面积
            eh_sale_out_money,--【 30】现房去化货值
            eh_sale_money,--【 31】现房推售货值
            eh_surplus_sale_money,--【 33】现房剩余货值
            si_sale_out_count,--【 34】顽固性库存去化套数
            si_sale_count,--【 35】顽固性库存推售套数
            si_sale_out_area,--【 37】顽固性库存去化面积
            si_sale_area,--【 38】顽固性库存推售面积
            si_sale_out_money,--【 40】顽固性库存去化货值
            si_sale_money,--【 41】顽固性库存推售货值
            si_surplus_sale_money--【 43】顽固性库存剩余货值
        FROM
            tmp_sale_rate_by_project where id=proj_spid;           
----汇总          
INSERT INTO tmp_sale_rate_by_org (
        id,
        org_id,--【  2】项目ID
        org_name,--【  3】项目名称
        parent_id,
        IS_COMPANY,
        LEVEL_RANK,
        fo_sale_out_count,--【  4】首开去化套数
        fo_sale_count,--【  5】首开推售套数
        fo_sale_out_area,--【  7】首开去化面积
        fo_sale_area,--【  8】首开推售面积
        fo_sale_out_money,--【 10】首开去化货值
        fo_sale_money,--【 11】首开推售货值
        fo_surplus_sale_money,--【 13】首开剩余货值
        po_sale_out_count,--【 14】全案去化套数
        po_sale_count,--【 15】全案推售套数
        po_sale_out_area,--【 17】全案去化面积
        po_sale_area,--【 18】全案推售面积
        po_sale_out_money,--【 20】全案去化货值
        po_sale_money,--【 21】全案推售货值
        po_surplus_sale_money,--【 23】全案剩余货值
        eh_sale_out_count,--【 24】现房去化套数
        eh_sale_count,--【 25】现房推售套数
        eh_sale_out_area,--【 27】现房去化面积
        eh_sale_area,--【 28】现房推售面积
        eh_sale_out_money,--【 30】现房去化货值
        eh_sale_money,--【 31】现房推售货值
        eh_surplus_sale_money,--【 33】现房剩余货值
        si_sale_out_count,--【 34】顽固性库存去化套数
        si_sale_count,--【 35】顽固性库存推售套数
        si_sale_out_area,--【 37】顽固性库存去化面积
        si_sale_area,--【 38】顽固性库存推售面积
        si_sale_out_money,--【 40】顽固性库存去化货值
        si_sale_money,--【 41】顽固性库存推售货值
        si_surplus_sale_money--【 43】顽固性库存剩余货值
    )
 select spid_sum,org_id,org_name,parent_id,IS_COMPANY,LEVEL_RANK
,(select sum(FO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_COUNT
,(select sum(FO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_COUNT
,(select sum(FO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_AREA
,(select sum(FO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_AREA
,(select sum(FO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_OUT_MONEY
,(select sum(FO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SALE_MONEY
,(select sum(FO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) FO_SURPLUS_SALE_MONEY
,(select sum(PO_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_COUNT
,(select sum(PO_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_COUNT
,(select sum(PO_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_AREA
,(select sum(PO_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_AREA
,(select sum(PO_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_OUT_MONEY
,(select sum(PO_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SALE_MONEY
,(select sum(PO_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) PO_SURPLUS_SALE_MONEY
,(select sum(EH_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_COUNT
,(select sum(EH_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_COUNT
,(select sum(EH_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_AREA
,(select sum(EH_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_AREA
,(select sum(EH_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_OUT_MONEY
,(select sum(EH_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SALE_MONEY
,(select sum(EH_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) EH_SURPLUS_SALE_MONEY
,(select sum(SI_SALE_OUT_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_COUNT
,(select sum(SI_SALE_COUNT) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_COUNT
,(select sum(SI_SALE_OUT_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_AREA
,(select sum(SI_SALE_AREA) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_AREA
,(select sum(SI_SALE_OUT_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_OUT_MONEY
,(select sum(SI_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SALE_MONEY
,(select sum(SI_SURPLUS_SALE_MONEY) from tmp_sale_rate_by_org start with org_id=s.org_id connect by prior org_id=parent_id and org_id!=parent_id) SI_SURPLUS_SALE_MONEY
from tmp_sale_rate_by_org s where id=spid_tree
order by org_id  ; 
----计算率
INSERT INTO tmp_sale_rate_by_org (
ID,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
LEVEL_RANK,
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK" )
select spid_result,ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
LEVEL_RANK,
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
case when FO_SALE_COUNT=0 then 0 else  round(FO_SALE_OUT_COUNT/FO_SALE_COUNT,4) end as  FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
case when FO_SALE_AREA=0 then 0 else  round(FO_SALE_OUT_AREA/FO_SALE_AREA,4) end as  FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
case when FO_SALE_MONEY=0 then 0 else  round(FO_SALE_OUT_MONEY/FO_SALE_MONEY,4) end as FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SALE_MONEY-FO_SALE_OUT_MONEY as FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
case when FO_SALE_MONEY=0 then 0 else  round(PO_SALE_OUT_COUNT/PO_SALE_COUNT,4) end as PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_AREA/PO_SALE_AREA,4) end as PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
case when PO_SALE_AREA=0 then 0 else  round(PO_SALE_OUT_MONEY/PO_SALE_MONEY,4) end as PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SALE_MONEY-PO_SALE_OUT_MONEY as PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
case when EH_SALE_COUNT=0 then 0 else  round(EH_SALE_OUT_COUNT/EH_SALE_COUNT,4) end as EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
case when EH_SALE_AREA=0 then 0 else  round(EH_SALE_OUT_AREA/EH_SALE_AREA,4) end  as EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
case when EH_SALE_MONEY=0 then 0 else  round(EH_SALE_OUT_MONEY/EH_SALE_MONEY,4) end  as EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SALE_MONEY-EH_SALE_OUT_MONEY as EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
case when SI_SALE_COUNT=0 then 0 else  round(SI_SALE_OUT_COUNT/SI_SALE_COUNT,4) end  as SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
case when SI_SALE_AREA=0 then 0 else  round(SI_SALE_OUT_AREA/SI_SALE_AREA,4) end  as SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
case when SI_SALE_MONEY=0 then 0 else  round(SI_SALE_OUT_MONEY/SI_SALE_MONEY,4) end  as SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SALE_MONEY-SI_SALE_OUT_MONEY as SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
p_X_AXIS_PERIOD,--【44】时间（横坐标）
sys_created,--【45】创建时间
dwm_remark--【46】备注信息
from tmp_sale_rate_by_org where IS_COMPANY=1 and id=spid_sum and LEVEL_RANK<=2
;
----插入到目标表

   DELETE FROM dwm_sale_rate_by_org where  X_AXIS_PERIOD=p_X_AXIS_PERIOD;
   --and REMARK=dwm_REMARK;

   INSERT INTO dwm_sale_rate_by_org (
ID,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK" )
select get_uuid,--【1】主键
ORG_ID,--【2】项目ID
ORG_NAME,--【3】项目名称
FO_SALE_OUT_COUNT,--【4】首开去化套数
FO_SALE_COUNT,--【5】首开推售套数
FO_SALE_RATE_BY_COUNT,--【6】首开去化率(按套数)
FO_SALE_OUT_AREA,--【7】首开去化面积
FO_SALE_AREA,--【8】首开推售面积
FO_SALE_RATE_BY_AREA,--【9】首开去化率(按面积)
FO_SALE_OUT_MONEY,--【10】首开去化货值
FO_SALE_MONEY,--【11】首开推售货值
FO_SALE_RATE_BY_MONEY,--【12】首开去化率(按货值)
FO_SURPLUS_SALE_MONEY,--【13】首开剩余货值
PO_SALE_OUT_COUNT,--【14】全案去化套数
PO_SALE_COUNT,--【15】全案推售套数
PO_SALE_RATE_BY_COUNT,--【16】全案去化率(按套数)
PO_SALE_OUT_AREA,--【17】全案去化面积
PO_SALE_AREA,--【18】全案推售面积
PO_SALE_RATE_BY_AREA,--【19】全案去化率(按面积)
PO_SALE_OUT_MONEY,--【20】全案去化货值
PO_SALE_MONEY,--【21】全案推售货值
PO_SALE_RATE_BY_MONEY,--【22】全案去化率(按货值)
PO_SURPLUS_SALE_MONEY,--【23】全案剩余货值
EH_SALE_OUT_COUNT,--【24】现房去化套数
EH_SALE_COUNT,--【25】现房推售套数
EH_SALE_RATE_BY_COUNT,--【26】现房去化率(按套数)
EH_SALE_OUT_AREA,--【27】现房去化面积
EH_SALE_AREA,--【28】现房推售面积
EH_SALE_RATE_BY_AREA,--【29】现房去化率(按面积)
EH_SALE_OUT_MONEY,--【30】现房去化货值
EH_SALE_MONEY,--【31】现房推售货值
EH_SALE_RATE_BY_MONEY,--【32】现房去化率(按货值)
EH_SURPLUS_SALE_MONEY,--【33】现房剩余货值
SI_SALE_OUT_COUNT,--【34】顽固性库存去化套数
SI_SALE_COUNT,--【35】顽固性库存推售套数
SI_SALE_RATE_BY_COUNT,--【36】顽固性库存去化率(按套数)
SI_SALE_OUT_AREA,--【37】顽固性库存去化面积
SI_SALE_AREA,--【38】顽固性库存推售面积
SI_SALE_RATE_BY_AREA,--【39】顽固性库存去化率(按面积)
SI_SALE_OUT_MONEY,--【40】顽固性库存去化货值
SI_SALE_MONEY,--【41】顽固性库存推售货值
SI_SALE_RATE_BY_MONEY,--【42】顽固性库存去化率(按货值)
SI_SURPLUS_SALE_MONEY,--【43】顽固性库存剩余货值
X_AXIS_PERIOD,--【44】时间（横坐标）
CREATED,--【45】创建时间
"REMARK"
from tmp_sale_rate_by_org where id=spid_result;
commit;

    
END p_dwm_sale_rate_by_org;