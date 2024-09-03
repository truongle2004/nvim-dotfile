return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"prettier",
				"eslint",
				"typescript-language-server",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			-- import lspconfig plugin

			local lspconfig = require("lspconfig")

			local util = require("lspconfig.util")

			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			local customizations = {
				{ rule = "style/*", severity = "off", fixable = true },
				{ rule = "format/*", severity = "off", fixable = true },
				{ rule = "*-indent", severity = "off", fixable = true },
				{ rule = "*-spacing", severity = "off", fixable = true },
				{ rule = "*-spaces", severity = "off", fixable = true },
				{ rule = "*-order", severity = "off", fixable = true },
				{ rule = "*-dangle", severity = "off", fixable = true },
				{ rule = "*-newline", severity = "off", fixable = true },
				{ rule = "*quotes", severity = "off", fixable = true },
				{ rule = "*semi", severity = "off", fixable = true },
			}

			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				root_dir = util.root_pattern(
					".eslintrc",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json"
					-- Disabled to prevent "No ESLint configuration found" exceptions
					-- 'package.json',
				),
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
					"html",
					"markdown",
					"json",
					"jsonc",
					"yaml",
					"toml",
					"xml",
					"gql",
					"graphql",
					"astro",
					"svelte",
					"css",
					"less",
					"scss",
					"pcss",
					"postcss",
				},
				settings = {
					-- Silent the stylistic rules in you IDE, but still auto fix them
					rulesCustomizations = customizations,
				},
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				commands = {
					OrganizeImports = {
						organize_imports,
						description = "Organize Imports",
					},
				},
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			})
		end,
	},
}
