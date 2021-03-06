USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[useDungeonCostRecoveryPotion]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[useDungeonCostRecoveryPotion](
	@userKey int
)
AS
BEGIN
	BEGIN TRAN
	
	UPDATE userGameTbl
	SET userGameTbl.dungeonCost = userGameTbl.maxDungeonCost,
	userGameTbl.updateDungeonCostTime = GETDATE()
	WHERE userGameTbl.userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
