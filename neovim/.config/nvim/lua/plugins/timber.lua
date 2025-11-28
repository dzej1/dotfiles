return {
  "Goose97/timber.nvim",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("timber").setup({
      -- Add custom log templates, while keeping defaults for other languages
      log_templates = {
        default = {
          javascript = [[console.log("%filename:%line_number – %log_target:", %log_target);]],
          typescript = [[console.log("%filename:%line_number – %log_target:", %log_target);]],
          jsx = [[console.log("%filename:%line_number – %log_target:", %log_target);]],
          tsx = [[console.log("%filename:%line_number – %log_target:", %log_target);]],
        },
      },

      batch_log_templates = {
        default = {
          -- glb: select multiple vars with visual + glb
          javascript = [[
console.group("%filename:%line_number");
console.log({ %repeat<"%log_target": %log_target><, > });
console.groupEnd();
]],
          typescript = [[
console.group("%filename:%line_number");
console.log({ %repeat<"%log_target": %log_target><, > });
console.groupEnd();
]],
          jsx = [[
console.group("%filename:%line_number");
console.log({ %repeat<"%log_target": %log_target><, > });
console.groupEnd();
]],
          tsx = [[
console.group("%filename:%line_number");
console.log({ %repeat<"%log_target": %log_target><, > });
console.groupEnd();
]],
        },
      },
    })
  end,
}
