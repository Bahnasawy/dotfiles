return {
	"neovim/nvim-lspconfig",
	opts = {
		inlay_hints = { enabled = false },
		servers = {
			vtsls = {
				enabled = true,
			},
			bacon_ls = {
				enabled = true,
			},
		},
	},
}
