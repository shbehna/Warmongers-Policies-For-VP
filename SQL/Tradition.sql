------------------------------------------------
-- Opener (POLICY_TRADITION)
------------------------------------------------


------------------------------------------------
-- Ceremony (POLICY_LEGALISM)
------------------------------------------------


------------------------------------------------
-- Justice (POLICY_ARISTOCRACY)
------------------------------------------------

-- Remove 25% ranged combat bonus to garrisoned cities (moved to Expertise).
UPDATE Policies
SET GarrisonedCityRangeStrikeModifier = 0
WHERE Type = 'POLICY_ARISTOCRACY';

-- Great Person Points in the Capital on kill (Lua).

------------------------------------------------
-- Sovereignty (POLICY_OLIGARCHY)
------------------------------------------------


------------------------------------------------
-- Majesty (POLICY_MONARCHY)
------------------------------------------------

-- Remove the flat Great Person Rate modifier from the free Palace Garden.
UPDATE Buildings
SET GreatPeopleRateModifier = 0
WHERE Type = 'BUILDING_PALACE_GARDEN';

-- Instant Food and Production in the Capital when razing a city (Lua).
-- The dummy building below records the population of a captured city so the
-- payout still knows it once razing completes, several turns and saves later.
INSERT INTO BuildingClasses
		(Type,										DefaultBuilding,						Description)
VALUES	('BUILDINGCLASS_WMP_RAZE_POP_DUMMY',		'BUILDING_WMP_RAZE_POP_DUMMY',			'TXT_KEY_BUILDING_WMP_RAZE_POP_DUMMY');

INSERT INTO Buildings
		(Type,								BuildingClass,							Description,								Help,										Cost,	GoldMaintenance,	MinAreaSize,	NukeImmune,	ConquestProb,	NeverCapture,	HurryCostModifier,	IconAtlas,		PortraitIndex,	IsDummy)
VALUES	('BUILDING_WMP_RAZE_POP_DUMMY',		'BUILDINGCLASS_WMP_RAZE_POP_DUMMY',		'TXT_KEY_BUILDING_WMP_RAZE_POP_DUMMY',		'TXT_KEY_BUILDING_WMP_RAZE_POP_DUMMY',		-1,		0,					-1,				1,			0,				1,				5,					'UCS_ATLAS',	0,				1);

------------------------------------------------
-- Splendor (POLICY_LANDED_ELITE)
------------------------------------------------


------------------------------------------------
-- Finisher (POLICY_TRADITION_FINISHER)
------------------------------------------------
