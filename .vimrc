" Set the <leader> to comma instead of backslash
let mapleader = " "
let g:mapleader = " "

"---------- VUNDLE ----------"
" Commands:
"	:PluginList				:: Lists configured plugins
"	:PluginInstall		:: Installs plugins; append `!` to update or just :PluginUpdate
"	:PluginSearch foo	:: Searches for foo; append `!` to refresh local cache
"	:PluginClean			:: Confirms removal of unused plugins; append `!` to auto-approve removal

set nocompatible    " be iMproved, required
filetype off        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'vundlevim/Vundle.vim'

" Plugins
Plugin 'ap/vim-css-color'
Plugin 'bling/vim-airline'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'omnisharp/omnisharp-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'pprovost/vim-ps1'
Plugin 'raimondi/delimitMate'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'shougo/neocomplcache.vim'
Plugin 'shougo/unite.vim'
Plugin 'ternjs/tern_for_vim'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'valloric/youcompleteme'
Plugin 'wting/rust.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"---------- END VUNDLE ----------"
"---------- AIRLINE ----------"

"	Commands:
"		none, just shows the tabline of buffers and the status bar at the bottom

" need utf-8 to display special characters for the arrows
set encoding=utf-8
" without this airline only shows up after the page has been split by nerdtree
set laststatus=2
" use the powerline fonts to get the fancy arrows
let g:airline_powerline_fonts = 1
" NOTE: the status line below depends on vim-fugitive
let g:airline_section_b = '%{getcwd()} %{fugitive#statusline()}'
let g:airline_section_c = '%t'
" show buffers in the tabline
let g:airline#extensions#tabline#enabled = 1
" Show just the filename of the buffer in the tabline
let g:airline#extensions#tabline#fnamemod = ':t'

"---------- END AIRLINE ----------"
"---------- JSON ----------"

" Commands:
"	none, just syntax-highlighting

" don't hide quotes around keys automatically
let g:vim_json_syntax_conceal = 0

"---------- END JSON ----------"
"---------- TAGBAR ----------"

" Commands:
"	<f8>					:: Toggle tagbar

nmap <F8> :TagbarToggle<CR>
nmap <leader>st :TagbarShowTag<CR>

"---------- END TAGBAR ----------"
"---------- GO ----------"

" Commands:
"

" Shell commands for GO
au FileType go nmap <leader>tr <Plug>(go-run)
au FileType go nmap <leader>tb <Plug>(go-build)
au FileType go nmap <leader>tt <Plug>(go-test)
au FileType go nmap <leader>tc <Plug>(go-coverage)
"au FileType go nmap <leader>tgd <Plug>(go-docs)
"au FileType go nmap <leader>tgb <Plug>(go-docs-browser)

"---------- END GO ----------"
"---------- TERN ----------"

" Commands:
"	<leader> td 	:: Documentation under cursor
"	<leader> tb 	:: Browse Documentation
"	<leader> tt 	:: Type hints
"	<leader> td 	:: Jump to definition
"	<leader> tpd 	:: Jump to definition inside preview
"	<leader> tsd 	:: Definition in new split
"	<leader> ttd 	:: Definition in new tab
"	<leader> tr 	:: All references under cursor
"	<leader> tR 	:: Rename variable

" Use above mappings
let g:tern_map_keys=1
" Display arg type hints when cursor is left over function
"let g:tern_show_argument_hints='on_hold'


"---------- END TERN ----------"
"---------- SUPERTAB ----------"

" Commands:
"	allows you to use <Tab> for all your insert completion needs

let g:SuperTabMappingForward = '<c-j>'
let g:SuperTabMappingBackward = '<c-k>'

"---------- END SUPERTAB ----------"
"---------- CSS3 SYNTAX ----------"

" Commands:
"	none. Adds css3 syntax support to vim's built-in syntax/css.vim

"---------- END CSS3 SYNTAX ----------"
"---------- LUCIUS ----------"

" Commands:
"	none. Color theme.

"---------- END LUCIUS ----------"
"---------- DELIMIT MATE -----------"
" Commands:
"	none. Adds closing brace automatically
imap <C-c> <CR><Esc>O
"---------- END DELIMIT MATE -----------"
"---------- INDENT GUIDES ----------"
"
" Commands:
"	<leader>ig					:: Show/hide the indent guides

"---------- END INDENT GUIDES ----------"
"---------- HTML5 ----------"
"
" Commands:
"	none. Syntax highlighting only.

"Disable event-handler attributes support
let g:html5_event_handler_attributes_complete = 0

"---------- END HTML5 ----------"
"---------- OMNISHARP ----------"
"
" Commands:
"	none. dotnet completion server

" Use unite for code actions, find type, and find symbol
let g:OmniSharp_selector_ui = 'unite'  " Use unite.vim

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1
" Get code issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>

augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    "autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    "autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    "autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    "autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END

"---------- END OMNISHARP ----------"
"---------- JAVSCRIPT ----------"

" Commands:
"	none. Adds enhanced javascript syntax indent support to vim's

" enable html/css syntax highlighting in JS files
let g:javascript_enable_domhtmlcss = 1

"---------- END JAVASCRIPT ----------"
"---------- AG ----------"

" Commands:
"	:ag [options] {pattern} [{directory}]	:: Run ag search

"---------- END AG ----------"
"---------- NERD COMMENTER ----------"
"
" Commands:
"	<leader>c						:: Toggle commenting on line or visual selection
"	<leader>cc						:: Comment out line or visual selection
"	<leader>cu						:: Uncomment line or visual selection
"	<leader>cs						:: Comment out the line sexy style
"	<leader>ca						:: Change to alternate comment style
"	<leader>c$						:: Commend to end of line

"---------- END NERD COMMENTER ----------"
"---------- NERDTREE --"
"
" Commands:
"	Ctrl-n				:: Open/close nerdtree
"	<leader>sin					:: Show current file in nerdtree

map <silent> <C-n> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pdb$','\.dll$','\.sln$','\.csproj$', '\.user$', '\.dat$', '\.dll.config$', '\.xml$']
nnoremap <silent> <leader>sin :NERDTreeFind<cr>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"---------- END NERDTREE --"
"---------- SYNTASTIC ----------"
" Commands:
"	<leader>jj	:: Run syntax check and open error window
"	<leader>E		:: Open error window

let g:syntastic_javascript_checkers=['jscs']
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nnoremap <silent> <leader>jj :SyntasticCheck<cr>:Error<cr>
" 	*Error List*
nnoremap <silent> <leader>E :Error<cr>

"---------- END SYNTASTIC ----------"
"---------- FUGITIVE ----------"
"
" Commands:
"	:Gdiff				:: Diff the staged and HEAD version of the current file
"	:Gblame				:: Show git blame for current file
"	:GStatus			:: Show git status
"	:GCommit			:: Open git commit window
"	:Glog					:: Show file revision history

"---------- END FUGITIVE ----------"
"---------- SURROUND ----------"
" Commands:
"	cs"'					:: Change surrounding " with '
"	cs'<q>				:: Change surrounding ' with <q></q>
"	cst"					:: Change surrounding tag with "
"	ds"						:: Delete surrounding "
"	ysiw]					:: Add [] around the current word
"	yss)					:: Add () around the current line

"---------- END SURROUND ----------"
"---------- UNIMPAIRED ----------"
" Commands:
"	[e						:: Swap current line with one above
"	]e						:: Swap current line with one below
"	[q						:: Previous item in quickfix window
"	]q						:: Next item in quickfix window
"	[a						:: Previous file
"	]a						:: Next file
"	[b						:: Previous buffer
"	]b						:: Next buffer
"	[t						:: Previous tag
"	]t						:: Next tag
"	[l						:: Previous item in location list window
"	]l						:: Next item in location list window
"	[<space>			:: Add newline before
"	]<space>			:: Add newline after
"	[os						:: Turn on spellcheck
"	]os						:: Turn off spellcheck
"	cos						:: Spellcheck current buffer

"---------- END UNIMPAIRED ----------"
"---------- YOUCOMPLETEME ----------"
"
" Commands:
"	none. Auto-completion

"---------- END YOUCOMPLETEME ----------"
"---------- RUST ----------"
"
" Commands:
"	none. Syntax highlighting

"---------- END RUST ----------"
"---------- JAKE:GUI ----------"
"
" Commands:
"	none.

" Maximize window when using GVim
au GUIEnter * simalt ~x
set guioptions-=m "remove menubar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right hand scrollbar
set guioptions-=L "remove left hand scrollbar
set guioptions-=b "remove bottom scrollbar

" Set the default font for GUI
set guifont=Anonymice_Powerline:h16:cANSI

" Allow us to use all the fancy colors :)
"set term=xterm
"set t_Co=256
"let &t_AB="\e[48;5;%dm"
"let &t_AF="\e[38;5;%dm"

" Set the theme when supporting 256+ colors
if &t_Co >= 256 || has("gui_running")
	set background=dark
	colorscheme lucius
endif

" Syntax Highlighting when supporting 2+ colors
if &t_Co > 2 || has("gui_running")
	" switch syntax highlighting on, when the terminal has colors
	syntax on
	syntax enable
endif

"---------- JAKE:OPTIONS ----------"
"
" Commands:
"	none.

" Use the >- characters for tabstops
set listchars=eol:␊,tab:»»,trail:Ξ,extends:▶,precedes:◀,nbsp:∥

"set autoread			" Set to auto read when a file is changed from the outside
set hidden				" hide buffers instead of closing them
set tabstop=2			" Tabstop should look like 2 spaces"
set nowrap				" don't wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent		" always set autoindenting on
set copyindent		" copy the previous indentation on autoindenting
set number				" always show line numbers
set shiftround		" use multiple of shiftwidth when indenting with '<' and '>'
set noshowmatch		" showmatch disabled due to slowness with omnisharp
"set showmatch		" briefly flash to the matching brace when you insert one (doesn't scroll)
set mat=2					" How many tenths of a second to blink when matching brackets
set ignorecase		" ignore case when searching with /
set smartcase			" ignore case if search pattern is all lowercase, case sensitive
										" otherwise (ignorecase is required for this to work)
set smarttab			" inserts tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch			" highlight search terms
set incsearch			" show search matches as you type
set history=1000	" remember more commands and search history
set undolevels=1000 " use many muchos levels of undo
set wildmenu			" autocompletion menu on vim commands
set wildmode=longest:full,full " menu display mode
set title					" change the terminal's title automatically to the filename
set visualbell		" don't beep
set noerrorbells	" don't beep
set nobackup			" don't create backup files
set noswapfile		" don't create swap files
set pastetoggle=<F2> 	" stop autoformatting issues by switching to paste mode
set lazyredraw		" Don't redrew while executing macros (good performance congif)
set foldmethod=indent 	"fold based on indent.(za toggle fold)
set foldnestmax=10	" deepest fold is 10 levels
set nofoldenable	" don't fold by default
set foldlevel=100
set lbr						" Linebreak on 500 characters
set tw=500

" ignore these filetypes
set wildignore+=*/tmp/*,*/temp/*		" Temp directories
set wildignore+=*.testsettings			" VS MSTEST Testsettings files
set wildignore+=*.swp								" Swap files
set wildignore+=*.bak								" Backup files
set wildignore+=*.dll								" Dynamically linked libraries
set wildignore+=tags								" Ctags
set wildignore+=*.zip,*.7zip,*.tar	" Compressed files
set wildignore+=*.exe,*.o						" Binaries
set wildignore+=*.suo,*.sln,*.csproj	" VS ProjectManagement Files
set wildignore+=*.xml								" XML Data
set wildignore+=*/node_modules/*		" Node dependencies
set wildignore+=*/bower_modules/*		" Bower dependencies
set wildignore+=*/bin/*,*/obj/*			" Binary directories
set wildignore+=*/.hg/*							" Mercurial
set wildignore+=*/.git/*						" Git
set wildignore+=*/.svn/*						" Subversion

" Marker line at 80 columns
if exists('+colorcolumn')
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+, -1)
endif

" virtual tabstops using spaces
let my_tab=2
execute "set shiftwidth=".g:my_tab
set softtabstop=0
set noexpandtab
" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
  	execute "echo('tabs')"
    execute "set shiftwidth=".g:my_tab
    set softtabstop=0
    set noexpandtab
  else
  	execute "echo('spaces')"
    execute "set shiftwidth=".g:my_tab
    execute "set softtabstop=".g:my_tab
    set expandtab
  endif
endfunction
nmap <F9> mz:execute TabToggle()<CR>'z

" Save aliases
map <C-s> :w<cr>
map <C-S-s> :w!<cr>

" Window Navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h

" Shell commands for Javascript
au FileType javascript nmap <silent> <leader>tr :!cls;npm start;echo "npm start"<cr>
au FileType javascript nmap <silent> <leader>tR :!cls;node %:p;echo "node filename"<cr>
au FileType javascript nmap <silent> <leader>tt :!cls;npm test<cr>
au FileType javascript nmap <silent> <leader>tT :!cls;./node_modules/mocha/bin/mocha %:p<cr>
au FileType javascript nmap <silent> <leader>td :!cls;node-debug %:p<cr>
" Shell commands for C++
au FileType cpp nmap <silent> <leader>tb :!cls;g++ -std=c++11 %:p;a.out<cr>


" Close scratch/preview window
map <silent> <leader>q :pc<cr>

"---------- END JAKE:OPTIONS ----------"

"---------- JAKE:SHORTCUTS ----------"
"
" Commands:
"	Alt-y					:: Copy to system clipboard
"	Alt-p					:: Paste from system clipboard
"	<leader>w					:: Close location list window
"	<leader>jf					:: Format json file
"	<leader>l					:: Show tabs
"	:w!!					:: Write as Admin
"	<leader><enter>				:: Clear search
"	<leader>bd					:: Delete buffer

" Copy/Paste from clipboard
vnoremap <silent> <A-y> "+y<ESC>
vnoremap <silent> <A-p> c<ESC>"+p
nnoremap <silent> <A-p> "+p
inoremap <silent> <A-p> <ESC>"+pa

" shortcut to close location list window
nnoremap <silent> <leader>w :ccl<cr>:lclose<cr>

" shortcut to format json
nnoremap <silent> <leader>jf :%!python -m json.tool<cr>

" Shortcut to rapidly toggle `set list`
nmap <silent> <leader>l :set list!<cr>

" forgot to sudo into file? force save with :w!!
cmap w!! w !sudo tee % >/dev/null

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Delete buffer
nnoremap <leader>bd :bd<cr>

" Cycle through filtered history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"---------- END JAKE:SHORTCUTS ----------"
"---------- JAKE:AUTO COMMANDS ----------"
"
" Commands:
"	none.

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

"---------- END JAKE:AUTO COMMANDS ----------"
