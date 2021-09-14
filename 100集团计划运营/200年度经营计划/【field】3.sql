delete opm_excel_filed where sheet_id='groupsheet3' and EXCEL_TYPE='总表';
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
SELECT 'groupsheet3' "sheetID",resultdata.*,'总表' from (
---必须层
---必须层
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet3ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '层级' "fieldId",'层级' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---第一层
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet3序号id' "fieldId",'序号' "lable",'groupsheet3序号' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'项目名称与分期(项目分期须与计划运营系统分期保值一致)' "fieldId",'项目名称与分期(项目分期须与计划运营系统分期保值一致)' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'业态' "fieldId",'业态' "lable",'业态' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'全案总可售货值' "fieldId",'全案总可售货值' "lable",'全案总可售货值' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'开累已取预售总货值' "fieldId",'开累已取预售总货值' "lable",'开累已取预售总货值' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'开累完成销售' "fieldId",'planyear-1||''年开累完成销售' "lable",'开累完成销售' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'全案库存' "fieldId",'全案库存' "lable",'全案库存' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'已取预售证库存' "fieldId",'已取预售证库存' "lable",'已取预售证库存' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021年供货计划' "fieldId",'planyear||''年供货计划' "lable",'2021年供货计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021年销售计划' "fieldId",'planyear||''年销售计划' "lable",'2021年销售计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第一个月' "fieldId",'planyear-1||''/12/26-''||planyear||''/1/25' "lable",'第一个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第二个月' "fieldId",'planyear||''/1/26-''||planyear||''/2/25' "lable",'第二个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第三个月' "fieldId",'planyear||''/2/26-''||planyear||''/3/25' "lable",'第三个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第四个月' "fieldId",'planyear||''/3/26-''||planyear||''/4/25' "lable",'第四个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第五个月' "fieldId",'planyear||''/4/26-''||planyear||''/5/25' "lable",'第五个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第六个月' "fieldId",'planyear||''/5/26-''||planyear||''/6/25' "lable",'第六个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第七个月' "fieldId",'planyear||''/6/26-''||planyear||''/7/25' "lable",'第七个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第八个月' "fieldId",'planyear||''/7/26-''||planyear||''/8/25' "lable",'第八个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第九个月' "fieldId",'planyear||''/8/26-''||planyear||''/9/25' "lable",'第九个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第十个月' "fieldId",'planyear||''/9/26-''||planyear||''/10/25' "lable",'第十个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第十一个月' "fieldId",'planyear||''/10/26-''||planyear||''/11/25' "lable",'第十一个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'第十二个月' "fieldId",'planyear||''/11/26-''||planyear||''/12/25' "lable",'第十二个月' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'供货均衡性分析（S1）' "fieldId",'planyear||''s1' "lable",'供货均衡性分析（S1）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'供货均衡性分析（S2）' "fieldId",'planyear||''s2' "lable",'供货均衡性分析（S2）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'供货均衡性分析（S3）' "fieldId",'planyear||''s3' "lable",'供货均衡性分析（S3）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'供货均衡性分析（S4）' "fieldId",'planyear||''s4' "lable",'供货均衡性分析（S4）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售均衡性分析（S1）' "fieldId",'planyear||''s1' "lable",'销售均衡性分析（S1）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售均衡性分析（S2）' "fieldId",'planyear||''s2' "lable",'销售均衡性分析（S2）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售均衡性分析（S3）' "fieldId",'planyear||''s3' "lable",'销售均衡性分析（S3）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售均衡性分析（S4）' "fieldId",'planyear||''s4' "lable",'销售均衡性分析（S4）' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'去化率' "fieldId",'去化率' "lable",'去化率' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022一季度' "fieldId",'planyear+1||''一季度' "lable",'2022一季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022二季度' "fieldId",'planyear+1||''二季度' "lable",'2022二季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022三季度' "fieldId",'planyear+1||''三季度' "lable",'2022三季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022四季度' "fieldId",'planyear+1||''四季度' "lable",'2022四季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023一季度' "fieldId",'planyear+2||''一季度' "lable",'2023一季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023二季度' "fieldId",'planyear+2||''二季度' "lable",'2023二季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023三季度' "fieldId",'planyear+2||''三季度' "lable",'2023三季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023四季度' "fieldId",'planyear+2||''四季度' "lable",'2023四季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024一季度' "fieldId",'planyear+3||''一季度' "lable",'2024一季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024二季度' "fieldId",'planyear+3||''二季度' "lable",'2024二季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024三季度' "fieldId",'planyear+3||''三季度' "lable",'2024三季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024四季度' "fieldId",'planyear+3||''四季度' "lable",'2024四季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025一季度' "fieldId",'planyear+4||''一季度' "lable",'2025一季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025二季度' "fieldId",'planyear+4||''二季度' "lable",'2025二季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025三季度' "fieldId",'planyear+4||''三季度' "lable",'2025三季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025四季度' "fieldId",'planyear+4||''四季度' "lable",'2025四季度' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第二层
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积' "fieldId",'面积' "lable",'a面积' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案总可售货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数' "fieldId",'a套数' "lable",'a套数' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案总可售货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额' "fieldId",'a金额' "lable",'a金额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案总可售货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价' "fieldId",'平米单价' "lable",'平米单价' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案总可售货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积1' "fieldId",'面积' "lable",'a面积1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累已取预售总货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数1' "fieldId",'套数' "lable",'a套数1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累已取预售总货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额1' "fieldId",'金额' "lable",'a金额1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累已取预售总货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价1' "fieldId",'平米单价' "lable",'平米单价1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累已取预售总货值' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积2' "fieldId",'面积' "lable",'a面积2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累完成销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数2' "fieldId",'套数' "lable",'a套数2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累完成销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额2' "fieldId",'金额' "lable",'a金额2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累完成销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价2' "fieldId",'平米单价' "lable",'平米单价2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'开累完成销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积3' "fieldId",'面积' "lable",'a面积3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数3' "fieldId",'套数' "lable",'a套数3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额3' "fieldId",'金额' "lable",'a金额3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价3' "fieldId",'平米单价' "lable",'平米单价3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'全案库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积4' "fieldId",'面积' "lable",'a面积4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数4' "fieldId",'套数' "lable",'a套数4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额4' "fieldId",'金额' "lable",'a金额4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价4' "fieldId",'平米单价' "lable",'平米单价4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'已取预售证库存' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积5' "fieldId",'面积' "lable",'a面积5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年供货计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数5' "fieldId",'套数' "lable",'a套数5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年供货计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额5' "fieldId",'金额' "lable",'a金额5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年供货计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价5' "fieldId",'平米单价' "lable",'平米单价5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年供货计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a面积6' "fieldId",'面积' "lable",'a面积6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年销售计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a套数6' "fieldId",'套数' "lable",'a套数6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年销售计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a金额6' "fieldId",'金额' "lable",'a金额6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年销售计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '平米单价6' "fieldId",'平米单价' "lable",'平米单价6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年销售计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应' "fieldId",'供应' "lable",'供应' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第一个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售' "fieldId",'销售' "lable",'销售' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第一个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应1' "fieldId",'供应' "lable",'供应1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第二个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售1' "fieldId",'销售' "lable",'销售1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第二个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应2' "fieldId",'供应' "lable",'供应2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第三个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售2' "fieldId",'销售' "lable",'销售2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第三个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应3' "fieldId",'供应' "lable",'供应3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第四个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售3' "fieldId",'销售' "lable",'销售3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第四个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应4' "fieldId",'供应' "lable",'供应4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第五个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售4' "fieldId",'销售' "lable",'销售4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第五个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应5' "fieldId",'供应' "lable",'供应5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第六个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售5' "fieldId",'销售' "lable",'销售5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第六个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应6' "fieldId",'供应' "lable",'供应6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第七个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售6' "fieldId",'销售' "lable",'销售6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第七个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应7' "fieldId",'供应' "lable",'供应7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第八个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售7' "fieldId",'销售' "lable",'销售7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第八个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应8' "fieldId",'供应' "lable",'供应8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第九个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售8' "fieldId",'销售' "lable",'销售8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第九个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应9' "fieldId",'供应' "lable",'供应9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售9' "fieldId",'销售' "lable",'销售9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应10' "fieldId",'供应' "lable",'供应10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十一个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售10' "fieldId",'销售' "lable",'销售10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十一个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '供应11' "fieldId",'供应' "lable",'供应11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十二个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '销售11' "fieldId",'销售' "lable",'销售11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'第十二个月' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---s1~s4
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '百分比' "fieldId",'%' "lable",'百分比' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'去化率' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应' "fieldId",'供应' "lable",'季度供应' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售' "fieldId",'销售' "lable",'季度销售' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应1' "fieldId",'供应' "lable",'季度供应1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售1' "fieldId",'销售' "lable",'季度销售1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应2' "fieldId",'供应' "lable",'季度供应2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售2' "fieldId",'销售' "lable",'季度销售2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应3' "fieldId",'供应' "lable",'季度供应3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售3' "fieldId",'销售' "lable",'季度销售3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应4' "fieldId",'供应' "lable",'季度供应4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售4' "fieldId",'销售' "lable",'季度销售4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应5' "fieldId",'供应' "lable",'季度供应5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售5' "fieldId",'销售' "lable",'季度销售5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应6' "fieldId",'供应' "lable",'季度供应6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售6' "fieldId",'销售' "lable",'季度销售6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应7' "fieldId",'供应' "lable",'季度供应7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售7' "fieldId",'销售' "lable",'季度销售7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应8' "fieldId",'供应' "lable",'季度供应8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售8' "fieldId",'销售' "lable",'季度销售8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应9' "fieldId",'供应' "lable",'季度供应9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售9' "fieldId",'销售' "lable",'季度销售9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应10' "fieldId",'供应' "lable",'季度供应10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售10' "fieldId",'销售' "lable",'季度销售10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应11' "fieldId",'供应' "lable",'季度供应11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售11' "fieldId",'销售' "lable",'季度销售11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应12' "fieldId",'供应' "lable",'季度供应12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售12' "fieldId",'销售' "lable",'季度销售12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025一季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应13' "fieldId",'供应' "lable",'季度供应13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售13' "fieldId",'销售' "lable",'季度销售13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025二季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应14' "fieldId",'供应' "lable",'季度供应14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售14' "fieldId",'销售' "lable",'季度销售14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025三季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度供应15' "fieldId",'供应' "lable",'季度供应15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '季度销售15' "fieldId",'销售' "lable",'季度销售15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025四季度' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第三层
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_area' "fieldId",'万㎡' "lable",'saleable_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_number' "fieldId",'套' "lable",'saleable_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_amount' "fieldId",'万元' "lable",'saleable_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_price' "fieldId",'元/㎡' "lable",'saleable_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_area' "fieldId",'万㎡' "lable",'tired_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_number' "fieldId",'套' "lable",'tired_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_amount' "fieldId",'万元' "lable",'tired_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_price' "fieldId",'元/㎡' "lable",'tired_sale_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_area' "fieldId",'万㎡' "lable",'tired_complete_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_number' "fieldId",'套' "lable",'tired_complete_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_amount' "fieldId",'万元' "lable",'tired_complete_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_price' "fieldId",'元/㎡' "lable",'tired_complete_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_area' "fieldId",'万㎡' "lable",'stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_number' "fieldId",'套' "lable",'stock_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_amount' "fieldId",'万元' "lable",'stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_price' "fieldId",'元/㎡' "lable",'stock_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_area' "fieldId",'万㎡' "lable",'sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_sleeve' "fieldId",'套' "lable",'sale_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_amount' "fieldId",'万元' "lable",'sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_price' "fieldId",'元/㎡' "lable",'sale_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_area' "fieldId",'万㎡' "lable",'supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_sleeve' "fieldId",'套' "lable",'supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_amount' "fieldId",'万元' "lable",'supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_price' "fieldId",'元/㎡' "lable",'supply_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_area' "fieldId",'万㎡' "lable",'sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a面积6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_sleeve' "fieldId",'套' "lable",'sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a套数6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_amount' "fieldId",'万元' "lable",'sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a金额6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_price' "fieldId",'元/㎡' "lable",'sales_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'平方单价6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积' "fieldId",'面积' "lable",'面积' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数' "fieldId",'套数' "lable",'套数' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额' "fieldId",'金额' "lable",'金额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积1' "fieldId",'面积' "lable",'面积1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数1' "fieldId",'套数' "lable",'套数1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额1' "fieldId",'金额' "lable",'金额1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积2' "fieldId",'面积' "lable",'面积2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数2' "fieldId",'套数' "lable",'套数2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额2' "fieldId",'金额2' "lable",'金额2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积3' "fieldId",'面积' "lable",'面积3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数3' "fieldId",'套数' "lable",'套数3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额3' "fieldId",'金额' "lable",'金额3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积4' "fieldId",'面积' "lable",'面积4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数4' "fieldId",'套数' "lable",'套数4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额4' "fieldId",'金额' "lable",'金额4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积5' "fieldId",'面积' "lable",'面积5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数5' "fieldId",'套数' "lable",'套数5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额5' "fieldId",'金额' "lable",'金额5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积6' "fieldId",'面积' "lable",'面积6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数6' "fieldId",'套数' "lable",'套数6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额6' "fieldId",'金额' "lable",'金额6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积7' "fieldId",'面积' "lable",'面积7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数7' "fieldId",'套数' "lable",'套数7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额7' "fieldId",'金额' "lable",'金额7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积8' "fieldId",'面积' "lable",'面积8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数8' "fieldId",'套数' "lable",'套数8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额8' "fieldId",'金额' "lable",'金额8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积9' "fieldId",'面积' "lable",'面积9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数9' "fieldId",'套数' "lable",'套数9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额9' "fieldId",'金额' "lable",'金额9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积10' "fieldId",'面积' "lable",'面积10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数10' "fieldId",'套数' "lable",'套数10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额10' "fieldId",'金额' "lable",'金额10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积11' "fieldId",'面积' "lable",'面积11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数11' "fieldId",'套数' "lable",'套数11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额11' "fieldId",'金额' "lable",'金额11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积12' "fieldId",'面积' "lable",'面积12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数12' "fieldId",'套数' "lable",'套数12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额12' "fieldId",'金额' "lable",'金额12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积13' "fieldId",'面积' "lable",'面积13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数13' "fieldId",'套数' "lable",'套数13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额13' "fieldId",'金额' "lable",'金额13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积14' "fieldId",'面积' "lable",'面积14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数14' "fieldId",'套数' "lable",'套数14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额14' "fieldId",'金额' "lable",'金额14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积15' "fieldId",'面积' "lable",'面积15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数15' "fieldId",'套数' "lable",'套数15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额15' "fieldId",'金额' "lable",'金额15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积16' "fieldId",'面积' "lable",'面积16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数16' "fieldId",'套数' "lable",'套数16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额16' "fieldId",'金额' "lable",'金额16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积17' "fieldId",'面积' "lable",'面积17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数17' "fieldId",'套数' "lable",'套数17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额17' "fieldId",'金额' "lable",'金额17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积18' "fieldId",'面积' "lable",'面积18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数18' "fieldId",'套数' "lable",'套数18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额18' "fieldId",'金额' "lable",'金额18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积19' "fieldId",'面积' "lable",'面积19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数19' "fieldId",'套数' "lable",'套数19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额19' "fieldId",'金额' "lable",'金额19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积20' "fieldId",'面积' "lable",'面积20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数20' "fieldId",'套数' "lable",'套数20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额20' "fieldId",'金额' "lable",'金额20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积21' "fieldId",'面积' "lable",'面积21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数21' "fieldId",'套数' "lable",'套数21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额21' "fieldId",'金额' "lable",'金额21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积22' "fieldId",'面积' "lable",'面积22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数22' "fieldId",'套数' "lable",'套数22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额22' "fieldId",'金额' "lable",'金额22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'供应11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积23' "fieldId",'面积' "lable",'面积23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数23' "fieldId",'套数' "lable",'套数23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额23' "fieldId",'金额' "lable",'金额23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
--s1
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额' "fieldId",'金额' "lable",'金额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比' "fieldId",'占比' "lable",'占比' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额1' "fieldId",'金额' "lable",'金额1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比1' "fieldId",'占比' "lable",'占比1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额2' "fieldId",'金额' "lable",'金额2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比2' "fieldId",'占比' "lable",'占比2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额3' "fieldId",'金额' "lable",'金额3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比3' "fieldId",'占比' "lable",'占比3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额4' "fieldId",'金额' "lable",'金额4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比4' "fieldId",'占比' "lable",'占比4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额5' "fieldId",'金额' "lable",'金额5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比5' "fieldId",'占比' "lable",'占比5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额6' "fieldId",'金额' "lable",'金额6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比6' "fieldId",'占比' "lable",'占比6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额7' "fieldId",'金额' "lable",'金额7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '占比7' "fieldId",'占比' "lable",'占比7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'销售11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积24' "fieldId",'面积' "lable",'面积24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数24' "fieldId",'套数' "lable",'套数24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额24' "fieldId",'金额' "lable",'金额24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积25' "fieldId",'面积' "lable",'面积25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数25' "fieldId",'套数' "lable",'套数25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额25' "fieldId",'金额' "lable",'金额25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积26' "fieldId",'面积' "lable",'面积26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数26' "fieldId",'套数' "lable",'套数26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额26' "fieldId",'金额' "lable",'金额26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积27' "fieldId",'面积' "lable",'面积27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数27' "fieldId",'套数' "lable",'套数27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额27' "fieldId",'金额' "lable",'金额27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积28' "fieldId",'面积' "lable",'面积28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数28' "fieldId",'套数' "lable",'套数28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额28' "fieldId",'金额' "lable",'金额28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积29' "fieldId",'面积' "lable",'面积29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数29' "fieldId",'套数' "lable",'套数29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额29' "fieldId",'金额' "lable",'金额29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积30' "fieldId",'面积' "lable",'面积30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数30' "fieldId",'套数' "lable",'套数30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额30' "fieldId",'金额' "lable",'金额30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积31' "fieldId",'面积' "lable",'面积31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数31' "fieldId",'套数' "lable",'套数31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额31' "fieldId",'金额' "lable",'金额31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积32' "fieldId",'面积' "lable",'面积32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数32' "fieldId",'套数' "lable",'套数32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额32' "fieldId",'金额' "lable",'金额32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积33' "fieldId",'面积' "lable",'面积33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数33' "fieldId",'套数' "lable",'套数33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额33' "fieldId",'金额' "lable",'金额33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积34' "fieldId",'面积' "lable",'面积34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数34' "fieldId",'套数' "lable",'套数34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额34' "fieldId",'金额' "lable",'金额34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积35' "fieldId",'面积' "lable",'面积35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数35' "fieldId",'套数' "lable",'套数35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额35' "fieldId",'金额' "lable",'金额35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积36' "fieldId",'面积' "lable",'面积36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数36' "fieldId",'套数' "lable",'套数36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额36' "fieldId",'金额' "lable",'金额36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积37' "fieldId",'面积' "lable",'面积37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数37' "fieldId",'套数' "lable",'套数37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额37' "fieldId",'金额' "lable",'金额37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积38' "fieldId",'面积' "lable",'面积38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数38' "fieldId",'套数' "lable",'套数38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额38' "fieldId",'金额' "lable",'金额38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积39' "fieldId",'面积' "lable",'面积39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数39' "fieldId",'套数' "lable",'套数39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额39' "fieldId",'金额' "lable",'金额39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积40' "fieldId",'面积' "lable",'面积40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数40' "fieldId",'套数' "lable",'套数40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额40' "fieldId",'金额' "lable",'金额40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积41' "fieldId",'面积' "lable",'面积41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数41' "fieldId",'套数' "lable",'套数41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额41' "fieldId",'金额' "lable",'金额41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积42' "fieldId",'面积' "lable",'面积42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数42' "fieldId",'套数' "lable",'套数42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额42' "fieldId",'金额' "lable",'金额42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积43' "fieldId",'面积' "lable",'面积43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数43' "fieldId",'套数' "lable",'套数43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额43' "fieldId",'金额' "lable",'金额43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积44' "fieldId",'面积' "lable",'面积44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数44' "fieldId",'套数' "lable",'套数44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额44' "fieldId",'金额' "lable",'金额44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积45' "fieldId",'面积' "lable",'面积45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数45' "fieldId",'套数' "lable",'套数45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额45' "fieldId",'金额' "lable",'金额45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积46' "fieldId",'面积' "lable",'面积46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数46' "fieldId",'套数' "lable",'套数46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额46' "fieldId",'金额' "lable",'金额46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积47' "fieldId",'面积' "lable",'面积47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数47' "fieldId",'套数' "lable",'套数47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额47' "fieldId",'金额' "lable",'金额47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积48' "fieldId",'面积' "lable",'面积48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数48' "fieldId",'套数' "lable",'套数48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额48' "fieldId",'金额' "lable",'金额48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积49' "fieldId",'面积' "lable",'面积49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数49' "fieldId",'套数' "lable",'套数49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额49' "fieldId",'金额' "lable",'金额49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积50' "fieldId",'面积' "lable",'面积50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数50' "fieldId",'套数' "lable",'套数50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额50' "fieldId",'金额' "lable",'金额50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积51' "fieldId",'面积' "lable",'面积51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数51' "fieldId",'套数' "lable",'套数51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额51' "fieldId",'金额' "lable",'金额51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积52' "fieldId",'面积' "lable",'面积52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数52' "fieldId",'套数' "lable",'套数52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额52' "fieldId",'金额' "lable",'金额52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积53' "fieldId",'面积' "lable",'面积53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数53' "fieldId",'套数' "lable",'套数53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额53' "fieldId",'金额' "lable",'金额53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积54' "fieldId",'面积' "lable",'面积54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数54' "fieldId",'套数' "lable",'套数54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额54' "fieldId",'金额' "lable",'金额54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '面积55' "fieldId",'面积' "lable",'面积55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '套数55' "fieldId",'套数' "lable",'套数55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '金额55' "fieldId",'金额' "lable",'金额55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

---第四层
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_area' "fieldId",'万㎡' "lable",'jan_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_sleeve' "fieldId",'套' "lable",'jan_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_amount' "fieldId",'万元' "lable",'jan_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_area' "fieldId",'万㎡' "lable",'jan_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_sleeve' "fieldId",'套' "lable",'jan_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_amount' "fieldId",'万元' "lable",'jan_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_area' "fieldId",'万㎡' "lable",'feb_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_sleeve' "fieldId",'套' "lable",'feb_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_amount' "fieldId",'万元' "lable",'feb_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_area' "fieldId",'万㎡' "lable",'feb_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_sleeve' "fieldId",'套' "lable",'feb_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_amount' "fieldId",'万元' "lable",'feb_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_area' "fieldId",'万㎡' "lable",'mar_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_sleeve' "fieldId",'套' "lable",'mar_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_amount' "fieldId",'万元' "lable",'mar_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_area' "fieldId",'万㎡' "lable",'mar_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_sleeve' "fieldId",'套' "lable",'mar_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_amount' "fieldId",'万元' "lable",'mar_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_area' "fieldId",'万㎡' "lable",'apr_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_sleeve' "fieldId",'套' "lable",'apr_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_amount' "fieldId",'万元' "lable",'apr_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_area' "fieldId",'万㎡' "lable",'apr_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_sleeve' "fieldId",'套' "lable",'apr_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_amount' "fieldId",'万元' "lable",'apr_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_area' "fieldId",'万㎡' "lable",'may_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_sleeve' "fieldId",'套' "lable",'may_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_amount' "fieldId",'万元' "lable",'may_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_area' "fieldId",'万㎡' "lable",'may_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_sleeve' "fieldId",'套' "lable",'may_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_amount' "fieldId",'万元' "lable",'may_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_area' "fieldId",'万㎡' "lable",'june_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_sleeve' "fieldId",'套' "lable",'june_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_amount' "fieldId",'万元' "lable",'june_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_area' "fieldId",'万㎡' "lable",'june_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_sleeve' "fieldId",'套' "lable",'june_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_amount' "fieldId",'万元' "lable",'june_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_area' "fieldId",'万㎡' "lable",'july_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_sleeve' "fieldId",'套' "lable",'july_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_amount' "fieldId",'万元' "lable",'july_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_area' "fieldId",'万㎡' "lable",'july_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_sleeve' "fieldId",'套' "lable",'july_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_amount' "fieldId",'万元' "lable",'july_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_area' "fieldId",'万㎡' "lable",'aug_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_sleeve' "fieldId",'套' "lable",'aug_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_amount' "fieldId",'万元' "lable",'aug_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_area' "fieldId",'万㎡' "lable",'aug_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_sleeve' "fieldId",'套' "lable",'aug_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_amount' "fieldId",'万元' "lable",'aug_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_area' "fieldId",'万㎡' "lable",'sep_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_sleeve' "fieldId",'套' "lable",'sep_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_amount' "fieldId",'万元' "lable",'sep_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_area' "fieldId",'万㎡' "lable",'sep_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_sleeve' "fieldId",'套' "lable",'sep_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_amount' "fieldId",'万元' "lable",'sep_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_area' "fieldId",'万㎡' "lable",'oct_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_sleeve' "fieldId",'套' "lable",'oct_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_amount' "fieldId",'万元' "lable",'oct_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_area' "fieldId",'万㎡' "lable",'oct_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_sleeve' "fieldId",'套' "lable",'oct_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_amount' "fieldId",'万元' "lable",'oct_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_area' "fieldId",'万㎡' "lable",'nov_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_sleeve' "fieldId",'套' "lable",'nov_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_amount' "fieldId",'万元' "lable",'nov_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_area' "fieldId",'万㎡' "lable",'nov_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_sleeve' "fieldId",'套' "lable",'nov_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_amount' "fieldId",'万元' "lable",'nov_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_area' "fieldId",'万㎡' "lable",'dec_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_sleeve' "fieldId",'套' "lable",'dec_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_amount' "fieldId",'万元' "lable",'dec_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_area' "fieldId",'万㎡' "lable",'dec_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'面积23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_sleeve' "fieldId",'套' "lable",'dec_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'套数23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_amount' "fieldId",'万元' "lable",'dec_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_one_amount' "fieldId",'万元' "lable",'supply_one_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_one_ratio' "fieldId",'%' "lable",'supply_one_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_two_amount' "fieldId",'万元' "lable",'supply_two_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_two_ratio' "fieldId",'%' "lable",'supply_two_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_three_amount' "fieldId",'万元' "lable",'supply_three_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_three_ratio' "fieldId",'%' "lable",'supply_three_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_four_amount' "fieldId",'万元' "lable",'supply_four_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_four_ratio' "fieldId",'%' "lable",'supply_four_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_one_amount' "fieldId",'万元' "lable",'sales_one_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_one_ratio' "fieldId",'%' "lable",'sales_one_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_two_amount' "fieldId",'万元' "lable",'sales_two_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_two_ratio' "fieldId",'%' "lable",'sales_two_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_three_amount' "fieldId",'万元' "lable",'sales_three_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_three_ratio' "fieldId",'%' "lable",'sales_three_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_four_amount' "fieldId",'万元' "lable",'sales_four_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'金额7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_four_ratio' "fieldId",'%' "lable",'sales_four_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'占比7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'desalination_rate' "fieldId",'%' "lable",'desalination_rate' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'去化率' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_area' "fieldId",'万㎡' "lable",'ny_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_number' "fieldId",'套' "lable",'ny_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_amount' "fieldId",'万元' "lable",'ny_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_area' "fieldId",'万㎡' "lable",'ny_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_number' "fieldId",'套' "lable",'ny_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_amount' "fieldId",'万元' "lable",'ny_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_area' "fieldId",'万㎡' "lable",'ny_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_number' "fieldId",'套' "lable",'ny_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_amount' "fieldId",'万元' "lable",'ny_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_area' "fieldId",'万㎡' "lable",'ny_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_number' "fieldId",'套' "lable",'ny_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_amount' "fieldId",'万元' "lable",'ny_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_area' "fieldId",'万㎡' "lable",'ny_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_number' "fieldId",'套' "lable",'ny_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_amount' "fieldId",'万元' "lable",'ny_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_area' "fieldId",'万㎡' "lable",'ny_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_number' "fieldId",'套' "lable",'ny_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_amount' "fieldId",'万元' "lable",'ny_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_area' "fieldId",'万㎡' "lable",'ny_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_number' "fieldId",'套' "lable",'ny_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_amount' "fieldId",'万元' "lable",'ny_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_area' "fieldId",'万㎡' "lable",'ny_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_number' "fieldId",'套' "lable",'ny_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_amount' "fieldId",'万元' "lable",'ny_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_area' "fieldId",'万㎡' "lable",'ncy_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_number' "fieldId",'套' "lable",'ncy_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_amount' "fieldId",'万元' "lable",'ncy_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_area' "fieldId",'万㎡' "lable",'ncy_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_number' "fieldId",'套' "lable",'ncy_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_amount' "fieldId",'万元' "lable",'ncy_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_area' "fieldId",'万㎡' "lable",'ncy_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_number' "fieldId",'套' "lable",'ncy_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_amount' "fieldId",'万元' "lable",'ncy_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_area' "fieldId",'万㎡' "lable",'ncy_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_number' "fieldId",'套' "lable",'ncy_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_amount' "fieldId",'万元' "lable",'ncy_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_area' "fieldId",'万㎡' "lable",'ncy_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_number' "fieldId",'套' "lable",'ncy_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_amount' "fieldId",'万元' "lable",'ncy_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_area' "fieldId",'万㎡' "lable",'ncy_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_number' "fieldId",'套' "lable",'ncy_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_amount' "fieldId",'万元' "lable",'ncy_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_area' "fieldId",'万㎡' "lable",'ncy_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_number' "fieldId",'套' "lable",'ncy_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_amount' "fieldId",'万元' "lable",'ncy_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_area' "fieldId",'万㎡' "lable",'ncy_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_number' "fieldId",'套' "lable",'ncy_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_amount' "fieldId",'万元' "lable",'ncy_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_area' "fieldId",'万㎡' "lable",'nty_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_number' "fieldId",'套' "lable",'nty_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_amount' "fieldId",'万元' "lable",'nty_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_area' "fieldId",'万㎡' "lable",'nty_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_number' "fieldId",'套' "lable",'nty_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_amount' "fieldId",'万元' "lable",'nty_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_area' "fieldId",'万㎡' "lable",'nty_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_number' "fieldId",'套' "lable",'nty_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_amount' "fieldId",'万元' "lable",'nty_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_area' "fieldId",'万㎡' "lable",'nty_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_number' "fieldId",'套' "lable",'nty_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_amount' "fieldId",'万元' "lable",'nty_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_area' "fieldId",'万㎡' "lable",'nty_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_number' "fieldId",'套' "lable",'nty_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_amount' "fieldId",'万元' "lable",'nty_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_area' "fieldId",'万㎡' "lable",'nty_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_number' "fieldId",'套' "lable",'nty_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_amount' "fieldId",'万元' "lable",'nty_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_area' "fieldId",'万㎡' "lable",'nty_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_number' "fieldId",'套' "lable",'nty_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_amount' "fieldId",'万元' "lable",'nty_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_area' "fieldId",'万㎡' "lable",'nty_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_number' "fieldId",'套' "lable",'nty_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_amount' "fieldId",'万元' "lable",'nty_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_area' "fieldId",'万㎡' "lable",'nfy_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_number' "fieldId",'套' "lable",'nfy_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_amount' "fieldId",'万元' "lable",'nfy_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_area' "fieldId",'万㎡' "lable",'nfy_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_number' "fieldId",'套' "lable",'nfy_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_amount' "fieldId",'万元' "lable",'nfy_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_area' "fieldId",'万㎡' "lable",'nfy_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_number' "fieldId",'套' "lable",'nfy_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_amount' "fieldId",'万元' "lable",'nfy_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_area' "fieldId",'万㎡' "lable",'nfy_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_number' "fieldId",'套' "lable",'nfy_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_amount' "fieldId",'万元' "lable",'nfy_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_area' "fieldId",'万㎡' "lable",'nfy_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_number' "fieldId",'套' "lable",'nfy_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_amount' "fieldId",'万元' "lable",'nfy_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_area' "fieldId",'万㎡' "lable",'nfy_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_number' "fieldId",'套' "lable",'nfy_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_amount' "fieldId",'万元' "lable",'nfy_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_area' "fieldId",'万㎡' "lable",'nfy_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_number' "fieldId",'套' "lable",'nfy_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_amount' "fieldId",'万元' "lable",'nfy_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度供应' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_area' "fieldId",'万㎡' "lable",'nfy_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_number' "fieldId",'套' "lable",'nfy_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_amount' "fieldId",'万元' "lable",'nfy_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'季度销售' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;