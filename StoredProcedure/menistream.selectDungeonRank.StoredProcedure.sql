USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[selectDungeonRank]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--INSERT INTO dungeonRankTbl
--VALUES ('E3F55920C8', '_', 'ZN0101', 'DG002', 19283, '05:10:22')

--SELECT * FROM dungeonRankTbl

CREATE PROC [menistream].[selectDungeonRank](
	@userKey char(10),
	@zoneDefineKey char(6),
	@dungeonDefineKey char(5)
)
AS BEGIN
BEGIN TRAN
	CREATE TABLE #tempDungeonRankTbl(
		ranking int identity(1, 1),
		userKey char(10),
		userLevel smallint,
		userProfileCardDefineKey varchar(16),
		userScore int,
		clearTime time(0)
	)
	
	INSERT INTO #tempDungeonRankTbl
	SELECT userKey,(SELECT userLevel FROM userTbl WHERE userKey = @userKey) AS userLevel, 
	userProfileCardDefineKey, userScore, clearTime 
	FROM dungeonRankTbl
	WHERE zoneDefineKey = @zoneDefineKey AND dungeonDefineKey = @dungeonDefineKey
	ORDER BY userScore DESC
		
	SELECT * FROM #tempDungeonRankTbl WHERE ranking BETWEEN (SELECT ranking FROM #tempDungeonRankTbl WHERE userKey = @userKey)-5 AND
	(SELECT ranking FROM #tempDungeonRankTbl WHERE userKey = @userKey)+5 
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		DROP TABLE #tempDungeonRankTbl
		COMMIT TRAN
END
GO
