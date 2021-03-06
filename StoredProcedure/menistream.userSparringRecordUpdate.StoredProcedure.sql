USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userSparringRecordUpdate]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userSparringRecordUpdate](
	@userKey int,
	@battleFlag tinyint,
	@defenceFlag tinyint,
	@people tinyint
)
AS BEGIN
	BEGIN TRAN
	
	IF @people = 0
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloSparringDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloSparringWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloSparringDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloSparringDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	ELSE
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleSparringDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleSparringWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleSparringDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleSparringDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
