-- [horisontal split] ---------------------------------------------------------
vis:command_register("hTmuxSplit", function()
	vis:command("!tmux split-window -h vis")
end, "tmux split horisontally")

-- [vertical split] -----------------------------------------------------------
vis:command_register("vTmuxSplit", function()
	vis:command("!tmux split-window -v vis")
end, "tmux split horisontally")
