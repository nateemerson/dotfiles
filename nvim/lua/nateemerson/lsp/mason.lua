-- Mason UI settings only
-- Server installation and configuration is handled by lsp-zero in after/plugin/lsp.lua

local settings = {
  ui = {
    border = "none",
    icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)

-- Note: Server installation is managed by lsp-zero.ensure_installed() in after/plugin/lsp.lua
-- This avoids conflicts and deprecated API usage
