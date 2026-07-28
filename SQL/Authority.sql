------------------------------------------------
-- Opener (POLICY_HONOR)
------------------------------------------------


------------------------------------------------
-- Imperium (POLICY_DISCIPLINE)
------------------------------------------------

-- Add a 20% production modifier to military units.
INSERT INTO Policy_UnitCombatProductionModifiers
	(PolicyType, UnitCombatType, ProductionModifier)
SELECT
	'POLICY_DISCIPLINE', Type, 20
FROM UnitCombatInfos
WHERE IsMilitary = 1;

------------------------------------------------
-- Tribute (POLICY_WARRIOR_CODE)
------------------------------------------------

-- Remove the free Settler.
DELETE FROM Policy_FreeUnitClasses
WHERE PolicyType = 'POLICY_WARRIOR_CODE';

UPDATE Policies
SET
	IncludesOneShotFreeUnits = 0,
	MinorBullyScoreModifier = 15
WHERE Type = 'POLICY_WARRIOR_CODE';

-- Science and Culture when a City produces a unit. Yield is a percentage of
-- the unit's production cost, so stronger units pay more.
INSERT INTO Policy_YieldFromUnitProduction
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_WARRIOR_CODE', 'YIELD_SCIENCE', 10),
	('POLICY_WARRIOR_CODE', 'YIELD_CULTURE', 10);

------------------------------------------------
-- Militarism (POLICY_MILITARY_TRADITION)
------------------------------------------------

-- Plunderer promotion - gain XP from pillaging.
INSERT INTO UnitPromotions
		(Type,						Description,						Help,									Sound,				XPFromPillaging,	CannotBeChosen,	LostWithUpgrade,	PortraitIndex,	IconAtlas,			PediaType,		PediaEntry)
VALUES	('PROMOTION_WMP_PLUNDERER',	'TXT_KEY_PROMOTION_WMP_PLUNDERER',	'TXT_KEY_PROMOTION_WMP_PLUNDERER_HELP',	'AS2D_IF_LEVELUP',	5,					1,				0,					44,				'PROMOTION_ATLAS',	'PEDIA_SHARED',	'TXT_KEY_PROMOTION_WMP_PLUNDERER_HELP');

INSERT INTO UnitPromotions_UnitCombats
	(PromotionType, UnitCombatType)
SELECT
	'PROMOTION_WMP_PLUNDERER', Type
FROM UnitCombatInfos
WHERE IsMilitary = 1;

INSERT INTO Policy_FreePromotions
	(PolicyType, PromotionType)
VALUES
	('POLICY_MILITARY_TRADITION', 'PROMOTION_WMP_PLUNDERER');

------------------------------------------------
-- Dominance (POLICY_MILITARY_CASTE)
------------------------------------------------


------------------------------------------------
-- Honor (POLICY_PROFESSIONAL_ARMY)
------------------------------------------------

-- Remove the free unit per 10 Citizens (moved to Fraternity).
UPDATE Policies
SET XPopulationConscription = 0
WHERE Type = 'POLICY_PROFESSIONAL_ARMY';

------------------------------------------------
-- Finisher (POLICY_HONOR_FINISHER)
------------------------------------------------
