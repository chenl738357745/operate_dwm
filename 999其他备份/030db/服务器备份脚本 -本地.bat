@echo off   
echo ================================================   
echo  Windows环境下Oracle数据库的自动备份脚本  
echo  1. 使用当前日期命名备份文件。  
echo  2. 自动删除7天前的备份。  
echo ================================================  
echo  以“YYYYMMDD”格式取出当前时间。  
set BACKUPDATE=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
echo  设置用户名、密码和要备份的数据库
set USER=pom
set PASSWORD=highzap2019
set DATABASE=oratest04.crccreit.cn/crccre
echo  创建备份目录
if not exist "D:\000work\030db\backup\data"       mkdir D:\000work\030db\backup\data  

set DATADIR=D:\000work\030db\backup\data

exp %USER%/%PASSWORD%@%DATABASE% file=%DATADIR%\data_%BACKUPDATE%.dmp buffer=102400 full=y 
pause