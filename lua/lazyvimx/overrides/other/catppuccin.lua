local blend = require("lazyvimx.util.general").color_blend

local colors_get = function(flavor)
	return require("catppuccin.palettes").get_palette(flavor)
end

---@type CtpHighlightOverrideFn
local override_all = function(c)
	return {
		AerialLine = { fg = c.none, bg = c.crust },
		AvantePromptInputBorder = { link = "FloatBorder" },
		AvanteSidebarWinHorizontalSeparator = { fg = c.surface1 },
		AvanteSidebarWinSeparator = { link = "WinSeparator" },
		BlinkCmpDoc = { bg = c.mantle, blend = 15 },
		BlinkCmpDocBorder = { link = "BlinkCmpDoc" },
		BlinkCmpDocSeparator = { fg = blend(c.mantle, c.text, 10) },
		BufferLineCustomGroupLabel = { bg = c.mantle, fg = c.text, style = { "bold" } },
		BufferLineCustomGroupSep = { bg = c.mantle, fg = c.maroon },
		ChatGPTQuestion = { fg = c.mauve },
		ChatGPTTotalTokens = { bg = c.none, fg = c.overlay2 },
		ChatGPTTotalTokensBorder = { fg = c.text },
		DiffviewDiffAdd = { bg = blend(c.green, c.base, 93) },
		DiffviewDiffDelete = { bg = blend(c.red, c.base, 93) },
		DiffviewNormal = { bg = c.mantle },
		DiffviewWinSeparator = { link = "NeoTreeWinSeparator" },
		EdgyNormal = { link = "NormalFloat" },
		EdgyTitle = { bg = c.none, fg = c.text },
		FlashBackdrop = { fg = blend(c.base, c.blue, 35) },
		FlashPrompt = { bg = blend(c.base, c.crust, 65) },
		FlashPromptSep = { fg = blend(c.crust, c.text, 50) },
		FloatBorder = { bg = c.base },
		FloatTitle = { bg = c.base, fg = c.lavender, style = { "bold" } },
		Folded = { bg = c.base, fg = c.surface2 },
		GitConflictCurrent = { bg = blend(c.blue, c.base, 90) },
		GitConflictCurrentLabel = { bg = blend(c.blue, c.base, 85) },
		GitConflictIncoming = { bg = blend(c.green, c.base, 90) },
		GitConflictIncomingLabel = { bg = blend(c.green, c.base, 85) },
		GitSignsAdd = { fg = blend(c.green, c.base, 50) },
		GitSignsAddInline = { bg = blend(c.green, c.base, 83) },
		GitSignsAddPreview = { bg = blend(c.green, c.base, 93) },
		GitSignsChange = { fg = blend(c.yellow, c.base, 50) },
		GitSignsDelete = { fg = blend(c.red, c.base, 50) },
		GitSignsDeleteInline = { bg = blend(c.red, c.base, 83) },
		GitSignsDeletePreview = { bg = blend(c.red, c.base, 93) },
		GitSignsStagedAdd = { fg = blend(c.green, c.base, 50 - 10) },
		GitSignsStagedAddNr = { link = "GitSignsStagedAdd" },
		GitSignsStagedChange = { fg = blend(c.yellow, c.base, 50 - 10) },
		GitSignsStagedChangedelete = { link = "GitSignsStagedChange" },
		GitSignsStagedChangedeleteNr = { link = "GitSignsStagedChange" },
		GitSignsStagedChangeNr = { link = "GitSignsStagedChange" },
		GitSignsStagedDelete = { fg = blend(c.red, c.base, 50 - 10) },
		GitSignsStagedDeleteNr = { link = "GitSignsStagedDelete" },
		GlanceBorderTop = { bg = c.base, fg = blend(c.base, c.lavender, 30) },
		GlanceFoldIcon = { link = "FoldColumn" },
		GlanceListBorderBottom = { link = "GlanceBorderTop" },
		GlanceListNormal = { bg = blend(c.base, c.crust, 15), fg = c.subtext0 },
		GlancePreviewBorderBottom = { link = "GlanceBorderTop" },
		GlancePreviewNormal = { bg = blend(c.base, c.crust, 30) },
		GlanceWinBarFilename = { link = "GlanceWinBarTitle" },
		GlanceWinBarFilepath = { link = "GlanceWinBarTitle" },
		GlanceWinBarTitle = { fg = c.overlay0, bg = blend(c.base, c.crust, 50), style = { "bold" } },
		LazyReasonKeys = { fg = c.overlay0 },
		LineNr = { fg = c.surface2 },
		LspInlayHint = { bg = c.none },
		MiniIconsAzure = { fg = blend(c.sapphire, c.mantle, 25) },
		MiniIconsBlue = { fg = blend(c.blue, c.mantle, 25) },
		MiniIconsCyan = { fg = blend(c.teal, c.mantle, 25) },
		MiniIconsGreen = { fg = blend(c.green, c.mantle, 25) },
		MiniIconsGrey = { fg = blend(c.text, c.mantle, 25) },
		MiniIconsOrange = { fg = blend(c.peach, c.mantle, 25) },
		MiniIconsPurple = { fg = blend(c.mauve, c.mantle, 25) },
		MiniIconsRed = { fg = blend(c.red, c.mantle, 25) },
		MiniIconsYellow = { fg = blend(c.yellow, c.mantle, 25) },
		NeoTreeCursorLine = { bg = c.crust },
		NeoTreeDotfile = { fg = c.overlay0 },
		NeoTreeFadeText1 = { fg = c.surface1 },
		NeoTreeFadeText2 = { fg = c.surface2 },
		NeoTreeFileStats = { fg = c.surface1 },
		NeoTreeFileStatsHeader = { fg = c.surface2 },
		NeoTreeFloatBorder = { bg = c.mantle },
		NeoTreeFloatNormal = { bg = c.mantle },
		NeoTreeFloatTitle = { bg = c.mantle, fg = c.lavender, style = { "bold" } },
		NeoTreeMessage = { fg = c.surface1 },
		NeoTreeModified = { fg = c.peach },
		NeoTreeNormalActive = { bg = blend(c.mantle, c.crust, 50) },
		NeoTreeRootName = { fg = c.green },
		NeoTreeTabActive = { fg = c.text, bg = blend(c.base, c.text, 10) },
		NeoTreeTabSeparatorActive = { bg = c.base, fg = c.base },
		NeoTreeWinSeparator = { bg = c.base, fg = c.base },
		NoiceCmdline = { bg = c.mantle },
		NoiceCmdlinePopupBorder = { link = "FloatBorder" },
		NoiceFormatEvent = { fg = c.overlay1 },
		NoiceFormatKind = { fg = c.overlay0 },
		NoiceLspProgressTitle = { fg = c.overlay0 },
		NoicePopup = { link = "NormalFloat" },
		NoicePopupmenuSelected = { link = "Visual" },
		NoiceScrollbar = { link = "NormalFloat" },
		NoiceScrollbarThumb = { bg = blend(c.base, c.surface0, 50) },
		NormalFloat = { bg = c.base },
		Pmenu = { bg = blend(c.crust, c.base, 50), blend = 15 },
		PmenuSbar = { bg = blend(c.crust, c.surface2, 30) },
		PmenuSel = { bg = blend(c.crust, c.surface2, 50) },
		PmenuThumb = { bg = blend(c.crust, c.surface2, 40) },
		SnacksDashboardBorder = { fg = blend(c.base, c.surface1, 50) },
		SnacksDashboardDesc = { fg = c.text },
		SnacksDashboardFooter = { fg = c.surface1, style = {} },
		SnacksDashboardHeader1 = { fg = c.surface2 },
		SnacksDashboardHeader2 = { fg = blend(c.base, c.blue, 5) },
		SnacksDashboardHeader3 = { fg = blend(c.base, c.sky, 5) },
		SnacksDashboardHeader4 = { fg = blend(c.base, c.green, 5) },
		SnacksDashboardHeader5 = { fg = blend(c.base, c.yellow, 5) },
		SnacksDashboardHeader6 = { fg = blend(c.base, c.peach, 5) },
		SnacksDashboardHeader7 = { fg = blend(c.base, c.red, 5) },
		SnacksDashboardHeader8 = { fg = c.surface2 },
		SnacksDashboardIcon = { fg = c.yellow },
		SnacksDashboardKey = { bg = blend(c.base, c.crust, 15), fg = c.peach },
		SnacksDashboardKeyBorder = { bg = blend(c.base, c.crust, 15), fg = blend(c.base, c.surface1, 50) },
		SnacksDashboardSpecial = { fg = blend(c.base, c.mauve, 50), style = { "bold" } },
		SnacksIndent = { fg = blend(c.base, c.text, 5) },
		SnacksIndentScope = { fg = blend(c.base, c.text, 15) },
		SnacksNotifierBorderDebug = { fg = blend(c.base, c.peach, 30) },
		SnacksNotifierBorderError = { fg = blend(c.base, c.red, 30) },
		SnacksNotifierBorderInfo = { fg = blend(c.base, c.blue, 30) },
		SnacksNotifierBorderTrace = { fg = blend(c.base, c.rosewater, 30) },
		SnacksNotifierBorderWarn = { fg = blend(c.base, c.yellow, 30) },
		SnacksPickerInputCursorLine = { bg = c.base },
		SnacksStatusColumnMark = { fg = c.mauve, style = { "bold" } },
		StatusLine = { bg = blend(c.base, c.mantle, 50) },
		SymbolUsageDef = { fg = c.red },
		SymbolUsageImpl = { fg = c.yellow },
		SymbolUsageRef = { fg = c.blue },
		TabLineFill = { bg = c.mantle },
		TinyInlineDiagnosticVirtualTextArrow = { link = "CursorLine" },
		TinyInlineDiagnosticVirtualTextError = { fg = c.red },
		TinyInlineDiagnosticVirtualTextHint = { fg = c.teal },
		TinyInlineDiagnosticVirtualTextInfo = { fg = c.sky },
		TinyInlineDiagnosticVirtualTextWarn = { fg = c.yellow },
		TinyInlineInvDiagnosticVirtualTextError = { link = "CursorLine" },
		TinyInlineInvDiagnosticVirtualTextHint = { link = "CursorLine" },
		TinyInlineInvDiagnosticVirtualTextInfo = { link = "CursorLine" },
		TinyInlineInvDiagnosticVirtualTextWarn = { link = "CursorLine" },
		TreesitterContext = { bg = c.base, blend = 10 },
		TreesitterContextBottom = { fg = c.surface2, blend = 0 },
		TreesitterContextLineNumber = { link = "LineNr" },
		TroubleCount = { bg = c.none },
		TroubleIndent = { fg = blend(c.base, c.text, 15) },
		TroubleNormal = { link = "NormalFloat" },
		Visual = { style = {} },
		Whitespace = { fg = c.base },
		WinSeparator = { fg = blend(c.base, c.crust, 40) },
		ZenBg = { bg = c.mantle },
	}
end

---@type CtpHighlightOverrideFn
local override_dark = function(c)
	return {
		AerialGuide = { fg = c.surface0 },
		FloatBorder = { fg = blend(c.base, c.lavender, 50) },
		GitSignsCurrentLineBlame = { fg = c.surface2 },
		IlluminatedWordRead = { bg = blend(c.base, c.surface2, 25) },
		IlluminatedWordText = { bg = blend(c.base, c.sapphire, 25) },
		IlluminatedWordWrite = { bg = blend(c.base, c.sapphire, 25) },
		NeoTreeFloatBorder = { fg = blend(c.base, c.lavender, 50) },
		NeoTreeIndentMarker = { fg = c.base },
		ScrollView = { bg = c.surface0, blend = 15 },
		SnacksPickerInputBorder = { fg = blend(c.base, c.lavender, 25) },
		SymbolUsageContent = { fg = c.surface2 },
		TinyInlineDiagnosticVirtualTextError = { bg = blend(c.base, c.red, 20) },
		TinyInlineDiagnosticVirtualTextHint = { bg = blend(c.base, c.teal, 20) },
		TinyInlineDiagnosticVirtualTextInfo = { bg = blend(c.base, c.sky, 20) },
		TinyInlineDiagnosticVirtualTextWarn = { bg = blend(c.base, c.yellow, 20) },
		TreewalkerIlluminate = { bg = blend(c.base, c.surface2, 15) },
		Visual = { bg = blend(c.base, c.surface2, 30), style = {} },
		VisualWhitespace = { bg = blend(c.base, c.surface2, 30), fg = c.surface2 },
	}
end

---@type CtpHighlightOverrideFn
local override_light = function(c)
	return {
		AerialGuide = { fg = c.crust },
		FloatBorder = { fg = blend(c.base, c.text, 20) },
		GitSignsCurrentLineBlame = { fg = c.surface0 },
		IlluminatedWordRead = { bg = blend(c.base, c.surface2, 20) },
		IlluminatedWordText = { bg = blend(c.base, c.sapphire, 10) },
		IlluminatedWordWrite = { bg = blend(c.base, c.sapphire, 10) },
		NeoTreeFloatBorder = { fg = blend(c.base, c.text, 20) },
		NeoTreeIndentMarker = { fg = c.surface0 },
		SnacksPickerInputBorder = { fg = blend(c.base, c.text, 15) },
		SymbolUsageContent = { fg = c.surface0 },
		TinyInlineDiagnosticVirtualTextError = { bg = blend(c.base, c.red, 10) },
		TinyInlineDiagnosticVirtualTextHint = { bg = blend(c.base, c.teal, 10) },
		TinyInlineDiagnosticVirtualTextInfo = { bg = blend(c.base, c.sky, 10) },
		TinyInlineDiagnosticVirtualTextWarn = { bg = blend(c.base, c.yellow, 10) },
		TreewalkerIlluminate = { bg = blend(c.base, c.mantle, 85) },
		Visual = { bg = blend(c.base, c.crust, 85) },
		VisualWhitespace = { bg = blend(c.base, c.crust, 85), fg = c.surface2 },
	}
end

---@type CtpHighlightOverrideFn
local override_bufferline_hls = function(c)
	local hls = {
		background = { bg = c.mantle },
		buffer_visible = { fg = c.subtext0 },
		close_button = { bg = c.bg_dark },
		duplicate_visible = { bg = c.base },
		fill = { bg = c.mantle },
		modified = { bg = c.mantle },
		modified_visible = { fg = c.peach },
		offset_separator = { bg = c.mantle },
		pick = { bg = c.mantle },
		separator = { fg = c.mantle },
		tab_selected = { fg = c.text, style = { "bold" } },
		tab_separator = { bg = c.mantle, fg = c.mantle },
		tab_separator_selected = { bg = c.base, fg = c.base },
		trunc_marker = { bg = c.mantle },
	}

	-- stylua: ignore start
	local items = {
		"buffer", "close_button", "diagnostic", "error", "error_diagnostic",
		"hint", "info_diagnostic", "info_diagnostic", "indicator", "info", "info_diagnostic",
		"modified", "numbers", "pick", "warning", "warning_diagnostic",
	}
	-- stylua: ignore end

	for _, item in ipairs(items) do
		local key_selected = item .. "_selected"
		local key_visible = item .. "_visible"

		if hls[key_selected] == nil then
			hls[key_selected] = {}
		end

		if hls[key_visible] == nil then
			hls[key_visible] = {}
		end

		hls[key_selected].bg = c.base
		hls[key_visible].bg = c.base
	end

	return hls
end

local lualine_theme_create = function(c)
	local colors = {
		["normal"] = c.blue,
		["insert"] = c.green,
		["visual"] = c.mauve,
		["replace"] = c.red,
		["command"] = c.peach,
		["terminal"] = c.green,
		["inactive"] = c.mantle,
	}

	local theme = {}

	for mode, color in pairs(colors) do
		theme[mode] = {
			a = { bg = blend(c.mantle, color, 70), fg = c.mantle },
			b = { bg = blend(c.mantle, color, 15), fg = color },
			c = { bg = blend(c.base, c.mantle, 50), fg = mode == "inactive" and c.surface2 or c.text },
			x = { bg = blend(c.base, c.mantle, 50), fg = c.surface2 },
		}
	end

	return theme
end

local dashboard_header_animate = function()
	local c = colors_get()
	local colors = { c.blue, c.sky, c.green, c.yellow, c.peach, c.red }
	local limit = require("lazyvimx.util.general").theme_is_dark() and 100 or 20

	for i = 5, limit do
		local timer = vim.loop.new_timer()

		if timer ~= nil then
			timer:start(
				i * 1.06 * 50,
				0,
				vim.schedule_wrap(function()
					for j = 2, 7 do
						vim.api.nvim_set_hl(0, "SnacksDashboardHeader" .. j, { fg = blend(c.base, colors[j - 1], i) })
					end
				end)
			)
		end
	end
end

return {
	"catppuccin/nvim",
	name = "catppuccin",
	optional = true,

	opts = {
		integrations = {
			navic = false,
			treesitter_context = true,
			dap = { enabled = true, enable_ui = true },
		},

		highlight_overrides = {
			all = override_all,
			frappe = override_dark,
			macchiato = override_dark,
			mocha = override_dark,
			latte = override_light,
		},
	},

	specs = {
		{
			"akinsho/bufferline.nvim",
			optional = true,

			opts = function(_, opts)
				function highlights_create()
					local catppuccin_bufferline = require("catppuccin.special.bufferline")
					local highlights = catppuccin_bufferline.get_theme({
						styles = { "bold" },
						custom = {
							frappe = override_bufferline_hls(colors_get("frappe")),
							macchiato = override_bufferline_hls(colors_get("macchiato")),
							mocha = override_bufferline_hls(colors_get("mocha")),
							latte = override_bufferline_hls(colors_get("latte")),
						},
					})

					return highlights
				end

				if vim.g.colors_name and vim.g.colors_name:find("catppuccin", 1, true) then
					opts.highlights = highlights_create()
				end

				vim.api.nvim_create_autocmd("ColorScheme", {
					desc = "Setup bufferline theme after colorscheme changed",
					pattern = "catppuccin*",
					callback = function()
						opts.highlights = highlights_create()

						require("bufferline.highlights").reset_icon_hl_cache()
						require("bufferline").setup(opts)
					end,
				})
			end,
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "catppuccin/nvim" },
			optional = true,

			opts = function(_, opts)
				if vim.g.colors_name:find("catppuccin", 1, true) then
					opts.options.theme = lualine_theme_create(colors_get())
				end

				vim.api.nvim_create_autocmd("ColorScheme", {
					desc = "Setup lualine theme after colorscheme changed",
					pattern = "catppuccin*",
					callback = function(data)
						for _, wb in pairs({ opts.inactive_winbar, opts.winbar }) do
							for _, section in pairs(wb.lualine_c) do
								section.color.bg = "none"
							end
						end

						opts.options.theme = lualine_theme_create(colors_get())

						require("lualine").setup(opts)
					end,
				})
			end,
		},

		{
			"folke/snacks.nvim",
			dependencies = { "catppuccin/nvim" },
			optional = true,

			opts = function()
				if vim.g.colors_name:find("catppuccin", 1, true) then
					vim.api.nvim_create_autocmd("User", {
						once = true,
						pattern = "LazyVimStarted",
						callback = dashboard_header_animate,
					})
				end
			end,
		},

		{
			"catppuccin/nvim",
			dependencies = { { "rachartier/tiny-inline-diagnostic.nvim", optional = true } },
		},
	},
}
