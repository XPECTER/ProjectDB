USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[cardSkillInformation_Kr]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [menistream].[cardSkillInformation_Kr](
	@cardSkillDefineKey char(5)
)
AS BEGIN
	SELECT * 
	FROM cardSkillDefineTbl_Kr
	WHERE cardSkillDefineKey = @cardSkillDefineKey
END
GO
