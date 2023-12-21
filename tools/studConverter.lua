--[[
studConverter.lua
Converts Meters into Studs
]]
--------------------------------
local v = 0 -- Enter your meters or studs here
local metersToStuds = true -- set to false if you want to convert studs into meters
local round = true --round the number
--------------------------------
local m = 3.571
function convert(x, y)
	if y == true then
		return x*m
	else
		return x/m
	end
end

if round == true then
	print(math.round(convert(v, metersToStuds)))
else
	print(convert(v, metersToStuds))
end
