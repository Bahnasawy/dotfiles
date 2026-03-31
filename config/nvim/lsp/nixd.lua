if vim.loop.os_uname().sysname == "Linux" then
	return {
		cmd = { "nixd" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixfmt" },
				},
				options = {
					nixos = {
						expr = "(builtins.getFlake (toString ./.)).nixosConfigurations." .. vim.fn.hostname() .. ".options",
					},
					home_manager = {
						expr = "(builtins.getFlake (toString ./.)).homeConfigurations." .. vim.fn.hostname() .. ".options",
					},
				},
			},
		},
	}
else
	return {
		cmd = { "nixd" },
		settings = {
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				formatting = {
					command = { "nixfmt" },
				},
				options = {
					nixdawin = {
						expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.mac.options",
					},
					home_manager = {
						expr = "(builtins.getFlake (toString ./.)).homeConfigurations.mac.options",
					},
				},
			},
		},
	}
end
