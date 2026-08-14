if vim.g.vscode then
	return {}
end

local new_dir_file = vim.fn.stdpath("cache") .. "/lazygit-newdir"

-- Marker title used to route the worktree notification to noice's bottom-right
-- "mini" view (same spot as LSP progress). The matching route lives in
-- `overrides/other/noice.lua` — keep this string in sync with it.
local notify_title = "lazygit-worktree"

---Run `git -C <cwd> rev-parse <args...>`; return trimmed first line or nil on error.
local function git_rev_parse(cwd, args)
	local cmd = { "git", "-C", cwd, "rev-parse" }
	vim.list_extend(cmd, args)
	local out = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(vim.split(out, "\n", { plain = true })[1] or "")
end

---Absolute common git dir (shared across worktrees of the same repo), or nil.
local function common_dir(cwd)
	local dir = git_rev_parse(cwd, { "--git-common-dir" })
	if not dir then
		return nil
	end
	if dir:sub(1, 1) ~= "/" then
		dir = cwd .. "/" .. dir
	end
	return (vim.fn.fnamemodify(dir, ":p"):gsub("/$", ""))
end

---Move open buffers from the old worktree to the new one.
---Returns moved, closed, skipped(names) — or nil when migration must not run.
local function migrate_buffers(old_cwd, new_dir)
	local old_root = git_rev_parse(old_cwd, { "--show-toplevel" })
	local new_root = git_rev_parse(new_dir, { "--show-toplevel" })
	if not old_root or not new_root or old_root == new_root then
		return nil
	end

	-- Both must be worktrees of the SAME repository, else leave buffers alone.
	local old_common, new_common = common_dir(old_cwd), common_dir(new_dir)
	if not old_common or not new_common or old_common ~= new_common then
		return nil
	end

	local old_prefix = old_root .. "/"
	local plan = {} -- { { buf, action = "move"|"close", new_path? } }
	local skipped = {} -- relative paths of modified buffers left untouched

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buflisted and vim.bo[buf].buftype == "" then
			local name = vim.api.nvim_buf_get_name(buf)
			if name ~= "" and name:sub(1, #old_prefix) == old_prefix then
				local rel = name:sub(#old_prefix + 1)
				local new_path = new_root .. "/" .. rel
				if vim.bo[buf].modified then
					table.insert(skipped, rel)
				elseif vim.fn.filereadable(new_path) == 1 then
					table.insert(plan, { buf = buf, action = "move", new_path = new_path })
				else
					table.insert(plan, { buf = buf, action = "close" })
				end
			end
		end
	end

	local moved, closed = 0, 0
	for _, item in ipairs(plan) do
		if item.action == "move" then
			local new_buf = vim.fn.bufadd(item.new_path)
			vim.fn.bufload(new_buf)
			vim.bo[new_buf].buflisted = true
			for _, win in ipairs(vim.fn.win_findbuf(item.buf)) do
				local cursor = vim.api.nvim_win_get_cursor(win)
				vim.api.nvim_win_set_buf(win, new_buf)
				local row = math.min(cursor[1], vim.api.nvim_buf_line_count(new_buf))
				pcall(vim.api.nvim_win_set_cursor, win, { row, cursor[2] })
			end
			pcall(vim.api.nvim_buf_delete, item.buf, { force = false })
			moved = moved + 1
		else
			pcall(vim.api.nvim_buf_delete, item.buf, { force = false })
			closed = closed + 1
		end
	end

	return moved, closed, skipped
end

---Re-root an already-open neo-tree at `dir` (no-op if neo-tree is closed).
---Uses action "show" so focus is not stolen from the current window.
local function refresh_neotree(dir)
	local open = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
			open = true
			break
		end
	end
	if not open then
		return
	end

	local ok, cmd = pcall(require, "neo-tree.command")
	if ok then
		pcall(cmd.execute, { action = "show", source = "filesystem", dir = dir })
	end
end

local function follow_worktree()
	if vim.fn.filereadable(new_dir_file) ~= 1 then
		return
	end

	local lines = vim.fn.readfile(new_dir_file)
	vim.fn.delete(new_dir_file)

	local dir = vim.trim(lines[1] or "")
	if dir == "" or vim.fn.isdirectory(dir) ~= 1 then
		return
	end

	local old_cwd = vim.fn.getcwd()
	vim.cmd("cd " .. vim.fn.fnameescape(dir))

	local msg = " " .. vim.fn.fnamemodify(dir, ":~")
	local moved, closed, skipped = migrate_buffers(old_cwd, dir)
	refresh_neotree(dir)
	if moved then
		msg = msg .. ("\nbuffers: moved %d, closed %d"):format(moved, closed)
		if #skipped > 0 then
			msg = msg .. ("\nskipped %d (unsaved):\n- %s"):format(#skipped, table.concat(skipped, "\n- "))
		end
	end
	vim.notify(msg, vim.log.levels.INFO, { title = notify_title })
end

local function setup()
	local Snacks = require("snacks")
	local open_original = Snacks.lazygit.open

	Snacks.lazygit.open = function(opts)
		opts = vim.tbl_deep_extend("force", opts or {}, {
			env = { LAZYGIT_NEW_DIR_FILE = new_dir_file },
		})
		return open_original(opts)
	end

	vim.api.nvim_create_autocmd("TermClose", {
		desc = "Follow lazygit worktree switch by changing nvim cwd",
		callback = function(ev)
			if ev.file:find("lazygit", 1, true) then
				vim.schedule(follow_worktree)
			end
		end,
	})
end

return {
	"folke/snacks.nvim",
	opts = setup,
}
