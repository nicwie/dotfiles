return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({})
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enable = true,
                -- Different Headings that could be used
                --                 header = [[
                -- ███╗   ██╗  ██╗ ██████╗ ███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
                -- ████╗  ██║  ██║ ██╔═══╝ ██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
                -- ██╔██╗ ██║  ██║ ██║     █████╗  ██║   ██║██║   ██║██║██╔████╔██║
                -- ██║╚██╗██║  ██║ ██║     ██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
                -- ██║ ╚████║  ██║ ██████╗ ███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
                -- ╚═╝  ╚═══╝  ╚═╝ ╚═════╝ ╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                --                 header = [[
                -- ███╗   ██╗██╗██████╗██╗   ██╗██╗███╗   ███╗
                -- ████╗  ██║██║██╔═══╝██║   ██║██║████╗ ████║
                -- ██╔██╗ ██║██║██║    ██║   ██║██║██╔████╔██║
                -- ██║╚██╗██║██║██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
                -- ██║ ╚████║██║██████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
                -- ╚═╝  ╚═══╝╚═╝╚═════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
                preset = {
                    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
                    ---@type fun(cmd:string, opts:table)|nil
                    pick = nil,
                    -- Used by the `keys` section to show keymaps.
                    -- Set your custom keymaps here.
                    -- When using a function, the `items` argument are the default keymaps.
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    -- Used by the `header` section
                    header = [[
███╗   ██╗██╗██████╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║██╔═══╝██║   ██║██║████╗ ████║
██╔██╗ ██║██║██║    ██║   ██║██║██╔████╔██║
██║╚██╗██║██║██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║██║██████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚═╝╚═════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
            },
            explorer = {
                enable = true,
            },
            -- image = {
            --     enable = true,
            --     opts = {
            --         doc = {
            --             inline = false,
            --             float = true,
            --         },
            --     },
            -- },
            quickfile = {
                enable = true,
            },
            words = {
                enable = false,
            },
        },
        keys = {
            -- !TODO: Do we need scratch buffers? check how these really work
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
        },
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "RRethy/vim-illuminate",
        -- event = "LazyFile",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
            -- !TODO: move this to main keymaps file

            Snacks.toggle({
                name = "Illuminate",
                get = function()
                    return not require("illuminate.engine").is_paused()
                end,
                set = function(enabled)
                    local m = require("illuminate")
                    if enabled then
                        m.resume()
                    else
                        m.pause()
                    end
                end,
            }):map("<leader>ux")

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },
    {
        "ggandor/flit.nvim",
        enabled = true,
        -- !TODO: how do we even get this to another file?
        keys = function()
            ---@type LazyKeysSpec[]
            local ret = {}
            for _, key in ipairs({ "f", "F", "t", "T" }) do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
            end
            return ret
        end,
        opts = { labeled_modes = "nx" },
    },
    {
        "ggandor/leap.nvim",
        enabled = true,
        keys = {
            { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
            { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
    { "tpope/vim-repeat", event = "VeryLazy" },
}
