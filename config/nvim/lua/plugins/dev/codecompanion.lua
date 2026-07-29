	return {
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"ravitemer/codecompanion-history.nvim",
				opts = {
					auto_save = true,
					picker = "snacks",
				},
			},
		},
	keys = {
		{ "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
		{ "<leader>Ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
		{ "<leader>Ci", "<cmd>CodeCompanion<cr>", mode = "x", desc = "CodeCompanion Inline" },
		{ "<leader>Cn", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion New Chat" },
	},
	opts = {
		interactions = {
			chat = {
				adapter = "opencode",
				model = "openai/gpt-5.6-terra",
				tools = {
					opts = {
						default_tools = { "agent" },
					},
				},
			},
			inline = { adapter = "opencode" },
			cmd = { adapter = "opencode" },
		},
		display = {
			action_palette = { provider = "snacks" },
			chat = {
				window = {
					layout = "vertical",
					position = "right",
					width = 0.5,
					full_height = true,
				},
				start_in_insert_mode = true,
				fold_reasoning = false,
			},
		},
		opts = {
			log_level = "ERROR",
			per_project_config = {
				files = { ".codecompanion.lua" },
			},
		},
	},
}
