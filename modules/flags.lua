local module = CreateFrame("Frame")
module:Hide()

local flagCoords, last = {}

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

		local coords = flagCoords[i]
		if(not coords) then
			coords = Coordinator:CreateTarget("Flag", flagX, flagY)
			flagCoords[i] = coords
		else
			coords.x, coords.y = flagX, flagY
			if(i > last) then
				coords:Enable()
			end
		end

		if(flagToken ~= coords.flagToken) then
			coords.flagToken = flagToken
			if(flagToken == "AllianceFlag") then
				coords.r, coords.g, coords.b = 0.5, 0.5, 1
			elseif(flagToken == "HordeFlag") then
				coords.r, coords.g, coords.b = 1, 0.5, 0.5
			else
				coords.r, coords.g, coords.b = 1, 1, 1
			end
			coords:Init()
		end

		i = i+1
		flagX, flagY, flagToken = GetBattlefieldFlagPosition(i)
	end
	i = i-1

	if(last and last > i) then
		for j=i+1, last do
			flagCoords[j]:Disable()
		end
	end
	last = i
end)