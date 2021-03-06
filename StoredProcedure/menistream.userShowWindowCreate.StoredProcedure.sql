USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userShowWindowCreate]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userShowWindowCreate](
	@userKey char(10)
)
AS BEGIN
	BEGIN TRAN
		INSERT INTO showWindowTbl
		VALUES (@userKey, 1, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 2, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 3, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 4, '_', '_', '_', '_', '_', '_', NULL),
		(@userKey, 5, '_', '_', '_', '_', '_', '_', NULL)
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
GO
