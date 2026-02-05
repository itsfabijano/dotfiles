return {
	"stevearc/conform.nvim",
	opts = {},
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		local conform = require("conform")
		local mason_tools = require("mason-tool-installer")

		mason_tools.setup({
			ensure_installed = {
				"prettierd",
				"biome",
				"stylua",
				"black",
			},
		})

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "biome", "prettierd", stop_after_first = true },
				javascriptreact = { "prettierd" },
				typescriptreact = { "biome", "prettierd", stop_after_first = true },
				json = { "prettierd" },
				lua = { "stylua" },
				graphql = { "prettierd" },
				python = { "black" },
				astro = { "prettierd" },
				yaml = { "prettierd" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
			formatters = {
				biome = {
					condition = function(self, ctx)
						return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1]
							~= nil
					end,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
