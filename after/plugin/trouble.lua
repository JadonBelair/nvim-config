local trouble = require('trouble')

trouble.setup({
	icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
	use_diagnostic_signs = true,
})

vim.keymap.set("n", "ds", trouble.toggle)
