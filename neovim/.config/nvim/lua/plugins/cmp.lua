return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- remove the default <CR> mapping
      opts.mapping["<CR>"] = nil
    end,
  },
}
