USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[ticketList]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[ticketList]
AS BEGIN
	SELECT ticketDefineKey, ticketName, ticketDescription, ticketIcon FROM ticketDefineTbl
END

--EXEC ticketList
GO
