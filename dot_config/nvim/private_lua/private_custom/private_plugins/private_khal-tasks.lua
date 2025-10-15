return {
    {
        "huantrinh1802/khal_endar.nvim",
        version = "*",
        dependencies = { "MunifTanjim/nui.nvim", "chrisbra/Colorizer" },
        config = function()
            -- Require
            require("khal_endar").setup()
        end,
    },
    --  We comment this out because when we use taskwarrior hooked up with git sync,
    --  we add ~2s to startup time of nvim, which we do not want
    --  Not a problem with lazy!
    --  !TODO: check out keybinds for this
    -- {
    --     "https://github.com/blindFS/vim-taskwarrior",
    --     lazy = true,
    -- },
}
