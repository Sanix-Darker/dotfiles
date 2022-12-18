vim.cmd('source ~/.config/nvim/config.vim')

-- [[ : sections backward or to the previous '{' in the first column.
-- ]] : sections forward or to the next '{' in the first column.
-- [] : sections backward or to the previous '}' in the first column.
-- ][ : sections forward or to the next '}' in the first column.

-- Uncomment this when debuging
-- require('dap-python').setup('*env*/bin/python')
-- require('dap-go').setup()
-- require("nvim-dap-virtual-text").setup { commented = true }
-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define("DapBreakpointRejected", {text='❌', texthl='', linehl='', numhl=''})

_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}
-- impatient
-- a plugin to speed up the loading of nvim
require('impatient')
-- >>>>>>>>>>>>>>>>>

-- Disabling just for now
require('which-key').setup()
-- hop to jump on any text base objects
require('hop').setup()
-- ti be able to use the ESC in the floatTerm terminal
require('smart-term-esc').setup{
    key='<Esc>',
    except={'nvim', 'fzf'}
}
-- neoscroll (for smooth scrolling)
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
})

local scroll_map = {}
scroll_map['<S-Up>'] = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}}
scroll_map['<S-Down>'] = {'scroll', { 'vim.wo.scroll', 'true', '350', [['sine']]}}
require('neoscroll.config').set_mappings(scroll_map)
-- >>>>>>>>>>>>>>>

-- for git conflicts resolutions
-- require('git-conflict').setup({
--     default_mappings = true, -- disable buffer local mapping created by this plugin
--     disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
--     highlights = { -- They must have background color, otherwise the default color will be used
--         incoming = 'DiffText',
--         current = 'DiffAdd',
--     }
-- })
-- for git conflicts resolutions
-- just like hop to search and jump really quickly
-- require('leap').add_default_mappings()
-- >>>>>>>>>>>>>>>>>>>>>
-- for image preview inside the neovim editor
-- require('hologram').setup{
--     auto_display = true
-- }
-- >>>>>>>>>>>>>>>>>>>

-- mason utile for lsp
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    -- ensure_installed = lsp_servers,
    automatic_installation = false,
})

-- LSP servers managers
-- set up an appropriate complation like lsp-nvim
-- LSP nvim-cmp (much faster than coc-nvim)
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
local lsp_servers = {
    'clangd', 'rust_analyzer', 'pyright', 'tsserver',
    'eslint', 'jsonls', 'gopls', 'phpactor',
    'cssls', 'html', 'bashls', 'cssmodules_ls',
    'emmet_ls', 'ruby_ls', 'vls', 'arduino_language_server',
    'cssls', 'dockerls', 'gradle_ls', 'graphql',
    'jdtls', 'kotlin_language_server', 'marksman',
    'rnix', 'taplo', 'tailwindcss',
    'terraformls', 'yamlls', 'zls', 'lemminx'
}
require'lspconfig'.sumneko_lua.setup {
    -- ... other configs
    settings = {
        Lua = {
            diagnostics = {
                -- this is to allow vim to be consider as a globals
                -- authorise variable
                globals = { 'vim' }
            }
        }
    }
}

-- Set up nvim-cmp.
local cmp = require'cmp'
local types = require'cmp.types'
local str = require'cmp.utils.str'
local luasnip = require'luasnip'
local lspkind = require'lspkind'

local t = function(str_)
	return vim.api.nvim_replace_termcodes(str_, true, true, true)
end

-- Selected option
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-d>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),
        ['<C-s>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),
        ['<Tab>'] = cmp.mapping(function(fallback)
          local col = vim.fn.col('.') - 1

          if cmp.visible() then
            cmp.select_next_item(select_opts)
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item(select_opts)
          else
            fallback()
          end
        end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    }),
    formatting = {
		fields = {
			cmp.ItemField.Kind,
			cmp.ItemField.Abbr,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
            maxwidth = 50,
			with_text = false,
			before = function(entry, vim_item)
				-- Get the full snippet (and only keep first line)
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)

				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(vim_item.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				vim_item.abbr = word

				return vim_item
			end,
		}),
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

---
-- Global Config
---
-- -- Set up lspconfig.
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lsp_defaults = lspconfig.util.default_config
local local_capabilities = cmp_nvim_lsp.default_capabilities()

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    local_capabilities
)

-- LSP Servers
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = local_capabilities,
  }
end

-- To load all our snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- keybindings to go to definition/declaration
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

	-- bufmap('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	-- bufmap('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
	-- bufmap('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	-- bufmap('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
	-- bufmap('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
	-- bufmap('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
	-- bufmap('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
	-- bufmap('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
	-- bufmap('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	-- bufmap('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	-- bufmap('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

-- For diagnostics
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = '▲'})
sign({name = 'DiagnosticSignHint', text = '⚑'})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

-- Styling with borders and everything
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- check : https://github.com/arduino/arduino-language-server
-- lspconfig.arduino_language_server.setup{}
-- lspconfig.arduino_language_server.setup {
--   cmd = {
--     "arduino-language-server",
--     "-cli-config", "/path/to/arduino-cli.yaml",
--     "-fqbn", "arduino:avr:uno",
--     "-cli", "arduino-cli",
--     "-clangd", "clangd"
--   }
-- }

require('vim.lsp.protocol').CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '了', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}
