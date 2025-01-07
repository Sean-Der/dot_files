vim.cmd.colorscheme '256_jungle'

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.wrap = false
vim.opt.mouse = ''

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- :e is relative to current file
vim.opt.autochdir = true

-- reserve git gutter
vim.opt.signcolumn = 'yes'

-- Leaving modes in Emacs+EVIL feels right
vim.keymap.set({'n', 'i', 'v', 'x', '!'}, '<C-g>', '<Esc>')
vim.keymap.set('t', '<C-g>', '<C-\\><C-n>')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath}
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'lewis6991/gitsigns.nvim',
    config = function()
      local signs = {
          add          = { text = '+' },
          change       = { text = '~' },
          delete       = { text = '-' },
          topdelete    = { text = '-' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        }
      require('gitsigns').setup({signs = signs, signs_staged = signs})
    end
  },
  { 'ibhagwan/fzf-lua',  -- Search
    config = function()
      require('fzf-lua').setup({ keymap = { builtin = { true, ['<C-g>'] = 'hide' } } })

      local fzf = require 'fzf-lua'
      vim.keymap.set('n', '<leader>g', fzf.live_grep)
      vim.keymap.set('n', '<leader>o', fzf.files)
      vim.keymap.set('n', '<leader>s', fzf.grep_cword)
      vim.keymap.set('n', '<leader>m', fzf.oldfiles)
      vim.keymap.set('n', '<leader>r', fzf.registers)
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "j-hui/fidget.nvim",
    },
    config = function()
      require('lspconfig').gopls.setup({
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

      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

      require("fidget").setup({})
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer',  keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end
  },
  { 'mfussenegger/nvim-lint',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            go = { 'golangcilint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
  },
  { 'stevearc/conform.nvim',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          ['*'] = { 'trim_whitespace' },
        },
      })
    end
  },
  { 'folke/trouble.nvim',
    opts = {
      modes = {
        diagnostics = { auto_open = true, auto_close = true },
      },
    }
  },
})
