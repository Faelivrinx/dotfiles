let g:theprimeagen_colorscheme = "gruvbox"
fun! ColorMyPencils()
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    highlight Cursor guifg=#f00 guibg=#657b83
    highlight Comment cterm=italic gui=italic

" Make it obvious where 80 characters is
    set textwidth=80
    set colorcolumn=+1
    set colorcolumn=80
    highlight ColorColumn guibg=#181818
    set background=dark
    let g:dracula_colorterm = 0
    let g:dracula_italic = 1
    " colorscheme dracula
    colorscheme gruvbox
endfun
call ColorMyPencils()


" Vim with me
nnoremap <leader>cmp :call ColorMyPencils()<CR>
