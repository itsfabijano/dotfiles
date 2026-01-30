return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@diagnostic disable-next-line: undefined-doc-name
	---@type snacks.Config
	opts = {
		lazygit = {
			enabled = true,
		},
		bigfile = {
			enabled = true,
		},
		indent = {
			enabled = true,
			priority = 1,
			only_scope = false,
			only_current = false,
			scope = {
				enabled = true,
			},
			animate = {
				enabled = false,
			},
		},
		quickfile = {
			enabled = true,
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		-- Ensure indent is enabled after setup
		vim.schedule(function()
			require("snacks").indent.enable()
			-- Make indent lines more visible
			vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#403d52" }) -- regular indent lines
			vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#7a7788" }) -- even darker
		end)
	end,
	keys = {
		{
			"<leader>gs",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
