local uCmd = "";
local function setCommand()
	local _, out, _ = vis:pipe(nil, nil, "vis-menu -p 'Enter something: '", false)
	local input = out and out:gsub("%s+$", "") or ""
	if input ~= "" then
		uCmd = input
	end
end

vis:command_register("ResetCmd", function()
	setCommand()
end, "reset command")
vis:command_register("ExecCmd", function()
	if uCmd ~= "" then
		vis:command("wa")
		vis:command("!" .. uCmd)
	else
		setCommand()
		vis:command("wa")
		vis:command("!" .. uCmd)
	end
end, "Execute command")
