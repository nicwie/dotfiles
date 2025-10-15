-- This is for plugins that either have no configuration options, or that we use the defaults on

return {
    "jghauser/mkdir.nvim",
    { "nkakouros-original/numbers.nvim", opts = {} },
    {
        "axkirillov/hbac.nvim",
        config = true,
    },
    {
        "m4xshen/hardtime.nvim",
        lazy = false,
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {},
    },
    {
        "v1nh1shungry/cppman.nvim",
        cmd = "Cppman",
        dependencies = {
            "nvim-telescope/telescope.nvim", -- optional for telescope picker
            "folke/snacks.nvim", -- optional for snacks picker
        },
        opts = {}, -- required, `setup()` must be called
    },
    {
        "psliwka/vim-dirtytalk",
        build = ":DirtytalkUpdate",
        config = function() end,
    },
    {
        "lcheylus/overlength.nvim",
        config = {
            textwidth_mode = 0,
            enabled = false,
        },
    },
}
