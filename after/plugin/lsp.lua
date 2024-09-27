local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "<Leader>k", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- ensure_installed = {"lua_ls", "zls"},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
		-- let rustaceanvim handle the setup
		rust_analyzer = lsp_zero.noop,
	},
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp'},
		{name = 'nvim_lua'},
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<C-k>'] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = nil,
		["<S-Tab>"] = nil,
	}),
})

lsp_zero.set_sign_icons({
	error = 'E',
	warn = 'W',
	hint = 'H',
	info = 'I'
})


lsp_zero.setup()

vim.g.rustaceanvim = {
	server = {
 		capabilities = require("cmp_nvim_lsp").default_capabilities(),
 		on_attach = function(_, bufnr)
 			vim.keymap.set("n", "<Leader>k", function () vim.cmd.RustLsp { 'hover', 'actions' } end, { buffer = bufnr })
 			vim.keymap.set("n", "<Leader>a", function () vim.cmd.RustLsp('codeAction') end, { buffer = bufnr })
			-- requires neovim v0.10 or higher
			vim.lsp.inlay_hint.enable(true)
 		end,
	},
	tools = {
		hover_actions = {
			auto_focus = true
		},
		enable_clippy = false,
	}
}

vim.diagnostic.config({
	virtual_text = true
})
