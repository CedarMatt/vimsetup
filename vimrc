filetype plugin indent on
set shiftround
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set completeopt=longest,menuone
set shortmess+=c
set belloff+=ctrlg

set notermguicolors
set nocompatible
set hidden
set splitbelow
set splitright
set noea

set bg=dark
colorscheme gruvbox

let g:background='dark'

let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
"let g:airline_theme='solarized'
"let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extentions#battery#enabled=1
let g:airline#extentions#branch#enabled=1

let g:ctrlp_cmd='CtrlPMixed'
let g:ctrlp_working_path_mode='r'

let g:ale_virtualenv_dir_names = ['env']
let g:ale_completion_enabled = 1
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['prettier', 'eslint'],
            \}
let g:ale_fix_on_save = 1

let g:gitgutter_override_sign_column_highlight=0
let g:gitgutter_sign_added='+'
highlight GitGutterAdd ctermfg=green guifg=green
let g:gitgutter_sign_modified='~'
highlight GitGutterChange ctermfg=yellow guifg=yellow
let g:gitgutter_sign_removed='-'
highlight GitGutterDelete ctermfg=red guifg=red
let g:gitgutter_sign_removed_first_line='-^'
let g:gitgutter_sign_removed_above_and_below='-v'
let g:gitgutter_sign_modified_removed='~-'
highlight GitGutterChangeDelete ctermfg=yellow guifg=yellow

let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
let g:fzf_tags_command = 'ctags -R'

let g:NERDTreeWinSize=50

"set spell
set spelllang=en_us

set omnifunc=ale#completion#OmniFunc

set hlsearch
set smartcase

syntax on
set wrap

set laststatus=2
set number
set ruler
set title

set encoding=utf-8

set matchpairs+=<:>

set t_Co=256

set rtp+=/opt/homebrew/opt/fzf

" Config cursor to change with modes
set t_RV =
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

augroup cursorCmds
    autocmd!
    " make cursor become a block on entering vim
    autocmd VimEnter * silent !echo -ne "\e[2 q"

    " make cursor become an I-bar on leaving vim
    autocmd VimLeave * silent !echo -ne "\e[6 q"
augroup END


set backspace=indent,eol,start

nmap <F5> :NERDTreeRefreshRoot<CR>
nnoremap <C-j> :bprevious<CR>
nnoremap <C-k> :bnext<CR>
nnoremap <C-n> :NERDTreeFocus<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <C-d> :ALEGoToDefinition<CR>
if isdirectory('.git')
    nnoremap <C-p> :GFilesWithDevicons<CR>
else
    nnoremap <C-p> :Files<CR>
endif
nnoremap <C-s> :Ag<CR>
nnoremap <C-b> :Buffers<CR>

nnoremap <F8> :TagbarToggle<CR>

nnoremap <silent> <S-Up> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <S-Down> :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <S-Left> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <S-Right> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

command CleanWhitespace %s/\s\+$//e
autocmd FileType python autocmd BufWritePre <buffer> CleanWhitespace

" Start NERDTree when VIM is started without file arguments, move the cursor
" to the other
autocmd StdinReadPre * let s:std_int=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif

autocmd VimEnter * redraw!

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeDirArrowExpandable=''
let g:NERDTreeDirArrowCollapsible=''

" When editing a file, always jump to the last known cursor position. Don't do
" it when the position is invalid, when inside an event handler (happends when
" dropping a file on gvim) and for a commit message (it's likely a different
" one than last time).
autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
            \ |     exe "normal! g`\""
            \ | endif

autocmd Filetype typescriptreact setlocal tabstop=2 shiftwidth=2

function! Smart_TabComplete()
    let line = getline('.')
    let substr = strpart(line, -1, col('.')+1)
    let substr = matchstr(substr, "[^ \t]*$")

    if (strlen(substr)==0)
        return "\<tab>"
    endif

    let has_period = match(substr, '\.') != -1
    let has_slash = match(substr, '\/') != -1
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"
    elseif ( has_slash )
        return "\<C-X>\<C-F>"
    else
        return "\<C-X>\<C-O>"
    endif
endfunction

" inoremap <tab> <c-r>=Smart_TabComplete()<CR>
