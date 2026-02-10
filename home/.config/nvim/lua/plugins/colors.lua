function ColorRefresh(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)
	vim.o.winborder = "single"
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
