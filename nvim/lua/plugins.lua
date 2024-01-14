local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use "wbthomason/packer.nvim" -- Have packer manage itself

    -- for big files (this will disable a lot of stuff when a file is huge to
    -- be open in a buffer)
    use "LunarVim/bigfile.nvim"

    --" For timing check of the loading time
    --" Plug 'dstein64/vim-startuptime'
    --" On-demand loading
    use 'preservim/nerdtree'

    -- for status of files changes/tracked... by git
    use 'Xuyuanp/nerdtree-git-plugin'
    -- The wakatime plugin
    -- Commenting this for now
    use 'wakatime/vim-wakatime'
    -- to search inside files
    use 'mileszs/ack.vim'
    -- To add comments
    use 'tpope/vim-commentary'
    -- To restore my vim session after closing/opening
    use 'tpope/vim-obsession'
    -- Vim syntactic
    use 'vim-syntastic/syntastic'
    -- vim-airline
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'
    -- Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
    use {'fatih/vim-go', run = ':GoUpdateBinaries'}
    -- Plugin options
    use {'nsf/gocode', run = 'vim'}
    -- Plugin outside ~/.vim/plugged with post-update hook
    -- needed to add this because neoclip depends on it
    use {'ibhagwan/fzf-lua', branch = 'main'}
    use {'Sanix-Darker/fzf', branch = 'me', run = function() vim.fn['fzf#install']() end}
    use 'junegunn/fzf.vim'
    -- For FZF preview
    use 'yuki-yano/fzf-preview.vim'
    -- For code folding
    -- use 'tmhedberg/SimpylFold'
    -- To automatically close a buffer after 20mins
    use 'chrisgrieser/nvim-early-retirement'
    -- For SourceGraph nvim integration
    -- Waiting for the mailing list
    -- use {'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua'}
    -- For DOC offline regarding any builtin func/class/modules/package
    -- Works with the zea sofware
    -- Will disable for now (for now the gd does a good job)
    -- use 'KabbAmine/zeavim.vim'
    -- For twitter
    -- use 'https://github.com/twitvim/twitvim.git'
    -- For the git diff/git blame
    -- use 'zivyangll/git-blame.vim'
    -- Magically check for commits inside the project even through history
    -- q Close the popup window
    -- o older. Back to older commit at the line
    -- O Opposite to o. Forward to newer commit at the line
    -- d Toggle unified diff hunks only in current file of the commit
    -- D Toggle all unified diff hunks of the commit
    -- r Toggle word diff hunks only in current file of the commit
    -- R Toggle all word diff hunks of current commit
    -- ? Show mappings help
    use 'rhysd/git-messenger.vim'
    -- For the gitbutter (live git diff on changes)
    -- use 'airblade/vim-gitgutter'

    -- For git signs
    use 'lewis6991/gitsigns.nvim'

    -- syntax highlight for graphql
    -- use 'jparise/vim-graphql'
    -- For a fancy status Line
    use {
        'nvim-lualine/lualine.nvim',
        -- commit = '84ffb80e452d95e2c46fa29a98ea11a240f7843e'
    }
    -- For icons on the statusline
    -- use 'kyazdani42/nvim-web-devicons'
    -- To handle case insensitive with :S a.k.a sed
    use 'tpope/vim-abolish'
    -- Finally a search and replace tool I may like
    -- NEED ripgrep
    use 'nvim-pack/nvim-spectre'
    -- To list diagnostic and warning
    use 'folke/trouble.nvim'
    -- For dev-icons
    -- use 'ryanoasis/vim-devicons'
    -- For highlight all occurrences
    -- Of the current word where we have the cursor
    use 'itchyny/vim-cursorword'
    -- For CSS color
    use 'ap/vim-css-color'
    -- For REST requests inside vim
    use 'diepm/vim-rest-console'
    -- An alternative? (boff, not quite impress)
    -- use 'rest-nvim/rest.nvim'
    -- For translations
    -- Yes, this is important for me
    -- use 'potamides/pantran.nvim'
    -- For EasyMotion
    use 'phaazon/hop.nvim'
    -- To fastly start neovim
    use 'lewis6991/impatient.nvim'
    -- get structure of the code classes and functions
    -- use 'https://github.com/preservim/tagbar'
    -- Another tagging system like tagbar
    -- TO install vista, we need
    -- https://github.com/universal-ctags/ctags not the default ctags
    -- use 'liuchengxu/vista.vim'
    -- use 'lukas-reineke/indent-blankline.nvim'
    -- The magical local history
    use 'simnalamburt/vim-mundo'
    -- For popup all over the place
    use 'voldikss/vim-floaterm'
    -- For formatting the code
    -- use 'sbdchd/neoformat'
    -- minimap for my project
    -- use 'ziontee113/neo-minimap'
    -- To format the c/cpp code
    use 'rhysd/vim-clang-format'
    -- To manage SQLite database
    -- sudo apt-get install sqlite3 libsqlite3-dev
    -- for clipboard history on nvim
    use 'kkharji/sqlite.lua'
    -- To have history of clipboard
    use 'AckslD/nvim-neoclip.lua'
    -- A hinter for next moves
    use 'folke/which-key.nvim'
    -- For differences in a file
    use 'nvim-lua/plenary.nvim'
    -- diff view for changes, since I have git browse,
    -- this is not needed anymore
    -- use 'sindrets/diffview.nvim'
    -- The Zig highlight
    -- use 'ziglang/zig.vim'
    -- ReactJs/typescript support
    -- use 'pangloss/vim-javascript'
    -- use 'leafgarland/typescript-vim'
    -- use 'maxmellon/vim-jsx-pretty'
    -- For debugging, we add dap
    -- use 'mfussenegger/nvim-dap'
    -- use 'Pocco81/DAPInstall.nvim'
    -- use 'mfussenegger/nvim-dap-python'
    -- go install github.com/go-delve/delve/cmd/dlv@latest (debugger)
    -- use 'leoluz/nvim-dap-go'
    -- use 'rcarriga/nvim-dap-ui'
    -- for signature during debugging
    --

    -- use 'folke/neodev.nvim'
    -- use 'theHamsta/nvim-dap-virtual-text'
    -- For highlights
    -- use 'LiadOz/nvim-dap-repl-highlights'

    -- hjkl with Treesitter
    -- for selecting stuff smartly
    -- Alt+V to toggle it
    use 'gsuuon/tshjkl.nvim'

    -- For the sticky header
    -- use 'wellle/context.vim'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- The lua alternative (looks SO SLOOOOOWWWW)
    use 'nvim-treesitter/nvim-treesitter-context'

    -- For the smooth scroll
    use 'karb94/neoscroll.nvim'

    -- Emmet for HTML fast completion
    -- use 'mattn/emmet-vim'

    -- Can be nice to have the terminal in split view
    -- use 'vimlab/split-term.vim'

    -- To resolve conflicts like a pro
    -- co — choose ours
    -- ct — choose theirs
    -- cb — choose both
    -- c0 — choose none
    -- ]x — move to the previous conflict
    -- [x — move to the next conflict
    -- use 'akinsho/git-conflict.nvim'

    -- For a minimap of my source code
    -- you should install code-minimap first:
    -- cargo install --locked code-minimap
    -- use {'wfxr/minimap.vim', run = ':!cargo install --locked code-minimap'}
    use 'petertriho/nvim-scrollbar'

    -- Just for the gitsigns
    -- use 'lewis6991/gitsigns.nvim'

    -- For camelcase to snakecase and the reverse
    -- use 'nicwest/vim-camelsnek'

    -- To get a direct link to a GitHub link from vim
    -- :GH or :GHInteractive (for GitHub)/ GB or :GBInteractive (for GitLab)
    use 'ruanyl/vim-gh-line'
    -- For snapshot from the code
    -- for this to work, you need to install the CLI silicon
    use 'segeljakt/vim-silicon'
    -- For Gist stuffs
    -- use 'mattn/webapi-vim'
    -- use 'mattn/vim-gist'

    -- more context on hover
    -- use 'lewis6991/hover.nvim'

    -- For surrounding quotes
    -- cs'> or ds'
    -- csw"
    -- S' (in visual selection)
    use 'tpope/vim-surround'
    -- For multicursor (need more mappings)
    -- use {'mg979/vim-visual-multi', branch = 'master'}
    -- For PHP
    -- use 'tobyS/pdv'                        " Auto generating PHP docblocks
    -- use {'phpactor/phpactor', run = 'composer install', for = 'php'} " PHP introspection and refactor tools
    -- use 'phpactor/ncm2-phpactor'           " Phpactor integration for ncm2 (autocomplete)
    -- use 'stephpy/vim-php-cs-fixer'         " Coding standards fixer
    -- For PHP autocompletion
    -- use 'Shougo/vimproc.vim', {'do' : 'make'}
    -- use 'Shougo/unite.vim'
    -- use 'm2mdas/phpcomplete-extended'
    -- use 'https://github.com/ojroques/nvim-lspfuzzy could be interesting to explore or the future
    -- use 'gfanto/fzf-lsp.nvim'
    -- To manage LSP servers
    -- :Mason - opens a graphical status window
    -- :MasonInstall <package> ... - installs/reinstalls the provided packages
    -- :MasonUninstall <package> ... - uninstalls the provided packages
    -- :MasonUninstallAll - uninstalls all packages
    -- :MasonLog - opens the mason.nvim log file in a new tab window
    use 'williamboman/mason.nvim'
    -- :LspInstall [<server>...] - installs the provided servers
    -- :LspUninstall <server> ... - uninstalls the provided servers
    use 'williamboman/mason-lspconfig.nvim'
    -- For GitHub actions on the nvim editor
    use 'topaxi/gh-actions.nvim'
    use 'MunifTanjim/nui.nvim'
    -- Let's optimize the completion for snippets
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-emoji'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    -- use 'ray-x/lsp_signature.nvim'
    -- For Brackets and stuffs
    use 'hrsh7th/nvim-insx'
    use 'simrat39/symbols-outline.nvim'
    -- Just like org on emacs, to organize your stuffs
    use 'phaazon/mind.nvim'
    -- To toggle and untoggle the LSP diagnostic
    -- removed in favor of the lsp_lines toggle one <Leader>o to activate
    -- and deactivate.
    -- use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
    -- For snippets
    use 'rafamadriz/friendly-snippets'
    -- lspkind for autocompletion stuff
    use 'onsails/lspkind.nvim'

    --" Should help preview got to references
    use {
        'kevinhwang91/nvim-bqf'
        --" added the commit hash because the lastest release is not working properly
        --let's test the fix
        --commit = '1276701ed0216b94d7919d5c07845dcdf05fbde5'
    }

    --" To show LSPs loading in side way
    use {
        'j-hui/fidget.nvim',
        -- tag = 'legacy'
    }

    --In the above example, Packer.nvim is configured to include `nvim-tree.lua` plugin with the tag `v0.5.1`.
    --Remember to update the tag to the desired version of the plugin you want to use.

    --" To show code action in a popup with a lot of details
    --" seems too early
    --" Plug 'weilbith/nvim-code-action-menu'
    --" we not use, we just keep it in mind"
    --" https://github.com/zbirenbaum/copilot.lua
    --" For syntax highlighting on a lot of stuffs
    --" Plug 'sheerun/vim-polyglot'
    --" For jumping fast on code am writing
    --" Plug 'ggandor/leap.nvim'
    --" A framework for some plugin to be working (gh.nvim) for example
    --" Plug 'ldelossa/litee.nvim'
    --" For code review on nvim directly
    --" Plug 'ldelossa/gh.nvim'

    --" Jedi-vim autocompletion
    --" Plug 'davidhalter/jedi-vim'
    --" For python IDE tools inside vim
    --" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    --" Add the following line to your packer configuration
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }
    --" To view images in neovim
    --" Plug 'm00qek/baleia.nvim'
    --" Plug 'princejoogie/chafa.nvim'
    --" Just another way for review
    --" Plug 'junkblocker/patchreview-vim'
    --" Plug 'codegram/vim-codereview'
    --" to preview images inside markdown...
    --" Plug 'edluffy/hologram.nvim'
    --" For multi cursor
    --" Coul but am oing to comment that for now
    --" googd tutorial : https://www.youtube.com/watch?v=N-X_zjU5INs
    --" Plug 'mg979/vim-visual-multi'
    --" To get import cost in a javascript codebase
    --" like bundle phobia
    --" check the documentation here : https://github.com/yardnsm/vim-import-cost/
    --" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install --production' }
    --" For distraction disabling
    --" Plug 'junegunn/goyo.vim'
    --" To preview image as ASCII
    --" Plug 'ashisha/image.vim'
    --" For bookmarking my code
    --" m, to add a bookmark
    --" m- to delete a bookmark
    --" m<Space> to delete all bookmark
    --" [` to jump to the prev bookmark
    --" ]` to jump to the next bookmark
    --" Plug 'kshenoy/vim-signature'

    --" Just for css to see composed values from class name
    --" Plug 'MaximilianLloyd/tw-values.nvim'
    --" Animation on the cursor
    --" Plug 'DanilaMihailov/beacon.nvim'
    --" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
    --" Track the engine.
    --" Fcedpe
    --" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    --" Copy paste history
    --" Plug 'vim-scripts/YankRing.vim'
    --" For grep search [because the :Lines freeze as shit]
    --" Plug 'dkprice/vim-easygrep'
    --" Colors on brackets
    --" Plug 'frazrepo/vim-rainbow'
    --" Same as Synthax but asynchron
    --" Plug 'https://github.com/w0rp/ale'
    --" vim plugin for flake8 PEP
    --" Plug 'nvie/vim-flake8'
    --" For the indent on python
    --" Plug 'vim-scripts/indentpython.vim'
    --" Jupyter-vim plugin
    --" Plug 'jupyter-vim/jupyter-vim'
    --" To search and replace for text
    --" Plug 'ray-x/sad.nvim'
    --" Plug 'brooth/far.vim'
    --" Unmanaged plugin (manually installed and updated)
    --" Plug '~/my-prototype-plugin'
    --" For viewing csv files
    --" Plug 'chrisbra/csv.vim'
    --" To play on leetCode
    --" to install the client we need at first
    --" pip install pynvim keyring browser-cookie3 --user
    --" Plug 'ianding1/leetcode.vim'
    --" Just testing a copilot concurent
    --" Assume using vim-plug as plugin manager
    --" docker run -p 7777:8080 -v $HOME/.tabby:/data tabbyml/tabby serve --model TabbyML/SantaCoder-1B
    --" Plug 'TabbyML/tabby', {'rtp': 'clients/vim'}

    --" for testing purposes
    --" Plug 'nvim-telescope/telescope.nvim'
    --" Plug 'jackMort/ChatGPT.nvim'
    use('gsuuon/llm.nvim')
    --" lsp-lines (for better diagnostic)
    use 'https://github.com/Sanix-Darker/lsp_lines.nvim'
    -- looks like this one does not work anymore ?
    -- use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    --" For vim-auto-save
    --" Plug '907th/vim-auto-save'

    -- snippets
    use 'SirVer/ultisnips'
    use 'dcampos/nvim-snippy'

    -- for rust dev
    use 'simrat39/rust-tools.nvim'

    --" This will shutdown unfocus LSP
    -- THIS IS WAY MORE AGRESSIVE LMAO, tej it for now MDR
    -- use('hinell/lsp-timeout.nvim')
    --" Multi line selection, could be interesting
    --" for explaining sutffs on peer programming
    use "Rasukarusan/nvim-select-multi-line"
    --" For Fugitive for git command directly inside the command section
    use 'tpope/vim-fugitive'
    --" Snippets are separated from the engine.
    --" Add this if you want them:
    use 'honza/vim-snippets'
    --" TODO: To be configure for later on
    --" https://github.com/OscarCreator/rsync.nvim
    --" For easy aligning...
    --" :EasyAlign *= | to align around each occurence
    --" of '=', 2= to align for the second occurence
    use 'junegunn/vim-easy-align'
    --" For sections in the codebase
    use 'mfussenegger/nvim-ts-hint-textobject'
    -- snips plugin to save code using snips.sh
    use 'Sanix-Darker/snips.nvim'

    -- For color
    -- use 'navarasu/onedark.nvim'
    -- use 'joshdick/onedark.vim'
    use 'folke/tokyonight.nvim'
    -- use 'Sanix-Darker/onedark.vim'
    -- Telescope (SHIT i need this to use octo,
    -- will remove when the support of fzf will be available)
    -- Plug 'nvim-telescope/telescope.nvim'
    -- For code review using octo
    -- use 'pwntester/octo.nvim'
    use 'nvim-tree/nvim-web-devicons'

    -- strongify my go lsp with go.nvim
    use 'ray-x/go.nvim'

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
