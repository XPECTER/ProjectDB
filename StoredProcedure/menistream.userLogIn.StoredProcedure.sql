USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userLogIn]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLogIn](
	@userId varchar(50),
	@userPassword varchar(20)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(10), @userKey char(10)
		
	IF (SELECT userId FROM userTbl WHERE userId = @userId) IS NULL
	BEGIN	
		SET @result = 'false'
		SELECT @result AS RESULE
	END
	ELSE
	BEGIN
		IF (SELECT userPassword FROM userTbl WHERE userId = @userId AND userPassword = @userPassword) is NULL 
		BEGIN
			SET @result = 'false'
			SELECT @result AS RESULT
		END
		ELSE
		BEGIN
			SET @userKey = (SELECT userKey FROM userTbl WHERE userId = @userId)
			SET @result = 'success'
			
			INSERT INTO logInOutLogTbl
			VALUES (@userKey, GETDATE(), NULL, NULL, NULL)
			
			SELECT @result AS RESULT, lobbyView.* FROM lobbyView WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
