return {
    n = {
        {
            "<leader>q",
            vim.diagnostic.setloclist,
            desc = "Open diagnostic [Q]uickfix list",
        },
        {
            "\\",
            "<cmd>Neotree reveal<cr>",
            desc = "Neotree reveal",
        },
        {
            "<leader>np",
            "<cmd>lua require('neotest').output_panel.toggle()<cr>",
            desc = "🧪 Toggle output panel",
        },
        { "<leader>nv", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "🧪 Toggle summary" },
        { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Toggle todo Panel" },
        {
            "<leader>xT",
            "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
            desc = "Toggle Todo/Fix/Fixme Panel",
        },
        {
            "<leader>k",
            "<cmd>KLInteract<cr>",
            desc = "[K]hal interact",
        },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        },
        {
            "<leader>a",
            "<cmd>AerialToggle!<cr>",
            desc = "Toggle Aerial Window",
        },
    },
}
