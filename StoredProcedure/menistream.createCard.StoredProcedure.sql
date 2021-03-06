USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[createCard]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[createCard](
	@userKey char(10),
	@cardDefineKey varchar(15)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @cardKey char(16), @result varchar(10)
	SET @cardKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16)
	
	WHILE (SELECT cardKey FROM cardTbl WHERE cardKey = @cardKey) IS NOT NULL 
	BEGIN
		SET @cardKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16)
		 
		IF (SELECT cardKey FROM cardTbl WHERE cardKey = @cardKey) IS NOT NULL
			CONTINUE
		ELSE
			BREAK
	END
	
	INSERT INTO cardTbl
	VALUES (@userKey, @cardKey ,@cardDefineKey, 
	(SELECT cardLevel FROM cardDefineTbl_Kr WHERE cardDefineKey = @cardDefineKey),
	(SELECT cardUpgrade FROM cardDefineTbl_Kr WHERE cardDefineKey = @cardDefineKey),
	0, '_', '0', 0)

	IF @@ERROR > 0
	BEGIN
		SET @result = 'false'
		SELECT @result AS RESULT
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		SET @result = 'success'
		SELECT @result AS RESULT
		COMMIT TRAN
	END
END
GO
