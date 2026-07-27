-- Add monopoly bonus

UPDATE Policies
SET MonopolyModFlat = 3
WHERE Type = 'POLICY_PROTECTIONISM';

UPDATE Policies
SET MonopolyModPercent = 10
WHERE Type = 'POLICY_PROTECTIONISM';

