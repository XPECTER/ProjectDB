USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[tutorialDeckCreate]    Script Date: 04/05/2015 10:54:26 ******/
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
