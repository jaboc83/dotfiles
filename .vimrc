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
let g:airline_powerline_fonts = 1
" Replace the branch indicator with the current working directory, followed by the filename.
let g:airline_section_b = '%{getcwd()}'
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
set guifont=Anonymice_Powerline:h16:cANSI

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

" Updated ctags
nnoremap <f8> :!ctags -R .<cr>

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

" Using ConEmu as your terminal?
if !empty($CONEMUBUILD)
	" Allow us to use all the fancy colors :)
	"set term=xterm
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

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
" 	*Args List*
nnoremap <silent> [a :previous<cr>
nnoremap <silent> ]a :next<cr>
nnoremap <silent> [A :first<cr>
nnoremap <silent> ]A :last<cr>
" 	*Tag List*
nnoremap <silent> [t :tprevious<cr>
nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [T :tfirst<cr>
nnoremap <silent> ]T :tlast<cr>

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


"--- END JAKE STUFF ---"
"--- NERDTREE --"
"
" 	Commands: <C-n> open/close nerdtree

" Map ctrl+n to nerdtree toggle
map <silent> <C-n> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pdb$','\.dll$','\.sln$','\.csproj$', '\.user$', '\.dat$', '\.dll.config$', '\.xml$']
nnoremap <silent> <leader>sin :NERDTreeFind<cr>

"--- END NERDTREE --"
"--- AG  ---"
"
" Commands: <leader>k :: Run a search

"--- END AG ---"
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
"--- NEOCOMPLCACHE ---"

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 0
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"--- END NEOCOMPLCACHE ---"
""--- OMNISHARP ---"

""Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

""don't autoselect first item in omnicomplete, show if only one item (for preview)
""remove preview if you don't want to see any documentation whatsoever.
"set completeopt=longest,menuone,preview
"" Fetch full documentation during omnicomplete requests.
"" There is a performance penalty with this (especially on Mono)
"" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
"" you need it with the :OmniSharpDocumentation command.
"" let g:omnicomplete_fetch_documentation=1

""Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
""You might also want to look at the echodoc plugin
"set splitbelow

"" Get Code Issues and syntax errors
"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
"" If you are using the omnisharp-roslyn backend, use the following
"" let g:syntastic_cs_checkers = ['code_checker']
"augroup omnisharp_commands
    "autocmd!

    ""Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    "" Synchronous build (blocks Vim)
    ""autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    "" Builds can also run asynchronously with vim-dispatch installed
    "autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    "" automatic syntax check on events (TextChanged requires Vim 7.4)
    "autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    "" Automatically add new cs files to the nearest project on save
    "autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    ""show type information automatically when the cursor stops moving
    "autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    ""The following commands are contextual, based on the current cursor position.

    "autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    "autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    "autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    "autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    "autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    ""finds members in the current buffer
    "autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    "" cursor can be anywhere on the line containing an issue
    "autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    "autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    "autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    "autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    ""navigate up by method/property/field
    "autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    ""navigate down by method/property/field
    "autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

"augroup END


"" this setting controls how long to wait (in ms) before fetching type / symbol information.
"set updatetime=500
"" Remove 'Press Enter to continue' message when type information is longer than one line.
"set cmdheight=2

"" Contextual code actions (requires CtrlP or unite.vim)
"nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
"" Run code actions with text selected in visual mode to extract method
"vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

"" rename with dialog
"nnoremap <leader>nm :OmniSharpRename<cr>
"nnoremap <F2> :OmniSharpRename<cr>
"" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
"command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

"" Force OmniSharp to reload the solution. Useful when switching branches etc.
"nnoremap <leader>rl :OmniSharpReloadSolution<cr>
"nnoremap <leader>cf :OmniSharpCodeFormat<cr>
"" Load the current .cs file to the nearest project
"nnoremap <leader>tp :OmniSharpAddToProject<cr>

"" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
"nnoremap <leader>ss :OmniSharpStartServer<cr>
"nnoremap <leader>sp :OmniSharpStopServer<cr>

"" Add syntax highlighting for types and interfaces
"nnoremap <leader>th :OmniSharpHighlightTypes<cr>
""Don't ask to save when changing buffers (i.e. when jumping to a type definition)
"set hidden

""--- END OMNISHARP ---
