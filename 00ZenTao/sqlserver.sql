---mysql 用于生成更新计划完成时间
select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---mysql 用于生成更新标识
select 'select '''+test2+''' id1 ,'''+test1+''' id union all' from [dbo].[Table_1];

select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---- mysql 用户查询
--select    'case ' a  
--union all
--select    CONCAT('when 主责人=''',realname,''' then ''',account,'''') a from  zt_user
--union all 
--select    ' else '''' end '  a

select 'INSERT INTO `zt_bug` (`product`,`branch`,`module`,`project`,`plan`,`title`,`keywords`,`severity`,`pri`,`steps`,`status`,activatedDate,openedBuild,assignedTo,deadline,openedDate) VALUES (2,0,0,2,0,''集团问题清单:【'
+所属系统+'】'+问题描述+''',''集团问题清单'',1,1,''<p>[步骤]'+问题描述
+'\r\n<br />优先级：'+优先级
+'\r\n<br />期望解决日期：'+期望解决日期
+'\r\n<br />提出日期：'+提出时间
+'\r\n<br />提出人：'+提出人
+'\r\n<br />主责人：'+主责人
+'\r\n<br />类型：'+类型
+'\r\n<br />内部计划完成时间：'+内部计划完成时间
+'\r\n<br />计划升级时间：'+计划升级时间
+'\r\n<br />备注：chenl20200607从问题清单迁移数据'
+'\r\n<br />[结果]\r\n<br />[期望]</p>'+期望结果+'\r\n<br />'',''active'','''+CONVERT(varchar,GETDATE(),120)+''',''Master'','''+
case 
when 主责人='谷国斌' then 'gugb'
when 主责人='徐峰' then 'xuf'
when 主责人='杜宋思仪' then 'dssy'
when 主责人='陈丽' then 'chenl'
when 主责人='王雨亭' then 'wangyt'
when 主责人='王海龙' then 'wanghl'
when 主责人='魏庆杨' then 'weiqy'
when 主责人='王攀' then 'wangp'
when 主责人='黄明远' then 'huangmy'
when 主责人='刘根来' then 'liugl'
when 主责人='李冲' then 'lichong'
when 主责人='杨明' then 'yangm'
when 主责人='蒋勇' then 'jiangy'
when 主责人='叶丁荣' then 'yedr'
when 主责人='鲜晓勇' then 'xianxy'
when 主责人='王传科' then 'wangck'
when 主责人='刘航' then 'liuh'
when 主责人='金顺鹏' then 'jinsp'
when 主责人='杨义松' then 'yangys'
when 主责人='王长生' then 'wangcs'
when 主责人='王荣松' then 'wangrs'
when 主责人='汪锐' then 'wangr'
when 主责人='李成' then 'lic'
when 主责人='代春中' then 'daicz'
when 主责人='犹睿' then 'your'
when 主责人='熊章杰' then 'xiongzj'
when 主责人='蒋洁' then 'jiangj'
when 主责人='蒋伟' then 'jiangw'
when 主责人='康文靖' then 'kangwj'
when 主责人='陆溢昕' then 'luyx'
when 主责人='谢松宏' then 'xiesh'
when 主责人='廖奥霖' then 'liaoal'
when 主责人='雷吉' then 'leij'
when 主责人='韩金明' then 'hanjm'
when 主责人='简小兵' then 'jianxb'
when 主责人='xxx' then 'xxx'
when 主责人='王勇' then 'wangy'
when 主责人='文杰' then 'wenj'
when 主责人='徐荣誉' then 'xury'
when 主责人='韩明华' then 'hanmh'
when 主责人='罗建辉' then 'luojh'
when 主责人='曹丽芹' then 'caolq'
when 主责人='陈杰' then 'chenj'
when 主责人='谢智' then 'xiez'
when 主责人='吴洪阳' then 'wuhy'
when 主责人='吴佳隆' then 'wujl'
when 主责人='李小聪' then 'lixc'
when 主责人='蒋洁' then 'jiangjie'
when 主责人='罗述婷' then 'luost'
when 主责人='徐正来' then 'xuzl'
when 主责人='纪海龙' then 'jihl'
when 主责人='李钦文' then 'liqw'
when 主责人='陈永松' then 'chenys'
when 主责人='杨成' then 'yangc'
when 主责人='常中秋' then 'changzq'
when 主责人='周梦杰' then 'zhoumj'
when 主责人='谢静宜' then 'xiejy'
 else '' end 

+''','''+内部计划完成时间+''','''+CONVERT(varchar,GETDATE(),120)+'''); ' from [dbo].Table_4问题清单;


