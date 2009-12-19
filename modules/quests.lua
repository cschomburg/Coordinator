local module = CreateFrame("Frame")

local target

module:SetScript("OnUpdate", function()
	local questID = WorldMapQuestScrollChildFrame.selected and WorldMapQuestScrollChildFrame.selected.questId
	if(not questID) then return target and Coordinator.DisableOverlay(target) end

	local _, posX, posY= QuestPOIGetIconInfo(questID)
	if(not posX or not posY) then return target and Coordinator.DisableOverlay(target) end

	if(not target) then
		target = Coordinator.DisplayCoordinate("Quest", posX, posY)
	else
		Coordinator.EnableOverlay(target)
		target.x, target.y = posX, posY
	end
end)