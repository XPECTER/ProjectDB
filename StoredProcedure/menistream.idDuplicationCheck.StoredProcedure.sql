USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[idDuplicationCheck]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[idDuplicationCheck](
	@userId varchar(100)
)
AS BEGIN
	DECLARE @result varchar(10)
		
	IF (SELECT userId FROM userTbl WHERE userId = @userId) is null
		SET @result = 'success'
	ELSE
		SET @result = 'false'
		
	SELECT @result AS result
END
GO
