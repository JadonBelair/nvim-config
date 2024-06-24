local trouble = require('trouble')

trouble.setup({
	icons = {
		indent = {
			fold_open = "v",
			fold_closed = ">",
		},
		folder_open = "v",
		folder_closed = ">",
	},
    indent_guides = false,
	use_diagnostic_signs = true,
	warn_no_results = false,
	open_no_results = true,
})

vim.keymap.set("n", "ds", "<Cmd>Trouble diagnostics toggle focus=true<CR>")
