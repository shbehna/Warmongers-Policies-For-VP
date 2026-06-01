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

-- Grant 25 XP to the unit that conquers a city 
function OnCityConqueredAddXP(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
    print("OnCityConqueredAddXP called. bConquest:", bConquest)
    if not bConquest then return end
    local pPlayer = Players[iNewOwner]
    if not pPlayer or not pPlayer:IsAlive() then
        print("Invalid or dead player:", iNewOwner)
        return
    end
    if not pPlayer:HasPolicy(GameInfoTypes.POLICY_MILITARY_TRADITION) then
        print("Player does not have policy.")
        return
    end

    -- Find the unit at the conquered city location
    local pPlot = Map.GetPlot(iX, iY)
    if pPlot then
        local pUnit = pPlot:GetUnit(0) -- Get the first unit on the plot
        if pUnit and pUnit:GetOwner() == iNewOwner and pUnit:IsCombatUnit() then
            pUnit:ChangeExperience(math.floor(25 * fGameSpeedModifier2), -1, 1)
            print("Added 25 XP to conquering unit ID:", pUnit:GetID())
        else
            print("No valid conquering unit found at the city location")
        end
    end
end

GameEvents.CityCaptureComplete.Add(OnCityConqueredAddXP)

function OnPolicyAdoptedDiscipline(playerID, policyID)
    if policyID ~= GameInfoTypes.POLICY_DISCIPLINE then return end
    local pPlayer = Players[playerID]
    if not pPlayer or not pPlayer:IsAlive() then return end

    local totalCost = 0
    for pUnit in pPlayer:Units() do
        local unitType = pUnit:GetUnitType()
        local unitInfo = GameInfo.Units[unitType]
        if unitInfo and unitInfo.Cost then
            totalCost = totalCost + unitInfo.Cost
        end
    end

    local reward = math.floor(totalCost * 0.1)
    if reward > 0 then
        pPlayer:ChangeJONSCulture(reward)
        pPlayer:ChangeOverflowResearch(reward)
        if playerID == Game.GetActivePlayer() then
            pPlayer:AddNotification(0,
				'You have Gained '..reward..' [ICON_RESEARCH] Science and '..reward..' [ICON_CULTURE] Culture for the units already produced by your civilization.',
				'Bonus Yields',
				iPlotX, iPlotY)
        end
        print(string.format("Warrior Code adopted: %d culture and %d science granted to player %d", reward, reward, playerID))
    end
end

GameEvents.PlayerAdoptPolicy.Add(OnPolicyAdoptedDiscipline)