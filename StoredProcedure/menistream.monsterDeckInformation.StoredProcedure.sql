USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[monsterDeckInformation]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[monsterDeckInformation]
AS BEGIN
	SELECT *
	FROM monsterDeckDefineTbl
END
GO
