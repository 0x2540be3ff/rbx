--/ServerScriptService/--
-- also make sure there is a RemoteEvent called "updateSoundReactor" in the ReplicatedStorage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local updateSound = game.Workspace.updateSound --just create an invisible part preferably 4,4,4 in size
local remoteEvent = ReplicatedStorage:FindFirstChild("updateSoundReactor")

local function update(player, updateSoundPosition)
	updateSound.Position = updateSoundPosition
	updateSound.Parent = workspace
end

remoteEvent.OnServerEvent:Connect(update)
--ACS
--RS.updateSoundReactor:FireServer(char:FindFirstChild("HumanoidRootPart").Position)
