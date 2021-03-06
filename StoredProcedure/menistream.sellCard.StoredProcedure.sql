USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[sellCard]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[sellCard](
	@userKey char(10),
	@cardKey varchar(16)
)
AS BEGIN
	BEGIN TRAN
	
	-- 카드에 대한 판매금액 리턴	
	SELECT needBuyUserGold / 2 FROM cardDefineTbl_Kr WHERE cardDefineKey = 
	(SELECT cardDefineKey FROM cardTbl WHERE cardKey = @cardKey)
	
	-- cardTbl에서 해당 유저가 선택한 카드를 지운다.
	DELETE FROM cardTbl
	WHERE userKey = @userKey AND cardKey = @cardKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
