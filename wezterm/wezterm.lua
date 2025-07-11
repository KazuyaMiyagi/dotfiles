local wezterm = require "wezterm"

wezterm.on("update-right-status", function(window, pane)
    calendar = string.format(
        " %s %s ",
        wezterm.nerdfonts.fa_calendar,
        wezterm.strftime("%Y-%m-%d(%A)")
    )
    clock = string.format(
        " %s %s ",
        wezterm.nerdfonts.fa_clock_o,
        wezterm.strftime("%H:%M:%S")
    )
    hostname = string.format(" %s ", wezterm.hostname())
    if window:leader_is_active() then
        leader_text = " Leader|  active "
        leader_background_color = "Lime"
    else
        leader_text = " Leader|inactive "
        leader_background_color = "Navy"
    end
    window:set_right_status(wezterm.format({
        {Text=calendar},
        {Text="|"},
        {Text=clock},
        {Foreground={AnsiColor="White"}},
        {Background={AnsiColor="Grey"}},
        {Text=hostname},
        'ResetAttributes',
        {Foreground={AnsiColor="Black"}},
        {Background={AnsiColor=leader_background_color}},
        {Text=leader_text},
        'ResetAttributes',
    }))
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local tab_width = 25
    text = wezterm.pad_right(wezterm.truncate_right(tab.active_pane.title, tab_width), tab_width)
    return {
        { Text = text },
    }
end)

wezterm.on('window-resized', function(window, pane)
    local overrides = {}

    if window:get_dimensions().is_full_screen then
        overrides.text_background_opacity = 1
        overrides.window_background_opacity = 1
    else
        overrides.text_background_opacity = 0.75
        overrides.window_background_opacity = 0.75
    end

    window:set_config_overrides(overrides)
end)

return {
    enable_scroll_bar = true,

    initial_cols = 160,
    initial_rows = 48,

    font_size = 18,
    font = wezterm.font_with_fallback({
        "Hack Nerd Font",
        { family = "Hiragino Kaku Gothic Pro", weight = "Light" },
    }),
    adjust_window_size_when_changing_font_size = false,

    color_scheme = "gruvbox",
    window_frame = {
        font = wezterm.font({ family = "Hack Nerd Font", weight = 'Bold' }),
        font_size = 18,
        active_titlebar_bg = '#333333',
        inactive_titlebar_bg = '#333333',
    },

    default_cursor_style = "BlinkingBlock",
    cursor_blink_rate = 800,

    use_fancy_tab_bar = true,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = false,

    visual_bell = {
        target = 'BackgroundColor',
        fade_in_function = 'EaseIn',
        fade_in_duration_ms = 100,
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 100,
    },
    colors = {
        visual_bell = 'grey',
    },

    leader = { key = "z", mods = "CTRL", timeout_milliseconds = 1000 },
    keys = {
        { key = "z", mods = "LEADER|CTRL", action = wezterm.action.SendKey { key = "z", mods = "CTRL" }},
        { key = "z", mods = "LEADER",      action = wezterm.action.SendKey { key = "z", mods = "CTRL" }},

        { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

        { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
        { key = "c", mods = "LEADER", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
        { key = "s", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
        { key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },

        { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Left" },
        { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Down" },
        { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Up" },
        { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection "Right" },
    },
}
