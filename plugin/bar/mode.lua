local M = {}

---Return active key table mode as a user friendly name
---@param window table
---@return string
M.get_mode = function(window)
    local key_table = window:active_key_table()
    if key_table == nil or not key_table:find("_mode$") then
        return "normal_mode"
    end
    return key_table
end

M.get_foreground_color = function(mode, palette)
    if mode == "normal_mode" then
        return palette.ansi[5]
    end
    return palette.ansi[2]
end

M.get_foreground = function(mode, palette, utilities, options)
    if mode == "normal_mode" then
        return {
            Foreground = {
                Color = palette.ansi[5]
            }
        }
    end

    return {
        Foreground = {
            Color = palette.ansi[2]
        }
    }

end

M.get_background = function(mode, palette, utilities, options)
end

M.get_text = function(mode, palette, utilities, options)
    local text = mode:gsub("_mode", "")
    text = text:upper()

    return {
        Text = options.modules.mode.icon .. utilities._space(text, options.separator.space)
    }
end

return M
