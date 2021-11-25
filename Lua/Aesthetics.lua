local eFineArtsPolicy = GameInfoTypes.POLICY_FINE_ARTS

-- Fine arts
function FineArts_OnGreatWorkCreated(playerID, unitID, greatWorkID)
    local pPlayer = Players[playerID]
    if not pPlayer:HasPolicy(eFineArtsPolicy) then return end
    if not IsAtWar(pPlayer) then return end

	local pCapital = pPlayer:GetCapitalCity()
    local pCapitalX, pCapitalY, pCapitalID = pCapital:GetX(), pCapital:GetY(), pCapital:GetID()	
    
    for pUnit in pPlayer:Units() do
        if pUnit:GetBaseCombatStrength() > 0 then 
            pUnit:ChangeExperience(1)
            pUnit:ChangeDamage(-5)
        end
    end

    if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
        pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
            'Units heal 5HP and gain XP',
            'Your army is inspired by the new great works !',
            pCapitalX, pCapitalY, pCapitalID)
    end
end

function IsAtWar(pPlayer)
    local iTeam = pPlayer:GetTeam()
    local pTeam = Teams[iTeam]
    local bIsAtWar = false
    for i = 0, GameDefines.MAX_CIV_PLAYERS - 1 do 
        if i ~= playerID then 
            local pOtherPlayer = Players[i]
            if pOtherPlayer:IsAlive() and not pOtherPlayer:IsBarbarian() and not pOtherPlayer:IsMinorCiv() then 
                local iOtherTeam = pOtherPlayer:GetTeam()
                if pTeam:IsAtWar(iOtherTeam) then
                    bIsAtWar = true
                    break 
                end
            end
        end
    end
    return bIsAtWar
end

GameEvents.GreatWorkCreated.Add(FineArts_OnGreatWorkCreated)