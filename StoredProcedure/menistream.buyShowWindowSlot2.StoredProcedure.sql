USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[buyShowWindowSlot2]    Script Date: 04/05/2015 10:54:23 ******/
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
