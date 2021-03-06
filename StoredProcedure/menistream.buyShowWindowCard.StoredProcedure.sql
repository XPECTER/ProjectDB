USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowCard]    Script Date: 04/05/2015 10:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowCard](
	@userKey char(10),
	@buyMoneyType varchar(10),
	@price int
)
AS BEGIN
	BEGIN TRAN
	
	IF @buyMoneyType = 'Gold'
		UPDATE userPropertyTbl
		SET	userGold -= @price
		WHERE userKey = @userKey
	ELSE IF @buyMoneyType = 'Cash'
		UPDATE userPropertyTbl
		SET userCash -= @price
		WHERE userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN	
END
GO
