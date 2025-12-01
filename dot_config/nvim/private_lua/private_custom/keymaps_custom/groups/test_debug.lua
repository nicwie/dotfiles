return {
    n = {
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
        -- DAP
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
    },
}
