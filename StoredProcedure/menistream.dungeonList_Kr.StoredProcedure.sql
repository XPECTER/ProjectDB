USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[dungeonList_Kr]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[dungeonList_Kr]
AS BEGIN
	SELECT * FROM dungeonDefineTbl_Kr
	ORDER BY zoneDefineKey, dungeonDefineKey
END
GO
