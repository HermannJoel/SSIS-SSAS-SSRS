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
:setvar SSISDB "SSISDB"
:setvar DatabaseName "AdventureworksLTDW2016"
:setvar DefaultFilePrefix "AdventureworksLTDW2016"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQL2017\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQL2017\MSSQL\DATA\"

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
PRINT N'Altering [SystemLog].[CloseLoadExecution]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
ALTER PROCEDURE [SystemLog].[CloseLoadExecution]
    @LoadExecutionId BIGINT
AS
    DECLARE @SSISExecutionId BIGINT = 0, @EndExecutionDateTime DATETIME = GETDATE()
	, @ErrorCount BIGINT = 0, @ErrorExecutionStatusId TINYINT = 4
	, @SuccessExecutionStatusId TINYINT = 7, @LoadExecutionStatusId TINYINT = 0;
	DECLARE @SSISExecutionIdTbl TABLE (SSISExecutionId BIGINT NOT NULL);
	
    UPDATE  [le]
    SET     [le].[ExecutionEndDateTime] = @EndExecutionDateTime
    OUTPUT  [Inserted].[SSISServerExecutionId]
            INTO @SSISExecutionIdTbl
    FROM    [SystemLog].[LoadExecutions] AS [le]
    WHERE   [le].[LoadExecutionId] = @LoadExecutionId;


	SELECT @SSISExecutionId = [s].[SSISExecutionId]
	FROM @SSISExecutionIdTbl AS [s];

	-- Retreive Catalog Execution statstics and insert them into [SystemLog].[ExecutionStatistics] table
    INSERT  INTO [SystemLog].[ExecutionStatictics]
            (
              [LoadExecutionId]
            , [SSISProjectName]
            , [SSISPackageName]
            , [SSISPackageStartDateTime]
            , [SSISPackageEndDateTime]
            , [DataFlowPathIdString]
            , [SourceComponentName]
            , [DestinationComponentName]
            , [RowsSent]
	        )
            SELECT  @LoadExecutionId
				  , [e].[project_name]
                  , [eds].[package_name]
                  , [e].[start_time] AS [package_start_time]
                  , [e].[end_time] AS [package_end_time]
                  , [dataflow_path_id_string]
                  , [source_component_name]
                  , [destination_component_name]
                  , SUM([rows_sent]) AS [rows_sent]
            FROM    [$(SSISDB)].[catalog].[execution_data_statistics] AS [eds]
                    INNER JOIN [$(SSISDB)].[catalog].[executions] AS [e] ON [e].[execution_id] = [eds].[execution_id]
            WHERE   [e].[execution_id] = @SSISExecutionId
            GROUP BY [eds].[package_name]
			      , [e].project_name
                  , [e].[start_time]
                  , [e].[end_time]
                  , [dataflow_path_id_string]
                  , [source_component_name]
                  , [destination_component_name];

				  --Retrieve execution messages and insert them innsert them into [SystemLog].[ExecutionMessages] table
    WITH    [ExecutionMessage] ( [RoundedMessageTime], [message], [package_name], [event_name], [message_source_name], [subcomponent_name], [package_path], [execution_path], [ExecutionMessageTypeId] )
              AS ( SELECT TOP 100 PERCENT
                            CAST(YEAR([message_time]) AS NVARCHAR) + '-'
                            + LEFT('0'
                                   + CAST(MONTH([message_time]) AS NVARCHAR) ,
                                   2) + '-' + LEFT('0'
                                                   + CAST(DAY([message_time]) AS NVARCHAR) ,
                                                   2) + ' ' + LEFT('0'
                                                              + CAST(DATEPART(HOUR ,
                                                              [message_time]) AS NVARCHAR) ,
                                                              2) + ':'
                            + LEFT('0'
                                   + CAST(DATEPART(MINUTE , [message_time]) AS NVARCHAR) ,
                                   2) + ':' + LEFT('0'
                                                   + CAST(DATEPART(SECOND ,
                                                              [message_time]) AS NVARCHAR) ,
                                                   2) AS [RoundedMessageTime]
                          , [message]
                          , [package_name]
                          , [event_name]
                          , [message_source_name]
                          , [subcomponent_name]
                          , [package_path]
                          , [execution_path]
						  , [emt].[ExecutionMessageTypeId]
                   FROM     [$(SSISDB)].[catalog].[event_messages] AS [em] WITH (READUNCOMMITTED) 
                            INNER JOIN [SystemLog].[ExecutionMessageTypes] AS [emt] ON [em].[message_type] = [emt].[SSISDBMessageType]
                   WHERE    [operation_id] = @SSISExecutionId
                   ORDER BY [message_time]
                 )
        INSERT  INTO [SystemLog].[ExecutionMessages]
                (
                  [LoadExecutionId]
                , [ExecutionMessageDateTime]
                , [ExecutionMessage]
                , [SSISPackageName]
                , [SSISEventName]
                , [SourceComponentName]
                , [PackagePathIdString]
                , [ExecutionPathIdString]
				, [ExecutionMessageTypeId]

	            )
                SELECT DISTINCT
                        @LoadExecutionId
                      , [RoundedMessageTime]
                      , [message]
                      , [package_name]
                      , [event_name]
                      , [message_source_name]
                      --, [subcomponent_name]
                      , [package_path]
                      , [execution_path]
					  , [ExecutionMessageTypeId]
                FROM    [ExecutionMessage];

				SELECT @ErrorCount = COUNT(*)
				FROM [SystemLog].[ExecutionMessages] AS [emt]
				WHERE [emt].[ExecutionMessageTypeId] = 1
				AND [emt].LoadExecutionId = @LoadExecutionId;

				SET @LoadExecutionStatusId = IIF((@ErrorCount = 0), @SuccessExecutionStatusId, @ErrorExecutionStatusId);

				
				UPDATE [SystemLog].[LoadExecutions]
				SET [ExecutionStatusId] = @LoadExecutionStatusId
				WHERE [LoadExecutionId] = @LoadExecutionId;
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


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
                      [ExecutionMessageTypeDescription],
					  [SSISDBMessageType]
                    )
            VALUES  ( 1 ,
                      N'Error' ,
                      N'The message logged contains the error derscription.',
					  120
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
                      [ExecutionMessageTypeDescription],
					  [SSISDBMessageType]
                    )
            VALUES  ( 2 ,
                      N'Warning' ,
                      N'The message logged is a warning.',
					  110
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
                      [ExecutionMessageTypeDescription],
					  [SSISDBMessageType]
                    )
            VALUES  ( 3 ,
                      N'Information' ,
                      N'The message logged is informative only.',
					  70
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
PRINT N'Update complete.';


GO
