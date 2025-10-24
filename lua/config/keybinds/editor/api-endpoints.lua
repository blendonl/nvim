local map = vim.keymap.set

map("n", "<leader>ee", "<cmd>Endpoint<CR>", { desc = "Endpoints" })
map("n", "<leader>eg", "<cmd>Endpoint Get<CR>", { desc = "Endpoints" })
map("n", "<leader>eo", "<cmd>Endpoint Post<CR>", { desc = "Endpoints" })
map("n", "<leader>ea", "<cmd>Endpoint Patch<CR>", { desc = "Endpoints" })
map("n", "<leader>eu", "<cmd>Endpoint Put<CR>", { desc = "Endpoints" })
map("n", "<leader>ed", "<cmd>Endpoint Delete<CR>", { desc = "Endpoints" })
