return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "gopls", "lua_ls", "sqls", "ts_ls" },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        })

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
        })
    end
}
-- return {
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufReadPost" },
-- 		cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" },
-- 		dependencies = {
-- 			-- Plugin(s) and UI to automatically install LSPs to stdpath
-- 			"williamboman/mason.nvim",
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",
--
-- 			-- Install lsp autocompletions
-- 			"hrsh7th/cmp-nvim-lsp",
--
-- 			-- Progress/Status update for LSP
-- 			{ "j-hui/fidget.nvim", opts = {} },
-- 		},
-- 		config = function()
-- 			-- Override tsserver diagnostics to filter out specific messages
-- 			local messages_to_filter = {
-- 				"This may be converted to an async function.",
-- 			}
--
-- 			local function tsserver_on_publish_diagnostics_override(_, result, ctx, config)
-- 				local filtered_diagnostics = {}
--
-- 				for _, diagnostic in ipairs(result.diagnostics) do
-- 					local found = false
-- 					for _, message in ipairs(messages_to_filter) do
-- 						if diagnostic.message == message then
-- 							found = true
-- 							break
-- 						end
-- 					end
-- 					if not found then
-- 						table.insert(filtered_diagnostics, diagnostic)
-- 					end
-- 				end
--
-- 				result.diagnostics = filtered_diagnostics
--
-- 				vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
-- 			end
--
-- 			-- Default handlers for LSP
-- 			local default_handlers = {
-- 				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
-- 				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
-- 			}
--
-- 			local nmap = function(keys, func, desc)
-- 				if desc then
-- 					desc = "LSP: " .. desc
-- 				end
--
-- 				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
-- 			end
--
-- 			-- Function to run when neovim connects to a Lsp client
-- 			---@diagnostic disable-next-line: unused-local
-- 			local on_attach = function(_client, buffer_number)
-- 				-- Pass the current buffer to map lsp keybinds
--
-- 				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
-- 				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
-- 				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
-- 				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
-- 				nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
-- 			end
--
-- 			-- LSP servers and clients are able to communicate to each other what features they support.
-- 			--  By default, Neovim doesn't support everything that is in the LSP Specification.
-- 			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
-- 			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
-- 			local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
--
-- 			-- LSP servers to install (see list here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers )
-- 			--  Add any additional override configuration in the following tables. Available keys are:
-- 			--  - cmd (table): Override the default command used to start the server
-- 			--  - filetypes (table): Override the default list of associated filetypes for the server
-- 			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
-- 			--  - settings (table): Override the default settings passed when initializing the server.
-- 			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
-- 			local servers = {
-- 				-- LSP Servers
-- 				bashls = {},
-- 				gopls = {},
-- 				eslint = {
-- 					autostart = false,
-- 					cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
-- 					settings = {
-- 						format = false,
-- 					},
-- 				},
-- 				html = {},
-- 				jsonls = {},
-- 				lua_ls = {
-- 					settings = {
-- 						Lua = {
-- 							runtime = { version = "LuaJIT" },
-- 							workspace = {
-- 								checkThirdParty = false,
-- 								-- Tells lua_ls where to find all the Lua files that you have loaded
-- 								-- for your neovim configuration.
-- 								library = {
-- 									"${3rd}/luv/library",
-- 									unpack(vim.api.nvim_get_runtime_file("", true)),
-- 								},
-- 							},
-- 							telemetry = { enabled = false },
-- 						},
-- 					},
-- 				},
-- 				nil_ls = {},
-- 				pyright = {},
-- 				sqlls = {},
-- 				tsserver = {
-- 					settings = {
-- 						maxTsServerMemory = 12288,
-- 						typescript = {
-- 							inlayHints = {
-- 								includeInlayEnumMemberValueHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayParameterNameHints = "all",
-- 								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayVariableTypeHints = true,
-- 								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
-- 							},
-- 						},
-- 						javascript = {
-- 							inlayHints = {
-- 								includeInlayEnumMemberValueHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayParameterNameHints = "all",
-- 								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayVariableTypeHints = true,
-- 								includeInlayVariableTypeHintsWhenTypeMatchesName = true,
-- 							},
-- 						},
-- 					},
-- 					handlers = {
-- 						["textDocument/publishDiagnostics"] = vim.lsp.with(
-- 							tsserver_on_publish_diagnostics_override,
-- 							{}
-- 						),
-- 					},
-- 				},
-- 				yamlls = {},
-- 				rust_analyzer = {},
-- 			}
--
-- 			local formatters = {
-- 				prettierd = {},
-- 				stylua = {},
-- 			}
--
-- 			local manually_installed_servers = { "ocamllsp", "gleam" }
--
-- 			local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))
--
-- 			local ensure_installed = vim.tbl_filter(function(name)
-- 				return not vim.tbl_contains(manually_installed_servers, name)
-- 			end, mason_tools_to_install)
--
-- 			require("mason-tool-installer").setup({
-- 				auto_update = true,
-- 				run_on_start = true,
-- 				start_delay = 3000,
-- 				debounce_hours = 12,
-- 				ensure_installed = ensure_installed,
-- 			})
--
-- 			-- Iterate over our servers and set them up
-- 			for name, config in pairs(servers) do
-- 				require("lspconfig")[name].setup({
-- 					autostart = config.autostart,
-- 					cmd = config.cmd,
-- 					capabilities = capabilities,
-- 					filetypes = config.filetypes,
-- 					handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
-- 					on_attach = on_attach,
-- 					settings = config.settings,
-- 					root_dir = config.root_dir,
-- 				})
-- 			end
--
-- 			-- Setup mason so it can manage 3rd party LSP servers
-- 			require("mason").setup({
-- 				ui = {
-- 					border = "rounded",
-- 				},
-- 			})
--
-- 			require("mason-lspconfig").setup()
--
-- 			-- Configure borderd for LspInfo ui
-- 			require("lspconfig.ui.windows").default_options.border = "rounded"
--
-- 			-- Configure diagnostics border
-- 			vim.diagnostic.config({
-- 				float = {
-- 					border = "rounded",
-- 				},
-- 			})
-- 		end,
-- 	},
-- }

-- return {
--     -- LSP Configuration & Plugins
--     'neovim/nvim-lspconfig',
--     dependencies = {
--         -- Automatically install LSPs to stdpath for neovim
--         'williamboman/mason.nvim',
--         'williamboman/mason-lspconfig.nvim',
--
--         -- Useful status updates for LSP
--         -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--         { 'j-hui/fidget.nvim', opts = {} },
--
--         -- Additional lua configuration, makes nvim stuff amazing!
--         'folke/neodev.nvim',
--     },
--     config = function ()
--
--         require('neodev').setup()
--         require('mason').setup()
--         require('mason-lspconfig').setup()
--
--         local servers = {
--             -- clangd = {},
--             -- gopls = {},
--             -- pyright = {},
--             rust_analyzer = {},
--             tsserver = {},
--             html = { filetypes = { 'html', 'twig', 'hbs'} },
--             ast_grep = {},
--
--             lua_ls = {
--                 Lua = {
--                     workspace = { checkThirdParty = false },
--                     telemetry = { enable = false },
--                     -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--                     -- diagnostics = { disable = { 'missing-fields' } },
--                 },
--             },
--         }
--
--         local on_attach = function(_, bufnr)
--             -- NOTE: Remember that lua is a real programming language, and as such it is possible
--             -- to define small helper and utility functions so you don't have to repeat yourself
--             -- many times.
--             --
--             -- In this case, we create a function that lets us more easily define mappings specific
--             -- for LSP related items. It sets the mode, buffer and description for us each time.
--             local nmap = function(keys, func, desc)
--                 if desc then
--                     desc = 'LSP: ' .. desc
--                 end
--
--                 vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--             end
--
--             nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--             nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--             nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--             nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--             nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--             nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--             nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--             nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--             -- See `:help K` for why this keymap
--             nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--             nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--             -- Lesser used LSP functionality
--             nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--             nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--             nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--             nmap('<leader>wl', function()
--                 print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--             end, '[W]orkspace [L]ist Folders')
--
--             -- Create a command `:Format` local to the LSP buffer
--             vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--                 vim.lsp.buf.format()
--             end, { desc = 'Format current buffer with LSP' })
--         end
--
--         local capabilities = vim.lsp.protocol.make_client_capabilities()
--         capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
--         -- Ensure the servers above are installed
--         local mason_lspconfig = require 'mason-lspconfig'
--
--         mason_lspconfig.setup {
--             ensure_installed = vim.tbl_keys(servers),
--         }
--
--         mason_lspconfig.setup_handlers {
--             function(server_name)
--                 require('lspconfig')[server_name].setup {
--                     capabilities = capabilities,
--                     on_attach = on_attach,
--                     settings = servers[server_name],
--                     filetypes = (servers[server_name] or {}).filetypes,
--                 }
--             end,
--         }
--
--         -- [[ Configure nvim-cmp ]]
--         -- See `:help cmp`
--         local cmp = require 'cmp'
--         -- local luasnip = require 'luasnip'
--         -- require('luasnip.loaders.from_vscode').lazy_load()
--         -- luasnip.config.setup {}
--
--         cmp.setup {
--             -- snippet = {
--             --     expand = function(args)
--             --         luasnip.lsp_expand(args.body)
--             --     end,
--             -- },
--             completion = {
--                 completeopt = 'menu,menuone,noinsert',
--             },
--             mapping = cmp.mapping.preset.insert {
--                 ['<C-n>'] = cmp.mapping.select_next_item(),
--                 ['<C-p>'] = cmp.mapping.select_prev_item(),
--                 ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                 ['<C-Space>'] = cmp.mapping.complete {},
--                 ['<CR>'] = cmp.mapping.confirm {
--                     behavior = cmp.ConfirmBehavior.Replace,
--                     select = true,
--                 },
--                 ['<Tab>'] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_next_item()
--                     -- elseif luasnip.expand_or_locally_jumpable() then
--                     --     luasnip.expand_or_jump()
--                     else
--                         fallback()
--                     end
--                 end, { 'i', 's' }),
--                 ['<S-Tab>'] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     -- elseif luasnip.locally_jumpable(-1) then
--                     --     luasnip.jump(-1)
--                     else
--                         fallback()
--                     end
--                 end, { 'i', 's' }),
--             },
--             sources = {
--                 { name = 'nvim_lsp' },
--                 { name = 'luasnip' },
--                 { name = 'path' },
--             },
--         }
--     end
-- }
--
