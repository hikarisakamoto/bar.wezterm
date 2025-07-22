local wez = require "wezterm"
local M = {}

---Return active key table mode as a user friendly name
---@param window table
---@return string
M.get_mode = function(window)
    local key_table = window:active_key_table()
    if key_table == nil or not key_table:find "_mode$" then
        return "normal_mode"
    end
    return key_table
end

M.get_foreground_color = function(mode, palette)
    if mode == "normal_mode" then
        return palette.ansi[5]
    elseif mode == "copy_mode" then
        return palette.ansi[7]
    elseif mode == "select_mode" then
        return palette.ansi[8]
    end
    return palette.ansi[2]
end

M.get_background_color = function(mode, palette)
    if mode == "normal_mode" then
        return palette.background or "transparent"
    end
    return palette.brights[8]
end

M.get_text = function(mode, utilities, options)
    local text = mode:gsub("_mode", "")
    text = text:upper()
    if mode == "normal_mode" then
        return wez.nerdfonts.cod_screen_normal .. " " .. text
    end
    if mode == "copy_mode" then
        return wez.nerdfonts.cod_copy .. " " .. text
    end
    if mode == "search_mode" then
        return wez.nerdfonts.cod_search .. " " .. text
    end
    return options.modules.mode.icon .. " " .. text
end

return M
