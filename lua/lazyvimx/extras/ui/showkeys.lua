return {
	"nvzone/showkeys",
	desc = "Displays pressed keys in a floating window — handy for screencasts, demos and pairing",
	dependencies = { "nvzone/volt" },
	cmd = "ShowkeysToggle",
	opts = { position = "bottom-right", maxkeys = 4 },
}
