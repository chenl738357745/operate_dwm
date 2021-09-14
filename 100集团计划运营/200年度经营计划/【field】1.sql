delete opm_excel_filed where sheet_id='groupsheet1' and EXCEL_TYPE='总表';
commit;
INSERT INTO opm_excel_filed (
    sheet_id,
    field_level,
    is_hide,
    is_end,
    header_bgcolor,
    header_fontcolor,
    field_id,
    field_lable,
    field_field,
    field_width,
    field_align,
    field_dataformat,
    field_order,
    field_parentid,
    field_textalign,
    is_columnmerge_column,EXCEL_TYPE
)
SELECT 'groupsheet1' "sheetID",resultdata.*,'总表' from (
---必须层
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet1ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '层级' "fieldId",'层级' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第一层
SELECT  1 "fieldLevel",1 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet1序号id' "fieldId",'序号' "lable",'groupsheet1序号' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'城市/项目名称' "fieldId",'城市/项目名称' "lable",'object_name' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'railway_bool' "fieldId",'是否并表（中国铁建）' "lable",'railway_bool' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'estate_bool' "fieldId",'是否并表（地产集团）' "lable",'estate_bool' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'estate_ratio' "fieldId",'地产集团所占股权比例' "lable",'estate_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",6 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'railway_ratio' "fieldId",'中国铁建所占股权比例' "lable",'railway_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",7 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'build_land_area' "fieldId",'建设用地面积（过规版方案指标）' "lable",'build_land_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",8 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'surface_total_area' "fieldId",'总建筑面积' "lable",'surface_total_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'其中' "fieldId",'其中' "lable",'其中' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'construction_stage' "fieldId",'建设阶段（竣工/在建／未开工）' "lable",'construction_stage' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",10 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_investment' "fieldId",'总投资' "lable",'total_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",11 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_saleable_area' "fieldId",'总可售面积' "lable",'total_saleable_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",12 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_value' "fieldId",'总货值' "lable",'total_value' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",13 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'工程数据' "fieldId",'工程数据' "lable",'工程数据' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'供销存计划' "fieldId",'供销存计划' "lable",'供销存计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售回款' "fieldId",'销售回款' "lable",'销售回款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'投资、资金计划' "fieldId",'投资、资金计划' "lable",'投资、资金计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'财务数据' "fieldId",'财务数据' "lable",'财务数据' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第二层
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'above_ground_area' "fieldId",'地上建筑面积（万平方米）' "lable",'above_ground_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",14 "fieldOrder",'其中' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",14 "fieldOrder",'工程数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年当年' "fieldId",'planyear||''年当年' "lable",'2021年当年' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'工程数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2021年开累' "fieldId",'截至''||to_char(planyear)||''开累' "lable",'截止2021年开累' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'工程数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022年当年' "fieldId",'planyear+1||''年当年' "lable",'2022年当年' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'工程数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累1' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'工程数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累2' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供销存计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年预计完成' "fieldId",'planyear||''年预计完成' "lable",'2021年预计完成' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供销存计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2021年开累1' "fieldId",'截至''||to_char(planyear)||''开累' "lable",'截止2021年开累1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供销存计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022年预计完成' "fieldId",'planyear+1||''年预计完成' "lable",'2022年预计完成' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供销存计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2022年开累' "fieldId",'截至''||to_char(planyear+1)||''开累' "lable",'截止2022年开累' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供销存计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累3' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售回款' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年当年1' "fieldId",'planyear||''年当年' "lable",'2021年当年1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售回款' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2021年开累2' "fieldId",'截至''||to_char(planyear)||''开累' "lable",'截止2021年开累2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售回款' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022年当年1' "fieldId",'planyear+1||''年当年' "lable",'2022年当年1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售回款' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2022年开累1' "fieldId",'截至''||to_char(planyear+1)||''开累' "lable",'截止2022年开累1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售回款' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累4' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'投资、资金计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年当年2' "fieldId",'planyear||''年当年' "lable",'2021年当年2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'投资、资金计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2021年开累3' "fieldId",'截至''||to_char(planyear)||''开累' "lable",'截止2021年开累3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'投资、资金计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022年当年2' "fieldId",'planyear+1||''年当年' "lable",'2022年当年2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'投资、资金计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2022年开累2' "fieldId",'截至''||to_char(planyear+1)||''开累' "lable",'截止2022年开累2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'投资、资金计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2020年开累5' "fieldId",'截至''||to_char(planyear-1)||''开累' "lable",'截止2020年开累5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年当年3' "fieldId",'planyear||''年当年' "lable",'2021年当年3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2021年开累4' "fieldId",'截至''||to_char(planyear)||''开累' "lable",'截止2021年开累4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022年当年3' "fieldId",'planyear+1||''年当年' "lable",'2022年当年3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截止2022年开累3' "fieldId",'截至''||to_char(planyear+1)||''开累' "lable",'截止2022年开累3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '自有资金回正时间' "fieldId",'自有资金回正时间' "lable",'自有资金回正时间' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",126 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '全投资回正时间' "fieldId",'全投资回正时间' "lable",'全投资回正时间' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",127 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '未来两年产值释放计划' "fieldId",'未来两年产值释放计划' "lable",'未来两年产值释放计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'财务数据' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第三层
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'last_started_area' "fieldId",'开工面积' "lable",'last_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",17 "fieldOrder",'截止2020年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'last_completed_area' "fieldId",'竣工面积' "lable",'last_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",18 "fieldOrder",'截止2020年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'this_started_area' "fieldId",'开工面积' "lable",'this_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",19 "fieldOrder",'2021年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'this_completed_area' "fieldId",'竣工面积' "lable",'this_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",20 "fieldOrder",'2021年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021年10~12月交付项目' "fieldId",'planyear||''年10~12月交付项目' "lable",'2021年10~12月交付项目' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_started_area' "fieldId",'开工面积' "lable",'cutoff_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",23 "fieldOrder",'截止2021年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_completed_area' "fieldId",'竣工面积' "lable",'cutoff_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",24 "fieldOrder",'截止2021年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_started_area' "fieldId",'开工面积' "lable",'next_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",25 "fieldOrder",'2022年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_completed_area' "fieldId",'竣工面积' "lable",'next_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",26 "fieldOrder",'2022年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022年交付项目' "fieldId",'planyear+1||''年交付项目' "lable",'2022年交付项目' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年当年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_last_started_area' "fieldId",'开工面积' "lable",'cutoff_last_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",29 "fieldOrder",'截止2020年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_last_completed_area' "fieldId",'竣工面积' "lable",'cutoff_last_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",30 "fieldOrder",'截止2020年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_sales_area' "fieldId",'销售面积' "lable",'cutoff_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",31 "fieldOrder",'截止2020年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cotoff_sales_amount' "fieldId",'销售金额' "lable",'cotoff_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",32 "fieldOrder",'截止2020年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'剩余货值' "fieldId",'剩余货值' "lable",'剩余货值' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2020年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'新增供货' "fieldId",'新增供货' "lable",'新增供货' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'expected_sales_area' "fieldId",'销售面积' "lable",'expected_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",37 "fieldOrder",'2021年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售金额' "fieldId",'销售金额' "lable",'销售金额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'开累供货（取预售证口径）' "fieldId",'开累供货（取预售证口径）' "lable",'开累供货（取预售证口径）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2021年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_sales_area' "fieldId",'销售面积' "lable",'tired_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",42 "fieldOrder",'截止2021年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_sales_amount' "fieldId",'销售金额' "lable",'tired_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",43 "fieldOrder",'截止2021年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'已取预售证库存' "fieldId",'已取预售证库存' "lable",'已取预售证库存' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2021年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'剩余货值1' "fieldId",'剩余货值' "lable",'剩余货值1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2021年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'新增供货（取预售证口径）' "fieldId",'新增供货（取预售证口径）' "lable",'新增供货（取预售证口径）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_sales_area' "fieldId",'销售面积' "lable",'forecast_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",50 "fieldOrder",'2022年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售金额1' "fieldId",'销售金额' "lable",'销售金额1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年预计完成' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'已取预售证' "fieldId",'已取预售证' "lable",'已取预售证' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2022年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_cotoff_area' "fieldId",'销售面积' "lable",'forecast_cotoff_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",55 "fieldOrder",'截止2022年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_cotoff_amount' "fieldId",'销售金额' "lable",'forecast_cotoff_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",56 "fieldOrder",'截止2022年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'已取预售证库存1' "fieldId",'已取预售证库存' "lable",'已取预售证库存1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2022年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'剩余货值2' "fieldId",'剩余货值' "lable",'剩余货值2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'截止2022年开累' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_last_sale_amount' "fieldId",'销售回款' "lable",'sac_last_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",61 "fieldOrder",'截止2020年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_last_unpaid_amount' "fieldId",'已售未回款金额' "lable",'sac_last_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",62 "fieldOrder",'截止2020年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_then_sale_amount' "fieldId",'销售回款' "lable",'sac_then_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",63 "fieldOrder",'2021年当年1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_then_equity_sale' "fieldId",'权益销售回款' "lable",'sac_then_equity_sale' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",64 "fieldOrder",'2021年当年1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tried_sale_amount' "fieldId",'销售回款' "lable",'tried_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",65 "fieldOrder",'截止2021年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tried_unpaid_amount' "fieldId",'已售未回款金额' "lable",'tried_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",66 "fieldOrder",'截止2021年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_next_sale_amount' "fieldId",'销售回款' "lable",'sac_next_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",67 "fieldOrder",'2022年当年1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_next_equity_sale' "fieldId",'权益销售回款' "lable",'sac_next_equity_sale' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",68 "fieldOrder",'2022年当年1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_tried_sale_amount' "fieldId",'销售回款' "lable",'sac_tried_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",69 "fieldOrder",'截止2022年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_tried_unpaid_amount' "fieldId",'已售未回款金额' "lable",'sac_tried_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",70 "fieldOrder",'截止2022年开累1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_last_investment' "fieldId",'总投资' "lable",'inv_last_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",71 "fieldOrder",'截止2020年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_actual' "fieldId",'实际完成投资' "lable",'inv_then_actual' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",72 "fieldOrder",'2021年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_payment' "fieldId",'实际支付资金' "lable",'inv_then_payment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",73 "fieldOrder",'2021年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'按照资金来源' "fieldId",'按照资金来源' "lable",'按照资金来源' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_land_price' "fieldId",'其中土地价款支付资金' "lable",'inv_land_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",77 "fieldOrder",'2021年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_investment' "fieldId",'总投资' "lable",'inv_then_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",78 "fieldOrder",'截止2021年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_plan_investment' "fieldId",'计划投资' "lable",'inv_plan_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",79 "fieldOrder",'2022年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_invest_funds' "fieldId",'计划投入资金' "lable",'inv_invest_funds' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",80 "fieldOrder",'2022年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'按照资金来源1' "fieldId",'按照资金来源' "lable",'按照资金来源1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_land_price' "fieldId",'其中土地价款支付资金' "lable",'inv_next_land_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",84 "fieldOrder",'2022年当年2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_investment' "fieldId",'总投资' "lable",'inv_next_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",85 "fieldOrder",'截止2022年开累2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income' "fieldId",'营业收入（表内）' "lable",'ltopera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",86 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income_outside' "fieldId",'营业收入（表外）' "lable",'ltopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",87 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income_inside' "fieldId",'营业收入（表内+表外）' "lable",'ltopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",88 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'lttotal_profit' "fieldId",'利润总额（全口径）' "lable",'lttotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",89 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_inside' "fieldId",'净利润（表内）' "lable",'ltprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",90 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_outside' "fieldId",'净利润（表外）' "lable",'ltprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",91 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_outside_equity' "fieldId",'净利润（表外权益）' "lable",'ltprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",92 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_inside_equity' "fieldId",'净利润（表内+表外权益）' "lable",'ltprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",93 "fieldOrder",'截止2020年开累5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income' "fieldId",'营业收入（表内）' "lable",'thopera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",94 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income_outside' "fieldId",'营业收入（表外）' "lable",'thopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",95 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income_inside' "fieldId",'营业收入（表内+表外）' "lable",'thopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",96 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thtotal_profit' "fieldId",'利润总额（全口径）' "lable",'thtotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",97 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_inside' "fieldId",'净利润（表内）' "lable",'thprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",98 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_outside' "fieldId",'净利润（表外）' "lable",'thprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",99 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_outside_equity' "fieldId",'净利润（表外权益）' "lable",'thprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",100 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_inside_equity' "fieldId",'净利润（表内+表外权益）' "lable",'thprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",101 "fieldOrder",'2021年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income' "fieldId",'营业收入（表内）' "lable",'end_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",102 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income_outside' "fieldId",'营业收入（表外）' "lable",'end_opera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",103 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income_inside' "fieldId",'营业收入（表内+表外）' "lable",'end_opera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",104 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_total_profit' "fieldId",'利润总额（全口径）' "lable",'end_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",105 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_inside' "fieldId",'净利润（表内）' "lable",'end_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",106 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_outside' "fieldId",'净利润（表外）' "lable",'end_profit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",107 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_outside_equity' "fieldId",'净利润（表外权益）' "lable",'end_profit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",108 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_inside_equity' "fieldId",'净利润（表内+表外权益）' "lable",'end_profit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",109 "fieldOrder",'截止2021年开累4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_inside_equity' "fieldId",'营业收入（表内）' "lable",'ntprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntopera_income_outside' "fieldId",'营业收入（表外）' "lable",'ntopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",111 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntopera_income_inside' "fieldId",'营业收入（表内+表外）' "lable",'ntopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",112 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'nttotal_profit' "fieldId",'利润总额（全口径）' "lable",'nttotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",113 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_inside' "fieldId",'净利润（表内）' "lable",'ntprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",114 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_outside' "fieldId",'净利润（表外）' "lable",'ntprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",115 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_outside_equity' "fieldId",'净利润（表外权益）' "lable",'ntprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",116 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_rights_equity' "fieldId",'净利润（表内+表外权益）' "lable",'ntprofit_rights_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",117 "fieldOrder",'2022年当年3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income' "fieldId",'营业收入（表内）' "lable",'entnt_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",118 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income_out' "fieldId",'营业收入（表外）' "lable",'entnt_opera_income_out' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",119 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income_ins' "fieldId",'营业收入（表内+表外）' "lable",'entnt_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",120 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_total_profit' "fieldId",'利润总额（全口径）' "lable",'entnt_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",121 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_inside' "fieldId",'净利润（表内）' "lable",'entnt_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",122 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_outside' "fieldId",'净利润（表外）' "lable",'entnt_profit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",123 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_out_equity' "fieldId",'净利润（表外权益）' "lable",'entnt_profit_out_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",124 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_ins_equity' "fieldId",'净利润（表内+表外权益）' "lable",'entnt_profit_ins_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",125 "fieldOrder",'截止2022年开累3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023年' "fieldId",'planyear+2||''年' "lable",'2023年' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'未来两年产值释放计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024年' "fieldId",'planyear+3||''年' "lable",'2024年' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'未来两年产值释放计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第四层
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'todec_due_time' "fieldId",'交付时间' "lable",'todec_due_time' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",21 "fieldOrder",'2021年10~12月交付项目' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'todec_delivery_installment' "fieldId",'交付分期及相应楼栋' "lable",'todec_delivery_installment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",22 "fieldOrder",'2021年10~12月交付项目' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_due_time' "fieldId",'交付时间' "lable",'next_due_time' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",27 "fieldOrder",'2022年交付项目' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_delivery_installment' "fieldId",'交付分期及相应楼栋' "lable",'next_delivery_installment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",28 "fieldOrder",'2022年交付项目' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'remaining_value_area' "fieldId",'面积' "lable",'remaining_value_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",33 "fieldOrder",'剩余货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'remaining_value_amount' "fieldId",'金额' "lable",'remaining_value_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",34 "fieldOrder",'剩余货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'added_supply_area' "fieldId",'面积' "lable",'remaining_value_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",35 "fieldOrder",'新增供货' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'added_supply_amount' "fieldId",'金额' "lable",'added_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",36 "fieldOrder",'新增供货' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'expected_sales_amount' "fieldId",'销售金额' "lable",'expected_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",38 "fieldOrder",'销售金额' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'equity_sales_amount' "fieldId",'权益销售金额' "lable",'equity_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",39 "fieldOrder",'销售金额' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_supply_area' "fieldId",'面积' "lable",'tired_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",40 "fieldOrder",'开累供货（取预售证口径）' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_supply_amount' "fieldId",'金额' "lable",'tired_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",41 "fieldOrder",'开累供货（取预售证口径）' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_stock_area' "fieldId",'面积' "lable",'tired_stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",44 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_stock_amount' "fieldId",'金额' "lable",'tired_stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",45 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_remaining_area' "fieldId",'面积' "lable",'tired_remaining_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",46 "fieldOrder",'剩余货值1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_remaining_amount' "fieldId",'金额' "lable",'tired_remaining_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",47 "fieldOrder",'剩余货值1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_supply_area' "fieldId",'面积' "lable",'forecast_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",48 "fieldOrder",'新增供货（取预售证口径）' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_supply_amount' "fieldId",'金额' "lable",'forecast_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",49 "fieldOrder",'新增供货（取预售证口径）' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_sales_amount' "fieldId",'销售金额' "lable",'forecast_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",51 "fieldOrder",'销售金额1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_equity_amount' "fieldId",'权益销售金额' "lable",'forecast_equity_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",52 "fieldOrder",'销售金额1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_tired_area' "fieldId",'面积' "lable",'forecast_tired_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",53 "fieldOrder",'已取预售证' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_tired_amount' "fieldId",'金额' "lable",'forecast_tired_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",54 "fieldOrder",'已取预售证' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_stock_area' "fieldId",'面积' "lable",'forecast_stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",57 "fieldOrder",'已取预售证库存1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_stock_amount' "fieldId",'金额' "lable",'forecast_stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",58 "fieldOrder",'已取预售证库存1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_remaining_area' "fieldId",'面积' "lable",'forecast_remaining_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",59 "fieldOrder",'剩余货值2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_remaining_amount' "fieldId",'金额' "lable",'forecast_remaining_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",60 "fieldOrder",'剩余货值2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_invest_firm' "fieldId",'企业自有资金' "lable",'inv_invest_firm' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",74 "fieldOrder",'按照资金来源' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_external_financing' "fieldId",'外部融资' "lable",'inv_external_financing' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",75 "fieldOrder",'按照资金来源' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_sales_collection' "fieldId",'销售回款' "lable",'inv_sales_collection' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",76 "fieldOrder",'按照资金来源' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_invest_funds' "fieldId",'企业自有资金' "lable",'inv_next_invest_funds' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",81 "fieldOrder",'按照资金来源1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_external_finan' "fieldId",'外部融资' "lable",'inv_next_external_finan' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",82 "fieldOrder",'按照资金来源1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_sales_collection' "fieldId",'销售回款' "lable",'inv_next_sales_collection' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",83 "fieldOrder",'按照资金来源1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_opera_income' "fieldId",'营业收入' "lable",'tomar_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",128 "fieldOrder",'2023年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_opera_income_ins' "fieldId",'营业收入（表内）' "lable",'tomar_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",129 "fieldOrder",'2023年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_total_profit' "fieldId",'利润总额（全口径）' "lable",'tomar_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",130 "fieldOrder",'2023年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_profit_inside' "fieldId",'净利润' "lable",'tomar_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",131 "fieldOrder",'2023年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_profit_equity' "fieldId",'净利润（表内+表外权益）' "lable",'tomar_profit_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",132 "fieldOrder",'2023年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_opera_income' "fieldId",'营业收入' "lable",'toapr_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",133 "fieldOrder",'2024年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_opera_income_ins' "fieldId",'营业收入（表内）' "lable",'toapr_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",134 "fieldOrder",'2024年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_total_profit' "fieldId",'利润总额（全口径）' "lable",'toapr_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",135 "fieldOrder",'2024年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_profit_inside' "fieldId",'净利润' "lable",'toapr_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",136 "fieldOrder",'2024年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_profit_equity' "fieldId",'净利润（表内+表外权益）' "lable",'toapr_profit_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",137 "fieldOrder",'2024年' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;