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

M.get_style = function(mode, palette, utilities, options)
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

return M
