local utf8 = require('utf8')

local single_quote_of = {
  ['`'] = '‘',
  ["'"] = '’',
}

local double_quote_of = {
  ['`'] = '“',
  ["'"] = '”',
}

local M = {}

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

local handle_event = function()
  curr_char, prev_char = get_chars()

  if curr_char == nil then
    return
  end

  if curr_char == '`' or curr_char == "'" then
    handle_quote(curr_char, prev_char)
  end
end

local event_id = nil

M.toggle = function()
  if event_id == nil then
    event_id = vim.api.nvim_create_autocmd('TextChangedI', {
      nil,
      desc = "Check if user entered ' or ` for electric-quotes.nvim",
      callback = handle_event
    })
  else
    vim.api.nvim_del_autocmd(event_id)
    event_id = nil
  end
end

return M
