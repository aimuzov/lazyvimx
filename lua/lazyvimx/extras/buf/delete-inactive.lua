return {
	"chrisgrieser/nvim-early-retirement",
	desc = "Deletes buffers if they have been inactive for 30 minutes or if the source has been deleted",
	event = "VeryLazy",

	opts = {
		deleteBufferWhenFileDeleted = false,
		retirementAgeMins = 30,
		notificationOnAutoClose = true,
		deleteFunction = function(buf)
			Snacks.bufdelete(buf, { force = true })
		end,
	},
}
