delete opm_excel_filed where sheet_id='groupsheet2' and EXCEL_TYPE='总表';
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
SELECT 'groupsheet2' "sheetID",resultdata.*,'总表' from (
---必须层
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet2ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '层级' "fieldId",'层级' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---第一层
SELECT  1 "fieldLevel",1 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet2序号id' "fieldId",'序号' "lable",'groupsheet2序号' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'城市/项目名称' "fieldId",'城市/项目名称' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021年集团（区域）动态现金流' "fieldId",'{currentYear}年集团（区域）动态现金流' "lable",'2021年集团（区域）动态现金流' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第二层
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '截至2021年底' "fieldId",'截至{currentYear_MinusOne}年底' "lable",'截至2021年底' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022年资金来源计划' "fieldId",'{currentYear}年资金来源计划' "lable",'2022年资金来源计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022年资金运用计划' "fieldId",'{currentYear}年资金运用计划' "lable",'2022年资金运用计划' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022年当年现金流情况展示窗' "fieldId",'{currentYear}年当年现金流情况展示窗' "lable",'2022年当年现金流情况展示窗' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2021年集团（区域）动态现金流' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---第三层
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021年底-期末资金余额' "fieldId",'2021年底-期末资金余额' "lable",'年底-期末资金余额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'截至2021年底' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'销售回款' "fieldId",'销售回款' "lable",'销售回款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'租金收入' "fieldId",'租金收入' "lable",'租金收入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",310 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'净增贷款' "fieldId",'净增贷款' "lable",'净增贷款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",410 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'代收款' "fieldId",'代收款' "lable",'代收款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",510 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'股东投入' "fieldId",'股东投入' "lable",'股东投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",610 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'往来投入' "fieldId",'往来投入' "lable",'往来投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'其他投入' "fieldId",'其他投入' "lable",'其他投入' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'资金来源合计' "fieldId",'资金来源合计' "lable",'资金来源合计' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2022年资金来源计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'土地费用' "fieldId",'土地费用' "lable",'土地费用' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'工程性支出' "fieldId",'工程性支出' "lable",'工程性支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1110 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'开发间接费' "fieldId",'开发间接费' "lable",'开发间接费' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1210 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'期间费用' "fieldId",'期间费用' "lable",'期间费用' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1310 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'税金' "fieldId",'税金' "lable",'税金' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1410 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'代付款' "fieldId",'代付款' "lable",'代付款' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1510 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'其他支出' "fieldId",'其他支出' "lable",'其他支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1610 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'往来支出' "fieldId",'往来支出' "lable",'往来支出' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1710 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'资金运用小计' "fieldId",'资金运用小计' "lable",'资金运用小计' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1810 "fieldOrder",'2022年资金运用计划' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'资金净流量' "fieldId",'资金净流量' "lable",'资金净流量' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1910 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'展示窗-期末资金余额' "fieldId",'期末资金余额' "lable",'展示窗-期末资金余额' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2010 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'可动用资金' "fieldId",'可动用资金' "lable",'可动用资金' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2110 "fieldOrder",'2022年当年现金流情况展示窗' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;
