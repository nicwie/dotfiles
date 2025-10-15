-- LSP Plugins
return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

            -- Allows extra capabilities provided by nvim-cmp
            "hrsh7th/cmp-nvim-lsp",
            -- Allows Jumping to respective functions
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim",
                },
                opts = { lsp = { auto_attach = true } },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "x" })

                    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
                    ---@param client vim.lsp.Client
                    ---@param method vim.lsp.protocol.Method
                    ---@param bufnr? integer some lsp support methods only in specific files
                    ---@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has("nvim-0.11") == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client_supports_method(
                            client,
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        local highlight_augroup =
                            vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if
                        client
                        and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                clangd = {},
                pyright = {},
                ts_ls = {},
                ltex_plus = {
                    on_setup = function(server)
                        server.setup_commands({
                            -- CORRECTED KEYS: Using strings with dots instead of identifiers with underscores
                            ["_ltex.hideFalsePositives"] = {
                                function()
                                    vim.ui.input(
                                        { prompt = "LTeX: Enter comma-separated rules to disable:" },
                                        function(rules)
                                            if not rules then
                                                return
                                            end
                                            vim.lsp.buf.execute_command({
                                                command = "_ltex.hideFalsePositives",
                                                arguments = {
                                                    vim.uri_from_bufnr(0),
                                                    { newRules = vim.split(rules, ",") },
                                                },
                                            })
                                        end
                                    )
                                end,
                                description = "LTeX: Hide false positives",
                            },
                            ["_ltex.addToDictionary"] = {
                                function()
                                    local params = vim.lsp.util.make_range_params()
                                    vim.ui.input({ prompt = "LTeX: Word to add to dictionary:" }, function(word)
                                        if not word then
                                            return
                                        end
                                        vim.lsp.buf.execute_command({
                                            command = "_ltex.addToDictionary",
                                            arguments = { params.textDocument, { word = word } },
                                        })
                                    end)
                                end,
                                description = "LTeX: Add to dictionary",
                            },
                        })
                    end,
                },
                jdtls = {
                    cmd = (function()
                        local mason_path = vim.fn.stdpath("data") .. "/mason"
                        local jdtls_path = mason_path .. "/packages/jdtls"

                        local launcher_glob = jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"
                        local launcher_jar = vim.fn.glob(launcher_glob)
                        if launcher_jar == "" then
                            vim.notify("Could not find JDTLS launcher jar.", vim.log.levels.ERROR)
                            return {}
                        end

                        local java_executable = "/home/nicwie1/.asdf/installs/java/openjdk-24.0.1/bin/java"

                        return {
                            java_executable,
                            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                            "-Dosgi.bundles.defaultStartLevel=4",
                            "-Declipse.product=org.eclipse.jdt.ls.core.product",
                            "-Dlog.protocol=true",
                            "-Dlog.level=ALL",
                            "-Xms1g",
                            "--add-modules=ALL-SYSTEM",
                            "--add-opens",
                            "java.base/java.util=ALL-UNNAMED",
                            "--add-opens",
                            "java.base/java.lang=ALL-UNNAMED",
                            "-jar",
                            vim.fn.fnameescape(launcher_jar),
                            "-configuration",
                            jdtls_path .. "/config_linux",
                            "-data",
                            vim.fn.expand("~/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")),
                        }
                    end)(),
                    settings = {
                        java = {
                            configuration = {
                                runtimes = {
                                    {
                                        name = "JavaSE-1.8",
                                        path = "/home/nicwie1/.asdf/installs/java/adoptopenjdk-8.0.202+8",
                                        default = true,
                                    },
                                    {
                                        name = "JavaSE-24",
                                        path = "/home/nicwie1/.asdf/installs/java/openjdk-24.0.1",
                                    },
                                },
                            },
                        },
                    },
                },
                gopls = {},
                qmlls = {},
                bashls = {},
                cmake = {},
                --

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                -- Formatters
                "stylua",
                "clang-format",
                "prettierd",
                "black",
                "isort",
                "shfmt",
                "clang-format",
                "latexindent",
                "bibtex-tidy",
                "beautysh",
                "google-java-format",

                -- Linters
                "ruff",
                "shellcheck",
                "cpplint",
                "luacheck",
                "yamllint",
                "markdownlint",
                "proselint",
                "java-debug-adapter",
                "java-test",
                "cmakelang",
                "ltex-ls-plus",
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
}
-- vim: ts=2 sts=2 sw=2 et
