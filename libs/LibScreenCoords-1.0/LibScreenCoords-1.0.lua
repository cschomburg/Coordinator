local lib = LibStub:NewLibrary("LibScreenCoords-1.0", 1)
if(not lib) then return end

local LC = LibStub("LibCamera-1.0")

local updater = CreateFrame("Frame", nil, UIParent)
updater:Hide()

local numActive = 0
local active, unused = {}, {}

local TargetCoordinate = {}
TargetCoordinate.__index = TargetCoordinate

function lib:Register(coord)
	if(active[coord]) then return end
	active[coord] = true

	numActive = numActive + 1
	if(numActive == 1) then
		updater:Show()
	end
end
function lib:Unregister(coord)
	if(not active[coord]) then return end
	active[coord] = nil
	numActive = numActive - 1
	if(numActive == 0) then
		updater:Hide()
	end
end

local function update()
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
		local dX, dY, dZ = coord:GetDistanceInYards()
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

			coord:UpdateScreenCoord(cY < 0, screenX, screenY, (cX^2 + cY^2 + cZ^2)^0.5)
		else
			coord:UpdateScreenCoord()
		end
	end
end

LC.RegisterCallback(lib, "LibCamera_Update", function() end)
updater:SetScript("OnUpdate", update)

-- Everyone needs a test gnome, mine is in thousand needles
--Coordinator:CreateTarget("Gnome", 0.81729340553284, 0.76272523403168)