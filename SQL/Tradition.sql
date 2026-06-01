------------------------------------------------
-- Tradition opener (POLICY_TRADITION)
------------------------------------------------

-- Now gain science when a citizen is born in the capital
INSERT INTO Policy_YieldFromBirthCapital
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_TRADITION', 'YIELD_SCIENCE', 15);

INSERT INTO Policy_YieldFromBirthCapitalRetroactive
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_TRADITION', 'YIELD_SCIENCE', 10);

-- Yields from tech
INSERT INTO Policy_YieldFromTech
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_TRADITION', 'YIELD_CULTURE', 15);

INSERT INTO Policy_YieldFromTechRetroactive
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_TRADITION', 'YIELD_CULTURE', 10);

-- Scaler
INSERT INTO Policy_YieldFromTech
	(PolicyType, YieldType, Yield)
SELECT
	Type, 'YIELD_CULTURE', 10
FROM Policies
WHERE PolicyBranchType = 'POLICY_BRANCH_TRADITION';

-- Remove flat science scaler
DELETE FROM Policy_CapitalYieldChanges WHERE PolicyType = 'POLICY_ARISTOCRACY' AND YieldType = 'YIELD_SCIENCE';
DELETE FROM Policy_CapitalYieldChanges WHERE PolicyType = 'POLICY_OLIGARCHY' AND YieldType = 'YIELD_SCIENCE';
DELETE FROM Policy_CapitalYieldChanges WHERE PolicyType = 'POLICY_LEGALISM' AND YieldType = 'YIELD_SCIENCE';
DELETE FROM Policy_CapitalYieldChanges WHERE PolicyType = 'POLICY_LANDED_ELITE' AND YieldType = 'YIELD_SCIENCE';
DELETE FROM Policy_CapitalYieldChanges WHERE PolicyType = 'POLICY_MONARCHY' AND YieldType = 'YIELD_SCIENCE';

-- Remove flat culture from pop
DELETE FROM Policy_CapitalYieldPerPopChanges WHERE PolicyType = 'POLICY_TRADITION';

------------------------------------------------
-- Ceremony (POLICY_LEGALISM)
------------------------------------------------

-- Add 1 happines per 15 pop
UPDATE Policies
SET
	HappinessPerXPopulationGlobal = 15
WHERE Type = 'POLICY_LEGALISM';

-- Remove flat science on buildings
DELETE FROM Building_BuildingClassYieldChanges
WHERE BuildingType IN ('BUILDING_PALACE_ASTROLOGER');

------------------------------------------------
-- Justice (POLICY_ARISTOCRACY)
------------------------------------------------
-- Remove 25% ranged combat bonus to garrisons. 
UPDATE Policies
SET GarrisonedCityRangeStrikeModifier = 0
WHERE Type = 'POLICY_ARISTOCRACY';

-- Remove flat production from cities. 
DELETE FROM Policy_CityYieldChanges WHERE PolicyType = 'POLICY_ARISTOCRACY';

-- Gain GG and GA points from the capital engineer building when killing units
INSERT INTO Building_YieldFromVictory
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_CAPITAL_ENGINEER', 'YIELD_GREAT_GENERAL_POINTS', 5),
	('BUILDING_CAPITAL_ENGINEER', 'YIELD_GREAT_ADMIRAL_POINTS', 5);

-- Add internal trace route yield changes
UPDATE Policies
SET
	InternalTradeRouteYieldModifier = 33
WHERE Type = 'POLICY_ARISTOCRACY';

UPDATE Buildings
SET
	AllowsProductionTradeRoutes = 1
WHERE BuildingClass = 'BUILDINGCLASS_CAPITAL_ENGINEER';

------------------------------------------------
-- Sovereignty (POLICY_OLIGARCHY)
------------------------------------------------

UPDATE Policies
SET
	PlotCultureExponentModifier = 0
WHERE Type = 'POLICY_OLIGARCHY';

------------------------------------------------
-- Majesty (POLICY_MONARCHY)
------------------------------------------------

-- GPP on kills (lua)

-- Remove flat GPP modifier on palace gardens
UPDATE Buildings
SET GreatPeopleRateModifier = 0
WHERE Type = 'BUILDING_PALACE_GARDEN';

------------------------------------------------
-- Splendor (POLICY_LANDED_ELITE)
------------------------------------------------

-- Add dummy building for bonus from raze
INSERT INTO BuildingClasses 
 		(Type, 						 		 		DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_WMP_TRADITION_DUMMY_2', 		'BUILDING_WMP_TRADITION_DUMMY_2',			'TXT_KEY_BUILDINGCLASS_WMP_TRADITION_DUMMY_2');

INSERT INTO Buildings 
		(Type,                               BuildingClass,                           Cost, GoldMaintenance, PrereqTech, Description,                               Help,                                           MinAreaSize, NukeImmune, ConquestProb, NeverCapture, HurryCostModifier, IconAtlas,   PortraitIndex, IsDummy)
VALUES  ('BUILDING_WMP_TRADITION_DUMMY_2', 'BUILDINGCLASS_WMP_TRADITION_DUMMY_2', -1,   0,               NULL,       'TXT_KEY_BUILDINGCLASS_WMP_TRADITION_DUMMY_2', 'TXT_KEY_BUILDINGCLASS_WMP_TRADITION_DUMMY_2',	-1,          1,          0,            1,            5,                 'UCS_ATLAS', 0,             1);

-- Remove flat bonus to monuments, gardens, and baths
DELETE INTO Building_BuildingClassYieldChanges WHERE BuildingType = 'BUILDING_PALACE_TREASURY';
