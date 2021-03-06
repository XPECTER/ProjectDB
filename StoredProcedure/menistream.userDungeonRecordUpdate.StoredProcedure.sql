USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDungeonRecordUpdate]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userDungeonRecordUpdate](
	@userKey int,
	@battleFlag tinyint,
	@people tinyint	
)
AS BEGIN
	BEGIN TRAN
	
	IF @people = 0
		IF @battleFlag = 0
			UPDATE userRecordTbl
			SET	soloDungeonDefeat += 1
			WHERE userKey = @userKey
		ELSE
			UPDATE userRecordTbl
			SET soloDungeonWin += 1
			WHERE userKey = @userKey
	ELSE
		IF @battleFlag = 0
			UPDATE userRecordTbl
			SET	coupleDungeonDefeat += 1
			WHERE userKey = @userKey
		ELSE
			UPDATE userRecordTbl
			SET coupleDungeonWin += 1
			WHERE userKey = @userKey
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
