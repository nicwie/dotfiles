local ls = require("luasnip")
local s = ls.s
local sn = ls.snippet_node
local t = ls.t
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep
local r = ls.restore_node

-- Check if cursor is in a vimtex math zone
local in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local generate_matrix = function(args, snip)
    local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    nodes[#nodes] = t("\\\\")
    return sn(nil, nodes)
end

local all_snippets = {}

-- Wrapper for creating a math-only autosnippet
-- We want to create a notification when we write something out in full that has
-- a snippet for it, so that we do not waste time writing out things that can be
-- written faster
local function math_auto(trigger, expansion, description)
    -- This is the main, intended snippet
    table.insert(
        all_snippets,
        s({
            trig = trigger,
            dscr = description,
            snippetType = "autosnippet",
            condition = in_mathzone,
        }, expansion)
    )

    local exp_text = expansion.nodes and expansion.nodes[1]
    if type(exp_text) == "string" and exp_text:match("^\\") then
        -- The corrected line with double-escaping for the regex trigger
        local reminder_trig = exp_text:gsub(" ", ""):gsub("\\", "\\\\\\\\") .. " "

        print("Luasnip Reminder Trigger: '" .. reminder_trig .. "'")

        table.insert(
            all_snippets,
            s(
                {
                    trig = reminder_trig,
                    descr = "Reminder for '" .. trigger:gsub(" ", "") .. "'",
                    snippetType = "autosnippet",
                    regTrig = true,
                    priority = 2000,
                    condition = in_mathzone,
                },
                d(1, function()
                    vim.notify(
                        "Hint: Use snippet '" .. trigger:gsub(" ", "") .. "' instead!",
                        vim.log.levels.INFO,
                        { title = "Luasnip" }
                    )
                    -- Return a text node of what was typed
                    return t(vim.fn.strpart(exp_text, 0))
                end)
            )
        )
    end
end

-- Wrapper for creating a math-only snippet with placeholders
local function math_fmt(trigger, format_string, nodes, description)
    table.insert(
        all_snippets,
        s({
            trig = trigger,
            dscr = description,
            snippetType = "autosnippet",
            condition = in_mathzone,
        }, fmt(format_string, nodes, { delimiters = "<>" }))
    )
end

local function math_fmt_wordtrig(trigger, format_string, nodes, description)
    table.insert(
        all_snippets,
        s({
            trig = trigger,
            dscr = description,
            snippetType = "autosnippet",
            condition = in_mathzone,
            wordTrig = false,
        }, fmt(format_string, nodes, { delimiters = "<>" }))
    )
end

--  General Symbols & Operators
math_auto("->", t("\\to"), "-> to \\to")
math_auto("=>", t("\\implies"), "=> to \\implies")
math_auto("<=>", t("\\iff"), "<=> to \\iff")
math_auto("==", t("\\equiv"), "== to \\equiv")
math_auto("!=", t("\\neq"), "!= to \\neq")
math_auto("~=", t("\\approx"), "~= to \\approx")
math_auto("<=", t("\\leq"), "<= to \\leq")
math_auto(">=", t("\\geq"), ">= to \\geq")
math_auto("pm", t("\\pm"), "+- to \\pm")
math_auto("xx", t("\\times"), "xx to \\times")
math_auto("**", t("\\cdot"), "** to \\cdot")
math_auto("...", t("\\ldots"), "... to \\ldots")
math_auto("prop", t("\\propto"), "prop to \\propto")
math_auto("inf", t("\\infty"), "inf to \\infty")
math_auto("cup", t("\\cup"), "cup to \\cup")
math_auto("cap", t("\\cap"), "cap to \\cap")
math_fmt("(", " \\left( <> \\right)", { i(1) }, "( to \\left( ")
math_fmt("[", " \\left[ <> \\right]", { i(1) }, "[ to \\left[ ")
math_fmt("\\{", "\\left\\{ <> \\right\\}", { i(1) }, "\\{ to \\left\\{")
math_fmt("| ", "\\left| <> \\right|", { i(1) }, "| to \\left|")

-- Set Theory
math_auto("in ", t(" \\in "), "in to \\in")
math_auto("!in", t(" \\notin "), "!in to \\notin")
math_auto("sub", t(" \\subset "), "sub to \\subset ")
math_auto("sup", t(" \\supset "), "sup to \\supset ")
math_auto("all", t(" \\forall "), "all to \\forall ")
math_auto("ex", t(" \\exists "), "ex to \\exists ")

-- Fractions, Powers, Roots
math_fmt("ff", "\\frac{<>}{<>}", { i(1), i(2) }, "Fraction")
math_fmt("pd", "\\frac{\\partial <>}{\\partial <>}", { i(1, "y"), i(2, "x") }, "Partial Derivative")
math_fmt("dd", "\\frac{d<>}{d<>}", { i(1, "y"), i(2, "x") }, "Derivative")
math_fmt_wordtrig("_", "_{<>}", { i(1, "x") }, "Subscript")
math_fmt_wordtrig("^", "^{<>}", { i(1, "x") }, "Superscript")
math_auto("sr", t("^{2}"), "Squared")
math_fmt("sqrt", "\\sqrt{<>}", { i(1) }, "Square Root")
math_fmt("nrt", "\\sqrt[<>]{<>}", { i(1, "n"), i(2) }, "Nth Root")

-- Calculus
math_fmt("sum", "\\sum_{<>}^{<>} <>", { i(1, "i=1"), i(2, "n"), i(3) }, "Summation")
math_fmt("int", "\\int_{<>}^{<>} <> \\,d<>", { i(1, "a"), i(2, "b"), i(3, "f(x)"), i(4, "x") }, "Integral")
math_fmt("prod", "\\prod_{<>}^{<>} <>", { i(1, "i=1"), i(2, "n"), i(3) }, "Product")
math_fmt("lim", "\\lim_{<> \\to <>} <>", { i(1, "n"), i(2, "\\infty"), i(3) }, "Limit")

-- Accents & grouping
math_fmt("bar", "\\overline{<>}", { i(1) }, "Overline")
math_fmt("hat", "\\hat{<>}", { i(1) }, "Hat")
math_fmt("vec", "\\vec{<>}", { i(1) }, "Vector")
math_fmt("tilde", "\\tilde{<>}", { i(1) }, "Tilde")
math_fmt("dot ", "\\dot{<>}", { i(1) }, "Dot")
math_fmt("ddot", "\\ddot{<>}", { i(1) }, "Double Dot")
math_fmt("ncr", "\\binom{<>}{<>}", { i(1, "n"), i(2, "k") }, "Binomial Coefficient")

math_fmt(
    "case", --, dscr = "Cases environment", snippetType = "autosnippet", condition = in_mathzone },
    [[
\begin{cases}
    <> & \text{if } <> \\
    <> & \text{if } <>
\end{cases}
            ]],
    { i(1), i(2), i(3), i(4) },
    "Cases environment"
)
-- Generate matrices with {s|b|B|p|v|V}Matnxm
table.insert(
    all_snippets,
    s(
        {
            trig = "([%sbBpvV])Mat(%d+)x(%d+)",
            snippetType = "autosnippet",
            regTrig = true,
            wordTrig = false,
            dscr = "[bBpvV]matrix of A x B size",
        },
        fmta(
            [[
    \begin{<>}
    <>
    \end{<>}]],
            {
                f(function(_, snip)
                    if snip.captures[1] == " " then
                        return "matrix"
                    else
                        return snip.captures[1] .. "matrix"
                    end
                end),
                d(1, generate_matrix),
                f(function(_, snip)
                    return snip.captures[1] .. "matrix"
                end),
            }
        ),
        { show_condition = in_mathzone }
    )
)

-- Greek letters autosnippets
math_auto(";a", t("\\alpha"), "alpha")
math_auto(";b", t("\\beta"), "beta")
math_auto(";g", t("\\gamma"), "gamma")
math_auto(";G", t("\\Gamma"), "Gamma")
math_auto(";d", t("\\delta"), "delta")
math_auto(";D", t("\\Delta"), "Delta")
math_auto(";e", t("\\varepsilon"), "epsilon")
math_auto(";z", t("\\zeta"), "zeta")
math_auto(";p ", t("\\pi "), "pi")
math_auto(";P ", t("\\Pi "), "Pi")
math_auto(";th", t("\\theta"), "theta")
math_auto(";Th", t("\\Theta"), "Theta")
math_auto(";l", t("\\lambda"), "lambda")
math_auto(";L", t("\\Lambda"), "Lambda")
math_auto(";m", t("\\mu"), "mu")
math_auto(";s", t("\\sigma"), "sigma")
math_auto(";S", t("\\Sigma"), "Sigma")
math_auto(";o", t("\\omega"), "omega")
math_auto(";O", t("\\Omega"), "Omega")
math_auto(";ph", t("\\phi"), "phi")
math_auto(";Ph", t("\\Phi"), "Phi")
math_auto(";ps", t("\\psi"), "psi")
math_auto(";Ps", t("\\Psi"), "Psi")
math_auto(";r", t("\\rho"), "rho")
math_auto(";t ", t("\\tau"), "tau")
math_auto(";x", t("\\xi"), "xi")
math_auto(";c", t("\\chi"), "chi")
-- Math fonts
math_fmt("bb", "\\mathbb{<>}", { i(1, "R") }, "Blackboard Bold")
math_fmt("cal", "\\mathcal{<>}", { i(1, "L") }, "Calligraphic")
math_fmt("bf", "\\mathbf{<>}", { i(1) }, "Math Bold")
-- Specific blackboard bold letters for speed
math_auto("RR", t("\\mathbb{R}"), "Real Numbers")
math_auto("CC", t("\\mathbb{C}"), "Complex Numbers")
math_auto("ZZ", t("\\mathbb{Z}"), "Integers")
math_auto("NN", t("\\mathbb{N}"), "Natural Numbers")
math_auto("QQ", t("\\mathbb{Q}"), "Rational Numbers")

return all_snippets
