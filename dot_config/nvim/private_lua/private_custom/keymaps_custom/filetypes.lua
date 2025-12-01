local M = {}

M.filetype_keymaps = {
    ["Cargo.toml"] = {
        n = {
            { "<leader>rt", "<cmd>Crates toggle<CR>", desc = "[r]ust Cargo [t]oggle" },
            { "<leader>rr", "<cmd>Crates reload<CR>", desc = "[r]ust Cargo [r]eload" },
            { "<leader>rv", "<cmd>Crates show_versions_popup<CR>", desc = "[r]ust Cargo show [v]ersions" },
            { "<leader>rf", "<cmd>Crates show_features_popup<CR>", desc = "[r]ust Cargo show [f]eatures" },
            { "<leader>rd", "<cmd>Crates show_dependencies_popup<CR>", desc = "[r]ust Cargo [d]epencies" },
            { "<leader>ru", "<cmd>Crates update_crate<CR>", desc = "[r]ust Cargo [u]pdate Crate" },
            { "<leader>ra", "<cmd>Crates update_all_crates<CR>", desc = "[r]ust Cargo update [a]ll crates" },
            { "<leader>rU", "<cmd>Crates upgrade_crate<CR>", desc = "[r]ust Cargo [U]pgrade crate" },
            { "<leader>rA", "<cmd>Crates upgrade_all_crates<CR>", desc = "[r]ust Cargo upgrade [A]ll crates" },
            {
                "<leader>rx",
                "<cmd>Crates expand_plain_crate_to_inline_table<CR>",
                desc = "[r]ust Cargo e[x]pand to inline table",
            },
            {
                "<leader>rX",
                "<cmd>Crates extract_crate_into_table<CR>",
                desc = "[r]ust Cargo e[X]tract into table",
            },
            { "<leader>rH", "<cmd>Crates open_homepage<CR>", desc = "[r]ust Cargo open [H]omepage" },
            { "<leader>rR", "<cmd>Crates open_repository<CR>", desc = "[r]ust Cargo open [R]epository" },
            { "<leader>rD", "<cmd>Crates open_documentation<CR>", desc = "[r]ust Cargo open [D]ocumentation" },
            { "<leader>rC", "<cmd>Crates open_crates_io<CR>", desc = "[r]ust Cargo open [C]rates.io" },
            { "<leader>rL", "<cmd>Crates open_lib_rs<CR>", desc = "[r]ust Cargo open [L]ib.rs" },
        },
    },
    ["*.rs"] = {
        n = {
            { "<leader>rc", "<cmd>!cargo check<CR>", desc = "[r]ust cargo [c]heck" },
            { "<leader>rC", "<cmd>!cargo clean<CR>", desc = "[r]ust cargo [C]lean" },
            { "<leader>rb", "<cmd>!cargo build<CR>", desc = "[r]ust cargo [b]uild" },
        },
    },
}

return M.filetype_keymaps
