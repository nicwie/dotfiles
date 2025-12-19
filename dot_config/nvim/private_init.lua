--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:


  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- ]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- for vim-arpeggio
vim.cmd([[
  Arpeggio inoremap jk  <Esc>
]])

-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })

vim.g.tex_flavor = "latex"

-- Open compiler
vim.api.nvim_set_keymap("n", "<F6>", "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap(
    "n",
    "<S-F6>",
    "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
        .. "<cmd>CompilerRedo<cr>",
    { noremap = true, silent = true }
)

-- Toggle compiler results
-- vim.api.nvim_set_keymap("n", "<S-F8>", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

-- Use powerline symbols for airline as separator
vim.g.airline_powerline_fonts = 1

vim.cmd([[let g:airline_left_sep = "\ue0b0"]])
vim.cmd([[let g:airline_right_sep = "\ue0b2"]])

vim.o.encoding = "utf-8"

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.hl", "hypr*.conf" },
    callback = function(event)
        print(string.format("starting hyprls for %s", vim.inspect(event)))
        vim.lsp.start({
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
        })
    end,
})

vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.cmd([[let g:vimtex_compiler_engine = 'lualatex']])

-- This is done so that vim airline doesn't overtake bufferline.nvim
vim.cmd([[let g:airline#extensions#tabline#enabled = 0]])

-- For neotest gtest, and jest:
-- For some reason, we can't do this in the opts = {} of neotest

local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
    return
end

local jest = require("neotest-jest")
local gtest = require("neotest-gtest")

neotest.setup({
    summary = {
        open = "botright vsplit | vertical resize 80",
    },
    adapters = {
        jest({
            jestCommand = "npm test --",
            cwd = function(path)
                return vim.fn.getcwd()
            end,
        }),
        require("neotest-gtest").setup({
            executable_name = "build/tests",
        }),
    },
})

vim.notify = require("notify")

-- vim: ts=2 sts=2 sw=2 et
