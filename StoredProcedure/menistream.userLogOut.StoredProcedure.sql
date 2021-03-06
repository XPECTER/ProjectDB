USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userLogOut]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userLogOut](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
	
	IF (SELECT TOP 1 userLogOutTime FROM logInOutLogTbl WHERE userKey = @userKey
		ORDER BY userLogInTime DESC) is null
	BEGIN
		UPDATE logInOutLogTbl
		SET userLogOutTime = GETDATE()
		WHERE userKey = @userKey
			AND userLogInTime = (SELECT TOP 1 userLogInTime FROM logInOutLogTbl 
				WHERE userKey = @userKey ORDER BY userLogInTime DESC)
	END
	
	IF @@ERROR > 0 
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
