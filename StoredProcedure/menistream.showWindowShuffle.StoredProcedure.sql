USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[showWindowShuffle]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[showWindowShuffle](	
	@jobType smallint,
	@element smallint,
	@rarity smallint,
	@season smallint,
	@randomNum int
)
AS BEGIN
	DECLARE @minJobType tinyint, @maxJobType tinyint
	DECLARE @minElement tinyint, @maxElement tinyint
	DECLARE @minRarity tinyint, @maxRarity tinyint
	DECLARE @minSeason tinyint, @maxSeason tinyint
	
	IF @jobType = -1
	BEGIN
		SET @minJobType = 0
		SET @maxJobType = (SELECT COUNT(jobType) FROM jobDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minJobType = @jobType
		SET @maxJobType = @jobType
	END
	
	IF @element = -1
	BEGIN
		SET @minElement = 0
		SET @maxElement = (SELECT MAX(element) FROM cardDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minElement = @element
		SET @maxElement = @element
	END
	
	IF @rarity = -1
	BEGIN
		SET @minRarity = 0
		SET @maxRarity = (SELECT COUNT(rarity) FROM cardCombinationDefineTbl)
	END
	ELSE
	BEGIN
		SET @minRarity = @rarity
		SET @maxRarity = @rarity
	END
	
	IF @season = -1
	BEGIN
		SET @minSeason = 0
		SET @maxSeason = (SELECT MAX(season) FROM cardDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minSeason = @season
		SET @maxSeason = @season
	END
	
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '#gachaTbl')
		DROP TABLE #gachaTbl
	
	CREATE TABLE #gachaTbl(
		gachaNum int IDENTITY(0, 1),
		cardDefineKey varchar(20)
	)
	
	INSERT INTO #gachaTbl(cardDefineKey)
	SELECT cardDefineKey FROM cardDefineTbl_Kr
	WHERE cardLevel = 1 AND cardUpgrade = 0 AND jobType BETWEEN @minJobType AND @maxJobType
	AND element BETWEEN @minElement AND @maxElement
	AND season BETWEEN @minSeason AND @maxSeason
	AND rarity BETWEEN @minRarity AND @maxRarity 
	
	SELECT cardDefineKey FROM #gachaTbl WHERE gachaNum = @randomNum
END
GO
