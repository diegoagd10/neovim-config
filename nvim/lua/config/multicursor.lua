local M = {}

function M.setup()
  local mc = require("multicursor-nvim")
  local set = vim.keymap.set

  mc.setup()

  -- Helix's normal-mode `s`: select the current line, then match a regex.
  set("n", "s", function()
    vim.cmd("normal! V")
    mc.matchCursors()
  end, { desc = "Select regex matches on the current line" })

  -- In visual mode, match the regex inside the existing selection.
  set("x", "s", mc.matchCursors, { desc = "Select regex matches in selection" })

  -- Native visual-block mode remains available, while these helpers make
  -- multicursor insertion work for ordinary visual selections too.
  set("x", "I", mc.insertVisual, { desc = "Insert at each selected line" })
  set("x", "A", mc.appendVisual, { desc = "Append to each selected line" })

  set({ "n", "x" }, "<leader>mn", function()
    mc.matchAddCursor(1)
  end, { desc = "Add next matching cursor" })
  set({ "n", "x" }, "<leader>mN", function()
    mc.matchAddCursor(-1)
  end, { desc = "Add previous matching cursor" })
  set({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors, { desc = "Add cursor to every word match" })

  mc.addKeymapLayer(function(layer_set)
    layer_set("n", "<Esc>", function()
      mc.clearCursors()
    end)
  end)

  vim.api.nvim_set_hl(0, "MultiCursorCursor", { reverse = true })
  vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
  vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
  vim.api.nvim_set_hl(0, "MultiCursorMatchPreview", { link = "Search" })
end

return M
