return {
    n = {
        {
            "gd",
            function()
                require("telescope.builtin").lsp_definitions()
            end,
            desc = "[G]oto [D]efinition",
        },
        {
            "gr",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "[G]oto [R]eferences",
        },
        {
            "gI",
            function()
                require("telescope.builtin").lsp_implementations()
            end,
            desc = "[G]oto [I]mplementation",
        },
        {
            "gD",
            function()
                require("telescope.builtin").lsp_type_definitions()
            end,
            desc = "Type [D]efinition",
        },
        {
            "ge",
            function()
                vim.lsp.buf.declaration()
            end,
            desc = "[G]oto D[e]finition",
        },
        {
            "<leader>csw",
            function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols()
            end,
            desc = "[S]ymbols in [W]orkspace",
        },
        {
            "<leader>th",
            function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end,
            desc = "[T]oggle Inlay [H]ints",
        },
        {
            "<leader>to",
            "<cmd>OverlengthToggle<cr>",
            desc = "[T]oggle [O]verlength",
        },
        {
            "<leader>tf",
            function()
                vim.b.disable_formatting = not vim.b.disable_formatting
                if vim.b.disable_formatting then
                    vim.notify(
                        "Formatting disabled for current buffer",
                        vim.log.levels.WARN,
                        { title = "Formatter" }
                    )
                else
                    vim.notify(
                        "Formatting enabled for current buffer",
                        vim.log.levels.INFO,
                        { title = "Formatter" }
                    )
                end
            end,
            desc = "[t]oggle [f]ormatter for buffer",
        },
        {
            "<leader>tl",
            function()
                vim.b.disable_linting = not vim.b.disable_linting
                if vim.b.disable_linting then
                    vim.diagnostic.enable(false, { bufnr = 0 })
                    vim.notify(
                        "Linting disabled for current buffer",
                        vim.log.levels.WARN,
                        { title = "Linter" }
                    )
                else
                    vim.diagnostic.enable(true, { bufnr = 0 })
                    vim.notify(
                        "Linting enabled for current buffer",
                        vim.log.levels.INFO,
                        { title = "Linter" }
                    )
                    require("lint").try_lint()
                end
            end,
            desc = "[t]oggle [l]inter for buffer",
        },
        {
            "<leader>cr",
            vim.lsp.buf.rename,
            desc = "[C]ode [R]ename",
        },
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            desc = "[F]ormat buffer",
        },
        {
            "<leader>ca",
            function()
                vim.lsp.buf.code_action()
            end,
            desc = "[C]ode [A]ction",
        },
    },
}
