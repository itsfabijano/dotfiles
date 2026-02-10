return {
	"ThePrimeagen/99",
	config = function()
		local _99 = require("99")

		_99.setup({
			completion = {
				custom_rules = {
					"scratch/custom_rules/",
				},
				source = "cmp",
			},
			md_files = {
				"AGENT.md",
			},
		})

		vim.keymap.set("v", "<leader>9vv", function()
			_99.visual()
		end)
		-- this is some comment
		vim.keymap.set("v", "<leader>9vp", function()
			_99.visual_prompt()
		end)

		vim.keymap.set("n", "<leader>9s", function()
			_99.stop_all_requests()
		end)
		vim.keymap.set("n", "<leader>9i", function()
			_99.info()
		end)
		vim.keymap.set("n", "<leader>9l", function()
			_99.view_logs()
		end)
		vim.keymap.set("n", "<leader>9n", function()
			_99.next_request_logs()
		end)
		vim.keymap.set("n", "<leader>9p", function()
			_99.prev_request_logs()
		end)
	end,
}
