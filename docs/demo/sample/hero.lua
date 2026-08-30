local M = {}

local defaults = {
	currency = "₽",
	precision = 2,
	discount_threshold = 5000,
	discount_rate = 0.1,
}

local function format_price(amount, opts)
	local precision = opts and opts.precision or defaults.precision
	return string.format("%." .. precision .. "f %s", amount, defaults.currency)
end

local function apply_discount(total)
	if total < defaults.discount_threshold then
		return total, 0
	end

	local discount = total * defaults.discount_rate
	return total - discount, discount
end

function M.calculate_total(items)
	local total = 0

	for _, item in ipairs(items) do
		total = total + item.price * item.quantity
	end

	return total
end

function M.build_receipt(items)
	local lines = {}
	local subtotal = M.calculate_total(items)
	local total, discount = apply_discount(subtotal)

	for _, item in ipairs(items) do
		local price = format_price(item.price * item.quantity)
		table.insert(lines, string.format("%-14s x%d %10s", item.name, item.quantity, price))
	end

	table.insert(lines, string.rep("─", 34))
	table.insert(lines, string.format("%-14s %19s", "Subtotal", format_price(subtotal)))

	if discount > 0 then
		table.insert(lines, string.format("%-14s %19s", "Discount", format_price(discount)))
	end

	table.insert(lines, string.format("%-14s %19s", "Total", format_price(total)))

	return table.concat(lines, "\n")
end

local cart = {
	{ name = "coffee", price = 350, quantity = 2 },
	{ name = "croissant", price = 180, quantity = 3 },
	{ name = "cheesecake", price = 420, quantity = 1 },
	{ name = "espresso", price = 220, quantity = 4 },
	{ name = "cappuccino", price = 290, quantity = 2 },
}

function M.print_receipt()
	print(M.build_receipt(cart))
end

return M
