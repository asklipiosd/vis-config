local comment_leaders = {
  lua = "--", sh = "#", bash = "#", python = "#", ruby = "#",
  makefile = "#", yaml = "#", toml = "#", awk = "#",
  c = "//", cpp = "//", java = "//", javascript = "//",
  typescript = "//", rust = "//", go = "//", css = "//",
  zig = "//", fish = "#"
}

local function comment_leader(win)
  return comment_leaders[win.syntax] or "//"
end

local function line_from_offset(file, offset)
  local prefix = file:content(0, offset) or ""
  local n = 1
  for _ in prefix:gmatch("\n") do n = n + 1 end
  return n
end

local function selection_lines(file, selection)
  local r = selection.range
  local line1 = line_from_offset(file, r.start)
  local last = r.finish - 1
  local line2 = (last > r.start) and line_from_offset(file, last) or line1
  local max = #file.lines
  if line1 < 1 then line1 = 1 end
  if line2 > max then line2 = max end
  if line2 < line1 then line2 = line1 end
  return line1, line2
end

--------------------------------------------------------------------------
-- Bannerate: turn line(s) into a padded comment banner
--------------------------------------------------------------------------
vis:command_register("Bannerate", function(argv, force, win, selection, range)
  local file = win.file
  local width = 79
  local cs = comment_leader(win)

  local line1, line2 = selection_lines(file, selection)

  for lnum = line1, line2 do
    local line = file.lines[lnum]
    local indent, text = line:match("^(%s*)(.-)%s*$")

    local existing = text:match("%[(.-)%]")
    if existing then
      text = existing
    else
      local cs_escaped = cs:gsub("(%W)", "%%%1")
      text = text:gsub("^" .. cs_escaped .. "%s*%-*%s*", "")
      text = text:gsub("%s*%-+%s*$", "")
    end

    local sep = (cs == "--") and "" or " --"
    local prefix = indent .. cs .. sep .. " [" .. text .. "] "
    file.lines[lnum] = prefix .. string.rep("-", math.max(0, width - #prefix))
  end

  return true
end, "Turn line(s) into a padded comment banner")

--------------------------------------------------------------------------
-- Unbannerate: reverse it
--------------------------------------------------------------------------
vis:command_register("Unbannerate", function(argv, force, win, selection, range)
  local file = win.file
  local cs = comment_leader(win)

  local line1, line2 = selection_lines(file, selection)

  for lnum = line1, line2 do
    local line = file.lines[lnum]
    local indent, text = line:match("^(%s*)(.-)%s*$")
    local label = text:match("%[(.-)%]")
    if label then
      file.lines[lnum] = indent .. cs .. " " .. label
    end
  end

  return true
end, "Strip a Bannerate banner back to a plain comment")
