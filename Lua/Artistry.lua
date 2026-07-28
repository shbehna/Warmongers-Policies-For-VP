local ePolicyHumanism = GameInfoTypes.POLICY_CULTURAL_CENTERS

local iHealAmount = 5

------------------------------------------------
-- Humanism (POLICY_CULTURAL_CENTERS)
------------------------------------------------

-- All your units heal when a Great Work is created.
function Humanism_OnGreatWorkCreatedHealUnits(playerID, unitID, greatWorkID)
	local pPlayer = Players[playerID]
	if pPlayer == nil or not pPlayer:HasPolicy(ePolicyHumanism) then return end

	for pUnit in pPlayer:Units() do
		if pUnit:GetBaseCombatStrength() > 0 then
			pUnit:ChangeDamage(-iHealAmount)
		end
	end

	if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital == nil then return end

		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
			'Your army is inspired by the new Great Work and heals ' .. iHealAmount .. ' HP.',
			'Inspired by the Arts',
			pCapital:GetX(), pCapital:GetY(), pCapital:GetID())
	end
end

GameEvents.GreatWorkCreated.Add(Humanism_OnGreatWorkCreatedHealUnits)
