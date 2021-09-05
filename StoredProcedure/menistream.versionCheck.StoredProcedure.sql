USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[versionCheck]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[versionCheck]
AS BEGIN
	SELECT TOP 1 versionNum, cardInfoVersion, cardSkillInfoVersion, dungeonInfoVersion, zoneInfoVersion, storeInfoVersion, missionInfoVersion, itemInfoVersion
	FROM versionTbl
	ORDER BY versionUpdateTime DESC
END

--EXEC versionCheck
GO
