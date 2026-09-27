-- [state] --------------------------------------------------------------------
local isRunning = false

-- [typst start preview] ------------------------------------------------------
local function startPreview()
	vis:communicate("tinymist", "tinymist preview " .. vis.win.file.path)
	vis:info("srarted tinymist preview")
	isRunning = true
end

-- [typst stop preview] -------------------------------------------------------
local function stopPreview()
	vis:command("!pkill tinymist")
	vis:info("stopped tinymist preview")
	isRunning = false
end

-- [typst toggle preview] -----------------------------------------------------
local function togglePreview()
	if isRunning then
		stopPreview()
	else
		startPreview()
	end
end

-- [register commands] --------------------------------------------------------
vis:command_register("typstStartPreview", startPreview, "typst start preview")
vis:command_register("typstStopPreview", stopPreview, "typst stop preview")
vis:command_register("typstTogglePreview", togglePreview, "typst toggle preview")
