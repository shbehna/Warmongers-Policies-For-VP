-- Remove monopoly bonuses (moved to commerce)

UPDATE Policies
SET MonopolyModFlat = 0
WHERE Type = 'POLICY_NAVAL_TRADITION';

UPDATE Policies
SET MonopolyModPercent = 0
WHERE Type = 'POLICY_NAVAL_TRADITION';

-- Add culture when training units
INSERT INTO BuildingClasses 	
 		(Type, 						 		 		DefaultBuilding, 						Description)
VALUES	('BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1', 		'BUILDING_WMP_EXPLORATION_DUMMY_1',			'TXT_KEY_BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1');

INSERT INTO Buildings 
		(Type,                               BuildingClass,                           Cost, GoldMaintenance, PrereqTech, Description,                                     Help,                                            MinAreaSize, NukeImmune, ConquestProb, NeverCapture, HurryCostModifier, IconAtlas,   PortraitIndex, IsDummy)
VALUES  ('BUILDING_WMP_EXPLORATION_DUMMY_1', 'BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1', -1,   0,               NULL,       'TXT_KEY_BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1', 'TXT_KEY_BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1', -1,          1,          0,            1,            5,                 'UCS_ATLAS', 0,             1);

INSERT INTO Building_YieldFromUnitProduction
		(BuildingType, YieldType, Yield)
VALUES	('BUILDING_WMP_EXPLORATION_DUMMY_1', 'YIELD_CULTURE', 15);

INSERT INTO Policy_FreeBuilding
			(PolicyType,			BuildingClassType,				Count)
VALUES		('POLICY_NAVAL_TRADITION',	'BUILDINGCLASS_WMP_EXPLORATION_DUMMY_1',	200);