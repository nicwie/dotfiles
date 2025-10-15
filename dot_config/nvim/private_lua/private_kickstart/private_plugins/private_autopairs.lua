-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- Optional dependency
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
        local npairs = require("nvim-autopairs")
        local rule = require("nvim-autopairs.rule")

        npairs.setup({})

        -- Checks if this is in a mathzone in latex
        local function is_not_in_mathzone()
            if vim.bo.filetype == "tex" then
                return vim.fn["vimtex#syntax#in_mathzone"]() == 0
            end
            return true
        end

        npairs.add_rules({
            rule("(", ")"):with_pair(is_not_in_mathzone),
            rule("[", "]"):with_pair(is_not_in_mathzone),
        })

        -- If you want to automatically add `(` after selecting a function or method
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
