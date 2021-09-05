USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[deckInformation_Kr]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[deckInformation_Kr](
	@userKey char(10)
)
AS BEGIN
	SELECT *
	FROM deckTbl
	WHERE userKey = @userKey
	ORDER BY deckNum
END
GO
