--[[
CREDITS:
AndrewLemons for the original OSM files
https://github.com/AndrewLemons/RobloxOSM
xanHR for instructions and modifications

]]

--/INSTRUCTIONS/--

--/HOW TO USE/--
--[[
First things first, load up an empty baseplate (baseplate required) and put this script in ServerScriptService, then create a folder called "Modules" and add the rest of the scripts:

!WARNING!
!All scripts inside the "Modules" scripts must be ModuleScripts and for the Renderer a normal script!
---
-> HexColors.lua,
-> OverpassAPI.lua,
-> PartDisplaySystem.lua,
-> Stylesheet.lua
---
!Make sure they have the same name as provided here!

Now, publish the place to roblox (doesn't have to be public) and enable "Allow HTTPS requests" and "Enable Studio Access to API Services" in the game settings.


--/LOAD RANGE/--

loadRange = 0.001 --> 100m
loadRange = 0.002 --> 200m
loadRange = 0.01 --> 1km
loadRange = 0.02 --> 2km
loadRange = 0.1 --> 10km

!I wouldn't recommend rendering more than 4 kilometers as the game might start to lag!
!Rendering also requires strong internet connection!

-> lat --> latitude of the coordinates
-> lon --> longitude of the coordinates

To find coordinates of a certain location, either use www.latlong.net (recommended) or Google Maps.

If I want to render let's say 1km of New York, where the center is the Times Square I will enter the following:
]]
local loadRange = .01
local lat = 40.757938075134014
local lon = -73.98542458930599
--[[

To start rendering, make sure that the game is in "Run Mode (F8)", not "Play Mode(F5)"


Once the game finished rendering, you will open Explorer and you will use the search to select all roads:
To select roads, click on the search and type "material=Concrete" or "material=Brick" for houses
Select maximum of 1000~1500 parts for copy paste.
Your game might lag while selecting the parts (Absolutely do not press Ctrl+A and make sure to select parts from the Explorer only!) and once it unlags copy it using CTRL+C, now paste it into your main game (It will lag, be patient and don't close any of the windows), once you've pasted those parts, save your main game (Would recommend you backup your main game first) and delete the parts in the render game and repeat the proccess.

When you've finished copy pasting the roads will probably be in the sky and not the floor, in that case, find a part that's on the floor, copy paste it's Y Position value, open Explorer, click on search and type in "Position.Y~=(your custom Y position here without brackets) material=Concrete", once you've located those parts again select max 1000 parts and set their Y position to the floor. Also, if there are some parts that are like in the void, just delete them, they are useless.

Just a small warning, convert the roads and houses into Parts otherwise there will be too much Unions and the game might not publish. You can use the plugins such as Reclass:

https://elttob.itch.io/reclass or https://devforum.roblox.com/t/reclass-free-intelligent-class-conversion/402382

Once you are done, you can close the render game and save your main game.

For any questions, DM me on DC: xanHR
---
]]

--This script is not required to be put in game
script:Destroy()
