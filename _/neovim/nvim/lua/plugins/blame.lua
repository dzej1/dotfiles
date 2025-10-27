return {
  "FabijanZulj/blame.nvim",
  event = "LazyFile",
  config = function()
    require("blame").setup()
  end,
}
