vim.cmd.colorscheme("256_jungle")

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.wrap = false
vim.opt.mouse = ""

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- :e is relative to current file
vim.opt.autochdir = true

-- reserve git gutter
vim.opt.signcolumn = "yes"

-- Leaving modes in Emacs+EVIL feels right
vim.keymap.set({ "n", "i", "v", "x", "!" }, "<C-g>", "<Esc>")
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>")

-- Don't yank on paste
vim.keymap.set("x", "p", "P", { silent = true })

vim.pack.add({
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/ibhagwan/fzf-lua",

	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/j-hui/fidget.nvim",

	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/stevearc/conform.nvim",

	"https://github.com/folke/trouble.nvim.git",
})

local signs = {
	add = { text = "+" },
	change = { text = "~" },
	delete = { text = "-" },
	topdelete = { text = "-" },
	changedelete = { text = "~" },
	untracked = { text = "┆" },
}
require("gitsigns").setup({ signs = signs, signs_staged = signs })

local fzf = require("fzf-lua")
fzf.setup({ keymap = { builtin = { true, ["<C-g>"] = "hide" } } })
vim.keymap.set("n", "<leader>g", fzf.live_grep)
vim.keymap.set("n", "<leader>o", fzf.files)
vim.keymap.set("n", "<leader>s", fzf.grep_cword)
vim.keymap.set("n", "<leader>m", fzf.oldfiles)
vim.keymap.set("n", "<leader>r", fzf.registers)

-- Disable LSP syntax hightlight
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.lsp.config("gopls", {
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	),
	settings = {
		gopls = {
			analyses = {
				shadowed = true,
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})
vim.lsp.enable("gopls")

require("fidget").setup({})
local cmp = require("cmp")
cmp.setup({
	completion = {
		autocomplete = false,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 2 },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.mapping.complete()(fallback)
				cmp.select_next_item({ count = 0 })
			end
		end,
		["<C-p>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.mapping.complete()(fallback)
				cmp.select_prev_item({ count = 0 })
			end
		end,
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
})

local lint = require("lint")
lint.linters_by_ft = { go = { "golangcilint" } }
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

require("conform").setup({
	formatters_by_ft = {
		go = { "goimports" },
		python = { "ruff", "isort" },
		["*"] = { "trim_whitespace" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("trouble").setup({
	modes = {
		diagnostics = {
			auto_open = true,
			auto_close = true,
			filter = {
				buf = 0,
			},
		},
	},
})
