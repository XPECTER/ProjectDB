USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDeckRename]    Script Date: 04/05/2015 10:54:27 ******/
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
