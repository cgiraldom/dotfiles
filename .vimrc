set number relativenumber

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-surround'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-obsession'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chr4/nginx.vim'
Plug 'stephpy/vim-yaml'

" Modify * to also work with visual selections.
Plug 'nelstrom/vim-visual-star-search'

" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'

" Handle multi-file find and replace.
Plug 'mhinz/vim-grepper'

" Better display unwanted whitespace.
Plug 'ntpeters/vim-better-whitespace'

" Toggle comments in various ways.
Plug 'tpope/vim-commentary'

" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'

" snippets
Plug 'SirVer/ultisnips', {'for': ['sh', 'python', 'markdown']}
Plug 'honza/vim-snippets', {'for': ['sh', 'python', 'markdown']}

call plug#end()

colorscheme nord

" vim options that make plugins better
set updatetime=100
set laststatus=2
set ignorecase
set hidden
set hlsearch
set incsearch
set mmp=5000
" set clipboard=unnamedplus

let mapleader=" "
let maplocalleader=" "

" indentation stuff
set autoindent
set smartindent
set pastetoggle=<F2>

" tabs and spaces
set tabstop=2
set shiftwidth=2
set expandtab
set splitbelow
set splitright

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Toggle quickfix window.
function! QuickFix_toggle()
  for i in range(1, winnr('$'))
     let bnum = winbufnr(i)
     if getbufvar(bnum, '&buftype') == 'quickfix'
        cclose
        return
     endif
  endfor

  copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Clear search highlights.
map <Leader><Space> :let @/=''<CR>

" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" .............................................................................
" " mattn/emmet-vim
" .............................................................................

let g:user_emmet_leader_key=','

" .............................................................................
" " scrooloose/nerdtree
" .............................................................................

let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>

" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim airline
let g:airline_powerline_fonts = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" FZF

" Launch fzf with CTRL+P
nnoremap <silent> <C-p> :FZF -m<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

" Map few common things
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <leader>l : Lines<CR>

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo.
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Edit Vim config file in a new tab.
map <Leader>ev :tabnew $MYVIMRC<CR>

" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" .............................................................................
" mhinz/vim-grepper
" .............................................................................

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
  \ "sy
  \ gvgr
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" .............................................................................
" SirVer/ultisnips
" .............................................................................

let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
