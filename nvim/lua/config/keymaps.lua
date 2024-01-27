-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local map = vim.keymap.set

-- Bufferline (Tabs)
if Util.has("bufferline.nvim") then
  map("n", "gT", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer", remap = true })
  map("n", "gt", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer", remap = true })
end

-- Editing
map("i", "<C-Bs>", "<C-w>", { desc = "C-w", remap = true })
map({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Window
map("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })

map("n", "<leader>wm", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<leader>wn", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<leader>we", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<leader>wi", "<C-w>l", { desc = "Go to right window", remap = true })

local function close_floats()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

map("n", "<esc>", close_floats, { desc = "Close floats" })

-- Buffers
map("n", "<leader>bp", function()
  require("custom.bufferhistory").go_back()
end, { desc = "Go to previous buffer" })

map("n", "<leader>bn", function()
  require("custom.bufferhistory").go_forward()
end, { desc = "Go to previous buffer" })

-- map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Go to next buffer" })
map("n", "<leader>bk", "<leader>bd<cr>", { desc = "Close buffer", remap = true })
map("n", "<leader>bK", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })

-- Lines
map("n", "<M+j>", "<cmd>m+<cr>", { desc = "Move line down one step", remap = true })

-- Neotree
vim.keymap.del("n", "<leader>e")
map("n", "<leader>op", "<cmd>Neotree<cr>", { desc = "Open Neotree" })

-- Code actions
map("n", "<leader>cd", "gd", { desc = "Go to code definition", remap = true })
map("n", "<leader>cR", "gr", { desc = "Find references", remap = true })
map("n", "<leader>c.", "<leader>ca", { desc = "Code actions", remap = true })
map("n", "<C-.>", vim.lsp.buf.hover, { desc = "Show signature under cursor", remap = true, silent = true })

-- Diagnostics
map("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", remap = true })
map("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic", remap = true })

map("n", "<leader>ek", vim.diagnostic.open_float, { desc = "Show full error", remap = true })
map("n", "<leader>eK", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

map("n", "<leader>el", "<cmd>Trouble document_diagnostics<cr>", { desc = "Show all diagnostics in document" })
map("n", "<leader>eL", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Show all diagnostics in workspace" })

-- Telescope
map("n", "<leader>pp", "<cmd>Telescope projects<cr>", { desc = "Telescope projects" })
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })

-- Git
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Telescope projects" })

map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Telescope projects" })

map("n", "<leader>c", require("osc52").copy_operator, { expr = true })
map("n", "<leader>cc", "<leader>c_", { remap = true })
map("v", "<leader>c", require("osc52").copy_visual)

-- Disable horizontal scrolling with mouse wheel
map("n", "<ScrollWheelRight>", "<Nop>", { noremap = true, silent = true })
map("n", "<ScrollWheelLeft>", "<Nop>", { noremap = true, silent = true })
