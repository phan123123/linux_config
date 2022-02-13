""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source ~/.vimrc
\| endif

" call plugins
call plug#begin('~/.vim/plugged')

" ((File browser))
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'PhilRunninger/nerdtree-buffer-ops'

" ((Search in files))
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

" ((Status bar))
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

" ((Git changes))
    Plug 'airblade/vim-gitgutter'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Config for plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1

" NERDTree refresh
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=UTF-8
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.' >> $config 
syntax on
set number relativenumber           "init line number
set clipboard+=unnamed,unnamedplus  " init the clipboard for copy-parse with terminal
set hlsearch                        "init hightlight the search
set autoindent                      "init indent    


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Binding keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F5> :call NERDTreeToggleAndRefresh()<CR>
