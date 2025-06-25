local M = {}

-- TODO: make the UI more user friendly

local function map_data(file, dir, data)
  local full_path = dir .. "/" .. file
  local lines = vim.fn.readfile(full_path)

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
      })
    end
  end
end

local function get_files(dir)
  -- decalare a table that will hold the file names
  local return_files = {}

  -- iterate through the current directory
  for _, file in ipairs(vim.fn.readdir(dir)) do
    -- skip hidden files
    if vim.startswith(file, ".") then
      goto continue
    end
    -- declare the full path of the file
    local full_path = dir .. "/" .. file
    -- if the file is a directory, recursively get files from it
    if vim.fn.isdirectory(full_path) == 0 then
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

    local lines = {}
    for _, file in ipairs(files) do
      table.insert(lines, file.file_name .. "-" .. file.col_idx .. ":" .. file.row)
    end


    vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    local width = math.min(math.floor(vim.o.columns * 0.8), 64)
    local height = math.floor(vim.o.lines * 0.8)

    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      border = 'single',
      -- style = 'minimal',
      title = "Todo Comments",
      title_pos = 'center',
      focusable = true,
      footer = "Press 'l' to open the file and jump to the line, 'q' to close",
      footer_pos = 'center',

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
