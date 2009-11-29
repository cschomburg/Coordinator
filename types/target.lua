local LC = LibStub("LibCoordinator-1.0")

local Target = {}
local unused = {}

Target.__index = Target
Target.Enable = LC.EnableOverlay
Target.Disable = LC.DisableOverlay
Target.singleCoordinate = true

function Target.CreateOverlay(arg1, x, y, z)
	return setmetatable(type(arg1) == table and arg1 or {x=x, y=y, z=(z or 0), name=arg1}, Target)
end

function Target:GetIndicator()
	if(self.ind) then return self.ind end

	local ind = tremove(unused)
	if(not ind) then
		ind = CreateFrame("Frame", nil, UIParent)
		ind:SetWidth(50)
		ind:SetHeight(50)

		local tex = ind:CreateTexture(nil, "BACKGROUND")
		tex:SetAlpha(0.5)
		tex:SetAllPoints()
		tex:SetTexture([[Interface\AddOns\Coordinator\hud]])

		local dist = ind:CreateFontString(nil, "BACKGROUND", "ChatFontSmall")
		dist:SetPoint("CENTER", 0, -3)

		local name = ind:CreateFontString(nil, "BACKGROUND", "ChatFontSmall")
		name:SetPoint("RIGHT", ind, "TOPLEFT", 0, 0)

		ind.tex, ind.dist, ind.name = tex, dist, name
	end

	ind.name:SetText(self.name)
	ind:SetAlpha(self.alpha or 0.8)

	local r,g,b = self.r or 0.8, self.g or 0.8, self.b or 1
	ind.dist:SetTextColor(r, g, b)
	ind.name:SetTextColor(r, g, b)
	ind.tex:SetVertexColor(r, g, b)
	ind:Show()

	self.ind = ind
	return ind
end

function Target:RemoveIndicator()
	local ind = self.ind
	if(not ind) then return end

	self.ind = nil
	ind:Hide()
	tinsert(unused, ind)
end
Target.OnDisable = Target.RemoveIndicator

function Target:UpdatePosition()
	if(not (self.x and self.y and self.z)) then return self:RemoveIndicator() end

	local dX, dY, dZ = LC.ToYards(self.relative, self.x, self.y, self.z)
	if(not (dX and dY and dZ)) then return self:RemoveIndicator() end

	local visible, screenX, screenY, distance = LC.WorldToScreen(dX, dY, dZ)

	if(not visible) then return self:RemoveIndicator() end

	local ind = self:GetIndicator()

	local scale = 0.8+0.7*max((300-distance)/300, 0)
	ind.dist:SetFormattedText("%.1f", distance)
	ind:ClearAllPoints()
	ind:SetPoint("CENTER", WorldFrame, "CENTER", screenX/scale, screenY/scale)
	ind:SetScale(scale)
end

LC.RegisterType("Target", Target)