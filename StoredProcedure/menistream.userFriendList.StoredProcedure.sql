USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userFriendList]    Script Date: 04/05/2015 10:54:28 ******/
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
