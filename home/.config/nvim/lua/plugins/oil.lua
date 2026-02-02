return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		CustomOilBar = function()
			local path = vim.fn.expand("%")
			path = path:gsub("oil://", "")

			return "  " .. vim.fn.fnamemodify(path, ":.")
		end

		require("oil").setup({
			columns = { "icon" },
			confirmation = {
				border = "rounded",
			},
			float = {
				border = "rounded",
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-r>"] = "actions.refresh",
				["<C-l>"] = false,
				["<C-k>"] = false,
				["<C-j>"] = false,
				["<C-p>"] = false,
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
			},
			win_options = {
				winbar = "%{v:lua.CustomOilBar()}",
			},
			keymaps_help = {
				border = "rounded",
			},
			progress = {
				border = "rounded",
				minimized_border = "rounded",
			},
			ssh = {
				border = "rounded",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".DS_Store"
				end,
			},
		})

		-- Open parent directory in current window
		vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		-- Open parent directory in floating window
		vim.keymap.set("n", "<space>-", require("oil").toggle_float)
	end,
}
