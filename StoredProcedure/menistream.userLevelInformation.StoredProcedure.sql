USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userLevelInformation]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLevelInformation]
AS BEGIN
	SELECT *
	FROM userLevelDefineTbl
END
GO
