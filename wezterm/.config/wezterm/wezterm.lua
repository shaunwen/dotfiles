local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- ── Appearance ──────────────────────────────────────────────────────────────
-- config.color_scheme = "rose-pine-moon"
config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0
config.window_background_opacity = 1
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- ── Leader key (CTRL+s — same as tmux prefix) ──────────────────────────────
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

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

	-- Toggle herdr mode  (CTRL+SHIFT+H — suspends the Ctrl+A leader so it passes through to herdr)
	{ key = "h", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-herdr-mode") },

	-- ── macOS standard bindings (matching alacritty) ─────────────────────────

	-- Cmd+K: send Ctrl-L into the pane so the shell/app actually clears
	-- (updating herdr's own state), then fake a focus-out/focus-in cycle so
	-- herdr (which only does a full repaint on focus-gained) redraws cleanly.
	{
		key = "k",
		mods = "CMD",
		action = act.Multiple({
			act.SendString("\x0c"),
			act.SendString("\x1b[O"),
			act.SendString("\x1b[I"),
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

-- ── Herdr mode toggle ───────────────────────────────────────────────────────
-- CTRL+SHIFT+H suspends the Ctrl+A leader for the current window so keystrokes
-- pass through to herdr uninterrupted.  Press again to restore it.
wezterm.on("toggle-herdr-mode", function(window, _pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.leader then
		-- Enter herdr mode: replace leader with an unreachable chord
		overrides.leader = { key = "F13", mods = "CTRL|SHIFT|ALT", timeout_milliseconds = 1 }
		window:set_config_overrides(overrides)
		window:set_right_status(wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Yellow" } },
			{ Text = "  HERDR  " },
		}))
	else
		-- Exit herdr mode: drop the override so the config-file leader comes back
		overrides.leader = nil
		window:set_config_overrides(overrides)
		window:set_right_status("")
	end
end)

return config
