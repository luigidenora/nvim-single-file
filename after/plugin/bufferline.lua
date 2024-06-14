vim.opt.termguicolors = true
require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, errors, ctx)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		offsets = {

			{
				filetype = "NvimTree",
				text = function()
					return "File Explorer"
				end,
				highlight = "Directory",
				text_align = "center",
				separator = false,
			},
		},
	},
})
