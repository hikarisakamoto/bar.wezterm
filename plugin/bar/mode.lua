local wez = require "wezterm"

---@private
---@class bar.mode
local M = {}

---Return active key table mode as a user friendly name
---@param window table
---@return string
function M.get_mode(window)
  local key_table = window:active_key_table()
  if key_table == nil or not key_table:find "_mode$" then
    return "normal_mode"
  end
  return key_table
end

---Fetch icon for current mode
---@param mode string
---@param options bar.options
---@return string
local function get_icon(mode, options)
  return options.modules.mode.icons[mode] or options.modules.mode.icons.default
end

---Get foreground color for active mode
---@param mode string
---@param palette table
---@param options bar.options
---@return string
function M.get_foreground_color(mode, palette, options)
  local idx = options.modules.mode.colors[mode] or options.modules.mode.colors.default
  return palette.ansi[idx]
end

---Get background color for active mode
---@param mode string
---@param palette table
---@return string
function M.get_background_color(mode, palette)
  if mode == "normal_mode" then
    return palette.background or "transparent"
  end
  return palette.brights[8]
end

---Format text for active mode
---@param mode string
---@param options bar.options
---@return string
function M.get_text(mode, options)
  local text = mode:gsub("_mode", ""):upper()
  return get_icon(mode, options) .. " " .. text
end

---Insert formatted mode cells into status bar
---@param cells table
---@param window table
---@param palette table
---@param options bar.options
function M.apply(cells, window, palette, options)
  local active = M.get_mode(window)
  if #active == 0 then
    return
  end
  local bg = M.get_background_color(active, palette)
  local fg = M.get_foreground_color(active, palette, options)
  table.insert(cells, { Background = { Color = bg } })
  table.insert(cells, { Foreground = { Color = fg } })
  table.insert(cells, { Text = M.get_text(active, options) })
  table.insert(cells, { Background = { Color = palette.tab_bar.background } })
  table.insert(cells, { Text = string.rep(" ", options.separator.space) })
end

return M
