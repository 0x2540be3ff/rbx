--/ROBLOX OSM Renderer | Renderer.lua/--
--[[
To get started:
Open readme.lua

]]
-----------------------------------------------------------------------
--lat = latitude, lon = longitude
local loadRange = .01
local lat = nil
local lon = nil

-- I recommend you don't touch this below!
local ratio = {
	3, -- y
	1.5 -- x
}
-----------------------------------------------------------------------
--[[

   _____ _______ ____  _____  _ 
  / ____|__   __/ __ \|  __ \| |
 | (___    | | | |  | | |__) | |
  \___ \   | | | |  | |  ___/| |
  ____) |  | | | |__| | |    |_|
 |_____/   |_|  \____/|_|    (_)
  
  !DO NOT TOUCH ANYTHING BELOW THIS LINE, YOU WILL BREAK THIS SCRIPT!
]]
-----------------------------------------------------------------------
local httpService = game:GetService("HttpService")
local sss = game:GetService("ServerScriptService")

local opapi = require(sss.Modules.OverpassAPI)
local partDisplay = require(sss.Modules.PartDisplaySystem)
local stylesheet = require(sss.Modules.Stylesheet)
local hex2rgb = require(sss.Modules.HexColors)

local minLat = lat - (loadRange/2)
local minLon = lon - (loadRange/2)
local maxLat = lat + (loadRange/2)
local maxLon = lon + (loadRange/2)

function addInstances()
	print("Adding instances...")
	local load_s = Instance.new("RemoteEvent")
	load_s.Name = "LoadingStatus"
	load_s.Parent = rs
	load_s.Archivable = true
	local node_t = Instance.new("Model")
	node_t.Name = "Nodes"
	node_t.Parent = game.Workspace
	node_t.Archivable = true
end
if manualAdd == false then
	addInstances()
else
	warn("manualAdd is enabled!")
end

print("Rendering started!")
game.ReplicatedStorage.LoadingStatus:FireAllClients(true, "Requesting map nodes...", 0)
local query = opapi.query("node("..minLat..","..minLon..","..maxLat..","..maxLon.."); out;")
--local query = game.Workspace.N.Value
local data = httpService:JSONDecode(query)
local nodes = data["elements"]
for index, node in pairs(nodes) do
	wait()
	local part = Instance.new("Part")
	part.Anchored = true
	part.Name = node.id
	part.Parent = game.Workspace.Nodes
	part.Material = Enum.Material.Neon
	part.Size = Vector3.new(1, .1, 1)

	local localLat = node.lat-lat
	local localLon = node.lon-lon

	part.CFrame = CFrame.new(localLat*111034*ratio[1], .05, localLon*111034*ratio[2])
	game.ReplicatedStorage.LoadingStatus:FireAllClients(true, "Node "..node.id, index/#nodes, part.Position)
end

game.ReplicatedStorage.LoadingStatus:FireAllClients(true, "Requesting map ways...", 0)
local query = opapi.query("way("..minLat..","..minLon..","..maxLat..","..maxLon.."); out;")
local data = httpService:JSONDecode(query)
local ways = data["elements"]
for index, way in pairs(ways) do
	local wayNodes = way.nodes
	local tags = way.tags or {empty = "Nothing"}

	game.ReplicatedStorage.LoadingStatus:FireAllClients(true, tags.name or way.id, index/#ways)
	local style = stylesheet.getStyle(tags)
	if tags["levels"] then
		print(tags.levels)
	end
	for iindex, node in pairs(wayNodes) do
		wait()
		local partA = game.Workspace.Nodes:FindFirstChild(node)
		local partB

		if iindex ~= #wayNodes then
			partB = game.Workspace.Nodes:FindFirstChild(wayNodes[iindex+1])
		else
			if style.loops then
				partB = game.Workspace.Nodes:FindFirstChild(wayNodes[1])
			else
				partB = game.Workspace.Nodes:FindFirstChild(wayNodes[iindex])
			end
		end
		local height = 1
		if tags["building:levels"] or tags["height"] then
			if tags["height"] then
				height = tags["height"]*2.5
			else
				height = tags["building:levels"]*7.5
			end
		else
			height = style.height
		end
		local line
		if partA and partB then
			line = partDisplay.makeLine(game.Workspace, partA.Position, partB.Position, height, style.width)
			line.Material = style.material
			if tags["building:colour"] then
				line.BrickColor = BrickColor.new(hex2rgb(string.gsub(tags["building:colour"], "#", "")))
			else
				line.BrickColor = style.color
			end
			line.Transparency = style.transparency

			game.ReplicatedStorage.LoadingStatus:FireAllClients(true, tags.name or way.id, index/#ways, partB.Position)
		end
	end
end

local oldNodes = game.Workspace.Nodes:GetChildren()

for index, node in pairs(oldNodes) do
	game.ReplicatedStorage.LoadingStatus:FireAllClients(true, "Removing nodes", index/#oldNodes)
	node:Destroy()
end

game.ReplicatedStorage.LoadingStatus:FireAllClients(false, "Done!", 1)
print("Done!")
