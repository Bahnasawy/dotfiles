return {
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescriptreact", "typescript" },
		opts = {
			run_as_monorepo = true,
			use_trouble_qflist = true,
			hide_progress_notifications_from_history = true,
		},
	},
	{
		"dmmulroy/ts-error-translator.nvim",
		lazy = true,
	},
}
