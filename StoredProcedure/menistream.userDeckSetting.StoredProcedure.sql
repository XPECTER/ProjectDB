USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDeckSetting]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userDeckSetting](
	@userKey char(10),
	@deckNum tinyint,
	@cardKey_0 char(16), @cardKey_1 char(16), @cardKey_2 char(16), @cardKey_3 char(16),
	@cardKey_4 char(16), @cardKey_5 char(16), @cardKey_6 char(16), @cardKey_7 char(16), 
	@cardKey_8 char(16), @cardKey_9 char(16), @cardKey_10 char(16), @cardKey_11 char(16), 
	@cardKey_12 char(16), @cardKey_13 char(16), @cardKey_14 char(16), @cardKey_15 char(16),
	@cardKey_16 char(16), @cardKey_17 char(16), @cardKey_18 char(16), @cardKey_19 char(16), 
	@cardKey_20 char(16), @cardKey_21 char(16), @cardKey_22 char(16), @cardKey_23 char(16), 
	@cardKey_24 char(16), @cardKey_25 char(16), @cardKey_26 char(16), @cardKey_27 char(16), 
	@cardKey_28 char(16), @cardKey_29 char(16), @cardKey_30 char(16), @cardKey_31 char(16),
	@cardKey_32 char(16), @cardKey_33 char(16), @cardKey_34 char(16), @cardKey_35 char(16),
	@cardKey_36 char(16), @cardKey_37 char(16), @cardKey_38 char(16), @cardKey_39 char(16),
	@cardKey_40 char(16), @cardKey_41 char(16), @cardKey_42 char(16), @cardKey_43 char(16), 
	@cardKey_44 char(16), @cardKey_45 char(16), @cardKey_46 char(16), @cardKey_47 char(16),
	@cardKey_48 char(16)
)
AS
BEGIN
	BEGIN TRAN
	
	DECLARE @string varchar(20)
		
	UPDATE deckTbl
	SET cardKey_0 = @cardKey_0, cardKey_1 = @cardKey_1, cardKey_2 = @cardKey_2,
	cardKey_3 = @cardKey_3, cardKey_4 = @cardKey_4, cardKey_5 = @cardKey_5,
	cardKey_6 = @cardKey_6, cardKey_7 = @cardKey_7, cardKey_8 = @cardKey_8,
	cardKey_9 = @cardKey_9, cardKey_10 = @cardKey_10, cardKey_11 = @cardKey_11,
	cardKey_12 = @cardKey_12, cardKey_13 = @cardKey_13, cardKey_14 = @cardKey_14,
	cardKey_15 = @cardKey_15, cardKey_16 = @cardKey_16, cardKey_17 = @cardKey_17,
	cardKey_18 = @cardKey_18, cardKey_19 = @cardKey_19, cardKey_20 = @cardKey_20,
	cardKey_21 = @cardKey_21, cardKey_22 = @cardKey_22, cardKey_23 = @cardKey_23,
	cardKey_24 = @cardKey_24, cardKey_25 = @cardKey_25, cardKey_26 = @cardKey_26,
	cardKey_27 = @cardKey_27, cardKey_28 = @cardKey_28, cardKey_29 = @cardKey_29,
	cardKey_30 = @cardKey_30, cardKey_31 = @cardKey_31, cardKey_32 = @cardKey_32,
	cardKey_33 = @cardKey_33, cardKey_34 = @cardKey_34, cardKey_35 = @cardKey_35,
	cardKey_36 = @cardKey_36, cardKey_37 = @cardKey_37, cardKey_38 = @cardKey_38,
	cardKey_39 = @cardKey_39, cardKey_40 = @cardKey_40, cardKey_41 = @cardKey_41,
	cardKey_42 = @cardKey_42, cardKey_43 = @cardKey_43, cardKey_44 = @cardKey_44,
	cardKey_45 = @cardKey_45, cardKey_46 = @cardKey_46, cardKey_47 = @cardKey_47,
	cardKey_48 = @cardKey_48	
	WHERE userKey = @userKey AND deckNum = @deckNum
	
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRAN
		SET @string = 'false'
	END
	ELSE
	BEGIN
		COMMIT TRAN
		SET @string = 'success'
	END
	
	SELECT @string AS RESULT
END
GO
