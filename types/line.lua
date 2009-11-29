local LC = LibStub("LibCoordinator-1.0")

local Line = {}
local unused = {}

Line.__index = Line
Line.Enable = LC.EnableOverlay
Line.Disable = LC.DisableOverlay

function Line.CreateOverlay(sX, sY, sZ, eX, eY, eZ)
	return setmetatable({sX=sX,sY=sY,sZ=sZ,eX=eX,eY=eY,eZ=eZ}, Line)
end

function Line:GetTexture()
	if(self.tex) then return self.tex end

	local tex = tremove(unused)
	if(not tex) then
		tex = UIParent:CreateTexture(nil, "BACKGROUND")
		tex:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Line")
	end

	tex:Show()

    self.tex = tex
	return tex
end

function Line:RemoveTexture()
	local tex = self.tex
	if(not tex) then return end

	self.tex = nil
	tex:Hide()
	tinsert(unused, tex)
end
Line.OnDisable = Line.RemoveTexture

function Line:UpdatePosition()
	local sX, sY, sZ = LC.ToYards(self.relative, self.sX, self.sY, self.sZ)
	local eX, eY, eZ = LC.ToYards(self.relative, self.eX, self.eY, self.eZ)

	if(not (sX and sY and sZ and eX and eY and eZ)) then return self:RemoveTexture() end

	local sV, sSX, sSY, sD = LC.WorldToScreen(sX, sY, sZ)
	local eV, eSX, eSY, eD = LC.WorldToScreen(eX, eY, eZ)

	if(not sV and not eV) then return self:RemoveTexture() end

	DrawRouteLine(self:GetTexture(), UIParent, sSX, sSY, eSX, eSY, 32, "CENTER")
end

LC.RegisterType("Line", Line)