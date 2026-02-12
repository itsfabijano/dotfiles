return {
	"ThePrimeagen/99",
	config = function()
		---@type _99
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
			_99.visual({
				additional_prompt = [[
                    Analyze the selected code and determine what needs to be done.
                    If the selection contains TODO comments, notes, or incomplete sections, implement or finalize them.
                    If the selection contains placeholder code, replace it with proper implementation.
                    If the selection contains comments describing functionality, implement that functionality.
                    Consider the surrounding context to understand what the code should do and make the necessary changes.
                    Make no mistakes. Make it secure.
                ]],
			})
		end)

		vim.keymap.set("n", "<leader>9q", function()
			_99.search({
				open_to_qfix = true,
			})
		end)

		vim.keymap.set("v", "<leader>9vp", function()
			_99.visual()
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
