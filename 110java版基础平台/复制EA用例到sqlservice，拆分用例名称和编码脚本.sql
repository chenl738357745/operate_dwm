

with base as(select
-- a.UseCases,
LEFT(a.UseCases, PATINDEX('%,UseCase%',a.UseCases)-1) UseCases---SR-FR-OM012,UseCase, ,Public,Proposed,1.0,2020/9/30,2020/10/14,������� ���,
,PATINDEX('%-%',a.UseCases)-3 'LeftLength'
 from [java_����ƽ̨11] a)  

,��� as (select 
REPLACE(UseCases,LEFT(UseCases,LeftLength),'') as �������
,LEFT(UseCases,LeftLength) as ��������
,case when UseCases like '%au%' then 'Ȩ�޹���'
when UseCases like '%AM%' then 'Ӧ������' 
when UseCases like '%BP%' then 'ҵ�����' 
when UseCases like '%PM%' then '��Ŀ��Ϣ����' 
when UseCases like '%UC%' then '��������'
when UseCases like '%OM%' then '��֯�û�����'  
else '' end    ģ��
----��������
,case when UseCases like '%��¼%UC%' then '��¼'
when UseCases like '%����%UC%' then '����' 
----��֯�û�����
 when UseCases like '%��˾%OM%' then '����˾����'
when UseCases like '%��λ%OM%' then '�����λ' 
when UseCases like '%�û�%OM%' then '�����û�' 
----Ӧ������
when UseCases like '%Ӧ��%AM%' then '����Ӧ��'
when UseCases like '%����%AM%' then '������' 
when UseCases like '%Ȩ�޵�%AM%' then '����Ȩ�޵�' 
----Ȩ�޹���
when UseCases like '%���ʿ���%au%' then '������ʿ���' 
when UseCases like '%�ּ���Ȩ%au%' then '����ּ���Ȩ' 
when UseCases like '%��ɫ%au%' then '�����ɫ' 
else '' end    ����
,*
from base)

select * from ���
--where ������� like '%OM%'
 order by ģ�� desc,right(�������, 3) 

