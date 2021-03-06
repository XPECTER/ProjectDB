USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[challengeDeckRegister]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[challengeDeckRegister](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
		DECLARE @result AS varchar(10)
	
		IF EXISTS (SELECT userKey FROM currentChallengeRankTbl WHERE userKey = @userKey)
			SET @result = 'false'			
		ELSE BEGIN
			INSERT INTO currentChallengeRankTbl
			VALUES (@userKey, (SELECT userNickname FROM userTbl WHERE userKey = @userKey), 0, 0, '_', '_', '0')
			
			SET @result = 'success'
		END
		
	IF @@ERROR > 0 
	BEGIN
		ROLLBACK TRAN
		SELECT @result AS RESULT
	END
	ELSE BEGIN
		COMMIT TRAN
		SELECT @result AS RESULT
	END
END
GO
