USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[friendDelete]    Script Date: 04/05/2015 10:54:25 ******/
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
