local augroup = vim.api.nvim_create_augroup
local MyGroup = augroup("MyGroup", {})
local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	group = MyGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		-- [G]o [D]efinition
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)

		-- [V]iew [R]efe[r]ence
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)

		-- [K]ay, how me more
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				border = "rounded",
			})
		end, opts)

		-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

		-- [V]iew [D]iagnostics
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		local builtin = require("telescope.builtin")

		-- [V]iew [S]ymbols
		vim.keymap.set("n", "<leader>vs", builtin.lsp_document_symbols, { buffer = 0 })
	end,
})
