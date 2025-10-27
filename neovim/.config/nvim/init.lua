-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

---------------------
--- CUSTOM MACROS ---
---------------------

-- local esc = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
vim.fn.setreg("s", "diJSON.stringify(pa, null, 4")

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
})
