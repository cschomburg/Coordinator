local LSC = LibStub("LibScreenCoords-1.0")

local Coordinator = CreateFrame("Frame", "Coordinator", UIParent)
Coordinator:Hide()

local numActive = 0
local styles = {}
Coordinator.Styles = styles

local TargetCoordinate = {}
TargetCoordinate.__index = TargetCoordinate

local defaultStyle

function Coordinator:RegisterStyle(name, style)
	defaultStyle = defaultStyle or name
	styles[name] = style
	unused[name] = {}
end

local function removeIndicator(coord)
	local ind = coord.ind
	if(not ind) then return end
	coord.ind = nil
	ind:Hide()
	tinsert(unused[coord.style], ind)
end

function Coordinator:Update()
	local plrX, plrY = GetPlayerMapPosition("player")
	local plrZ = 0

	local camRoll, camPitch, camYaw, camDist = 0, LC.GetCameraPosition()
	camPitch, camYaw = deg(camPitch), deg(camYaw)

	-- If anyone knows why these need to be swapped ...
	local tmp = camRoll
	local camRoll, camPitch = camPitch, tmp

	-- Reducing CPU time as much as possible
	local sPitch, cPitch = sin(camPitch), cos(camPitch)
	local sRoll, cRoll = sin(camRoll), cos(camRoll)
	local sYaw, cYaw = sin(camYaw), cos(camYaw)

	-- Generating the camera coordinates relative to player, axes world
	local camX, camY, camZ = 0, camDist, 0
	camY, camZ = camY*cRoll - camZ*sRoll, camZ*cRoll + camY*sRoll
	camX, camY = camX*cYaw - camY*sYaw, camY*cYaw + camX*sYaw

	-- Blizz' viewer is by default 2 yards behind the screen, creating a field of view of 53°
	local eX, eY, eZ = 0, WorldFrame:GetHeight()/768*2, 0

	local factor = WorldFrame:GetHeight()/768

	for coord in pairs(active) do
		if(coord.x and coord.y and coord.z) then
			local dX, dY, dZ = self:ToYards(-coord.x+plrX, coord.y-plrY, coord.z-plrZ)
			if(dX and dY and dZ) then
				-- Relative to camera, axes still world
				dX, dY, dZ = dX-camX, dY-camY, dZ-camZ

				-- Rotate axes relative to camera - the Y-axis serves as the distance, going in the screen
				local cX = cPitch * (sYaw * dY + cYaw * dX) - sPitch * dZ
				local cY = sRoll * (cPitch * dZ + sPitch * (sYaw * dY + cYaw * dX)) + cRoll * (cYaw * dY - sYaw * dX)
				local cZ = cRoll * (cPitch * dZ + sPitch * (sYaw * dY + cYaw * dX)) - sRoll * (cYaw * dY - sYaw * dX)

				-- Now get the screen coordinates; screenY is the camera 3D Z-coordinate, remember?
				local screenX = (cX - eX) * (eY/cY)			* WorldFrame:GetWidth()*factor/2
				local screenY = (cZ - eZ) * (eY/cY)			* -WorldFrame:GetWidth()*factor/2

				if(cY > 0) then
					removeIndicator(coord)
				else
					local dDist = (cX^2 + cY^2 + cZ^2)^0.5
					local style = coord.style
					local styleTbl = styles[style]
					if(not coord.ind) then
						coord.ind = tremove(unused[style]) or styleTbl.Create()
						styleTbl.Init(coord.ind, coord)
					end
					styleTbl.Update(coord.ind, screenX, screenY, dDist)
				end
			else
				removeIndicator(coord)
			end
		else
			removeIndicator(coord)
		end
	end
end

LC.RegisterCallback(Coordinator, "LibCamera_Update", function() end, Coordinator)
Coordinator:SetScript("OnUpdate", Coordinator.Update)

-- Everyone needs a test gnome, mine is in thousand needles
--Coordinator:CreateTarget("Gnome", 0.81729340553284, 0.76272523403168)