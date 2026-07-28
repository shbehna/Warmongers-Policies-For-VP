------------------------------------------------
-- Opener (POLICY_LIBERTY)
------------------------------------------------


------------------------------------------------
-- Organization (POLICY_COLLECTIVE_RULE)
------------------------------------------------

-- Remove the flat 2 Production in every City.
DELETE FROM Policy_CityYieldChanges
WHERE PolicyType = 'POLICY_COLLECTIVE_RULE' AND YieldType = 'YIELD_PRODUCTION';

-- Add Settlers to the 25% production bonus already granted to the other
-- non-military units.
INSERT INTO Policy_UnitClassProductionModifiers
	(PolicyType, UnitClassType, ProductionModifier)
VALUES
	('POLICY_COLLECTIVE_RULE', 'UNITCLASS_SETTLER', 25);

-- Add a free Settler on adoption.
UPDATE Policies
SET IncludesOneShotFreeUnits = 1
WHERE Type = 'POLICY_COLLECTIVE_RULE';

INSERT INTO Policy_FreeUnitClasses
	(PolicyType, UnitClassType, Count)
VALUES
	('POLICY_COLLECTIVE_RULE', 'UNITCLASS_SETTLER', 1);

------------------------------------------------
-- Liberty (POLICY_CITIZENSHIP)
------------------------------------------------

-- Bonus XP on purchased units (Lua).

-- Remove the flat 2 Gold in every City.
DELETE FROM Policy_CityYieldChanges
WHERE PolicyType = 'POLICY_CITIZENSHIP' AND YieldType = 'YIELD_GOLD';

------------------------------------------------
-- Expertise (POLICY_REPUBLIC)
------------------------------------------------

-- Add 25% ranged combat bonus to garrisoned cities (moved from Justice).
UPDATE Policies
SET GarrisonedCityRangeStrikeModifier = 25
WHERE Type = 'POLICY_REPUBLIC';

-- Great General / Great Admiral points on kill. Yield is a percentage of the
-- killed unit's combat strength, so it scales with era on its own.
INSERT INTO Policy_YieldFromKills
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_REPUBLIC', 'YIELD_GREAT_GENERAL_POINTS', 25),
	('POLICY_REPUBLIC', 'YIELD_GREAT_ADMIRAL_POINTS', 25);

------------------------------------------------
-- Equality (POLICY_REPRESENTATION)
------------------------------------------------

-- Trade the flat Happiness in every City for Happiness in Cities that are at
-- least CITY_STRENGTH_THRESHOLD_FOR_BONUSES (10) Strength.
UPDATE Policies
SET
	ExtraHappinessPerCity = 0,
	HappinessPerCityOverStrengthThreshold = 1
WHERE Type = 'POLICY_REPRESENTATION';

------------------------------------------------
-- Fraternity (POLICY_MERITOCRACY)
------------------------------------------------

-- Free unit for every 10 Citizens in a City (moved from Honor).
UPDATE Policies
SET XPopulationConscription = 10
WHERE Type = 'POLICY_MERITOCRACY';

------------------------------------------------
-- Finisher (POLICY_LIBERTY_FINISHER)
------------------------------------------------
