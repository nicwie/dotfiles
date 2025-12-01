return {
    n = {
        {
            "<leader>sh",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "[S]earch [H]elp",
        },
        {
            "<leader>sk",
            function()
                require("telescope.builtin").keymaps()
            end,
            desc = "[S]earch [K]eymaps",
        },
        {
            "<leader>sf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "[S]earch [F]iles",
        },
        {
            "<leader>ss",
            function()
                require("telescope.builtin").builtin()
            end,
            desc = "[S]earch [S]select Telescope",
        },
        {
            "<leader>sw",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "[S]earch current [W]ord",
        },
        {
            "<leader>sg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "[S]earch by [G]rep",
        },
        {
            "<leader>sd",
            function()
                require("telescope.builtin").diagnostics()
            end,
            desc = "[S]earch [D]iagnostics",
        },
        {
            "<leader>sr",
            function()
                require("telescope.builtin").resume()
            end,
            desc = "[S]earch [R]esume",
        },
        {
            "<leader>s.",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "[S]earch recent files",
        },
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "[S]earch [T]odo/Fix/Fixme" },
        {
            "<leader><leader>",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "[ ] Find existing buffers",
        },
        {
            "<leader>/",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({ previewer = false })
                )
            end,
            desc = "[/] Fuzzily search in current buffer",
        },
        {
            "<leader>s/",
            function()
                require("telescope.builtin").live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end,
            desc = "[S]earch [/] in open files",
        },
        {
            "<leader>sn",
            function()
                require("telescope.builtin").find_files({
                    cwd = vim.fn.stdpath("config"),
                })
            end,
            desc = "[S]earch [N]eovim files",
        },
        {
            "<leader>sc",
            function()
                require("cppman").search()
            end,
            desc = "[S]earch [C]ppman",
        },
    },
}
