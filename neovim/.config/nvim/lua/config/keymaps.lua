-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jj", "<Esc>:normal j<CR>", { desc = "Esc and down" })
vim.keymap.set("i", "kk", "<Esc>:normal k<CR>", { desc = "Esc and up" })
vim.keymap.set("i", "jk", "<Esc>:normal<CR>", { desc = "Esc" })
vim.keymap.set("i", "kj", "<Esc>:normal<CR>", { desc = "Esc" })
vim.keymap.set("n", "cp", ':let @+ = expand("%")<CR>', { desc = "Copy filename" })

vim.keymap.set({ "n", "i" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set({ "n", "x" }, "<C-0>", ":BlameToggle virtual<CR>")
vim.keymap.set({ "n" }, "<C-t>", '<cmd>echo "you surely do not want to use tags"<CR>')

-- Smart bracket text objects
local function smart_bracket(inner, bracket)
  local open = bracket == "[" and "\\[" or bracket
  local close = bracket == "[" and "\\]" or (bracket == "(" and ")" or "}")

  local pos = vim.fn.getpos(".")
  vim.cmd("normal! %")
  local match_pos = vim.fn.getpos(".")
  vim.fn.setpos(".", pos)

  if pos[2] ~= match_pos[2] or pos[3] ~= match_pos[3] then
    vim.fn.search(open, "W")
  end

  if inner then
    vim.cmd("normal! vi" .. bracket)
  else
    vim.cmd("normal! va" .. bracket)
  end
end

for _, bracket in ipairs({ "[", "(", "{" }) do
  vim.keymap.set({ "o", "x" }, "in" .. bracket, function()
    smart_bracket(true, bracket)
  end, { silent = true })
  vim.keymap.set({ "o", "x" }, "an" .. bracket, function()
    smart_bracket(false, bracket)
  end, { silent = true })
end
