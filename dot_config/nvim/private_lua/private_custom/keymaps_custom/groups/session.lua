return {
    n = {
        {
            "<leader>er",
            function()
                require("persistence").load()
            end,
            desc = "S[e]ssion [R]estore",
        },
        {
            "<leader>es",
            function()
                require("persistence").select()
            end,
            desc = "S[e]ssion [S]elect",
        },
        {
            "<leader>el",
            function()
                require("persistence").load({ last = true })
            end,
            desc = "S[e]ssion Restore [L]ast",
        },
        {
            "<leader>ei",
            function()
                require("persistence").stop()
            end,
            desc = "S[e]ssion [I]gnore current",
        },
    },
}
