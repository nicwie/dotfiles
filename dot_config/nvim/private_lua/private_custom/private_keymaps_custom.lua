-- This function will set the keymaps
local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true, -- Use non-recursive mapping
        silent = true, -- Don't show the command in the command line
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- return a setup function to be called from another file
local M = {}

function M.setup()
    -- Define all keymaps in this table
    local keymaps = {
        -- Normal Mode Keymaps
        n = {
            -- lsp gotos
            {
                "gd",
                function()
                    require("telescope.builtin").lsp_definitions()
                end,
                desc = "[G]oto [D]efinition",
            },
            {
                "gr",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                "[G]oto [R]eferences",
            },
            {
                "gI",
                function()
                    require("telescope.builtin").lsp_implementations()
                end,
                "[G]oto [I]mplementation",
            },
            {
                "gD",
                function()
                    require("telescope.builtin").lsp_type_definitions()
                end,
                desc = "Type [D]efinition",
            },
            {
                "ge",
                function()
                    vim.lsp.buf.declaration()
                end,
                desc = "[G]oto D[e]finition",
            },
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
                "<leader>csw",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols()
                end,
                desc = "[S]ymbols in [W]orkspace",
            },
            -- Toggle hints
            -- Would love for this to work, but originally (lspconfig.lua)
            -- this gets run only after "event" is defined and it's attached
            -- to a buffer, not sure how to handle this
            -- {
            --     "<leader>th",
            --     function()
            --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            --     end,
            --     desc = "[T]oggle Inlay [H]ints",
            -- },
            {
                "<leader>to",
                "<cmd>OverlengthToggle<cr>",
                "[T]oggle [O]verlength",
            },
            {
                "<leader>tf",
                function()
                    vim.b.disable_formatting = not vim.b.disable_formatting
                    if vim.b.disable_formatting then
                        vim.notify(
                            "Formatting disabled for current buffer",
                            vim.log.levels.WARN,
                            { title = "Formatter" }
                        )
                    else
                        vim.notify(
                            "Formatting enabled for current buffer",
                            vim.log.levels.INFO,
                            { title = "Formatter" }
                        )
                    end
                end,
                desc = "[t]oggle [f]ormatter for buffer",
            },
            {
                "<leader>cr",
                vim.lsp.buf.rename,
                desc = "[C]ode [R]ename",
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
            -- Neotest Mappings
            {
                "<leader>nr",
                "<cmd>lua require('neotest').run.run()<cr>",
                desc = "🧪 Run nearest test",
            },
            {
                "<leader>nf",
                "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
                desc = "🧪 Run current file",
            },
            { "<leader>na", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", desc = "🧪 Run all tests" },
            {
                "<leader>nd",
                "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
                desc = "🧪 Debug nearest test",
            },
            { "<leader>ns", "<cmd>lua require('neotest').run.stop()<cr>", desc = "🧪 Stop test" },
            {
                "<leader>nn",
                "<cmd>lua require('neotest').run.attach()<cr>",
                desc = "🧪 Attach to nearest test",
            },
            {
                "<leader>no",
                "<cmd>lua require('neotest').output.open()<cr>",
                desc = "🧪 Show test output",
            },
            {
                "<leader>nc",
                "<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>",
                desc = "🧪 Run all tests (CI)",
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
            -- Code
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                desc = "[F]ormat buffer",
            },
            {
                "<leader>cb",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle [B]reakpoint",
            },
            {
                "<leader>cB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "Conditional [B]reakpoint",
            },
            {
                "<leader>ca",
                function()
                    vim.lsp.buf.code_action()
                end,
                desc = "[C]ode [A]ction",
            },
            {
                "<F1>",
                function()
                    require("dap").step_into()
                end,
                desc = "Debug: Step Into",
            },
            {
                "<F2>",
                function()
                    require("dap").step_over()
                end,
                desc = "Debug: Step Over",
            },
            {
                "<F3>",
                function()
                    require("dap").step_out()
                end,
                desc = "Debug: Step Out",
            },
            {
                "<F5>",
                function()
                    require("dap").continue()
                end,
                desc = "Debug: Start/Continue",
            },
            -- Git
            {
                "<leader>gB",
                function()
                    Snacks.gitbrowse()
                end,
                desc = "Git Browse",
                mode = { "n", "v" },
            },
            {
                "<leader>gg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Lazygit",
            },
            -- UI Settings (Opening panels etc.)
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
            -- Session commands
            {
                "<leader>er",
                function()
                    require("persistence").load()
                end,
                desc = "S[e]ssion [R]estore",
            },
            {
                "<leader>es",
                function()
                    require("persistence").select()
                end,
                desc = "S[e]ssion [S]elect",
            },
            {
                "<leader>el",
                function()
                    require("persistence").load({ last = true })
                end,
                desc = "S[e]ssion Restore [L]ast",
            },
            {
                "<leader>ei",
                function()
                    require("persistence").stop()
                end,
                desc = "S[e]ssion [I]gnore current",
            },
            -- search
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
            { "<leader>l", ":Gen<CR>", "Chat with [l]lm" },
        },

        -- Visual Mode Keymaps
        v = {
            { "J", ":m '>+1<CR>gv=gv", desc = "Move line down" },
            { "K", ":m '<-2<CR>gv=gv", desc = "Move line up" },
            { "<leader>l", ":Gen<CR>", "Send selected to [l]lm" },
        },
        i = {
            {
                "<C-a>",
                "<c-g>u<Esc>[s1z=`]a<c-g>u",
                desc = "Correct previous spelling mistake",
            },
        },

        -- You can add more modes like 'i' for insert, 't' for terminal, etc.
    }

    -- Loop through the keymaps table and set each mapping
    for mode, mappings in pairs(keymaps) do
        for _, mapping in ipairs(mappings) do
            local lhs = mapping[1]
            local rhs = mapping[2]
            local opts = { desc = mapping.desc } -- Use the 'desc' key from the table
            map(mode, lhs, rhs, opts)
        end
    end
    --    local wk = require("which-key")
    --    wk.add({
    --        ["<leader>n"] = { name = "🧪 Neotest" },
    --    })
end

return M
