local utf8 = require('utf8')

local M = {}

local is_enabled = false

M.toggle = function()
  is_enabled = not is_enabled
end

local single_quote_of = {
  ['`'] = '‘',
  ["'"] = '’',
}

local double_quote_of = {
  ['`'] = '“',
  ["'"] = '”',
}

local get_nth_char = function(line, n)
  local i = utf8.offset(line, n)

  return utf8.char(utf8.codepoint(line, i))
end

local get_chars = function()
  local line = vim.fn.getline('.')

  local curr_pos = vim.fn.getcursorcharpos()[3] - 1

  if curr_pos == 0 then
    return nil, nil
  end

  local curr_char = get_nth_char(line, curr_pos)

  if curr_pos == 1 then
    return curr_char, nil
  end

  local prev_char = get_nth_char(line, curr_pos - 1)

  return curr_char, prev_char
end

local handle_quote = function(curr_char, prev_char)
  if prev_char == nil then
    vim.api.nvim_input('<BS>' .. single_quote_of[curr_char])
  elseif prev_char ~= single_quote_of[curr_char] then
    vim.api.nvim_input('<BS>' .. single_quote_of[curr_char])
  else
    vim.api.nvim_input('<BS><BS>' .. double_quote_of[curr_char])
  end
end

vim.api.nvim_create_autocmd('TextChangedI', {
  nil,
  callback = function()
    if not is_enabled then
      return
    end

    curr_char, prev_char = get_chars()

    if curr_char == nil then
      return
    end

    if curr_char == '`' or curr_char == "'" then
      handle_quote(curr_char, prev_char)
    end
  end
})

return M
