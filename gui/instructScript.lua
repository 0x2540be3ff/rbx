--/Simple LUA gui animation/--
-- TODO: fix the shitty code
local instruct = {
	"Press LSHIFT to run.",
	"Press 2 to equip your pistol.",
	"Press E to interact.",
	"Press U to view your objective.",
	"Press RMOUSE to aim.",
	"Press T to unzoom/zoom your sight.",
	"Press N to hide instructions."
	
}
local outPos = UDim2.new(0.422, 0,0.957, 0)
local inPos = UDim2.new(0.422, 0,0.987, 0)
local f = "infoFrame"
local t = "infoLabel"
local w_t = 3


---------------------------------------------------------------------------------------------------------


local TweenService = game:GetService("TweenService")
local pointer = 1
local frame = script.Parent:WaitForChild(f)
local frame_t = frame:WaitForChild(t)
frame_t.TextTransparency = 1
local tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(1)
function outInstruct(w)
	local tween = TweenService:Create(frame, tweenInfo, {Position = outPos})
	local tween2 = TweenService:Create(frame_t, tweenInfo2, {TextTransparency = 0})
	local tween3 = TweenService:Create(frame_t, tweenInfo2, {TextTransparency = 1})
	frame_t.Text = instruct[pointer]
	tween:Play()
	tween2:Play()
	wait(w)
	tween3:Play()
	wait(1)
	frame.Position = inPos
	pointer += 1
	print(pointer)
end

wait(5)
outInstruct(w_t)
