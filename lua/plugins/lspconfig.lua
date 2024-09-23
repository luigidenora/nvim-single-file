return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        "Bilal2453/luvit-meta",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "smiteshp/nvim-navic",
    },
    config = function()
        local mason_registry = require("mason-registry")
        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- Diagnostics
        vim.diagnostic.config({
            signs = true,
            underline = true,
            update_in_insert = true,
            virtual_text = {
                source = "if_many",
                prefix = "●",
            },
        })

        -- Run setup for no_config_servers
        local no_config_servers = {
            "docker_compose_language_service",
            "dockerls",
            "html",
            "jsonls",
            "tailwindcss",
            "taplo",
            "templ", -- requires gopls in PATH, mason probably won't work depending on the OS
            "yamlls",
            "ts_ls",
        }
        for _, server in pairs(no_config_servers) do
            require("lspconfig")[server].setup({})
        end

        -- Angular
        local global_library_path = vim.fn.trim(vim.fn.system("npm root -g"))
        local cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            global_library_path,
            "--ngProbeLocations",
            global_library_path,
        }
        vim.filetype.add({
            pattern = {
                [".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
            },
        })
        vim.cmd("runtime! ftplugin/html.vim!")
        require("lspconfig").angularls.setup({
            cmd = cmd,
            on_new_config = function(new_config, new_root_dir)
                new_config.cmd = cmd
            end,
            root_dir = function(fname)
                return require("lspconfig").util.root_pattern("angular.json", ".git")(fname) or vim.fn.getcwd()
            end,
        })
        -- Go
        require("lspconfig").gopls.setup({
            settings = {
                gopls = {
                    completeUnimported = true,
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                },
            },
        })

        -- Bicep
        local bicep_path = vim.fn.stdpath("data") .. "/mason/packages/bicep-lsp/bicep-lsp.cmd"
        require("lspconfig").bicep.setup({
            cmd = { bicep_path },
        })

        -- Lua
        require("lspconfig").lua_ls.setup({
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                        },
                    })

                    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end
                return true
            end,
        })

        -- PowerShell
        local bundle_path = mason_registry.get_package("powershell-editor-services"):get_install_path()
        require("lspconfig").powershell_es.setup({
            bundle_path = bundle_path,
            settings = { powershell = { codeFormatting = { Preset = "Stroustrup" } } },
        })
    end,
}
