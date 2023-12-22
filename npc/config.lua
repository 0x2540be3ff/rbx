--ModuleScript
local w = game.Workspace
local config = {}

--Quick note: The parts in the tables are just a demo, make sure you add your own parts with their own name like this: w.PART_NAME.Position

config.AIDifficulty = 10
config.AISpeed = 16
config.fakeDeath = true
config.visualReaction = true
config.soundReaction = true
config.AIWaitTime = {5, 10} --how long the NPC waits until it moves to another part (min, max)
config.VisualReactionDistance = 256
config.VisualReactionTime = 0.2

config.w_table = { -- wander_parts
	w.wander.Position,
	w.wander1.Position
}
config.h_table = { --hide_parts
	w.hide.Position
}
config.esc_table = { --escape_parts
	w.exit.Position
}
config.s_table = { -- sound_distance
	360,
	720,
	1080,
	1440,
	1880	
}
return config
