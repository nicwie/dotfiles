return {

    { -- Linting
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                c = { "cpplint" },
                cpp = { "cpplint" },
                python = { "ruff" },
                lua = { "luacheck" },
                sh = { "shellcheck" },
                yaml = { "yamllint" },
                markdown = { "markdownlint", "proselint" },
                java = { "checkstyle" },
                cmake = { "cmakelint" },
            }
            lint.linters_by_ft["clojure"] = nil
            -- lint.linters_by_ft["dockerfile"] = nil
            lint.linters_by_ft["inko"] = nil
            lint.linters_by_ft["janet"] = nil
            -- lint.linters_by_ft['json'] = nil
            -- lint.linters_by_ft['markdown'] = nil
            -- lint.linters_by_ft['rst'] = nil
            -- lint.linters_by_ft['ruby'] = nil
            lint.linters_by_ft["terraform"] = nil
            -- lint.linters_by_ft['text'] = nil

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    -- Only run the linter in buffers that you can modify
                    if vim.opt_local.modifiable:get() then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
}
