local w = game.Workspace
local w_table = {
	
}
--[[
TODO:
fix the shitty followPath() function
add customizable tables for easier editing
add wander() function -> test it
add waypoints table
add a stop function so the npc stops moving when in wander mode (incase the shoot function gets called)
optimize code maybe??

also if you want it to work you'll need to add this in your acs in the Shoot() function:

RS.updateSoundReactor:FireServer(char:FindFirstChild("HumanoidRootPart").Position)

add it one line before this in every if statement:
Evt.Atirar:FireServer(WeaponTool,Suppressor,FlashHider)
]]
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")

local path = PathfindingService:CreatePath()

local character = script.Parent
local AIDifficulty = 10
local humanoid = character:WaitForChild("Humanoid")
local part = game.Workspace.Part
local part2 = game.Workspace.Part2
local TEST_DESTINATION
local updateSound = game.Workspace.updateSound
local waypoints -- = {}
local nextWaypointIndex
local reachedConnection
local blockedConnection
local reach = 2
local escape = 0
local hide = 0
function moveChance()
	local seedMove = math.random(1,20)
	print(AIDifficulty, seedMove)
	if AIDifficulty >= seedMove then
		TEST_DESTINATION = part2.Position
	else
		TEST_DESTINATION = part.Position
	end
end
function setRandomPath()
	local seed = math.random(1,20)
	print(AIDifficulty, seed)
	if AIDifficulty >= seed then
		if hide == 0 then
			TEST_DESTINATION = part2.Position
			escape = 1
		end
	else
		if escape == 0 then
			TEST_DESTINATION = part.Position
			hide = 1
		end
	end
end
setRandomPath()

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
--[[
function wander()
	followPath(w_table[math.random(#w_table)])
	wait(math.random(10,30))
end
]]
function onTouched(hit)
	--print(hit.Parent)
	if not hit or not hit.Parent then return end
	local human = hit.Parent:findFirstChild("Humanoid")
	local root = hit.Parent:findFirstChild("HumanoidRootPart")
	if human and human:IsA("Humanoid") then
		print(root.Position)
		if getMagnitude(root.Position) < 360 then
			if reach == 1 then
				setRandomPath()
				reach = 0
				humanoid.WalkSpeed = 24
				followPath(TEST_DESTINATION)
			elseif reach == 2 then
				setRandomPath()
				reach = 0
				humanoid.WalkSpeed = 24
				followPath(TEST_DESTINATION)
			end
		end
		tpBack()
	end
end
updateSound.Touched:connect(onTouched)
