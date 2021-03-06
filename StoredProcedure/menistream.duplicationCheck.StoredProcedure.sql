USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[duplicationCheck]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[duplicationCheck](
	@userId varchar(100),
	@userPassword varchar(100),
	@userNickname varchar(30)
)
AS BEGIN
	DECLARE @string varchar(10)

	IF EXISTS (SELECT userId FROM userTbl WHERE userId = @userId)
		SET @string = 'false'
	ELSE IF NOT EXISTS (SELECT userId FROM userTbl WHERE userId = @userId)
	BEGIN
		EXEC userCreate @userId = @userId, @userPassword = @userPassword, @userNickname = @userNickname
		SET @string = 'success'
	END
	
	SELECT @string AS RESULT
END
GO
