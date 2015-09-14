" This must be first, because it changes other options as side effect
set nocompatible
filetype plugin indent on

"--- PATHOGEN ---"
"
"	Commands: none, just loads all the plugins

" load the plugins
execute pathogen#infect()
" sessions capture global options like 'runtimepath' this can cause problems
" so we turn it off.
set sessionoptions-=options

"--- END PATHOGEN ---"
"--- CTRLP ---"

let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"--- END CTRLP ---"
"--- AIRLINE ---"
"
"	Commands: none, just shows the tabline of buffers and the status bar at the
"	bottom

" need utf-8 to display special characters for the arrows
set encoding=utf-8
" without this airline only shows up after the page has been split by nerdtree
set laststatus=2
" use the powerline fonts to get the fancy arrows
"let g:airline_powerline_fonts = 1
" Replace the branch indicator with the current working directory, followed by the filename.
let g:airline_section_b = '%{getcwd()} %{fugitive#statusline()}'
let g:airline_section_c = '%t'
" show buffers in the tabline
let g:airline#extensions#tabline#enabled = 1
" Show just the filename of the buffer in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'

"--- END AIRLINE ---"
"--- INDENT GUIDES ---"
"
"	Commands: <leader>ig :: show/hide the indent guides
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=5

"--- END INDENT GUIDES ---"
"--- JAKE STUFF ---"

" Maximize window when using GVim
au GUIEnter * simalt ~x
set guioptions-=m "remove menubar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right hand scrollbar
set guioptions-=L "remove left hand scrollbar
set guioptions-=b "remove bottom scrollbar

" Set the default font for GVIM
"set guifont=Inconsolata_for_Powerline:h14:cANSI
"set guifont=DejaVu_Sans_Mono_for_Powerline:h12:cANSI
"set guifont=Anonymice_Powerline:h16:cANSI
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14

" Set the <leader> to comma instead of backslash
let mapleader = ","
let g:mapleader = ","

" Copy/Paste from clipboard
vnoremap <silent> <A-y> "+y<ESC>
vnoremap <silent> <A-p> c<ESC>"+p
nnoremap <silent> <A-p> "+p
inoremap <silent> <A-p> <ESC>"+pa

" shortcut to close quickfix window
nnoremap <silent> <leader>w :ccl<cr>:lclose<cr>

" shortcut to format json
nnoremap <silent> <leader>jf :%!python -m json.tool<cr>

" Shortcut to rapidly toggle `set list`
nmap <silent> <leader>l :set list!<cr>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:>-

" forgot to sudo into file? force save with :w!!
cmap w!! w !sudo tee % >/dev/null

"set autoread		" Set to auto read when a file is changed from the outside
set hidden			" hide buffers instead of closing them
set nowrap			" don't wrap lines
set tabstop=4		" a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent		" always set autoindenting on
set copyindent		" copy the previous indentation on autoindenting
set number			" always show line numbers
set shiftwidth=4	" number of spaces to use for autoindent
set shiftround		" use multiple of shiftwidth when indenting with '<' and '>'
set noshowmatch		" showmatch disabled due to slowness with omnisharp
"set showmatch		" briefly flash to the matching brace when you insert one (doesn't scroll)
set mat=2			" How many tenths of a second to blink when matching brackets
set ignorecase		" ignore case when searching with /
set smartcase		" ignore case if search pattern is all lowercase, case sensitive
					" otherwise (ignorecase is required for this to work)
set smarttab		" inserts tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch		" highlight search terms
set incsearch		" show search matches as you type
set history=1000	" remember more commands and search history
set undolevels=1000 " use many muchos levels of undo
set wildmenu		" autocompletion menu on vim commands
set wildmode=longest:full,full " menu display mode
set title			" change the terminal's title automatically to the filename
set visualbell		" don't beep
set noerrorbells	" don't beep
set nobackup		" don't create backup files
set noswapfile		" don't create swap files
set softtabstop=4	" tabbing inside insert mode is same as tabstop
set pastetoggle=<F2> " stop autoformatting issues by switching to paste mode
set lazyredraw		" Don't redrew while executing macros (good performance congif)
set foldmethod=indent "fold based on indent.(za toggle fold)
set foldnestmax=10	" deepest fold is 10 levels
set nofoldenable	" don't fold by default
set foldlevel=100
set lbr				" Linebreak on 500 characters
set tw=500

" ignore these filetypes
set wildignore+=*/tmp/*,*/temp/*		" Temp directories
set wildignore+=*.testsettings			" VS MSTEST Testsettings files
set wildignore+=*.swp					" Swap files
set wildignore+=*.bak					" Backup files
set wildignore+=*.dll					" Dynamically linked libraries
set wildignore+=tags					" Ctags
set wildignore+=*.zip,*.7zip,*.tar		" Compressed files
set wildignore+=*.exe,*.o				" Binaries
set wildignore+=*.suo,*.sln,*.csproj	" VS ProjectManagement Files
set wildignore+=*.xml					" XML Data
set wildignore+=*/node_modules/*		" Node dependencies
set wildignore+=*/bower_modules/*		" Bower dependencies
set wildignore+=*/bin/*,*/obj/*			" Binary directories
set wildignore+=*/.hg/*					" Mercurial
set wildignore+=*/.git/*				" Git
set wildignore+=*/.svn/*				" Subversion

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Allow us to use all the fancy colors :)
"set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

" Set the theme when supporting 256+ colors
if &t_Co >= 256 || has("gui_running")
	set background=dark
	colorscheme lucius
	"colorscheme herokudoc
	"colorscheme flatcolor
endif

" Syntax Highlighting when supporting 2+ colors
if &t_Co > 2 || has("gui_running")
	" switch syntax highlighting on, when the terminal has colors
	syntax on
	syntax enable
endif


" Traversing lists quickly
" 	*Buffer List*
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> <A-[> :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> <A-]> :bnext<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> ]B :blast<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <silent> <A-x> :bd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.cs :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.jsx :call DeleteTrailingWS()
autocmd BufWrite *.vimrc :call DeleteTrailingWS()
autocmd BufWrite *.ps1 :call DeleteTrailingWS()
autocmd BufWrite *.psm1 :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()

" Pressing ,ss will toggle and untoggle spell checking
map <silent> <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
" 	next spelling error
map <silent> <leader>sn ]s
"	previous spelling error
map <silent> <leader>sp [s
"	add to good word list
map <silent> <leader>sa zg
"	suggestions
map <silent> <leader>s? z=

" Auto-Reload VIMRC changes
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Deal with gnome terminal swallowing ALT press
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

"--- END JAKE STUFF ---"
"--- NERDTREE --"
"
" 	Commands: <C-n> open/close nerdtree

" Map ctrl+n to nerdtree toggle
map <silent> <C-n> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pdb$','\.dll$','\.sln$','\.csproj$', '\.user$', '\.dat$', '\.dll.config$', '\.xml$']
nnoremap <silent> <leader>sin :NERDTreeFind<cr>

"--- END NERDTREE --"
"--- NERD COMMENTER ---"
"
" Commands: [count]<leader>c :: Toggle commenting on  line or visual selection
"			[count]<leader>cc :: Comment out line or visual selection
"			[count]<leader>cu :: Uncomment line or visual selection
"			[count]<leader>cs :: Comment out the line sexy style
"			<leader>ca :: Change to alternate comment style

"--- END NERD COMMENTER ---"
"--- SYNTASTIC ---"
" Commands: none.

let g:syntastic_javascript_checkers=['jscs']
nnoremap <silent> <leader>jj :SyntasticCheck<cr>:Error<cr>
" 	*Error List*
nnoremap <silent> <leader>E :Error<cr>
nnoremap <silent> [e :lprevious<cr>
nnoremap <silent> ]e :lnext<cr>
nnoremap <silent> [E :lfirst<cr>
nnoremap <silent> ]E :llast<cr>

"--- END SYNTASTIC ---"
"--- SURROUND ---"
" Commands: cs"' 	:: change surrounding " with '
"			cs'<q> 	:: change surrounding ' with <q></q>
"			cst" 	:: change surrounding tag with "
"			ds" 	:: delete surrounding "
"			ysiw] 	:: add [] around the current word
"			yss) 	:: add () around the current line

"--- END SURROUND ---"
"--- SUPERTAB ---"

let g:SuperTabMappingForward = '<c-j>'
let g:SuperTabMappingBackward = '<c-k>'

"--- END SUPERTAB ---"
"--- HTML5 ---"

"Disable event-handler attributes support
let g:html5_event_handler_attributes_complete = 0

"--- END HTML5 ---"
