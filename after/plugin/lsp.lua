vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	callback = function(event)
		local opts = { buffer = event.buf, remap = false }

		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "<Leader>k", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end
})

require('mason').setup({})

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = 'E',
			[vim.diagnostic.severity.WARN] = 'W',
			[vim.diagnostic.severity.HINT] = 'H',
			[vim.diagnostic.severity.INFO] = 'I'
		}
	}
})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function (args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	sources = {
		{name = 'path'},
		{name = 'nvim_lsp'},
		{name = "luasnip" },
	},
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

require('lazydev').setup({})
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
})
vim.lsp.enable("lua_ls")

vim.lsp.config("zls", {
	capabilities = capabilities,
	settings = {
		zls = {
			enable_build_on_save = true,
		}
	}
})
vim.lsp.enable("zls")

vim.lsp.config("ocamllsp", { capabilities = capabilities })
vim.lsp.enable("ocamllsp")

vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "off",
			}
		}
	}
})
vim.lsp.enable("basedpyright")

vim.lsp.config("clangd", { capabilities = capabilities })
vim.lsp.enable("clangd")

vim.g.rustaceanvim = {
	server = {
 		capabilities = capabilities,
 		on_attach = function(_, bufnr)
 			vim.keymap.set("n", "<Leader>k", function () vim.cmd.RustLsp { 'hover', 'actions' } end, { buffer = bufnr })
 			vim.keymap.set("n", "<Leader>a", function () vim.cmd.RustLsp('codeAction') end, { buffer = bufnr })
			vim.lsp.inlay_hint.enable(true)
 		end,
	},
	tools = {
		hover_actions = { auto_focus = true },
		enable_clippy = false,
	}
}

vim.g.rustfmt_emit_files = 1
vim.g.rustfmt_autosave = 1
