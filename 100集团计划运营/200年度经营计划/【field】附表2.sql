delete opm_excel_filed where sheet_id='projsheet2' and EXCEL_TYPE='����';
commit;
INSERT INTO opm_excel_filed (
    sheet_id,
    field_level,
    is_hide,
    is_end,
    header_bgcolor,
    header_fontcolor,
    DATA_COLUMN_BGCOLOR,
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
SELECT 'projsheet2' "sheetID",resultdata.*,'����' from (
---��һ��
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",'WHITE' "dataBgColor",   'groupsheet2���id' "fieldId",'���' "lable",'groupsheet2���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",'WHITE' "dataBgColor",  '��Ŀ����1' "fieldId",'��Ŀ����' "lable",'OBJECT_NAME1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'PALE_BLUE' "headerBgColor",'GREY_80_PERCENT' "headerFontColor",'WHITE' "dataBgColor",  '��Ŀ����2' "fieldId",'��Ŀ����' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",0 "isColumnMerge"  From Dual

) resultdata;
