USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[useRaidCostRecoveryPotion]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[useRaidCostRecoveryPotion](
	@userKey int
)
AS
BEGIN
	BEGIN TRAN
	
	IF NOT EXISTS (SELECT userKey, itemDefineKey FROM itemTbl WHERE userKey = @userKey AND itemDefineKey = 1001)
		ROLLBACK TRAN
	ELSE
	BEGIN
		UPDATE userGameTbl
		SET userGameTbl.raidCost = userGameTbl.maxRaidCost,	userGameTbl.updateRaidCosttime = GETDATE()
		WHERE userKey = @userKey
		
		UPDATE itemTbl
		SET itemAmount -= 1
		WHERE userKey = @userKey AND itemDefineKey = 1001
	END
	
	IF @@ERROR > 0
		ROlLBACK TRAN
	ELSE
		COMMIT TRAN	
END
GO
