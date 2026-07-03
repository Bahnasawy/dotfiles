-- lazy.nvim
return {
	{
		"tris203/precognition.nvim",
		dependencies = { "chrisgrieser/nvim-spider" },
		opts = {},
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
		--- @type Spider.config
		opts = {
			consistentOperatorPending = true,
		}, -- calls `setup()`, which registers the precognition adapter
	},
}
