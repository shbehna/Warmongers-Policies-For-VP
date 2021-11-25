------------------------------------------------
-- Justice (POLICY_ARISTOCRACY)
------------------------------------------------
-- Remove 25% ranged combat bonus to garrisons. 
UPDATE Policies
SET GarrisonedCityRangeStrikeModifier = '0'
WHERE Type = 'POLICY_ARISTOCRACY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

-- GG/GA points when defeating an enemy to Royal Guardhouse. 
INSERT INTO Building_YieldFromVictory (BuildingType, YieldType, Yield)
SELECT 'BUILDING_CAPITAL_ENGINEER', 'YIELD_GREAT_GENERAL_POINTS', 5 UNION ALL
SELECT 'BUILDING_CAPITAL_ENGINEER', 'YIELD_GREAT_ADMIRAL_POINTS', 5;
