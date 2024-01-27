local BufferHistory = {
  file_stack = {},
  current_index = 0,
}

local BH = BufferHistory
local H = {}

local did_navigate = false

--- Module setup
---
---@param config table|nil Module config table.
---
---@usage `require('mini.completion').setup({})` (replace `{}` with your `config` table)
BufferHistory.setup = function(config)
  -- Export module
  _G.BufferHistory = BufferHistory

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Define behavior
  H.create_autocommands()
end

--- Module config
---
--- Default values:
-----@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
BufferHistory.config = {
  cycle = true,
}
--minidoc_afterlines_end

-- Module functionality =======================================================

-- Function to remove a file from the stack
-- @param file The file to remove
function BufferHistory.remove_file(file)
  if file == "" then
    return
  end

  -- Remove any previous occurrence of the file
  for i, f in ipairs(BH.file_stack) do
    if f == file then
      print("REMOVE", f)

      table.remove(BH.file_stack, i)
      if i <= BH.current_index then
        BH.current_index = BH.current_index - 1
      end
      break
    end
  end
end

-- Function to push a file to the stack
-- @param file The file to push
function BufferHistory.push_file(file)
  if file == "" then
    return
  end

  BufferHistory.remove_file(file)

  -- Push the new file to the top and update index
  table.insert(BH.file_stack, file)
  BH.current_index = #BH.file_stack
end

-- Function to go back in the stack
function BufferHistory.go_back()
  if BH.config.cycle and BH.current_index == 1 then
    BH.current_index = #BH.file_stack + 1
  end

  if BH.current_index > 1 then
    BH.current_index = BH.current_index - 1
    did_navigate = true
    vim.cmd("edit " .. BH.file_stack[BH.current_index])
  else
    print("Already at the bottom of the stack")
  end
end

-- Function to go forward in the stack
function BufferHistory.go_forward()
  if BH.config.cycle and BH.current_index == #BH.file_stack then
    BH.current_index = 0
  end

  if BH.current_index < #BH.file_stack then
    BH.current_index = BH.current_index + 1
    did_navigate = true
    vim.cmd("edit " .. BH.file_stack[BH.current_index])
  end
end

-- Function to print history
function BufferHistory.print_history()
  vim.print(BH.file_stack)
end

-- Helper data ================================================================
-- Module default config
H.default_config = vim.deepcopy(BufferHistory.config)

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, "table", true } })
  config = vim.tbl_deep_extend("force", vim.deepcopy(H.default_config), config or {})

  -- Validate per nesting level to produce correct error message
  -- vim.validate({
  --   modes = { config.modes, 'table' },
  --   mappings = { config.mappings, 'table' },
  -- })

  return config
end

H.apply_config = function(config)
  BufferHistory.config = config
end

H.create_autocommands = function()
  local augroup = vim.api.nvim_create_augroup("BufferHistory", {})

  local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
  end

  au("BufEnter", { "*" }, function(args)
    if args.file == "" then
      return
    end

    if did_navigate then
      did_navigate = false
      return
    end

    BufferHistory.push_file(args.file)
  end)

  au("BufUnload", { "*" }, function(args)
    vim.print("UNLOAD", args, args.file)

    if args.file == "" then
      return
    end

    BufferHistory.remove_file(args.match)

    print("new history:")
    BufferHistory.print_history()
  end)
end

-- Autocommand to push the file to the stack when opened
-- vim.cmd([[
--   augroup FileStack
--     autocmd!
--     autocmd BufEnter * lua M.push_file(vim.fn.expand('<afile>:p'))
--   augroup END
-- ]])

return BufferHistory
