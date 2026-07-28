include("FLuaVector.lua")

local ePolicyJustice = GameInfoTypes.POLICY_ARISTOCRACY
local ePolicyMajesty = GameInfoTypes.POLICY_MONARCHY
local eRazePopDummy = GameInfoTypes.BUILDING_WMP_RAZE_POP_DUMMY

local iRazeYieldPerPop = 25
local iGppPercentOfStrength = 75

local fInstantYieldModifier = GameInfo.GameSpeeds[Game.GetGameSpeedType()].InstantYieldPercent / 100

function PositionCalculator(i1, i2)
	return HexToWorld(ToHexFromGrid(Vector2(i1, i2)))
end

------------------------------------------------
-- Majesty (POLICY_MONARCHY)
------------------------------------------------

-- Great Person Points in the Capital on kill, worth 75% of the killed unit's
-- combat strength. One Great Person type is picked at random per kill.
local tGreatPeople = {
	{ Specialist = "SPECIALIST_WRITER",			Icon = "[ICON_GREAT_WRITER]",	Name = "Great Writer" },
	{ Specialist = "SPECIALIST_ARTIST",			Icon = "[ICON_GREAT_ARTIST]",	Name = "Great Artist" },
	{ Specialist = "SPECIALIST_MUSICIAN",		Icon = "[ICON_GREAT_MUSICIAN]",	Name = "Great Musician" },
	{ Specialist = "SPECIALIST_SCIENTIST",		Icon = "[ICON_GREAT_SCIENTIST]",Name = "Great Scientist" },
	{ Specialist = "SPECIALIST_MERCHANT",		Icon = "[ICON_GREAT_MERCHANT]",	Name = "Great Merchant" },
	{ Specialist = "SPECIALIST_ENGINEER",		Icon = "[ICON_GREAT_ENGINEER]",	Name = "Great Engineer" },
	{ Specialist = "SPECIALIST_CIVIL_SERVANT",	Icon = "[ICON_GREAT_DIPLOMAT]",	Name = "Great Diplomat" },
}

function Majesty_OnKillAwardGPP(iAttackingPlayer, iAttackingUnit, iAttackerDamage, iAttackerFinalDamage, iAttackerMaxHP, iDefendingPlayer, iDefendingUnit, iDefenderDamage, iDefenderFinalDamage, iDefenderMaxHP, iInterceptingPlayer, iInterceptingUnit, iInterceptorDamage, iPlotX, iPlotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	local pDefendingPlayer = Players[iDefendingPlayer]

	if pAttackingPlayer == nil or pDefendingPlayer == nil then return end
	if not pAttackingPlayer:HasPolicy(ePolicyMajesty) then return end

	local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)
	if pDefendingUnit == nil or not pDefendingUnit:IsDead() then return end

	local pCapital = pAttackingPlayer:GetCapitalCity()
	if pCapital == nil then return end

	local tGreatPerson = tGreatPeople[math.random(#tGreatPeople)]
	local iGainTimes100 = iGppPercentOfStrength * pDefendingUnit:GetBaseCombatStrength()
	local iGain = math.floor(iGainTimes100 / 100)

	pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes[tGreatPerson.Specialist], iGainTimes100)

	if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
		Events.AddPopupTextEvent(PositionCalculator(iPlotX, iPlotY), "[COLOR_WHITE]+" .. iGain .. " " .. tGreatPerson.Icon .. "[ENDCOLOR]", 1)
		pAttackingPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
			'You have gained ' .. iGain .. ' ' .. tGreatPerson.Icon .. ' ' .. tGreatPerson.Name .. ' Points in ' .. pCapital:GetName() .. ' for killing a Unit.',
			'Bonus Yields',
			iPlotX, iPlotY)
	end
end

GameEvents.CombatEnded.Add(Majesty_OnKillAwardGPP)

------------------------------------------------
-- Justice (POLICY_ARISTOCRACY)
------------------------------------------------

-- Razing a city takes several turns, and the city is gone by the time the
-- payout fires, so stamp the captured city with a dummy building whose count
-- is its population. That survives both the razing timer and save/reload.
function Justice_OnCaptureRecordPopulation(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlayer = Players[iNewOwner]
	if pPlayer == nil or not pPlayer:HasPolicy(ePolicyJustice) then return end

	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity == nil then return end

	pCity:SetNumRealBuilding(eRazePopDummy, pCity:GetPopulation())
end

GameEvents.CityCaptureComplete.Add(Justice_OnCaptureRecordPopulation)

-- Instant Food and Production in the Capital when the raze completes,
-- 25 per population of the razed city. Does not scale with era.
function Justice_OnRazeAwardYields(hexPos, iOldOwner, cityID, iNewOwner)
	local pPlayer = Players[iNewOwner]
	if pPlayer == nil or not pPlayer:HasPolicy(ePolicyJustice) then return end

	local pCapital = pPlayer:GetCapitalCity()
	if pCapital == nil then return end

	local pCity = Players[iOldOwner]:GetCityByID(cityID)
	if pCity == nil then return end

	local iRazedPop = pCity:GetNumRealBuilding(eRazePopDummy)
	if iRazedPop <= 0 then return end

	local iGain = math.floor(iRazeYieldPerPop * iRazedPop * fInstantYieldModifier)

	pCapital:ChangeFood(iGain)
	pCapital:ChangeProduction(iGain)

	if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
			'Loot from your recent conquest has arrived in the capital! Gained: +' .. iGain .. ' [ICON_FOOD] Food, +' .. iGain .. ' [ICON_PRODUCTION] Production.',
			'Loot from your recent conquest',
			pCapital:GetX(), pCapital:GetY(), pCapital:GetID())
	end
end

Events.SerialEventCityDestroyed.Add(Justice_OnRazeAwardYields)
