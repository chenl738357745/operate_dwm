create or replace PROCEDURE "P_OPM_INIT" (planyear IN number
--�ƻ���
) AS-- �����ʼ�����е�����
-- ע�⣺��ʼ���ṹ˳�򼰹�ʽ������ֵ�������ύ�����
--���ߣ� chenl--���ڣ� 2021/08/24 FIELDSINFO SYS_REFCURSOR;
plan_year   VARCHAR2(500):=(case when planyear is null or planyear='' then  to_char(sysdate, 'yyyy' ) else planyear end); 
BEGIN 
-----------------------------------���ż�
  
-----------------------------------����
  begin
  P_OPM_INIT_REGION(
    PLANYEAR => plan_year,
    REGIONCOMPANYID => null
  );
  end;
-----------------------------------��Ŀ��
 
-----------------------------------
END P_OPM_INIT;

