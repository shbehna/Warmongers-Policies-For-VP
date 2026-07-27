include("FLuaVector.lua")

function PositionCalculator(i1, i2)
	return HexToWorld(ToHexFromGrid(Vector2(i1, i2)))
end

------------------------------------------------
-- Majesty (POLICY_MONARCHY)
------------------------------------------------

-- Bonus GPP points on kill
function OnWinCombatAwardGPP(iAttackingPlayer, iAttackingUnit, iAttackerDamage, iAttackerFinalDamage, iAttackerMaxHP, iDefendingPlayer, iDefendingUnit, iDefenderDamage, iDefenderFinalDamage, iDefenderMaxHP, iInterceptingPlayer, iInterceptingUnit, iInterceptorDamage, iPlotX, iPlotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	local pDefendingPlayer = Players[iDefendingPlayer]
	local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)

	if pAttackingPlayer == nil or pDefendingPlayer == nil then return end
	if not pAttackingPlayer:HasPolicy(GameInfoTypes.POLICY_MONARCHY) then return end
	if not pDefendingUnit:IsDead() then return end

	local rand = math.random(7)
	local pCapital = pAttackingPlayer:GetCapitalCity()
	local iGainText = pDefendingUnit:GetBaseCombatStrength()
	local iGain = (100 * iGainText)
	
	if (rand == 1) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_WRITER"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Writer Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	elseif (rand == 2) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ARTIST"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Artist Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	elseif (rand == 3) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MUSICIAN"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Musician Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	elseif (rand == 4) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_SCIENTIST"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Scientist Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	elseif (rand == 5) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_MERCHANT"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Merchant Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	elseif (rand == 6) then
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_ENGINEER"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Engineer Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	
	else
		pCapital:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes["SPECIALIST_CIVIL_SERVANT"], iGain)
		if pAttackingPlayer:IsHuman() and pAttackingPlayer:IsTurnActive() then
			local vUnitPosition = PositionCalculator(iPlotX, iPlotY)
			
			Events.AddPopupTextEvent(vUnitPosition, "[COLOR_WHITE]+"..iGainText.." [ICON_GREAT_PEOPLE][ENDCOLOR]", 1)
			pAttackingPlayer:AddNotification(0,
				'You have Gained '..iGainText..' [ICON_GREAT_PEOPLE] Great Diplomat Points in '..pCapital:GetName()..' for killing a Unit.',
				'Bonus Yields',
				iPlotX, iPlotY)
		end
	end
end

GameEvents.CombatEnded.Add(OnWinCombatAwardGPP)

------------------------------------------------
-- Splendor (POLICY_LANDED_ELITE)
------------------------------------------------
-- Instant yields on city raze
function SetPopBuilding(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlayer = Players[iNewOwner]
	if not pPlayer:HasPolicy(GameInfoTypes.POLICY_LANDED_ELITE) then return end

 	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_WMP_TRADITION_DUMMY_2, pCity:GetPopulation())
end
GameEvents.CityCaptureComplete.Add(SetPopBuilding)

-- Instant yields on city raze
function BonusOnRaze(hexPos, iOldOwner, cityID, iNewOwner)
	local pPlayer = Players[iNewOwner]
	local pCapital = pPlayer:GetCapitalCity()

	if pPlayer:HasPolicy(GameInfoTypes.POLICY_LANDED_ELITE) then
		local pCapitalX, pCapitalY, pCapitalID = pCapital:GetX(), pCapital:GetY(), pCapital:GetID()
		local iEraModifier = math.max(1, pPlayer:GetCurrentEra())
		local fGameSpeedModifier = GameInfo.GameSpeeds[ Game.GetGameSpeedType() ].InstantYieldPercent / 100

		local pCity = Players[iOldOwner]:GetCityByID(cityID)
		local iRazePop = pCity:GetNumRealBuilding(GameInfoTypes.BUILDING_WMP_TRADITION_DUMMY_2)
		local iGain = 25 * fGameSpeedModifier * iRazePop

		pCapital:ChangeFood(iGain)
		pCapital:ChangeProduction(iGain)
		pPlayer:ChangeGoldenAgeProgressMeter(iGain)
		pPlayer:ChangeGold(iGain)
		
		if pPlayer:IsHuman() and pPlayer:IsTurnActive() then			
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
				'Loot from your recent conquest have arrived in the capital ! Gained: +'..iGain..' [ICON_FOOD] Food, +'..iGain..' [ICON_PRODUCTION] Production, +'..iGain..' [ICON_GOLD] Gold, +'..iGain..' [ICON_GOLDEN_AGE] Golden age points',
				'Loot from your recent conquest',
				pCapitalX, pCapitalY, pCapitalID)
		end
	end
end

Events.SerialEventCityDestroyed.Add(BonusOnRaze)