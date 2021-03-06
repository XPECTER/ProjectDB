USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[insertShowWindow]    Script Date: 04/05/2015 10:54:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[insertShowWindow](
	@userKey char(10),
	@cardDefineKey_1 varchar(20),
	@cardDefineKey_2 varchar(20),
	@cardDefineKey_3 varchar(20),
	@cardDefineKey_4 varchar(20),
	@cardDefineKey_5 varchar(20),
	@cardDefineKey_6 varchar(20)
)
AS BEGIN
	BEGIN TRAN
	DECLARE @showWindowNum tinyint
	SET @showWindowNum = (SELECT TOP 1 showWindowNum FROM showWindowTbl 
	WHERE userKey = @userKey ORDER BY resetTime DESC)
	
	IF @showWindowNum <=4
		SET @showWindowNum += 1
	ELSE IF @showWindowNum = 5
		SET @showWindowNum = 1	
	
	UPDATE showWindowTbl
	SET cardDefineKey_1 = @cardDefineKey_1, cardDefineKey_2 = @cardDefineKey_2,
		cardDefineKey_3 = @cardDefineKey_3, cardDefineKey_4 = @cardDefineKey_4,
		cardDefineKey_5 = @cardDefineKey_5, cardDefineKey_6 = @cardDefineKey_6,
		resetTime = CURRENT_TIMESTAMP
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
	
	UPDATE userPropertyTbl
	SET activeShowWindowNum = @showWindowNum
	WHERE userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
