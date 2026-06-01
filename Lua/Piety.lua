-- Grant faith and culture when a unit dies
function OnUnitPrekill(playerID, unitID, unitType, iX, iY, bDelay, eKiller)
    local pPlayer = Players[playerID]

    if not pPlayer or not pPlayer:IsAlive() then return end
    if not pPlayer:HasPolicy(GameInfoTypes.POLICY_THEOCRACY) then return end

    -- Only trigger if killed by another player
    if eKiller == -1 or eKiller == playerID then return end

    local pUnit = pPlayer:GetUnitByID(unitID)
    if not pUnit then return end
    if not pUnit:IsCombatUnit() then return end

    local level = pUnit:GetLevel()
    local iEraModifier = math.max(pPlayer:GetCurrentEra(), 1)

    local fGameSpeedModifierFaith = GameInfo.GameSpeeds[ Game.GetGameSpeedType() ].FaithPercent / 100
    local fGameSpeedModifierCulture = GameInfo.GameSpeeds[ Game.GetGameSpeedType() ].CulturePercent / 100

    local faithAmount = math.floor(level ^ math.pi * fGameSpeedModifierFaith)
    local cultureAmount = math.floor(level ^ math.pi * fGameSpeedModifierCulture)

    pPlayer:ChangeFaith(faithAmount)
    pPlayer:ChangeJONSCulture(cultureAmount)

    local pCapital = pPlayer:GetCapitalCity()
    local pCapitalX = pCapital:GetX()
    local pCapitalY = pCapital:GetY()
    local pCapitalID = pCapital:GetID()
    pPlayer:AddNotification(NotificationTypes.NOTIFICATION_INSTANT_YIELD,
        'They died as martyrs ! Gained: +'..faithAmount..' [ICON_FAITH] Faith, +'..cultureAmount..' [ICON_CULTURE] Culture',
        'They died as martyrs',
        pCapitalX, pCapitalY, pCapitalID)
end

GameEvents.UnitPrekill.Add(OnUnitPrekill)