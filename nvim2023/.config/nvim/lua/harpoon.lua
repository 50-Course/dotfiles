local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<localleader>a", function() mark.add_file() end)
vim.keymap.set("n", "<localleader>h", function() mark.toggle_quick_menu() end)
vim.keymap.set("n", "<localleader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<localleader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<localleader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<localleader>4", function() ui.nav_file(4) end)
