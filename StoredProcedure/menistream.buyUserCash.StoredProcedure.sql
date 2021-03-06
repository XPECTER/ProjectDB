USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[buyUserCash]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyUserCash](
	@userKey char(10),
	@userCash int
)
AS BEGIN
	BEGIN TRAN
	DECLARE @result varchar(10)
	
	UPDATE userPropertyTbl
	SET userCash += @userCash
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
	
	SELECT @result AS RESULT
END
GO
