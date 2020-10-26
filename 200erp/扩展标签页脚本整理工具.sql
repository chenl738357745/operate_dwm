
  select * from sys_DetailPageRegist
 select * from sys_PageRefTabs
 
 
--1.整理扩展标签页注册的记录
SELECT * INTO #sys_DetailPageRegist FROM sys_DetailPageRegist WHERE RegistCode='bmp_GeneralRole'

 		EXEC p_sys_InsertScriptFromTemp '#sys_DetailPageRegist','sys_DetailPageRegist'
		drop table #sys_DetailPageRegist
		

SELECT * INTO #sys_PageRefTabs FROM sys_PageRefTabs WHERE DetailPageRegistGUID='9CAE0A99-686A-E911-950C-00505629CC36'

 		EXEC p_sys_InsertScriptFromTemp '#sys_PageRefTabs','sys_PageRefTabs'
		drop table #sys_PageRefTabs		
		
	--2.整理扩展标签页中配置的列表	
		DECLARE @return_value int
					EXEC @return_value = p_sys_GenerateSimpleModelScript
					 @FunctionGUID = '00269B64-8072-E911-8110-B4BEF9088AF3' 
		
