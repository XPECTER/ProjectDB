USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[buyMaxCardInventory]    Script Date: 04/05/2015 10:54:23 ******/
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
