-- ϵͳ�����б�
CREATE TABLE [dbo].[lkpObjectType](
	[ID] [int] NOT NULL,
	[TableKey] [varchar](20) NOT NULL,
	[Prefix] [varchar](10) NOT NULL,
	[LeadingZeros] [decimal](2,0) NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpObjectType PRIMARY KEY ([ID]),
	CONSTRAINT IX_lkpObjectType UNIQUE NONCLUSTERED ([TableKey]),
)
GO
INSERT INTO [lkpObjectType] VALUES(1,	'Supplier',			'GYS',	8, '��Ӧ��')
INSERT INTO [lkpObjectType] VALUES(2,	'Contract',			'HT',	8, '��ͬ')
INSERT INTO [lkpObjectType] VALUES(3,	'Equipment',		'ZC',	8, '�豸')
INSERT INTO [lkpObjectType] VALUES(4,	'Request',			'C',	8, '�ͻ�����')
INSERT INTO [lkpObjectType] VALUES(5,	'Dispatch',			'PGD',	8, '�ɹ���')
INSERT INTO [lkpObjectType] VALUES(6,	'DispatchJournal',	'FWPZ',	8, '����ƾ֤')
INSERT INTO [lkpObjectType] VALUES(7,	'DispatchReport',	'ZYBG',	8, '��ҵ����')
INSERT INTO [lkpObjectType] VALUES(8,	'ReportAccessory',	'LPJ',	8, '���������')
INSERT INTO [lkpObjectType] VALUES(9,	'CustomReport',		'ZB',	8, '�Զ��屨��')
INSERT INTO [lkpObjectType] VALUES(10,	'Notice',			'GB',	8, '�㲥')
INSERT INTO [lkpObjectType] VALUES(11,	'Department',		'KS',	8, '����')
INSERT INTO [lkpObjectType] VALUES(12,	'SysAuditLog',		'XTRZ',	8, '��־')
INSERT INTO [lkpObjectType] VALUES(13,	'Component',		'LJ',	8, '���')
INSERT INTO [lkpObjectType] VALUES(14,	'Consumable',		'HC',	8, '�Ĳ�')
INSERT INTO [lkpObjectType] VALUES(15,	'FujiClass1',		'',		8, '��ʿI��')
INSERT INTO [lkpObjectType] VALUES(16,	'FujiClass2',		'FJFL',	8, '��ʿII��')
INSERT INTO [lkpObjectType] VALUES(17,	'InvComponent',		'LJK',	8, '���')
INSERT INTO [lkpObjectType] VALUES(18,	'InvConsumable',	'HCK',	8, '�Ĳ�')
INSERT INTO [lkpObjectType] VALUES(19,	'InvService',		'WGFW',	8, '�����')
INSERT INTO [lkpObjectType] VALUES(20,	'InvSpare',			'BYJ',	8, '���û���')
INSERT INTO [lkpObjectType] VALUES(21,	'PurchaseOrder',	'CGD',	8, '�ɹ���')
GO

-- �������
CREATE TABLE [dbo].[lkpComponentType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpComponentType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpComponentType] VALUES(1,'��Ҫ���')
INSERT INTO [lkpComponentType] VALUES(2,'һ�����')
INSERT INTO [lkpComponentType] VALUES(3,'CT���')
GO

-- �Ĳ�����
CREATE TABLE [dbo].[lkpConsumableType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpConsumableType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpConsumableType] VALUES(1,'����')
INSERT INTO [lkpConsumableType] VALUES(2,'����')
INSERT INTO [lkpConsumableType] VALUES(3,'С��ɱ�')
GO

-- �ɹ���״̬
CREATE TABLE [dbo].[lkpPurchaseOrderStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpPurchaseOrderStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpPurchaseOrderStatus] VALUES(-1,'��ֹ')
INSERT INTO [lkpPurchaseOrderStatus] VALUES(1,'�½�')
INSERT INTO [lkpPurchaseOrderStatus] VALUES(2,'������')
INSERT INTO [lkpPurchaseOrderStatus] VALUES(3,'�����')
INSERT INTO [lkpPurchaseOrderStatus] VALUES(9,'�����')
GO

-- �豸�ȼ�
CREATE TABLE [dbo].[lkpEquipmentType](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpEquipmentType PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpEquipmentType] VALUES(1,'�ص�')
INSERT INTO [lkpEquipmentType] VALUES(2,'���ص�')
INSERT INTO [lkpEquipmentType] VALUES(3,'һ��')
GO

-- ҽԺ�ȼ�
CREATE TABLE [dbo].[lkpHospitalLevel](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	[Factor] [decimal] (5, 2) NOT NULL,
	CONSTRAINT PK_lkpHospitalLevel PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpHospitalLevel] VALUES(1,'1��', 0.8)
INSERT INTO [lkpHospitalLevel] VALUES(2,'2��', 1)
INSERT INTO [lkpHospitalLevel] VALUES(3,'3��', 1.5)
GO

-- �����ʼ��㷽ʽ
CREATE TABLE [dbo].[lkpFaultRateMethod](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpFaultRateMethod PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpFaultRateMethod] VALUES(1,'�ֶ�')
INSERT INTO [lkpFaultRateMethod] VALUES(2,'Τ��')
INSERT INTO [lkpFaultRateMethod] VALUES(3,'����')
GO

-- ���۲���
CREATE TABLE [dbo].[tblValParameter](
	[CtlFlag] [varchar](3) NOT NULL DEFAULT ('CTL') ,
	[HospitalLevel] [int] NULL,						-- ҽԺ�ȼ�
	[HospitalFactor1] [decimal] (5, 2) NULL,		-- ҽԺ�ȼ�1ϵ��
	[HospitalFactor2] [decimal] (5, 2) NULL,		-- ҽԺ�ȼ�2ϵ��
	[HospitalFactor3] [decimal] (5, 2) NULL,		-- ҽԺ�ȼ�3ϵ��
	[SystemCost] [decimal](12, 2) NULL,				-- ��Ϣϵͳʹ�÷�
	[MonthlyHours] [decimal](12, 2) NULL,			-- ÿ�¹���ʱ��
	[UnitCost] [decimal](12, 2) NULL,				-- ��λ�˹��ɱ�
	[SmallConsumableCost] [decimal](12, 2) NULL,	-- С��ɱ��Ĳı�׼�����
)
GO
INSERT INTO [tblValParameter](CtlFlag,HospitalLevel) VALUES('CTL',2)

-- �������
CREATE TABLE [dbo].[tblComponent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FujiClass2ID] [int] NOT NULL,				-- ��ʿII��
	[Name] [nvarchar](50) NOT NULL,				-- ���
	[Description] [nvarchar](200) NOT NULL,		-- ����
	[TypeID] [int] NOT NULL,					-- ����
	[StdPrice] [decimal](12, 2) NULL,			-- ��׼����
	[Usage] [int] NULL,							-- ��׼ʹ����
	[TotalSeconds] [int] NULL,					-- CT��� ��������
	[SecondsPer] [decimal](12,2) NULL,			-- CT��� ���/��
	[IsIncluded] [bit] NOT NULL,				-- �Ƿ�����ֵ
	[IncludeContract] [bit] NOT NULL,			-- �Ƿ�ά��
	
	[MethodID] [int] NULL,						-- �����ʼ��㷽ʽ
	[LifeTime] [int] NULL,						-- ������������� 
	
	[IsActive] [bit] NOT NULL,					-- ״̬ 1���á�0ͣ��
	[AddDate] [datetime] NOT NULL,				-- ��������	
	[UpdateDate] [datetime] NULL,				-- �޸�����	
	CONSTRAINT PK_tblComponent PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblComponent UNIQUE NONCLUSTERED ([FujiClass2ID],[Name]),
)
GO

-- �ĲĶ���
CREATE TABLE [dbo].[tblConsumable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FujiClass2ID] [int] NOT NULL,					-- ��ʿII��
	[Name] [nvarchar](50) NOT NULL,					-- ���
	[Description] [nvarchar](200) NOT NULL,			-- ����
	[TypeID] [int] NOT NULL,						-- ����
	[ReplaceTimes] [decimal](5, 2) NULL,			-- ����Ƶ��
	[CostPer] [decimal](12, 2) NULL,				-- ���α����Ĳĳɱ�
	[StdPrice] [decimal](12, 2) NULL,				-- ��׼����
	[IsIncluded] [bit] NOT NULL,					-- �Ƿ�����ֵ
	[IncludeContract] [bit] NOT NULL,				-- �Ƿ�ά��
	[IsActive] [bit] NOT NULL,						-- ״̬ 1���á�0ͣ��
	[AddDate] [datetime] NOT NULL,					-- ��������	
	[UpdateDate] [datetime] NULL,					-- �޸�����	
	CONSTRAINT PK_tblConsumable PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblConsumable UNIQUE NONCLUSTERED ([FujiClass2ID],[Name]),
)
GO

-- ��ʿI��
CREATE TABLE [dbo].[tblFujiClass1](
	[ID] [int] IDENTITY(-1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,						-- ���
	[Description] [nvarchar](200) NOT NULL,				-- ����
	[AddDate] [datetime] NOT NULL,						-- ��������	
	[UpdateDate] [datetime] NULL,						-- �޸�����	
	CONSTRAINT PK_tblFujiClass1 PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblFujiClass1 UNIQUE NONCLUSTERED ([Name]),
)
GO
INSERT INTO [tblFujiClass1] VALUES('����','����',GETDATE(),NULL)
dbcc checkident ("tblFujiClass1",reseed,0)

-- ��ʿI���豸���͹�����
CREATE TABLE [dbo].[jctFujiClass1EqpType](
	[EquipmentType1ID] [varchar](20) NOT NULL,				-- �豸����I
	[EquipmentType2ID] [varchar](20) NOT NULL,				-- �豸����II
	[FujiClass1ID] [int] NOT NULL,						-- ��ʿI��ID
	CONSTRAINT PK_jctFujiClass1EqpType PRIMARY KEY ([EquipmentType1ID],[EquipmentType2ID]),
)
GO

-- ��ʿII��
CREATE TABLE [dbo].[tblFujiClass2](
	[ID] [int] IDENTITY(-1,1) NOT NULL,
	[FujiClass1ID] [int] NOT NULL,						-- ��ʿI��
	[Name] [nvarchar](50) NOT NULL,						-- ���
	[Description] [nvarchar](200) NOT NULL,				-- ����
	
	[IncludeLabour] [bit] NOT NULL,						-- �Ƿ�����˹���
	[PatrolTimes] [decimal](12, 2) NOT NULL,			-- Ѳ�����
	[PatrolHours] [decimal](12, 2) NOT NULL,			-- Ѳ�칤ʱ	
	[MaintenanceTimes] [decimal](12, 2) NOT NULL,		-- ��������
	[MaintenanceHours] [decimal](12, 2) NOT NULL,		-- ������ʱ
	[RepairHours] [decimal](12, 2) NOT NULL,			-- ά��ƽ����ʱ
	
	[IncludeContract] [bit] NOT NULL,					-- �Ƿ����ά�������
	[FullCoveragePtg] [decimal](5, 2) NOT NULL,			-- ȫ������ռ�豸���ٷֱ�
	[TechCoveragePtg] [decimal](5, 2) NOT NULL,			-- ����������ռ�豸���ٷֱ�
	
	[IncludeSpare] [bit] NOT NULL,						-- �Ƿ�������û��ɱ�
	[SparePrice] [decimal](12, 2) NOT NULL,				-- ���û���׼����
	[SpareRentPtg] [decimal](5, 2) NOT NULL,			-- ����ռ��׼���۱���
	
	[IncludeRepair] [bit] NOT NULL,						-- �Ƿ����ά������ά�޷�
	[Usage] [int] NOT NULL,								-- ʹ����
	[EquipmentType] [int] NOT NULL,						-- �豸�ȼ�
	[RepairComponentCost] [decimal](12, 2) NOT NULL,	-- ����ά��ƽ������ɱ�
	[Repair3partyRatio] [decimal](5, 2) NOT NULL,		-- ����ʦ�޷��޸�����
	[Repair3partyCost] [decimal](12, 2) NOT NULL,		-- ��ά�޷���ƽ���ɱ�	
	[RepairCostRatio] [decimal](5, 2) NOT NULL,			-- ���ϳɱ�ռ�豸������
	
	[MethodID] [int] NOT NULL,							-- �����ʼ��㷽ʽ
	
	[AddDate] [datetime] NOT NULL,						-- ��������	
	[UpdateDate] [datetime] NULL,						-- �޸�����	
	CONSTRAINT PK_tblFujiClass2 PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblFujiClass2 UNIQUE NONCLUSTERED ([Name]),
)
GO
INSERT INTO [tblFujiClass2] VALUES(-1,'����','����',0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,1,GETDATE(),NULL)  --3Ϊ�豸�ȼ�һ��,1Ϊ�����ʼ��㷽ʽ�ֶ�
dbcc checkident ("tblFujiClass2",reseed,0)

-- ��ʿII���豸���͹�����
CREATE TABLE [dbo].[jctFujiClass2EqpType](
	[EquipmentType1ID] [varchar](20) NOT NULL,				-- �豸����I
	[EquipmentType2ID] [varchar](20) NOT NULL,				-- �豸����II
	[FujiClass2ID] [int] NOT NULL,							-- ��ʿII��ID
	CONSTRAINT PK_jctFujiClass2EqpType PRIMARY KEY ([EquipmentType1ID],[EquipmentType2ID],[FujiClass2ID]),
)
GO

-- ������
CREATE TABLE [dbo].[tblFaultRate](
	[ObjectTypeID] [int] NOT NULL,						-- ��������
	[ObjectID] [int] NOT NULL,							-- ����id
	[Year] [int] NOT NULL,								-- ���
	[Month] [int] NOT NULL,								-- �·�
	[Rate] [decimal](5, 2) NOT NULL,					-- ������
	CONSTRAINT PK_tblFailureRate PRIMARY KEY ([ObjectTypeID],[ObjectID],[Year],[Month]),
)
GO


-- ��ҵ��������� ������������tblReportAccessory
CREATE TABLE [dbo].[tblReportComponent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,				-- ��������������
	[ComponentID] [int] NOT NULL,					-- ���ID
	[NewSerialCode] [nvarchar](30) NOT NULL,		-- ��װ��������к�
	[OldSerialCode] [nvarchar](30) NOT NULL,		-- ������������к�
	CONSTRAINT PK_tblReportComponent PRIMARY KEY ([ID]),
)
GO

-- ��ҵ����Ĳ�
CREATE TABLE [dbo].[tblReportConsumable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,			-- ��������������
	[ConsumableID] [int] NOT NULL,				-- �Ĳ�ID
	[LotNum] [nvarchar](30) NOT NULL,			-- ���κ�
	[Qty] [decimal](12,2) NOT NULL,				-- ����
	CONSTRAINT PK_tblReportConsumable PRIMARY KEY ([ID]),
)
GO

-- ��ҵ�������
CREATE TABLE [dbo].[tblReportService](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DispatchReportID] [int] NOT NULL,			-- ��������������
	[ServiceID] [int] NOT NULL,					-- ������
	CONSTRAINT PK_tblReportService PRIMARY KEY ([ID]),
)
GO

CREATE TABLE [dbo].[tblMaterialHistory](
	[DispatchReportID] [int] NOT NULL,			-- ��������������
	[ObjectType] [int] NOT NULL,				-- ���ͱ��(1������� 2������� 3�Ĳ� 4����)
	[ObjectID] [int] NOT NULL,					-- ����id
	[EquipmentID] [int] NOT NULL,				-- �����豸���
	[UserID] [int] NOT NULL,					-- ����ʦid
	[Qty] [decimal](12,2) NOT NULL,				-- ����
	[UsedDate] [datetime] NOT NULL,				-- ʹ������
	
	CONSTRAINT PK_tblMaterialHistory PRIMARY KEY ([DispatchReportID],[ObjectType],[ObjectID]),
)
GO


-- ִ�б�
CREATE TABLE [dbo].[tblValControl](
	[CtlFlag] [varchar](3) NOT NULL DEFAULT ('CTL') ,
	[UserID] [int] NOT NULL,					-- ִ����
	[UpdateDate] [datetime] NOT NULL,			-- ��������
	[IsExecuted] [bit] NOT NULL,				-- �Ƿ���ִ��
	
	[EndDate] [datetime] NOT NULL,				-- ��Ӫʵ�ʽ�����
	[ContractStartDate] [datetime] NOT NULL,	-- ��ͬ��ʼ��
	[Years] [int] NOT NULL,						-- Ԥ������
	[HospitalLevel] [int] NOT NULL,				-- ҽԺ�ȼ�
	[ImportCost] [decimal](12, 2) NOT NULL,		-- �����ڳɱ�
	[ProfitMargins] [decimal](5, 2) NOT NULL,	-- �߼�������
	[RiskRatio] [decimal](5, 2) NOT NULL,		-- ���տ��ƶ�
	[VarAmount] [decimal](5, 2) NOT NULL,		-- var�ʽ������
	[ComputeEngineer] [int] NOT NULL,			-- Ԥ�⹤��ʦ����
	[ForecastEngineer] [int] NOT NULL,			-- Ԥ������ʦ����
	
	CONSTRAINT PK_tblValControl PRIMARY KEY ([CtlFlag],[UserID]),
)
GO

-- �豸�嵥ִ�б�(�豸��Ԥ�������ֶζ�Ҫ����:�ʲ����(key)	����	�豸���к�	����	����	��ʿII������(������))
CREATE TABLE [dbo].[tblValEquipment](
	[UserID] [int] NOT NULL,							-- ִ����
	[InSystem] [bit] NOT NULL,							-- �Ƿ�����
	[EquipmentID] [int] NOT NULL,						-- �豸ID
	[AssetCode] [nvarchar](30) NULL,        			-- ҽԺϵͳ�ʲ����	
	[Name] [nvarchar] (30) NOT NULL,					-- �豸����
	[SerialCode] [nvarchar](30) NULL,					-- �豸���к�
	[Manufacturer] [nvarchar](50) NULL,					-- �豸����
	[Department] [nvarchar](20) NULL,					-- �豸����
	[FujiClass2ID] [int] NOT NULL,						-- ��ʿII��
	[PurchaseAmount] [decimal](10, 2) NOT NULL,			-- �ɹ����
			
	[CurrentScopeID] [int] NOT NULL,					-- Ŀǰά������
	[NextScopeID] [int] NOT NULL,						-- ����ά������
	[EndDate] [datetime] NULL,							-- ά��������
	
	[PatrolHours] [decimal](12, 2) NULL,				-- ����Ѳ�칤ʱ
	[MaintenanceHours] [decimal](12, 2) NULL,			-- ���豣����ʱ
	[RepairHours] [decimal](12, 2) NULL,				-- ����ά�޹�ʱ
	CONSTRAINT PK_tblValEquipment PRIMARY KEY ([InSystem],[EquipmentID],[UserID]),
)
GO

-- ���û�ִ�б�
CREATE TABLE [dbo].[tblValSpare](
	[UserID] [int] NOT NULL,					-- ִ����
	[FujiClass2ID] [int] NOT NULL,				-- ��ʿII��ID
	[Price] [decimal](12,2) NOT NULL,			-- �������
	[QtyEnter] [int] NOT NULL,					-- ������������
	[QtyEval] [int] NOT NULL,					-- ������������
	CONSTRAINT PK_tblValSpare PRIMARY KEY ([FujiClass2ID],[UserID]),
)
GO

-- �Ĳ�ִ�б�
CREATE TABLE [dbo].[tblValConsumable](
	[UserID] [int] NOT NULL,					-- ִ����
	[ConsumableID] [int] NOT NULL,				-- �Ĳ�ID
	[IncludeContract] [bit] NOT NULL,			-- �Ƿ�ά������
	CONSTRAINT PK_tblValConsumable PRIMARY KEY ([ConsumableID],[UserID]),
)
GO

-- ���ִ�б�
CREATE TABLE [dbo].[tblValComponent](
	[UserID] [int] NOT NULL,					-- ִ����
	[InSystem] [bit] NOT NULL,					-- �Ƿ�����
	[EquipmentID] [int] NOT NULL,				-- �豸ID
	[ComponentID] [int] NOT NULL,				-- ���ID(��Ϊ0ʱ��ʾ����)
	[Qty] [int] NOT NULL,						-- ����/��ʹ���˴�
	[Usage] [int] NULL,							-- ʹ����
	[UsageRefere] [int] NULL,					-- ʹ�����ο�ֵ
	[Seconds] [decimal](12,2) NULL,				-- CT��ʹ�����
	[IncludeContract] [bit] NOT NULL,			-- �Ժ��Ƿ�ά��
	CONSTRAINT PK_tblValComponent PRIMARY KEY ([InSystem],[EquipmentID],[ComponentID],[UserID]),
)
GO

CREATE TABLE [dbo].[tblValEqptOutput](
	[UserID] [int] NOT NULL,					-- ִ����
	[InSystem] [bit] NOT NULL,								-- �Ƿ�����
	[EquipmentID] [int] NOT NULL,	
	[Year] [int] NOT NULL,									-- ���
	[Month] [int] NOT NULL,									-- �·�
	[ContractAmount] [decimal](12,2) NOT NULL,				-- ά�����
	[Repair3partyCost] [decimal](12,2) NOT NULL,			-- �⹺ά�޷���ѽ��
	
	CONSTRAINT PK_tblValEqptOutput PRIMARY KEY ([UserID],[InSystem],[EquipmentID],[Year],[Month]),
)
GO

CREATE TABLE [dbo].[tblValConsumableOutput](
	[UserID] [int] NOT NULL,					-- ִ����
	[InSystem] [bit] NOT NULL,							-- �Ƿ�����
	[EquipmentID] [int] NOT NULL,
	[Year] [int] NOT NULL,								-- ���
	[Month] [int] NOT NULL,								-- �·�
	[ConsumableID] [int] NOT NULL,
	[Amount] [decimal](12,2) NOT NULL,
	
	CONSTRAINT PK_tblValConsumableOutput PRIMARY KEY ([UserID],[InSystem],[EquipmentID],[ConsumableID],[Year],[Month]),
)
GO

CREATE TABLE [dbo].[tblValComponentOutput](
	[UserID] [int] NOT NULL,					-- ִ����
	[InSystem] [bit] NOT NULL,							-- �Ƿ�����
	[EquipmentID] [int] NOT NULL,
	[ComponentID] [int] NOT NULL,
	[Year] [int] NOT NULL,									-- ���
	[Month] [int] NOT NULL,									-- �·�
	[Amount] [decimal] (12,2) NOT NULL,						-- ���
	
	CONSTRAINT PK_tblValComponentOutput PRIMARY KEY ([UserID],[InSystem],[EquipmentID],[ComponentID],[Year],[Month]),
)
GO

-- �����
CREATE TABLE [dbo].[tblInvComponent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ComponentID] [int] NOT NULL,				-- ���id
	[EquipmentID] [int] NOT NULL,				-- �豸id
	[SerialCode] [nvarchar](30) NOT NULL,		-- ������к�
	[Specification] [nvarchar](50) NOT NULL,	-- ���
	[Model] [nvarchar](50) NOT NULL,			-- �ͺ�
	[SupplierID] [int] NOT NULL,				-- ��Ӧ��
	[Price] [decimal](12,2) NOT NULL,			-- ����
	[PurchaseDate] [datetime] NOT NULL,			-- ��������
	[PurchaseID] [int] NULL,					-- �ɹ�����
	[Comments] [nvarchar](500) NULL,			-- ��ע
	[AddDate] [datetime] NOT NULL,				-- ��������	
	[UpdateDate] [datetime] NULL,				-- �޸�����		
	[StatusID] [int] NOT NULL,					-- ״̬ 1 �ڿ⡢2 ���á� 3 ����
	CONSTRAINT PK_tblInvComponent PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblInvComponent UNIQUE NONCLUSTERED ([SerialCode]),
)
GO
CREATE INDEX IX_Component ON [tblInvComponent] ([ComponentID], [StatusID])
GO
CREATE INDEX IX_EquipmentID ON [tblInvComponent] ([EquipmentID], [StatusID])
GO
CREATE INDEX IX_Purchase ON [tblInvComponent] ([PurchaseID])
GO

-- �ĲĿ�
CREATE TABLE [dbo].[tblInvConsumable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ConsumableID] [int] NOT NULL,				-- �Ĳ�id	
	[LotNum] [nvarchar](30) NOT NULL,			-- ���κ�
	[Specification] [nvarchar](50) NOT NULL,	-- ���
	[Model] [nvarchar](50) NOT NULL,			-- �ͺ�
	[SupplierID] [int] NOT NULL,				-- ��Ӧ��
	[Price] [decimal](12,2) NOT NULL,			-- ����
	[ReceiveQty] [decimal](12,2) NOT NULL,		-- �������
	[PurchaseDate] [datetime] NOT NULL,			-- ��������
	[PurchaseID] [int] NULL,					-- �ɹ�����
	[Comments] [nvarchar](500) NULL,			-- ��ע
	[AddDate] [datetime] NOT NULL,				-- ��������	
	[AvaibleQty] [decimal](12,2) NOT NULL,		-- ��������
	[UpdateDate] [datetime] NULL,				-- �޸�����
	CONSTRAINT PK_tblInvConsumable PRIMARY KEY ([ID]),	
	CONSTRAINT IX_tblInvConsumable UNIQUE NONCLUSTERED ([ConsumableID], [LotNum]),
)
GO
CREATE INDEX IX_Consumable ON [tblInvConsumable] ([ConsumableID], [AvaibleQty])
GO
CREATE INDEX IX_Purchase ON [tblInvConsumable] ([PurchaseID])
GO

-- �����
CREATE TABLE [dbo].[tblInvService](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FujiClass2ID] [int] NOT NULL,				-- ��ʿII��
	[Name] [nvarchar](50) NOT NULL,				-- ��������
	[TotalTimes] [int] NOT NULL,				-- �������
	[Price] [decimal](12, 2) NOT NULL,			-- ���
	[StartDate] [datetime] NOT NULL,			-- ��ʼ����
	[EndDate] [datetime] NOT NULL,  			-- ��������
	[SupplierID] [int] NOT NULL,				-- ��Ӧ��	
	[PurchaseID] [int] NULL,					-- �ɹ�����
	[PurchaseDate] [datetime] NOT NULL,			-- ��������
	[Comments] [nvarchar](500) NULL,			-- ��ע
	[AddDate] [datetime] NOT NULL,				-- ��������	
	[AvaibleTimes] [int] NOT NULL,				-- ���÷������
	[UpdateDate] [datetime] NULL,				-- �޸�����		
	CONSTRAINT PK_tblInvService PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Purchase ON [tblInvService] ([PurchaseID],[AvaibleTimes])
GO
CREATE INDEX IX_FujiClass2ID ON [tblInvService] ([FujiClass2ID])
GO
CREATE INDEX IX_Name ON [tblInvService] ([Name])
GO

-- ���û���
CREATE TABLE [dbo].[tblInvSpare](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FujiClass2ID] [int] NOT NULL,				-- ��ʿII��id	
	[SerialCode] [nvarchar](30) NOT NULL,		-- ���к�
	[Price] [decimal](12,2) NOT NULL,			-- ����
	[StartDate] [datetime] NOT NULL,			-- ��ʼ����
	[EndDate] [datetime] NOT NULL,				-- ��������
	[AddDate] [datetime] NOT NULL,				-- ��������	
	[UpdateDate] [datetime] NULL,				-- �޸�����		
	CONSTRAINT PK_tblInvSpare PRIMARY KEY ([ID]),
	CONSTRAINT IX_tblInvSpare UNIQUE NONCLUSTERED ([FujiClass2ID], [SerialCode],[StartDate]),
)
GO

-- �ɹ���
CREATE TABLE [dbo].[tblPurchaseOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,				-- ������
	[SupplierID] [int] NOT NULL,				-- ��Ӧ��
	[OrderDate] [datetime] NOT NULL,			-- �ɹ�����
	[DueDate] [datetime] NOT NULL,				-- ��������
	[Comments] [nvarchar](500) NULL,			-- ��ע
	[FujiComments] [nvarchar](200) NULL,		-- ������ע
	[StatusID] [int] NOT NULL,					-- �ɹ���״̬
	[AddDate] [datetime] NOT NULL,				-- ��������
	[UpdateDate] [datetime] NULL,				-- �޸�����
	
	CONSTRAINT PK_tblPurchaseOrder PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_Status ON [tblPurchaseOrder] ([StatusID])
GO

-- �ɹ�����ʷ
CREATE TABLE [dbo].[tblPurchaseOrderHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderID] [int] NOT NULL,
	[OperatorID] [int] NOT NULL,
	[Action] [int] NOT NULL,											-- 1: �ύ , 2: ͨ��, 3���˻�
	[Comments] [nvarchar](255) NULL,					
	[TransDate] [datetime] NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT PK_tblPurchaseOrderHistory PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_PurchaseOrderID ON [tblPurchaseOrderHistory] ([PurchaseOrderID],[TransDate])
GO

-- �ɹ���-���������
CREATE TABLE [dbo].[tblPurchaseComponent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseID] [int] NOT NULL,				-- �ɹ������
	[ComponentID] [int] NOT NULL,				-- ������
	[EquipmentID] [int] NOT NULL,				-- �豸���
	[Specification] [nvarchar](50) NOT NULL,	-- ���
	[Model] [nvarchar](50) NOT NULL,			-- �ͺ�
	[Price] [decimal](12,2) NOT NULL,			-- ����
	[Qty] [int] NOT NULL,						-- ����
	[InboundQty] [int] NOT NULL,				-- ���������
	CONSTRAINT PK_tblPurchaseComponent PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_PurchaseID ON [tblPurchaseComponent] ([PurchaseID])
GO

-- �ɹ���-�ĲĹ�����
CREATE TABLE [dbo].[tblPurchaseConsumable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseID] [int] NOT NULL,				-- �ɹ������
	[ConsumableID] [int] NOT NULL,				-- �Ĳı��
	[Specification] [nvarchar](50) NOT NULL,	-- ���
	[Model] [nvarchar](50) NOT NULL,			-- �ͺ�
	[Price] [decimal](12,2) NOT NULL,			-- ����
	[Qty] [decimal](12,2) NOT NULL,				-- ����
	[InboundQty] [decimal](12,2) NOT NULL,		-- ���������
	CONSTRAINT PK_tblPurchaseConsumable PRIMARY KEY ([ID]),
)
GO
CREATE INDEX IX_PurchaseID ON [tblPurchaseConsumable] ([PurchaseID])
GO

-- �ɹ���-���������
CREATE TABLE [dbo].[tblPurchaseService](
	[PurchaseID] [int] NOT NULL,				-- �ɹ������
	[FujiClass2ID] [int] NOT NULL,				-- ��ʿII����
	[Name] [nvarchar](50) NOT NULL,				-- ��������
	[TotalTimes] [int] NOT NULL,				-- �������
	[Price] [decimal](12, 2) NOT NULL,			-- ���
	[StartDate] [datetime] NOT NULL,			-- ��ʼ����
	[EndDate] [datetime] NOT NULL,  			-- ��������
	CONSTRAINT PK_tblPurchaseService PRIMARY KEY ([PurchaseID],[FujiClass2ID],[Name]),
)
GO

-- not reviewed yet

-- �̵�״̬
CREATE TABLE [dbo].[lkpStockTakeStatus](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpStockTakeStatus PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpStockTakeStatus] VALUES(-1,'��ֹ')
INSERT INTO [lkpStockTakeStatus] VALUES(1,'�½�')
INSERT INTO [lkpStockTakeStatus] VALUES(2,'���̵�')
INSERT INTO [lkpStockTakeStatus] VALUES(3,'������')
INSERT INTO [lkpStockTakeStatus] VALUES(9,'�ѽ���')
GO

-- �̵��������
CREATE TABLE [dbo].[lkpWarehouse](
	[ID] [int] NOT NULL,
	[Description] [nvarchar](20) NOT NULL,
	CONSTRAINT PK_lkpWarehouse PRIMARY KEY ([ID])
)
GO
INSERT INTO [lkpWarehouse] VALUES(1,'���')
INSERT INTO [lkpWarehouse] VALUES(2,'�Ĳ�')
INSERT INTO [lkpWarehouse] VALUES(3,'�����')
INSERT INTO [lkpWarehouse] VALUES(9,'���û�')
GO

-- ����̵�
CREATE TABLE [dbo].[tblInvStockTake](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ObjectTypeID] [int] NOT NULL,				-- �̵��������
	[StockTakeDate] [datetime] NOT NULL,		-- �̵㿪ʼ����
	[StatusID] [int] NOT NULL,					-- ״̬
	[Comments] [nvarchar](500) NULL,			-- ��ע
	CONSTRAINT PK_tblInvStockTake PRIMARY KEY ([ID]),
)
GO

-- �̵����
CREATE TABLE [dbo].[jctStockTakeComponent](
	[StockTakeID] [int] NOT NULL,				-- �̵㵥���
	[ComponentID] [int] NOT NULL,				-- ���id
	[SerialID] [nvarchar](30) NOT NULL,			-- ���к�
	[IsLibrary] [bit] NOT NULL,					-- �Ƿ��ڿ�
	CONSTRAINT PK_jctStockTakeComponent PRIMARY KEY ([StockTakeID],[ComponentID]),
)
Go

-- �̵�Ĳ�
CREATE TABLE [dbo].[jctStockTakeConsumable](
	[StockTakeID] [int] NOT NULL,				-- �̵㵥���
	[ConsumableID] [int] NOT NULL,				-- ���id
	[BatchNum] [nvarchar](30) NOT NULL,			-- ���к�
	[ActualAmount] [decimal](12,1) NOT NULL,	-- ʵ������
	CONSTRAINT PK_jctStockTakeConsumable PRIMARY KEY ([StockTakeID],[ConsumableID]),
)
Go

-- �̵㱸�û�
CREATE TABLE [dbo].[jctStockTakeSpare](
	[StockTakeID] [int] NOT NULL,				-- �̵㵥���
	[SpareID] [int] NOT NULL,					-- ���û�id
	[IsLibrary] [bit] NOT NULL,					-- �Ƿ��ڿ�
	CONSTRAINT PK_jctStockTakeSpare PRIMARY KEY ([StockTakeID],[SpareID]),
)
Go