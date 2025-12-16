local layout = require("lazyvimx.util.layout")

function tab_rename()
	local tab_name = vim.fn.input("tab name: ")

	if tab_name ~= "" then
		vim.api.nvim_tabpage_set_var(0, "name", tab_name)
	end
end

local function create(plugin_name, keys, opts, dependencies)
	local info = {
		plugin_name,
		optional = true,
	}

	for _, value in pairs(keys) do
		value["desc"] = value["desc"] or "Description not setted"

		if type(value[2]) == "string" then
			value[2] = "<cmd>" .. value[2] .. "<cr>"
		else
			value[2] = value[2][1]
		end
	end

	info.keys = keys

	if opts ~= nil then
		info.opts = opts
	end

	if dependencies ~= nil then
		info.dependencies = dependencies
	end

	return info
end

return {
	desc = "Custom keybindings for LazyVimx features including DAP, motions, and enhanced navigation",

	create("LazyVim/LazyVim", {
		{ "d", { [["_d]] }, mode = { "n", "v" }, desc = "Delete text without yanking" },

		-- stylua: ignore start
		{ "<c-s-j>", { ":m '>+1<cr>gv=gv" },		desc = "Move down", mode = { "v" }, silent = true },
		{ "<c-s-j>", { "<esc><cmd>m .+1<cr>==gi" },	desc = "Move down", mode = { "i" } },
		{ "<c-s-j>", { "<cmd>m .+1<cr>==" },		desc = "Move down", mode = { "n" } },

		{ "<c-s-k>", { ":m '<-2<cr>gv=gv" },		desc = "Move up", mode = { "v" }, silent = true },
		{ "<c-s-k>", { "<esc><cmd>m .-2<cr>==gi" },	desc = "Move up", mode = { "i" } },
		{ "<c-s-k>", { "<cmd>m .-2<cr>==" },		desc = "Move up", mode = { "n" } },
		-- stylua: ignore end
	}),

	create("LazyVim/LazyVim", not vim.g.vscode and {
		{ "<leader>\\", { "<c-w>v" }, desc = "Split window right" },
		{ "<leader>ch", "lua Snacks.terminal.open('cht.sh --shell')", desc = "Open shell (cht.sh)" },
		{ "<leader>ll", "Lazy", desc = "Open popup with lazy dashboard" },
		{ "<leader>lx", "LazyExtras", desc = "Open popup with lazy extras" },
	} or {}),

	create("neovim/nvim-lspconfig", {}, function(_, opts)
		local lazyvim_override_key = function(plug_name, key)
			if LazyVim.has(plug_name) then
				table.insert(opts.servers["*"].keys, key)
			end
		end

		lazyvim_override_key("live-rename.nvim", { "<leader>cr", [[<cmd>lua require("live-rename").rename()<cr>]] })
		lazyvim_override_key("glance.nvim", { "gr", [[<cmd>Glance references<cr>]], nowait = true })
	end),

	create("mikavilpas/yazi.nvim", {
		{ "<leader>fy", "Yazi", desc = "Find files (yazi)" },
		{ "<leader>fY", "Yazi toggle", desc = "Find files (yazi prev session)" },
	}),

	create("folke/snacks.nvim", {
		{ "<leader><space>", { LazyVim.pick("smart") }, desc = "Find files (smart)" },
		{ "<leader>uz", "lua Snacks.zen.zoom()", desc = "Toggle zen mode" },
		{
			"<leader>uq",
			{
				function()
					if vim.bo.filetype == "snacks_dashboard" then
						return
					end

					require("snacks").dashboard.open()
				end,
			},
			desc = "Open dashboard",
		},
	}),

	create("nvim-treesitter/nvim-treesitter-context", {
		{ "[x", "lua require('treesitter-context').go_to_context(vim.v.count1)", desc = "Go to context" },
	}),

	create("akinsho/bufferline.nvim", {
		{ "<leader><tab>r", { tab_rename }, desc = "Rename tab" },
		{ "<leader>bg", "BufferLinePick", mode = { "n", "v" }, desc = "Pick Buffer" },
		{ "<leader>bm[", "BufferLineMoveNextRepeatable", desc = "Move buffer (prev)" },
		{ "<leader>bm]", "BufferLineMovePrevRepeatable", desc = "Move buffer (next)" },
		{ "H", "BufferLineCyclePrev" },
		{ "L", "BufferLineCycleNext" },
	}),

	create("chrisgrieser/nvim-spider", {
		{ "<c-b>", { "<esc><cmd>lua require('spider').motion('b')<cr>i" }, mode = { "i" } },
		{ "<c-f>", { "<esc>l<cmd>lua require('spider').motion('w')<cr>i" }, mode = { "i" } },
		{ "b", "lua require('spider').motion('b')", mode = { "n", "o", "x" } },
		{ "cw", { "c<cmd>lua require('spider').motion('e')<cr>" }, mode = { "n" } },
		{ "e", "lua require('spider').motion('e')", mode = { "n", "o", "x" } },
		{ "w", "lua require('spider').motion('w')", mode = { "n", "o", "x" } },
	}),

	create("folke/edgy.nvim", {
		-- stylua: ignore start
		{ "<c-Up>",		"resize +" .. layout.step,				mode = { "n", "v", "t" }, desc = "Increase window height" },
		{ "<c-Down>",	"resize -" .. layout.step,				mode = { "n", "v", "t" }, desc = "Decrease window height" },
		{ "<c-Left>",	"vertical resize -" .. layout.step,		mode = { "n", "v", "t" }, desc = "Decrease window width" },
		{ "<c-Right>",	"vertical resize +" .. layout.step,		mode = { "n", "v", "t" }, desc = "Increase window width" },
		-- stylua: ignore end
	}, function(_, opts)
		opts.keys = {
			["<c-Up>"] = layout.increase_create("height"),
			["<c-Down>"] = layout.decrease_create("height"),
			["<c-Left>"] = layout.decrease_create("width"),
			["<c-Right>"] = layout.increase_create("width"),
		}
	end),

	create("tiagovla/scope.nvim", {
		{ "<leader>b<tab>", "lua require('scope.core').move_current_buf({})", desc = "Move buffer to another tab" },
	}),

	create("harrisoncramer/gitlab.nvim", {
		{ "<leader>gLA", "lua require('gitlab').approve()", desc = "Approve" },
		{ "<leader>gLc", "lua require('gitlab').create_comment()", desc = "Create comment" },
		-- stylua: ignore
		{ "<leader>gLC", "lua require('gitlab').create_comment_suggestion()", mode = { "v" }, desc = "Create comment suggestion" },
		{ "<leader>gLc", "lua require('gitlab').create_multiline_comment()", mode = { "v" }, desc = "Create comment" },
		{ "<leader>gLd", "lua require('gitlab').toggle_discussions()", desc = "Toggle discussion" },
		{ "<leader>gLe", "lua require('gitlab').choose_merge_request()", desc = "Choose merge request" },
		{ "<leader>gLM", "lua require('gitlab').merge()", desc = "Merge" },
		-- stylua: ignore
		{ "<leader>gLm", "lua require('gitlab').move_to_discussion_tree_from_diagnostic()", desc = "Move to discussion" },
		{ "<leader>gLn", "lua require('gitlab').create_note()", desc = "create note" },
		{ "<leader>gLo", "lua require('gitlab').open_in_browser()", desc = "Open in browser" },
		{ "<leader>gLp", "lua require('gitlab').pipeline()", desc = "Pipeline" },
		{ "<leader>gLr", "lua require('gitlab').review()", desc = "Review" },
		{ "<leader>gLR", "lua require('gitlab').revoke()", desc = "Revoke" },
		{ "<leader>gLs", "lua require('gitlab').summary()", desc = "Summary" },
	}),

	create("tpope/vim-fugitive", {
		{ "go", "'<,'>GBrowse", desc = "Open range (browser)", mode = { "v" } },
		{ "go", "GBrowse", desc = "Open (browser)", mode = { "n" } },
	}),

	create("moyiz/git-dev.nvim", {
		{ "gX", "GitDevRemoteEnterAndOpen", desc = "Enter a remote git repository; open (tab)" },
		{ "gx", "GitDevRemoteOpen", desc = "Open a remote git repository; open (tab)" },
	}),

	create("mfussenegger/nvim-dap", {
		{ "<F5>", "require('dap').continue()", desc = "Continue" },
		{ "<F10>", "require('dap').step_over()", desc = "Step over" },
		{ "<F11>", "require('dap').step_into()", desc = "Step into" },
		{ "<F12>", "require('dap').step_out()", desc = "Step out" },
	}),

	create("olrtg/nvim-emmet", {
		{ "<leader>cw", "EmmetWrap", desc = "Wrap with emmet abbreviation", mode = { "n", "v" } },
	}),

	create("Wansmer/sibling-swap.nvim", {
		{ "<C-.>", "lua require('sibling-swap').swap_with_right()", desc = "Move sibling node to right" },
		{ "<C-,>", "lua require('sibling-swap').swap_with_left()", desc = "Move sibling node to left" },
	}, { use_default_keymaps = false }, { "folke/sidekick.nvim" }),

	create("Wansmer/treesj", {
		{ "<leader>ct", "lua require('treesj').toggle()", desc = "Split or Join code block with autodetect" },
		{ "<leader>c\\", "lua require('treesj').split()", desc = "Split code block" },
		{ "<leader>cj", "lua require('treesj').join()", desc = "Join code block" },
	}, function(_, opts)
		opts.use_default_keymaps = false
	end),

	create("aaronik/treewalker.nvim", {
		{ "<c-a-l>", "Treewalker Right" },
		{ "<c-a-h>", "Treewalker Left" },
		{ "<c-a-j>", "Treewalker Down" },
		{ "<c-a-k>", "Treewalker Up" },
		{ "<c-a-.>", "Treewalker SwapDown" },
		{ "<c-a-,>", "Treewalker SwapUp" },
	}),

	create("lewis6991/gitsigns.nvim", {}, function(_, opts)
		local on_attach_orig = opts.on_attach
		local on_attach_modified = function(buffer)
			local keyOpts = { buffer = buffer, desc = "Preview Hunk" }
			vim.keymap.set("n", "<leader>ghP", require("gitsigns").preview_hunk, keyOpts)
			on_attach_orig(buffer)
		end

		opts.on_attach = on_attach_modified
		opts.preview_config = vim.tbl_extend("force", opts.preview_config or {}, { row = 1, col = 1 })
	end),
}
