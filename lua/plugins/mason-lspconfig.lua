return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "angularls", "astro", "lua_ls", "ts_ls" },
		})
		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup_handlers({
			-- Default handler (per server senza configurazione specifica)
			function(server_name)
				lspconfig[server_name].setup({
        })
        vim.lsp.enable(server_name)
			end,

			-- Esempio di handler dedicato (se necessario):
			["lua_ls"] = function()
			  lspconfig.lua_ls.setup({
			    settings = {
			      Lua = { diagnostics = { globals = { "vim" } } },
			    },
			  })
			end,
		})
local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig').clangd.setup({
      capabilities = capabilities
    })
	end,
}
