USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userItemList]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userItemList](
	@userKey char(10)
	)
	AS BEGIN
		SELECT itemDefineKey, itemAmount FROM itemTbl WHERE userKey = @userKey
	END
GO
