USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[dungeonClear]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[dungeonClear](
	@userKey char(10),
	@zoneDefineKey char(5),
	@dungeonDefineKey char(5),
	@clearRank tinyint,
	@clearTime varchar(10)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(20)
	
	SET @clearTime = CAST(@clearTime as time(0))
	
	IF EXISTS (SELECT userKey, dungeonDefineKey FROM dungeonClearLogTbl 
		WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey)
		UPDATE dungeonClearLogTbl
		SET dungeonClearLogTbl.clearRank = @clearRank, dungeonClearLogTbl.clearTime = @clearTime
		WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey
	ELSE
		INSERT INTO dungeonClearLogTbl
		VALUES (@userKey, @zoneDefineKey, @dungeonDefineKey, @clearRank, @clearTime)
	
	UPDATE userRecordTbl
	SET dungeonWin += 1
	WHERE userKey = @userKey
		
	IF @@ERROR > 0
	BEGIN
		SET @result = 'false'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SET @result = 'success'
		COMMIT TRAN
	END
	
	SELECT @result AS result	
END
GO
