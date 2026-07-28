------------------------------------------------
-- Opener (POLICY_EXPLORATION)
------------------------------------------------


------------------------------------------------
-- Civilizing Mission (POLICY_TREASURE_FLEETS)
------------------------------------------------


------------------------------------------------
-- Regimental System (POLICY_NAVIGATION_SCHOOL)
------------------------------------------------


------------------------------------------------
-- Colonialism (POLICY_NAVAL_TRADITION)
------------------------------------------------

-- Remove the monopoly bonuses (moved to Subsidies).
UPDATE Policies
SET
	MonopolyModFlat = 0,
	MonopolyModPercent = 0
WHERE Type = 'POLICY_NAVAL_TRADITION';

-- Instant Science and Culture when a building is constructed in a City.
-- Instant yields scale with era and game speed.
INSERT INTO Policy_YieldFromConstruction
	(PolicyType, YieldType, Yield)
VALUES
	('POLICY_NAVAL_TRADITION', 'YIELD_SCIENCE', 15),
	('POLICY_NAVAL_TRADITION', 'YIELD_CULTURE', 15);

------------------------------------------------
-- Exploitation (POLICY_MERCHANT_NAVY)
------------------------------------------------


------------------------------------------------
-- Martial Law (POLICY_MARITIME_INFRASTRUCTURE)
------------------------------------------------


------------------------------------------------
-- Finisher (POLICY_EXPLORATION_FINISHER)
------------------------------------------------
