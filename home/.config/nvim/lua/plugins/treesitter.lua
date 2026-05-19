return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			treesitter.install({
				"vimdoc",
				"javascript",
				"typescript",
				"lua",
				"jsdoc",
				"bash",
				"go",
				"yaml",
				"dockerfile",
				"json",
				"nix",
			})

			local function is_installed(lang)
				local installed = treesitter.get_installed()
				return vim.list_contains(installed, lang)
			end

			local function enable(bufnr)
				local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
				if not ok or not parser then
					return
				end
				pcall(vim.treesitter.start)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					local lang = vim.treesitter.language.get_lang(ft)

					local bufnr = args.buf

					if is_installed(lang) then
						enable()
						return
					end

					if not vim.list_contains(treesitter.get_available(), lang) then
						return
					end

					treesitter.install(lang):await(function()
						if not vim.api.nvim_buf_is_loaded(bufnr) then
							return
						end
						enable(bufnr)
					end)
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
