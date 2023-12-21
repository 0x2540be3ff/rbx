--[[
v0.7.1 BETA
Made by xanHR

Added:
Minor value change
Sound distance
Optimized code a little (52 lines less)
Separate ModuleScript for configuration

Next update:
Optimize the entire code (min version)
Initialize sound reaction
Visual reaction, will use raycasting
]]
local w = game.Workspace


-------------------------------------------------------------------

local c = require(w.config) -- Make sure you add a ModuleScript in the Workspace

-------------------------------------------------------------------


local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local updatePos = ReplicatedStorage:FindFirstChild("updatePos")
local path = PathfindingService:CreatePath()
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local go_to
local waypoints -- = {}
local nextWaypointIndex
local reachedConnection
local blockedConnection
local reach = 2
local escape = 0
local hide = 0
local shoot = 0
local lastDestination = nil
local r = 0
function getMagnitude(player, position)
	local playerCharacter = player
	if playerCharacter then
		local playerPosition = position
		local magnitude = (character.HumanoidRootPart.Position - position).Magnitude
		return magnitude
	end
end
function setRandomPath()
	local seed = math.random(1,20)
	if c.AIDifficulty >= seed then
		if hide == 0 then
			if escape == 0 then
				go_to = c.esc_table[math.random(#c.esc_table)]
				escape = 1
			end
		end
	else
		if escape == 0 then
			if hide == 0 then
				go_to = c.h_table[math.random(#c.h_table)]
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
				if reached and nextWaypointIndex < #waypoints then
	
					nextWaypointIndex += 1
					reach = 1
					humanoid:MoveTo(waypoints[nextWaypointIndex].Position)	
				else
					reach = 1
					task.wait(math.random(c.AIWaitTime[1], c.AIWaitTime[2]))
					lastDestination = r
					wander(shoot)
				end
			end)
		end
		
		nextWaypointIndex = 2
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
	else
		warn("Path not computed!", errorMessage)
	end
end
function rerollTablePick()
	local x = c.w_table[math.random(#c.w_table)]
	return x
end
function wander(x)
	task.wait()
	if x == 0 then
		if reach == 1 or reach == 2 then
			if lastDestination == r then
				r = rerollTablePick()
				wander(shoot)
			else
				print(r)
				followPath(r)
				reach = 0
			end
		end
	end
end
function soundDistance(x)
	for i = 1, #c.s_table do
		if x < c.s_table[i] then
			return i - 1
		end
	end
	return #c.s_table
end
function a(plr, pos)
	local magnitude = getMagnitude(plr, pos)
	if magnitude < 360 then
		shoot = 1
		if reach == 1 or reach == 2 then
			setRandomPath()
			reach = 0
			humanoid.WalkSpeed = c.AISpeed
			followPath(go_to)
		end
	end
end
updatePos.OnServerEvent:Connect(function(plr, pos)
	a(plr, pos)
end)
function init()
	r = rerollTablePick()
	wander(shoot)
end
init()
