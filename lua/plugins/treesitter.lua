return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		highlight = { enable = true },
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"javascript", 
			"astro", 
			"css",
			"gitignore",
			"html",
			"http",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"typescript",
			"yaml",
			"angular",
		},
	},
	config = function(_,opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
