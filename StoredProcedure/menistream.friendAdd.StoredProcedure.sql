USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[friendAdd]    Script Date: 04/05/2015 10:54:25 ******/
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
