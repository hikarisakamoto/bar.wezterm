---@private
---@class bar.mode
local M = {}

---Return active key table mode as a user friendly name
---@param window table
---@return string
M.get_mode = function(window)
  if not window then
    return "normal_mode"
  end

  local present, key_table = pcall(window.active_key_table, window)
  if not present or key_table == nil or type(key_table) ~= "string" then
    return "normal_mode"
  end

  if key_table == nil or not key_table:find "_mode$" then
    return "normal_mode"
  end
  return key_table
end

---Fetch icon for current mode
---@param mode string
---@param options bar.options
---@return string
local function _get_icon(mode, options)
  if type(mode) ~= "string" or type(options) ~= "table" then
    return ""
  end

  return options.modules.mode.icons[mode] or options.modules.mode.icons.default
end

---Get foreground color for active mode
---@param mode string
---@param palette table
---@param options bar.options
---@return string
M.get_foreground_color = function(mode, palette, options)
  if type(mode) ~= "string" or type(palette) ~= "table" or type(options) ~= "table" then
    return "transparent"
  end

  local idx = options.modules.mode.colors[mode] or options.modules.mode.colors.default
  return (palette.ansi and palette.ansi[idx]) or palette.foreground or "transparent"
end

---Get background color for active mode
---@param mode string
---@param palette table
---@return string
M.get_background_color = function(mode, palette)
  if type(mode) ~= "string" or type(palette) ~= "table" then
    return "transparent"
  end

  return (palette.tab_bar and palette.tab_bar.background) or "transparent"
end

---Format text for active mode
---@param mode string
---@param options bar.options
---@return string
M.get_text = function(mode, options)
  if type(mode) ~= "string" or type(options) ~= "table" then
    return ""
  end

  local text = mode:gsub("_mode", ""):upper()
  local icon = _get_icon(mode, options)
  if #icon == 0 then
    return text
  end
  return icon .. " " .. text
end

---Insert formatted mode cells into status bar
---@param cells table
---@param window table
---@param palette table
---@param options bar.options
---@return nil
M.apply = function(cells, window, palette, options)
  if type(cells) ~= "table" or type(palette) ~= "table" or type(options) ~= "table" then
    return
  end

  local active = M.get_mode(window)
  if #active == 0 then
    return
  end

  local text = M.get_text(active, options)
  if #text == 0 then
    return
  end

  local bg = M.get_background_color(active, palette)
  local fg = M.get_foreground_color(active, palette, options)
  table.insert(cells, { Background = { Color = bg } })
  table.insert(cells, { Foreground = { Color = fg } })
  table.insert(cells, { Text = text })
  table.insert(cells, { Background = { Color = palette.tab_bar.background } })
  table.insert(cells, { Text = string.rep(" ", options.separator.space) })
end

return M
