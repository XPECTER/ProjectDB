USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[defenceDeckSet]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[defenceDeckSet](
	@userKey char(10), @cardDefineKey_0 varchar(16), 
	@cardDefineKey_1 varchar(16), @cardDefineKey_2 varchar(16),
	@cardDefineKey_3 varchar(16), @cardDefineKey_4 varchar(16),
	@cardDefineKey_5 varchar(16), @cardDefineKey_6 varchar(16),
	@cardDefineKey_7 varchar(16), @cardDefineKey_8 varchar(16),
	@cardDefineKey_9 varchar(16), @cardDefineKey_10 varchar(16),
	@cardDefineKey_11 varchar(16), @cardDefineKey_12 varchar(16),
	@cardDefineKey_13 varchar(16), @cardDefineKey_14 varchar(16),
	@cardDefineKey_15 varchar(16), @cardDefineKey_16 varchar(16),
	@cardDefineKey_17 varchar(16), @cardDefineKey_18 varchar(16),
	@cardDefineKey_19 varchar(16), @cardDefineKey_20 varchar(16),
	@cardDefineKey_21 varchar(16), @cardDefineKey_22 varchar(16),
	@cardDefineKey_23 varchar(16), @cardDefineKey_24 varchar(16),
	@cardDefineKey_25 varchar(16), @cardDefineKey_26 varchar(16),
	@cardDefineKey_27 varchar(16), @cardDefineKey_28 varchar(16),
	@cardDefineKey_29 varchar(16), @cardDefineKey_30 varchar(16),
	@cardDefineKey_31 varchar(16), @cardDefineKey_32 varchar(16),
	@cardDefineKey_33 varchar(16), @cardDefineKey_34 varchar(16),
	@cardDefineKey_35 varchar(16), @cardDefineKey_36 varchar(16),
	@cardDefineKey_37 varchar(16), @cardDefineKey_38 varchar(16),
	@cardDefineKey_39 varchar(16), @cardDefineKey_40 varchar(16),
	@cardDefineKey_41 varchar(16), @cardDefineKey_42 varchar(16),
	@cardDefineKey_43 varchar(16), @cardDefineKey_44 varchar(16),
	@cardDefineKey_45 varchar(16), @cardDefineKey_46 varchar(16),
	@cardDefineKey_47 varchar(16), @cardDefineKey_48 varchar(16)
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE deckTbl
	SET cardKey_0 = @cardDefineKey_0, cardKey_1 = @cardDefineKey_1,
	cardKey_2 = @cardDefineKey_2, cardKey_3 = @cardDefineKey_3,
	cardKey_4 = @cardDefineKey_4, cardKey_5 = @cardDefineKey_5,
	cardKey_6 = @cardDefineKey_6, cardKey_7 = @cardDefineKey_7,
	cardKey_8 = @cardDefineKey_8, cardKey_9 = @cardDefineKey_9,
	cardKey_10 = @cardDefineKey_10, cardKey_11 = @cardDefineKey_11,
	cardKey_12 = @cardDefineKey_12, cardKey_13 = @cardDefineKey_13,
	cardKey_14 = @cardDefineKey_14, cardKey_15 = @cardDefineKey_15,
	cardKey_16 = @cardDefineKey_16, cardKey_17 = @cardDefineKey_17,
	cardKey_18 = @cardDefineKey_18, cardKey_19 = @cardDefineKey_19,
	cardKey_20 = @cardDefineKey_20, cardKey_21 = @cardDefineKey_21,
	cardKey_22 = @cardDefineKey_22, cardKey_23 = @cardDefineKey_23,
	cardKey_24 = @cardDefineKey_24, cardKey_25 = @cardDefineKey_25,
	cardKey_26 = @cardDefineKey_26, cardKey_27 = @cardDefineKey_27,
	cardKey_28 = @cardDefineKey_28, cardKey_29 = @cardDefineKey_29,
	cardKey_30 = @cardDefineKey_30, cardKey_31 = @cardDefineKey_31,
	cardKey_32 = @cardDefineKey_32, cardKey_33 = @cardDefineKey_33,
	cardKey_34 = @cardDefineKey_34, cardKey_35 = @cardDefineKey_35,
	cardKey_36 = @cardDefineKey_36, cardKey_37 = @cardDefineKey_37,
	cardKey_38 = @cardDefineKey_38, cardKey_39 = @cardDefineKey_39,
	cardKey_40 = @cardDefineKey_40, cardKey_41 = @cardDefineKey_41,
	cardKey_42 = @cardDefineKey_42, cardKey_43 = @cardDefineKey_43,
	cardKey_44 = @cardDefineKey_44, cardKey_45 = @cardDefineKey_45,
	cardKey_46 = @cardDefineKey_46, cardKey_47 = @cardDefineKey_47,
	cardKey_48 = @cardDefineKey_48	
	WHERE userKey = @userKey
	
END
GO
