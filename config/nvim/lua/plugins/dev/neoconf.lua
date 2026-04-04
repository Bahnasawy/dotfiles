return {
	"neoconf.nvim",
	config = function()
		require("neoconf").setup({
			plugins = {
				jsonls = {
					configured_servers_only = false,
				},
			},
		})
		require("lspconfig").jsonls.setup({})
		require("lspconfig").lua_ls.setup({})
	end,
}
