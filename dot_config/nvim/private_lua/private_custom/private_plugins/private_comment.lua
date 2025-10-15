-- Important: <leader>cc (comment out line), <leader>bc (comment block)
-- Works with move commands ofc: <leader>c6j comments the next 6 lines,
-- gca} comments until next curly bracket

return {
    "numToStr/Comment.nvim",
    opts = {
        opleader = {
            line = "<leader>c",
            block = "<leader>b",
        },
    },
    keys = {
        -- Operator-pending mapping (e.g. "<leader>c6j")
        -- !FIX: Get these into keymaps.lua
        {
            "<leader>c",
            "<Plug>(comment_toggle_linewise_op)",
            mode = "n",
            remap = true,
            desc = "Comment: Operator (line)",
        },
        -- Operator-pending mapping for blocks
        {
            "<leader>b",
            "<Plug>(comment_toggle_blockwise_op)",
            mode = "n",
            remap = true,
            desc = "Comment: Operator (blockwise)",
        },
    },
}
