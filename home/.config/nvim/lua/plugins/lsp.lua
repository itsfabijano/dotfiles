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
		"j-hui/fidget.nvim",
	},
	enable = os.getenv("NVIM_F_LSP") == "1",

	config = function()
		require("fidget").setup({})

		-- Suppress window/showMessage for info level and below, show warnings and errors
		-- Workaround for noisy csharp_ls
		vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
			if result.type <= vim.lsp.log_levels.INFO then
				return -- Suppress info and debug messages
			end
		end

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"eslint",
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"graphql",
				"pylsp",
				"jsonls",
				"marksman",
				"vtsls",
				"copilot",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["vtsls"] = function()
					require("lspconfig").vtsls.setup({
						root_dir = require("lspconfig").util.root_pattern(
							".git",
							"pnpm-workspace.yaml",
							"pnpm-lock.yaml",
							"yarn.lock",
							"package-lock.json",
							"bun.lockb"
						),
						typescript = {
							tsserver = {
								maxTsServerMemory = 12288,
							},
						},
						experimental = {
							completion = {
								entriesLimit = 3,
							},
						},
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_init = function(client)
							if client.workspace_folders then
								local path = client.workspace_folders[1].name
								if
									path ~= vim.fn.stdpath("config")
									and (
										vim.uv.fs_stat(path .. "/.luarc.json")
										or vim.uv.fs_stat(path .. "/.luarc.jsonc")
									)
								then
									return
								end
							end

							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									-- Tell the language server which version of Lua you're using
									-- (most likely LuaJIT in the case of Neovim)
									version = "LuaJIT",
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
										vim.fn.stdpath("data") .. "/lazy/snacks.nvim",
										-- Depending on the usage, you might want to add additional paths here.
										-- "${3rd}/luv/library"
										-- "${3rd}/busted/library",
									},
									-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
									-- library = vim.api.nvim_get_runtime_file("", true)
								},
							})
						end,

						settings = {
							Lua = {
								-- runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,

				pylsp = function()
					local lspconfig = require("lspconfig")
					lspconfig.pylsp.setup({
						capabilities = capabilities,
						settings = {
							pylsp = {
								plugins = {
									pycodestyle = { enabled = false },
								},
							},
						},
					})
				end,

				csharp_ls = function()
					local lspconfig = require("lspconfig")
					lspconfig.csharp_ls.setup({
						cmd = { vim.fn.exepath("csharp-ls") },
						capabilities = capabilities,
						settings = {
							csharp = {
								roslyn = {
									analyzers = true, -- Enable Roslyn analyzers for better diagnostics
								},
							},
						},
					})
				end,

				copilot = function()
					require("lspconfig").copilot.setup({
						capabilities = capabilities,
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
