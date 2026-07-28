local ePolicyForeignService = GameInfoTypes.POLICY_PHILANTHROPY

local iBonusInfluence = 10

------------------------------------------------
-- Foreign Service (POLICY_PHILANTHROPY)
------------------------------------------------

-- Bonus Influence when gifting a unit to a City-State, on top of the
-- Influence the gift is normally worth.
function ForeignService_OnGiftUnitAddInfluence(eMajor, eMinor, iGold, eUnitType, iX, iY)
	if eUnitType == nil or eUnitType == -1 then return end

	local pMajorPlayer = Players[eMajor]
	if pMajorPlayer == nil or not pMajorPlayer:HasPolicy(ePolicyForeignService) then return end

	local pMinorPlayer = Players[eMinor]
	if pMinorPlayer == nil or not pMinorPlayer:IsMinorCiv() then return end

	pMinorPlayer:ChangeMinorCivFriendshipWithMajor(eMajor, iBonusInfluence)

	if pMajorPlayer:IsHuman() and pMajorPlayer:IsTurnActive() then
		pMajorPlayer:AddNotification(NotificationTypes.NOTIFICATION_MINOR,
			'Your Foreign Service earned you ' .. iBonusInfluence .. ' extra [ICON_INFLUENCE] Influence with ' .. pMinorPlayer:GetName() .. ' for gifting a Unit.',
			'Foreign Service',
			iX, iY)
	end
end

GameEvents.PlayerGifted.Add(ForeignService_OnGiftUnitAddInfluence)
