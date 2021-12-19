call plug#begin('~/.config/nvim/plugged')
    " Zen ??
    Plug 'folke/zen-mode.nvim'

    " Better wildmenu
    Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }

    " Sidebar
    Plug 'GustavoKatel/sidebar.nvim'
    Plug 'akinsho/bufferline.nvim'
    " Coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Lsp 
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    " TODO: Verify if we can use lsp-saga somehow
    Plug 'glepnir/lspsaga.nvim'
    Plug 'folke/trouble.nvim'

    " Neovim tree shitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/playground'

    " Telescope fancy things
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    "    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'gruvbox-community/gruvbox'

    " Colors and themes 
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'hoob3rt/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
call plug#end()
let mapleader = " "


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}


imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" Plug 'gelguy/wilder.nvim' {{{
call wilder#setup({'modes': [':', '/', '?']})
" }}}
"

" Plug 'GustavoKatel/sidebar.nvim' {{{
lua << EOF
require("sidebar-nvim").setup({})
-- require("sidebar-nvim").setup({
--     disable_default_keybindings = 0,
--     bindings = nil,
--     open = false,
--     side = "left",
--     initial_width = 35,
--     update_interval = 1000,
--     sections = { "datetime", "git-status", "lsp-diagnostics" },
--     section_separator = "-----",
--     docker = {
--         attach_shell = "/bin/sh", show_all = true, interval = 5000,
--     },
--     datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
--     todos = { ignored_paths = { "~" } }
-- })
EOF
nnoremap <leader>sb <cmd>SidebarNvimToggl<cr>
" }}}
"
" 'akinsho/nvim-bufferline.lua' {{{
lua << EOF
vim.api.nvim_exec([[let $KITTY_WINDOW_ID=0]], true)
require("bufferline").setup{
  highlights = {
    fill = {
      guibg = "#282828"
    },
    separator_selected = {
      guifg = "#282828"
    },
    separator_visible = {
      guifg = "#282828"
    },
    separator = {
      guifg = "#282828"
    }
  },
  options = {
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 25,
    max_prefix_length = 25,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = "slant",
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    offsets = {
      {
        filetype = "coc-explorer",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    }
  }
}
EOF
nnoremap <silent> gb :BufferLinePick<CR>
" }}}
"

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
