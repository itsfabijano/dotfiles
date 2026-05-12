return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		enable = os.getenv("NVIM_F_LSP") == "1",

		config = function()
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Get all installed mason packages and set them up
			local mason_lspconfig = require("mason-lspconfig")
			local installed_servers = mason_lspconfig.get_installed_servers()

			vim.lsp.config("vtsls", {
				settings = {
					complete_function_calls = true,
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						preferences = {
							importModuleSpecifier = "shortest",
							importModuleSpecifierEnding = "minimal",
							includePackageJsonAutoImports = "on",
						},
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
					javascript = {
						updateImportsOnFileMove = { enabled = "always" },
						preferences = {
							importModuleSpecifier = "shortest",
							importModuleSpecifierEnding = "minimal",
							includePackageJsonAutoImports = "on",
						},
					},
				},
			})

			for _, server_name in ipairs(installed_servers) do
				vim.lsp.enable(server_name)
			end
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Insert }
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
			})
		end,
	},
}
