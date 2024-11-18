vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})
vim.opt.relativenumber = true
vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

require('pm') --loads lazy.nvim

vim.cmd.colorscheme('tokyonight')

require('nvim-autopairs').setup({})
require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  per_filetype = {
    ["html"] = {
      enable_close = true
    }
  }
})

require('lsp')
