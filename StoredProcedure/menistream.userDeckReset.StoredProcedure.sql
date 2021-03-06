USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDeckReset]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userDeckReset](
	@userKey char(10),
	@deckNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @string varchar(20)
	
	UPDATE deckTbl
	SET cardKey_0 = '_', cardKey_1 = '_', cardKey_2 = '_', cardKey_3 = '_',
		cardKey_4 = '_', cardKey_5 = '_', cardKey_6 = '_', cardKey_7 = '_',
		cardKey_8 = '_', cardKey_9 = '_', cardKey_10 = '_', cardKey_11 = '_',
		cardKey_12 = '_', cardKey_13 = '_', cardKey_14 = '_', cardKey_15 = '_',
		cardKey_16 = '_', cardKey_17 = '_', cardKey_18 = '_', cardKey_19 = '_',
		cardKey_20 = '_', cardKey_21 = '_', cardKey_22 = '_', cardKey_23 = '_',
		cardKey_24 = '_', cardKey_25 = '_', cardKey_26 = '_', cardKey_27 = '_',
		cardKey_28 = '_', cardKey_29 = '_', cardKey_30 = '_', cardKey_31 = '_',
		cardKey_32 = '_', cardKey_33 = '_', cardKey_34 = '_', cardKey_35 = '_',
		cardKey_36 = '_', cardKey_37 = '_', cardKey_38 = '_', cardKey_39 = '_',
		cardKey_40 = '_', cardKey_41 = '_', cardKey_42 = '_', cardKey_43 = '_',
		cardKey_44 = '_', cardKey_45 = '_', cardKey_46 = '_', cardKey_47 = '_',
		cardKey_48 = '_'
	WHERE userKey = @userKey AND deckNum = @deckNum
	
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
