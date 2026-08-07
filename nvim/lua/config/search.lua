local M = {}

local function visual_text()
  local mode = vim.fn.mode()
  local start_pos
  local end_pos
  local visual_type

  if mode == "v" or mode == "V" or mode == "\22" then
    start_pos = vim.fn.getpos("v")
    end_pos = vim.fn.getcurpos()
    visual_type = mode
  else
    visual_type = vim.fn.visualmode()
    if visual_type == "" then
      return ""
    end
    start_pos = vim.fn.getpos("'<")
    end_pos = vim.fn.getpos("'>")
  end

  local lines = vim.fn.getregion(start_pos, end_pos, {
    type = visual_type,
    eol = false,
  })
  return table.concat(lines, "\n")
end

function M.replace_word()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    return
  end

  vim.ui.input({ prompt = ("Replace %q with: "):format(word) }, function(replacement)
    if replacement == nil then
      return
    end

    local pattern = vim.fn.escape(word, [[\/]])
    local value = vim.fn.escape(replacement, [[\/&]])
    vim.cmd(("%%s/\\V%s/%s/g"):format(pattern, value))
  end)
end

function M.find_visual_in_file()
  local text = visual_text()
  local filename = vim.api.nvim_buf_get_name(0)

  if text == "" or filename == "" then
    return
  end

  require("telescope.builtin").grep_string({
    search = text,
    cwd = vim.fn.fnamemodify(filename, ":h"),
    search_dirs = { vim.fn.fnamemodify(filename, ":t") },
    use_regex = false,
  })
end

function M.replace_visual()
  local text = visual_text()
  if text == "" then
    return
  end

  if text:find("\n", 1, true) then
    vim.notify("Select text from one line for file-wide replacement", vim.log.levels.WARN)
    return
  end

  vim.ui.input({ prompt = ("Replace %q with: "):format(text) }, function(replacement)
    if replacement == nil then
      return
    end

    local pattern = vim.fn.escape(text, [[\/]])
    local value = vim.fn.escape(replacement, [[\/&]])
    vim.cmd(("%%s/\\V%s/%s/g"):format(pattern, value))
  end)
end

return M
