local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require("nateemerson.lsp.lsp-installer")
require("nateemerson.lsp.handlers").setup()
