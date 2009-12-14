local module = CreateFrame("Frame")
module:Hide()

local flagTargets, last = {}

module:SetScript("OnEvent", function(self)
	if(select(2, IsInInstance()) == "pvp") then
		module:Show()
	else
		module:Hide()
	end
end)
module:RegisterEvent("PLAYER_ENTERING_WORLD")

module:SetScript("OnUpdate", function(self)
	local i=1
	local flagX, flagY, flagToken = GetBattlefieldFlagPosition(i)
	while(flagX and flagX ~= 0) do

		local target = flagTargets[i]
		if(not target) then
			target = Coordinator.DisplayCoordinate("Flag", flagX, flagY)
			flagTargets[i] = target
		else
			target.x, target.y = flagX, flagY
			if(i > last) then
				Coordinator.EnableOverlay(target)
			end
		end

		if(flagToken == "AllianceFlag") then
			target.r, target.g, target.b = 0.5, 0.5, 1
		elseif(flagToken == "HordeFlag") then
			target.r, target.g, target.b = 1, 0.5, 0.5
		else
			target.r, target.g, target.b = 1, 1, 1
		end

		i = i+1
		flagX, flagY, flagToken = GetBattlefieldFlagPosition(i)
	end
	i = i-1

	if(last and last > i) then
		for j=i+1, last do
			Coordinator.DisableOverlay(flagTargets[j])
		end
	end
	last = i
end)