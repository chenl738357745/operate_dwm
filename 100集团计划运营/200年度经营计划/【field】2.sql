delete opm_excel_filed where sheet_id='groupsheet2' and EXCEL_TYPE='�ܱ�';
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
SELECT 'groupsheet2' "sheetID",resultdata.*,'�ܱ�' from (
---�����
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet2ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�㼶' "fieldId",'�㼶' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
Union All
---��һ��
SELECT  1 "fieldLevel",1 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet2���id' "fieldId",'���' "lable",'groupsheet2���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����/��Ŀ����' "fieldId",'����/��Ŀ����' "lable",'OBJECT_NAME' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021�꼯�ţ����򣩶�̬�ֽ���' "fieldId",'{currentYear}�꼯�ţ����򣩶�̬�ֽ���' "lable",'2021�꼯�ţ����򣩶�̬�ֽ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",0 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---�ڶ���
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '����2021���' "fieldId",'����{currentYear_MinusOne}���' "lable",'����2021���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022���ʽ���Դ�ƻ�' "fieldId",'{currentYear}���ʽ���Դ�ƻ�' "lable",'2022���ʽ���Դ�ƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022���ʽ����üƻ�' "fieldId",'{currentYear}���ʽ����üƻ�' "lable",'2022���ʽ����üƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022�굱���ֽ������չʾ��' "fieldId",'{currentYear}�굱���ֽ������չʾ��' "lable",'2022�굱���ֽ������չʾ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2021�꼯�ţ����򣩶�̬�ֽ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---������
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021���-��ĩ�ʽ����' "fieldId",'2021���-��ĩ�ʽ����' "lable",'���-��ĩ�ʽ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'����2021���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���ۻؿ�' "fieldId",'���ۻؿ�' "lable",'���ۻؿ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�������' "fieldId",'�������' "lable",'�������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",310 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'��������' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",410 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���տ�' "fieldId",'���տ�' "lable",'���տ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",510 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ɶ�Ͷ��' "fieldId",'�ɶ�Ͷ��' "lable",'�ɶ�Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",610 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����Ͷ��' "fieldId",'����Ͷ��' "lable",'����Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����Ͷ��' "fieldId",'����Ͷ��' "lable",'����Ͷ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",810 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ʽ���Դ�ϼ�' "fieldId",'�ʽ���Դ�ϼ�' "lable",'�ʽ���Դ�ϼ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",910 "fieldOrder",'2022���ʽ���Դ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���ط���' "fieldId",'���ط���' "lable",'���ط���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1010 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'������֧��' "fieldId",'������֧��' "lable",'������֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1110 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'������ӷ�' "fieldId",'������ӷ�' "lable",'������ӷ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1210 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ڼ����' "fieldId",'�ڼ����' "lable",'�ڼ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1310 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'˰��' "fieldId",'˰��' "lable",'˰��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1410 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'������' "fieldId",'������' "lable",'������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1510 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����֧��' "fieldId",'����֧��' "lable",'����֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1610 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����֧��' "fieldId",'����֧��' "lable",'����֧��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1710 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ʽ�����С��' "fieldId",'�ʽ�����С��' "lable",'�ʽ�����С��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1810 "fieldOrder",'2022���ʽ����üƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ʽ�����' "fieldId",'�ʽ�����' "lable",'�ʽ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1910 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'չʾ��-��ĩ�ʽ����' "fieldId",'��ĩ�ʽ����' "lable",'չʾ��-��ĩ�ʽ����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2010 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�ɶ����ʽ�' "fieldId",'�ɶ����ʽ�' "lable",'�ɶ����ʽ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2110 "fieldOrder",'2022�굱���ֽ������չʾ��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;
