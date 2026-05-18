return {
	"folke/sidekick.nvim",
	optional = true,

	opts = {
		nes = { debounce = 1000 },
	},

	keys = {
		{
			"<leader>ac",
			function()
				local name = vim.api.nvim_buf_get_name(0)
				if name and name ~= "" then
					local ok, rel = pcall(vim.fs.relpath, vim.fn.getcwd(0), name)
					if ok and rel and rel ~= "" then
						name = rel
					end
				else
					name = "[No Name]"
				end

				local mode = vim.fn.mode()
				local l1, c1, l2, c2

				if mode == "v" or mode == "V" or mode == "\22" then
					local v = vim.fn.getpos("v")
					local cur = vim.fn.getpos(".")
					l1, c1 = v[2], v[3]
					l2, c2 = cur[2], cur[3]
					if l1 > l2 or (l1 == l2 and c1 > c2) then
						l1, l2 = l2, l1
						c1, c2 = c2, c1
					end
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
				else
					l1, c1 = vim.fn.line("."), vim.fn.col(".")
					l2, c2 = l1, c1
				end

				local text
				if l1 == l2 and c1 == c2 then
					text = string.format("@%s :L%d:C%d", name, l1, c1)
				else
					text = string.format("@%s :L%d:C%d-L%d:C%d", name, l1, c1, l2, c2)
				end

				vim.fn.setreg("+", text)
				vim.notify(text, vim.log.levels.INFO, { title = "Copied" })
			end,
			mode = { "n", "x" },
			desc = "Copy Position to Clipboard",
		},
	},

	specs = {
		{
			"saghen/blink.cmp",
			optional = true,

			---@type blink.cmp.Config
			opts = {
				keymap = {
					["<Tab>"] = {
						"snippet_forward",
						function()
							return require("sidekick").nes_jump_or_apply()
						end,
						"fallback",
					},
				},
			},
		},
	},
}
