USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[selectDungeonRankTop10]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[selectDungeonRankTop10](
	@zoneDefineKey char(6),
	@dungeonDefineKey char(5)
)
AS BEGIN
BEGIN TRAN
	CREATE TABLE #tempDungeonRankTop10Tbl(
		ranking int identity(1, 1),
		userKey char(10),
		userLevel smallint,
		userProfileCardDefineKey varchar(16),
		userScore int,
		clearTime time(0)
	)
	
	INSERT INTO #tempDungeonRankTop10Tbl
	SELECT userKey,(SELECT userLevel FROM userTbl WHERE userTbl.userKey = dungeonRankTbl.userKey) AS userLevel, 
	userProfileCardDefineKey, userScore, clearTime 
	FROM dungeonRankTbl
	WHERE zoneDefineKey = @zoneDefineKey AND dungeonDefineKey = @dungeonDefineKey
	ORDER BY userScore DESC, clearTime ASC
	
	SELECT TOP 10 * FROM #tempDungeonRankTop10Tbl
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		DROP TABLE #tempDungeonRankTop10Tbl
		COMMIT TRAN
END
GO
