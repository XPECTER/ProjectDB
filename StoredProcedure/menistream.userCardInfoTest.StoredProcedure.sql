USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userCardInfoTest]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userCardInfoTest](
	@userKey char(10)
)
AS BEGIN
	DECLARE @string varchar(MAX)
	
	SET @string = 
	(SELECT * 
	FROM cardTbl INNER JOIN cardDefineTbl_Kr
	ON userKey = @userKey AND cardTbl.cardDefineKey = cardDefineTbl_Kr.cardDefineKey
	FOR XML RAW('cardTbl'), ELEMENTS)
	
	SELECT @string AS DBXML
END
GO
