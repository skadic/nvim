local inlayHintConfig = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}
return {
  settings = {
    typescript = {
      inlayHints = inlayHintConfig,
    },
    javascript = {
      inlayHints = inlayHintConfig,
    },
    typescriptreact = {
      inlayHints = inlayHintConfig,
    },
    javascriptreact = {
      inlayHints = inlayHintConfig,
    },
  },
}
