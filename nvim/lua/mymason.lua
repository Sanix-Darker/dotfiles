local mason_setup = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

local masonlspconfig_setup = {
    ensure_installed = lsp_servers,
    automatic_installation = true,
}
require("mason").setup(mason_setup)
--require("mason-lspconfig").setup(masonlspconfig_setup)
