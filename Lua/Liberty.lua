include("FLuaVector.lua")

------------------------------------------------
-- Progress opener (POLICY_LIBERTY)
------------------------------------------------


-----------------------------------------------
-- Liberty (POLICY_CITIZENSHIP)
-----------------------------------------------

-- Extra XP when purchasing units

-- acquire game speed modifier (XP scaling is always active in VP v5)
local fGameSpeedModifier2 = GameInfo.GameSpeeds[Game.GetGameSpeedType()].ExperiencePercent / 100

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


