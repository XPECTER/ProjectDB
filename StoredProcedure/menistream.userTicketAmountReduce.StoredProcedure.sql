USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[userTicketAmountReduce]    Script Date: 04/05/2015 10:54:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[userTicketAmountReduce](
	@userKey char(10),
	@ticketDefineKey char(5)
)
AS BEGIN
	BEGIN TRAN
	
	UPDATE itemTbl
	SET itemAmount -= 1
	WHERE userKey = @userKey AND itemDefineKey = @ticketDefineKey
	
	IF @@ERROR > 0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN 
END
GO
