---mysql �������ɸ��¼ƻ����ʱ��
select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---mysql �������ɸ��±�ʶ
select 'select '''+test2+''' id1 ,'''+test1+''' id union all' from [dbo].[Table_1];

select 'select str_to_date('''+test2+''', ''%Y/%m/%d %H'') id1 ,'''+test1+''' id union all' from [dbo].[Table_1];
---- mysql �û���ѯ
--select    'case ' a  
--union all
--select    CONCAT('when ������=''',realname,''' then ''',account,'''') a from  zt_user
--union all 
--select    ' else '''' end '  a

select 'INSERT INTO `zt_bug` (`product`,`branch`,`module`,`project`,`plan`,`title`,`keywords`,`severity`,`pri`,`steps`,`status`,activatedDate,openedBuild,assignedTo,deadline,openedDate) VALUES (2,0,0,2,0,''���������嵥:��'
+����ϵͳ+'��'+��������+''',''���������嵥'',1,1,''<p>[����]'+��������
+'\r\n<br />���ȼ���'+���ȼ�
+'\r\n<br />����������ڣ�'+�����������
+'\r\n<br />������ڣ�'+���ʱ��
+'\r\n<br />����ˣ�'+�����
+'\r\n<br />�����ˣ�'+������
+'\r\n<br />���ͣ�'+����
+'\r\n<br />�ڲ��ƻ����ʱ�䣺'+�ڲ��ƻ����ʱ��
+'\r\n<br />�ƻ�����ʱ�䣺'+�ƻ�����ʱ��
+'\r\n<br />��ע��chenl20200607�������嵥Ǩ������'
+'\r\n<br />[���]\r\n<br />[����]</p>'+�������+'\r\n<br />'',''active'','''+CONVERT(varchar,GETDATE(),120)+''',''Master'','''+
case 
when ������='�ȹ���' then 'gugb'
when ������='���' then 'xuf'
when ������='����˼��' then 'dssy'
when ������='����' then 'chenl'
when ������='����ͤ' then 'wangyt'
when ������='������' then 'wanghl'
when ������='κ����' then 'weiqy'
when ������='����' then 'wangp'
when ������='����Զ' then 'huangmy'
when ������='������' then 'liugl'
when ������='���' then 'lichong'
when ������='����' then 'yangm'
when ������='����' then 'jiangy'
when ������='Ҷ����' then 'yedr'
when ������='������' then 'xianxy'
when ������='������' then 'wangck'
when ������='����' then 'liuh'
when ������='��˳��' then 'jinsp'
when ������='������' then 'yangys'
when ������='������' then 'wangcs'
when ������='������' then 'wangrs'
when ������='����' then 'wangr'
when ������='���' then 'lic'
when ������='������' then 'daicz'
when ������='���' then 'your'
when ������='���½�' then 'xiongzj'
when ������='����' then 'jiangj'
when ������='��ΰ' then 'jiangw'
when ������='���ľ�' then 'kangwj'
when ������='½���' then 'luyx'
when ������='л�ɺ�' then 'xiesh'
when ������='�ΰ���' then 'liaoal'
when ������='�׼�' then 'leij'
when ������='������' then 'hanjm'
when ������='��С��' then 'jianxb'
when ������='xxx' then 'xxx'
when ������='����' then 'wangy'
when ������='�Ľ�' then 'wenj'
when ������='������' then 'xury'
when ������='������' then 'hanmh'
when ������='�޽���' then 'luojh'
when ������='������' then 'caolq'
when ������='�½�' then 'chenj'
when ������='л��' then 'xiez'
when ������='�����' then 'wuhy'
when ������='���¡' then 'wujl'
when ������='��С��' then 'lixc'
when ������='����' then 'jiangjie'
when ������='������' then 'luost'
when ������='������' then 'xuzl'
when ������='�ͺ���' then 'jihl'
when ������='������' then 'liqw'
when ������='������' then 'chenys'
when ������='���' then 'yangc'
when ������='������' then 'changzq'
when ������='���ν�' then 'zhoumj'
when ������='л����' then 'xiejy'
 else '' end 

+''','''+�ڲ��ƻ����ʱ��+''','''+CONVERT(varchar,GETDATE(),120)+'''); ' from [dbo].Table_4�����嵥;


