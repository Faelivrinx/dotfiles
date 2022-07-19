call plug#begin('~/.config/nvim/plugged')
	

	" Language Server Protocol
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'onsails/lspkind-nvim'
	Plug 'folke/trouble.nvim'
	Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
	Plug 'creativenull/diagnosticls-configs-nvim'

	" Completion
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'David-Kunz/cmp-npm'

	" Dashboard
	Plug 'glepnir/dashboard-nvim'
	
	" Better menu
	Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

	Plug 'nvim-lua/plenary.nvim'	
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-telescope/telescope-file-browser.nvim'

	" Utilites
	Plug 'hoob3rt/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	"
	Plug 'dracula/vim', { 'as': 'dracula' }

	" Nvim-Treesitter
	Plug 'MaxMEllon/vim-jsx-pretty' 
	Plug 'jxnblk/vim-mdx-js'

	" tpope plugins
	Plug 'tpope/vim-projectionist'
	Plug 'tpope/vim-unimpaired' 
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-eunuch'
	Plug 'tpope/vim-sleuth'
	Plug 'tpope/vim-fugitive'

	" Others
	Plug 'windwp/nvim-autopairs'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'karb94/neoscroll.nvim'

	Plug 'norcalli/nvim-colorizer.lua', { 'branch': 'color-editor' }
	
	" tmux plugins
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'preservim/vimux'
call plug#end()

let mapleader = " "

" Plug 'gelguy/wilder.nvim' {{{
call wilder#setup({'modes': [':', '/', '?']})
" }}}
"
"
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

" Colors {{{
if (has("termguicolors"))
  set termguicolors " enable true colors support
endif
let g:dracula_colorterm = 0
let g:dracula_italic = 1
colorscheme dracula
" set background=dark " light or dark
" colorscheme onebuddy
"

" 'hrsh7th/nvim-cmp' {{{
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    auto_select = false,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --['<C-Space>'] = cmp.mapping.complete(),
      ['<C-x>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      --['<CR>'] = cmp.mapping.confirm({ select = false }),
      ['<C-y>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,        
        select = true
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      -- For vsnip user.
      -- { name = 'vsnip' },
      -- For luasnip user.
      { name = 'path' },
      -- For ultisnips user.
      -- { name = 'ultisnips' },
      { name = 'luasnip' },
      { name = 'buffer', keywork_length = 5 },
      { name = 'npm', keyword_length = 4 },
    },
    formatting = {
      -- format = require('lspkind').cmp_format {
      --   with_text = true,
      --   menu = {
      --     buffer = "[buf]",
      --     nvim_lsp = "[LSP]",
      --     path = "[path]",
      --     luasnip = "[snip]"
      --   }
      -- }
    },
    experimental = {
      native_menu = false,
      ghost_text = true
    }
  })
EOF

" Plug 'onsails/lspkind-nvim' {{{
lua << EOF
require('lspkind').init({})
EOF
" }}}
"

lua << EOF
require('trouble').setup {}
EOF
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" tpope/vim-commentary {{{
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>
"}}}
"

" Plug 'windwp/nvim-autopairs' {{{
lua << EOF
require('nvim-autopairs').setup()
EOF
" }}}
"

" Plug 'karb94/neoscroll.nvim'{{{
lua require('neoscroll').setup()
" }}}
"
" lewis6991/gitsigns.nvim {{{
lua << EOF
  require('gitsigns').setup({})
EOF
" }}}
"
" norcalli/nvim-colorizer.lua {{{
lua require'colorizer'.setup()
" }}}
"

nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

lua << EOF
-- npm install -g diagnostic-languageserver eslint_d prettier_d_slim prettier
local function on_attach(client)
  print('Attached to ' .. client.name)
end
local dlsconfig = require 'diagnosticls-configs'
dlsconfig.init {
  default_config = false,
  format = true,
  on_attach = on_attach,
}
local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
prettier.requiredFiles = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.toml',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    'prettier.config.js',
    'prettier.config.cjs',
  }
dlsconfig.setup {
  ['javascript'] = {
    linter = eslint,
    formatter = { prettier }
  },
  ['javascriptreact'] = {
    linter = { eslint },
    formatter = { prettier }
  },
  ['css'] = {
    formatter = prettier
  },
  ['html'] = {
    formatter = prettier
  },
}
EOF
