local set = vim.keymap.set

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
				git_files = {
					hidden = true,
				},
				live_grep = {
					hidden = true,
				},
				commands = {
					theme = "dropdown",
					entry_maker = function(entry)
						return {
							value = entry,
							ordinal = entry.name, -- Enables filtering
							display = function(e)
								return e.value.name -- Only show the command name
							end,
							cmd = entry.name, -- Ensures execution works
						}
					end,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		local builtin = require("telescope.builtin")

		set({ "n", "t" }, "<C-p>", builtin.git_files, {})
		set("n", "<leader>pf", builtin.find_files, {}) -- [P]roject [F]ilesearch

		-- [P]roject [A]ll Files
		set("n", "<leader>pa", function()
			builtin.find_files(require("telescope.themes").get_dropdown({
				no_ignore = true,
				previewer = false,
				prompt_title = "All Files",
				file_ignore_patterns = { "yarn.lock", "node_modules/", "%.git/" },
			}))
		end)

		set("n", "<leader>pb", builtin.buffers, {}) -- [P]roject [B]uffers
		set("n", "<leader>pd", builtin.git_files, {}) -- [P]roject [D]efault Search
		set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
		set("n", "<leader>pws", builtin.grep_string) -- [P]rep [W]ord [S]earch
		set("n", "<leader>ps", builtin.live_grep) -- [P]roject [S]earch
		set("n", "<leader>vh", builtin.help_tags, {}) -- [V]iew [H]elp
		set("n", "<leader>pc", builtin.commands, {}) -- [P]roject [C]ommands
	end,
}
