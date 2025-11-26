-- This is for plugins that either have almost no configuration options, or
-- that we use the defaults on

return {
    -- Allows us to open foo/bar.txt without foo existing
    "jghauser/mkdir.nvim",
    { "nkakouros-original/numbers.nvim", opts = {} },
    {
        "axkirillov/hbac.nvim",
        config = true,
    },
    -- {
    --     "m4xshen/hardtime.nvim",
    --     lazy = false,
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     opts = {},
    -- },
    {
        "v1nh1shungry/cppman.nvim",
        cmd = "Cppman",
        dependencies = {
            "nvim-telescope/telescope.nvim", -- optional for telescope picker
            -- "folke/snacks.nvim", -- optional for snacks picker
        },
        opts = {}, -- required, `setup()` must be called
    },
    -- Add computer words to dictionary
    {
        "psliwka/vim-dirtytalk",
        build = ":DirtytalkUpdate",
        config = function() end,
    },
    -- We use this mapped to <leader>to to (especially in latex) not have the
    -- view break when viewing side by side
    {
        "lcheylus/overlength.nvim",
        config = {
            textwidth_mode = 0,
            enabled = false,
        },
    },
    -- replaces "s", substitute, with a 2-char seek motion to make jumping in
    -- line faster
    "goldfeld/vim-seek",
}
