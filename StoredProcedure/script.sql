USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[zoneList_Kr]    Script Date: 04/05/2015 10:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[zoneList_Kr]
AS BEGIN
	SELECT * FROM zoneDefineTbl_Kr
END
GO
/****** Object:  StoredProcedure [menistream].[userLevelInformation]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLevelInformation]
AS BEGIN
	SELECT *
	FROM userLevelDefineTbl
END
GO
/****** Object:  StoredProcedure [menistream].[versionCheck]    Script Date: 04/05/2015 10:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[versionCheck]
AS BEGIN
	SELECT TOP 1 versionNum, cardInfoVersion, cardSkillInfoVersion, dungeonInfoVersion, zoneInfoVersion, storeInfoVersion, missionInfoVersion, itemInfoVersion
	FROM versionTbl
	ORDER BY versionUpdateTime DESC
END

--EXEC versionCheck
GO
/****** Object:  StoredProcedure [menistream].[userTicketAmountReduce]    Script Date: 04/05/2015 10:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userTicketAmountReduce](
	@userKey char(10),
	@ticketDefineKey char(5)
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE itemTbl
	SET itemAmount -= 1
	WHERE userKey = @userKey AND itemDefineKey = @ticketDefineKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN 
END
GO
/****** Object:  StoredProcedure [menistream].[userJackpotRecordUpdate]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userJackpotRecordUpdate](
	@userKey int,
	@battleFlag tinyint,
	@defenceFlag tinyint,
	@people tinyint
)
AS BEGIN
	BEGIN TRAN
	
	IF @people = 0
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloJackpotDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloJackpotWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloJackpotDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloJackpotDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	ELSE
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleJackpotDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleJackpotWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleJackpotDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleJackpotDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userItemList]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userItemList](
	@userKey char(10)
	)
	AS BEGIN
		SELECT itemDefineKey, itemAmount FROM itemTbl WHERE userKey = @userKey
	END
GO
/****** Object:  StoredProcedure [menistream].[userCardList]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[userCardList](
	@userKey char(10)
)
AS BEGIN
	SELECT cardKey, cardDefineKey, cardLevel, cardUpgrade, cardState, tradeKey, tradeState, cardExp 
	FROM cardTbl
	WHERE userKey = @userKey
	ORDER BY cardDefineKey ASC
END
GO
/****** Object:  StoredProcedure [menistream].[userCardInfoTest]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userCardInfoTest](
	@userKey char(10)
)
AS BEGIN
	DECLARE @string varchar(MAX)
	
	SET @string = 
	(SELECT * 
	FROM cardTbl INNER JOIN cardDefineTbl_Kr
	ON userKey = @userKey AND cardTbl.cardDefineKey = cardDefineTbl_Kr.cardDefineKey
	FOR XML RAW('cardTbl'), ELEMENTS)
	
	SELECT @string AS DBXML
END
GO
/****** Object:  StoredProcedure [menistream].[useRaidCostRecoveryPotion]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[useRaidCostRecoveryPotion](
	@userKey int
)
AS
BEGIN
	BEGIN TRAN
	
	IF NOT EXISTS (SELECT userKey, itemDefineKey FROM itemTbl WHERE userKey = @userKey AND itemDefineKey = 1001)
		ROLLBACK TRAN
	ELSE
	BEGIN
		UPDATE userGameTbl
		SET userGameTbl.raidCost = userGameTbl.maxRaidCost,	userGameTbl.updateRaidCosttime = GETDATE()
		WHERE userKey = @userKey
		
		UPDATE itemTbl
		SET itemAmount -= 1
		WHERE userKey = @userKey AND itemDefineKey = 1001
	END
	
	IF @@ERROR > 0
		ROlLBACK TRAN
	ELSE
		COMMIT TRAN	
END
GO
/****** Object:  StoredProcedure [menistream].[useDungeonCostRecoveryPotion]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[useDungeonCostRecoveryPotion](
	@userKey int
)
AS
BEGIN
	BEGIN TRAN
	
	UPDATE userGameTbl
	SET userGameTbl.dungeonCost = userGameTbl.maxDungeonCost,
	userGameTbl.updateDungeonCostTime = GETDATE()
	WHERE userGameTbl.userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[tutorialDeckCreate]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[tutorialDeckCreate](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN		
	DECLARE @string varchar(20)	
		
	INSERT INTO cardTbl
	VALUES (@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 10101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 20101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 30101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 40101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 50101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 60101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 70101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 80101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 90101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 100101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 110101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 120101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 130101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 140101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 150101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 160101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 170101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 180101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 190101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 200101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 210101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 220101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 230101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 240101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 250101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 260101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 270101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 280101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 290101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 300101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 310101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 320101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 330101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 340101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 350101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 360101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 370101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 380101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 390101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 400101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 410101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 420101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 430101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 440101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 450101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 460101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 470101, 1, 1, 0, '_', '_', 0),
	(@userKey, SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 16), 480101, 1, 1, 0, '_', '_', 0)
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[ticketList]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[ticketList]
AS BEGIN
	SELECT ticketDefineKey, ticketName, ticketDescription, ticketIcon FROM ticketDefineTbl
END

--EXEC ticketList
GO
/****** Object:  StoredProcedure [menistream].[deckInformation_Kr]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[deckInformation_Kr](
	@userKey char(10)
)
AS BEGIN
	SELECT *
	FROM deckTbl
	WHERE userKey = @userKey
	ORDER BY deckNum
END
GO
/****** Object:  StoredProcedure [menistream].[cardSkillInformation_Kr]    Script Date: 04/05/2015 10:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[cardSkillInformation_Kr](
	@cardSkillDefineKey char(5)
)
AS BEGIN
	SELECT * 
	FROM cardSkillDefineTbl_Kr
	WHERE cardSkillDefineKey = @cardSkillDefineKey
END
GO
/****** Object:  StoredProcedure [menistream].[cardDefineList_Kr]    Script Date: 04/05/2015 10:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[cardDefineList_Kr]
AS BEGIN
SELECT * FROM cardDefineTbl_Kr
END
GO
/****** Object:  StoredProcedure [menistream].[cardDefineInformation_Kr]    Script Date: 04/05/2015 10:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[cardDefineInformation_Kr](
	@cardDefineKey varchar(20)
)
AS BEGIN
	SELECT * FROM cardDefineTbl_Kr WHERE cardDefineKey = @cardDefineKey
END
GO
/****** Object:  StoredProcedure [menistream].[caculateSellCard]    Script Date: 04/05/2015 10:56:27 ******/
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
/****** Object:  StoredProcedure [menistream].[buyUserCash]    Script Date: 04/05/2015 10:56:27 ******/
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
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot6]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot6](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_6 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot5]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot5](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_5 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot4]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot4](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_4 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot3]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot3](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_3 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot2]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot2](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_2 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot1]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyShowWindowSlot1](
	@userKey char(10),
	@showWindowNum tinyint
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE showWindowTbl
	SET cardDefineKey_1 = '_'
	WHERE userKey = @userKey AND showWindowNum = @showWindowNum
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowCard]    Script Date: 04/05/2015 10:56:26 ******/
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
/****** Object:  StoredProcedure [menistream].[buyMaxCardInventory]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyMaxCardInventory](
	@userKey int
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE userPropertyTbl
	SET maxCardInventory = maxCardInventory + 5
	WHERE userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[buyItem]    Script Date: 04/05/2015 10:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[buyItem](
	@userKey int,
	@itemDefineKey int,
	@itemAmount smallint
)
AS BEGIN
	BEGIN TRAN
	
	IF EXISTS (SELECT userKey, itemDefineKey FROM itemTbl WHERE userKey = @userKey AND itemDefineKey = @itemDefineKey)
		UPDATE itemTbl
		SET itemAmount += @itemAmount
		WHERE userKey = @userKey AND itemDefineKey = @itemDefineKey
	ELSE
		INSERT INTO itemTbl
		VALUES (@userKey, @itemDefineKey, @itemAmount)
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[missionList_Kr]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[missionList_Kr]
AS BEGIN
	SELECT * FROM missionDefineTbl_Kr
END
GO
/****** Object:  StoredProcedure [menistream].[dungeonList_Kr]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[dungeonList_Kr]
AS BEGIN
	SELECT * FROM dungeonDefineTbl_Kr
	ORDER BY zoneDefineKey, dungeonDefineKey
END
GO
/****** Object:  StoredProcedure [menistream].[itemAmountCheck]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[itemAmountCheck](
	@userKey char(10),
	@itemDefineKey varchar(6)
)
AS BEGIN
	DECLARE @result varchar(10)

	IF (SELECT itemAmount FROM itemTbl WHERE userKey = @userKey AND itemDefineKey = @itemDefineKey) = 0
	BEGIN
		SET @result = 'false'
		SELECT @result AS RESULT
	END
	ELSE
	BEGIN
		SET @result = 'success'
		SELECT @result AS RESULT
	END
END
GO
/****** Object:  StoredProcedure [menistream].[insertShowWindow]    Script Date: 04/05/2015 10:56:29 ******/
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
/****** Object:  StoredProcedure [menistream].[idDuplicationCheck]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[idDuplicationCheck](
	@userId varchar(100)
)
AS BEGIN
	DECLARE @result varchar(10)
		
	IF (SELECT userId FROM userTbl WHERE userId = @userId) is null
		SET @result = 'success'
	ELSE
		SET @result = 'false'
		
	SELECT @result AS result
END
GO
/****** Object:  StoredProcedure [menistream].[dungeonClear]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[dungeonClear](
	@userKey char(10),
	@zoneDefineKey char(5),
	@dungeonDefineKey char(5),
	@clearRank tinyint,
	@clearTime varchar(10)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(20)
	
	SET @clearTime = CAST(@clearTime as time(0))
	
	IF EXISTS (SELECT userKey, dungeonDefineKey FROM dungeonClearLogTbl 
		WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey)
		UPDATE dungeonClearLogTbl
		SET dungeonClearLogTbl.clearRank = @clearRank, dungeonClearLogTbl.clearTime = @clearTime
		WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey
	ELSE
		INSERT INTO dungeonClearLogTbl
		VALUES (@userKey, @zoneDefineKey, @dungeonDefineKey, @clearRank, @clearTime)
	
	UPDATE userRecordTbl
	SET dungeonWin += 1
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
	
	SELECT @result AS result	
END
GO
/****** Object:  StoredProcedure [menistream].[defenceDeckSet]    Script Date: 04/05/2015 10:56:28 ******/
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
/****** Object:  StoredProcedure [menistream].[createCard]    Script Date: 04/05/2015 10:56:27 ******/
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
/****** Object:  StoredProcedure [menistream].[challengeDeckRegister]    Script Date: 04/05/2015 10:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[challengeDeckRegister](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
		DECLARE @result AS varchar(10)
	
		IF EXISTS (SELECT userKey FROM currentChallengeRankTbl WHERE userKey = @userKey)
			SET @result = 'false'			
		ELSE BEGIN
			INSERT INTO currentChallengeRankTbl
			VALUES (@userKey, (SELECT userNickname FROM userTbl WHERE userKey = @userKey), 0, 0, '_', '_', '0')
			
			SET @result = 'success'
		END
		
	IF @@ERROR > 0 
	BEGIN
		ROLLBACK TRAN
		SELECT @result AS RESULT
	END
	ELSE BEGIN
		COMMIT TRAN
		SELECT @result AS RESULT
	END
END
GO
/****** Object:  StoredProcedure [menistream].[dungeonDefeat]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [menistream].[dungeonDefeat](
	@userKey char(10),
	@zoneDefineKey char(5),
	@dungeonDefineKey char(5)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @string varchar(20)
		
	UPDATE userRecordTbl
	SET dungeonDefeat += 1
	WHERE userKey = @userKey
	
	IF NOT EXISTS (SELECT userKey, dungeonDefineKey 
	FROM dungeonClearLogTbl
	WHERE userKey = @userKey AND dungeonDefineKey = @dungeonDefineKey AND zoneDefineKey = @zoneDefineKey)
		INSERT INTO dungeonClearLogTbl
		VALUES (@userKey, @zoneDefineKey, @dungeonDefineKey, 0, null)
			
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
/****** Object:  StoredProcedure [menistream].[dungeonCostSpent]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[dungeonCostSpent](
	@userKey char(10),
	@dungeonCost tinyint
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(10)
	
	IF (SELECT dungeonCost FROM userGameTbl WHERE userKey = @userKey) < @dungeonCost
	BEGIN
		SET @result = 'false'
	END
	ELSE
	BEGIN
		IF (SELECT dungeonCost FROM userGameTbl WHERE userKey = @userKey) = 
			(SELECT maxDungeonCost FROM userGameTbl WHERE userKey = @userKey)
		BEGIN
			UPDATE userGameTbl
			SET dungeonCost -= @dungeonCost, updateDungeonCostTime = GETDATE()
			WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			UPDATE userGameTbl
			SET dungeonCost -= @dungeonCost
			WHERE userKey = @userKey
		END
	END
	
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
/****** Object:  StoredProcedure [menistream].[cardInformation_Kr]    Script Date: 04/05/2015 10:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[cardInformation_Kr](
		@cardKey char(16)
)
AS BEGIN
	-- 리더 카드 정보
	IF(SELECT jobType FROM cardDefineTbl_Kr WHERE cardDefineKey = 
	(SELECT cardDefineKey FROM cardTbl WHERE cardKey = @cardKey)) IS NULL
	BEGIN
		SELECT @cardKey AS cardKey, cardDefineTbl_Kr.* FROM cardDefineTbl_Kr WHERE cardDefineKey = 
		(SELECT cardDefineKey FROM cardTbl WHERE cardKey = @cardKey)
	END
	ELSE
	BEGIN
		-- 그 외 카드 정보
		SELECT @cardKey AS cardKey, cardDefineTbl_Kr.*
		FROM cardDefineTbl_Kr 
		cross join jobDefineTbl_Kr 
		WHERE cardDefineTbl_Kr.cardDefineKey = 
			(SELECT c.cardDefineKey 
			FROM cardTbl c 				
			WHERE cardKey = @cardKey) 
			AND cardDefineTbl_Kr.jobType = jobDefineTbl_Kr.jobType
	END
END
GO
/****** Object:  StoredProcedure [menistream].[friendDelete]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[friendDelete](
	@userKey char(10),
	@friendUserKey char(10)
)
AS
BEGIN
	BEGIN TRAN
	
	DELETE FROM friendListTbl
	WHERE userKey = @userKey AND friendUserKey = @friendUserKey
	
	UPDATE userPropertyTbl
	SET currentFriend -= 1
	WHERE userKey = @userKey
	
	DELETE FROM friendListTbl
	WHERE userKey = @friendUserKey AND friendUserKey = @userKey	
	
	UPDATE userPropertyTbl
	SET currentFriend -= 1
	WHERE userKey = @friendUserKey
	
	UPDATE userGameTbl
	SET friendDeleteState = 1
	WHERE userKey = @userKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[friendAdd]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[friendAdd](
	@userKey char(10),
	@friendUserKey char(10)
)
AS BEGIN
	BEGIN TRAN
	
	INSERT INTO userFriendListTbl
	VALUES (@userKey, @friendUserKey, 
	(SELECT userNickname FROM userTbl WHERE userKey = @friendUserKey),
	(SELECT userProfileCardDefineKey FROM userTbl WHERE userKey = @friendUserKey), 0, 0, 0)
	
	INSERT INTO userFriendListTbl
	VALUES (@friendUserKey, @userKey,
	(SELECT userNickname FROM userTbl WHERE userKey = @userKey),
	(SELECT userProfileCardDefineKey FROM userTbl WHERE userKey = @friendUserKey), 0 ,0, 0)
		
	IF @@ERROR > 0
		ROllBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[showWindowShuffle]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[showWindowShuffle](	
	@jobType smallint,
	@element smallint,
	@rarity smallint,
	@season smallint,
	@randomNum int
)
AS BEGIN
	DECLARE @minJobType tinyint, @maxJobType tinyint
	DECLARE @minElement tinyint, @maxElement tinyint
	DECLARE @minRarity tinyint, @maxRarity tinyint
	DECLARE @minSeason tinyint, @maxSeason tinyint
	
	IF @jobType = -1
	BEGIN
		SET @minJobType = 0
		SET @maxJobType = (SELECT COUNT(jobType) FROM jobDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minJobType = @jobType
		SET @maxJobType = @jobType
	END
	
	IF @element = -1
	BEGIN
		SET @minElement = 0
		SET @maxElement = (SELECT MAX(element) FROM cardDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minElement = @element
		SET @maxElement = @element
	END
	
	IF @rarity = -1
	BEGIN
		SET @minRarity = 0
		SET @maxRarity = (SELECT COUNT(rarity) FROM cardCombinationDefineTbl)
	END
	ELSE
	BEGIN
		SET @minRarity = @rarity
		SET @maxRarity = @rarity
	END
	
	IF @season = -1
	BEGIN
		SET @minSeason = 0
		SET @maxSeason = (SELECT MAX(season) FROM cardDefineTbl_Kr)
	END
	ELSE
	BEGIN
		SET @minSeason = @season
		SET @maxSeason = @season
	END
	
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '#gachaTbl')
		DROP TABLE #gachaTbl
	
	CREATE TABLE #gachaTbl(
		gachaNum int IDENTITY(0, 1),
		cardDefineKey varchar(20)
	)
	
	INSERT INTO #gachaTbl(cardDefineKey)
	SELECT cardDefineKey FROM cardDefineTbl_Kr
	WHERE cardLevel = 1 AND cardUpgrade = 0 AND jobType BETWEEN @minJobType AND @maxJobType
	AND element BETWEEN @minElement AND @maxElement
	AND season BETWEEN @minSeason AND @maxSeason
	AND rarity BETWEEN @minRarity AND @maxRarity 
	
	SELECT cardDefineKey FROM #gachaTbl WHERE gachaNum = @randomNum
END
GO
/****** Object:  StoredProcedure [menistream].[sellCard]    Script Date: 04/05/2015 10:56:29 ******/
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
/****** Object:  StoredProcedure [menistream].[selectDungeonRankTop10]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[selectDungeonRankTop10](
	@zoneDefineKey char(6),
	@dungeonDefineKey char(5)
)
AS BEGIN
BEGIN TRAN
	CREATE TABLE #tempDungeonRankTop10Tbl(
		ranking int identity(1, 1),
		userKey char(10),
		userLevel smallint,
		userProfileCardDefineKey varchar(16),
		userScore int,
		clearTime time(0)
	)
	
	INSERT INTO #tempDungeonRankTop10Tbl
	SELECT userKey,(SELECT userLevel FROM userTbl WHERE userTbl.userKey = dungeonRankTbl.userKey) AS userLevel, 
	userProfileCardDefineKey, userScore, clearTime 
	FROM dungeonRankTbl
	WHERE zoneDefineKey = @zoneDefineKey AND dungeonDefineKey = @dungeonDefineKey
	ORDER BY userScore DESC, clearTime ASC
	
	SELECT TOP 10 * FROM #tempDungeonRankTop10Tbl
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		DROP TABLE #tempDungeonRankTop10Tbl
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[selectDungeonRank]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--INSERT INTO dungeonRankTbl
--VALUES ('E3F55920C8', '_', 'ZN0101', 'DG002', 19283, '05:10:22')

--SELECT * FROM dungeonRankTbl

CREATE PROC [menistream].[selectDungeonRank](
	@userKey char(10),
	@zoneDefineKey char(6),
	@dungeonDefineKey char(5)
)
AS BEGIN
BEGIN TRAN
	CREATE TABLE #tempDungeonRankTbl(
		ranking int identity(1, 1),
		userKey char(10),
		userLevel smallint,
		userProfileCardDefineKey varchar(16),
		userScore int,
		clearTime time(0)
	)
	
	INSERT INTO #tempDungeonRankTbl
	SELECT userKey,(SELECT userLevel FROM userTbl WHERE userKey = @userKey) AS userLevel, 
	userProfileCardDefineKey, userScore, clearTime 
	FROM dungeonRankTbl
	WHERE zoneDefineKey = @zoneDefineKey AND dungeonDefineKey = @dungeonDefineKey
	ORDER BY userScore DESC
		
	SELECT * FROM #tempDungeonRankTbl WHERE ranking BETWEEN (SELECT ranking FROM #tempDungeonRankTbl WHERE userKey = @userKey)-5 AND
	(SELECT ranking FROM #tempDungeonRankTbl WHERE userKey = @userKey)+5 
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		DROP TABLE #tempDungeonRankTbl
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[selectCardSkillDefineList_Kr]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[selectCardSkillDefineList_Kr]
AS BEGIN
	SELECT * FROM cardSkillDefineTbl_Kr
END
GO
/****** Object:  StoredProcedure [menistream].[raidAttack]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[raidAttack](
	@raidKey char(10),
	@userKey char(10),
	@targetDamage int
)
AS BEGIN
	DECLARE @raidHealthPoint AS int
	SET @raidHealthPoint = 
	(SELECT raidHealthPoint FROM raidOnProgressTbl WHERE raidKey = @raidKey)

	IF @raidHealthPoint = 0
		RETURN

	IF @targetDamage > @raidHealthPoint
	BEGIN
		UPDATE raidOnProgressTbl
		SET raidHealthPoint = 0
		WHERE raidKey = @raidKey
	
		INSERT INTO raidRecordTbl 
		VALUES (@raidKey, @userKey, @raidHealthPoint, GETDATE())
	END
	ELSE
	BEGIN
		UPDATE raidOnProgressTbl
		SET raidHealthPoint -= @targetDamage
		WHERE raidKey = @raidKey
	
		INSERT INTO raidRecordTbl 
		VALUES (@raidKey, @userKey, @targetDamage, GETDATE())
	END	
END
GO
/****** Object:  StoredProcedure [menistream].[raidAppear]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[raidAppear](
	@raidDefineKey char(5),
	@discoverUserKey char(10)
)
AS BEGIN
BEGIN TRAN	
	DECLARE @raidKey AS char(10)
	SET @raidKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 10)
	
	DECLARE @discoverUserNickname AS varchar(20)
	SET @discoverUserNickname = (SELECT userNickname FROM userTbl
	WHERE userKey = @discoverUserKey)
	
	DECLARE @raidHealthPoint AS int
	SET @raidHealthPoint = (SELECT raidHealthPoint FROM raidDefineTbl_Kr
	WHERE raidDefineKey = @raidDefineKey)
	
	DECLARE @extinctionTime AS smalldatetime
	SET @extinctionTime = GETDATE() +
	(SELECT duelLimitTime FROM raidDefineTbl_Kr WHERE raidDefineKey = @raidDefineKey)
	
	INSERT INTO raidOnProgressTbl
	VALUES (@raidKey, @raidDefineKey, @discoverUserKey, @discoverUserNickname,
		@raidHealthPoint, @raidHealthPoint, GETDATE(), @extinctionTime)
	
IF @@ERROR > 0
	ROLLBACK TRAN
ELSE
	COMMIT TRAN	
END
GO
/****** Object:  StoredProcedure [menistream].[nicknameDuplicationCheck]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[nicknameDuplicationCheck](
	@userNickname varchar(20)
)
AS BEGIN
	DECLARE @result varchar(10)
	
	IF (SELECT userNickname FROM userTbl WHERE userNickname = @userNickname) is null
		SET @result = 'success'
	ELSE
		SET @result = 'false'
		
	SELECT @result AS result
END
GO
/****** Object:  StoredProcedure [menistream].[monsterDeckInformation]    Script Date: 04/05/2015 10:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[monsterDeckInformation]
AS BEGIN
	SELECT *
	FROM monsterDeckDefineTbl
END
GO
/****** Object:  StoredProcedure [menistream].[userFriendList]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userFriendList](
	@userKey char(10)
)
AS BEGIN
	SELECT friendUserKey, friendUserNickname, friendUserProfileCardKey
	FROM userFriendListTbl
	WHERE userKey = @userKey
END
GO
/****** Object:  StoredProcedure [menistream].[userDungeonRecordUpdate]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userDungeonRecordUpdate](
	@userKey int,
	@battleFlag tinyint,
	@people tinyint	
)
AS BEGIN
	BEGIN TRAN
	
	IF @people = 0
		IF @battleFlag = 0
			UPDATE userRecordTbl
			SET	soloDungeonDefeat += 1
			WHERE userKey = @userKey
		ELSE
			UPDATE userRecordTbl
			SET soloDungeonWin += 1
			WHERE userKey = @userKey
	ELSE
		IF @battleFlag = 0
			UPDATE userRecordTbl
			SET	coupleDungeonDefeat += 1
			WHERE userKey = @userKey
		ELSE
			UPDATE userRecordTbl
			SET coupleDungeonWin += 1
			WHERE userKey = @userKey
		
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userDelete]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userDelete](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN	
		
	-- userRecordTbl 레코드 삭제
	DELETE FROM userRecordTbl
	WHERE userKey = @userKey
	
	-- userGameTbl 레코드 삭제
	DELETE FROM userGameTbl
	WHERE userKey = @userKey
	
	-- userPropertyTbl 레코드 삭제
	DELETE FROM userPropertyTbl
	WHERE userKey = @userKey
	
	-- deckTbl 레코드 삭제
	DELETE FROM deckTbl
	WHERE userKey = @userKey
	
	-- userTbl 레코드 삭제
	DELETE FROM userTbl
	WHERE userKey = @userKey
	
	-- cardTbl 레코드 삭제
	DELETE FROM cardTbl
	WHERE userKey = @userKey
	
	-- deleteUserTbl에 레코드 생성. 같은 아이디로는 아이디 재생성 안 됨
	/*
	INSERT INTO deleteUserTbl
	VALUES (@userId, @userPassword)
	*/
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userDeckSetting]    Script Date: 04/05/2015 10:56:31 ******/
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
/****** Object:  StoredProcedure [menistream].[userDeckReset]    Script Date: 04/05/2015 10:56:30 ******/
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
/****** Object:  StoredProcedure [menistream].[userDeckRename]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userDeckRename](
	@userKey int,
	@deckNum tinyint,
	@deckName varchar(30)
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE deckTbl
	SET deckName = @deckName
	WHERE userKey = @userKey AND deckNum = @deckNum
	
	IF @@ERROR > 0 
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userSparringRecordUpdate]    Script Date: 04/05/2015 10:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userSparringRecordUpdate](
	@userKey int,
	@battleFlag tinyint,
	@defenceFlag tinyint,
	@people tinyint
)
AS BEGIN
	BEGIN TRAN
	
	IF @people = 0
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloSparringDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloSparringWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET soloSparringDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET soloSparringDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	ELSE
	BEGIN
		IF @defenceFlag = 0
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleSparringDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleSparringWin += 1
				WHERE userKey = @userKey
		END
		ELSE
		BEGIN
			IF @battleFlag = 0
				UPDATE userRecordTbl
				SET coupleSparringDefenceDefeat += 1
				WHERE userKey = @userKey
			ELSE
				UPDATE userRecordTbl
				SET coupleSparringDefenceWin += 1
				WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userShowWindowCreate]    Script Date: 04/05/2015 10:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userShowWindowCreate](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
		INSERT INTO showWindowTbl
		VALUES (@userKey, 1, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 2, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 3, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 4, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 5, '_', '_', '_', '_', '_', '_', NULL)
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userNicknameDuplicationCheck]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userNicknameDuplicationCheck](
	@userNickname varchar(30)
)
AS BEGIN
	DECLARE @result varchar(10)
	
	IF EXISTS (SELECT userNickname FROM userTbl WHERE userNickname = @userNickname)
		SET @result = 'false'
	ELSE
		SET @result = 'true'
	
	SELECT @result AS RESULT
END
GO
/****** Object:  StoredProcedure [menistream].[userLogOut]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLogOut](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
	
	IF (SELECT TOP 1 userLogOutTime FROM logInOutLogTbl WHERE userKey = @userKey
		ORDER BY userLogInTime DESC) is null
	BEGIN
		UPDATE logInOutLogTbl
		SET userLogOutTime = GETDATE()
		WHERE userKey = @userKey
			AND userLogInTime = (SELECT TOP 1 userLogInTime FROM logInOutLogTbl 
				WHERE userKey = @userKey ORDER BY userLogInTime DESC)
	END
	
	IF @@ERROR > 0 
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userLogIn]    Script Date: 04/05/2015 10:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLogIn](
	@userId varchar(50),
	@userPassword varchar(20)
)
AS BEGIN
	BEGIN TRAN
	
	DECLARE @result varchar(10), @userKey char(10)
		
	IF (SELECT userId FROM userTbl WHERE userId = @userId) IS NULL
	BEGIN	
		SET @result = 'false'
		SELECT @result AS RESULE
	END
	ELSE
	BEGIN
		IF (SELECT userPassword FROM userTbl WHERE userId = @userId AND userPassword = @userPassword) is NULL 
		BEGIN
			SET @result = 'false'
			SELECT @result AS RESULT
		END
		ELSE
		BEGIN
			SET @userKey = (SELECT userKey FROM userTbl WHERE userId = @userId)
			SET @result = 'success'
			
			INSERT INTO logInOutLogTbl
			VALUES (@userKey, GETDATE(), NULL, NULL, NULL)
			
			SELECT @result AS RESULT, lobbyView.* FROM lobbyView WHERE userKey = @userKey
		END
	END
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
/****** Object:  StoredProcedure [menistream].[userDeckCreate]    Script Date: 04/05/2015 10:56:30 ******/
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
/****** Object:  StoredProcedure [menistream].[userCreate]    Script Date: 04/05/2015 10:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userCreate](
	@userId varchar(50),
	@userPassword varchar(30),
	@userNickname varchar(20)	
)
AS BEGIN 
	BEGIN TRAN
	
	DECLARE @userKey AS char(10)
	SET @userKey = SUBSTRING(REPLACE(NEWID(), '-', ''), 1, 10)
	
	-- userTblCreate
	INSERT INTO userTbl
	VALUES (@userKey, @userId, @userPassword, @userNickname, '0', NULL, NULL, 1, 0, '_', 0)
		
	-- userPropertyTblCreate
	INSERT INTO userPropertyTbl
	VALUES (@userKey, 0, 0, (SELECT maxCardInventory FROM worldValueTbl), 1)
	
	-- userGameTblCreate
	INSERT INTO userGameTbl
	VALUES (@userKey, '_', 50, GETDATE(), 50, 50, GETDATE(), 50, 0, 0, '_', '_')
	
	-- userRecordTblCreate
	INSERT INTO userRecordTbl
	VALUES (@userKey, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	
	-- 앞의 @userKey는 userDeckCreate의 변수명, 뒤의 @userKey는 현재 프로시저에서 선언한 변수
	EXEC userDeckCreate @userKey = @userKey
	
	-- 앞의 @userKey는 userDeckCreate의 변수명, 뒤의 @userKey는 프로시저 변수명
	EXEC userShowWindowCreate @userKey = @userKey
	
	IF @@ERROR > 0
	BEGIN
		ROLLBACK TRAN
		SET @userKey = 'false'
		SELECT @userKey AS userKey
	END
	ELSE
	BEGIN
		COMMIT TRAN
		SELECT @userKey AS userKey
	END
END
GO
/****** Object:  StoredProcedure [menistream].[duplicationCheck]    Script Date: 04/05/2015 10:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[duplicationCheck](
	@userId varchar(100),
	@userPassword varchar(100),
	@userNickname varchar(30)
)
AS BEGIN
	DECLARE @string varchar(10)

	IF EXISTS (SELECT userId FROM userTbl WHERE userId = @userId)
		SET @string = 'false'
	ELSE IF NOT EXISTS (SELECT userId FROM userTbl WHERE userId = @userId)
	BEGIN
		EXEC userCreate @userId = @userId, @userPassword = @userPassword, @userNickname = @userNickname
		SET @string = 'success'
	END
	
	SELECT @string AS RESULT
END
GO
