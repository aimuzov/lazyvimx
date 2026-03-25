local M = {}

local size = {
	left = 40,
	right = 80,
	top = 10,
	bottom = 10,
}

local function resize(win, dir, sign)
	local step_signed = M.step * sign

	size[win.view.edgebar.pos] = win[dir] + step_signed
	win:resize(dir, step_signed)
end

local function increase(win, dir)
	return resize(win, dir, 1)
end

local function decrease(win, dir)
	return resize(win, dir, -1)
end

------------------------------------------------------------------------------------------------------------------------

M.step = 3

function M.get_size(pos)
	return size[pos]
end

function M.get_size_create(pos)
	return function()
		return M.get_size(pos)
	end
end

function M.increase_create(dir)
	return function(win)
		return increase(win, dir)
	end
end

function M.decrease_create(dir)
	return function(win)
		return decrease(win, dir)
	end
end

return M
