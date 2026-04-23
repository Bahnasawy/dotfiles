return {
	"conform.nvim",
	--- @module 'conform'
	--- @type conform.setupOpts
	opts = {
		formatters_by_ft = {
			javascript = { "oxfmt" },
			javascriptreact = { "oxfmt" },
			typescript = { "oxfmt" },
			typescriptreact = { "oxfmt" },
			json = { "oxfmt" },
			vue = { "oxfmt" },
		},
	},
}
