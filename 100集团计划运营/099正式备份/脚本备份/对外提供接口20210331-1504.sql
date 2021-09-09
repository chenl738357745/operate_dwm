procedure P_MDM_PROJECT_INFO_GROUP(

	projectId IN VARCHAR2,

	info out sys_refcursor

)

	is

	org_projectId VARCHAR2(360); --原始id

-- 工程项目管理系统	 根据ID获得项目信息	 /REST/http-loadProject.ac

-- @date 2021年1月28日补充注释

-- @author hanjm

--陈丽 2021年1月28日 调整映射集团项目id

begin

	org_projectId:=projectId;

	org_projectId:=FN_GET_PROJECT_ORIGINAL_ID(projectId);

	open info for

		with base as(  select t.* from (

			select

				to_char(sp.update_date,'yyyy-MM-dd hh:mm:ss') as "updateDate",

				sp.project_code as "code",

				sp.unit_Name as "unitName",

				UPPER(sp.copr_id) as "coprId",

				sp.update_user_id as "updateUserId",

				sp.city_code as "cityCode",

				sp.vice_pm_name as "vicePMName",

				sp.update_user as "updateUser",

				sp.corp_name as "corpName",

				'' as "vicePMId",

				sp.city_name as "cityName",

				sp.project_name as "name",

				UPPER(sp.unit_id) as "unitId",

				sp.id as "id",

				replace(wmsys.wm_concat(mpr.id) over(partition by sp.id),',',';')  as "itemLmsIds",

				mpi.OVERALL_FLOORAGE_AREA as "zjmj"

--		  mpr.id as parcelId,

--		  mpr.parcel_name

			from SYS_PROJECT sp

			LEFT JOIN MDM_PARCEL mpr on sp.id=mpr.project_id

			LEFT JOIN (SELECT * FROM MDM_PROJECT_PHASE

					   WHERE PROJ_ID=org_projectId

						 AND ROWNUM=1

					   ORDER BY PHASE_ORDER desc

			) pp on pp.proj_id=sp.id

			LEFT JOIN MDM_OBJ_PHASE_INDEX mpi on mpi.OBJ_PHASE_ID=pp.id

			where sp.id=org_projectId

		)t where rownum=1)

			 ---20210128调整

		select

			base."updateDate",

			base."code",

			base."unitName",

			base."coprId",

			base."updateUserId",

			base."cityCode",

			base."vicePMName",

			base."updateUser",

			base."corpName",

			base."vicePMId",

			base."cityName",

			base."name",

			base."unitId",

			mp.R_PROJ_ID as "id",

			base."itemLmsIds",

			base."zjmj"

		from base

		left join MDM_PROJ_MAPPING mp on base."id"=mp.PROJECT_ORIGINAL_ID

	;

end;

PROCEDURE "P_MDM_PROJECT_LIST_GROUP" (

	info out sys_refcursor

)

	is

begin

	open info for

		select

			DISTINCT

			to_char(mp1.update_date,'yyyy-MM-dd hh-mm-ss') as "updateDate",

			mp1.project_code as "code",

			mp1.unit_name as "unitName",

			mp1.address as "address",

			UPPER(mp1.COPR_ID) as "coprId",

			UPPER(mp1.CORP_ID) as "corpId",

			mp1.update_user_id as "updateUserId",

			mp1.city_code as "cityCode",

			mp1.vice_pm_name as "vicePmName",

			mp1.update_user as "updateUser",

			mp1.COPR_NAME as "coprName",

			mp1.CORP_NAME as "corpName",

			NVL2(regexp_replace(mp1.sn, '[^0-9]*', ''), regexp_replace(mp1.sn, '[^0-9]*', '')*1, null) as "sn",

			UPPER(mp1.vice_pm_id) as "vicePmId",

			mp1.city_name as "cityName",

			mp1.project_name as "name",

			UPPER(mp1.unit_id) as "unitId",

			mpm.R_PROJ_ID as "id",

			to_char(mp1.take_date,'yyyy-MM-dd') as "takeDate",

			(case when completeTotal = total

					  then '03' else (

				case when constrcutionTotal = 0 or constrcutionTotal is null then '01' else '02' end

				)

				end) "state",

			(CASE WHEN b.cnt = 1 and stage_name = '无分期' THEN '04' else	'02'END) AS "structType"

		from SYS_PROJECT mp1

		left join (

			select

				count(*) over(partition by PROJ_ID) total,	--总楼栋数

				sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PROJ_ID) constrcutionTotal, --领取施工许可证楼栋树

				sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PROJ_ID) completeTotal, --领取竣工备案证楼栋树

				mb.*

			from MDM_BUILD mb where BUILD_STATE=10

		) mb1 on mp1.ID = mb1.PROJ_ID

		INNER JOIN (

			SELECT

				sp.id,

				sps.stage_name,

				COUNT(*) OVER(PARTITION BY sp.id) AS cnt

			FROM sys_project sp

			LEFT JOIN sys_project_stage	  sps ON sp.id = sps.project_id

			UNION

			SELECT '' id, '' stage_name, 0 cnt

			FROM dual

		) b on mp1.id=b.id

		left join MDM_PROJ_MAPPING MPM on mp1.ID = mpm.PROJECT_ORIGINAL_ID;

end;

PROCEDURE "P_MDM_PROJECT_STAGE_TREE_GROUP" (

	info out sys_refcursor

)

	is

begin

	----获取项目分期数据 （包含组织） 处理了是否无分期的项目。需在程序中过滤	  【主数据集团接口使用】

	open info for

		-- 公司

		with

			unit as (

				SELECT

					1 as "isStageProject",

					'1' as "isParent",

					ORG_NAME AS "name",

					UPPER(PARENT_ID) AS "pId",

					UPPER(ID) AS "id",

					'unit' as "nodeType",

					'0'||ORDER_HIERARCHY_CODE as "orderCode"

				FROM SYS_BUSINESS_UNIT

				where IS_COMPANY=1

				START WITH	ID='003200000000000000000000000000'

				CONNECT BY PRIOR ID=PARENT_ID

			),

			-- 项目

			project as (

				select

					DISTINCT

					(CASE  WHEN a."cnt" > 1 THEN 1

						   ELSE (

							   CASE WHEN a."cnt" != 1 THEN 1

									ELSE (

										CASE WHEN stage_name = '无分期' or stage_name is null	THEN 0

											 ELSE 1

											END)

								   END)

						END) AS "isStageProject",

					a."isParent",a."name",a."pId",a."id",a."nodeType", a."orderCode"

				from (

					select	DISTINCT

						'1' as "isParent",

						sp.PROJECT_NAME as "name",

						UPPER(sp.UNIT_ID) as "pId",

						sp.ID as "id",

						'project' as "nodeType",

						'1' || sp.ORDER_HIERARCHY_CODE as "orderCode",

						msm.period_name as "stageName",

						COUNT(*) OVER( PARTITION BY sp.id) AS "cnt"

					from SYS_PROJECT sp

					inner join unit on UPPER(sp.UNIT_ID) = unit."id"

					LEFT JOIN sys_project_stage spg ON spg.project_id = sp.id

					LEFT JOIN MDM_PERIOD_MAPPING msm on spg.id=msm.PERIOD_ORIGINAL_ID

					UNION

					SELECT

						'1' as "isParent",

						'' as "name",

						'' as "pId",

						'' as "id",

						'project' as "nodeType",

						'1' as "orderCode",

						'' as "stageName",

						0 AS "cnt"

					FROM dual

				)a	LEFT JOIN sys_project_stage spg ON spg.project_id = a."id" where a."id" is not null

			),

			-- 分期

			stage as (

				select

					project."isStageProject",

					'0' as "isParent",

					sps.STAGE_NAME as "name",

					mpm.R_PROJ_ID as "pId",

					sps.id as "id",

					'stage' as "nodeType",

					'3'||sps.ORDER_CODE as "orderCode"

				from SYS_PROJECT_STAGE sps

					left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sps.PROJECT_ID

				inner join project on sps.PROJECT_ID = project."id"

			)

		SELECT a.*

		from (

			select * from unit

			UNION ALL

			select "isStageProject", "isParent", "name", "pId", r_proj_id as "id", "nodeType", "orderCode"

			from project

				left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = project."id"

			UNION ALL 

			select sta."isStageProject",sta."isParent",msm.period_name,sta."pId",msm.R_PERIOD_ID AS "id",sta."nodeType",sta."orderCode" from stage sta

			left join MDM_PERIOD_MAPPING msm on msm.PERIOD_ORIGINAL_ID=sta."id"

		)a order by a."orderCode";

--end;
PROCEDURE "P_MDM_PROJECT_ALL_LIST_GROUP" (

	info out sys_refcursor

)

	-- 8.获得所有项目列表(前置项目+非前置项目)	/REST/http-loadListAllProject.ac

	is

begin

	--获取所有项目 前置+非前置项目

	open info for

		select

			DISTINCT

			project_code as "code",

			unit_name as "unitName",

			address as "address",

			UPPER(copr_id) as "coprId",

			update_user_id as "updateUserId",

			sp.city_code as "cityCode",

			sp.corp_name as "coprName",

			NVL2(regexp_replace(sn, '[^0-9]*', ''), regexp_replace(sn, '[^0-9]*', '')*1, null) as "sn",

			sp.city_name as "cityName",

			mpm.project_name as "name",

			UPPER(unit_id) as "unitId",

			mpm.R_PROJ_ID as "id",

			'1' as "frontType",

			to_char(take_date,'yyyy-MM-dd') as "takeDate"

		from SYS_PROJECT sp

			left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sp.ID;

--end;
PROCEDURE "P_MDM_PROJECT_STAGE_LIST_GROUP" (

	projectId IN VARCHAR2,

	info out sys_refcursor

)

	--10.根据项目ID获取分期列表	/REST/http-loadListProjectStage.ac

	is

	vProjectId varchar2(36) := FN_GET_PROJECT_ORIGINAL_ID(projectId);

begin

	open info for

		select	  msm.r_period_id as "id",

				  msm.period_name as "name",

				  d.state as "state",

				  d.order_code as "code",

				  nvl(TO_CHAR(d.sn), 'null') as "sn"

		from (

			SELECT	  *

			from (

				SELECT DISTINCT sps.*,a.cnt,

								(case when completeTotal = total

										  then '03' else

										  (case when constrcutionTotal = 0 or constrcutionTotal is null then '01' else '02' end) end) state

				FROM SYS_PROJECT_STAGE sps

				left join (

					select

						count(*) over(partition by PERIOD_ID) total,  --总楼栋数

						sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PERIOD_ID) constrcutionTotal, --领取施工许可证楼栋树

						sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PERIOD_ID) completeTotal, --领取竣工备案证楼栋树

						mb.*

					from MDM_BUILD mb where BUILD_STATE=10

				) mb1

							  on sps.ID = mb1.PERIOD_ID

				INNER JOIN (

					SELECT DISTINCT

						spg.id,

						spg.stage_name,

						COUNT(*) OVER(

							PARTITION BY sp.id

							) AS cnt

					FROM

						sys_project			sp

						LEFT JOIN sys_project_stage	  spg ON spg.project_id = sp.id

					UNION

					SELECT

						'' id,

						'' stage_name,

						0 cnt

					FROM

						dual

				)a on sps.id=a.id

				where  a.cnt!=1

				   or (a.cnt=1 and a.stage_name != '无分期' and a.stage_name is not null) ORDER BY sps.SN

			)s where s.project_id=vProjectId

		)d 

		LEFT JOIN MDM_PERIOD_MAPPING msm on msm.period_original_id=d.id

		order by d.sn;

--end;
PROCEDURE "P_MDM_STAGE_LIST_GROUP" (

	info out sys_refcursor

)

	--9.获得所有分期列表	/REST/http-loadListStage.ac

	is

begin

	open info for

		SELECT	msm.r_period_id as "id",

				msm.period_name as "name",

				s.state as "stage",

				s.state as "state",

				mpm.R_PROJ_ID as "projectId",

				s.sn as "sn"

		from (

			SELECT DISTINCT sps.*,a.cnt,

							(case when completeTotal = total

									  then '03' else

									  (case when constrcutionTotal = 0 or constrcutionTotal is null then '01' else '02' end) end) state

			FROM SYS_PROJECT_STAGE sps

			left join (

				select

					count(*) over(partition by PERIOD_ID) total,  --总楼栋数

					sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PERIOD_ID) constrcutionTotal, --领取施工许可证楼栋树

					sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PERIOD_ID) completeTotal, --领取竣工备案证楼栋树

					mb.*

				from MDM_BUILD mb where BUILD_STATE=10

			) mb1 on sps.ID = mb1.PERIOD_ID

			INNER JOIN (

				SELECT DISTINCT

					spg.id,

					spg.stage_name,

					COUNT(*) OVER(

						PARTITION BY sp.id

						) AS cnt

				FROM

					sys_project			sp

					LEFT JOIN sys_project_stage	  spg ON spg.project_id = sp.id

				UNION

				SELECT

					'' id,

					'' stage_name,

					0 cnt

				FROM

					dual

			)a on sps.id=a.id

			where  a.cnt!=1

			   or (a.cnt=1 and a.stage_name != '无分期' and a.stage_name is not null) ORDER BY sps.SN

		)s 

		LEFT JOIN MDM_PERIOD_MAPPING msm on msm.period_original_id=s.id

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = s.PROJECT_ID;

--end;
procedure P_MDM_PROJECT_LIST_PAGE_GROUP(

	pageIndex in VARCHAR2,

	pageSizes in VARCHAR2,

	unitId in VARCHAR2,

	projectCode IN varchar2,

	projectName IN VARCHAR2,

	address IN VARCHAR2,

	unitName IN VARCHAR2,

	projectState IN VARCHAR2,

	structType IN VARCHAR2,

	info out sys_refcursor

)

  --15.以分页形式返回项目列表	/REST/http-loadPageProject.ac

AS

	v_unitId varchar2(200);

	v_code varchar2(200);

	v_name varchar2(200);

	v_address varchar2(200);

	v_unitName varchar2(200);

	v_state varchar2(200);

	v_structType varchar2(200);

begin

	v_unitId:=unitId;

	v_code:=projectCode;

	v_name:=projectName;

	v_address:=address;

	v_unitName:=unitName;

	v_state:=projectState;

	v_structType:=structType;

	open info for

		select

			DISTINCT

			s2."code",

			s2."unitName",

			s2."address",

			s2."corpId",

			s2."cityCode",

			s2."corpName",

			s2."name",

			s2."id",

			s2."unitId",

			s2."state",

			s2."structTypeText",

			s2."structType",

			s2."records",

			s2."rowsTotal"

		from (

			select s1.*,rownum as "rowno",count(*)over() as "rowsTotal"

			from (

				select f.*, decode(f."structType", '04', '项目-楼栋', '项目-分期-楼栋')  as "structTypeText"

				from (

					select s.*,count(*) over() as "records"

					from (

						select

							DISTINCT

							mp1.project_code as "code",

							mp1.unit_name as "unitName",

							mp1.address as "address",

							UPPER(mp1.CORP_ID) as "corpId",

							mp1.city_code as "cityCode",

							mp1.corp_name as "corpName",

							mp1.project_name as "name",

							UPPER(mp1.unit_id) as "unitId",

							mpm.R_PROJ_ID as "id",

							(case when completeTotal = total

									  then '03' else

									  (case when constrcutionTotal = 0 or constrcutionTotal is null then '01' else '02' end)

								end) "state",

							( CASE

								  WHEN b.cnt > 1 THEN '02'

								  ELSE (

									  CASE WHEN b.cnt != 1 THEN '02'

										   ELSE (

											   CASE WHEN stage_name = '无分期' or stage_name is null THEN '04'

													ELSE '02' END

											   ) END

									  ) END

								) AS "structType"

						from SYS_PROJECT mp1

						left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = mp1.ID

						left join (

							select

								count(*) over(partition by PROJ_ID) total,	--总楼栋数

								sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PROJ_ID) constrcutionTotal, --领取施工许可证楼栋树

								sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PROJ_ID) completeTotal, --领取竣工备案证楼栋树

								mb.*

							from MDM_BUILD mb where BUILD_STATE=10

						) mb1 on mp1.ID = mb1.PROJ_ID

						LEFT JOIN (

							SELECT sp.id, sps.stage_name, COUNT(*) OVER( PARTITION BY sp.id ) AS cnt

							FROM sys_project sp

							LEFT JOIN sys_project_stage sps ON sp.id = sps.project_id

							UNION

							SELECT '' id, '' stage_name, 0 cnt FROM dual

						) b on mp1.id=b.id

					)s where (v_code is null or s."code" like '%'||v_code||'%')

						 and (v_unitname is null or s."unitName" like '%'||v_unitname||'%' )

						 and (v_address is null or s."address" like '%'||v_address||'%')

						 and (v_name is null or s."name" like '%'||v_name||'%')

						 and (v_unitid is null or s."unitId" like '%'||v_unitid||'%')

						 and (v_state is null or s."state" like '%'||v_state||'%')

						 and (v_structtype is null or s."structType" like '%'||v_structtype||'%')

				)f

			)s1 where rownum <= ( pageIndex*1) * (pageSizes*1)

		)s2	 where s2."rowno" > (pageSizes*1) * ( (pageIndex*1) - 1 );

end;

procedure P_MDM_UNIT_PROJECT_LIST_GROUP(

	unitId IN VARCHAR2,

	info out sys_refcursor

)

	-- 11.根据公司ID获取项目列表	/REST/http-loadListUnitProject.ac P_MDM_UNIT_PROJECT_LIST_GROUP

	is

begin

	--根据公司获取项目列表

	open info for

		select

			sp.project_code as "code",

			sp.unit_name as "unitName",

			sp.project_name as "name",

			UPPER(sp.unit_id) as "unitId",

			mpm.R_PROJ_ID as "id"

		from sys_project sp

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sp.ID

		where LOWER(unit_id)=LOWER(unitId);

end;

PROCEDURE "P_MDM_PROJECT_LIST_GROUP_SALE" (

	unitId IN VARCHAR2,

	info out sys_refcursor

)

	-- 22.获取项目列表	/api/loadProjectList P_MDM_PROJECT_LIST_GROUP_SALE

	is

begin

	open info for

		SELECT sp.unit_name as "unitName",

			   sp.project_code as "projectCode",

			   sp.unit_id as "unitId",

			   sp.project_name as "projectName",

			   mpm.R_PROJ_ID as "projectId"

		FROM SYS_PROJECT sp

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sp.ID

		WHERE unitId is null or unit_id=unitId

		order by PROJECT_CODE;

end;

PROCEDURE "P_MDM_PROJECT_STAGE_SALE_GROUP" (

	projectId IN VARCHAR2,

	info out sys_refcursor

)

--	   24.根据项目id获取项目和分期信息(提供给销售系统)

	is

	vProjectId varchar(36) := FN_GET_PROJECT_ORIGINAL_ID(projectId);

begin

	open info  for

		with

			stage as (

				select distinct *

				from (

					SELECT

						sps.stage_name as "stageName",

						sp.project_code as "projectCode",

						sp.project_name as "projectName",

						to_char(pp.plan_end_date,'yyyy-MM-dd') as "planEndDate",

						to_char(pp.plan_start_date,'yyyy-MM-dd') as "planStartDate",

						to_char(pp.actual_end_date,'yyyy-MM-dd')  as "actualEndDate",

						sp.id as "projectId",

						sps.id as "stageId",

						sps.sn as "sn",

						sps.order_Code as "stageCode",

						'分期' as "type",

						bt.bltTotal as "bldNum",

						cnt,

						(case when mb1.completeTotal = mb1.total

								  then '03' else

								  (case when mb1.constrcutionTotal = 0 or mb1.constrcutionTotal is null then '01' else '02' end) end) "state"

					FROM SYS_PROJECT sp

					

					LEFT JOIN (

						select isps.*, count(*) over (partition by isps.PROJECT_ID) cnt from SYS_PROJECT_STAGE isps

					) sps on sp.id=sps.project_id

					LEFT JOIN (

						select period_id,count(*) as bltTotal from mdm_build group by period_id

					) bt on sps.id=bt.period_id

					LEFT JOIN (

						select

							count(*) over(partition by PERIOD_ID) total,  --总楼栋数

							sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PERIOD_ID) constrcutionTotal, --领取施工许可证楼栋树

							sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PERIOD_ID) completeTotal, --领取竣工备案证楼栋树

							mb.*

						from MDM_BUILD mb where BUILD_STATE=10

					) mb1 on sps.ID = mb1.PERIOD_ID

					LEFT JOIN (

						SELECT distinct pp.*,pn.plan_end_date,pn.plan_start_date,pn.actual_end_date

						FROM POM_PROJ_PLAN pp

						LEFT JOIN (

							select tt2.*

							from (

								select ta.*, max(id) over(PARTITION BY PROJ_PLAN_ID) maxId

								from (

									SELECT	MAX(actual_end_date) over(PARTITION BY PROJ_PLAN_ID) as max_actual_end_date, tt.*

									FROM POM_PROJ_PLAN_NODE tt where actual_end_date is not null

								) ta where ta.actual_end_date = max_actual_end_date

							) tt2 where tt2.id = maxId

						)pn on pp.id=pn.proj_plan_id where pp.plan_type='关键节点计划' and pp.approval_status='已审核'

					)  pp on sps.id=pp.proj_id

					where sp.id=vProjectId order by sps.sn

				)s order by s."sn"

			),

			project as (

				select

					null as "stageName",

					ss."projectCode",

					ss."projectName",

					ss."planEndDate",

					ss."planStartDate",

					ss.max_actual_end_date as "actualEndDate",

					ss."projectId",

					null as "stageId",

					null as "sn",

					null as "stageCode",

					'项目' as "type",

					ss."totalBld" as"bldNum",

					0 cnt,

					(case when ss.completeTotal = ss.total

							  then '03' else

							  (case when ss.constrcutionTotal = 0 or ss.constrcutionTotal is null then '01' else '02' end) end) "state"

				from (

					select bt.*,mb1.constrcutionTotal,mb1.total,mb1.completeTotal

					from (

						select	SUM("bldNum")over (PARTITION BY "projectId") as "totalBld", ff.*

						from (

							SELECT	MAX("actualEndDate") over(PARTITION BY "projectId") as max_actual_end_date,tt.*

							FROM stage tt

						)ff

					)bt left join (

						select

							count(*) over(partition by PERIOD_ID) total,  --总楼栋数

							sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PERIOD_ID) constrcutionTotal, --领取施工许可证楼栋树

							sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PERIOD_ID) completeTotal, --领取竣工备案证楼栋树

							mb.*

						from MDM_BUILD mb where BUILD_STATE=10

					)mb1 on mb1.proj_id=bt."projectId"

					where bt.max_actual_end_date=bt."actualEndDate" or bt.max_actual_end_date is null

					order by bt.max_actual_end_date

				)ss

			)

		select msm.period_name as "stageName",

			   ls."projectCode",

			   ls."projectName",

			   ls."planEndDate",

			   ls."planStartDate",

			   ls."actualEndDate",

			   mpm.R_PROJ_ID "projectId",

			   msm.r_period_id as "stageId",

			   ls."sn",

			   ls."stageCode",

			   ls."type",

			   ls."bldNum",

			   ls."state"

		from (

			select * from project where ROWNUM = 1

			union all

			select * from stage where cnt != 1 or "stageName" != '无分期'

		) ls left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = ls."projectId"

		LEFT JOIN MDM_PERIOD_MAPPING msm on msm.period_original_id=ls."stageId"

		;

--end;
PROCEDURE "P_MDM_STAGE_LIST_SALE_GROUP" (

	projectId in varchar2,

	info out sys_refcursor

)

	--21.获取分期列表	/api/loadStageList

	is

	vProjectId varchar(36) := FN_GET_PROJECT_ORIGINAL_ID(projectId);

begin

	open info for

		select * from (

			SELECT

				distinct

				msm.period_name as "stageName",

				sp.project_code as "projectCode",

				sp.project_name as "projectName",

				to_char(pp.plan_end_date,'yyyy-MM-dd') as "planEndDate",

				to_char(pp.plan_start_date,'yyyy-MM-dd') as "planStartDate",

				mpm.R_PROJ_ID as "projectId",

				msm.r_period_id as "stageId",

				sps.sn as "sn",

				(case when mb1.completeTotal = mb1.total

						  then '03' else

						  (case when mb1.constrcutionTotal = 0 or mb1.constrcutionTotal is null then '01' else '02' end) end) "state"

			FROM SYS_PROJECT sp

			LEFT JOIN MDM_PROJ_MAPPING mpm on sp.id=mpm.PROJECT_ORIGINAL_ID

			LEFT JOIN (

				select tsps.*, count(*) over ( partition by tsps.PROJECT_ID) cnt from SYS_PROJECT_STAGE tsps

		   ) sps on sp.id=sps.project_id

		   LEFT JOIN MDM_PERIOD_MAPPING msm on sps.id =msm.PERIOD_ORIGINAL_ID

		   LEFT JOIN (

				select

					count(*) over(partition by PERIOD_ID) total,  --总楼栋数

					sum(mb.IS_GET_CONSTRCUTION_PERMIT) over(partition by PERIOD_ID) constrcutionTotal, --领取施工许可证楼栋树

					sum(mb.IS_GET_COMPLETED_PERMIT) over(partition by PERIOD_ID) completeTotal, --领取竣工备案证楼栋树

					mb.*

				from MDM_BUILD mb where BUILD_STATE=10

			) mb1 on sps.ID = mb1.PERIOD_ID

			LEFT JOIN (

				SELECT distinct pp.*,pn.plan_end_date,pn.plan_start_date FROM POM_PROJ_PLAN pp

				LEFT JOIN (

					select tt2.* from (

						select ta.*, max(id) over(PARTITION BY PROJ_PLAN_ID) maxId from (

							SELECT	MAX(actual_end_date) over(PARTITION BY PROJ_PLAN_ID) as max_actual_end_date, tt.*

							FROM POM_PROJ_PLAN_NODE tt where actual_end_date is not null

						) ta where ta.actual_end_date = max_actual_end_date

					) tt2 where tt2.id = maxId

				)pn on pp.id=pn.proj_plan_id where pp.plan_type='关键节点计划' and pp.approval_status='已审核'

			)  pp on sps.id=pp.proj_id

			where (vProjectId is null or sp.id=vProjectId) and (cnt != 1 or STAGE_NAME != '无分期')

			order by sps.sn

		)s order by s."sn";

--end;
PROCEDURE "P_MDM_EXT_ALL_PT" (

	info out sys_refcursor

)

as

	-- 19.获取全部业态	/api/listAllPT

	-- @auth hanjm

begin

	open info for

		select

			mbpt1.ID "id",

			mbpt1.PRODUCT_TYPE_SHORT_NAME "name",

			mbpt2.ID "pId"

		from MDM_BUILD_PRODUCT_TYPE mbpt1

		left join MDM_BUILD_PRODUCT_TYPE mbpt2 on mbpt1.PARENT_CODE = mbpt2.PRODUCT_TYPE_CODE

			and mbpt1.IS_DISABLE = mbpt2.IS_DISABLE

		where mbpt1.IS_DISABLE = 0;

end;

PROCEDURE "P_MDM_EXT_BUILDING_BY_STAGE" (

	stageId in varchar,

	info out sys_refcursor

)

as

	--23.根据分期id获取楼栋信息	/api/getBuildingByStage P_MDM_EXT_BUILDING_BY_STAGE

	vStageId varchar2(36) := stageId;

	vStageNames varchar2(3000);

	vStageCnt number(4) := 0;

	vIsNoPeriod number(2) := 0;

begin

	begin

		-- 无分期项目时，集团会传入项目id 需要做判断处理

		select count(*), WMSYS.WM_CONCAT(STAGE_NAME) into vStageCnt, vStageNames from SYS_PROJECT_STAGE

		where PROJECT_ID = vStageId;

		if vStageCnt = 1 and vStageNames = '无分期' then

			-- 为无分期项目

			vStageId := FN_GET_PROJECT_ORIGINAL_ID(vStageId);

			vIsNoPeriod := 1;

		end if;

	exception when others then

		vIsNoPeriod := 0;

	end;

	open info for

		select

			mbm.build_name "buildingName", -- 楼栋名称

			mpm.R_PROJ_ID "projectId", -- 项目ID

			mbm.r_build_id "buildingId", -- 楼栋ID

			msm.r_period_id "stageId" --分期ID

		from MDM_BUILD mb

		left join MDM_BUILD_MAPPING mbm on mbm.build_id=mb.id

		LEFT JOIN MDM_PERIOD_MAPPING msm on mb.period_id=msm.period_original_id

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = mb.PROJ_ID

		where ((vIsNoPeriod = 1 and mpm.R_PROJ_ID=vStageId) or msm.r_period_id = vStageId) and BUILD_STATE='10';

--end;
PROCEDURE "P_MDM_EXT_STAGE_CAP_BUILD" (

	info out sys_refcursor,

	stageGuid in varchar -- 项目id

)	 -- 27.获取项目下的车位&楼栋信息 /REST/getStageInfoByStageId

-- notes: 存在多条数据，也只会返回第一条数据

-- @auth hanjm

as

	vStageId varchar2(36) := stageGuid;

	vStageNames varchar2(3000);

	vStageCnt number(4) := 0;

	vIsNoPeriod number(2) := 0;

begin

	begin

		-- 无分期项目时，集团会传入项目id 需要做判断处理

		select count(*), WMSYS.WM_CONCAT(STAGE_NAME) into vStageCnt, vStageNames from SYS_PROJECT_STAGE

		where PROJECT_ID = vStageId;

		if vStageCnt = 1 and vStageNames = '无分期' then

			-- 为无分期项目

			vStageId := FN_GET_PROJECT_ORIGINAL_ID(vStageId);

			vIsNoPeriod := 1;

		end if;

	exception when others then

		vIsNoPeriod := 0;

	end;

	open info for

		select

			mpm.project_name as "title", --项目名称(String)

			TO_CHAR(sum(NVL(mr.cnt, 0))) as "count", --合计（默认返回“0”）(String)

			TO_CHAR(nvl(SUM("totalArea"), 0)) as "totalArea", --房源面积合计(String)

			TO_CHAR(nvl(SUM("totalPt1Area"), 0)) as "totalPt1Area", --房源住宅面积(String)

			TO_CHAR(nvl(SUM("totalPt2Area"), 0)) as "totalPt2Area", --房源公寓面积(String)

			TO_CHAR(nvl(SUM("totalPt3Area"), 0)) as "totalPt3Area", --房源商业面积(String)

			TO_CHAR(nvl(SUM("totalPt4Area"), 0)) as "totalPt4Area", --房源车位面积(String)

			TO_CHAR(nvl(SUM("totalCount"), 0)) as "totalCount", --房源套数合计(String)

			TO_CHAR(nvl(SUM("totalPt1Count"), 0)) as "totalPt1Count", --房源住宅套数(String)

			TO_CHAR(nvl(SUM("totalPt2Count"), 0)) as "totalPt2Count", --房源公寓套数(String)

			TO_CHAR(nvl(SUM("totalPt3Count"), 0)) as "totalPt3Count", --房源商业套数(String)

			TO_CHAR(nvl(SUM("totalPt4Count"), 0)) as "totalPt4Count", --房源车位套数(String)

			TO_CHAR(nvl(SUM("forSaleCount"), 0)) as "forSaleCount", --待售套数(String)

			TO_CHAR(nvl(SUM("forSalePt1Count"), 0)) as "forSalePt1Count", --住宅待售套数(String)

			TO_CHAR(nvl(SUM("forSalePt2Count"), 0)) as "forSalePt2Count", --公寓待售套数(String)

			TO_CHAR(nvl(SUM("forSalePt3Count"), 0)) as "forSalePt3Count", --商业待售套数(String)

			TO_CHAR(nvl(SUM("forSalePt4Count"), 0)) as "forSalePt4Count", --车位待售套数(String)

			TO_CHAR(nvl(SUM("qyArea"), 0)) as "qyArea", --签约面积(String)

			TO_CHAR(nvl(SUM("qyPt1Area"), 0)) as "qyPt1Area", --住宅签约面积(String)

			TO_CHAR(nvl(SUM("qyPt2Area"), 0)) as "qyPt2Area", --公寓签约面积(String)

			TO_CHAR(nvl(SUM("qyPt3Area"), 0)) as "qyPt3Area", --商业签约面积(String)

			TO_CHAR(nvl(SUM("qyPt4Area"), 0)) as "qyPt4Area", --车位签约面积(String)

			TO_CHAR(nvl(SUM("qyCount"), 0)) as "qyCount", --签约套数(String)

			TO_CHAR(nvl(SUM("qyPt1Count"), 0)) as "qyPt1Count", --住宅签约套数(String)

			TO_CHAR(nvl(SUM("qyPt2Count"), 0)) as "qyPt2Count", --公寓签约套数(String)

			TO_CHAR(nvl(SUM("qyPt3Count"), 0)) as "qyPt3Count", --商业签约套数(String)

			TO_CHAR(nvl(SUM("qyPt4Count"), 0)) as "qyPt4Count", --车位签约套数(String)

			TO_CHAR(nvl(SUM("rgCount"), 0)) as "rgCount", --认购套数(String)

			TO_CHAR(nvl(SUM("rgPt1Count"), 0)) as "rgPt1Count", --住宅认购套数(String)

			TO_CHAR(nvl(SUM("rgPt2Count"), 0)) as "rgPt2Count", --公寓认购套数(String)

			TO_CHAR(nvl(SUM("rgPt3Count"), 0)) as "rgPt3Count", --商业认购套数(String)

			TO_CHAR(nvl(SUM("rgPt4Count"), 0)) as "rgPt4Count", --车位认购套数(String)

			TO_CHAR(nvl(SUM("rgNoQyCount"), 0)) as "rgNoQyCount", --认购未签约套数(String)

			TO_CHAR(nvl(SUM("rgNoQyPt1Count"), 0)) as "rgNoQyPt1Count", --住宅认购未签约套数(String)

			TO_CHAR(nvl(SUM("rgNoQyPt2Count"), 0)) as "rgNoQyPt2Count", --公寓认购未签约套数(String)

			TO_CHAR(nvl(SUM("rgNoQyPt3Count"), 0)) as "rgNoQyPt3Count", --商业认购未签约套数(String)

			TO_CHAR(nvl(SUM("rgNoQyPt4Count"), 0)) as "rgNoQyPt4Count", --车位认购未签约套数(String)

			TO_CHAR(nvl(SUM("ylCount"), 0)) as "ylCount", --预留套数(String)

			TO_CHAR(nvl(SUM("ylPt1Count"), 0)) as "ylPt1Count", --住宅预留套数(String)

			TO_CHAR(nvl(SUM("ylPt2Count"), 0)) as "ylPt2Count", --公寓预留套数(String)

			TO_CHAR(nvl(SUM("ylPt3Count"), 0)) as "ylPt3Count", --商业预留套数(String)

			TO_CHAR(nvl(SUM("ylPt4Count"), 0)) as "ylPt4Count" --车位预留套数(String)

		from SYS_PROJECT_STAGE sps

		LEFT JOIN MDM_PERIOD_MAPPING msm on sps.id=msm.PERIOD_ORIGINAL_ID

		left join MDM_BUILD mb on mb.PERIOD_ID = sps.ID

		LEFT JOIN MDM_BUILD_MAPPING mbm on mb.id=mbm.build_id

		left join (

			select

				sum(case when SALE_STATE = '待售' then 1 else 0 end) "forSaleCount", --待售套数

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt1Count",-- 住宅待售套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt2Count",-- 公寓待售套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt3Count",-- 商业待售套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt4Count",-- 车位待售套数

				sum(case when SALE_STATE = '签约' then 1 else 0 end) "qyCount", --签约套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '签约' then 1 else 0 end) "qyPt1Count",-- 住宅签约套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '签约' then 1 else 0 end) "qyPt2Count",-- 公寓签约套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '签约' then 1 else 0 end) "qyPt3Count",-- 商办签约套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '签约' then 1 else 0 end) "qyPt4Count",-- 车位签约套数

				sum(case when SALE_STATE = '认购' or SALE_STATE = '签约' then 1 else 0 end) "rgCount", --认购套数(String)

				sum(case when PRODUCT_NAME = '住宅' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt1Count",-- 住宅认购套数

				sum(case when PRODUCT_NAME = '公寓' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt2Count",-- 公寓认购套数

				sum(case when PRODUCT_NAME = '商办' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt3Count",-- 商办认购套数

				sum(case when PRODUCT_NAME = '车位' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt4Count",-- 车位认购套数

				sum(case when SALE_STATE = '认购' then 1 else 0 end) "rgNoQyCount", --认购未签约套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt1Count",-- 住宅认购未签约套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt2Count",-- 公寓认购未签约套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt3Count",-- 商办认购未签约套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt4Count",-- 车位认购未签约套数

				sum(case when SALE_STATE = '销控' then 1 else 0 end) "ylCount", --预留套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '销控' then 1 else 0 end) "ylPt1Count",-- 住宅预留套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '销控' then 1 else 0 end) "ylPt2Count",-- 公寓预留套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '销控' then 1 else 0 end) "ylPt3Count",-- 商办预留套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '销控' then 1 else 0 end) "ylPt4Count",-- 车位预留套数

				count(1) "totalCount", --房源套数合计(String)

				sum(case when PRODUCT_NAME = '住宅' then 1 else 0 end) "totalPt1Count", --房源住宅套数(String)

				sum(case when PRODUCT_NAME = '公寓' then 1 else 0 end) "totalPt2Count", --房源公寓套数(String)

				sum(case when PRODUCT_NAME = '商办' then 1 else 0 end) "totalPt3Count", --房源商业套数(String)

				sum(case when PRODUCT_NAME = '车位' then 1 else 0 end) "totalPt4Count", --房源车位套数(String)

				sum(NEW_BLD_AREA) "totalArea", --房源面积合计(String)

				sum(case when PRODUCT_NAME = '住宅' then NEW_BLD_AREA else 0 end) "totalPt1Area",-- 房源住宅面积

				sum(case when PRODUCT_NAME = '公寓' then NEW_BLD_AREA else 0 end) "totalPt2Area",-- 房源公寓面积

				sum(case when PRODUCT_NAME = '商办' then NEW_BLD_AREA else 0 end) "totalPt3Area",-- 房源商业面积

				sum(case when PRODUCT_NAME = '车位' then NEW_BLD_AREA else 0 end) "totalPt4Area",-- 房源车位面积

				sum(case when SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyArea", --签约面积(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt1Area", --住宅签约面积(String)

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt2Area", --公寓签约面积(String)

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt3Area", --商业签约面积(String)

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt4Area", --车位签约面积(String)

				BUILDING_ID,

				count(*) cnt

			from MDM_ROOM tmr

			group by BUILDING_ID

		) mr on mb.ID = mr.BUILDING_ID

		inner join SYS_PROJECT sp on sp.ID = sps.PROJECT_ID

		LEFT JOIN MDM_PROJ_MAPPING mpm on sp.id=mpm.PROJECT_ORIGINAL_ID

		where ((vIsNoPeriod = 1 and mpm.r_proj_id = vStageId) or msm.r_period_id = stageGuid)

		group by PROJECT_ID, mpm.PROJECT_NAME;

--end;
PROCEDURE "P_MDM_EXT_BUILDING_LIST" (

	projectId in varchar,

	info out sys_refcursor

)

--	   20.获取楼栋列表 /api/loadBuildingList

as

	vProjectId varchar(36) := FN_GET_PROJECT_ORIGINAL_ID(projectId);

begin

	open info for

		select

			mbm.BUILD_NAME "buildingName", -- 楼栋名称

			mpm.R_PROJ_ID "projectId", -- 项目ID

			mbm.r_build_id "buildingId", -- 楼栋ID

			msm.r_period_id "stageId" --分期ID

		from MDM_BUILD mb

		LEFT JOIN MDM_BUILD_MAPPING mbm on mb.id=mbm.build_id

		LEFT JOIN MDM_PERIOD_MAPPING msm on mb.period_id=msm.period_original_id

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = mb.PROJ_ID

		where (vProjectId is null or PROJ_ID = vProjectId)

		  and BUILD_STATE='10'

		order by ORDER_HIERARCHY_CODE;

--end;
PROCEDURE "P_MDM_EXT_BUILDING_ROOM" (

	bldguid in varchar, -- 房间id

	buildingInfo out sys_refcursor, --楼栋信息

	floors out sys_refcursor, --楼层信息

	rooms out sys_refcursor, -- 房间信息

	units out sys_refcursor --单元信息

)

as

	--25.获取楼栋所有房间的信息（新） /api/saleReportViewByBldguid

	-- 获取所有业态

	-- @auth hanjm

begin

	-- 获取楼栋所有房间信息 单个

	open buildingInfo for

		select

			decode("XSJE_SHANGYE"+"XSJE_ZHUZHAI", 0, 0.00,

				   TO_CHAR(("XSJE_SHANGYE" + "XSJE_ZHUZHAI")/("XSMJ_SHANGYE"+"XSMJ_ZHUZHAI"), 'FM9999990.99')) "JJ_TOTAL", --均价总计(Double)

			"FYTS_ZHUZHAI", --房源套数住宅(Integer)

			"XSJE_SHANGYE", --销售金额商业(Double)

			"FYMJ_ZHUZHAI", --房源面积住宅(Double)

			decode("FYMJ_ZHUZHAI", 0, 0.00, TO_CHAR("XSJE_ZHUZHAI"/"FYMJ_ZHUZHAI",

													'FM99999990.99')) "JJ_ZHUZHAI", --均价住宅(Double)

			"XSMJ_SHANGYE"+"XSMJ_ZHUZHAI" "XSMJ_TOTAL", --销售面积总计(Double)

			"XSMJ_SHANGYE", --销售面积商业(Double)

			"XSJE_ZHUZHAI", --销售金额住宅(Double)

			"FYTS_SHANGYE", --房源商业总计(Double)

			"XSJE_SHANGYE"+"XSJE_ZHUZHAI" "XSJE_TOTAL", --销售金额总计(Double)

			"XSZT_RENGOU", --销售状态认购(Integer)

			"XSZT_QIANYUE", --销售状态签约(Integer)

			"XSZT_DAISHOU", --销售状态待售(Integer)

			"FYMJ_SHANGYE", --房源面积商业(Integer)

			"XSMJ_ZHUZHAI", --销售面积住宅(Double)

			"FYMJ_TOTAL", --房源面积总计(Double)

			decode("FYMJ_SHANGYE", 0, 0.00,

				   TO_CHAR("XSJE_SHANGYE"/"FYMJ_SHANGYE", 'FM999990.99')) "JJ_SHANGYE", -- 均价商业(Integer)

			"FYTS_TOTAL" -- 房源套数合计(Integer),

		from (

			select

				sum(case when SALE_STATE = '待售' then 1 else 0 end) "XSZT_DAISHOU", --销售状态待售(Integer)

				sum(case when SALE_STATE = '签约' then 1 else 0 end) "XSZT_QIANYUE", --销售状态签约(Integer)

				sum(case when SALE_STATE = '认购' then 1 else 0 end) "XSZT_RENGOU", --销售状态认购(Integer)

				count(1) "FYTS_TOTAL", --房源套数合计(String)

				sum(case when PRODUCT_NAME = '住宅' then 1 else 0 end) "FYTS_ZHUZHAI", --房源套数住宅(Integer)

				sum(case when PRODUCT_NAME = '商办' then 1 else 0 end) "FYTS_SHANGYE", --房源商业套数(String)

				sum(NEW_BLD_AREA) "FYMJ_TOTAL", --房源面积合计(String)

				sum(case when PRODUCT_NAME = '住宅' then NEW_BLD_AREA else 0 end) "FYMJ_ZHUZHAI",-- 房源住宅面积

				sum(case when PRODUCT_NAME = '商办' then NEW_BLD_AREA else 0 end) "FYMJ_SHANGYE",-- 房源面积商业

				sum(case when PRODUCT_NAME = '住宅' then NEW_BLD_AREA else 0 end) "XSMJ_ZHUZHAI",-- 销售面积住宅

				sum(case when PRODUCT_NAME = '商办' then NEW_BLD_AREA else 0 end) "XSMJ_SHANGYE",-- 销售面积商业

				sum(case when PRODUCT_NAME = '住宅' then nvl(TRADE_TOTAL, BZ_TOTAL) else 0 end) "XSJE_ZHUZHAI",-- 销售金额住宅

				sum(case when PRODUCT_NAME = '商办' then nvl(TRADE_TOTAL, BZ_TOTAL) else 0 end) "XSJE_SHANGYE"-- 销售金额商业

			from MDM_ROOM

--					where BUILDING_ID=bldguid

			where BUILDING_ID='0245fc247e7544df9c6b3ddb3288d3d9'

			group by BUILDING_ID

		);

	-- 获取楼栋楼层

	open floors for

		select

			distinct FLOOR_NAME "FLOORNAME" --楼层名称(String)

		from MDM_ROOM where BUILDING_ID = bldguid;

	-- 获取房间楼层

	open rooms for

		select

			mr.ID ROOMGUID,

			mr.BZ_TOTAL "TOTAL", --标准总价(Double)

			mr.PRODUCT_NAME "HXNAME", --户型名称(String)

			mr.BASE_PRICE PRICE,   --建筑单价(Double)

			mr.FLOOR_NAME FLOOR_NAME,	--楼层名称(String)

			mr.NEW_IN_AREA TNAREA,	 --套内面积（户型）(Double)

			mr.TRADE_TOTAL CONTRACTTOTAL,	--合同金额(Integer)

			nvl(mr.SALE_STATE, '出售') SALESTATUS,   --销售状态("出售")(String)

			mr.NEW_BLD_AREA BLDAREA,   --建筑面积（户型）(Double)

			mr.ROOM_CODE ROOMCODE,	 --房间编码(String)

			1 STATUS,	--状态(Integer)

			mr.TRADE_PRICE CONTRACTPRICE,	--合同单价(Double)

			mr.UNIT_NAME UNIT_NAME,	  --单元名称(String)

			mr.ROOM_NAME ROOMNAME,	 --房间名称(String)

			mr.PRODUCT_CODE BPRODUCTTYPECODE,	--业态编码(String)

			mr.SALE_STATE SALETYPE,	  --销售类型(String)

			mr.BZ_PRICE TNPRICE -- 套内单价

		from MDM_ROOM mr

		left join MDM_BUILD mb on mr.BUILDING_ID = mb.ID

		where mb.id = bldguid;

	-- 获取单元信息

	open units for

		select

			UNIT_NAME "UNITNAME", -- 单元名称(String)

			ROOM_CODE "DOORNUM" --房间数(String)

		from MDM_ROOM where BUILDING_ID = bldguid;

end;

PROCEDURE "P_MDM_EXT_BUILDING_ROOM_OLD" (

	info out sys_refcursor,

	buildingId in varchar -- 房间id

)

as

	-- 28.获取楼栋所有房间信息	/REST/listRoomByBuildingId

	-- 获取楼栋所有房间信息

	-- @author hanjm

begin

	open info for

		select

			mr.id "roomGuid", -- 房间ID(String)

			mr.UNIT_ID "unitNo", -- 单元号(String)

			mr.ROOM_CODE "roomNo", -- 房间编号(String)

			mr.UNIT_NAME "unitName", -- 单元名称(String)

			mr.NEW_BLD_AREA "bldArea", -- 建筑面积（户型）(Double)

			mr.PRODUCT_NAME "ptName", -- 业态名称(String)

			mr.SALE_STATE "saleStatus", -- 销售状态(String)

			mr.ROOM_CODE "roomCode", -- 房间编号(String)

			mr.PRODUCT_CODE "ptId", -- 业态ID(String)

			null "hxName", -- 户型名称(String)

			mr.ROOM_NAME "roomName", -- 房间名称(String)

			UPPER(mbm.r_build_id) "buildingId", -- 楼栋ID(String)

			mr.NEW_IN_AREA "tnArea", -- 套内面积（户型）(Double)

			mr.FLOOR_ID "floorNo", -- 楼层号(String)

			mr.FLOOR_NAME "floor", -- 楼层(String)

			mpm.R_PROJ_ID "projectId", -- 项目ID(String)

			mr.PRODUCT_NAME "productType", --业态名称

			nvl('', '出售') "roomType", --房间类型（默认："出售"）

			decode(isNoPeriod, 1, mpm.R_PROJ_ID, mb.PERIOD_ID) "stageId" --分期Id

		from MDM_ROOM mr left join MDM_BUILD mb on mb.ID = mr.BUILDING_ID

		left join (

			select

				(case when (count(*) over ( partition by PROJECT_ID)) = 1 and STAGE_NAME = '无分期' then 1 else 0

					end) isNoPeriod, dsps.PROJECT_ID

			from SYS_PROJECT_STAGE dsps

		) sps on sps.PROJECT_ID = mr.PROJECT_ID

		left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = mb.PROJ_ID

		LEFT JOIN MDM_BUILD_MAPPING mbm on mr.building_id=mbm.build_id

		where UPPER(mr.BUILDING_ID)=UPPER(buildingId);

--end;
PROCEDURE "P_MDM_EXT_PROJECT_CAP_BUILD" (

	info out sys_refcursor,

	projectGuid in varchar -- 项目id

)

	-- 26.获取项目下的车位&楼栋信息

	-- notes: 存在多条数据，也只会返回第一条数据

	-- @auth hanjm

as

	vProjectGuid varchar(36) := FN_GET_PROJECT_ORIGINAL_ID(projectGuid);

begin

	open info for

		select

			sp.PROJECT_NAME "title", --项目名称(String)

			TO_CHAR(count(*)) "count", --合计（默认返回“0”）(String)

			TO_CHAR(SUM("totalArea")) as "totalArea", --房源面积合计(String)

			TO_CHAR(SUM("totalPt1Area")) as"totalPt1Area", --房源住宅面积(String)

			TO_CHAR(SUM("totalPt2Area")) as "totalPt2Area", --房源公寓面积(String)

			TO_CHAR(SUM("totalPt3Area")) as "totalPt3Area", --房源商业面积(String)

			TO_CHAR(SUM("totalPt4Area")) as "totalPt4Area", --房源车位面积(String)

			TO_CHAR(SUM("totalCount")) as "totalCount", --房源套数合计(String)

			TO_CHAR(SUM("totalPt1Count")) as "totalPt1Count", --房源住宅套数(String)

			TO_CHAR(SUM("totalPt2Count")) as "totalPt2Count", --房源公寓套数(String)

			TO_CHAR(SUM("totalPt3Count")) as "totalPt3Count", --房源商业套数(String)

			TO_CHAR(SUM("totalPt4Count")) as "totalPt4Count", --房源车位套数(String)

			TO_CHAR(SUM("forSaleCount")) as "forSaleCount", --待售套数(String)

			TO_CHAR(SUM("forSalePt1Count")) as "forSalePt1Count", --住宅待售套数(String)

			TO_CHAR(SUM("forSalePt2Count")) as "forSalePt2Count", --公寓待售套数(String)

			TO_CHAR(SUM("forSalePt3Count")) as "forSalePt3Count", --商业待售套数(String)

			TO_CHAR(SUM("forSalePt4Count")) as "forSalePt4Count", --车位待售套数(String)

			TO_CHAR(SUM("qyArea")) as "qyArea", --签约面积(String)

			TO_CHAR(SUM("qyPt1Area")) as "qyPt1Area", --住宅签约面积(String)

			TO_CHAR(SUM("qyPt2Area")) as "qyPt2Area", --公寓签约面积(String)

			TO_CHAR(SUM("qyPt3Area")) as "qyPt3Area", --商业签约面积(String)

			TO_CHAR(SUM("qyPt4Area")) as "qyPt4Area", --车位签约面积(String)

			TO_CHAR(SUM("qyCount")) as "qyCount", --签约套数(String)

			TO_CHAR(SUM("qyPt1Count")) as "qyPt1Count", --住宅签约套数(String)

			TO_CHAR(SUM("qyPt2Count")) as "qyPt2Count", --公寓签约套数(String)

			TO_CHAR(SUM("qyPt3Count")) as "qyPt3Count", --商业签约套数(String)

			TO_CHAR(SUM("qyPt4Count")) as "qyPt4Count", --车位签约套数(String)

			TO_CHAR(SUM("rgCount")) as "rgCount", --认购套数(String)

			TO_CHAR(SUM("rgPt1Count")) as "rgPt1Count", --住宅认购套数(String)

			TO_CHAR(SUM("rgPt2Count")) as "rgPt2Count", --公寓认购套数(String)

			TO_CHAR(SUM("rgPt3Count")) as "rgPt3Count", --商业认购套数(String)

			TO_CHAR(SUM("rgPt4Count")) as "rgPt4Count", --车位认购套数(String)

			TO_CHAR(SUM("rgNoQyCount")) as "rgNoQyCount", --认购未签约套数(String)

			TO_CHAR(SUM("rgNoQyPt1Count")) as "rgNoQyPt1Count", --住宅认购未签约套数(String)

			TO_CHAR(SUM("rgNoQyPt2Count")) as "rgNoQyPt2Count", --公寓认购未签约套数(String)

			TO_CHAR(SUM("rgNoQyPt3Count")) as "rgNoQyPt3Count", --商业认购未签约套数(String)

			TO_CHAR(SUM("rgNoQyPt4Count")) as "rgNoQyPt4Count", --车位认购未签约套数(String)

			TO_CHAR(SUM("ylCount")) as "ylCount", --预留套数(String)

			TO_CHAR(SUM("ylPt1Count")) as "ylPt1Count", --住宅预留套数(String)

			TO_CHAR(SUM("ylPt2Count")) as "ylPt2Count", --公寓预留套数(String)

			TO_CHAR(SUM("ylPt3Count")) as "ylPt3Count", --商业预留套数(String)

			TO_CHAR(SUM("ylPt4Count")) as "ylPt4Count" --车位预留套数(String)

		from MDM_BUILD mb

		inner join (

			select

				sum(case when SALE_STATE = '待售' then 1 else 0 end) "forSaleCount", --待售套数

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt1Count",-- 住宅待售套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt2Count",-- 公寓待售套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt3Count",-- 商业待售套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '待售' then 1 else 0 end) "forSalePt4Count",-- 车位待售套数

				sum(case when SALE_STATE = '签约' then 1 else 0 end) "qyCount", --签约套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '签约' then 1 else 0 end) "qyPt1Count",-- 住宅签约套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '签约' then 1 else 0 end) "qyPt2Count",-- 公寓签约套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '签约' then 1 else 0 end) "qyPt3Count",-- 商办签约套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '签约' then 1 else 0 end) "qyPt4Count",-- 车位签约套数

				sum(case when SALE_STATE = '认购' or SALE_STATE = '签约' then 1 else 0 end) "rgCount", --认购套数(String)

				sum(case when PRODUCT_NAME = '住宅' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt1Count",-- 住宅认购套数

				sum(case when PRODUCT_NAME = '公寓' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt2Count",-- 公寓认购套数

				sum(case when PRODUCT_NAME = '商办' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt3Count",-- 商办认购套数

				sum(case when PRODUCT_NAME = '车位' and (SALE_STATE = '认购' or SALE_STATE = '签约') then 1 else 0 end) "rgPt4Count",-- 车位认购套数

				sum(case when SALE_STATE = '认购' then 1 else 0 end) "rgNoQyCount", --认购未签约套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt1Count",-- 住宅认购未签约套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt2Count",-- 公寓认购未签约套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt3Count",-- 商办认购未签约套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '认购' then 1 else 0 end) "rgNoQyPt4Count",-- 车位认购未签约套数

				sum(case when SALE_STATE = '销控' then 1 else 0 end) "ylCount", --预留套数(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '销控' then 1 else 0 end) "ylPt1Count",-- 住宅预留套数

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '销控' then 1 else 0 end) "ylPt2Count",-- 公寓预留套数

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '销控' then 1 else 0 end) "ylPt3Count",-- 商办预留套数

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '销控' then 1 else 0 end) "ylPt4Count",-- 车位预留套数

				count(1) "totalCount", --房源套数合计(String)

				sum(case when PRODUCT_NAME = '住宅' then 1 else 0 end) "totalPt1Count", --房源住宅套数(String)

				sum(case when PRODUCT_NAME = '公寓' then 1 else 0 end) "totalPt2Count", --房源公寓套数(String)

				sum(case when PRODUCT_NAME = '商办' then 1 else 0 end) "totalPt3Count", --房源商业套数(String)

				sum(case when PRODUCT_NAME = '车位' then 1 else 0 end) "totalPt4Count", --房源车位套数(String)

				sum(NEW_BLD_AREA) "totalArea", --房源面积合计(String)

				sum(case when PRODUCT_NAME = '住宅' then NEW_BLD_AREA else 0 end) "totalPt1Area",-- 房源住宅面积

				sum(case when PRODUCT_NAME = '公寓' then NEW_BLD_AREA else 0 end) "totalPt2Area",-- 房源公寓面积

				sum(case when PRODUCT_NAME = '商办' then NEW_BLD_AREA else 0 end) "totalPt3Area",-- 房源商业面积

				sum(case when PRODUCT_NAME = '车位' then NEW_BLD_AREA else 0 end) "totalPt4Area",-- 房源车位面积

				sum(case when SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyArea", --签约面积(String)

				sum(case when PRODUCT_NAME = '住宅' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt1Area", --住宅签约面积(String)

				sum(case when PRODUCT_NAME = '公寓' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt2Area", --公寓签约面积(String)

				sum(case when PRODUCT_NAME = '商办' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt3Area", --商业签约面积(String)

				sum(case when PRODUCT_NAME = '车位' and SALE_STATE = '签约' then NEW_BLD_AREA else 0 end) "qyPt4Area", --车位签约面积(String)

				BUILDING_ID

			from MDM_ROOM tmr

			group by BUILDING_ID

		) mr on mb.ID = mr.BUILDING_ID

		inner join SYS_PROJECT	sp on mb.PROJ_ID = sp.ID

		where sp.id = vProjectGuid

		group by PROJECT_NAME, PROJ_ID;

--end;
PROCEDURE "P_MDM_EXT_STAGE_BUILDING" (

	info out sys_refcursor

)

	--18. 获取项目、分期、楼栋	/REST/http-listProjectStageBuilding.ac

	-- 注意isParent的值为字符串 避免java接收到BigDecimal

	is

begin

	open info for

		-- 公司

		with

			unit as (

				select

					'1' as "isParent",

					sbu.ORG_NAME as "name",

					sbu.PARENT_ID as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					null as "parentType",

					null as "stageId",

					null as "sn",

					sbu.ID as "id",

					'unit' as "nodeType",

					null "projectId"

				from SYS_BUSINESS_UNIT sbu

				where IS_COMPANY=1

			),

			-- 项目

			project as (

				select

					'1' as "isParent",

					sp.PROJECT_NAME as "name",

					UPPER(sp.UNIT_ID) as "pId",

					sp.UNIT_NAME as "unitName",

					sp.CITY_CODE as "cityCode",

					sp.CITY_NAME as "cityName",

					UPPER(sp.UNIT_ID) as "unitId",

					null as "parentType",

					null as "stageId",

					sp.SN*1 as "sn",

					mpm.R_PROJ_ID as "id",

					'project' as "nodeType",

					null "projectId"

				from SYS_PROJECT sp

				left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sp.ID

				inner join unit on sp.UNIT_ID = unit."id"

			),

			-- 分期

			stage as (

				select

					'1' as "isParent",

					msm.period_name as "name",

					mpm.R_PROJ_ID as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					null as "parentType",

					null as "stageId",

					sps.SN as "sn",

					msm.r_period_id as "id",

					'stage' as "nodeType",

					count(*) over ( partition by sps.PROJECT_ID) cnt,

					null "projectId"

				from SYS_PROJECT_STAGE sps

				LEFT JOIN MDM_PERIOD_MAPPING msm on sps.id=msm.PERIOD_ORIGINAL_ID

				left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sps.PROJECT_ID

				inner join project on sps.PROJECT_ID = project."id"

			),

			--楼栋

			building as (

				select

					'0' as "isParent",

					mbm.BUILD_NAME as "name",

					(case when cnt != 1 or "name" != '无分期' then sb.PERIOD_ID else mpm.R_PROJ_ID end) as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					(case when cnt != 1 or "name" != '无分期' then 'stage' else 'project' end) as "parentType",

					stage."id" as  "stageId",

					null as "sn",

					mbm.r_build_id as "id",

					'building' as "nodeType",

					mpm.R_PROJ_ID "projectId"

				from SYS_BUILD sb

				LEFT JOIN MDM_BUILD_MAPPING mbm on sb.id=mbm.build_id

				inner join stage on sb.PERIOD_ID = stage."id"

				left join MDM_PROJ_MAPPING mpm on mpm.PROJECT_ORIGINAL_ID = sb.PROJ_ID

			)

		select * from project

		union all

		select "isParent", "name", "pId", "unitName", "cityCode", "cityName", "unitId", "parentType",

			   "stageId", "sn", "id", "nodeType", "projectId"

		from stage

		where cnt != 1 or "name" != '无分期'

		union select * from building;

--end;
PROCEDURE		"P_MDM_EXT_STAGE_BUILDING_TREE" (

	info out sys_refcursor

)

-- 注意isParent的值为字符串 避免java接收到BigDecimal

--同步组织架构及用户

--作者：韩金明

--修改者：陈丽 20210318 chenl 

--背景：三亚东岸单元人才公寓项目（暂定），查询无楼栋数据 。//使用了外部映射项目字段关联分期，导致分期下的楼栋inner join不能被查询出来

--调整方式：①项目数据，最后查询，再关联映射id。②楼栋项目id关联项目映射id

	is

begin

	open info for

	-- 公司

		with

			unit as (

				select

					'1' as "isParent",

					sbu.ORG_NAME as "name",

					UPPER(sbu.PARENT_ID) as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					null as "parentType",

					null as "stageId",

					null as "sn",

					UPPER(sbu.ID) as "id",

					'unit' as "nodeType",

					null as "projectId"

				from SYS_BUSINESS_UNIT sbu

				where IS_COMPANY=1 order by ORDER_HIERARCHY_CODE

			),

			-- 项目

			project as (

				select

					'1' as "isParent",

					sp.PROJECT_NAME as "name",

					UPPER(sp.UNIT_ID) as "pId",

					sp.UNIT_NAME as "unitName",

					sp.CITY_CODE as "cityCode",

					sp.CITY_NAME as "cityName",

					UPPER(sp.UNIT_ID) as "unitId",

					null as "parentType",

					null as "stageId",

					sp.SN*1 as "sn",

					sp.ID as "id",

				   -- mpm.R_PROJ_ID as "id",

					'project' as "nodeType",

					null as "projectId"

				from SYS_PROJECT sp

			   -- left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(sp.ID)

				inner join unit on UPPER(sp.UNIT_ID) = UPPER(unit."id") order by  SN

			),

			-- 分期

			stage as (

				select

					'1' as "isParent",

					sps.STAGE_NAME as "name",

					sps.PROJECT_ID as "pId",

					--mpm.R_PROJ_ID as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					null as "parentType",

					null as "stageId",

					sps.SN as "sn",

					sps.ID as "id",

					'stage' as "nodeType",

					count(*) over (partition by sps.PROJECT_ID) cnt,

					null as "projectId"

				from SYS_PROJECT_STAGE sps

			   -- left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(sps.PROJECT_ID)

				inner join project on sps.PROJECT_ID = project."id" order by SN

			),

			--楼栋

			building as (

				select

					'0' as "isParent",

					BUILD_NAME as "name",

					(case when cnt=1 and stage."name"='无分期' then stage."pId" else sb.PERIOD_ID end) as "pId",

					null as "unitName",

					null as "cityCode",

					null as "cityName",

					null as "unitId",

					(case when cnt=1 and stage."name" = '无分期' then 'project' else 'stage' end) as "parentType",

					stage."id" as  "stageId",

					null as "sn",

					sb.id as "id",

					'building' as "nodeType",

					 sb.PROJ_ID as "projectId"

				from SYS_BUILD sb

				inner join stage on UPPER(sb.PERIOD_ID) = UPPER(stage."id") order by ORDER_HIERARCHY_CODE

			)

			

			,resultdata as(

		select * from unit 

		union all

		select	proj."isParent",

					proj."name",

					proj."pId",

					proj."unitName",

					proj."cityCode",

					proj."cityName",

					proj."unitId",

					proj."parentType",

					proj."stageId",

					proj."sn",

					mpm.R_PROJ_ID as "id",

					proj."nodeType",

					mpm.R_PROJ_ID from project proj

		left join MDM_PROJ_MAPPING mpm on UPPER(mpm.PROJECT_ORIGINAL_ID) = UPPER(proj."id")

		union all

		select stage."isParent", msm.period_name as "name", mpm.R_PROJ_ID as "pId", stage."unitName", stage."cityCode", stage."cityName", stage."unitId", stage."parentType",

			   stage."stageId", stage."sn",	 msm.R_PERIOD_ID AS "id", stage."nodeType", stage."projectId"

		from stage stage

		left join MDM_PERIOD_MAPPING msm on UPPER(msm.PERIOD_ORIGINAL_ID) = UPPER(stage."id")

		left join MDM_PROJ_MAPPING mpm on UPPER(stage."pId") = UPPER(mpm.PROJECT_ORIGINAL_ID)

		where cnt != 1 or "name" != '无分期'

		union all select b."isParent",

					mbm.BUILD_NAME AS "name",

					--分期使用映射的分期id。 无分期，使用楼栋已处理的父级分期id（项目id）

					(case when "parentType"='stage' then msm.R_PERIOD_ID else b."pId"  end) as "pId",

					b."unitName",

					b."cityCode",

					b."cityName",

					b."unitId",

					b."parentType",

					--分期使用映射的分期id。 无分期 null

				   (case when "parentType"='stage' then msm.R_PERIOD_ID else null  end)	 "stageId",

					b."sn",

					mbm.R_BUILD_ID AS "id",

					b."nodeType",

					mpm.R_PROJ_ID	from building b

		LEFT JOIN MDM_BUILD_MAPPING mbm on	 UPPER(b."id") =UPPER(mbm.BUILD_ID)

		--关联分期，获取楼栋父级id（分期id）

		left join MDM_PERIOD_MAPPING msm on	 UPPER(b."pId") = UPPER(msm.PERIOD_ORIGINAL_ID)

		--关联项目，获取楼栋所属项目id

		left join MDM_PROJ_MAPPING mpm on UPPER(b."projectId") = UPPER(mpm.PROJECT_ORIGINAL_ID))

		

		select * from resultdata

		;

		
end;