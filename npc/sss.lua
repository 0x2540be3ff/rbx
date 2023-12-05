--/ServerScriptService/--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local updateSound = game.Workspace.updateSound
local remoteEvent = ReplicatedStorage:FindFirstChild("updateSoundReactor")

local function update(player, updateSoundPosition)
	updateSound.Position = updateSoundPosition
	updateSound.Parent = workspace
end

remoteEvent.OnServerEvent:Connect(update)
