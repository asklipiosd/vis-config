require("vis")

-- [on vis open] --------------------------------------------------------------
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set number', win)
end)

-- [plugins] ------------------------------------------------------------------
require("plugins/vis-command").Setup()
require("plugins/vis-commentary")()
require("plugins/vis-autoclose")
require("plugins/vis-colorizer")
require("plugins/bannerate")
require("plugins/execCmd")
require("plugins/createFile")
require("plugins/vis-tmux")
require("plugins/vis-typst-preview")
Lspc = require("plugins/vis-lspc")
Fzf = require("plugins/vis-fzf-open")

-- [fzf] ----------------------------------------------------------------------
vis.events.subscribe(vis.events.START, function()
    vis:command('set autoindent')
    if not vis.win.file.name then
	Fzf.fzf_args = "-q '!.class ' --preview 'bat {} --color=always --style=plain --theme=base16'"
		.. " --preview-border=sharp  --preview-window=up --no-separator --no-scrollbar --no-header"
        vis:command("fzf")
    end
end)
Fzf.fzf_args = "-q '!.class ' --height=40% --preview "
	.. "'bat {} --color=always --style=plain --theme=base16' --preview-border=sharp"
vis:map(vis.modes.NORMAL, " f", ":fzf<Enter>", "Fzf")

-- [LSP settings] -------------------------------------------------------------
Lspc.menu_cmd = 'vis-menu'
Lspc.highlight_diagnostics = 'line'

-- [bannerate] ----------------------------------------------------------------
vis:map(vis.modes.NORMAL, " g", ":Bannerate<Enter>", "Bannerate current line")
vis:map(vis.modes.VISUAL, " g", ":Bannerate<Enter>", "Bannerate selection")
vis:map(vis.modes.NORMAL, " G", ":Unbannerate<Enter>", "Unbannerate current line")
vis:map(vis.modes.VISUAL, " G", ":Unbannerate<Enter>", "Unbannerate selection")

-- [execCmd] ------------------------------------------------------------------
vis:map(vis.modes.NORMAL, " \\",":ExecCmd<Enter>", "execute command")
vis:map(vis.modes.NORMAL, " s",":ResetCmd<Enter>", "execute command")

-- [createFile] ---------------------------------------------------------------
vis:map(vis.modes.NORMAL, " c",":CreateFile<Enter>", "create file interactively")

-- [tmux] ---------------------------------------------------------------------
vis:map(vis.modes.NORMAL, " v",":vTmuxSplit<Enter>", "open vertical tmux split")
vis:map(vis.modes.NORMAL, " h",":hTmuxSplit<Enter>", "open horisontal tmux split")
