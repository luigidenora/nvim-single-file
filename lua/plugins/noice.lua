return {
    {
        "folke/noice.nvim",
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                lsp = {
                    progress = {
                        enabled = true,
                        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                        -- See the section on formatting for more details on how to customize.
                        --- @type NoiceFormat|string
                        format = "lsp_progress",
                        --- @type NoiceFormat|string
                        format_done = "lsp_progress_done",
                        throttle = 1000 / 30, -- frequency to update lsp progress message
                        view = "mini",
                    },
                    override = {
                        -- override the default lsp markdown formatter with Noice
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                        -- override the lsp markdown formatter with Noice
                        ["vim.lsp.util.stylize_markdown"] = false,
                        -- override cmp documentation with Noice (needs the other options to work)
                        ["cmp.entry.get_documentation"] = false,
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                            },
                        },
                        opts = { skip = true },
                    },
                },
                presets = {
                    bottom_search = true,
                    long_message_to_split = true,
                    lsp_doc_border = true,
                },
                cmdline = {
                    view = "cmdline",
                },
                views = {
                    mini = {
                        win_options = {
                            winblend = 0,
                        },
                    },
                },
            })
        end,
    },
}
