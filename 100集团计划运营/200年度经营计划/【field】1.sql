delete opm_excel_filed where sheet_id='groupsheet1' and EXCEL_TYPE='�ܱ�';
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
SELECT 'groupsheet1' "sheetID",resultdata.*,'�ܱ�' from (
---�����
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet1ParentId' "fieldId",'parentid' "lable",'PARENT_ID' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9998 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�㼶' "fieldId",'�㼶' "lable",'LEVEL_CODE' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9999 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---��һ��
SELECT  1 "fieldLevel",1 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'id' "fieldId",'id' "lable",'id' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",1 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'groupsheet1���id' "fieldId",'���' "lable",'groupsheet1���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",2 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����/��Ŀ����' "fieldId",'����/��Ŀ����' "lable",'object_name' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",3 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'railway_bool' "fieldId",'�Ƿ񲢱��й�������' "lable",'railway_bool' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",4 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'estate_bool' "fieldId",'�Ƿ񲢱��ز����ţ�' "lable",'estate_bool' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'estate_ratio' "fieldId",'�ز�������ռ��Ȩ����' "lable",'estate_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",6 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'railway_ratio' "fieldId",'�й�������ռ��Ȩ����' "lable",'railway_ratio' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",7 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'build_land_area' "fieldId",'�����õ����������淽��ָ�꣩' "lable",'build_land_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",8 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'surface_total_area' "fieldId",'�ܽ������' "lable",'surface_total_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",9 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����' "fieldId",'����' "lable",'����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'construction_stage' "fieldId",'����׶Σ�����/�ڽ���δ������' "lable",'construction_stage' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",10 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_investment' "fieldId",'��Ͷ��' "lable",'total_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",11 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_saleable_area' "fieldId",'�ܿ������' "lable",'total_saleable_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",12 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'total_value' "fieldId",'�ܻ�ֵ' "lable",'total_value' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",13 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'��������' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'������ƻ�' "fieldId",'������ƻ�' "lable",'������ƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���ۻؿ�' "fieldId",'���ۻؿ�' "lable",'���ۻؿ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'Ͷ�ʡ��ʽ�ƻ�' "fieldId",'Ͷ�ʡ��ʽ�ƻ�' "lable",'Ͷ�ʡ��ʽ�ƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  1 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'��������' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",5 "fieldOrder",'' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---�ڶ���
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'above_ground_area' "fieldId",'���Ͻ����������ƽ���ף�' "lable",'above_ground_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",14 "fieldOrder",'����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",14 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021�굱��' "fieldId",'planyear||''�굱��' "lable",'2021�굱��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2021�꿪��' "fieldId",'����''||to_char(planyear)||''����' "lable",'��ֹ2021�꿪��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022�굱��' "fieldId",'planyear+1||''�굱��' "lable",'2022�굱��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��1' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��2' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021��Ԥ�����' "fieldId",'planyear||''��Ԥ�����' "lable",'2021��Ԥ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2021�꿪��1' "fieldId",'����''||to_char(planyear)||''����' "lable",'��ֹ2021�꿪��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022��Ԥ�����' "fieldId",'planyear+1||''��Ԥ�����' "lable",'2022��Ԥ�����' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2022�꿪��' "fieldId",'����''||to_char(planyear+1)||''����' "lable",'��ֹ2022�꿪��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'������ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��3' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ۻؿ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021�굱��1' "fieldId",'planyear||''�굱��' "lable",'2021�굱��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ۻؿ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2021�꿪��2' "fieldId",'����''||to_char(planyear)||''����' "lable",'��ֹ2021�꿪��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ۻؿ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022�굱��1' "fieldId",'planyear+1||''�굱��' "lable",'2022�굱��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ۻؿ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2022�꿪��1' "fieldId",'����''||to_char(planyear+1)||''����' "lable",'��ֹ2022�꿪��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'���ۻؿ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��4' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'Ͷ�ʡ��ʽ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021�굱��2' "fieldId",'planyear||''�굱��' "lable",'2021�굱��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'Ͷ�ʡ��ʽ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2021�꿪��3' "fieldId",'����''||to_char(planyear)||''����' "lable",'��ֹ2021�꿪��3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'Ͷ�ʡ��ʽ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022�굱��2' "fieldId",'planyear+1||''�굱��' "lable",'2022�굱��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'Ͷ�ʡ��ʽ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2022�꿪��2' "fieldId",'����''||to_char(planyear+1)||''����' "lable",'��ֹ2022�꿪��2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'Ͷ�ʡ��ʽ�ƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2020�꿪��5' "fieldId",'����''||to_char(planyear-1)||''����' "lable",'��ֹ2020�꿪��5' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2021�굱��3' "fieldId",'planyear||''�굱��' "lable",'2021�굱��3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2021�꿪��4' "fieldId",'����''||to_char(planyear)||''����' "lable",'��ֹ2021�꿪��4' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '2022�굱��3' "fieldId",'planyear+1||''�굱��' "lable",'2022�굱��3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '��ֹ2022�꿪��3' "fieldId",'����''||to_char(planyear+1)||''����' "lable",'��ֹ2022�꿪��3' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", '�����ʽ����ʱ��' "fieldId",'�����ʽ����ʱ��' "lable",'�����ʽ����ʱ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",126 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'ȫͶ�ʻ���ʱ��' "fieldId",'ȫͶ�ʻ���ʱ��' "lable",'ȫͶ�ʻ���ʱ��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",127 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  2 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor", 'δ�������ֵ�ͷżƻ�' "fieldId",'δ�������ֵ�ͷżƻ�' "lable",'δ�������ֵ�ͷżƻ�' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",710 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---������
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'last_started_area' "fieldId",'�������' "lable",'last_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",17 "fieldOrder",'��ֹ2020�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'last_completed_area' "fieldId",'�������' "lable",'last_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",18 "fieldOrder",'��ֹ2020�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'this_started_area' "fieldId",'�������' "lable",'this_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",19 "fieldOrder",'2021�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'this_completed_area' "fieldId",'�������' "lable",'this_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",20 "fieldOrder",'2021�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2021��10~12�½�����Ŀ' "fieldId",'planyear||''��10~12�½�����Ŀ' "lable",'2021��10~12�½�����Ŀ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_started_area' "fieldId",'�������' "lable",'cutoff_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",23 "fieldOrder",'��ֹ2021�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_completed_area' "fieldId",'�������' "lable",'cutoff_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",24 "fieldOrder",'��ֹ2021�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_started_area' "fieldId",'�������' "lable",'next_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",25 "fieldOrder",'2022�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_completed_area' "fieldId",'�������' "lable",'next_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",26 "fieldOrder",'2022�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2022�꽻����Ŀ' "fieldId",'planyear+1||''�꽻����Ŀ' "lable",'2022�꽻����Ŀ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022�굱��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_last_started_area' "fieldId",'�������' "lable",'cutoff_last_started_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",29 "fieldOrder",'��ֹ2020�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_last_completed_area' "fieldId",'�������' "lable",'cutoff_last_completed_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",30 "fieldOrder",'��ֹ2020�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cutoff_sales_area' "fieldId",'�������' "lable",'cutoff_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",31 "fieldOrder",'��ֹ2020�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'cotoff_sales_amount' "fieldId",'���۽��' "lable",'cotoff_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",32 "fieldOrder",'��ֹ2020�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ʣ���ֵ' "fieldId",'ʣ���ֵ' "lable",'ʣ���ֵ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2020�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��������' "fieldId",'��������' "lable",'��������' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'expected_sales_area' "fieldId",'�������' "lable",'expected_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",37 "fieldOrder",'2021��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۽��' "fieldId",'���۽��' "lable",'���۽��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۹�����ȡԤ��֤�ھ���' "fieldId",'���۹�����ȡԤ��֤�ھ���' "lable",'���۹�����ȡԤ��֤�ھ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2021�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_sales_area' "fieldId",'�������' "lable",'tired_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",42 "fieldOrder",'��ֹ2021�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_sales_amount' "fieldId",'���۽��' "lable",'tired_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",43 "fieldOrder",'��ֹ2021�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ȡԤ��֤���' "fieldId",'��ȡԤ��֤���' "lable",'��ȡԤ��֤���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2021�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ʣ���ֵ1' "fieldId",'ʣ���ֵ' "lable",'ʣ���ֵ1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2021�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'����������ȡԤ��֤�ھ���' "fieldId",'����������ȡԤ��֤�ھ���' "lable",'����������ȡԤ��֤�ھ���' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_sales_area' "fieldId",'�������' "lable",'forecast_sales_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",50 "fieldOrder",'2022��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'���۽��1' "fieldId",'���۽��' "lable",'���۽��1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022��Ԥ�����' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ȡԤ��֤' "fieldId",'��ȡԤ��֤' "lable",'��ȡԤ��֤' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2022�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_cotoff_area' "fieldId",'�������' "lable",'forecast_cotoff_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",55 "fieldOrder",'��ֹ2022�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_cotoff_amount' "fieldId",'���۽��' "lable",'forecast_cotoff_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",56 "fieldOrder",'��ֹ2022�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'��ȡԤ��֤���1' "fieldId",'��ȡԤ��֤���' "lable",'��ȡԤ��֤���1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2022�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ʣ���ֵ2' "fieldId",'ʣ���ֵ' "lable",'ʣ���ֵ2' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'��ֹ2022�꿪��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_last_sale_amount' "fieldId",'���ۻؿ�' "lable",'sac_last_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",61 "fieldOrder",'��ֹ2020�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_last_unpaid_amount' "fieldId",'����δ�ؿ���' "lable",'sac_last_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",62 "fieldOrder",'��ֹ2020�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_then_sale_amount' "fieldId",'���ۻؿ�' "lable",'sac_then_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",63 "fieldOrder",'2021�굱��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_then_equity_sale' "fieldId",'Ȩ�����ۻؿ�' "lable",'sac_then_equity_sale' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",64 "fieldOrder",'2021�굱��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tried_sale_amount' "fieldId",'���ۻؿ�' "lable",'tried_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",65 "fieldOrder",'��ֹ2021�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tried_unpaid_amount' "fieldId",'����δ�ؿ���' "lable",'tried_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",66 "fieldOrder",'��ֹ2021�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_next_sale_amount' "fieldId",'���ۻؿ�' "lable",'sac_next_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",67 "fieldOrder",'2022�굱��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_next_equity_sale' "fieldId",'Ȩ�����ۻؿ�' "lable",'sac_next_equity_sale' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",68 "fieldOrder",'2022�굱��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_tried_sale_amount' "fieldId",'���ۻؿ�' "lable",'sac_tried_sale_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",69 "fieldOrder",'��ֹ2022�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'sac_tried_unpaid_amount' "fieldId",'����δ�ؿ���' "lable",'sac_tried_unpaid_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",70 "fieldOrder",'��ֹ2022�꿪��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_last_investment' "fieldId",'��Ͷ��' "lable",'inv_last_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",71 "fieldOrder",'��ֹ2020�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_actual' "fieldId",'ʵ�����Ͷ��' "lable",'inv_then_actual' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",72 "fieldOrder",'2021�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_payment' "fieldId",'ʵ��֧���ʽ�' "lable",'inv_then_payment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",73 "fieldOrder",'2021�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�����ʽ���Դ' "fieldId",'�����ʽ���Դ' "lable",'�����ʽ���Դ' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2021�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_land_price' "fieldId",'�������ؼۿ�֧���ʽ�' "lable",'inv_land_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",77 "fieldOrder",'2021�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_then_investment' "fieldId",'��Ͷ��' "lable",'inv_then_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",78 "fieldOrder",'��ֹ2021�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_plan_investment' "fieldId",'�ƻ�Ͷ��' "lable",'inv_plan_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",79 "fieldOrder",'2022�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_invest_funds' "fieldId",'�ƻ�Ͷ���ʽ�' "lable",'inv_invest_funds' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",80 "fieldOrder",'2022�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'�����ʽ���Դ1' "fieldId",'�����ʽ���Դ' "lable",'�����ʽ���Դ1' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'2022�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_land_price' "fieldId",'�������ؼۿ�֧���ʽ�' "lable",'inv_next_land_price' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",84 "fieldOrder",'2022�굱��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_investment' "fieldId",'��Ͷ��' "lable",'inv_next_investment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",85 "fieldOrder",'��ֹ2022�꿪��2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income' "fieldId",'Ӫҵ���루���ڣ�' "lable",'ltopera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",86 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income_outside' "fieldId",'Ӫҵ���루���⣩' "lable",'ltopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",87 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltopera_income_inside' "fieldId",'Ӫҵ���루����+���⣩' "lable",'ltopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",88 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'lttotal_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'lttotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",89 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_inside' "fieldId",'�����󣨱��ڣ�' "lable",'ltprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",90 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_outside' "fieldId",'�����󣨱��⣩' "lable",'ltprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",91 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_outside_equity' "fieldId",'�����󣨱���Ȩ�棩' "lable",'ltprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",92 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ltprofit_inside_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'ltprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",93 "fieldOrder",'��ֹ2020�꿪��5' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income' "fieldId",'Ӫҵ���루���ڣ�' "lable",'thopera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",94 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income_outside' "fieldId",'Ӫҵ���루���⣩' "lable",'thopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",95 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thopera_income_inside' "fieldId",'Ӫҵ���루����+���⣩' "lable",'thopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",96 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thtotal_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'thtotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",97 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_inside' "fieldId",'�����󣨱��ڣ�' "lable",'thprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",98 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_outside' "fieldId",'�����󣨱��⣩' "lable",'thprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",99 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_outside_equity' "fieldId",'�����󣨱���Ȩ�棩' "lable",'thprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",100 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'thprofit_inside_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'thprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",101 "fieldOrder",'2021�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income' "fieldId",'Ӫҵ���루���ڣ�' "lable",'end_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",102 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income_outside' "fieldId",'Ӫҵ���루���⣩' "lable",'end_opera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",103 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_opera_income_inside' "fieldId",'Ӫҵ���루����+���⣩' "lable",'end_opera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",104 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_total_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'end_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",105 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_inside' "fieldId",'�����󣨱��ڣ�' "lable",'end_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",106 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_outside' "fieldId",'�����󣨱��⣩' "lable",'end_profit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",107 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_outside_equity' "fieldId",'�����󣨱���Ȩ�棩' "lable",'end_profit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",108 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'end_profit_inside_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'end_profit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",109 "fieldOrder",'��ֹ2021�꿪��4' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_inside_equity' "fieldId",'Ӫҵ���루���ڣ�' "lable",'ntprofit_inside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",110 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntopera_income_outside' "fieldId",'Ӫҵ���루���⣩' "lable",'ntopera_income_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",111 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntopera_income_inside' "fieldId",'Ӫҵ���루����+���⣩' "lable",'ntopera_income_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",112 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'nttotal_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'nttotal_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",113 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_inside' "fieldId",'�����󣨱��ڣ�' "lable",'ntprofit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",114 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_outside' "fieldId",'�����󣨱��⣩' "lable",'ntprofit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",115 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_outside_equity' "fieldId",'�����󣨱���Ȩ�棩' "lable",'ntprofit_outside_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",116 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'ntprofit_rights_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'ntprofit_rights_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",117 "fieldOrder",'2022�굱��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income' "fieldId",'Ӫҵ���루���ڣ�' "lable",'entnt_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",118 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income_out' "fieldId",'Ӫҵ���루���⣩' "lable",'entnt_opera_income_out' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",119 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_opera_income_ins' "fieldId",'Ӫҵ���루����+���⣩' "lable",'entnt_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",120 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_total_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'entnt_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",121 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_inside' "fieldId",'�����󣨱��ڣ�' "lable",'entnt_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",122 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_outside' "fieldId",'�����󣨱��⣩' "lable",'entnt_profit_outside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",123 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_out_equity' "fieldId",'�����󣨱���Ȩ�棩' "lable",'entnt_profit_out_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",124 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'entnt_profit_ins_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'entnt_profit_ins_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",125 "fieldOrder",'��ֹ2022�꿪��3' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2023��' "fieldId",'planyear+2||''��' "lable",'2023��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'δ�������ֵ�ͷżƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  3 "fieldLevel",0 "isHide",0"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'2024��' "fieldId",'planyear+3||''��' "lable",'2024��' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",210 "fieldOrder",'δ�������ֵ�ͷżƻ�' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
---���Ĳ�
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'todec_due_time' "fieldId",'����ʱ��' "lable",'todec_due_time' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",21 "fieldOrder",'2021��10~12�½�����Ŀ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'todec_delivery_installment' "fieldId",'�������ڼ���Ӧ¥��' "lable",'todec_delivery_installment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",22 "fieldOrder",'2021��10~12�½�����Ŀ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_due_time' "fieldId",'����ʱ��' "lable",'next_due_time' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",27 "fieldOrder",'2022�꽻����Ŀ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'next_delivery_installment' "fieldId",'�������ڼ���Ӧ¥��' "lable",'next_delivery_installment' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",28 "fieldOrder",'2022�꽻����Ŀ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'remaining_value_area' "fieldId",'���' "lable",'remaining_value_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",33 "fieldOrder",'ʣ���ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'remaining_value_amount' "fieldId",'���' "lable",'remaining_value_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",34 "fieldOrder",'ʣ���ֵ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'added_supply_area' "fieldId",'���' "lable",'remaining_value_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",35 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'added_supply_amount' "fieldId",'���' "lable",'added_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",36 "fieldOrder",'��������' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'expected_sales_amount' "fieldId",'���۽��' "lable",'expected_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",38 "fieldOrder",'���۽��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'equity_sales_amount' "fieldId",'Ȩ�����۽��' "lable",'equity_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",39 "fieldOrder",'���۽��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_supply_area' "fieldId",'���' "lable",'tired_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",40 "fieldOrder",'���۹�����ȡԤ��֤�ھ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_supply_amount' "fieldId",'���' "lable",'tired_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",41 "fieldOrder",'���۹�����ȡԤ��֤�ھ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_stock_area' "fieldId",'���' "lable",'tired_stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",44 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_stock_amount' "fieldId",'���' "lable",'tired_stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",45 "fieldOrder",'��ȡԤ��֤���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_remaining_area' "fieldId",'���' "lable",'tired_remaining_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",46 "fieldOrder",'ʣ���ֵ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tired_remaining_amount' "fieldId",'���' "lable",'tired_remaining_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",47 "fieldOrder",'ʣ���ֵ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_supply_area' "fieldId",'���' "lable",'forecast_supply_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",48 "fieldOrder",'����������ȡԤ��֤�ھ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_supply_amount' "fieldId",'���' "lable",'forecast_supply_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",49 "fieldOrder",'����������ȡԤ��֤�ھ���' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_sales_amount' "fieldId",'���۽��' "lable",'forecast_sales_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",51 "fieldOrder",'���۽��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_equity_amount' "fieldId",'Ȩ�����۽��' "lable",'forecast_equity_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",52 "fieldOrder",'���۽��1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_tired_area' "fieldId",'���' "lable",'forecast_tired_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",53 "fieldOrder",'��ȡԤ��֤' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_tired_amount' "fieldId",'���' "lable",'forecast_tired_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",54 "fieldOrder",'��ȡԤ��֤' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_stock_area' "fieldId",'���' "lable",'forecast_stock_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",57 "fieldOrder",'��ȡԤ��֤���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_stock_amount' "fieldId",'���' "lable",'forecast_stock_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",58 "fieldOrder",'��ȡԤ��֤���1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_remaining_area' "fieldId",'���' "lable",'forecast_remaining_area' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",59 "fieldOrder",'ʣ���ֵ2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'forecast_remaining_amount' "fieldId",'���' "lable",'forecast_remaining_amount' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",60 "fieldOrder",'ʣ���ֵ2' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_invest_firm' "fieldId",'��ҵ�����ʽ�' "lable",'inv_invest_firm' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",74 "fieldOrder",'�����ʽ���Դ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_external_financing' "fieldId",'�ⲿ����' "lable",'inv_external_financing' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",75 "fieldOrder",'�����ʽ���Դ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_sales_collection' "fieldId",'���ۻؿ�' "lable",'inv_sales_collection' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",76 "fieldOrder",'�����ʽ���Դ' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_invest_funds' "fieldId",'��ҵ�����ʽ�' "lable",'inv_next_invest_funds' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",81 "fieldOrder",'�����ʽ���Դ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_external_finan' "fieldId",'�ⲿ����' "lable",'inv_next_external_finan' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",82 "fieldOrder",'�����ʽ���Դ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'inv_next_sales_collection' "fieldId",'���ۻؿ�' "lable",'inv_next_sales_collection' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",83 "fieldOrder",'�����ʽ���Դ1' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_opera_income' "fieldId",'Ӫҵ����' "lable",'tomar_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",128 "fieldOrder",'2023��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_opera_income_ins' "fieldId",'Ӫҵ���루���ڣ�' "lable",'tomar_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",129 "fieldOrder",'2023��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_total_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'tomar_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",130 "fieldOrder",'2023��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_profit_inside' "fieldId",'������' "lable",'tomar_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",131 "fieldOrder",'2023��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'tomar_profit_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'tomar_profit_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",132 "fieldOrder",'2023��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_opera_income' "fieldId",'Ӫҵ����' "lable",'toapr_opera_income' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",133 "fieldOrder",'2024��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_opera_income_ins' "fieldId",'Ӫҵ���루���ڣ�' "lable",'toapr_opera_income_ins' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",134 "fieldOrder",'2024��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_total_profit' "fieldId",'�����ܶȫ�ھ���' "lable",'toapr_total_profit' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",135 "fieldOrder",'2024��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_profit_inside' "fieldId",'������' "lable",'toapr_profit_inside' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",136 "fieldOrder",'2024��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
union all
SELECT  4 "fieldLevel",0 "isHide",1"isEnd",'GREY_40_PERCENT' "headerBgColor",'LIGHT_TURQUOISE' "headerFontColor",'toapr_profit_equity' "fieldId",'�����󣨱���+����Ȩ�棩' "lable",'toapr_profit_equity' "field",'auto' "width",'left' "align",'#,##0.00' "dataFormat",137 "fieldOrder",'2024��' "parentId",'left' "textAlign",1 "isColumnMerge"  From Dual
) resultdata;