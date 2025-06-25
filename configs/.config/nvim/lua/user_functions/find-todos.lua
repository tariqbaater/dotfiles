local M = {}

-- TODO: make the UI more user friendly

local function map_data(file, dir, data)
  local full_path = dir .. "/" .. file
  -- safely read file with error handling
  local ok, lines = pcall(vim.fn.readfile, full_path)
  if not ok then
    vim.notify("Error reading file: " .. full_path, vim.log.levels.ERROR)
    return
  end

  -- iterate through the lines of the file
  for index, value in ipairs(lines) do
    -- check if the file has todo comments
    local find = string.find(value, "TODO:")
    -- if it does, add the file name and line number to the data table
    if find then
      table.insert(data, {
        path = full_path,
        file_name = file,
        col_idx = find,
        row = index,
        content = value:sub(find), -- store the TODO comment content
      })
    end
  end
end

local function get_files(dir)
  -- declare a table that will hold the file names
  local return_files = {}

  -- safely read directory with error handling
  local ok, files = pcall(vim.fn.readdir, dir)
  if not ok then
    vim.notify("Error reading directory: " .. dir, vim.log.levels.ERROR)
    return return_files
  end

  -- iterate through the current directory
  for _, file in ipairs(files) do
    -- skip hidden files
    if vim.startswith(file, ".") then
      goto continue
    end

    -- declare the full path of the file
    local full_path = dir .. "/" .. file

    -- safely check if path is directory
    local ok_dir, is_dir = pcall(function()
      return vim.fn.isdirectory(full_path) == 1
    end)

    if not ok_dir then
      vim.notify("Error checking directory: " .. full_path, vim.log.levels.WARN)
      goto continue
    end

    -- if the file is not a directory, process it
    if not is_dir then
      map_data(file, dir, return_files)
    else
      -- iterate through the files in the subdirectory
      for _, sub_file in ipairs(get_files(full_path)) do
        table.insert(return_files, sub_file)
      end
    end
    ::continue::
  end
  return return_files
end


function M.setup()
  vim.api.nvim_create_user_command("TodoComments", function()
    local files = get_files(vim.fn.getcwd())
    local buf = vim.api.nvim_create_buf(false, true)
    local current_buf = vim.api.nvim_get_current_buf()

    -- Calculate window dimensions
    local width = math.min(math.floor(vim.o.columns * 0.8), 64)
    local height = math.floor(vim.o.lines * 0.8)

    local lines = {}
    -- Add a header line
    table.insert(lines, string.rep("=", width))
    table.insert(lines, "TODOs Found: " .. #files)
    table.insert(lines, string.rep("-", width))

    for _, file in ipairs(files) do
      -- Format each TODO entry with file info and content
      table.insert(lines, string.format("📄 %s:%d", file.file_name, file.row))
      -- Add the TODO content with proper indentation
      table.insert(lines, "  " .. file.content:gsub("^%s*", ""))
      table.insert(lines, string.rep("-", width))
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

    -- Set up syntax highlighting
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

    -- Add buffer local highlights
    local ns_id = vim.api.nvim_create_namespace("todo_comments")
    for i, line in ipairs(lines) do
      if line:match("^📄") then
        vim.api.nvim_buf_add_highlight(buf, ns_id, "Directory", i - 1, 0, -1)
      elseif line:match("^%s*TODO:") then
        vim.api.nvim_buf_add_highlight(buf, ns_id, "Todo", i - 1, 0, -1)
      end
    end

    -- Create floating window
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      style = 'minimal',
      border = 'rounded',
      title = " Todo Comments ",
      title_pos = 'center'
    })

    -- keymap to open the file and jump to the line
    vim.keymap.set('n', 'l', function()
      local pos = vim.api.nvim_win_get_cursor(win)
      local selected_line = files[pos[1]]
      -- close the window when selected file is opened
      vim.api.nvim_win_close(win, true)
      -- open the file in the current buffer
      vim.api.nvim_set_current_buf(current_buf)
      -- open the file in a new buffer
      vim.cmd('edit ' .. selected_line.path)
      -- jump to the line with the todo comment
      vim.api.nvim_win_set_cursor(0, { selected_line.row, selected_line.col_idx - 1 })
    end, { buffer = buf, noremap = true, silent = true })

    -- keymap to close the window
    vim.keymap.set('n', 'q', function()
      vim.api.nvim_win_close(win, true)
    end, { buffer = buf, noremap = true, silent = true })
  end, {})
end

return M
