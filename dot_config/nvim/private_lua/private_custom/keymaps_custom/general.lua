local M = {}

M.keymaps = { n = {}, v = {}, i = {}, t = {} }

local groups = {
    "lsp",
    "search",
    "test_debug",
    "git",
    "ui",
    "session",
    "editing",
    "llm",
}

for _, group in ipairs(groups) do
    local mappings = require("custom.keymaps_custom.groups." .. group)
    for mode, maps in pairs(mappings) do
        if not M.keymaps[mode] then
            M.keymaps[mode] = {}
        end
        vim.list_extend(M.keymaps[mode], maps)
    end
end

return M.keymaps