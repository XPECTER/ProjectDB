USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[raidAppear]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[raidAppear](
	@raidDefineKey char(5),
	@discoverUserKey char(10)
)
AS BEGIN
BEGIN TRAN	
	DECLARE @raidKey AS char(10)
	SET @raidKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 10)
	
	DECLARE @discoverUserNickname AS varchar(20)
	SET @discoverUserNickname = (SELECT userNickname FROM userTbl
	WHERE userKey = @discoverUserKey)
	
	DECLARE @raidHealthPoint AS int
	SET @raidHealthPoint = (SELECT raidHealthPoint FROM raidDefineTbl_Kr
	WHERE raidDefineKey = @raidDefineKey)
	
	DECLARE @extinctionTime AS smalldatetime
	SET @extinctionTime = GETDATE() +
	(SELECT duelLimitTime FROM raidDefineTbl_Kr WHERE raidDefineKey = @raidDefineKey)
	
	INSERT INTO raidOnProgressTbl
	VALUES (@raidKey, @raidDefineKey, @discoverUserKey, @discoverUserNickname,
		@raidHealthPoint, @raidHealthPoint, GETDATE(), @extinctionTime)
	
IF @@ERROR > 0
	ROLLBACK TRAN
ELSE
	COMMIT TRAN	
END
GO
