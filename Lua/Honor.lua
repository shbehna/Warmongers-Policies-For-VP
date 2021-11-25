
local ePolicyHonorFinisher = GameInfoTypes.POLICY_HONOR_FINISHER

-- Finisher - Instant yields and extra supply on city raze
function Finisher_BonusOnRaze(hexPos, iOldOwner, cityID, iNewOwner)
	local pPlayer = Players[iOldOwner]
	local pCapital = pPlayer:GetCapitalCity()
	
	if pPlayer:HasPolicy(ePolicyHonorFinisher) then
		local pCapitalX, pCapitalY, pCapitalID = pCapital:GetX(), pCapital:GetY(), pCapital:GetID()	
		local iEraModifier = math.max(pPlayer:GetCurrentEra(), 1)
		local fGameSpeedModifier = GameInfo.GameSpeeds[ Game.GetGameSpeedType() ].GoldPercent / 100

		local iGain = 100 * iEraModifier * fGameSpeedModifier

		pCapital:ChangeFood(iGain)
		pCapital:ChangeProduction(iGain)
		pPlayer:ChangeGoldenAgeProgressMeter(iGain)
		pPlayer:ChangeJONSCulture(iGain) 
		pPlayer:ChangeFaith(iGain)
		pPlayer:ChangeGold(iGain)
		pPlayer:ChangeOverflowResearch(iGain)
		
		if pPlayer:IsHuman() and pPlayer:IsTurnActive() then			
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
				'Loot from your recent conquest have arrived in the capital ! Gained: +'..iGain..' [ICON_FOOD] Food, +'..iGain..' [ICON_PRODUCTION] Production, +'..iGain..' [ICON_GOLD] Gold, +'..iGain..' [ICON_PEACE] Faith, +'..iGain..' [ICON_CULTURE] Culture, +'..iGain..' [ICON_RESEARCH] Research and +'..iGain..' [ICON_GOLDEN_AGE] Golden age points',
				'Loot from your recent conquest',
				pCapitalX, pCapitalY, pCapitalID)
		end
	end
end

function PositionCalculator(i1, i2)
	return HexToWorld(ToHexFromGrid(Vector2(i1, i2)))
end

Events.SerialEventCityDestroyed.Add(Finisher_BonusOnRaze)
