local function calculate_total(items)
	local total = 0

	for _, item in ipairs(items) do
		total = total + item.price * item.quantity
	end

	return total
end

local function format_price(amount)
	return string.format("%.2f ₽", amount)
end

local cart = {
	{ name = "coffee", price = 350, quantity = 2 },
	{ name = "croissant", price = 180, quantity = 1 },
}

print(format_price(calculate_total(cart)))
print(format_price(calculate_total({})))

return { calculate_total = calculate_total, format_price = format_price }
