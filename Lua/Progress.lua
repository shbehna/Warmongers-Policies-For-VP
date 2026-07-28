local ePolicyLiberty = GameInfoTypes.POLICY_CITIZENSHIP

local iBonusXP = 5

-- XP scaling is always active in VP v5.
local fExperienceModifier = GameInfo.GameSpeeds[Game.GetGameSpeedType()].ExperiencePercent / 100

------------------------------------------------
-- Liberty (POLICY_CITIZENSHIP)
------------------------------------------------

-- Units purchased with Gold start with 5 bonus XP, scaling with era.
function Liberty_OnPurchaseAddXP(iPlayer, iCity, iUnit, bGold, bFaith)
	if not bGold then return end

	local pPlayer = Players[iPlayer]
	if pPlayer == nil or not pPlayer:HasPolicy(ePolicyLiberty) then return end

	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit == nil then return end

	local iEraModifier = math.max(pPlayer:GetCurrentEra(), 1)

	pUnit:ChangeExperience(iEraModifier * math.floor(iBonusXP * fExperienceModifier), -1, 1)
end

GameEvents.CityTrained.Add(Liberty_OnPurchaseAddXP)
