local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require("nateemerson.lsp.mason")
require("nateemerson.lsp.null-ls")
require("nateemerson.lsp.handlers").setup()
