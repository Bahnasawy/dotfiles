return {
	"blink.cmp",
	build = "nix run .#build-plugin --accept-flake-config",
	opts = {
		completion = {
			trigger = {
				prefetch_on_insert = false,
			},
		},
	},
}
