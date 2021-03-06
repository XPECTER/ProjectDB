USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userDelete]    Script Date: 04/05/2015 10:54:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[userDelete](
	@userKey char(10)
)
AS BEGIN		
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
	INSERT INTO deleteUserTbl
	VALUES (@userId, @userPassword)
END
GO
