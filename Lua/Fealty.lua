local ePolicyOrganizedReligion = GameInfoTypes.POLICY_ORGANIZED_RELIGION

local fInstantYieldModifier = GameInfo.GameSpeeds[Game.GetGameSpeedType()].InstantYieldPercent / 100

------------------------------------------------
-- Organized Religion (POLICY_ORGANIZED_RELIGION)
------------------------------------------------

-- Faith and Culture when one of your units is killed by another player,
-- worth its combat strength times its experience level.
function OrganizedReligion_OnUnitDeathAwardYields(playerID, unitID, unitType, iX, iY, bDelay, eKiller)
	local pPlayer = Players[playerID]

	if pPlayer == nil or not pPlayer:IsAlive() then return end
	if not pPlayer:HasPolicy(ePolicyOrganizedReligion) then return end

	-- Only martyrs: the unit has to have been killed by somebody else.
	if eKiller == -1 or eKiller == playerID then return end

	local pUnit = pPlayer:GetUnitByID(unitID)
	if pUnit == nil or not pUnit:IsCombatUnit() then return end

	local iGain = math.floor(pUnit:GetBaseCombatStrength() * pUnit:GetLevel() * fInstantYieldModifier)
	if iGain <= 0 then return end

	pPlayer:ChangeFaith(iGain)
	pPlayer:ChangeJONSCulture(iGain)

	if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital == nil then return end

		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
			'They died as martyrs! Gained: +' .. iGain .. ' [ICON_PEACE] Faith, +' .. iGain .. ' [ICON_CULTURE] Culture.',
			'They died as martyrs',
			pCapital:GetX(), pCapital:GetY(), pCapital:GetID())
	end
end

GameEvents.UnitPrekill.Add(OrganizedReligion_OnUnitDeathAwardYields)
