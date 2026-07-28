------------------------------------------------
-- Opener (POLICY_PIETY)
------------------------------------------------


------------------------------------------------
-- Nobility (POLICY_MANDATE_OF_HEAVEN)
------------------------------------------------

-- Remove the flat 2 Gold from Armories (the Castle bonus is untouched).
DELETE FROM Policy_BuildingClassYieldChanges
WHERE PolicyType = 'POLICY_MANDATE_OF_HEAVEN'
	AND BuildingClassType = 'BUILDINGCLASS_ARMORY'
	AND YieldType = 'YIELD_GOLD';

-- Crusader promotion - units heal in enemy territory.
INSERT INTO UnitPromotions
		(Type,						Description,						Help,									Sound,				EnemyHeal,	CannotBeChosen,	LostWithUpgrade,	PortraitIndex,	IconAtlas,			PediaType,		PediaEntry)
VALUES	('PROMOTION_WMP_CRUSADER',	'TXT_KEY_PROMOTION_WMP_CRUSADER',	'TXT_KEY_PROMOTION_WMP_CRUSADER_HELP',	'AS2D_IF_LEVELUP',	5,			1,				0,					31,				'PROMOTION_ATLAS',	'PEDIA_SHARED',	'TXT_KEY_PROMOTION_WMP_CRUSADER_HELP');

INSERT INTO UnitPromotions_UnitCombats
	(PromotionType, UnitCombatType)
SELECT
	'PROMOTION_WMP_CRUSADER', Type
FROM UnitCombatInfos
WHERE IsMilitary = 1;

INSERT INTO Policy_FreePromotions
	(PolicyType, PromotionType)
VALUES
	('POLICY_MANDATE_OF_HEAVEN', 'PROMOTION_WMP_CRUSADER');

------------------------------------------------
-- Fiefdoms (POLICY_THEOCRACY)
------------------------------------------------


------------------------------------------------
-- Serfdom (POLICY_FREE_RELIGION)
------------------------------------------------


------------------------------------------------
-- Organized Religion (POLICY_ORGANIZED_RELIGION)
------------------------------------------------

-- Remove the flat Culture from Temples and Grand Temples.
DELETE FROM Policy_BuildingClassYieldChanges
WHERE PolicyType = 'POLICY_ORGANIZED_RELIGION';

-- Faith and Culture when one of your units dies (Lua).

------------------------------------------------
-- Divine Right (POLICY_REFORMATION)
------------------------------------------------


------------------------------------------------
-- Finisher (POLICY_PIETY_FINISHER)
------------------------------------------------
