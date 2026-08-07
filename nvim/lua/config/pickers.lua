local M = {}

local function project_root()
  local filename = vim.api.nvim_buf_get_name(0)
  local start = filename ~= "" and vim.fs.dirname(filename) or vim.uv.cwd()
  local markers = {
    ".git",
    "package.json",
    "tsconfig.json",
    "jsconfig.json",
    "pyproject.toml",
    "pyrightconfig.json",
  }
  local found = vim.fs.find(markers, { path = start, upward = true })
  return found[1] and vim.fs.dirname(found[1]) or vim.uv.cwd()
end

local function builtin(name, opts)
  require("telescope.builtin")[name](opts or {})
end

function M.find_files()
  builtin("find_files", { cwd = project_root() })
end

function M.live_grep()
  builtin("live_grep", { cwd = project_root() })
end

function M.buffers()
  builtin("buffers", { sort_lastused = true })
end

function M.recent_files()
  builtin("oldfiles")
end

function M.diagnostics()
  builtin("diagnostics")
end

function M.document_symbols()
  builtin("lsp_document_symbols")
end

function M.workspace_symbols()
  builtin("lsp_dynamic_workspace_symbols")
end

function M.file_explorer()
  vim.cmd("Explore")
end

return M
