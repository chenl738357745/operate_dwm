@echo off   
echo ================================================   
echo  Windows������Oracle���ݿ���Զ����ݽű�  
echo  1. ʹ�õ�ǰ�������������ļ���  
echo  2. �Զ�ɾ��7��ǰ�ı��ݡ�  
echo ================================================  
echo  �ԡ�YYYYMMDD����ʽȡ����ǰʱ�䡣  
set BACKUPDATE=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
echo  �����û����������Ҫ���ݵ����ݿ�
set USER=pom
set PASSWORD=highzap2019
set DATABASE=oratest04.crccreit.cn/crccre
echo  ��������Ŀ¼
if not exist "D:\000work\030db\backup\data"       mkdir D:\000work\030db\backup\data  

set DATADIR=D:\000work\030db\backup\data

exp %USER%/%PASSWORD%@%DATABASE% file=%DATADIR%\data_%BACKUPDATE%.dmp buffer=102400 full=y 
pause