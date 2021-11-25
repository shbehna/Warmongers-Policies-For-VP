local ePolicyConsulates = GameInfoTypes.POLICY_CONSULATES
local ePolicyScholastiscism = GameInfoTypes.POLICY_SCHOLASTICISM
local ePromotionAdvisor = GameInfoTypes.PROMOTION_WMP_MILITARY_ADVISOR
local eMerchant = GameInfoTypes.SPECIALIST_MERCHANT
local eScientist = GameInfoTypes.SPECIALIST_SCIENTIST
local eWriter = GameInfoTypes.SPECIALIST_WRITER
local eArtist = GameInfoTypes.SPECIALIST_ARTIST
local eMusician = GameInfoTypes.SPECIALIST_MUSICIAN
local eEngineer = GameInfoTypes.SPECIALIST_ENGINEER
local eDiplomat = GameInfoTypes.SPECIALIST_CIVIL_SERVANT
local iGpGain = 3
local iCultureGpGain = 1

function Consulates_GrantXpAndGppWhenAtWarInCsTerritory(iPlayer)
    local pPlayer = Players[iPlayer]
    
    if not pPlayer:HasPolicy(ePolicyConsulates) then return end
    if not IsAtWar(pPlayer) then return end

    local iMerchantGain = 0
    local iScientistGain = 0
    local iWriterGain = 0
    local iArtistGain = 0
    local iMusicianGain = 0
    local iEngineerGain = 0
    local iDiplomatGain = 0
    local pCapital = pPlayer:GetCapitalCity()

    for pUnit in pPlayer:Units() do 
        if pUnit:IsHasPromotion(ePromotionAdvisor) and pUnit:GetPlot():GetOwner() > -1 and pUnit:GetBaseCombatStrength() > 0 then
            local pPlotOwner = Players[pUnit:GetPlot():GetOwner()]
            if pPlotOwner:IsMinorCiv() then
                if pPlotOwner:GetMinorCivTrait() == MinorCivTraitTypes.MINOR_CIV_TRAIT_MILITARISTIC then
                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eScientist, iGpGain * 100)
                    iScientistGain = iScientistGain + iGpGain
                end

                if pPlotOwner:GetMinorCivTrait() == MinorCivTraitTypes.MINOR_CIV_TRAIT_MERCANTILE then
                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eDiplomat, iGpGain * 100)
                    iDiplomatGain = iDiplomatGain + iGpGain
                end

                if pPlotOwner:GetMinorCivTrait() == MinorCivTraitTypes.MINOR_CIV_TRAIT_RELIGIOUS then
                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eEngineer, iGpGain * 100)
                    iEngineerGain = iEngineerGain + iGpGain
                end

                if pPlotOwner:GetMinorCivTrait() == MinorCivTraitTypes.MINOR_CIV_TRAIT_MARITIME then
                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eMerchant, iGpGain * 100)
                    iMerchantGain = iMerchantGain + iGpGain
                end

                if pPlotOwner:GetMinorCivTrait() == MinorCivTraitTypes.MINOR_CIV_TRAIT_CULTURED then
                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eArtist, iCultureGpGain * 100)
                    iArtistGain = iArtistGain + iCultureGpGain

                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eMusician, iCultureGpGain * 100)
                    iMusicianGain = iMusicianGain + iCultureGpGain

                    pCapital:ChangeSpecialistGreatPersonProgressTimes100(eWriter, iCultureGpGain * 100)
                    iWriterGain = iWriterGain + iCultureGpGain
                end
            end
        end
    end

    if iPlayer == Game:GetActivePlayer() and (iMerchantGain + iEngineerGain + iScientistGain + iDiplomatGain + iWriterGain + iArtistGain + iMusicianGain) > 0 then
        local msg = 'This turn, your military advisors have earned the following from their work in City-State territory : \n'
        
        if iMerchantGain > 0 then
            msg = msg .. iMerchantGain .. " [ICON_GREAT_MERCHANT] Great Merchant points\n"
        end
        if iEngineerGain > 0 then
            msg = msg .. iEngineerGain .. " [ICON_GREAT_ENGINEER] Great Engineer points\n"
        end
        if iScientistGain > 0 then
            msg = msg .. iScientistGain .. " [ICON_GREAT_SCIENTIST] Great Scientist points\n"
        end
        if iWriterGain > 0 then
            msg = msg .. iWriterGain .. " [ICON_GREAT_WRITER] Great Writer points\n"
        end
        if iArtistGain > 0 then
            msg = msg .. iArtistGain .. " [ICON_GREAT_ARTIST] Great Artist points\n"
        end
        if iMusicianGain > 0 then
            msg = msg .. iMusicianGain .. " [ICON_GREAT_MUSICIAN] Great Musician points\n"
        end
        if iDiplomatGain > 0 then
            msg = msg .. iDiplomatGain .. " [ICON_GREAT_DIPLOMAT] Great Diplomat points\n"
        end

        if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
            pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD, 
                msg, 
                'Military advisors', 
                pCapital:Plot():GetX(), 
                pCapital:Plot():GetY())
        end
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

GameEvents.PlayerDoTurn.Add(Consulates_GrantXpAndGppWhenAtWarInCsTerritory)

function Scholastiscism_OnLiberateGainCultureAndScience(iPlayer, iOtherPlayer, iCity)
    local pPlayer = Players[iPlayer]
    
	if pPlayer:HasPolicy(ePolicyScholastiscism) then
        local iCities = pPlayer:GetNumCities()
        
		local iGain = 10 * (pPlayer:GetCurrentEra() + 1) * iCities
        pPlayer:ChangeJONSCulture(iGain)
        pPlayer:ChangeOverflowResearch(iGain)
        if pPlayer:IsHuman() then
            local pCapital = pPlayer:GetCapitalCity()
            pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD, 
                "City states reward you for liberating them. You gained " .. iGain .. " [ICON_CULTURE] Culture and " .. iGain .. " [ICON_RESEARCH] Science.",
                "Liberation !", 
                pCapital:Plot():GetX(), 
                pCapital:Plot():GetY())
		end
	end
end

GameEvents.PlayerLiberated.Add(Scholastiscism_OnLiberateGainCultureAndScience)