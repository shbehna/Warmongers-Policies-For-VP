------------------------------------------------
-- Progress opener (POLICY_LIBERTY)
------------------------------------------------

INSERT INTO Policy_BuildingClassYieldChanges
	(PolicyType, BuildingClassType, YieldType, YieldChange)
VALUES
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_MONUMENT', 'YIELD_CULTURE', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_BATH', 'YIELD_CULTURE', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_GARDEN', 'YIELD_CULTURE', 1);

INSERT INTO Policy_FounderYield
			(PolicyType, YieldType, Yield)
VALUES
			('POLICY_LIBERTY', 'YIELD_SCIENCE', 40),
			('POLICY_LIBERTY', 'YIELD_CULTURE', 40);

DELETE FROM Policy_YieldFromBirthCapital WHERE PolicyType = 'POLICY_LIBERTY';
DELETE FROM Policy_YieldFromBirthCapitalRetroactive WHERE PolicyType = 'POLICY_LIBERTY';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_LIBERTY';
DELETE FROM Policy_YieldFromTechRetroactive WHERE PolicyType = 'POLICY_LIBERTY';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_COLLECTIVE_RULE';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_CITIZENSHIP';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_REPUBLIC';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_REPRESENTATION';
DELETE FROM Policy_YieldFromTech WHERE PolicyType = 'POLICY_MERITOCRACY';

-- Gold from birth is now the scaler
DELETE FROM Policy_YieldFromBirth WHERE PolicyType = 'POLICY_LIBERTY_FINISHER'; 

INSERT INTO Policy_YieldFromBirth
	(PolicyType, YieldType, Yield)
SELECT
	Type, 'YIELD_GOLD', 10
FROM Policies
WHERE PolicyBranchType = 'POLICY_BRANCH_LIBERTY';

-----------------------------------------------
-- Organization (POLICY_COLLECTIVE_RULE)
-----------------------------------------------

-- Remove flat production from cities.
DELETE FROM Policy_CityYieldChanges WHERE PolicyType = 'POLICY_COLLECTIVE_RULE';

-- Add gold and production from border growth.
INSERT INTO Policy_YieldFromBorderGrowth
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_COLLECTIVE_RULE', 'YIELD_PRODUCTION', 20),
	('POLICY_COLLECTIVE_RULE', 'YIELD_GOLD', 20);

-----------------------------------------------
-- Liberty (POLICY_CITIZENSHIP)
-----------------------------------------------

-- Remove flat production from cities.
DELETE FROM Policy_CityYieldChanges WHERE PolicyType = 'POLICY_CITIZENSHIP';

-- Extra XP on purchased units (lua)

-- Add free settler unit.
INSERT INTO Policy_FreeUnitClasses
	(PolicyType, UnitClassType, Count)
VALUES
	('POLICY_CITIZENSHIP', 'UNITCLASS_SETTLER', 1);

-- Add 20% production modifier for buildings.
UPDATE Policies
SET BuildingProductionModifier = 20
WHERE Type = 'POLICY_CITIZENSHIP';

-----------------------------------------------
-- Expertise (POLICY_REPUBLIC)
-----------------------------------------------

-- Add 25% ranged combat bonus to city strike. 
-- Add 20% extra supply per population.
-- Remove building production modifier (moved to Citizenship).
UPDATE Policies
SET GarrisonedCityRangeStrikeModifier = 25, 
	ExtraSupplyPerPopulation = 20, 
	BuildingProductionModifier = 0
WHERE Type = 'POLICY_REPUBLIC';

INSERT INTO Policy_ImprovementYieldChanges
	(PolicyType, ImprovementType, YieldType, Yield)
VALUES
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_FORT', 'YIELD_CULTURE_LOCAL', 1),
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_FORT', 'YIELD_PRODUCTION', 1),
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_CITADEL', 'YIELD_CULTURE_LOCAL', 1),
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_CITADEL', 'YIELD_PRODUCTION', 1),
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_MONGOLIA_ORDO', 'YIELD_CULTURE_LOCAL', 1),
	('POLICY_NAVAL_TRADITION', 'IMPROVEMENT_MONGOLIA_ORDO', 'YIELD_PRODUCTION', 1);

-----------------------------------------------
-- Equality (POLICY_REPRESENTATION)
-----------------------------------------------

UPDATE Policies
SET
	HappinessPerGarrisonedUnit = 1, 
	ExtraHappinessPerCity = 0
WHERE Type = 'POLICY_REPRESENTATION';

-----------------------------------------------
-- Fraternity (POLICY_MERITOCRACY)
-----------------------------------------------

INSERT INTO Policy_BuildingClassYieldChanges
	(PolicyType, BuildingClassType, YieldType, YieldChange)
VALUES
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_HERBALIST', 'YIELD_FOOD', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_LODGE', 'YIELD_FOOD', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_GROVE', 'YIELD_FOOD', 1), 
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_HERBALIST', 'YIELD_SCIENCE', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_LODGE', 'YIELD_SCIENCE', 1),
	('POLICY_MERITOCRACY', 'BUILDINGCLASS_GROVE', 'YIELD_SCIENCE', 1);

-- Remove flat yields
DELETE FROM Policy_CityYieldChanges WHERE PolicyType = 'POLICY_MERITOCRACY' AND YieldType = 'YIELD_FOOD';
DELETE FROM Policy_YieldChangeTradeRoute WHERE PolicyType = 'POLICY_MERITOCRACY' AND YieldType = 'YIELD_SCIENCE';

-----------------------------------------------
-- Finisher (POLICY_LIBERTY_FINISHER)
-----------------------------------------------

INSERT INTO Policy_YieldFromBorderGrowth
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_LIBERTY_FINISHER', 'YIELD_GOLD', 20),
	('POLICY_LIBERTY_FINISHER', 'YIELD_PRODUCTION', 20);
