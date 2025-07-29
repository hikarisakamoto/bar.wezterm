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


M.get_mode_table= function(mode)
    
end
return M
