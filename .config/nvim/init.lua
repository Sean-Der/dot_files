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
      require('gitsigns').setup()


    end
  },
  { 'nvim-telescope/telescope.nvim',  -- Search
    branch = '0.1.x', 
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-g>"] = { "<esc>", type = "command" },
              ['<C-g>'] = require("telescope.actions").close,
            },
          },
        },
      }

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>g', builtin.live_grep)
      vim.keymap.set('n', '<leader>o', builtin.find_files)
      vim.keymap.set('n', '<leader>s', builtin.grep_string)
      vim.keymap.set('n', '<leader>m', builtin.oldfiles)
      vim.keymap.set('n', '<leader>r', builtin.registers)
    end
  }
 })
