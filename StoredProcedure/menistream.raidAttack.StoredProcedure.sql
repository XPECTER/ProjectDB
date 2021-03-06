USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[raidAttack]    Script Date: 04/05/2015 10:54:26 ******/
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
