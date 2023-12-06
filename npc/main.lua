--[[
BETA_VERSION
Made by xanHR

Added:
Modifiable tables
AI Difficulty and NPC Speed
NPC modes: Wander, Hide and Escape (Run)
Shooting reaction

Next update:
Automatically add needed parts and scripts (manualAdd)
Sound distance
Visual reaction (maybe)
Optimized followPath() function
]]
local w = game.Workspace


-------------------------------------------------------------------


--local manualAdd = true
local AIDifficulty = 10 -- from 1 to 20
local AISpeed = 16 -- walkspeed


local w_table = { --wander mode
	w.ff.Position,
	w.ff2.Position,
	w.ff3.Position,
	w.ff4.Position,
	w.ff5.Position,
	w.ff6.Position,
	w.ff7.Position
}
local h_table = { -- hide mode
	w.hh.Position,
	w.hh2.Position
}
local esc_table = { --escape mode
	w.esc.Position
}


-------------------------------------------------------------------


local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

local path = PathfindingService:CreatePath()

local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local goto
local updateSound = game.Workspace.updateSound
local waypoints -- = {}
local nextWaypointIndex
local reachedConnection
local blockedConnection
local reach = 2
local escape = 0
local hide = 0
local shoot = 0
--[[
---DO NOT TOUCH---
if manualAdd == false then
	if not w:FindFirstChild("npcWorkspace")	then
		init_ws()
	else
		print("Folder exists!")
		manualAdd = true
	end
end

function init_ws()
	if manualAdd == false then
		local folder = Instance.new("Folder")
		folder.Parent = w
		folder.Name = "npcWorkspace"
		local spart = Instance.new("Part")
		spart.Transparency = 1
		spart.Position = Vector3.new(0,-1000,0)
		spart.Size = Vector3.new(4,4,4)
		spart.CanCollide = false
		spart.Anchored = true
		spart.Parent = folder
		updateSound = spart
	end
	
end

--unused function, will leave it here if I need it
function moveChance()
	local seedMove = math.random(1,20)
	--print(AIDifficulty, seedMove)
	if AIDifficulty >= seedMove then
		goto = esc_table[math.random(#esc_table)]
	else
		goto = h_table[math.random(#h_table)]
	end
end
]]
function setRandomPath()
	local seed = math.random(1,20)
	--print(AIDifficulty, seed)
	if AIDifficulty >= seed then
		if hide == 0 then
			if escape == 0 then
				goto = esc_table[math.random(#esc_table)]
				escape = 1
			end
		end
	else
		if escape == 0 then
			if hide == 0 then
				goto = h_table[math.random(#h_table)]
				hide = 1
			end
		end
	end
end


local function followPath(destination)
	local success, errorMessage = pcall(function()
		path:ComputeAsync(character.PrimaryPart.Position, destination)
	end)

	if success and path.Status == Enum.PathStatus.Success then
		waypoints = path:GetWaypoints()

		blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
			if blockedWaypointIndex >= nextWaypointIndex then
				blockedConnection:Disconnect()
				followPath(destination)
			end
		end)
		if not reachedConnection then
			reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
				if reached then
					nextWaypointIndex += 1
					reach = 1
				    humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
				end
			end)
		end
		nextWaypointIndex = 2
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
	else
		warn("Path not computed!", errorMessage)
	end
end
function tpBack()
	updateSound.Position = Vector3.new(0,-1000,0)
end
function getMagnitude(x)
	local magn = (character.HumanoidRootPart.Position-x).Magnitude
	return magn
end
function wander()
	if shoot == 0 then
		wait(math.random(5,10))
		followPath(w_table[math.random(#w_table)])
		--print(w_table[math.random(#w_table)])
	end
end

function onTouched(hit)
	if not hit or not hit.Parent then return end
	local human = hit.Parent:findFirstChild("Humanoid")
	local root = hit.Parent:findFirstChild("HumanoidRootPart")
	if human and human:IsA("Humanoid") then
		--print(root.Position)
		if getMagnitude(root.Position) < 360 then
			shoot = 1
			if reach == 1 then
				setRandomPath()
				reach = 0
				humanoid.WalkSpeed = AISpeed
				followPath(goto)
			elseif reach == 2 then
				setRandomPath()
				reach = 0
				humanoid.WalkSpeed = AISpeed
				followPath(goto)
			end
		end
		tpBack()
	end
end

updateSound.Touched:connect(onTouched)
while task.wait() do
	if shoot == 1 then
		--print("Break")
		break
	end
	--print("Task ran")
	wander()
end
