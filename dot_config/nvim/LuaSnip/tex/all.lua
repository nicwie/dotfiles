local ls = require("luasnip")
local s = ls.s
-- local sn = ls.snippet_node
local t = ls.t
local i = ls.insert_node
-- local f = ls.function_node
-- local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep

local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
    s(
        { trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
        fmta([[\href{<>}{<>}]], {
            i(1, "url"),
            i(2, "display name"),
        })
    ),
}
