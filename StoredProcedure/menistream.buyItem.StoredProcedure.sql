USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[buyItem]    Script Date: 04/05/2015 10:54:23 ******/
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
