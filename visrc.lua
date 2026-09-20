require("vis")

-- [on vis open] --------------------------------------------------------------
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set number', win)
end)

-- [plugins] ------------------------------------------------------------------
require("plugins/vis-command").Setup()
require("plugins/vis-autoclose")
require("plugins/vis-lspc")
require("plugins/bannerate")
require("plugins/vis-commentary")()
Fzf = require("plugins/vis-fzf-open")

-- [Fzf] ----------------------------------------------------------------------
Fzf.fzf_args = "-q '!.class ' --height=40% --preview 'bat {} --color=always --style=plain --theme=base16 '"
vis.events.subscribe(vis.events.START, function()
    if not vis.win.file.name then
        vis:command("Fzf")
    end
end)

-- [bannerate] ----------------------------------------------------------------
vis:map(vis.modes.NORMAL, " f", ":fzf<Enter>", "Fzf")
vis:map(vis.modes.NORMAL, " g", ":Bannerate<Enter>", "Bannerate current line")
vis:map(vis.modes.VISUAL, " g", ":Bannerate<Enter>", "Bannerate selection")
vis:map(vis.modes.NORMAL, " G", ":Unbannerate<Enter>", "Unbannerate current line")
vis:map(vis.modes.VISUAL, " G", ":Unbannerate<Enter>", "Unbannerate selection")
