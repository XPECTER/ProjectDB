USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDeckCreate]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userDeckCreate](
	@userKey char(10)
)
AS
BEGIN
	BEGIN TRAN
	
	DECLARE @int int
	DECLARE @string varchar(MAX)
	
	EXEC createCard @userKey = @userKey, @cardDefineKey = '10000000110'
	
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011004001'
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011005001'
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011006001'
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011007001'
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011008001'
	--EXEC createCard @userKey = @userKey, @cardDefineKey = '10011009001'
	--SET @int = 10
	--WHILE @int < 52
	--BEGIN
	--	SET @string = '100110' + CAST(@int AS varchar(2)) + '001'
	--	EXEC createCard @userKey = @userKey, @cardDefineKey = @string
		
	--	SET @int += 1
	--END
	
	INSERT INTO deckTbl
	VALUES (@userKey, '1번덱', 0, 0, 
	(SELECT cardKey FROM cardTbl WHERE userKey = @userKey AND cardDefineKey = '10000000110'), 
	'_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_')
	
	INSERT INTO deckTbl
		VALUES (@userKey, '2번덱', 1, 0, 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_')
	
	INSERT INTO deckTbl
	VALUES (@userKey, '3번덱', 2, 0, 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_')
	
	INSERT INTO deckTbl
	VALUES (@userKey, '4번덱', 3, 0, 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_')
	
	INSERT INTO deckTbl
	VALUES (@userKey, '방어덱', 4, 0, 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_', '_',
	'_', '_', '_', '_', '_', '_', '_', '_', '_')
	
	
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		COMMIT TRAN
	END
END
GO
