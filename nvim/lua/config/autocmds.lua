-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

--- Auto root
-- Array of file names indicating root directory. Modify to your liking.
local root_names = { ".git", "Makefile" }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return
  end
  path = vim.fs.dirname(path)

  print("Current path", path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file == nil then
      return
    end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  print("Change dir to", root)

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup("MyAutoRoot", {})
-- vim.api.nvim_create_autocmd("BufEnter", { group = root_augroup, callback = set_root })

-- Signatures
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = root_augroup,
--   callback = function()
--     local winid = vim.api.nvim_get_current_win()
--     local col = vim.fn.getcursorcharpos()[3]
--
--     -- local _, col = vim.api.nvim_win_get_cursor(winid)
--     -- print(col)
--     --
--     local line = vim.api.nvim_get_current_line()
--     local char = line:sub(col, col)
--
--     if char ~= " " then
--       vim.lsp.buf.hover()
--     end
--   end,
-- })

local function copy()
  if (vim.v.event.operator == "d" or vim.v.event.operator == "y") and vim.v.event.regname == "" then
    require("osc52").copy_register("+")
  end
end

vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "wgsl",
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    -- vim.opt_local.comments = "//"
    vim.opt_local.commentstring = "// %s"
  end,
})
