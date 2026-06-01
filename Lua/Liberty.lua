include("FLuaVector.lua")

------------------------------------------------
-- Progress opener (POLICY_LIBERTY)
------------------------------------------------


-----------------------------------------------
-- Liberty (POLICY_CITIZENSHIP)
-----------------------------------------------

-- Extra XP when purchasing units

-- check XP scaling
local bXPScaling = true -- default VP

for t in GameInfo.CustomModOptions { Name = "BALANCE_CORE_SCALING_XP" } do
	bXPScaling = (t.Value == 1)
end

-- acquire game speed modifier
local fGameSpeedModifier2 = 1.0

if bXPScaling then
	fGameSpeedModifier2 = GameInfo.GameSpeeds[Game.GetGameSpeedType()].TrainPercent / 100
end

function OnTrainAddXP(iPlayer, iCity, iUnit, bGold, bFaith)
	local pPlayer = Players[iPlayer]

	local pCity = pPlayer:GetCityByID(iCity)

	if not pPlayer:HasPolicy(GameInfoTypes.POLICY_CITIZENSHIP) then return end

	if bGold then
		-- adds 5 XP (scaling) to purchased units
		local pUnit = pPlayer:GetUnitByID(iUnit)

		local iEraModifier = math.max(pPlayer:GetCurrentEra(), 1)
		pUnit:ChangeExperience(iEraModifier * math.floor(5 * fGameSpeedModifier2), -1, 1)
	end
end

GameEvents.CityTrained.Add(OnTrainAddXP)


