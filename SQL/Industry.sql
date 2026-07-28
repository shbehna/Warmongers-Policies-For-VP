------------------------------------------------
-- Opener (POLICY_COMMERCE)
------------------------------------------------


------------------------------------------------
-- Division of Labor (POLICY_TRADE_UNIONS)
------------------------------------------------


------------------------------------------------
-- Subsidies (POLICY_CARAVANS)
------------------------------------------------

-- Remove the instant Science when a building is constructed (moved to
-- Colonialism).
DELETE FROM Policy_YieldFromConstruction
WHERE PolicyType = 'POLICY_CARAVANS';

-- Add the monopoly bonuses (moved from Colonialism).
UPDATE Policies
SET
	MonopolyModFlat = 5,
	MonopolyModPercent = 5
WHERE Type = 'POLICY_CARAVANS';

------------------------------------------------
-- Mercantilism (POLICY_MERCANTILISM)
------------------------------------------------


------------------------------------------------
-- Entrepreneurship (POLICY_ENTREPRENEURSHIP)
------------------------------------------------


------------------------------------------------
-- Gold Standard (POLICY_PROTECTIONISM)
------------------------------------------------


------------------------------------------------
-- Finisher (POLICY_COMMERCE_FINISHER)
------------------------------------------------
