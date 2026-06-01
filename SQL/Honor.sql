------------------------------------------------
-- Authority opener (POLICY_HONOR)
------------------------------------------------

-- -- Add more yields to scalers 

-- UPDATE Policy_YieldFromKills 
-- SET Yield = 20 
-- WHERE PolicyType IN (SELECT Type FROM Policies WHERE PolicyBranchType = 'POLICY_BRANCH_HONOR'); 

-- UPDATE Policies
-- SET CultureFromKills = 20
-- WHERE PolicyBranchType = 'POLICY_BRANCH_HONOR';

-- Barracks and walls build faster
INSERT INTO Policy_BuildingClassProductionModifiers
	(PolicyType, BuildingClassType, ProductionModifier)
VALUES
	('POLICY_HONOR', 'BUILDINGCLASS_BARRACKS', 100),
	('POLICY_HONOR', 'BUILDINGCLASS_WALLS', 100);

------------------------------------------------
-- Imperium (POLICY_DISCIPLINE)
------------------------------------------------
DELETE FROM Policy_FounderYield WHERE PolicyType = 'POLICY_DISCIPLINE';

DELETE FROM Policy_YieldFromBorderGrowth WHERE PolicyType = 'POLICY_DISCIPLINE';

-- Add unit production modifier for military units
INSERT INTO Policy_UnitCombatProductionModifiers
	(PolicyType, UnitCombatType, ProductionModifier)
SELECT
	'POLICY_DISCIPLINE', Type, 20
FROM UnitCombatInfos
WHERE IsMilitary = 1;

------------------------------------------------
-- Tribute (POLICY_WARRIOR_CODE)
------------------------------------------------
DELETE FROM Policy_FreeUnitClasses WHERE PolicyType = 'POLICY_WARRIOR_CODE';

UPDATE Policies
SET
	IncludesOneShotFreeUnits = 0, 
	MinorBullyScoreModifier = 15
WHERE Type = 'POLICY_WARRIOR_CODE';

-- Add culture when training units
INSERT INTO BuildingClasses 	
		(Type, 						 		 		DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_WMP_HONOR_DUMMY_1', 		'BUILDING_WMP_HONOR_DUMMY_1',			'TXT_KEY_BUILDINGCLASS_WMP_HONOR_DUMMY_1');

INSERT INTO Buildings 
		(Type,                               BuildingClass,                           Cost, GoldMaintenance, PrereqTech, Description,                                     Help,                                            MinAreaSize, NukeImmune, ConquestProb, NeverCapture, HurryCostModifier, IconAtlas,   PortraitIndex, IsDummy)
VALUES  ('BUILDING_WMP_HONOR_DUMMY_1', 'BUILDINGCLASS_WMP_HONOR_DUMMY_1', -1,   0,               NULL,       'TXT_KEY_BUILDINGCLASS_WMP_HONOR_DUMMY_1', 'TXT_KEY_BUILDINGCLASS_WMP_HONOR_DUMMY_1', -1,          1,          0,            1,            5,                 'UCS_ATLAS', 0,             1);

INSERT INTO Building_YieldFromUnitProduction
		(BuildingType, YieldType, Yield)
VALUES	('BUILDING_WMP_HONOR_DUMMY_1', 'YIELD_SCIENCE', 10),
		('BUILDING_WMP_HONOR_DUMMY_1', 'YIELD_CULTURE', 10);

INSERT INTO Policy_FreeBuilding
			(PolicyType,			BuildingClassType,				Count)
VALUES		('POLICY_DISCIPLINE',	'BUILDINGCLASS_WMP_HONOR_DUMMY_1',	999);

------------------------------------------------
-- Militarism (POLICY_MILITARY_TRADITION)
------------------------------------------------

-- Plunderer promotion - Gain XP on pillage 
INSERT INTO UnitPromotions 
		(Type, 						    Description, 						Help, 									    Sound, 				GainsXPFromPillaging,	ExtraXpOnKill, 		AttackWoundedMod,	MovesChange,	PillageBonusStrength, 	AttackMod,	DefenseMod, 	ExperiencePercent,	IgnoreZOC,	LostWithUpgrade,	CannotBeChosen, PortraitIndex, 		IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_WMP_PLUNDERER', 	'TXT_KEY_PROMOTION_WMP_PLUNDERER',	'TXT_KEY_PROMOTION_WMP_PLUNDERER_HELP', 	'AS2D_IF_LEVELUP',	1,						1, 					0,					0,				0, 				    	0,			0,				0,					0,			0,					1, 				58, 				'PROMOTION_ATLAS', 	'PEDIA_SHARED',	    'TXT_KEY_PROMOTION_WMP_PLUNDERER_HELP');

INSERT INTO UnitPromotions_UnitCombats (PromotionType, UnitCombatType)
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_RECON' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_ARCHER' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_MOUNTED' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_MELEE' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_SIEGE' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_GUN' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_ARMOR' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_HELICOPTER' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_NAVALMELEE' UNION ALL
SELECT 'PROMOTION_WMP_PLUNDERER', 'UNITCOMBAT_NAVALRANGED';

INSERT INTO UnitPromotions_YieldFromPillage
	(PromotionType, YieldType, Yield)
VALUES
	('PROMOTION_WMP_PLUNDERER', 'YIELD_GOLD', 10), 
	('PROMOTION_WMP_PLUNDERER', 'YIELD_PRODUCTION', 10);

INSERT INTO Policy_FreePromotions
	(PolicyType, PromotionType)
VALUES
	('POLICY_MILITARY_TRADITION', 'PROMOTION_WMP_PLUNDERER');

------------------------------------------------
-- Dominance (POLICY_MILITARY_CASTE)
------------------------------------------------
UPDATE Policies
SET
	ExtraSupplyPerPopulation = 0
WHERE Type = 'POLICY_MILITARY_CASTE';

DELETE FROM Policy_YieldFromXMilitaryUnits WHERE PolicyType = 'POLICY_MILITARY_CASTE';

-- Gain food and gold with each 10 units
INSERT INTO Policy_YieldFromXMilitaryUnits
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_MILITARY_CASTE', 'YIELD_PRODUCTION', 8), 
	('POLICY_MILITARY_CASTE', 'YIELD_GOLD', 8);

------------------------------------------------
-- Honor (POLICY_PROFESSIONAL_ARMY)
------------------------------------------------
