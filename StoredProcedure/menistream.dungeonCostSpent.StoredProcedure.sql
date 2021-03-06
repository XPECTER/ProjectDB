USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[dungeonCostSpent]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[dungeonCostSpent](
	@userKey char(10),
	@dungeonCost tinyint
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(10)
	
	IF (SELECT dungeonCost FROM userGameTbl WHERE userKey = @userKey) < @dungeonCost
	BEGIN
		SET @result = 'false'
	END
	ELSE
	BEGIN
		IF (SELECT dungeonCost FROM userGameTbl WHERE userKey = @userKey) = 
			(SELECT maxDungeonCost FROM userGameTbl WHERE userKey = @userKey)
		BEGIN
			UPDATE userGameTbl
			SET dungeonCost -= @dungeonCost, updateDungeonCostTime = GETDATE()
			WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			UPDATE userGameTbl
			SET dungeonCost -= @dungeonCost
			WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
	BEGIN
		SET @result = 'false'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SET @result = 'success'
		COMMIT TRAN
	END
	
	SELECT @result AS RESULT
END
GO
