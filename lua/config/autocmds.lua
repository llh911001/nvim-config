-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Open neo-tree on enter",
  group = "neotree_autoopen",
  once = true,
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd("Neotree show")
      vim.g.neotree_opened = true
    end
  end,
})
