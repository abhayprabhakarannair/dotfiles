-- Remap the leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local k = vim.keymap

-- Disable arrow keys in normal mode
k.set({ "n", "v" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
k.set({ "n", "v" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
k.set({ "n", "v" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
k.set({ "n", "v" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Make copy to clipboard easier
k.set({ "n", "v" }, "<leader>y", '"+y')
k.set({ "n", "v" }, "<leader>p", '"+p')

-- Quick text movements up & down
k.set("v", "J", ":m '>+1<CR>gv=gv")
k.set("v", "K", ":m '<-2<CR>gv=gv")
