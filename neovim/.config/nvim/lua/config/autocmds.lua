-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "undotree" then
      return
    end
    if vim.fn.exists(":UndotreeToggle") > 0 then
      local undotree_winnr = vim.fn.bufwinnr("undotree_2")
      if undotree_winnr ~= -1 then
        vim.cmd("UndotreeHide")
        vim.cmd("UndotreeShow")
      end
    end
  end,
})
