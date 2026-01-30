-- local function harpoon_section()
-- 	local harpoon = require("harpoon")
--
-- 	return {
-- 		title = "Harpoon Hooks",
-- 		icon = "📍",
-- 		setup = function()
-- 			-- called only once and if the section is being used
-- 		end,
-- 		update = function()
-- 			-- hook callback, called when an update was requested by either the user of external events (using autocommands)
-- 		end,
-- 		draw = function()
-- 			local items = harpoon:list().items
-- 			local harpoon_marks = {}
-- 			local function generate_lines()
-- 				harpoon_marks = {}
-- 				for i, item in ipairs(items) do
-- 					table.insert(harpoon_marks, string.format("[%d] %s", i, item.value))
-- 				end
-- 			end
-- 			generate_lines()
--
-- 			return table.concat(harpoon_marks, "\n")
-- 		end,
-- 	}
-- end

local function project_name()
	local cwd = vim.fn.getcwd()
	local name = cwd:match("([^/]+)$")
	return {
		title = "Project",
		draw = function()
			return name
		end,
	}
end

return {
	"sidebar-nvim/sidebar.nvim",
	enabled = true,
	config = function()
		local sidebar = require("sidebar-nvim")
		sidebar.setup({
			sections = { project_name() },
			initial_width = 120,
			open = false,
			disable_default_keybindings = false,
		})

		vim.keymap.set("n", "<leader>sb", sidebar.toggle)
	end,
}
