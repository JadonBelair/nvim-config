local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>hp", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)
vim.keymap.set("n", "<leader>o", function() harpoon:list():next() end)
vim.keymap.set("n", "<leader>i", function() harpoon:list():prev() end)

