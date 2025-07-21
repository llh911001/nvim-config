-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Disable move Lines, in /lua/lazyvim/config/keymaps.lua
map({ "n", "i", "v" }, "<A-j>", "<Nop>", { desc = "Do nothing" })
map({ "n", "i", "v" }, "<A-k>", "<Nop>", { desc = "Do nothing" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>z", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer or Close Window" })

-- Clear search with <leader>/
map({ "i", "n" }, "<leader>/", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map({ "i", "n" }, "<esc>", "<esc>", { desc = "Escape and Clear hlsearch" })

-- Formatting
map({ "n", "v" }, "<leader>,", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "gj", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "gk", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "g]", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "g[", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

-- Alternative copy/paste
map("x", "<leader>c", '"_c', { desc = "Copy without having your register overwritten" })
map("x", "<leader>p", '"_dP', { desc = "Paste without having your register overwritten" })

-- Function to convert snake_case to camelCase
local function snake_to_camel()
  -- Get the visual selection
  local start_line, start_col = vim.fn.line("'<"), vim.fn.col("'<")
  local end_line, end_col = vim.fn.line("'>"), vim.fn.col("'>")
  -- Get the selected text
  local lines = vim.fn.getline(start_line, end_line)
  local selected_text = lines[1]:sub(start_col, end_col)
  -- Convert snake_case to camelCase
  local camel_text = selected_text:gsub("_(%l)", function(c)
    return c:upper()
  end)
  -- Replace the selected text
  vim.api.nvim_buf_set_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, { camel_text })
end

-- Create a direct mapping for visual mode
map("x", "<leader>sc", function()
  snake_to_camel()
end, { noremap = true, silent = true, desc = "Convert snake_case to camelCase" })
