-- [create file interactively] ------------------------------------------------

-- [input functions] ----------------------------------------------------------
local function getFileName()
	local _, out, _ = vis:pipe(nil, nil, "vis-menu -p 'Enter filename: '", false)
	local input = out and out:gsub("%s+$", "") or ""
	if input ~= "" then
		return input
	end
	return ""
end
local function getOption()
	local _, out, _ = vis:pipe(nil, nil, "vis-menu -p 'Enter viewing option: '", false)
	local input = out and out:gsub("%s+$", "") or ""
	if input ~= "" then
		return input
	end
	return ""
end

-- [register command and open files] ------------------------------------------
vis:command_register("CreateFile", function()
	local filename = getFileName()
	local options = getOption()
	if options ~= "" and filename ~= "" then
		local pntr = io.open(filename, "a")
		if pntr then
			io.close(pntr)
		end
		if options == "s" then
			vis:command("split " .. filename)
		elseif options == "v" then
			vis:command("vsplit " .. filename)
		elseif options == "e" then
			vis:command("e  " .. filename)
		end
	end
end, "create file and open it in viewing option")
vis:map(vis.modes.NORMAL, " c",":CreateFile<Enter>", "create file interactively")
