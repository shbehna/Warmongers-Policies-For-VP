include("FLuaVector.lua")

local eLegalismPolicy = GameInfoTypes.POLICY_LEGALISM

-- Legalism - Bonus GPP points on kill
function Legalism_OnWinCombatAwardGPP(iAttackingPlayer, iAttackingUnit, iAttackerDamage, iAttackerFinalDamage, iAttackerMaxHP, iDefendingPlayer, iDefendingUnit, iDefenderDamage, iDefenderFinalDamage, iDefenderMaxHP, iInterceptingPlayer, iInterceptingUnit, iInterceptorDamage, iPlotX, iPlotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	local pDefendingPlayer = Players[iDefendingPlayer]
	local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)

	if pAttackingPlayer == nil or pDefendingPlayer == nil then return end
	if not pAttackingPlayer:HasPolicy(eLegalismPolicy) then return end
	if not pDefendingUnit:IsDead() then return end

	local rand = math.random(7)
	local pCapital = pAttackingPlayer:GetCapitalCity()
	local iGainText = math.floor((3/2) * pDefendingUnit:GetBaseCombatStrength())
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

function PositionCalculator(i1, i2)
	return HexToWorld(ToHexFromGrid(Vector2(i1, i2)))
end

GameEvents.CombatEnded.Add(Legalism_OnWinCombatAwardGPP)

