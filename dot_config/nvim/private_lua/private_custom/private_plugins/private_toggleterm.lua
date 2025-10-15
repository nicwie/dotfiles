-- Gives you the ability to toggle terminals better

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        {
            "<F7>",
            "<cmd>ToggleTerm<cr>",
            desc = "Toggle Terminal",
        },
    },
    config = function()
        require("toggleterm").setup({
            size = 10,
            open_mapping = [[<F7>]],
            shading_factor = 2,
            direction = "float",
            float_opts = {
                border = "curved",
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
    end,
}
