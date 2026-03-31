local _ = require("conform")

return {
	"conform.nvim",
	---@type conform.setupOpts
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
