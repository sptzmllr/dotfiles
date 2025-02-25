-- Vista-Standard-Executor auf LSP setzen
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_sidebar_width = 45
vim.g.vista_echo_cursor_strategy = 'both'

-- Funktion zum Setzen eines Keybindings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>v', ':Vista!!<CR>', opts)

vim.g.vista_executive_for = {
  cpp = 'nvim_lsp',  -- Verwende 'vim_lsp' für C++-Dateien
  md = 'toc',  -- Verwende 'vim_lsp' für PHP-Dateien
}

