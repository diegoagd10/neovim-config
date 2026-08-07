local M = {
  buffer = nil,
  window = nil,
}

function M.toggle()
  if M.window and vim.api.nvim_win_is_valid(M.window) then
    vim.api.nvim_win_close(M.window, true)
    M.window = nil
    return
  end

  if M.buffer and not vim.api.nvim_buf_is_valid(M.buffer) then
    M.buffer = nil
  end

  vim.cmd("botright split")
  M.window = vim.api.nvim_get_current_win()
  vim.cmd("resize 12")

  if M.buffer then
    vim.api.nvim_win_set_buf(M.window, M.buffer)
  else
    vim.cmd("terminal")
    M.buffer = vim.api.nvim_get_current_buf()
    vim.bo[M.buffer].buflisted = false
  end

  vim.cmd("startinsert")
end

return M
