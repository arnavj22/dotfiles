local wezterm = require 'wezterm'

-- Define both theme sets
local color_schemes = {
  light = "Rosé Pine Dawn (base16)",
  dark = "Rosé Pine (base16)",
}

-- Define your window frame (title bar) colors for each mode
local window_frames = {
  light = {
    active_titlebar_bg = "#faf4ed",
    inactive_titlebar_bg = "#f2e9e1",
    active_titlebar_fg = "#575279",
    inactive_titlebar_fg = "#797593",
    button_fg = "#797593",
    button_bg = "#f2e9e1",
  },
  dark = {
    active_titlebar_bg = "#232136",
    inactive_titlebar_bg = "#2a273f",
    active_titlebar_fg = "#e0def4",
    inactive_titlebar_fg = "#908caa",
    button_fg = "#e0def4",
    button_bg = "#2a273f",
  }
}

wezterm.on('toggle-dark-light', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local is_light = (overrides.color_scheme or wezterm.config_builder().color_scheme) == color_schemes.light

  if is_light then
    -- Switch to dark
    overrides.color_scheme = color_schemes.dark
    overrides.window_background_opacity = 0.90
    overrides.macos_window_background_blur = 22
    overrides.window_frame = window_frames.dark
  else
    -- Switch to light
    overrides.color_scheme = color_schemes.light
    overrides.window_background_opacity = 0.82
    overrides.macos_window_background_blur = 16
    overrides.window_frame = window_frames.light
  end

  window:set_config_overrides(overrides)
end)

return {
  font = wezterm.font("JetBrains Mono", {weight="Regular"}),
  font_size = 13.0,
  line_height = 1.06,

  color_scheme = color_schemes.light,
  window_background_opacity = 0.82,
  macos_window_background_blur = 16,

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = true,
  window_decorations = "RESIZE",
  window_padding = { left = 14, right = 14, top = 8, bottom = 8 },

  default_cursor_style = "BlinkingBar",
  cursor_blink_rate = 700,
  check_for_updates = false,
  scrollback_lines = 8000,
  freetype_load_target = "Light",

  -- Set initial window frame (for light mode)
  window_frame = window_frames.light,

  keys = {
    { key = "t", mods = "CMD", action = wezterm.action{SpawnTab="CurrentPaneDomain"} },
    { key = "w", mods = "CMD", action = wezterm.action{CloseCurrentTab={confirm=true}} },
    { key = "LeftArrow", mods = "CMD", action = wezterm.action{ActivateTabRelative=-1} },
    { key = "RightArrow", mods = "CMD", action = wezterm.action{ActivateTabRelative=1} },
    { key = "LeftArrow",  mods = "CMD|OPT", action = wezterm.action{ActivatePaneDirection="Left"} },
    { key = "RightArrow", mods = "CMD|OPT", action = wezterm.action{ActivatePaneDirection="Right"} },
    { key = "UpArrow",    mods = "CMD|OPT", action = wezterm.action{ActivatePaneDirection="Up"} },
    { key = "DownArrow",  mods = "CMD|OPT", action = wezterm.action{ActivatePaneDirection="Down"} },
    { key = "L", mods = "CMD|SHIFT", action = wezterm.action.EmitEvent("toggle-dark-light") },
  },

  -- Optional: tweak the tab bar colors for light mode
  colors = {
    tab_bar = {
      background = "#f2e9e1",
      active_tab = { bg_color = "#fffaf3", fg_color = "#5a576e", intensity = "Bold" },
      inactive_tab = { bg_color = "#e5e3e0", fg_color = "#7e7896" },
      inactive_tab_hover = { bg_color = "#ecebf0", fg_color = "#5a576e", italic = true },
      new_tab = { bg_color = "#e5e3e0", fg_color = "#7e7896" },
      new_tab_hover = { bg_color = "#ecebf0", fg_color = "#5a576e", italic = true },
    }
  },
}
