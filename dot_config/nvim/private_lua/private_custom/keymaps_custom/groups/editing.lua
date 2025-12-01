return {
    n = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next Todo Comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous Todo Comment",
        },
        {
            "<leader>cc",
            function()
                require("Comment.api").toggle.linewise.current()
            end,
            desc = "Comment: Toggle current line",
        },
        {
            "<leader>bc",
            function()
                require("Comment.api").toggle.blockwise.current()
            end,
            desc = "Comment: Toggle current block",
        },
        -- Portal.lua
        {
            "<leader>o",
            "<cmd>Portal jumplist backward<cr>",
            desc = "Open backwards jump list",
        },
        {
            "<leader>i",
            "<cmd>Portal jumplist forward<cr>",
            desc = "Open forwards jump list",
        },
    },
    v = {
        { "J", ":m '>+1<CR>gv=gv", desc = "Move line down" },
        { "K", ":m '<-2<CR>gv=gv", desc = "Move line up" },
    },
    i = {
        {
            "<C-a>",
            "<c-g>u<Esc>[s1z=`]a<c-g>u",
            desc = "Correct previous spelling mistake",
        },
    },
}
