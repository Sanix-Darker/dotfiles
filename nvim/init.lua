_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_chunks",
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
	},
}

vim.cmd("source ~/.config/nvim/config.vim")

-- for configs (from config.vim
require("config")
-- The list of available plugins using lazy
require('packernvim')
-- To speed up the start(cache)
require("impatient")
-- All set configurations
require("set_config")
-- to import plugins configurations
require('plugins_config')
-- for my keymaps
require("keymaps")
-- lsp configurations
require("lsp_config")
