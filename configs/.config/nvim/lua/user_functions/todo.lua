local M = {}

local function expand_path(path)
  -- This function expands the path if it starts with '~' to full home directory path
  if path:sub(1, 1) == '~' then
    return os.getenv("HOME") .. path:sub(2)
  else
    return path
  end
end

local function win_config()
  -- This function returns the window style configuration
  local width = math.min(math.floor(vim.o.columns * 0.8), 64)
  local height = math.floor(vim.o.lines * 0.8)
  return {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'single',
    title = 'Todo List',
    title_pos = 'center',
    focusable = true,
    footer = "q:close, @c:convert to checklist, @x: mark as done, dd: delete task",
    footer_pos = 'center',
  }
end

local function open_floating_file(target_file)
  local expanded_path = expand_path(target_file)
  -- check if the file existing
  if vim.fn.filereadable(expanded_path) == 0 then
    vim.notify("Todo file does not exist: " .. expanded_path, vim.log.levels.ERROR)
    -- if the file does not exist, create it
    return
  end
  local buf = vim.fn.bufnr(expanded_path, true)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(buf, expanded_path)
  end

  -- This ignore swapfile for the floating window if it's opened somewhere else
  vim.bo[buf].swapfile = false

  -- Open the buffer in a floating window
  vim.api.nvim_open_win(buf, true, win_config())

  -- Close the floating window when 'q' is pressed
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
end

local function setup_user_commands(opts)
  -- optional parameters for the target file
  local default_target_file = "~/notes/todo.md"
  local target_file = opts.target_file
  if not target_file then
    target_file = default_target_file
  end
  -- This function sets up user commands
  vim.api.nvim_create_user_command(
    'TodoList',
    function()
      -- Open the target file in a new tab
      open_floating_file(target_file)
    end,
    {
      desc = "Open the todo list file in a floating window",
      nargs = 0,
    }
  )
end

M.setup = function(opts)
  -- This function sets up the module and takes optional parameters
  setup_user_commands(opts or {})
end
return M
