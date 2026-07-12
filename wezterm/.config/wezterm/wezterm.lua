local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- ── Appearance ──────────────────────────────────────────────────────────────
config.color_scheme = "rose-pine-moon"
-- config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- ── Leader key (CTRL+A — same as tmux prefix) ──────────────────────────────
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- ── Keybindings ─────────────────────────────────────────────────────────────
config.keys = {
	-- Reload config  (prefix + r)
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },

	-- Split panes
	-- prefix + s  →  split-window -v  (new pane below, horizontal divider)
	{ key = "s", mods = "LEADER", action = act.SplitPane({ direction = "Down" }) },
	-- prefix + v  →  split-window -h  (new pane to right, vertical divider)
	{ key = "v", mods = "LEADER", action = act.SplitPane({ direction = "Right" }) },

	-- Close current pane  (prefix + e — tmux kills all-but-current; here closes current)
	{ key = "e", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	-- Toggle pane zoom  (prefix + z — same as tmux prefix+z)
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- Navigate panes vim-style  (prefix + h/j/k/l)
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- Resize panes  (prefix + arrow, 5 units — same as tmux)
	{ key = "UpArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "LeftArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- New tab  (prefix + c  ≈  tmux new-window)
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

	-- Rename tab  (prefix + ,  — same as tmux prefix+,)
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Rename tab:",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Fuzzy launcher  (prefix + f  ≈  tmux-sessionizer)
	{ key = "f", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|TABS" }) },

	-- Swap tabs  (CTRL+SHIFT+Left/Right — no prefix, same as tmux)
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },

	-- ── macOS standard bindings (matching alacritty) ─────────────────────────

	-- Cmd+K: send \f (form-feed/Ctrl-L) then clear scrollback
	{
		key = "k",
		mods = "CMD",
		action = act.Multiple({
			act.SendString("\x0c"),
			act.ClearScrollback("ScrollbackAndViewport"),
		}),
	},

	-- Font size
	{ key = "0", mods = "CMD", action = act.ResetFontSize },
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "+", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },

	-- Clipboard
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },

	-- Window management
	{ key = "h", mods = "CMD", action = act.HideApplication },
	{ key = "m", mods = "CMD", action = act.Hide },
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "n", mods = "CMD", action = act.SpawnWindow },
	{ key = "f", mods = "CMD|CTRL", action = act.ToggleFullScreen },

	-- Search  (Cmd+F forward, Cmd+B backward — matching alacritty)
	{ key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "b", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },

	-- Alt+J → send ESC+j  (matches alacritty chars = "\u001Bj")
	{ key = "j", mods = "OPT", action = act.SendString("\x1bj") },
}

return config
