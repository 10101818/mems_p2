CREATE DATABASE [MEHS_DB] COLLATE Chinese_PRC_CS_AS_KS_WS
GO

USE [MEHS_DB]
GO

-- 角色
CREATE TABLE [dbo].[lkpRole](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpRole PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpRole] VALUES(0,'系统管理员') 		--Admin
INSERT INTO [lkpRole] VALUES(1,'超级管理员') 		--服务主管
INSERT INTO [lkpRole] VALUES(2,'管理员')			--服务人员
INSERT INTO [lkpRole] VALUES(3,'超级用户')			--设备科主管
INSERT INTO [lkpRole] VALUES(4,'普通用户')
GO

-- 设备状态
CREATE TABLE [dbo].[lkpEquipmentStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpEquipmentStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpEquipmentStatus] VALUES(1,'正常')
INSERT INTO [lkpEquipmentStatus] VALUES(2,'故障')
INSERT INTO [lkpEquipmentStatus] VALUES(3,'已报废')
GO

-- 使用状态
CREATE TABLE [dbo].[lkpUsageStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpUsageStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpUsageStatus] VALUES(1,'使用')
INSERT INTO [lkpUsageStatus] VALUES(2,'停用')
GO

-- 紧急程度
CREATE TABLE [dbo].[lkpUrgency](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpUrgency PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpUrgency] VALUES(1,'普通')
INSERT INTO [lkpUrgency] VALUES(2,'紧急')
GO

-- 周期类型
CREATE TABLE [dbo].[lkpPeriodType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpPeriodType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpPeriodType] VALUES(1,'天/次')
INSERT INTO [lkpPeriodType] VALUES(3,'月/次')
INSERT INTO [lkpPeriodType] VALUES(4,'年/次')
GO

-- 供应商类型
CREATE TABLE [dbo].[lkpSupplierType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpSupplierType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpSupplierType] VALUES(1,'厂商')
INSERT INTO [lkpSupplierType] VALUES(2,'代理商')
INSERT INTO [lkpSupplierType] VALUES(3,'经销商')
INSERT INTO [lkpSupplierType] VALUES(4,'其他供应商')
GO

-- 合同类型
CREATE TABLE [dbo].[lkpContractType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpContractType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpContractType] VALUES(1,'原厂服务合同')
INSERT INTO [lkpContractType] VALUES(2,'第三方供应商服务合同')
GO

-- 合同范围
CREATE TABLE [dbo].[lkpContractScope](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpContractScope PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpContractScope] VALUES(1,'全保')
INSERT INTO [lkpContractScope] VALUES(2,'技术保')
INSERT INTO [lkpContractScope] VALUES(3,'其他')
GO

-- 故障类型
CREATE TABLE [dbo].[lkpFaultType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpFaultType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpFaultType] VALUES(1,'未知')

-- 客户请求状态
CREATE TABLE [dbo].[lkpRequestStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpRequestStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpRequestStatus] VALUES(-1,'终止')
INSERT INTO [lkpRequestStatus] VALUES(1,'新建')
INSERT INTO [lkpRequestStatus] VALUES(2,'已分配')
INSERT INTO [lkpRequestStatus] VALUES(3,'已响应')
INSERT INTO [lkpRequestStatus] VALUES(4,'待审批')
INSERT INTO [lkpRequestStatus] VALUES(5,'待分配')
INSERT INTO [lkpRequestStatus] VALUES(6,'问题升级')
INSERT INTO [lkpRequestStatus] VALUES(7,'待第三方支持')
INSERT INTO [lkpRequestStatus] VALUES(99,'关闭')
GO

-- 派工单状态
CREATE TABLE [dbo].[lkpDispatchStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDispatchStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDispatchStatus] VALUES(-1,'终止')
INSERT INTO [lkpDispatchStatus] VALUES(1,'新建')
INSERT INTO [lkpDispatchStatus] VALUES(2,'已响应')
INSERT INTO [lkpDispatchStatus] VALUES(3,'待审批')
INSERT INTO [lkpDispatchStatus] VALUES(4,'已审批')
GO

-- 请求处理方式
CREATE TABLE [dbo].[lkpDealType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDealType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDealType] VALUES(1,'现场服务')
INSERT INTO [lkpDealType] VALUES(2,'电话解决')
INSERT INTO [lkpDealType] VALUES(3,'远程解决')
INSERT INTO [lkpDealType] VALUES(4,'第三方支持')
GO

-- 作业报告类型
CREATE TABLE [dbo].[lkpDispatchReportType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDispatchReportType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDispatchReportType] VALUES(1,'通用作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(101,'维修作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(201,'保养作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(301,'强检作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(401,'巡检作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(501,'校准作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(601,'设备新增作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(701,'不良事件作业报告')
INSERT INTO [lkpDispatchReportType] VALUES(901,'验收安装作业报告')
GO

-- 作业报告结果状态
CREATE TABLE [dbo].[lkpSolutionResultStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpSolutionResultStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpSolutionResultStatus] VALUES(1,'待分配')
INSERT INTO [lkpSolutionResultStatus] VALUES(2,'问题升级')
INSERT INTO [lkpSolutionResultStatus] VALUES(3,'待第三方支持')
INSERT INTO [lkpSolutionResultStatus] VALUES(4,'已解决')
GO

-- 服务凭证结果状态
CREATE TABLE [dbo].[lkpDispatchJournalResultStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDispatchJournalResultStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDispatchJournalResultStatus] VALUES(1,'待跟进')
INSERT INTO [lkpDispatchJournalResultStatus] VALUES(2,'完成')
GO

-- 作业报告/服务凭证审批状态
CREATE TABLE [dbo].[lkpDispatchDocStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDispatchDocStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDispatchDocStatus] VALUES(1,'新建')
INSERT INTO [lkpDispatchDocStatus] VALUES(2,'待审批')
INSERT INTO [lkpDispatchDocStatus] VALUES(3,'已审批')
INSERT INTO [lkpDispatchDocStatus] VALUES(99,'已终止')
GO


-- 医疗设备分类(三级)
CREATE TABLE [dbo].[lkpEquipmentClass](
	[Level] [int] NOT NULL,
	[ParentCode] [varchar](4) NOT NULL,
	[Code] [varchar](2) NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	CONSTRAINT PK_lkpEquipmentClass PRIMARY KEY ([ParentCode], [Code])
)
GO
CREATE INDEX IX_lkpEquipmentClass ON [lkpEquipmentClass] ([Level])
GO
--insert records with file: lkpEquipmentClass.sql

-- 科室
CREATE TABLE [dbo].[lkpDepartmentType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpDepartmentType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDepartmentType] VALUES(1,'医技科室')
INSERT INTO [lkpDepartmentType] VALUES(2,'临床科室')
INSERT INTO [lkpDepartmentType] VALUES(9,'其他科室')
GO

CREATE TABLE [dbo].[lkpDepartment](
	[ID] [int] IDENTITY(0,1) NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	[Pinyin] [varchar](100) NULL,
	[Seq] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	CONSTRAINT PK_lkpDepartment PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpDepartment] VALUES('其他','qt',99999,9)

-- 请求类型
CREATE TABLE [dbo].[lkpRequestType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpRequestType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpRequestType] VALUES(1,'维修')
INSERT INTO [lkpRequestType] VALUES(2,'保养')
INSERT INTO [lkpRequestType] VALUES(3,'强检')
INSERT INTO [lkpRequestType] VALUES(4,'巡检')
INSERT INTO [lkpRequestType] VALUES(5,'校准')
INSERT INTO [lkpRequestType] VALUES(6,'设备新增')
INSERT INTO [lkpRequestType] VALUES(7,'不良事件')
INSERT INTO [lkpRequestType] VALUES(8,'合同档案')
INSERT INTO [lkpRequestType] VALUES(9,'验收安装')
INSERT INTO [lkpRequestType] VALUES(10,'调拨')
INSERT INTO [lkpRequestType] VALUES(11,'借用')
INSERT INTO [lkpRequestType] VALUES(12,'盘点')
INSERT INTO [lkpRequestType] VALUES(13,'报废')
INSERT INTO [lkpRequestType] VALUES(14,'其他服务')
GO

-- 用户
CREATE TABLE [dbo].[tblUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoginID] [varchar](20) NOT NULL,
	[LoginPwd] [varchar](50) NOT NULL,
	[Name] [nvarchar] (20) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Department] [int] NOT NULL,
	[Mobile] [nvarchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,									--1正常、0停用
	[VerifyStatus] [int] NOT NULL,  							--激活状态 1已通过 2待审批 3已拒绝
	[Comments] [nvarchar](500) NULL,
	[LastLoginDate] [datetime] NULL,
	[WebSessionID] [varchar](50) NULL,
	[SessionID] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	[RegistrationID] [varchar](100) NULL,
	[OSName] [varchar](50) NULL,
	CONSTRAINT PK_tblUser PRIMARY KEY ([ID]),
	CONSTRAINT [IX_tblUser] UNIQUE NONCLUSTERED ([LoginID])
)
GO
--add default Admin user
INSERT INTO [tblUser] ([LoginID],[LoginPwd],[Name],[RoleID],[IsActive],[VerifyStatus],[Department]) VALUES('Admin','','系统管理员',0,1,1,0)
GO

--发送验证码
CREATE TABLE [dbo].[tblPhoneVerify](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MobilePhone] [varchar](20) NOT NULL,
	[VerificationCode] [varchar](10) NOT NULL,
	[IsUsed] [bit] NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblPhoneVerify PRIMARY KEY ([ID])
)
GO
CREATE INDEX IX_Phone ON [tblPhoneVerify] ([MobilePhone],[CreatedTime])
GO

-- 设备资产
CREATE TABLE [dbo].[tblEquipment](
	[ID] [int] IDENTITY(1,1) NOT NULL,			
	[EquipmentLevel] [int] NOT NULL, 			-- 1,2,3类医疗器械
	[Name] [nvarchar] (30) NOT NULL,			-- 设备名称
	[EquipmentCode] [nvarchar](30) NOT NULL, 	-- 设备型号
	[SerialCode] [nvarchar](30) NOT NULL,		-- 设备序列号
	[ManufacturerID] [int] NOT NULL,			-- 设备厂商
	[EquipmentClass1] [varchar](2) NOT NULL,	-- 设备分类一级
	[EquipmentClass2] [varchar](2) NOT NULL,	-- 设备分类二级
	[EquipmentClass3] [varchar](2) NOT NULL,	-- 设备分类三级
	[ResponseTimeLength] [int] NOT NULL,		-- 标准响应时间时长
	[ServiceScope] [bit] NOT NULL,				-- 整包范围
	[Brand] [nvarchar] (30) NULL,				-- 品牌
	[Comments] [nvarchar](100) NULL,			-- 备注
	[ManufacturingDate] [datetime] NULL,		-- 出厂日期
	
	[FixedAsset] [bit] NOT NULL,				-- 固定资产
	[AssetCode] [nvarchar](30) NOT NULL,        -- 医院系统资产编号
	[AssetLevel] [int] NOT NULL,				-- 资产等级
	[DepreciationYears] [int] NOT NULL,			-- 折旧年限——折旧率根据采购日期判断
	[ValidityStartDate] [datetime] NULL,		-- 注册证有效开始日期
	[ValidityEndDate] [datetime] NULL,	  		-- 注册证有效结束日期
	
	[SaleContractName] [nvarchar](30) NOT NULL,	-- 销售合同名称
	[SupplierID] [int] NOT NULL,				-- 供应商
	[PurchaseWay] [nvarchar](30) NOT NULL,		-- 购入方式
	[PurchaseAmount] [decimal](10, 2) NOT NULL,	-- 采购金额
	[PurchaseDate] [datetime] NULL,				-- 采购日期
	[IsImport] [bit] NOT NULL,					-- 设备产地 1进口、0国产
	
	[DepartmentID] [int] NOT NULL,		 		-- 使用科室
	[InstalSite] [nvarchar](30) NOT NULL, 		-- 安装地点
	[InstalDate] [datetime] NULL,  				-- 安装日期
	[UseageDate] [datetime] NULL,  				-- 启用日期
	[Accepted] [bit] NOT NULL,					-- 验收状态
	[AcceptanceDate] [datetime] NULL,			-- 验收日期
	[UsageStatusID] [int] NOT NULL,		 		-- 使用状态
	[EquipmentStatusID] [int] NOT NULL,			-- 设备状态
	[ScrapDate] [datetime] NULL,				-- 报废时间
	[MaintenancePeriod] [int] NOT NULL,			-- 保养周期
	[MaintenanceTypeID] [int] NOT NULL,			-- 保养周期类型
	[LastMaintenanceDate] [datetime] NULL,  	-- 上次保养日期
	[PatrolPeriod] [int] NOT NULL,				-- 巡检周期
	[PatrolTypeID] [int] NOT NULL,				-- 巡检周期类型
	[LastPatrolDate] [datetime] NULL,  			-- 上次巡检日期
	[CorrectionPeriod] [int] NOT NULL,			-- 校准周期
	[CorrectionTypeID] [int] NOT NULL,			-- 校准周期类型
	[LastCorrectionDate] [datetime] NULL, 	 	-- 上次校准日期
	[MandatoryTestStatus] [int] NOT NULL,		-- 强检标记
	[MandatoryTestDate] [datetime] NULL,		-- 强检时间
	[RecallFlag] [bit] NOT NULL,				-- 召回标记
	[RecallDate] [datetime] NULL,				-- 召回时间
	[CreateDate] [datetime] NOT NULL,			-- 添加时间
	[CreateUserID] [int] NOT NULL,				-- 添加用户
	[UpdateDate] [datetime] NULL,				-- 更新时间
	CONSTRAINT PK_tblEquipment PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_SerialCode ON [tblEquipment] ([SerialCode])
GO
CREATE INDEX IX_Status ON [tblEquipment] ([UsageStatusID],[EquipmentStatusID])
GO
CREATE INDEX IX_Flag ON [tblEquipment] ([MaintenanceTypeID],[PatrolTypeID],[CorrectionTypeID],[MandatoryTestStatus])
GO
CREATE INDEX IX_DepartmentID ON [tblEquipment] ([DepartmentID])
GO

-- 设备资产文件
CREATE TABLE [dbo].[tblEquipmentFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblEquipmentFile PRIMARY KEY ([ID]),
)
GO

-- 更新日志
CREATE TABLE [dbo].[tblAuditHdr](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ObjectTypeID] [int] NOT NULL,					-- 操作对象类型
	[ObjectID] [int] NOT NULL,						-- 对象ID
	[UserID] [int] NOT NULL,						-- 操作者id
	[UpdateDate] [datetime] NOT NULL,				-- 修改时间
	CONSTRAINT PK_tblAuditHdr PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_tblAuditHdr ON [tblAuditHdr] ([ObjectTypeID],[ObjectID])
GO
-- 日志详细信息
CREATE TABLE [dbo].[tblAuditDetail](
	[AuditID] [int] NOT NULL,
	[FieldName] [varchar](50) NOT NULL,			-- 操作字段名称
	[OldValue] [nvarchar](500) NOT NULL,			-- 编辑前字段信息
	[NewValue] [nvarchar](500) NOT NULL,			-- 编辑后字段信息
	CONSTRAINT PK_tblAuditDetail PRIMARY KEY ([AuditID],[FieldName]),
)
GO

-- 服务合同
CREATE TABLE [dbo].[tblContract](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NOT NULL,				-- 供应商
	[ContractNum] [nvarchar](20) NOT NULL,		-- 合同编号
	[Name] [nvarchar](50) NOT NULL,				-- 合同名称
	[TypeID] [int] NOT NULL,					-- 合同类型
	[ScopeID] [int] NOT NULL,					-- 服务范围
	[ScopeComments] nvarchar(50) NULL,			-- 其他范围备注
	[Amount] [decimal](12, 2) NOT NULL,			-- 合同金额
	[ProjectNum] [nvarchar](20) NULL,			-- 投标项目编号	
	[StartDate] [datetime] NOT NULL,			-- 开始日期
	[EndDate] [datetime] NOT NULL,  			-- 结束日期
	[Comments] [nvarchar](500) NULL,			-- 备注
	CONSTRAINT PK_tblContract PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_tblContract ON [tblContract] ([SupplierID],[TypeID],[StartDate],[EndDate])
GO

-- 服务合同设备关联表
CREATE TABLE [dbo].[jctContractEqpt](
	[ContractID] [int] NOT NULL,
	[EquipmentID] [int] NOT NULL,
	CONSTRAINT PK_jctContractEqpt PRIMARY KEY ([ContractID],[EquipmentID]),
)
GO

-- 服务合同文件
CREATE TABLE [dbo].[tblContractFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ContractID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblContractFile PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Contract ON [tblContractFile] ([ContractID])
GO

-- 供应商
CREATE TABLE [dbo].[tblSupplier](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NOT NULL,					-- 供应商类型
	[Name] [nvarchar](50) NOT NULL,				-- 供应商名称
	[Province] [nvarchar](50) NOT NULL,			-- 供应商省份
	[Mobile] [nvarchar](20) NULL,				-- 供应商电话
	[Address] [nvarchar](255) NULL,				-- 供应商地址
	[Contact] [nvarchar](20) NOT NULL,			-- 供应商联系人
	[ContactMobile] [nvarchar](20) NULL,			-- 联系电话
	[IsActive] [bit] NOT NULL,					-- 状态 1正常、0停用
	[AddDate] [datetime] NOT NULL,				-- 添加日期	
	CONSTRAINT PK_tblSupplier PRIMARY KEY ([ID]),
	CONSTRAINT [IX_tblSupplier] UNIQUE NONCLUSTERED ([TypeID],[Name])
)
GO

-- 供应商附件
CREATE TABLE [dbo].[tblSupplierFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblSupplierFile PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Supplier ON [tblSupplierFile] ([SupplierID])
GO

-- 客户请求
CREATE TABLE [dbo].[tblRequest](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Source] [int] NOT NULL, 					-- 请求来源 1客户请求,2系统请求,3手工请求
	[RequestType] [int] NOT NULL,				-- 服务类型
	[RequestUserID] [int] NULL, 				-- 请求人
	[RequestUserName] [nvarchar] (20) NULL,		
	[RequestUserMobile] [varchar](20) NULL,		
	[Subject] [nvarchar](50) NOT NULL,			-- 主题
	[EquipmentStatus] [int] NULL,	 			-- 机器状态
	[FaultTypeID] [int] NULL,		 			-- 故障分类
	[FaultDesc] [nvarchar](200) NOT NULL,		-- 故障描述
	[StatusID] [int] NOT NULL, 					-- 状态
	[DealTypeID] [int] NOT NULL, 				-- 处理方式
	[PriorityID] [int] 		 NULL,				-- 优先级  更换为 紧急程度
	[RequestDate] [datetime] NOT NULL,			-- 开始日期
	[DistributeDate] [datetime] NULL,			-- 首次分配时间
	[DispatchDate] [datetime] NULL,				-- 首次派工时间
	[ResponseDate] [datetime] NULL,				-- 首次响应时间
	[CloseDate] [datetime] NULL,  				-- 结束日期
	[LastStatusID] [int] NOT NULL, 				-- 派工前状态	
	[IsRecall] [bit] NOT NULL,					-- 是否召回
	[SelectiveDate] [datetime] NULL,			-- 择期时间
	CONSTRAINT PK_tblRequest PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Status ON [tblRequest] ([StatusID],[RequestDate])
GO

-- 请求设备关联表
CREATE TABLE [dbo].[jctRequestEqpt](
	[RequestID] [int] NOT NULL,
	[EquipmentID] [int] NOT NULL,
	CONSTRAINT PK_jctRequestEqpt PRIMARY KEY ([RequestID],[EquipmentID]),
)
GO

-- 客户请求附件
CREATE TABLE [dbo].[tblRequestFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblRequestFile PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_tblRequestFile ON [tblRequestFile] ([RequestID])
GO

-- 请求历史
CREATE TABLE [dbo].[tblRequestHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[OperatorID] [int] NOT NULL,
	[Action] [int] NOT NULL,									-- 1: 新增 , 2: 派工, 3:更新状态, 4: 终止
	[Comments] [nvarchar](255) NULL,
	[TransDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblRequestHistory PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_RequestID ON [tblRequestHistory] ([RequestID],[TransDate])
GO

-- 派工单
CREATE TABLE [dbo].[tblDispatch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NOT NULL,
	[RequestType] [int] NOT NULL,				-- 服务类型
	[UrgencyID] [int] NOT NULL,					-- 紧急程度
	[EquipmentStatus] [int]	NOT NULL,	 		-- 机器状态
	[EngineerID] [int] NOT NULL,				-- 工程师
	[ScheduleDate] [datetime] NOT NULL,			-- 计划日期
	[LeaderComments] [nvarchar](200) NOT NULL,	-- 备注
	[StatusID] [int] NOT NULL, 					-- 状态
	[CreateDate] [datetime] NULL,				-- 生成日期
	[StartDate] [datetime] NULL,				-- 开始日期
	[EndDate] [datetime] NULL,		  			-- 结束日期
	CONSTRAINT PK_tblDispatch PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Status ON [tblDispatch] ([StatusID],[ScheduleDate])
GO
CREATE INDEX IX_Engineer ON [tblDispatch] ([EngineerID])
GO

-- 派工单历史
CREATE TABLE [dbo].[tblDispatchHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchID] [int] NOT NULL,
	[OperatorID] [int] NOT NULL,
	[Action] [int] NOT NULL,									-- 1: 新增 , 2: 响应, 3:完成, 4: 终止
	[Comments] [nvarchar](255) NULL,					
	[TransDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblDispatchHistory PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_DispatchID ON [tblDispatchHistory] ([DispatchID],[TransDate])
GO

-- 作业报告
CREATE TABLE [dbo].[tblDispatchReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchID] [int] NOT NULL,						-- 关联派工单编号
	[TypeID] [int] NOT NULL,							-- 作业报告类型	
	[FaultCode] [nvarchar](20) NOT NULL,				-- 错误代码	
	[FaultDesc] [nvarchar](500) NOT NULL,				-- 详细故障描述 / 强检要求
	[SolutionCauseAnalysis] [nvarchar](500) NOT NULL,	-- 分析原因 / 报告明细
	[SolutionWay] [nvarchar](500) NOT NULL, 			-- 处理方式
	[IsPrivate] [bit] NULL,								-- 专用报告 (强检)
	[ServiceProvider] [int] NULL,						-- 服务提供方 (保养:管理方；第三方；厂家)
	[SolutionResultStatusID] [int] NOT NULL,			-- 作业报告结果状态
	[SolutionUnsolvedComments] [nvarchar](500) NULL,	-- 问题升级
	[EquipmentStatus] [int] NULL,						-- 设备状态 (离场)
	[PurchaseAmount] [decimal](10, 2) NULL,				-- 资产金额
	[ServiceScope] [bit] NULL,							-- 整包范围
	[Result] [nvarchar] (500) NULL,						-- 结果
	[IsRecall] [bit] NULL,								-- 待召回
	[AcceptanceDate] [datetime] NULL,					-- 验收日期
	[DelayReason] [nvarchar](500) NULL,					-- 误工说明
	[Comments] [nvarchar](500) NULL,					-- 备注信息
	[FujiComments] [nvarchar](200) NULL,				-- 审批备注
	[StatusID] [int] NOT NULL,							-- 派工单审批状态
	CONSTRAINT PK_tblDispatchReport PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Status ON [tblDispatchReport] ([StatusID])
GO
CREATE INDEX IX_Dispatch ON [tblDispatchReport] ([DispatchID])
GO

-- 作业报告附件
CREATE TABLE [dbo].[tblDispatchReportFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblDispatchReportFile PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_DispatchReport ON [tblDispatchReportFile] ([DispatchReportID])
GO

-- 作业报告历史
CREATE TABLE [dbo].[tblDispatchReportHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,
	[OperatorID] [int] NOT NULL,
	[Action] [int] NOT NULL,											-- 1: 提交 , 2: 通过, 3：退回
	[Comments] [nvarchar](255) NULL,					
	[TransDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblDispatchReportHistory PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_DispatchReportID ON [tblDispatchReportHistory] ([DispatchReportID],[TransDate])
GO

-- 零配件
CREATE TABLE [dbo].[tblReportAccessory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,			-- 关联工作报告编号
	[Name] [nvarchar](50) NOT NULL,				-- 零配件名称
	[SourceID] [int] NOT NULL,					-- 来源
	[SupplierID] [int] NULL,					-- 外部供应商
	[NewSerialCode] [nvarchar](30) NOT NULL,		-- 新装零配件序列号
	[OldSerialCode] [nvarchar](30) NOT NULL,		-- 拆下零配件序列号
	[Qty] [int] NOT NULL,						-- 新装零配件数量
	[Amount] [decimal](10, 2) NOT NULL,			-- 新装零配件金额
	CONSTRAINT PK_tblReportAccessory PRIMARY KEY ([ID]),
)
GO

-- 零配件来源类型
CREATE TABLE [dbo].[lkpAccessorySourceType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpAccessorySourceType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpAccessorySourceType] VALUES(1,'外部供应商')
INSERT INTO [lkpAccessorySourceType] VALUES(2,'备件库')
GO

-- 零配件附件
CREATE TABLE [dbo].[tblReportAccessoryFile](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReportAccessoryID] [int] NOT NULL,
	[FileName] [nvarchar](200) NOT NULL,
	[FileType] [int] NOT NULL,					--	1、新装附件；2、拆下附件
	[FileDesc] [nvarchar](200) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	CONSTRAINT PK_tblReportAccessoryFile PRIMARY KEY ([ID]),
)
GO

-- 服务凭证
CREATE TABLE [dbo].[tblDispatchJournal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchID] [int] NOT NULL,						-- 关联派工单编号
	[FaultCode] [nvarchar](500) NOT NULL,				-- 故障现象/错误代码/事由
	[JobContent] [nvarchar](500) NOT NULL,				-- 工作内容
	[ResultStatusID] [int] NOT NULL,					-- 服务结果
	[FollowProblem] [nvarchar](500) NOT NULL,			-- 待跟进问题
	[Advice] [nvarchar](500) NOT NULL,					-- 建议留言
	[UserName] [nvarchar] (20) NULL,		
	[UserMobile] [nvarchar](20) NULL,
	[Signed] [bit] NULL,		 						-- 是否签名
	[FujiComments] [nvarchar](200) NULL,				-- 审批备注
	[StatusID] [int] NOT NULL,							-- 审核状态
	CONSTRAINT PK_tblDispatchJournal PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Status ON [tblDispatchJournal] ([StatusID])
GO
CREATE INDEX IX_Dispatch ON [tblDispatchJournal] ([DispatchID])
GO

-- 服务凭证历史
CREATE TABLE [dbo].[tblDispatchJournalHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchJournalID] [int] NOT NULL,
	[OperatorID] [int] NOT NULL,
	[Action] [int] NOT NULL,											-- 1: 提交 , 2: 通过, 3：退回
	[Comments] [nvarchar](255) NULL,					
	[TransDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblDispatchJournalHistory PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_DispatchJournalID ON [tblDispatchJournalHistory] ([DispatchJournalID],[TransDate])
GO

-- 系统设置
CREATE TABLE [dbo].[tblControl](
	[AdminEmail] [varchar](50) NULL,
	[SmtpHost] [varchar](255) NULL,
	[SmtpPort] [int] NULL,
	[SmtpUseSsl] [bit] NULL,
	[SmtpUserName] [varchar](50) NULL,
	[SmtpPwd] [varchar](20) NULL,
	[SmtpEmailFrom] [varchar](50) NULL,
	[AppValidVersion] [varchar](30) NULL,
	[MessageEnabled] [bit] NULL,
	[MessageKey] [varchar](50) NULL,
	[MobilePhone] [varchar](50) NULL,
	[WillExpireTime] [int] NULL,
	[OverDueTime] [int] NULL,
	[ErrorMessage] [nvarchar](50) NULL
) ON [PRIMARY]
GO
INSERT INTO tblControl (AdminEmail,WillExpireTime,OverDueTime,ErrorMessage) VALUES (null,30,18,'请联系管理员')
GO

-- 系统设置-通知
CREATE TABLE [dbo].[tblNotice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Content] [nvarchar](500) NOT NULL,
	[Comments] [nvarchar](500) NULL,
	[IsLoop] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL
	CONSTRAINT PK_tblNotice PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_IsLoop ON [tblNotice] ([IsLoop])
GO


-- 自定义报表
CREATE TABLE [dbo].[lkpCustomReportType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpCustomReportType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpCustomReportType] VALUES(1,'设备')
INSERT INTO [lkpCustomReportType] VALUES(2,'合同')
INSERT INTO [lkpCustomReportType] VALUES(3,'请求')
INSERT INTO [lkpCustomReportType] VALUES(4,'派工单')
GO

CREATE TABLE [dbo].[lkpCustRptTemplateTable](
	[TypeID] [int] NOT NULL,
	[Seq] [int] NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[TableDesc] [nvarchar](50) NOT NULL,
	CONSTRAINT PK_lkpCustRptTemplateTable PRIMARY KEY ([TypeID], [Seq])
)
GO
CREATE UNIQUE INDEX IX_TableName ON [lkpCustRptTemplateTable] ([TypeID], [TableName])
CREATE UNIQUE INDEX IX_TableDesc ON [lkpCustRptTemplateTable] ([TypeID],[TableDesc])
GO
INSERT INTO [lkpCustRptTemplateTable] VALUES(1,1 ,'tblEquipment', '设备')
INSERT INTO [lkpCustRptTemplateTable] VALUES(1,2 ,'tblManufacturer', '设备厂商')
INSERT INTO [lkpCustRptTemplateTable] VALUES(1,3 ,'tblSupplier', '经销商')
INSERT INTO [lkpCustRptTemplateTable] VALUES(2,1 ,'tblContract', '合同')
INSERT INTO [lkpCustRptTemplateTable] VALUES(2,2 ,'tblEquipment', '设备')
INSERT INTO [lkpCustRptTemplateTable] VALUES(2,3 ,'tblSupplier', '供应商')
INSERT INTO [lkpCustRptTemplateTable] VALUES(3,1 ,'tblRequest', '请求')
INSERT INTO [lkpCustRptTemplateTable] VALUES(3,2 ,'tblEquipment', '设备')
INSERT INTO [lkpCustRptTemplateTable] VALUES(3,3 ,'tblManufacturer', '设备厂商')
INSERT INTO [lkpCustRptTemplateTable] VALUES(4,1 ,'tblDispatch', '派工单')
INSERT INTO [lkpCustRptTemplateTable] VALUES(4,2 ,'tblDispatchReport', '作业报告')
INSERT INTO [lkpCustRptTemplateTable] VALUES(4,3 ,'tblDispatchJournal', '服务凭证')
INSERT INTO [lkpCustRptTemplateTable] VALUES(4,4 ,'tblRequest', '请求')
GO

CREATE TABLE [dbo].[lkpCustRptTemplateField](
	[TypeID] [int] NOT NULL,
	[Seq] [int] NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[FieldName] [varchar](50) NOT NULL,
	[FieldDesc][nvarchar](50) NOT NULL,
	CONSTRAINT PK_lkpCustRptTemplate PRIMARY KEY ([TypeID], [Seq])
)
GO
CREATE UNIQUE INDEX IX_FieldName ON [lkpCustRptTemplateField] ([TypeID], [TableName],[FieldName])
CREATE UNIQUE INDEX IX_FieldDesc ON [lkpCustRptTemplateField] ([TypeID],[FieldDesc])
GO
INSERT INTO [lkpCustRptTemplateField] VALUES(1,1 ,'tblEquipment','EquipmentID','设备系统编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,2 ,'tblEquipment','EquipmentName','设备名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,3 ,'tblEquipment','EquipmentCode','设备型号')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,4 ,'tblEquipment','SerialCode','设备序列号')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,5 ,'tblEquipment','EquipmentLevelDesc','等级')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,6 ,'tblEquipment','EquipmentClass1Name','设备分类一级')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,7 ,'tblEquipment','EquipmentClass2Name','设备分类二级')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,8 ,'tblEquipment','EquipmentClass3Name','设备分类三级')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,9 ,'tblEquipment','ResponseTimeLength','标准响应时间(分)')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,10 ,'tblEquipment','ServiceScopeDesc','整包范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,11 ,'tblEquipment','Brand','品牌')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,12 ,'tblEquipment','EquipmentComments','备注')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,13 ,'tblEquipment','ManufacturingDate','出厂日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,14 ,'tblEquipment','FixedAsset','固定资产')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,15 ,'tblEquipment','AssetCode','医院系统资产编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,16 ,'tblEquipment','AssetLevel','资产等级')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,17 ,'tblEquipment','DepreciationYears','折旧年限')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,18 ,'tblEquipment','ValidityStartDate','注册证有效开始日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,19 ,'tblEquipment','ValidityEndDate','注册证有效结束日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,20 ,'tblEquipment','SaleContractName','销售合同名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,21 ,'tblEquipment','PurchaseWay','购入方式')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,22 ,'tblEquipment','EquipmentPurchaseAmount','采购金额')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,23 ,'tblEquipment','PurchaseDate','采购日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,24 ,'tblEquipment','IsImport','设备产地')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,25 ,'tblEquipment','DepartmentName','使用科室')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,26 ,'tblEquipment','InstalSite','安装地点')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,27 ,'tblEquipment','InstalDate','安装日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,28 ,'tblEquipment','UseageDate','启用日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,29 ,'tblEquipment','Accepted','验收状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,30 ,'tblEquipment','AcceptanceDate','验收日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,31 ,'tblEquipment','UsageStatusDesc','使用状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,32 ,'tblEquipment','EquipmentStatusDesc','设备状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,33 ,'tblEquipment','MandatoryTestStatusDesc','强检标记')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,34 ,'tblEquipment','MandatoryTestDate','强检时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,35 ,'tblEquipment','RecallFlag','召回标记')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,36 ,'tblEquipment','RecallDate','召回时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,37 ,'tblEquipment','PatrolPeriod','巡检周期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,38 ,'tblEquipment','PatrolTypeDesc','巡检周期类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,39 ,'tblEquipment','MaintenancePeriod','保养周期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,40 ,'tblEquipment','MaintenanceTypeDesc','保养周期类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,41 ,'tblEquipment','CorrectionPeriod','校准周期')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,42 ,'tblEquipment','CorrectionTypeDesc','校准周期类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,43 ,'tblEquipment','CreateDate','添加时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,44 ,'tblEquipment','CreateUserName','添加用户')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,45 ,'tblEquipment','UpdateDate','更新时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,46 ,'tblEquipment','ScrapDate','报废时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,47 ,'tblEquipment','WarrantyStatus','保修范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,48 ,'tblManufacturer','ManufacturerName','厂商名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,49 ,'tblManufacturer','ManufacturerProvince','厂商省份')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,50 ,'tblManufacturer','ManufacturerMobile','厂商电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,51 ,'tblManufacturer','ManufacturerAddress','厂商地址')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,52 ,'tblManufacturer','ManufacturerContact','厂商联系人')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,53 ,'tblManufacturer','ManufacturerContactMobile','厂商联系电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,54 ,'tblSupplier','DealerName','经销商名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,55 ,'tblSupplier','DealerProvince','经销商省份')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,56 ,'tblSupplier','DealerMobile','经销商电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,57 ,'tblSupplier','DealerAddress','经销商地址')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,58 ,'tblSupplier','DealerContact','经销商联系人')
INSERT INTO [lkpCustRptTemplateField] VALUES(1,59 ,'tblSupplier','DealerContactMobile','经销商联系电话')

INSERT INTO [lkpCustRptTemplateField] VALUES(2,1 ,'tblContract','ContractNum','合同编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,2 ,'tblContract','ContractName','合同名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,3 ,'tblContract','TypeDesc','合同类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,4 ,'tblContract','ScopeDesc','合同服务范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,5 ,'tblContract','Amount','合同金额')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,6 ,'tblContract','ProjectNum','合同项目编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,7 ,'tblContract','ContractStartDate','合同开始日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,8 ,'tblContract','ContractEndDate','合同结束日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,9 ,'tblContract','ContractComments','合同备注')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,10,'tblEquipment','EquipmentID','设备系统编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,11,'tblEquipment','EquipmentName','设备名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,12,'tblEquipment','EquipmentCode','设备型号')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,13,'tblEquipment','SerialCode','设备序列号')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,14,'tblEquipment','EquipmentLevelDesc','等级')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,15,'tblEquipment','EquipmentClass1Name','设备分类一级')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,16,'tblEquipment','EquipmentClass2Name','设备分类二级')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,17,'tblEquipment','EquipmentClass3Name','设备分类三级')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,18,'tblEquipment','ServiceScopeDesc','整包范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,19,'tblEquipment','EquipmentManufacturerName','设备厂商')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,20,'tblEquipment','DepartmentName','使用科室')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,21,'tblEquipment','InstalSite','安装地点')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,22,'tblSupplier','SupplierName','供应商名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,23,'tblSupplier','SupplierProvince','供应商省份')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,24,'tblSupplier','SupplierMobile','供应商电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,25,'tblSupplier','SupplierAddress','供应商地址')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,26,'tblSupplier','SupplierContact','供应商联系人')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,27,'tblSupplier','SupplierContactMobile','供应商联系电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,28,'tblSupplier','SupplierType','供应商类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(2,29,'tblSupplier','SupplierStatus','供应商经营状态')

INSERT INTO [lkpCustRptTemplateField] VALUES(3,1 ,'tblRequest','RequestID','请求编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,2 ,'tblRequest','RequestTypeDesc','请求类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,3 ,'tblRequest','RequestUserName','请求人姓名')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,4 ,'tblRequest','RequestUserMobile','请求人联系电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,5 ,'tblRequest','Subject','主题')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,6 ,'tblRequest','SourceDesc','请求来源')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,7 ,'tblRequest','FaultTypeDesc','故障分类')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,8 ,'tblRequest','RequestFaultDesc','故障描述')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,9 ,'tblRequest','RequestStatusDesc','请求状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,10,'tblRequest','DealTypeDesc','处理方式')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,11,'tblRequest','PriorityDesc','紧急程度')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,12,'tblRequest','RequestDate','开始日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,13,'tblRequest','DistributeDate','首次分配日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,14,'tblRequest','ResponseDate','首次响应时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,15,'tblRequest','CloseDate','结束日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,16,'tblRequest','IsRecallDesc','是否召回')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,17,'tblRequest','SelectiveDate','择期时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,18,'tblEquipment','EquipmentID','设备系统编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,19,'tblEquipment','EquipmentName','设备名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,20,'tblEquipment','EquipmentCode','设备型号')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,21,'tblEquipment','SerialCode','设备序列号')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,22,'tblEquipment','EquipmentLevelDesc','等级')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,23,'tblEquipment','EquipmentClass1Name','设备分类一级')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,24,'tblEquipment','EquipmentClass2Name','设备分类二级')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,25,'tblEquipment','EquipmentClass3Name','设备分类三级')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,26,'tblEquipment','EquipmentManufacturerName','设备厂商')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,27,'tblEquipment','DepartmentName','使用科室')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,28,'tblEquipment','InstalSite','安装地点')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,29,'tblEquipment','ServiceScopeDesc','整包范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,30,'tblManufacturer','ManufacturerName','厂商名称')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,31,'tblManufacturer','ManufacturerProvince','厂商省份')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,32,'tblManufacturer','ManufacturerMobile','厂商电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,33,'tblManufacturer','ManufacturerAddress','厂商地址')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,34,'tblManufacturer','ManufacturerContact','厂商联系人')
INSERT INTO [lkpCustRptTemplateField] VALUES(3,35,'tblManufacturer','ManufacturerContactMobile','厂商联系电话')

INSERT INTO [lkpCustRptTemplateField] VALUES(4,1 ,'tblDispatch','DisID','派工单编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,2 ,'tblDispatch','DispatchTypeDesc','派工类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,3 ,'tblDispatch','UrgencyDesc','派工单紧急程度')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,4 ,'tblDispatch','MachineStatusDesc','机器状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,5 ,'tblDispatch','EngineerName','工程师姓名')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,6 ,'tblDispatch','ScheduleDate','计划日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,7 ,'tblDispatch','LeaderComments','备注')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,8 ,'tblDispatch','DispatchStatusDesc','派工单状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,9 ,'tblDispatch','CreateDate','派工单生成日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,10,'tblDispatch','StartDate','派工单开始日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,11,'tblDispatch','EndDate','派工单结束日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,12,'tblDispatchReport','ReportID','作业报告编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,13,'tblDispatchReport','ReportTypeDesc','作业报告类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,14,'tblDispatchReport','DispatchReportFaultCode','错误代码')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,15,'tblDispatchReport','DispatchReportFaultDesc','详细故障描述 / 强检要求')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,16,'tblDispatchReport','SolutionCauseAnalysis','分析原因')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,17,'tblDispatchReport','SolutionWay','作业报告处理方式')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,18,'tblDispatchReport','ReportIsRecallDesc','待召回')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,19,'tblDispatchReport','IsPrivateDesc','专用报告')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,20,'tblDispatchReport','ServiceProviderDesc','服务提供方')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,21,'tblDispatchReport','SolutionUnsolvedComments','问题升级')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,22,'tblDispatchReport','ReportEquipmentStatusDesc','设备状态 (离场)')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,23,'tblDispatchReport','PurchaseAmount','资产金额')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,24,'tblDispatchReport','ServiceScopeDesc','整包范围')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,25,'tblDispatchReport','Result','结果')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,26,'tblDispatchReport','AcceptanceDate','验收日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,27,'tblDispatchReport','ReportComments','备注信息')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,28,'tblDispatchReport','ReportFujiComments','审批备注')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,29,'tblDispatchReport','SolutionResultStatusDesc','作业报告结果状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,30,'tblDispatchReport','DelayReason','误工说明')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,31,'tblDispatchReport','ReportStatusDesc','作业报告审批状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,32,'tblDispatchJournal','JournalID','服务凭证编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,33,'tblDispatchJournal','FaultCode','故障现象/错误代码/事由')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,34,'tblDispatchJournal','JobContent','工作内容')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,35,'tblDispatchJournal','ResultStatusDesc','服务结果')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,36,'tblDispatchJournal','FollowProblem','待跟进问题')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,37,'tblDispatchJournal','Advice','建议留言')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,38,'tblDispatchJournal','UserName','用户姓名')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,39,'tblDispatchJournal','UserMobile','用户电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,40,'tblDispatchJournal','SignedDesc','是否签名')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,41,'tblDispatchJournal','JournalFujiComments','服务凭证审批备注')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,42,'tblDispatchJournal','JournalStatusDesc','审核状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,43,'tblRequest','RequestID','请求编号')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,44,'tblRequest','RequestTypeDesc','请求类型')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,45,'tblRequest','RequestUserName','请求人姓名')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,46,'tblRequest','RequestUserMobile','请求人联系电话')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,47,'tblRequest','Subject','主题')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,48,'tblRequest','SourceDesc','请求来源')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,49,'tblRequest','FaultTypeDesc','故障分类')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,50,'tblRequest','RequestFaultDesc','故障描述')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,51,'tblRequest','RequestStatusDesc','请求状态')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,52,'tblRequest','DealTypeDesc','处理方式')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,53,'tblRequest','PriorityDesc','紧急程度')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,54,'tblRequest','RequestDate','开始日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,55,'tblRequest','DistributeDate','首次分配日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,56,'tblRequest','DispatchDate','首次派工时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,57,'tblRequest','ResponseDate','首次响应时间')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,58,'tblRequest','CloseDate','结束日期')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,59,'tblRequest','IsRecallDesc','是否召回')
INSERT INTO [lkpCustRptTemplateField] VALUES(4,60,'tblRequest','SelectiveDate','择期时间')
                                                   
GO

CREATE TABLE [dbo].[tblCustomReport](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeID] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[CreateUserID] [int] NOT NULL,
	[CreateUserName] [nvarchar](20) NOT NULL, 
	[CreatedDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	[UpdateDate] [datetime] NULL,
	[LastRunDate] [datetime] NULL,
	CONSTRAINT PK_tblCustomReport PRIMARY KEY ([ID]),
)

CREATE TABLE [dbo].[tblCustRptField](
	[CustomReportID] [int] NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[FieldName] [varchar](50) NOT NULL,
	CONSTRAINT PK_tblCustRptField PRIMARY KEY ([CustomReportID],[TableName],[FieldName])
)
GO

--view
CREATE VIEW [dbo].[v_ActiveContract]
AS
SELECT e.EquipmentID, max(c.ID) AS ContractID FROM tblContract as c
inner join jctContractEqpt as e on c.ID = e.ContractID
 WHERE DATEDIFF(DAY, c.StartDate, GETDATE()) >= 0 AND DATEDIFF(DAY, c.EndDate, GETDATE()) <= 0
 GROUP BY e.EquipmentID
GO

--设备经营记录
CREATE TABLE [tblServiceHis]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,				--
	[EquipmentID] [int] NOT NULL,					--设备ID
	[TransDate] [DateTime] NOT NULL,				--产生时间
	[Income] [decimal](10,2) NOT NULL,				--收入
	CONSTRAINT PK_tblServiceHis PRIMARY KEY([ID])
)
GO
CREATE INDEX IX_Date ON [tblServiceHis] ([TransDate],[EquipmentID])
GO

--设备资产编号自动填充
CREATE TABLE [dbo].[tblEquipmentCtl](
	[Date] [varchar](20) NOT NULL,			-- 日期
	[Seq] [int] NOT NULL,			-- 序号
	CONSTRAINT PK_tblEquipmentCtl PRIMARY KEY ([Date])
)
GO