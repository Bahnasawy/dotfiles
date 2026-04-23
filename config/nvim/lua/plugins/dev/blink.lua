return {
	"blink.cmp",
	build = "nix run .#build-plugin --accept-flake-config",
	--- @module 'blink-cmp'
	--- @type blink.cmp.Config
	opts = {
		completion = {
			trigger = {
				prefetch_on_insert = false,
			},
		},
	},
}
