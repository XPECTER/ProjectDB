USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[missionList_Kr]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[missionList_Kr]
AS BEGIN
	SELECT * FROM missionDefineTbl_Kr
END
GO
