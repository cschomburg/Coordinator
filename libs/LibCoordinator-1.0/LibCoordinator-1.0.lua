local lib = LibStub:NewLibrary("LibCoordinator-1.0", 1)
if(not lib) then return end

local LC = LibStub("LibCamera-1.0")

local updater = CreateFrame("Frame", nil, UIParent)
updater:Hide()

local types = {}
local defaultType
function lib.RegisterType(name, table)
	types[name] = table
	if(not defaultType and table.singleCoordinate) then
		lib.SetDefaultType(name)
	end
end

function lib.IsTypeRegistered(type) return types[type] and true or nil end
function lib.GetRegisteredTypes() return types end
function lib.SetDefaultType(name) defaultType = name end

local overlays, numActive = {}, 0
function lib.EnableOverlay(overlay)
	if(overlays[overlay]) then return end
	overlays[overlay] = true

	numActive = numActive + 1
	if(numActive == 1) then
		updater:Show()
	end

	if(overlay.OnEnable) then overlay:OnEnable() end
end

function lib.DisableOverlay(overlay)
	if(not overlays[overlay]) then return end
	overlays[overlay] = nil

	if(numActive == 0) then
		updater:Hide()
	end

	if(overlay.OnDisable) then overlay:OnDisable() end
end

function lib.CreateOverlay(type, ...)
	local overlay = types[type].CreateOverlay(...)
	lib.EnableOverlay(overlay)
	return overlay
end

function lib.DisplayCoordinate(...) return lib.CreateOverlay(defaultType, ...) end

local sPitch, cPitch, sRoll, cRoll, sYaw, cYaw
local camX, camY, camZ
local eX, eY, eZ
local factor

function lib.WorldToScreen(x, y, z)
	-- Relative to camera, axes still world
	local dX, dY, dZ = x-camX, y-camY, z-camZ

	-- Rotate axes relative to camera - the Y-axis serves as the distance, going in the screen
	local cX = cPitch * (sYaw * dY + cYaw * dX) - sPitch * dZ
	local cY = sRoll * (cPitch * dZ + sPitch * (sYaw * dY + cYaw * dX)) + cRoll * (cYaw * dY - sYaw * dX)
	local cZ = cRoll * (cPitch * dZ + sPitch * (sYaw * dY + cYaw * dX)) - sRoll * (cYaw * dY - sYaw * dX)

	-- Now get the screen coordinates; screenY is the camera 3D Z-coordinate, remember?
	local screenX = (cX - eX) * (eY/cY)			* WorldFrame:GetWidth()*factor/2
	local screenY = (cZ - eZ) * (eY/cY)			* -WorldFrame:GetWidth()*factor/2

	return cY < 0, screenX, screenY, (cX^2 + cY^2 + cZ^2)^0.5
end

-- quick'n'dirty hack to update LibCamera every update
LC.Events:OnUsed(LC, "LibCamera_Update")

updater:SetScript("OnUpdate", function()
	local camRoll, camPitch, camYaw, camDist = 0, LC.GetCameraPosition()
	local camPitch, camYaw = deg(camPitch), deg(camYaw)

	-- If anyone knows why these need to be swapped ...
	local tmp = camRoll
	camRoll, camPitch = camPitch, tmp

	-- Reducing CPU time as much as possible
	sPitch, cPitch = sin(camPitch), cos(camPitch)
	sRoll, cRoll = sin(camRoll), cos(camRoll)
	sYaw, cYaw = sin(camYaw), cos(camYaw)

	-- Generating the camera coordinates relative to player, axes world
	camX, camY, camZ = 0, camDist, 0
	camY, camZ = camY*cRoll - camZ*sRoll, camZ*cRoll + camY*sRoll
	camX, camY = camX*cYaw - camY*sYaw, camY*cYaw + camX*sYaw

	-- Blizz' viewer is by default 2 yards behind the screen, creating a field of view of 53°
	eX, eY, eZ = 0, WorldFrame:GetHeight()/768*2, 0

	factor = WorldFrame:GetHeight()/768

	for overlay in pairs(overlays) do
		overlay:UpdatePosition()
	end
end)

-- Everyone needs a test gnome, mine is in thousand needles
--Coordinator:CreateTarget("Gnome", 0.81729340553284, 0.76272523403168)