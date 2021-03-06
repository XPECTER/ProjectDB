USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[caculateSellCard]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[caculateSellCard](
	@userKey char(10),
	@totalPrice int
)
AS BEGIN
	BEGIN TRAN
	DECLARE @result varchar(10)
	
	UPDATE userPropertyTbl
	SET userGold += @totalPrice
	WHERE userKey = @userKey
	
	IF @@ERROR > 0
	BEGIN
		SET @result = 'false'
		ROLLBACK TRAN
	END
	ElSE
	BEGIN
		SET @result = 'success'
		COMMIT TRAN
	END
	
	SELECT @result AS RESULT
END
GO
