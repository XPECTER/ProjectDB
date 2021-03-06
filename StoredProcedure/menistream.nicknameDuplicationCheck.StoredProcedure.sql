USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[nicknameDuplicationCheck]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[nicknameDuplicationCheck](
	@userNickname varchar(20)
)
AS BEGIN
	DECLARE @result varchar(10)
	
	IF (SELECT userNickname FROM userTbl WHERE userNickname = @userNickname) is null
		SET @result = 'success'
	ELSE
		SET @result = 'false'
		
	SELECT @result AS result
END
GO
