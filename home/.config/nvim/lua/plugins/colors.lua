function ColorRefresh(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)
	local p = require("rose-pine.palette")
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#046e30" })
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#950606" })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2F4146" })
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#463C2F" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				extend_background_behind_borders = true,
				enable = {
					terminal = false,
				},
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*",
				callback = function()
					vim.opt_local.winhighlight = "Normal:Terminal,NormalNC:Terminal"
				end,
			})
			ColorRefresh()
		end,
	},
}
