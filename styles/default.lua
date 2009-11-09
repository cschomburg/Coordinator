Coordinator:RegisterStyle("Default", {
	Create = function()
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
	end,

	Init = function(ind, coord)
		ind.name:SetText(coord.name)
		ind:SetAlpha(coord.alpha or 0.8)

		local r,g,b = coord.r or 0.8, coord.g or 0.8, coord.b or 1
		ind.dist:SetTextColor(r, g, b)
		ind.name:SetTextColor(r, g, b)
		ind.tex:SetVertexColor(r, g, b)
		ind:Show()
	end,

	Update = function(ind, screenX, screenY, dDist)
		local scale = 0.8+0.7*max((300-dDist)/300, 0)
		ind.dist:SetFormattedText("%.1f", dDist)
		ind:ClearAllPoints()
		ind:SetPoint("CENTER", WorldFrame, "CENTER", screenX/scale, screenY/scale)
		ind:SetScale(scale)
	end,
})