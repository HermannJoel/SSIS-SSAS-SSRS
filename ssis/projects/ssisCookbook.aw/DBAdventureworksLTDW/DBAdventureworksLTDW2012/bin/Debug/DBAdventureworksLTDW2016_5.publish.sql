﻿/*
Deployment script for AdventureworksLTDW2016

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "AdventureworksLTDW2016"
:setvar DefaultFilePrefix "AdventureworksLTDW2016"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [SystemLog].[ExecutionMessages].[MessageType] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [SystemLog].[ExecutionMessages])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [SystemLog].[Loads].[LoadApplicationId] on table [SystemLog].[Loads] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [SystemLog].[Loads].[LoadStatusId] on table [SystemLog].[Loads] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [SystemLog].[Loads])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'The following operation was generated from a refactoring log file 883b5e62-b663-4459-902b-59f25c9f0f64';

PRINT N'Rename [Staging].[StgAddress].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgAddress].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 97fb77c7-b08c-4654-bdca-7bd951f00653';

PRINT N'Rename [Staging].[StgCustomer].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgCustomer].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file fe114ee8-e69a-4dd3-8cd5-2fdd615315be';

PRINT N'Rename [Staging].[StgCustomerAddress].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgCustomerAddress].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file eea55d82-7050-4a7e-8ab2-7fc748706c31';

PRINT N'Rename [Staging].[StgProduct].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgProduct].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file ace9f8b8-b4f1-49d1-80f4-12c0b40644fe';

PRINT N'Rename [Staging].[StgProductCategory].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgProductCategory].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 5a200521-80b9-42e0-b39c-8ffcf2ff9eeb';

PRINT N'Rename [Staging].[StgProductDescription].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgProductDescription].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file d4636434-094f-4575-b8b0-e8eb1f180b61';

PRINT N'Rename [Staging].[StgProductModel].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgProductModel].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file b967f637-87c5-4b9b-8a1d-918a869c96a7';

PRINT N'Rename [Staging].[StgProductModelProductDescription].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgProductModelProductDescription].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 883eb137-d6fb-4c02-85d5-b0e6abb98ef7';

PRINT N'Rename [Staging].[StgSalesOrderDetail].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgSalesOrderDetail].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file a5a51cec-5d93-40a9-893b-5f7f3349702a';

PRINT N'Rename [Staging].[StgSalesOrderHeader].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[Staging].[StgSalesOrderHeader].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 581bcdea-f576-4805-b7ec-c726076fefe5';

PRINT N'Rename [DW].[DimAddress].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[DW].[DimAddress].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 5f82f72d-f460-4d87-a0fc-9ecd96f6744a';

PRINT N'Rename [DW].[DimCustomer].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[DW].[DimCustomer].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 1d529888-4230-4c86-8539-606063f42a6e';

PRINT N'Rename [DW].[DimOrderProvenance].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[DW].[DimOrderProvenance].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 26a18f2b-ba8c-42ac-8220-345a9f67b20c';

PRINT N'Rename [DW].[DimProduct].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[DW].[DimProduct].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 139e9e17-d35d-4679-8ccd-de3e394f8494';

PRINT N'Rename [DW].[FactOrders].[LoadID] to LoadExecutionId';


GO
EXECUTE sp_rename @objname = N'[DW].[FactOrders].[LoadID]', @newname = N'LoadExecutionId', @objtype = N'COLUMN';


GO
PRINT N'The following operation was generated from a refactoring log file 151bd019-ce88-4c66-9d20-9f09dd1fde58';

PRINT N'Rename [DW].[FactOrders].[PurchareOrderNumber] to PurchaseOrderNumber';


GO
EXECUTE sp_rename @objname = N'[DW].[FactOrders].[PurchareOrderNumber]', @newname = N'PurchaseOrderNumber', @objtype = N'COLUMN';


GO
PRINT N'Dropping [SystemLog].[FK_Executions_To_Loads]...';


GO
ALTER TABLE [SystemLog].[LoadExecutions] DROP CONSTRAINT [FK_Executions_To_Loads];


GO
PRINT N'Altering [DW].[DimAddress]...';


GO
ALTER TABLE [DW].[DimAddress] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
PRINT N'Altering [DW].[DimCustomer]...';


GO
ALTER TABLE [DW].[DimCustomer] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
PRINT N'Altering [DW].[DimOrderProvenance]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [DW].[DimOrderProvenance] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [DW].[DimProduct]...';


GO
ALTER TABLE [DW].[DimProduct] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
PRINT N'Altering [DW].[FactOrders]...';


GO
ALTER TABLE [DW].[FactOrders] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
PRINT N'Altering [Staging].[StgAddress]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgAddress] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgCustomer]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgCustomer] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgCustomerAddress]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgCustomerAddress] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgProduct]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgProduct] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgProductCategory]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgProductCategory] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgProductDescription]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgProductDescription] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgProductModel]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgProductModel] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgProductModelProductDescription]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgProductModelProductDescription] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgSalesOrderDetail]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgSalesOrderDetail] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [Staging].[StgSalesOrderHeader]...';


GO
SET QUOTED_IDENTIFIER ON;

SET ANSI_NULLS OFF;


GO
ALTER TABLE [Staging].[StgSalesOrderHeader] ALTER COLUMN [LoadExecutionId] BIGINT NOT NULL;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Altering [SystemLog].[ExecutionMessages]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
ALTER TABLE [SystemLog].[ExecutionMessages] DROP COLUMN [MessageType];


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Starting rebuilding table [SystemLog].[Loads]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [SystemLog].[tmp_ms_xx_Loads] (
    [LoadId]            BIGINT   IDENTITY (1, 1) NOT NULL,
    [LoadApplicationId] TINYINT  NOT NULL,
    [LoadStartDateTime] DATETIME NOT NULL,
    [LoadEndDateTime]   DATETIME NULL,
    [LoadStatusId]      TINYINT  NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_LoadId1] PRIMARY KEY CLUSTERED ([LoadId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [SystemLog].[Loads])
    BEGIN
        SET IDENTITY_INSERT [SystemLog].[tmp_ms_xx_Loads] ON;
        INSERT INTO [SystemLog].[tmp_ms_xx_Loads] ([LoadId], [LoadStartDateTime], [LoadEndDateTime])
        SELECT   [LoadId],
                 [LoadStartDateTime],
                 [LoadEndDateTime]
        FROM     [SystemLog].[Loads]
        ORDER BY [LoadId] ASC;
        SET IDENTITY_INSERT [SystemLog].[tmp_ms_xx_Loads] OFF;
    END

DROP TABLE [SystemLog].[Loads];

EXECUTE sp_rename N'[SystemLog].[tmp_ms_xx_Loads]', N'Loads';

EXECUTE sp_rename N'[SystemLog].[tmp_ms_xx_constraint_PK_LoadId1]', N'PK_LoadId', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [SystemLog].[LoadApplications]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [SystemLog].[LoadApplications] (
    [LoadApplicationId]      TINYINT        IDENTITY (1, 1) NOT NULL,
    [ApplicationName]        NVARCHAR (100) NOT NULL,
    [ApplicationDescription] NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_LoadApplications] PRIMARY KEY CLUSTERED ([LoadApplicationId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [SystemLog].[FK_Executions_To_Loads]...';


GO
ALTER TABLE [SystemLog].[LoadExecutions] WITH NOCHECK
    ADD CONSTRAINT [FK_Executions_To_Loads] FOREIGN KEY ([LoadId]) REFERENCES [SystemLog].[Loads] ([LoadId]);


GO
PRINT N'Creating [SystemLog].[FK_Loads_To_LoadApplications]...';


GO
ALTER TABLE [SystemLog].[Loads] WITH NOCHECK
    ADD CONSTRAINT [FK_Loads_To_LoadApplications] FOREIGN KEY ([LoadApplicationId]) REFERENCES [SystemLog].[LoadApplications] ([LoadApplicationId]);


GO
PRINT N'Creating [SystemLog].[FK_Loads_To_ExectionStatus]...';


GO
ALTER TABLE [SystemLog].[Loads] WITH NOCHECK
    ADD CONSTRAINT [FK_Loads_To_ExectionStatus] FOREIGN KEY ([LoadStatusId]) REFERENCES [SystemLog].[ExecutionStatus] ([ExecutionStatusId]);


GO
PRINT N'Refreshing [Cube].[FactOrders]...';


GO
EXECUTE sp_refreshsqlmodule N'[Cube].[FactOrders]';


GO
PRINT N'Creating [SystemLog].[CloseLoadExecution]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE [SystemLog].[CloseLoadExecution]
	@LoadExecutionId BIGINT
AS
	-- Reterive Catalog Execution statstics and insert them into [SystemLog].[ExecutionStatistics] table
	INSERT INTO SystemLog.ExecutionStatictics
	        ( LoadExecutionId ,
	          SSISProjectName ,
	          SSISPackageName ,
	          SSISPackageStartDateTime ,
	          SSISPackageEndDateTime ,
	          DataFlowPathIdString ,
	          SourceComponentName ,
	          DestinationComponentName ,
	          RowsSent
	        )
	VALUES  ( 0 , -- LoadExecutionId - bigint
	          N'' , -- SSISProjectName - nvarchar(260)
	          N'' , -- SSISPackageName - nvarchar(260)
	          SYSDATETIMEOFFSET() , -- SSISPackageStartDateTime - datetimeoffset(7)
	          SYSDATETIMEOFFSET() , -- SSISPackageEndDateTime - datetimeoffset(7)
	          N'' , -- DataFlowPathIdString - nvarchar(4000)
	          N'' , -- SourceComponentName - nvarchar(500)
	          N'' , -- DestinationComponentName - nvarchar(500)
	          0  -- RowsSent - int
	        )
RETURN 0
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creating [SystemLog].[OpenLoadExecution]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE PROCEDURE [SystemLog].[OpenLoadExecution]
    @ServerExecutionId BIGINT = 0 ,
    @LoadId BIGINT = -1 ,
    @LoadExectionId BIGINT OUTPUT
AS
    DECLARE @FailureStatusId TINYINT = 0 ,
        @RunningStatusId TINYINT = 0 ,
        @LoadDateTime DATETIME = GETDATE();
    DECLARE @LoadIdTbl TABLE
        (
          LoadExecutionId BIGINT
        );
     --Get StatusId for Falied loads
    SELECT  @FailureStatusId = s.ExecutionStatusId
    FROM    SystemLog.ExecutionStatus s
    WHERE   s.ExecutionStatusName = N'Failed';

	--Get StatusId for Running loads
    SELECT  @RunningStatusId = s.ExecutionStatusId
    FROM    SystemLog.ExecutionStatus AS s
    WHERE   s.ExecutionStatusName = 'Running';

	--If the SystemLog.Loads table is used, get its LoadDtartDateTime to have a consistent Start date and time in our loads
    IF ( @LoadId <> -1 )
        BEGIN
            SELECT  @LoadDateTime = l.LoadStartDateTime
            FROM    SystemLog.Loads AS l
            WHERE   LoadId = @LoadId;
        END;
	--Check iff there are any pending loads for this Application. Terminate it if that's the case.
    IF EXISTS ( SELECT TOP 1
                        1
                FROM    SystemLog.LoadExecutions le
                WHERE   le.LoadId = @LoadId
                        AND le.LoadId <> -1 )
        BEGIN
            UPDATE  SystemLog.LoadExecutions
            SET     ExecutionStatusId = @FailureStatusId
            WHERE   LoadId = @LoadId;
        END;
    INSERT  INTO SystemLog.LoadExecutions
            ( SSISServerExecutionId ,
              LoadId ,
              ExecutionStatusId ,
              ExecutionStartDateTime ,
              ExecutionEndDateTime
	        )
    OUTPUT  Inserted.LoadExecutionId  --Retreive the Identity LoadExecutionId value
            INTO @LoadIdTbl ( LoadExecutionId )
    VALUES  ( @ServerExecutionId , -- SSISServerExecutionId - bigint
              @LoadId , -- LoadId - bigint
              @RunningStatusId , -- ExecutionStatusId - tinyint
              @LoadDateTime , -- ExecutionStartDateTime - datetime
              NULL  -- ExecutionEndDateTime - datetime
	        );

    --Return LoadExecutionId from insert statement above
    SELECT  @LoadExectionId = t.LoadExecutionId
    FROM    @LoadIdTbl AS t;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '883b5e62-b663-4459-902b-59f25c9f0f64')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('883b5e62-b663-4459-902b-59f25c9f0f64')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '97fb77c7-b08c-4654-bdca-7bd951f00653')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('97fb77c7-b08c-4654-bdca-7bd951f00653')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fe114ee8-e69a-4dd3-8cd5-2fdd615315be')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fe114ee8-e69a-4dd3-8cd5-2fdd615315be')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'eea55d82-7050-4a7e-8ab2-7fc748706c31')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('eea55d82-7050-4a7e-8ab2-7fc748706c31')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ace9f8b8-b4f1-49d1-80f4-12c0b40644fe')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ace9f8b8-b4f1-49d1-80f4-12c0b40644fe')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5a200521-80b9-42e0-b39c-8ffcf2ff9eeb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5a200521-80b9-42e0-b39c-8ffcf2ff9eeb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd4636434-094f-4575-b8b0-e8eb1f180b61')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d4636434-094f-4575-b8b0-e8eb1f180b61')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b967f637-87c5-4b9b-8a1d-918a869c96a7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b967f637-87c5-4b9b-8a1d-918a869c96a7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '883eb137-d6fb-4c02-85d5-b0e6abb98ef7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('883eb137-d6fb-4c02-85d5-b0e6abb98ef7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a5a51cec-5d93-40a9-893b-5f7f3349702a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a5a51cec-5d93-40a9-893b-5f7f3349702a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '581bcdea-f576-4805-b7ec-c726076fefe5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('581bcdea-f576-4805-b7ec-c726076fefe5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '5f82f72d-f460-4d87-a0fc-9ecd96f6744a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('5f82f72d-f460-4d87-a0fc-9ecd96f6744a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1d529888-4230-4c86-8539-606063f42a6e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1d529888-4230-4c86-8539-606063f42a6e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '26a18f2b-ba8c-42ac-8220-345a9f67b20c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('26a18f2b-ba8c-42ac-8220-345a9f67b20c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '139e9e17-d35d-4679-8ccd-de3e394f8494')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('139e9e17-d35d-4679-8ccd-de3e394f8494')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '151bd019-ce88-4c66-9d20-9f09dd1fde58')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('151bd019-ce88-4c66-9d20-9f09dd1fde58')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
--:R DimensionsUnknownMembers.sql

	--ExecutionMessageTypes fixed members
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionMessageTypes]
                    WHERE   [ExecutionMessageTypeId] = 1 )
        BEGIN
            INSERT  [SystemLog].[ExecutionMessageTypes]
                    ( [ExecutionMessageTypeId] ,
                      [ExecutionMessageTypeName] ,
                      [ExecutionMessageTypeDescription]
                    )
            VALUES  ( 1 ,
                      N'Error' ,
                      N'The message logged contains the error derscription.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionMessageTypes]
                    WHERE   [ExecutionMessageTypeId] = 2 )
        BEGIN
            INSERT  [SystemLog].[ExecutionMessageTypes]
                    ( [ExecutionMessageTypeId] ,
                      [ExecutionMessageTypeName] ,
                      [ExecutionMessageTypeDescription]
                    )
            VALUES  ( 2 ,
                      N'Warning' ,
                      N'The message logged is a warning.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionMessageTypes]
                    WHERE   [ExecutionMessageTypeId] = 3 )
        BEGIN
            INSERT  [SystemLog].[ExecutionMessageTypes]
                    ( [ExecutionMessageTypeId] ,
                      [ExecutionMessageTypeName] ,
                      [ExecutionMessageTypeDescription]
                    )
            VALUES  ( 3 ,
                      N'Information' ,
                      N'The message logged is informative only.'
                    );
        END;


--ExecutionStatus fixed members
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 0 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 0 ,
                      N'Unkmown' ,
                      N''
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 1 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 1 ,
                      N'Execution created' ,
                      N'The SSIS execution has been initiated.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 2 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 2 ,
                      N'Running' ,
                      N'The SSIS execution is currently running.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 3 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 3 ,
                      N'Cancelled' ,
                      N'The SSIS execution has been cancelled.'
                    );
        END;


    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 4 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 4 ,
                      N'Failed' ,
                      N'The SSIS execution encountered errors.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 5 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 5 ,
                      N'Pending' ,
                      N'The SSIS execution is pending.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 6 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 6 ,
                      N'Ended unexpectedly' ,
                      N'The SSIS execution could not finish.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 7 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 7 ,
                      N'Succeeded' ,
                      N'The SSIS execution completed successfully.'
                    );
        END;

    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 8 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 8 ,
                      N'Stopping' ,
                      N'The SSIS execution is currently stopping.'
                    );
        END;
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[ExecutionStatus]
                    WHERE   [ExecutionStatusId] = 9 )
        BEGIN
            INSERT  [SystemLog].[ExecutionStatus]
                    ( [ExecutionStatusId] ,
                      [ExecutionStatusName] ,
                      [ExecutionStatusDescription]
                    )
            VALUES  ( 9 ,
                      N'Completed' ,
                      N'The SSIS execution has completed.'
                    );
        END;

   --SystmeLog.LoadApplication unkmown member
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[LoadApplications] AS [la]
                    WHERE   [la].[LoadApplicationId] = 0 )
        BEGIN
            SET IDENTITY_INSERT [SystemLog].[LoadApplications] ON;
            INSERT  INTO [SystemLog].[LoadApplications]
                    ( [LoadApplicationId] ,
                      [ApplicationName] ,
                      [ApplicationDescription]
                    )
            VALUES  ( 0 ,
                      N'Unknown',
                      N'Unknown load application'
		            );
            SET IDENTITY_INSERT [SystemLog].[LoadApplications] OFF;
        END;

		--SystmeLog.LoadApplication SSIS CookBook application
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[LoadApplications] AS [la]
                    WHERE   [la].[LoadApplicationId] = 1 )
        BEGIN
            SET IDENTITY_INSERT [SystemLog].[LoadApplications] ON;
            INSERT  INTO [SystemLog].[LoadApplications]
                    ( [LoadApplicationId] ,
                      [ApplicationName] ,
                      [ApplicationDescription]
                    )
            VALUES  ( 1 ,
                      N'SSIS CookBook',
                      N'SSIS CookBook sample application'
		            );
            SET IDENTITY_INSERT [SystemLog].[LoadApplications] OFF;
        END;

	--SystmeLog.Loads unkmown member
    IF NOT EXISTS ( SELECT TOP 1
                            1
                    FROM    [SystemLog].[Loads] AS [l]
                    WHERE   [l].[LoadId] =-1 )
        BEGIN
            SET IDENTITY_INSERT [SystemLog].[Loads] ON;
            INSERT  INTO [SystemLog].[Loads]
                    ( [LoadId] ,
                      [LoadStartDateTime] ,
                      [LoadEndDateTime] ,
                      [LoadStatusId],
					  [LoadApplicationId]
                    )
            VALUES  ( -1 ,
                      CAST('1900-01-01' AS DATETIME) ,
                      CAST('1900-01-01' AS DATETIME) ,
                      0,
					  0
		            );
            SET IDENTITY_INSERT [SystemLog].[Loads] OFF;
        END;
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [SystemLog].[LoadExecutions] WITH CHECK CHECK CONSTRAINT [FK_Executions_To_Loads];

ALTER TABLE [SystemLog].[Loads] WITH CHECK CHECK CONSTRAINT [FK_Loads_To_LoadApplications];

ALTER TABLE [SystemLog].[Loads] WITH CHECK CHECK CONSTRAINT [FK_Loads_To_ExectionStatus];


GO
PRINT N'Update complete.';


GO
