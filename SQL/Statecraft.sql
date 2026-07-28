------------------------------------------------
-- Opener (POLICY_PATRONAGE)
------------------------------------------------


------------------------------------------------
-- Foreign Service (POLICY_PHILANTHROPY)
------------------------------------------------

-- Bonus Influence when gifting a unit to a City-State, on top of the
-- Influence the gift is normally worth (same field Arsenal of Democracy uses).
UPDATE Policies
SET MilitaryUnitGiftExtraInfluence = 10
WHERE Type = 'POLICY_PHILANTHROPY';

------------------------------------------------
-- Trade Confederacy (POLICY_MERCHANT_CONFEDERACY)
------------------------------------------------


------------------------------------------------
-- Shadow Networks (POLICY_SCHOLASTICISM)
------------------------------------------------


------------------------------------------------
-- Consulates (POLICY_CONSULATES)
------------------------------------------------


------------------------------------------------
-- Exchange Markets (POLICY_CULTURAL_DIPLOMACY)
------------------------------------------------


------------------------------------------------
-- Finisher (POLICY_PATRONAGE_FINISHER)
------------------------------------------------
