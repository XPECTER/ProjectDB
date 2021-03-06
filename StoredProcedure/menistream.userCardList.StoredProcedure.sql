USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userCardList]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[userCardList](
	@userKey char(10)
)
AS BEGIN
	SELECT cardKey, cardDefineKey, cardLevel, cardUpgrade, cardState, tradeKey, tradeState, cardExp 
	FROM cardTbl
	WHERE userKey = @userKey
	ORDER BY cardDefineKey ASC
END
GO
