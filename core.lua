local LC = LibStub("LibCamera-1.0")

local Coordinator = CreateFrame("Frame", "Coordinator", UIParent)
Coordinator:SetAlpha(0.8)

local coords, indicators = {}, {}

local TargetCoordinate = {}
TargetCoordinate.__index = TargetCoordinate

local function createIndicator()
	local ind = CreateFrame("Frame", nil, UIParent)
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
	return ind
end

local function rotate(x, y, angle)
	return x*cos(angle) - y*sin(angle), y*cos(angle) + x*sin(angle)
end

function Coordinator:CreateTarget(name, x, y, z)
	local coord = {x=x, y=y, z=(z or 0), name=name}
	coords[coord] = true
	return setmetatable(coord, TargetCoordinate)
end

local function removeIndicator(coord)
	if(coord.ind) then
		local ind = coord.ind
		coord.ind = nil
		ind:Hide()
		indicators[#indicators+1] = ind
	end
end

local function updateIndicator(coord, dPitch, dYaw, dDist)
	if(not coord.ind) then
		coord.ind = tremove(indicators) or createIndicator()
		coord.ind.name:SetText(coord.name)
		coord.ind:SetAlpha(coord.alpha)
		coord.ind.dist:SetTextColor(coord.r, coord.g, coord.b)
		coord.ind.name:SetTextColor(coord.r, coord.g, coord.b)
		coord.ind.tex:SetVertexColor(coord.r, coord.g, coord.b)
		coord.ind:Show()
	end

	local screenX = tan(dYaw) * WorldFrame:GetWidth()
	local screenY = tan(dPitch) * WorldFrame:GetWidth()
	local scale = 0.8+0.7*max((300-dDist)/300, 0)

	coord.ind.dist:SetFormattedText("%.1f", dDist)
	coord.ind:ClearAllPoints()
	coord.ind:SetPoint("CENTER", UIParent, "CENTER", screenX/scale, screenY/scale)
	coord.ind:SetScale(scale)
end

local plrInd

function Coordinator:Update()
	local plrX, plrY = GetPlayerMapPosition("player")
	local plrZ = 0

	local camPitch, camYaw, camDist = LC.GetCameraPosition()
	camPitch, camYaw = deg(camPitch), deg(camYaw)

	local camX, camY, camZ = 0, camDist, 0
	camY, camZ = rotate(camY, camZ, camPitch)
	camX, camY = rotate(camX, camY, -camYaw)
	
	local uiSize = UIParent:GetWidth()/UIParent:GetScale()/2

	for coord in pairs(coords) do
		local dX, dY, dZ = self:ToYards(coord.x-plrX, coord.y-plrY, coord.z-plrZ)
		if(dX) then
			dX, dY, dZ = dX-camX, dY-camY, dZ-camZ
			local dPlaneDist = (dX^2+dY^2)^0.5
			local dDist = (dX^2+dY^2+dZ^2)^0.5

			local dYaw = -atan(dX/dY) + camYaw
			if(dY > 0) then dYaw = dYaw+180 end
			if(dYaw > 180) then dYaw = dYaw-360 end

			local dPitch = atan(dZ/dPlaneDist) + camPitch

			if(abs(dYaw) > 90) then
				removeIndicator(coord)
			else
				updateIndicator(coord, dPitch, dYaw, dDist)
			end
		else
			removeIndicator(coord)
		end
	end
end

LC.RegisterCallback(Coordinator, "LibCamera_Update", Coordinator.Update, Coordinator)
Coordinator:SetScript("OnUpdate", Coordinator.Update)

function TargetCoordinate:Enable()
	coords[self] = true
end

function TargetCoordinate:Disable()
	coords[self] = nil
	removeIndicator(self)
end

function TargetCoordinate:SetColor(r,g,b)
	self.r, self.g, self.b = r,g,b
	local ind = self.ind
	if(not ind) then return end

	ind.dist:SetTextColor(self.r, self.g, self.b)
	ind.name:SetTextColor(self.r, self.g, self.b)
	ind.tex:SetVertexColor(self.r, self.g, self.b)
end

function TargetCoordinate:SetName(name)
	self.name = name
	if(not self.ind) then return end
	ind.name:SetText(name)
end

function TargetCoordinate:SetAlpha(alpha)
	self.alpha = alpha
	if(not self.ind) then return end
	ind:SetAlpha(self.alpha)
end

TargetCoordinate.r = 0.8
TargetCoordinate.g = 0.8
TargetCoordinate.b = 1
TargetCoordinate.alpha = 0.8