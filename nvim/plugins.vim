" Specify a directory for plugins
" - For Neovim: stdpath data  . plugged
" - Avoid using standard Vim directory names like plugin
" auto install vim-plug and plugins:
"
call plug#begin('~/.config/nvim/plugged')
" On-demand loading
Plug 'preservim/nerdtree'
" The wakatime plugin
" Commenting this for now
Plug 'wakatime/vim-wakatime'
" to search inside files
Plug 'mileszs/ack.vim'
" To add comments
Plug 'tpope/vim-commentary'
" Vim synthaxic
Plug 'vim-syntastic/syntastic'
" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim'}
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" For FZF preview
Plug 'yuki-yano/fzf-preview.vim'
" Use release branch (recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'tag': 'v0.0.81'}
" For code folding
Plug 'tmhedberg/SimpylFold'
" For log hightlighting
" Plug 'mtdl9/vim-log-highlighting'
" For the git diff/git blame
Plug 'zivyangll/git-blame.vim'
" For the gitbutter (live git diff on changes)
Plug 'airblade/vim-gitgutter'
" For dev-icons
Plug 'ryanoasis/vim-devicons'
" For hichlight all occurences
" Of the current word where we have the cursor
Plug 'itchyny/vim-cursorword'
" For CSS color
Plug 'ap/vim-css-color'
" For REST requests inside vim
Plug 'diepm/vim-rest-console'
" For EasyMotion
Plug 'phaazon/hop.nvim'
" To fastly start neovim
Plug 'lewis6991/impatient.nvim'
" get strucure of the code classes and functions
" Plug 'https://github.com/preservim/tagbar'
" Another tagging system like tagbar
Plug 'liuchengxu/vista.vim'
" TO install vista, we need 
" https://github.com/universal-ctags/ctags not the default ctags
" Plug 'lukas-reineke/indent-blankline.nvim'
" The magical local history
Plug 'simnalamburt/vim-mundo'
" For popUp all over the place
Plug 'voldikss/vim-floaterm'
" For formating the code:
" Plug 'sbdchd/neoformat'
" A hinter for next moves
Plug 'folke/which-key.nvim'
" For differences in a file
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
" The Zig hightligh & 
" Plug 'ziglang/zig.vim'
" Just to use the ESC in a floaterm
Plug 'sychen52/smart-term-esc.nvim'
" ReactJs/typescript support
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
" For debugging, we add dap
" Plug 'mfussenegger/nvim-dap'
" Plug 'Pocco81/DAPInstall.nvim'
" Plug 'mfussenegger/nvim-dap-python'
" Plug 'leoluz/nvim-dap-go'
" Plug 'rcarriga/nvim-dap-ui'
" Plug 'theHamsta/nvim-dap-virtual-text'
" For the smooth scroll
Plug 'karb94/neoscroll.nvim'
" For the sticky header
Plug 'wellle/context.vim'
" Emmet for html fast completion
" Plug 'mattn/emmet-vim'
" Can be nice to ave the terminal in split view
" Plug 'vimlab/split-term.vim'
" To resolve conflicts like a pro
" co — choose ours
" ct — choose theirs
" cb — choose both
" c0 — choose none
" ]x — move to previous conflict
" [x — move to next conflict
" Plug 'akinsho/git-conflict.nvim'

" For a minimap of my source code
" you should install code-minimap first:
" cargo install --locked code-minimap
" Plug 'wfxr/minimap.vim'

" To get a direct link to a github link from vim
" :GH or :GHInteractive (for github)/ GB or :GBInteractive (for gitlab)
Plug 'ruanyl/vim-gh-line'

" For snapshot from the code
Plug 'segeljakt/vim-silicon'

" For gist stuffs
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'

" For surrounding quotes
" cs'> or ds'<
Plug 'tpope/vim-surround'

" For multicursor (need more mappings)
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" for php
" Plug 'tobyS/pdv'                        " Auto generating php docblocks
" Plug 'StanAngeloff/php.vim'             " Improved syntax highlighting for php
" Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'} " PHP introspection and refactor tools
" Plug 'phpactor/ncm2-phpactor'           " Phpactor integration for ncm2 (autocomplete)
" Plug 'stephpy/vim-php-cs-fixer'         " Coding standards fixer
" " for php autocompletion
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'Shougo/unite.vim'
" Plug 'm2mdas/phpcomplete-extended'

" To manage LSP servers
" :Mason - opens a graphical status window
" :MasonInstall <package> ... - installs/reinstalls the provided packages
" :MasonUninstall <package> ... - uninstalls the provided packages
" :MasonUninstallAll - uninstalls all packages
" :MasonLog - opens the mason.nvim log file in a new tab window
Plug 'williamboman/mason.nvim'
" :LspInstall [<server>...] - installs the provided servers
" :LspUninstall <server> ... - uninstalls the provided servers
Plug 'williamboman/mason-lspconfig.nvim'

" Let's optimize the completion for snippets
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" For snippets
Plug 'rafamadriz/friendly-snippets'

" lspkind for autocompletion stuff
Plug 'onsails/lspkind.nvim'

" Should help preview got to references
Plug 'kevinhwang91/nvim-bqf'

" For jumping fast on code am writing
" Plug 'ggandor/leap.nvim'

" For code review using octo
Plug 'pwntester/octo.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" Telescope (SHIT i need this to use octo,
" will remove when the support of fzf will be available)
Plug 'nvim-telescope/telescope.nvim'

" A framework for some plugin to be working (gh.nvim) for example
" Plug 'ldelossa/litee.nvim'
" For code review on nvim directly
" Plug 'ldelossa/gh.nvim'

" For icons on modules types
" Plug 'onsails/lspkind.nvim'

" For easy aligning...
" :EasyAlign *= | to align around each occurence
" of '=', 2= to align for the second occurence
Plug 'junegunn/vim-easy-align'

" For sections in the codebase
" Plug 'mfussenegger/nvim-ts-hint-textobject'
" For color
" Plug 'navarasu/onedark.nvim'
Plug 'joshdick/onedark.vim'
" For python IDE tools inside vim
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Just another way for review
" Plug 'junkblocker/patchreview-vim'
" Plug 'codegram/vim-codereview'

" to preview images inside markdown...
" Plug 'edluffy/hologram.nvim'

" For multi cursor
" Coul but am oing to comment that for now
" Plug 'mg979/vim-visual-multi'

" For distraction disabling
" Plug 'junegunn/goyo.vim'

" To preview image as ASCII
" Plug 'ashisha/image.vim'

" For bookmarking my code
" m, to add a bookmark
" m- to delete a bookmark
" m<Space> to delete all bookmark
" [` to jump to the prev bookmark
" ]` to jump to the next bookmark
" Plug 'kshenoy/vim-signature'

" Snippets are separated from the engine.
" Add this if you want them:
" Plug 'honza/vim-snippets'

" Jedi-vim autocompletion
" Plug 'davidhalter/jedi-vim'

" Animation on the cursor
" Plug 'DanilaMihailov/beacon.nvim'

" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Track the engine.
" Fcedpe
" Plug 'SirVer/ultisnips'

" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Copy paste history
" Plug 'https://github.com/vim-scripts/YankRing.vim'

" For grep search [because the :Lines freeze as shit]
" Plug 'dkprice/vim-easygrep'

" For git
" Plug 'https://github.com/tpope/vim-fugitive'

" Colors on brackets
" Plug 'frazrepo/vim-rainbow'

"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plug 'Shougo/deoplete.nvim'
"  Plug 'roxma/nvim-yarp'
"  Plug 'roxma/vim-hug-neovim-rpc'
"endif

" To search for lines and files
" Plug 'damage220/vim-finder'

" Plug 'wincent/command-t'

" Same as Synthax but asynchron
" Plug 'https://github.com/w0rp/ale'

" For Fugitive for git command directly inside the command section
" Plug 'https://github.com/tpope/vim-fugitive'

" vim plugin for flake8 PEP
" Plug 'nvie/vim-flake8'

" For the indent on python
" Plug 'vim-scripts/indentpython.vim'

" Jupyter-vim plugin
" Plug 'jupyter-vim/jupyter-vim'

" To search and replace for text
" Plug 'ray-x/sad.nvim'
" Plug 'brooth/far.vim'

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" For viewing csv files
" Plug 'chrisbra/csv.vim'

" For vim-auto-save
" Plug '907th/vim-auto-save'

call plug#end()