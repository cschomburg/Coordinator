local LC = LibStub("LibCoordinator-1.0")

local Cube =  {}

function Cube.CreateOverlay(x, y, z, xW, yW, zW)
	local cube = setmetatable({}, Cube)

	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y-yW, z-zW, x+xW, y-yW, z-zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y+yW, z-zW, x+xW, y+yW, z-zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y-yW, z-zW, x-xW, y+yW, z-zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x+xW, y-yW, z-zW, x+xW, y+yW, z-zW))

	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y-yW, z+zW, x+xW, y-yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y+yW, z+zW, x+xW, y+yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y-yW, z+zW, x-xW, y+yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x+xW, y-yW, z+zW, x+xW, y+yW, z+zW))

	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y-yW, z-zW, x-xW, y-yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x-xW, y+yW, z-zW, x-xW, y+yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x+xW, y-yW, z-zW, x+xW, y-yW, z+zW))
	tinsert(cube, Coordinator.CreateOverlay("Line", x+xW, y+yW, z-zW, x+xW, y+yW, z+zW))
end

function Cube:Enable()
	for i=1, #self do
		self[i]:Enable()
	end
end

function Cube:Disable()
	for i=1, #self do
		self[i]:Disable()
	end
end

LC.RegisterType("Cube", Cube)