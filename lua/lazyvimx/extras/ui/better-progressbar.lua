function is_supported()
	return vim.fn.getenv("TERM") == "xterm-ghostty"
end

local function lsp_progress_osc()
	vim.api.nvim_create_autocmd("LspProgress", {
		callback = function(ev)
			local value = ev.data.params.value or {}
			local msg = value.message or "done"

			-- rust analyzer in particular has really long LSP messages so truncate them
			if #msg > 40 then
				msg = msg:sub(1, 37) .. "..."
			end

			-- Ghostty OSC 9;4 progress bar
			if value.kind == "end" then
				io.write("\x1b]9;4;0\x07")
			elseif value.percentage then
				io.write(("\x1b]9;4;1;%d\x07"):format(value.percentage))
			else
				io.write("\x1b]9;4;3\x07")
			end

			vim.api.nvim_echo({ { msg } }, false, { kind = "progress" })
		end,
	})
end

return {
	desc = "LSP progress via Ghostty OSC 9;4 terminal progress bar instead of in-editor notifications",

	{
		"folke/noice.nvim",
		optional = true,
		opts = {
			routes = {
				{
					filter = { event = "lsp", kind = "progress" },
					opts = { skip = true },
				},
			},
		},
	},

	{
		"folke/noice.nvim",
		optional = true,
		opts = function(_, opts)
			if is_supported() then
				opts.routes = opts.routes or {}

				vim.list_extend(opts.routes, {
					filter = { event = "lsp", kind = "progress" },
					opts = { skip = true },
				})
			end
		end,
	},

	{
		"LazyVim/LazyVim",
		optional = true,
		opts = function()
			if is_supported() then
				lsp_progress_osc()
			else
				vim.notify("Better progress bar supports only by ghostty", "warn")
			end
		end,
	},
}
