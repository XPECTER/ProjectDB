USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[zoneList_Kr]    Script Date: 04/05/2015 10:54:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[zoneList_Kr]
AS BEGIN
	SELECT * FROM zoneDefineTbl_Kr
END
GO
