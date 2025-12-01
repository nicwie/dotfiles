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
    local keymaps = require("custom.keymaps_custom.general")

    -- Loop through the keymaps table and set each mapping
    for mode, mappings in pairs(keymaps) do
        for _, mapping in ipairs(mappings) do
            local lhs = mapping[1]
            local rhs = mapping[2]
            local opts = { desc = mapping.desc } -- Use the 'desc' key from the table
            map(mode, lhs, rhs, opts)
        end
    end

    -- Define filetype/filename specific keymaps
    local filetype_keymaps = require("custom.keymaps_custom.filetypes")

    -- Loop through filetype_keymaps and set autocommands
    for pattern, modes in pairs(filetype_keymaps) do
        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = pattern,
            group = vim.api.nvim_create_augroup("CustomKeymaps_" .. pattern, { clear = true }),
            callback = function()
                for mode, mappings in pairs(modes) do
                    for _, mapping in ipairs(mappings) do
                        local lhs = mapping[1]
                        local rhs = mapping[2]
                        local opts = { desc = mapping.desc, buffer = true }
                        map(mode, lhs, rhs, opts)
                    end
                end
            end,
        })
    end
end

return M
