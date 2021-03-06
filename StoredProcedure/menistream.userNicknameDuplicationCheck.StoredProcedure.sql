USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userNicknameDuplicationCheck]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userNicknameDuplicationCheck](
	@userNickname varchar(30)
)
AS BEGIN
	DECLARE @result varchar(10)
	
	IF EXISTS (SELECT userNickname FROM userTbl WHERE userNickname = @userNickname)
		SET @result = 'false'
	ELSE
		SET @result = 'true'
	
	SELECT @result AS RESULT
END
GO
