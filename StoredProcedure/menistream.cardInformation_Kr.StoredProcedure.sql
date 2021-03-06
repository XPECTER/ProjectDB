USE [menistream]
GO
/****** Object:  StoredProcedure [menistream].[cardInformation_Kr]    Script Date: 04/05/2015 10:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [menistream].[cardInformation_Kr](
		@cardKey char(16)
)
AS BEGIN
	-- 리더 카드 정보
	IF(SELECT jobType FROM cardDefineTbl_Kr WHERE cardDefineKey = 
	(SELECT cardDefineKey FROM cardTbl WHERE cardKey = @cardKey)) IS NULL
	BEGIN
		SELECT @cardKey AS cardKey, cardDefineTbl_Kr.* FROM cardDefineTbl_Kr WHERE cardDefineKey = 
		(SELECT cardDefineKey FROM cardTbl WHERE cardKey = @cardKey)
	END
	ELSE
	BEGIN
		-- 그 외 카드 정보
		SELECT @cardKey AS cardKey, cardDefineTbl_Kr.*
		FROM cardDefineTbl_Kr 
		cross join jobDefineTbl_Kr 
		WHERE cardDefineTbl_Kr.cardDefineKey = 
			(SELECT c.cardDefineKey 
			FROM cardTbl c 				
			WHERE cardKey = @cardKey) 
			AND cardDefineTbl_Kr.jobType = jobDefineTbl_Kr.jobType
	END
END
GO
