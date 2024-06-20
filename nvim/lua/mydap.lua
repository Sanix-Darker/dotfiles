-- For dap configurations
-- require('dap-go').setup()
-- pip install debugpy
-- require('dap-python').setup()
local dap = require('dap')
local dapui = require("dapui")
dapui.setup()

require("mason-nvim-dap").setup({
    automatic_installation = true,
    handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
            config.adapters = {
              type = 'executable',
              command = '*env/bin/python',
              args = { '-m', 'debugpy.adapter' },
              options = {
                source_filetype = 'python',
              },
            }
            require('mason-nvim-dap').default_setup(config)
        end,

        -- dap adapter for php
        -- yes, it use node... what a nightmare man.
        --
        -- steps to install :
        -- cd $HOME && git clone https://github.com/xdebug/vscode-php-debug.git
        -- cd vscode-php-debug && nvm use 16
        -- npm install && npm run build
        php = function(config)
            config.adapters = {
                type = "executable",
                command = "node",
                args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" }
            }
            require('mason-nvim-dap').default_setup(config)
        end,
    },
    ensure_installed = {
        "php",
        "bash",
        "js",
        "python",
        "node2",
        "php-debug-adapter",
    },
})

dap.configurations.php = {
    {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        breakpoints = {
            exception = {
                Notice = false,
                Warning = false,
                Error = false,
                Exception = false,
                ["*"] = false,
            },
        },
    }
}

dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

-- for dap virtual text
require("nvim-dap-virtual-text").setup()
-- for highlights
require('nvim-dap-repl-highlights').setup()

