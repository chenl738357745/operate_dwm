delete opm_excel_filed where sheet_id='groupsheet3' and EXCEL_TYPE='�ܱ�';
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
SELECT 'groupsheet3' "sheetID",resultdata.*,'�ܱ�' from (
---�����
---�����
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet3ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�㼶' "fieldId",'�㼶' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---��һ��
SELECT    1 "fieldLevel",1 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet3���id' "fieldId",'���' "lable",'groupsheet3���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��Ŀ���������(��Ŀ��������ƻ���Ӫϵͳ���ڱ�ֵһ��)' "fieldId",'��Ŀ���������(��Ŀ��������ƻ���Ӫϵͳ���ڱ�ֵһ��)' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ҵ̬' "fieldId",'ҵ̬' "lable",'ҵ̬' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ȫ���ܿ��ۻ�ֵ' "fieldId",'ȫ���ܿ��ۻ�ֵ' "lable",'ȫ���ܿ��ۻ�ֵ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'������ȡԤ���ܻ�ֵ' "fieldId",'������ȡԤ���ܻ�ֵ' "lable",'������ȡԤ���ܻ�ֵ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�����������' "fieldId",'planyear-1||''�꿪���������' "lable",'�����������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ȫ�����' "fieldId",'ȫ�����' "lable",'ȫ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ȡԤ��֤���' "fieldId",'��ȡԤ��֤���' "lable",'��ȡԤ��֤���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021�깩���ƻ�' "fieldId",'planyear||''�깩���ƻ�' "lable",'2021�깩���ƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021�����ۼƻ�' "fieldId",'planyear||''�����ۼƻ�' "lable",'2021�����ۼƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��һ����' "fieldId",'planyear-1||''/12/26-''||planyear||''/1/25' "lable",'��һ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ڶ�����' "fieldId",'planyear||''/1/26-''||planyear||''/2/25' "lable",'�ڶ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'planyear||''/2/26-''||planyear||''/3/25' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���ĸ���' "fieldId",'planyear||''/3/26-''||planyear||''/4/25' "lable",'���ĸ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�������' "fieldId",'planyear||''/4/26-''||planyear||''/5/25' "lable",'�������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'planyear||''/5/26-''||planyear||''/6/25' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���߸���' "fieldId",'planyear||''/6/26-''||planyear||''/7/25' "lable",'���߸���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ڰ˸���' "fieldId",'planyear||''/7/26-''||planyear||''/8/25' "lable",'�ڰ˸���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ھŸ���' "fieldId",'planyear||''/8/26-''||planyear||''/9/25' "lable",'�ھŸ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ʮ����' "fieldId",'planyear||''/9/26-''||planyear||''/10/25' "lable",'��ʮ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ʮһ����' "fieldId",'planyear||''/10/26-''||planyear||''/11/25' "lable",'��ʮһ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ʮ������' "fieldId",'planyear||''/11/26-''||planyear||''/12/25' "lable",'��ʮ������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���������Է�����S1��' "fieldId",'planyear||''s1' "lable",'���������Է�����S1��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���������Է�����S2��' "fieldId",'planyear||''s2' "lable",'���������Է�����S2��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���������Է�����S3��' "fieldId",'planyear||''s3' "lable",'���������Է�����S3��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���������Է�����S4��' "fieldId",'planyear||''s4' "lable",'���������Է�����S4��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۾����Է�����S1��' "fieldId",'planyear||''s1' "lable",'���۾����Է�����S1��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۾����Է�����S2��' "fieldId",'planyear||''s2' "lable",'���۾����Է�����S2��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۾����Է�����S3��' "fieldId",'planyear||''s3' "lable",'���۾����Է�����S3��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۾����Է�����S4��' "fieldId",'planyear||''s4' "lable",'���۾����Է�����S4��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ȥ����' "fieldId",'ȥ����' "lable",'ȥ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022һ����' "fieldId",'planyear+1||''һ����' "lable",'2022һ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022������' "fieldId",'planyear+1||''������' "lable",'2022������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022������' "fieldId",'planyear+1||''������' "lable",'2022������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022�ļ���' "fieldId",'planyear+1||''�ļ���' "lable",'2022�ļ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023һ����' "fieldId",'planyear+2||''һ����' "lable",'2023һ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023������' "fieldId",'planyear+2||''������' "lable",'2023������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023������' "fieldId",'planyear+2||''������' "lable",'2023������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023�ļ���' "fieldId",'planyear+2||''�ļ���' "lable",'2023�ļ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024һ����' "fieldId",'planyear+3||''һ����' "lable",'2024һ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024������' "fieldId",'planyear+3||''������' "lable",'2024������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024������' "fieldId",'planyear+3||''������' "lable",'2024������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024�ļ���' "fieldId",'planyear+3||''�ļ���' "lable",'2024�ļ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025һ����' "fieldId",'planyear+4||''һ����' "lable",'2025һ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025������' "fieldId",'planyear+4||''������' "lable",'2025������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025������' "fieldId",'planyear+4||''������' "lable",'2025������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    1 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2025�ļ���' "fieldId",'planyear+4||''�ļ���' "lable",'2025�ļ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---�ڶ���
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���' "fieldId",'���' "lable",'a���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ���ܿ��ۻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����' "fieldId",'a����' "lable",'a����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ���ܿ��ۻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���' "fieldId",'a���' "lable",'a���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ���ܿ��ۻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ���ܿ��ۻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���1' "fieldId",'���' "lable",'a���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ȡԤ���ܻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����1' "fieldId",'����' "lable",'a����1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ȡԤ���ܻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���1' "fieldId",'���' "lable",'a���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ȡԤ���ܻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���1' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ȡԤ���ܻ�ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���2' "fieldId",'���' "lable",'a���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�����������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����2' "fieldId",'����' "lable",'a����2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�����������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���2' "fieldId",'���' "lable",'a���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�����������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���2' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�����������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���3' "fieldId",'���' "lable",'a���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����3' "fieldId",'����' "lable",'a����3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���3' "fieldId",'���' "lable",'a���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���3' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȫ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���4' "fieldId",'���' "lable",'a���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����4' "fieldId",'����' "lable",'a����4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���4' "fieldId",'���' "lable",'a���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���4' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���5' "fieldId",'���' "lable",'a���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�깩���ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����5' "fieldId",'����' "lable",'a����5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�깩���ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���5' "fieldId",'���' "lable",'a���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�깩���ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���5' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�깩���ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���6' "fieldId",'���' "lable",'a���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�����ۼƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a����6' "fieldId",'����' "lable",'a����6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�����ۼƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'a���6' "fieldId",'���' "lable",'a���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�����ۼƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ƽ�׵���6' "fieldId",'ƽ�׵���' "lable",'ƽ�׵���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�����ۼƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ' "fieldId",'��Ӧ' "lable",'��Ӧ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����' "fieldId",'����' "lable",'����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ1' "fieldId",'��Ӧ' "lable",'��Ӧ1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ڶ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����1' "fieldId",'����' "lable",'����1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ڶ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ2' "fieldId",'��Ӧ' "lable",'��Ӧ2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����2' "fieldId",'����' "lable",'����2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ3' "fieldId",'��Ӧ' "lable",'��Ӧ3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ĸ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����3' "fieldId",'����' "lable",'����3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ĸ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ4' "fieldId",'��Ӧ' "lable",'��Ӧ4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����4' "fieldId",'����' "lable",'����4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ5' "fieldId",'��Ӧ' "lable",'��Ӧ5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����5' "fieldId",'����' "lable",'����5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ6' "fieldId",'��Ӧ' "lable",'��Ӧ6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���߸���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����6' "fieldId",'����' "lable",'����6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���߸���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ7' "fieldId",'��Ӧ' "lable",'��Ӧ7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ڰ˸���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����7' "fieldId",'����' "lable",'����7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ڰ˸���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ8' "fieldId",'��Ӧ' "lable",'��Ӧ8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ھŸ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����8' "fieldId",'����' "lable",'����8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'�ھŸ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ9' "fieldId",'��Ӧ' "lable",'��Ӧ9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����9' "fieldId",'����' "lable",'����9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ10' "fieldId",'��Ӧ' "lable",'��Ӧ10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮһ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����10' "fieldId",'����' "lable",'����10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮһ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��Ӧ11' "fieldId",'��Ӧ' "lable",'��Ӧ11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮ������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����11' "fieldId",'����' "lable",'����11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��ʮ������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---s1~s4
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�ٷֱ�' "fieldId",'%' "lable",'�ٷֱ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȥ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������' "fieldId",'����' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ1' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������1' "fieldId",'����' "lable",'��������1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ2' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������2' "fieldId",'����' "lable",'��������2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ3' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������3' "fieldId",'����' "lable",'��������3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ4' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������4' "fieldId",'����' "lable",'��������4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ5' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������5' "fieldId",'����' "lable",'��������5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ6' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������6' "fieldId",'����' "lable",'��������6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ7' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������7' "fieldId",'����' "lable",'��������7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2023�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ8' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������8' "fieldId",'����' "lable",'��������8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ9' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������9' "fieldId",'����' "lable",'��������9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ10' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������10' "fieldId",'����' "lable",'��������10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ11' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������11' "fieldId",'����' "lable",'��������11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2024�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ12' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������12' "fieldId",'����' "lable",'��������12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025һ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ13' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������13' "fieldId",'����' "lable",'��������13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ14' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������14' "fieldId",'����' "lable",'��������14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���ȹ�Ӧ15' "fieldId",'��Ӧ' "lable",'���ȹ�Ӧ15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    2 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��������15' "fieldId",'����' "lable",'��������15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2025�ļ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---������
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_area' "fieldId",'��O' "lable",'saleable_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_number' "fieldId",'��' "lable",'saleable_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_amount' "fieldId",'��Ԫ' "lable",'saleable_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'saleable_price' "fieldId",'Ԫ/�O' "lable",'saleable_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_area' "fieldId",'��O' "lable",'tired_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_number' "fieldId",'��' "lable",'tired_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_amount' "fieldId",'��Ԫ' "lable",'tired_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_sale_price' "fieldId",'Ԫ/�O' "lable",'tired_sale_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_area' "fieldId",'��O' "lable",'tired_complete_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_number' "fieldId",'��' "lable",'tired_complete_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_amount' "fieldId",'��Ԫ' "lable",'tired_complete_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'tired_complete_price' "fieldId",'Ԫ/�O' "lable",'tired_complete_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_area' "fieldId",'��O' "lable",'stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_number' "fieldId",'��' "lable",'stock_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_amount' "fieldId",'��Ԫ' "lable",'stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'stock_price' "fieldId",'Ԫ/�O' "lable",'stock_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_area' "fieldId",'��O' "lable",'sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_sleeve' "fieldId",'��' "lable",'sale_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_amount' "fieldId",'��Ԫ' "lable",'sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sale_price' "fieldId",'Ԫ/�O' "lable",'sale_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_area' "fieldId",'��O' "lable",'supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_sleeve' "fieldId",'��' "lable",'supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_amount' "fieldId",'��Ԫ' "lable",'supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_price' "fieldId",'Ԫ/�O' "lable",'supply_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_area' "fieldId",'��O' "lable",'sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_sleeve' "fieldId",'��' "lable",'sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a����6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_amount' "fieldId",'��Ԫ' "lable",'sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'a���6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_price' "fieldId",'Ԫ/�O' "lable",'sales_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ƽ������6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���' "fieldId",'���' "lable",'���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����' "fieldId",'����' "lable",'����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���' "fieldId",'���' "lable",'���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���1' "fieldId",'���' "lable",'���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����1' "fieldId",'����' "lable",'����1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���1' "fieldId",'���' "lable",'���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���2' "fieldId",'���' "lable",'���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����2' "fieldId",'����' "lable",'����2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���2' "fieldId",'���2' "lable",'���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���3' "fieldId",'���' "lable",'���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����3' "fieldId",'����' "lable",'����3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���3' "fieldId",'���' "lable",'���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���4' "fieldId",'���' "lable",'���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����4' "fieldId",'����' "lable",'����4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���4' "fieldId",'���' "lable",'���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���5' "fieldId",'���' "lable",'���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����5' "fieldId",'����' "lable",'����5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���5' "fieldId",'���' "lable",'���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���6' "fieldId",'���' "lable",'���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����6' "fieldId",'����' "lable",'����6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���6' "fieldId",'���' "lable",'���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���7' "fieldId",'���' "lable",'���7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����7' "fieldId",'����' "lable",'����7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���7' "fieldId",'���' "lable",'���7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���8' "fieldId",'���' "lable",'���8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����8' "fieldId",'����' "lable",'����8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���8' "fieldId",'���' "lable",'���8' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���9' "fieldId",'���' "lable",'���9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����9' "fieldId",'����' "lable",'����9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���9' "fieldId",'���' "lable",'���9' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���10' "fieldId",'���' "lable",'���10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����10' "fieldId",'����' "lable",'����10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���10' "fieldId",'���' "lable",'���10' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���11' "fieldId",'���' "lable",'���11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����11' "fieldId",'����' "lable",'����11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���11' "fieldId",'���' "lable",'���11' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���12' "fieldId",'���' "lable",'���12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����12' "fieldId",'����' "lable",'����12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���12' "fieldId",'���' "lable",'���12' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���13' "fieldId",'���' "lable",'���13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����13' "fieldId",'����' "lable",'����13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���13' "fieldId",'���' "lable",'���13' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���14' "fieldId",'���' "lable",'���14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����14' "fieldId",'����' "lable",'����14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���14' "fieldId",'���' "lable",'���14' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���15' "fieldId",'���' "lable",'���15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����15' "fieldId",'����' "lable",'����15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���15' "fieldId",'���' "lable",'���15' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���16' "fieldId",'���' "lable",'���16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����16' "fieldId",'����' "lable",'����16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���16' "fieldId",'���' "lable",'���16' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���17' "fieldId",'���' "lable",'���17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����17' "fieldId",'����' "lable",'����17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���17' "fieldId",'���' "lable",'���17' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���18' "fieldId",'���' "lable",'���18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����18' "fieldId",'����' "lable",'����18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���18' "fieldId",'���' "lable",'���18' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���19' "fieldId",'���' "lable",'���19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����19' "fieldId",'����' "lable",'����19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���19' "fieldId",'���' "lable",'���19' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���20' "fieldId",'���' "lable",'���20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����20' "fieldId",'����' "lable",'����20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���20' "fieldId",'���' "lable",'���20' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���21' "fieldId",'���' "lable",'���21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����21' "fieldId",'����' "lable",'����21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���21' "fieldId",'���' "lable",'���21' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���22' "fieldId",'���' "lable",'���22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����22' "fieldId",'����' "lable",'����22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���22' "fieldId",'���' "lable",'���22' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��Ӧ11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���23' "fieldId",'���' "lable",'���23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����23' "fieldId",'����' "lable",'����23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���23' "fieldId",'���' "lable",'���23' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
--s1
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���' "fieldId",'���' "lable",'���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��' "fieldId",'ռ��' "lable",'ռ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���1' "fieldId",'���' "lable",'���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��1' "fieldId",'ռ��' "lable",'ռ��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���2' "fieldId",'���' "lable",'���2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��2' "fieldId",'ռ��' "lable",'ռ��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���3' "fieldId",'���' "lable",'���3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��3' "fieldId",'ռ��' "lable",'ռ��3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���4' "fieldId",'���' "lable",'���4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��4' "fieldId",'ռ��' "lable",'ռ��4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���5' "fieldId",'���' "lable",'���5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��5' "fieldId",'ռ��' "lable",'ռ��5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���6' "fieldId",'���' "lable",'���6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��6' "fieldId",'ռ��' "lable",'ռ��6' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���7' "fieldId",'���' "lable",'���7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ռ��7' "fieldId",'ռ��' "lable",'ռ��7' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���24' "fieldId",'���' "lable",'���24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����24' "fieldId",'����' "lable",'����24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���24' "fieldId",'���' "lable",'���24' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���25' "fieldId",'���' "lable",'���25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����25' "fieldId",'����' "lable",'����25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���25' "fieldId",'���' "lable",'���25' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���26' "fieldId",'���' "lable",'���26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����26' "fieldId",'����' "lable",'����26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���26' "fieldId",'���' "lable",'���26' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���27' "fieldId",'���' "lable",'���27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����27' "fieldId",'����' "lable",'����27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���27' "fieldId",'���' "lable",'���27' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���28' "fieldId",'���' "lable",'���28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����28' "fieldId",'����' "lable",'����28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���28' "fieldId",'���' "lable",'���28' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���29' "fieldId",'���' "lable",'���29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����29' "fieldId",'����' "lable",'����29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���29' "fieldId",'���' "lable",'���29' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���30' "fieldId",'���' "lable",'���30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����30' "fieldId",'����' "lable",'����30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���30' "fieldId",'���' "lable",'���30' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���31' "fieldId",'���' "lable",'���31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����31' "fieldId",'����' "lable",'����31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���31' "fieldId",'���' "lable",'���31' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���32' "fieldId",'���' "lable",'���32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����32' "fieldId",'����' "lable",'����32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���32' "fieldId",'���' "lable",'���32' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���33' "fieldId",'���' "lable",'���33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����33' "fieldId",'����' "lable",'����33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���33' "fieldId",'���' "lable",'���33' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���34' "fieldId",'���' "lable",'���34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����34' "fieldId",'����' "lable",'����34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���34' "fieldId",'���' "lable",'���34' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���35' "fieldId",'���' "lable",'���35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����35' "fieldId",'����' "lable",'����35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���35' "fieldId",'���' "lable",'���35' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���36' "fieldId",'���' "lable",'���36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����36' "fieldId",'����' "lable",'����36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���36' "fieldId",'���' "lable",'���36' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���37' "fieldId",'���' "lable",'���37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����37' "fieldId",'����' "lable",'����37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���37' "fieldId",'���' "lable",'���37' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���38' "fieldId",'���' "lable",'���38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����38' "fieldId",'����' "lable",'����38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���38' "fieldId",'���' "lable",'���38' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���39' "fieldId",'���' "lable",'���39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����39' "fieldId",'����' "lable",'����39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���39' "fieldId",'���' "lable",'���39' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���40' "fieldId",'���' "lable",'���40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����40' "fieldId",'����' "lable",'����40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���40' "fieldId",'���' "lable",'���40' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���41' "fieldId",'���' "lable",'���41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����41' "fieldId",'����' "lable",'����41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���41' "fieldId",'���' "lable",'���41' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���42' "fieldId",'���' "lable",'���42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����42' "fieldId",'����' "lable",'����42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���42' "fieldId",'���' "lable",'���42' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���43' "fieldId",'���' "lable",'���43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����43' "fieldId",'����' "lable",'����43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���43' "fieldId",'���' "lable",'���43' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���44' "fieldId",'���' "lable",'���44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����44' "fieldId",'����' "lable",'����44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���44' "fieldId",'���' "lable",'���44' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���45' "fieldId",'���' "lable",'���45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����45' "fieldId",'����' "lable",'����45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���45' "fieldId",'���' "lable",'���45' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���46' "fieldId",'���' "lable",'���46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����46' "fieldId",'����' "lable",'����46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���46' "fieldId",'���' "lable",'���46' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���47' "fieldId",'���' "lable",'���47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����47' "fieldId",'����' "lable",'����47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���47' "fieldId",'���' "lable",'���47' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���48' "fieldId",'���' "lable",'���48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����48' "fieldId",'����' "lable",'����48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���48' "fieldId",'���' "lable",'���48' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���49' "fieldId",'���' "lable",'���49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����49' "fieldId",'����' "lable",'����49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���49' "fieldId",'���' "lable",'���49' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���50' "fieldId",'���' "lable",'���50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����50' "fieldId",'����' "lable",'����50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���50' "fieldId",'���' "lable",'���50' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���51' "fieldId",'���' "lable",'���51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����51' "fieldId",'����' "lable",'����51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���51' "fieldId",'���' "lable",'���51' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���52' "fieldId",'���' "lable",'���52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����52' "fieldId",'����' "lable",'����52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���52' "fieldId",'���' "lable",'���52' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���53' "fieldId",'���' "lable",'���53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����53' "fieldId",'����' "lable",'����53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���53' "fieldId",'���' "lable",'���53' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���54' "fieldId",'���' "lable",'���54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����54' "fieldId",'����' "lable",'����54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���54' "fieldId",'���' "lable",'���54' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���55' "fieldId",'���' "lable",'���55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����55' "fieldId",'����' "lable",'����55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    3 "fieldLevel",0 "isHide",0 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '���55' "fieldId",'���' "lable",'���55' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

---���Ĳ�
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_area' "fieldId",'��O' "lable",'jan_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_sleeve' "fieldId",'��' "lable",'jan_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_supply_amount' "fieldId",'��Ԫ' "lable",'jan_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_area' "fieldId",'��O' "lable",'jan_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_sleeve' "fieldId",'��' "lable",'jan_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'jan_sales_amount' "fieldId",'��Ԫ' "lable",'jan_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_area' "fieldId",'��O' "lable",'feb_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_sleeve' "fieldId",'��' "lable",'feb_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_supply_amount' "fieldId",'��Ԫ' "lable",'feb_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_area' "fieldId",'��O' "lable",'feb_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_sleeve' "fieldId",'��' "lable",'feb_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'feb_sales_amount' "fieldId",'��Ԫ' "lable",'feb_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_area' "fieldId",'��O' "lable",'mar_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_sleeve' "fieldId",'��' "lable",'mar_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_supply_amount' "fieldId",'��Ԫ' "lable",'mar_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_area' "fieldId",'��O' "lable",'mar_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_sleeve' "fieldId",'��' "lable",'mar_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'mar_sales_amount' "fieldId",'��Ԫ' "lable",'mar_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_area' "fieldId",'��O' "lable",'apr_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_sleeve' "fieldId",'��' "lable",'apr_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_supply_amount' "fieldId",'��Ԫ' "lable",'apr_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_area' "fieldId",'��O' "lable",'apr_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_sleeve' "fieldId",'��' "lable",'apr_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'apr_sales_amount' "fieldId",'��Ԫ' "lable",'apr_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_area' "fieldId",'��O' "lable",'may_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_sleeve' "fieldId",'��' "lable",'may_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_supply_amount' "fieldId",'��Ԫ' "lable",'may_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���8' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_area' "fieldId",'��O' "lable",'may_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_sleeve' "fieldId",'��' "lable",'may_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'may_sales_amount' "fieldId",'��Ԫ' "lable",'may_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���9' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_area' "fieldId",'��O' "lable",'june_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_sleeve' "fieldId",'��' "lable",'june_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_supply_amount' "fieldId",'��Ԫ' "lable",'june_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���10' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_area' "fieldId",'��O' "lable",'june_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_sleeve' "fieldId",'��' "lable",'june_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'june_sales_amount' "fieldId",'��Ԫ' "lable",'june_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���11' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_area' "fieldId",'��O' "lable",'july_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_sleeve' "fieldId",'��' "lable",'july_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_supply_amount' "fieldId",'��Ԫ' "lable",'july_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���12' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_area' "fieldId",'��O' "lable",'july_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_sleeve' "fieldId",'��' "lable",'july_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'july_sales_amount' "fieldId",'��Ԫ' "lable",'july_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���13' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_area' "fieldId",'��O' "lable",'aug_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_sleeve' "fieldId",'��' "lable",'aug_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_supply_amount' "fieldId",'��Ԫ' "lable",'aug_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���14' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_area' "fieldId",'��O' "lable",'aug_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_sleeve' "fieldId",'��' "lable",'aug_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'aug_sales_amount' "fieldId",'��Ԫ' "lable",'aug_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���15' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_area' "fieldId",'��O' "lable",'sep_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_sleeve' "fieldId",'��' "lable",'sep_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_supply_amount' "fieldId",'��Ԫ' "lable",'sep_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���16' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_area' "fieldId",'��O' "lable",'sep_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_sleeve' "fieldId",'��' "lable",'sep_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sep_sales_amount' "fieldId",'��Ԫ' "lable",'sep_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���17' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_area' "fieldId",'��O' "lable",'oct_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_sleeve' "fieldId",'��' "lable",'oct_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_supply_amount' "fieldId",'��Ԫ' "lable",'oct_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���18' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_area' "fieldId",'��O' "lable",'oct_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_sleeve' "fieldId",'��' "lable",'oct_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'oct_sales_amount' "fieldId",'��Ԫ' "lable",'oct_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���19' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_area' "fieldId",'��O' "lable",'nov_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_sleeve' "fieldId",'��' "lable",'nov_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_supply_amount' "fieldId",'��Ԫ' "lable",'nov_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���20' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_area' "fieldId",'��O' "lable",'nov_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_sleeve' "fieldId",'��' "lable",'nov_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nov_sales_amount' "fieldId",'��Ԫ' "lable",'nov_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���21' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_area' "fieldId",'��O' "lable",'dec_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_sleeve' "fieldId",'��' "lable",'dec_supply_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_supply_amount' "fieldId",'��Ԫ' "lable",'dec_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���22' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_area' "fieldId",'��O' "lable",'dec_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_sleeve' "fieldId",'��' "lable",'dec_sales_sleeve' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'����23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'dec_sales_amount' "fieldId",'��Ԫ' "lable",'dec_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���23' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_one_amount' "fieldId",'��Ԫ' "lable",'supply_one_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_one_ratio' "fieldId",'%' "lable",'supply_one_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_two_amount' "fieldId",'��Ԫ' "lable",'supply_two_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_two_ratio' "fieldId",'%' "lable",'supply_two_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_three_amount' "fieldId",'��Ԫ' "lable",'supply_three_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_three_ratio' "fieldId",'%' "lable",'supply_three_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_four_amount' "fieldId",'��Ԫ' "lable",'supply_four_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'supply_four_ratio' "fieldId",'%' "lable",'supply_four_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_one_amount' "fieldId",'��Ԫ' "lable",'sales_one_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_one_ratio' "fieldId",'%' "lable",'sales_one_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_two_amount' "fieldId",'��Ԫ' "lable",'sales_two_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_two_ratio' "fieldId",'%' "lable",'sales_two_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_three_amount' "fieldId",'��Ԫ' "lable",'sales_three_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_three_ratio' "fieldId",'%' "lable",'sales_three_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��6' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_four_amount' "fieldId",'��Ԫ' "lable",'sales_four_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'sales_four_ratio' "fieldId",'%' "lable",'sales_four_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ռ��7' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'desalination_rate' "fieldId",'%' "lable",'desalination_rate' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'ȥ����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all

SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_area' "fieldId",'��O' "lable",'ny_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_number' "fieldId",'��' "lable",'ny_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_supply_amount' "fieldId",'��Ԫ' "lable",'ny_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_area' "fieldId",'��O' "lable",'ny_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_number' "fieldId",'��' "lable",'ny_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_first_sale_amount' "fieldId",'��Ԫ' "lable",'ny_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_area' "fieldId",'��O' "lable",'ny_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_number' "fieldId",'��' "lable",'ny_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_supply_amount' "fieldId",'��Ԫ' "lable",'ny_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_area' "fieldId",'��O' "lable",'ny_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_number' "fieldId",'��' "lable",'ny_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_second_sale_amount' "fieldId",'��Ԫ' "lable",'ny_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_area' "fieldId",'��O' "lable",'ny_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_number' "fieldId",'��' "lable",'ny_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_supply_amount' "fieldId",'��Ԫ' "lable",'ny_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_area' "fieldId",'��O' "lable",'ny_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_number' "fieldId",'��' "lable",'ny_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_third_sale_amount' "fieldId",'��Ԫ' "lable",'ny_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_area' "fieldId",'��O' "lable",'ny_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_number' "fieldId",'��' "lable",'ny_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_supply_amount' "fieldId",'��Ԫ' "lable",'ny_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_area' "fieldId",'��O' "lable",'ny_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_number' "fieldId",'��' "lable",'ny_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ny_fourth_sale_amount' "fieldId",'��Ԫ' "lable",'ny_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_area' "fieldId",'��O' "lable",'ncy_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_number' "fieldId",'��' "lable",'ncy_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_supply_amount' "fieldId",'��Ԫ' "lable",'ncy_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_area' "fieldId",'��O' "lable",'ncy_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_number' "fieldId",'��' "lable",'ncy_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_first_sale_amount' "fieldId",'��Ԫ' "lable",'ncy_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_area' "fieldId",'��O' "lable",'ncy_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_number' "fieldId",'��' "lable",'ncy_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_supply_amount' "fieldId",'��Ԫ' "lable",'ncy_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_area' "fieldId",'��O' "lable",'ncy_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_number' "fieldId",'��' "lable",'ncy_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_second_sale_amount' "fieldId",'��Ԫ' "lable",'ncy_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_area' "fieldId",'��O' "lable",'ncy_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_number' "fieldId",'��' "lable",'ncy_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_supply_amount' "fieldId",'��Ԫ' "lable",'ncy_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_area' "fieldId",'��O' "lable",'ncy_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_number' "fieldId",'��' "lable",'ncy_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_third_sale_amount' "fieldId",'��Ԫ' "lable",'ncy_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_area' "fieldId",'��O' "lable",'ncy_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_number' "fieldId",'��' "lable",'ncy_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_supply_amount' "fieldId",'��Ԫ' "lable",'ncy_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_area' "fieldId",'��O' "lable",'ncy_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_number' "fieldId",'��' "lable",'ncy_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ncy_fourth_sale_amount' "fieldId",'��Ԫ' "lable",'ncy_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_area' "fieldId",'��O' "lable",'nty_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_number' "fieldId",'��' "lable",'nty_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_supply_amount' "fieldId",'��Ԫ' "lable",'nty_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_area' "fieldId",'��O' "lable",'nty_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_number' "fieldId",'��' "lable",'nty_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_first_sale_amount' "fieldId",'��Ԫ' "lable",'nty_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_area' "fieldId",'��O' "lable",'nty_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_number' "fieldId",'��' "lable",'nty_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_supply_amount' "fieldId",'��Ԫ' "lable",'nty_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_area' "fieldId",'��O' "lable",'nty_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_number' "fieldId",'��' "lable",'nty_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_second_sale_amount' "fieldId",'��Ԫ' "lable",'nty_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_area' "fieldId",'��O' "lable",'nty_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_number' "fieldId",'��' "lable",'nty_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_supply_amount' "fieldId",'��Ԫ' "lable",'nty_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_area' "fieldId",'��O' "lable",'nty_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_number' "fieldId",'��' "lable",'nty_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_third_sale_amount' "fieldId",'��Ԫ' "lable",'nty_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_area' "fieldId",'��O' "lable",'nty_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_number' "fieldId",'��' "lable",'nty_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_supply_amount' "fieldId",'��Ԫ' "lable",'nty_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_area' "fieldId",'��O' "lable",'nty_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_number' "fieldId",'��' "lable",'nty_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nty_fourth_sale_amount' "fieldId",'��Ԫ' "lable",'nty_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_area' "fieldId",'��O' "lable",'nfy_first_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_number' "fieldId",'��' "lable",'nfy_first_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_supply_amount' "fieldId",'��Ԫ' "lable",'nfy_first_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_area' "fieldId",'��O' "lable",'nfy_first_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_number' "fieldId",'��' "lable",'nfy_first_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_first_sale_amount' "fieldId",'��Ԫ' "lable",'nfy_first_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_area' "fieldId",'��O' "lable",'nfy_second_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_number' "fieldId",'��' "lable",'nfy_second_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_supply_amount' "fieldId",'��Ԫ' "lable",'nfy_second_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_area' "fieldId",'��O' "lable",'nfy_second_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_number' "fieldId",'��' "lable",'nfy_second_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_second_sale_amount' "fieldId",'��Ԫ' "lable",'nfy_second_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_area' "fieldId",'��O' "lable",'nfy_third_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_number' "fieldId",'��' "lable",'nfy_third_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_supply_amount' "fieldId",'��Ԫ' "lable",'nfy_third_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_area' "fieldId",'��O' "lable",'nfy_third_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_number' "fieldId",'��' "lable",'nfy_third_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_third_sale_amount' "fieldId",'��Ԫ' "lable",'nfy_third_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_area' "fieldId",'��O' "lable",'nfy_fourth_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_number' "fieldId",'��' "lable",'nfy_fourth_supply_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_supply_amount' "fieldId",'��Ԫ' "lable",'nfy_fourth_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ȹ�Ӧ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_area' "fieldId",'��O' "lable",'nfy_fourth_sale_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_number' "fieldId",'��' "lable",'nfy_fourth_sale_number' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT    4 "fieldLevel",0 "isHide",1 "isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'nfy_fourth_sale_amount' "fieldId",'��Ԫ' "lable",'nfy_fourth_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;