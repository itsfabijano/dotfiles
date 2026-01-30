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
				"stylua",
				"black",
			},
		})

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
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
