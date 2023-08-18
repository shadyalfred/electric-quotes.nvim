local utf8 = require('utf8')
local List = require('plenary.collections.py_list')

local M = {}

local stack = List{}

local is_enabled = true

local opening_of = {
  ['"'] = '“',
  ['“'] = '“',
  ['”'] = '“',
  ["'"] = '‘',
  ['‘'] = '‘',
  ['’'] = '‘',
}

local closing_of = {
  ['"'] = '”',
  ['“'] = '”',
  ['”'] = '”',
  ["'"] = '’',
  ['‘'] = '’',
  ['’'] = '’',
}

M.toggle = function()
  is_enabled = not is_enabled
end

local new_char

local get_lines = function(row, col)
  local lines = vim.fn.getline(1, row)

  if col > 1 then
    col = utf8.offset(lines[row], col - 1)
    lines[row] = string.sub(lines[row], 1, col)
  end

  return lines, col
end

local handle_quote = function(lines, char, row, col)
  stack = List{}
  new_char = nil

  for j = #lines, 1, -1 do
    local line = lines[j]

    local len = utf8.len(line)

    if len == nil then
      goto skip_line
    end

    local last = #line

    for i = len, 1, -1 do 
      local start = utf8.offset(line, i)
      local ch = utf8.char(utf8.codepoint(line, start, last - 1))

      if ch == closing_of[char] then
        stack:push(closing_of[char])
      elseif ch == opening_of[char] then
        if #stack == 0 then
          new_char = closing_of[char]
          goto clean_up
        elseif stack[#stack] == closing_of[char] then
          stack:pop()
        end
      end

      last = start
    end

    ::skip_line::
  end

  ::clean_up::
  if #stack ~= 0 and new_char == nil then
    while #stack ~= 0 do
      local last_char = stack:pop()
      if last_char == opening_of[char] then
        new_char = closing_of[char]
        break
      end
    end
  end

  if new_char ~= nil then
    vim.v.char = new_char
  else
    vim.v.char = opening_of[char]
  end

end

vim.api.nvim_create_autocmd('InsertCharPre', {
  nil,
  callback = function()
    if not is_enabled then
      return
    end

    local char = vim.v.char

    if char == "'" or char == '"' then
      local pos = vim.fn.getcurpos()
      local row, col = pos[2], pos[3]

      lines, col = get_lines(row, col)

      handle_quote(lines, char, row, col)
    end
  end
})

return M
