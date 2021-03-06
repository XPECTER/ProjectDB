USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[dungeonDefeat]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [menistream].[dungeonDefeat](
	@userKey char(10),
	@zoneDefineKey char(5),
	@dungeonDefineKey char(5)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @string varchar(20)
		
	UPDATE userRecordTbl
	SET dungeonDefeat += 1
	WHERE userKey = @userKey
	
	IF NOT EXISTS (SELECT userKey, dungeonDefineKey 
	FROM dungeonClearLogTbl
	WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey AND zoneDefineKey = @zoneDefineKey)
		INSERT INTO dungeonClearLogTbl
		VALUES (@userKey, @zoneDefineKey, @dungeonDefineKey, 0, null)
			
	IF @@ERROR > 0
	BEGIN	
		SET @string = 'false'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SET @string = 'success'
		COMMIT TRAN
	END
	
	SELECT @string AS result
END
GO
