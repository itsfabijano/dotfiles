-- Function to copy text to the system clipboard
local function copy_to_clipboard(text)
	vim.fn.setreg("+", text) -- Set the clipboard register
	print("Copied: " .. text)
end

-- Custom commands
vim.api.nvim_create_user_command("CopyFileName", function()
	local filename = vim.fn.expand("%:t") -- Get the current file name
	copy_to_clipboard(filename)
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
	local relative_path = vim.fn.expand("%:.") -- Get the relative path
	copy_to_clipboard(relative_path)
end, {})

vim.api.nvim_create_user_command("CopyFullPath", function()
	local full_path = vim.fn.expand("%:p") -- Get the full path
	copy_to_clipboard(full_path)
end, {})
