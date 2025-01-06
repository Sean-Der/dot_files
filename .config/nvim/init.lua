vim.cmd.colorscheme '256_jungle'

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.wrap = false

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- :e is relative to current file
vim.opt.autochdir = true

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
      require("fzf-lua").setup({ keymap = { builtin = { true, ["<C-g>"] = "hide" } } })

      local fzf = require 'fzf-lua'
      vim.keymap.set('n', '<leader>g', fzf.live_grep)
      vim.keymap.set('n', '<leader>o', fzf.files)
      vim.keymap.set('n', '<leader>s', fzf.grep_cword)
      vim.keymap.set('n', '<leader>m', fzf.oldfiles)
      vim.keymap.set('n', '<leader>r', fzf.registers)
    end
  },
  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        ensure_installed = {'c', 'c', 'cpp', 'go', 'html', 'lua', 'python', 'vim', 'vimdoc'},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
})
