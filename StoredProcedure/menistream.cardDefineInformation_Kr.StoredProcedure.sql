USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[cardDefineInformation_Kr]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[cardDefineInformation_Kr](
	@cardDefineKey varchar(20)
)
AS BEGIN
	SELECT * FROM cardDefineTbl_Kr WHERE cardDefineKey = @cardDefineKey
END
GO
