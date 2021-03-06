USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userJackpotRecordUpdate]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userJackpotRecordUpdate](
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
				SET soloJackpotDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloJackpotWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloJackpotDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloJackpotDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	ELSE
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleJackpotDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleJackpotWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleJackpotDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleJackpotDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
