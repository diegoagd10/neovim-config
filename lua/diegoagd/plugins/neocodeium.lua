return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    
    -- Set keybindings for NeoCodeium
    vim.keymap.set("i", "<A-f>", neocodeium.accept)
    vim.keymap.set("i", "<A-;>", neocodeium.clear)
    vim.keymap.set("i", "<A-,>", function() neocodeium.cycle(-1) end)
    vim.keymap.set("i", "<A-.>", function() neocodeium.cycle(1) end)
  end,
}
