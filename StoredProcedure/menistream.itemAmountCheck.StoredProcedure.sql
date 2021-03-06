USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[itemAmountCheck]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[itemAmountCheck](
	@userKey char(10),
	@itemDefineKey varchar(6)
)
AS BEGIN
	DECLARE @result varchar(10)

	IF (SELECT itemAmount FROM itemTbl WHERE userKey = @userKey AND itemDefineKey = @itemDefineKey) = 0
	BEGIN
		SET @result = 'false'
		SELECT @result AS RESULT
	END
	ELSE
	BEGIN
		SET @result = 'success'
		SELECT @result AS RESULT
	END
END
GO
