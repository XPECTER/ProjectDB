USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[selectCardSkillDefineList_Kr]    Script Date: 04/05/2015 10:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [menistream].[selectCardSkillDefineList_Kr]
AS BEGIN
	SELECT * FROM cardSkillDefineTbl_Kr
END
GO
