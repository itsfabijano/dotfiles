return {
	"stevearc/conform.nvim",
	opts = {},
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		local conform = require("conform")
		local mason_tools = require("mason-tool-installer")

		mason_tools.setup({
			ensure_installed = {
				"oxfmt",
				"prettierd",
				"biome",
				"stylua",
				"black",
				"csharpier",
			},
		})

		conform.setup({
			formatters_by_ft = {
				javascript = { "oxfmt", "prettierd", stop_after_first = true },
				typescript = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				javascriptreact = { "oxfmt", "prettierd", stop_after_first = true },
				typescriptreact = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				json = { "oxfmt", "biome", "prettierd", stop_after_first = true },
				lua = { "stylua" },
				graphql = { "oxfmt", "prettierd", stop_after_first = true },
				python = { "black" },
				astro = { "prettierd" },
				yaml = { "oxfmt", "prettierd", stop_after_first = true },
				cs = { "csharpier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
			formatters = {
				-- Only enable these when their project configuration is found.
				oxfmt = {
					require_cwd = true,
				},
				biome = {
					require_cwd = true,
				},
				prettier = {
					require_cwd = true,
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
