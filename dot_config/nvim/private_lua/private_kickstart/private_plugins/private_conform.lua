return {
    { -- Autoformat
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                if vim.b[bufnr].disable_formatting then
                    return
                end
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = "never"
                else
                    lsp_format_opt = "fallback"
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
                cpp = { "clang-format" },

                rust = { "rustfmt", lsp_format = "fallback" },

                java = { "google-java-format" },

                cmake = { "cmake-format" },

                -- LateX
                tex = { "latexindent" },
                bib = { "bibtex-tidy" },

                -- Web formats with prettierd
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                markdown = { "prettierd" },

                sh = { "shfmt" },
                zsh = { "shfmt" },
                -- Conform can also run multiple formatters sequentially
                python = { "isort", "black" },
            },
        },
    },
}
-- vim: ts=2 sts=2 sw=2 et
