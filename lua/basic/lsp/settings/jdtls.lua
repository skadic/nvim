local server_opts = {
  on_attach = require("basic.lsp.handlers").on_attach,
  capabilities = require("basic.lsp.handlers").capabilities,
}
require("java").setup()
require("lspconfig").jdtls.setup(server_opts)
