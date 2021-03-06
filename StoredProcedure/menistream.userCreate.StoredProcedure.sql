USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userCreate]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userCreate](
	@userId varchar(50),
	@userPassword varchar(30),
	@userNickname varchar(20)	
)
AS BEGIN 
	BEGIN TRAN
	
	DECLARE @userKey AS char(10)
	SET @userKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 10)
	
	-- userTblCreate
	INSERT INTO userTbl
	VALUES (@userKey, @userId, @userPassword, @userNickname, '0', NULL, NULL, 1, 0, '_', 0)
		
	-- userPropertyTblCreate
	INSERT INTO userPropertyTbl
	VALUES (@userKey, 0, 0, (SELECT maxCardInventory FROM worldValueTbl), 1)
	
	-- userGameTblCreate
	INSERT INTO userGameTbl
	VALUES (@userKey, '_', 50, GETDATE(), 50, 50, GETDATE(), 50, 0, 0, '_', '_')
	
	-- userRecordTblCreate
	INSERT INTO userRecordTbl
	VALUES (@userKey, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	
	-- 앞의 @userKey는 userDeckCreate의 변수명, 뒤의 @userKey는 현재 프로시저에서 선언한 변수
	EXEC userDeckCreate @userKey = @userKey
	
	-- 앞의 @userKey는 userDeckCreate의 변수명, 뒤의 @userKey는 프로시저 변수명
	EXEC userShowWindowCreate @userKey = @userKey
	
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRAN
		SET @userKey = 'false'
		SELECT @userKey AS userKey
	END
	ELSE
	BEGIN
		COMMIT TRAN
		SELECT @userKey AS userKey
	END
END
GO
