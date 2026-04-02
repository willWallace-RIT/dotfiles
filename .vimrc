	"set pyxversion=3"
	"
	filetype plugin on
	set omnifunc=syntaxcomplete#Complete 
	filetype plugin indent on
	syntax on
	set encoding=utf-8
	set number
	set cmdheight=1
	" Specify a directory for plugins
	" - For Neovim: ~/.local/share/nvim/plugged
	" - Avoid using standard Vim directory names like 'plugin'
	call plug#begin('~/.vim/plugged')
	set visualbell "stops system beep
	" Use Vim settings, rather then Vi settings. This setting must be as early as
	" possible, as it has side effects.
	set nocompatible


	" Leader - ( Spacebar )
	set backspace=2   " Backspace deletes like most programs in insert mode
	set showcmd       " display incomplete command
	set laststatus=2  " Always display the status line
	set autoread      " Reload files changed outside vim
	" Trigger autoread when changing buffers or coming back to vim in terminal.
	au FocusGained,BufEnter * :silent! !
	set wildmenu
	set wildmode=list:longest,full

	" Make searching better
	set gdefault      " Never have to type /g at the end of search / replace again
	set ignorecase    " case insensitive searching (unless specified)
	set smartcase
	set hlsearch
	nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
	set incsearch
	set showmatch

	" Softtabs, 2 spaces
	set tabstop=2
	set shiftwidth=2
	set shiftround
	set expandtab

	" Display extra whitespace
	set list listchars=tab:»·,trail:·,nbsp:·,

	" Make it obvious where 100 characters is
	set textwidth=100
	" set formatoptions=cq
	set formatoptions=qrn1
	set wrapmargin=0
	set colorcolumn=+1

	" Numbers
	set number
	set numberwidth=5

	" Open new split panes to right and bottom, which feels more natural
	" set splitbelow
	set splitright

	" Auto resize Vim splits to active split
	set winwidth=104
	set winheight=5
	set winminheight=5
	set winheight=999

	"HTML Editing
	set matchpairs+=<:>

	" Treat <li> and <p> tags like the block tags they are
	let g:html_indent_tags = 'li\|p'

	" ================ Scrolling ========================

	set scrolloff=8         "Start scrolling when we're 8 lines away from margins
	set sidescrolloff=15
	set sidescroll=1

	"Toggle relative numbering, and set to absolute on loss of focus or insert mode
	set rnu
	function! ToggleNumbersOn()
			set nu!
			set rnu
	endfunction
	function! ToggleRelativeOn()
			set rnu!
			set nu
	endfunction
	autocmd FocusLost * call ToggleRelativeOn()
	autocmd FocusGained * call ToggleRelativeOn()
	autocmd InsertEnter * call ToggleRelativeOn()
	autocmd InsertLeave * call ToggleRelativeOn()

	"Use enter to create new lines w/o entering insert mode
	nnoremap <CR> o<Esc>
	"Below is to fix issues with the ABOVE mappings in quickfix window
	autocmd CmdwinEnter * nnoremap <CR> <CR>
	autocmd BufReadPost quickfix nnoremap <CR> <CR>

	" Quicker window movement
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-h> <C-w>h
	nnoremap <C-l> <C-w>l
	" <c-h> is interpreted as <bs> in neovim
	" This is a bandaid fix until the team decides how
	" they want to handle fixing it...(https://github.com/neovim/neovim/issues/2048)
	nnoremap <silent> <bs> :TmuxNavirateLeft<cr>

	" Navigate properly when lines are wrapped
	nnoremap j gj
	nnoremap k gk

	" Use tab to jump between blocks, because it's easier
	nnoremap <tab> %
	vnoremap <tab> %

	" Set spellfile to location that is guaranteed to exist, can be symlinked to
	" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
	set spellfile=$HOME/.vim-spell-en.utf-8.add

	" Always use vertical diffs
	set diffopt+=vertical

	" Switch syntax highlighting on, when the terminal has colors
	" Also switch on highlighting the last used search pattern.
	if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
		syntax on
	endif



	function! BuildYCM(info)
			" info is a dictionary with 3 fields
			" - name:   name of the plugin
			" - status: 'installed', 'updated', or 'unchanged'
			" - force:  set on PlugInstall! or PlugUpdate!
		if a:info.status == 'installed' || a:info.force
			!./install.py --tern-completer
	endif
endfunction



" PLUGINS
" Syntastic
Plug 'scrooloose/syntastic' "syntax checking
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox' 
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sensible'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug '/usr/bin/fzf'
"denite may not work
"Plug 'shougo/denite'
Plug 'shougo/neocomplete'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
"Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'OmniSharp/omnisharp-vim'
" Several plugins to help work with Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'https://github.com/christoomey/vim-tmux-runner'
Plug 'christoomey/vim-run-interactive'
" [4] search filesystem with ctrl+p
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jimmyhchan/dustjs.vim' "Highlighting for Dust
Plug 'elmcast/elm-vim' "Highlighting for Elm
" [6] Adds a ; at the end of a line by pressing <leader> ;
Plug 'lfilho/cosco.vim'
Plug 'jiangmiao/auto-pairs' "MANY features, but mostly closes ([{' etc
Plug 'vim-scripts/HTML-AutoCloseTag' "close tags after >
Plug 'vim-scripts/tComment' "Comment easily with gcc
Plug 'tpope/vim-repeat' "allow plugins to utilize . command
Plug 'tpope/vim-surround' "easily surround things...just read docs for info
Plug 'vim-scripts/matchit.zip' " % also matches HTML tags / words / etc
Plug 'duff/vim-scratch' "Open a scratch buffer
"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator',{'branch':'stable'}
Plug 'Valloric/ListToggle'
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/ingo-library'
Plug 'tomtom/tcomment_vim'
" Provides Async autocomplete with Tern
"Plug 'https://github.com/Shougo/deoplete.nvim'
"Plug 'roxma/vim-hug-neovim-rpc'
"let g:SuperTabDefaultCompletionType = '<C-n>'
" IDE like code intelligence for Javascript
Plug 'ternjs/tern_for_vim', {'do': 'npm install tern'}
"deopleete plugs"
Plug 'Shougo/neco-vim'
Plug 'Rip-Rip/clang_complete'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'c9s/perlomni.vim'
Plug 'carlitux/deoplete-ternjs',{'do':'npm install -g tern'}
Plug 'SevereOverfl0w/deoplete-github'
Plug 'deoplete-plugins/deoplete-asm'
"Plug 'deoplete-plugins/deoplete-dictionary'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neopairs.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Konfekt/FastFold'
Plug 'php-vim/phpcd.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'chrisbra/unicode.vim'
Plug 'will133/vim-dirdiff'
Plug 'ap/vim-css-color'
Plug 'habamax/vim-godot'
"location list toggle using \l \q"
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'


autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %


if has('nvim')
 Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
 Plug 'https://github.com/Shougo/deoplete.nvim'
 Plug 'roxma/nvim-yarp'
 Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

"deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"Sensible
"runtime! plugin/sensible.vim

"emmet
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {'javascript.jsx':{ 'extends' : 'jsx',},}

"Sytastic defaults

"statusline settings
set statusline=%f\ %h%w%m%r\ 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)
set laststatus=2
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_c_compiler_options = '-std=c++20'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"OMNISHarp
let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_server_path = '/opt/omnisharp-roslyn/OmniSharp.exe'
"let g:OmniSharp_server_type = 'roslyn'
let g:OmniSharp_server_stdio=1
let g:OmniSharp_selector_ui='fzf'
"let g:ale_cs_mcsc_assemblies = ['~/UnityEdit/2019.4.1f1/Editor/Data/Managed/UnityEngine.dll']
"let g:ale_cs_mcsc_assemblies +=["~/New Unity Project/Library/ScriptAssemblies"]
"let g:OmniSharp_start_server=0
let g:OmniSharp_typeLookupInPreview=1
autocmd FileType cs let g:OmniSharp_start_server=1

"Gruvbox settings
colorscheme gruvbox
let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='dark'
set background=dark

"Unimpaired gruvbox remaps
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

"Tagbar settings
nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_gdscript = {
			\'ctagstype' :'gdscript',
			\'kinds':[
			\'v:variables',
			\'f:functions',
			\]
			\}

"unite settins
"file search
nnoremap <C-p> :Unite file_rec/async<cr>
"content search
nnoremap <space>/ :Unite grep:.<cr>
"yank history
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
"buffer switch
nnoremap <space>s :Unite -quick-match buffer<cr>
"ALE settings
let g:ale_sign_error = 'â—' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
call ale#linter#Define('gdscript',{
\'name': 'godot',
\'lsp': 'socket',
\'address':'127.0.0.1:6008',
\'project_root': "project.godot",
\})

let g:ale_linters={'c':[],'cpp':[],'cs':['OmniSharp'],'gdscript':['godot']}



"SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
noremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
"   " Use Ag over Grep
	set grepprg=ag\ --nogroup\ --nocolor
"
"       " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_working_path_mode = 'r'

    " ag is fast enough that CtrlP doesn't need to cache
    	let g:ctrlp_use_caching = 0
    	let g:ctrlp_extensions = ['line']
endif

"Nerd tree [2]
map <silent> <C-n> :NERDTreeToggle<cr>
nnoremap <C-t> :call ToggleRelativeOn()<cr>
" Close vim if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Allow moving around between Tmux windows
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
"
""Open a tmux pane with Node
nnoremap <leader>node :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'node'}<cr>


" configure syntastic syntax checking to check on open as well as save
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes':['javascript'], 'passive_filetypes': [] }


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" " Syntastic will search for an .eslintrc in your project, otherwise it defaults
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc','.;') != '' ? ['eslint'] : ['standard']
" these 2 lines check to see if eslint is installed via local npm and runs that before going global
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path,'^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
" Allow highlighting of HTML within Javascript (for React)
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

" [6] Key mapping for Cosco.vim - space + ; to add semicolon or comma in Javascript or CSS
autocmd FileType javascript,css nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> <Leader>; <c-o>:call cosco#commaOrSemiColon()<CR>

" [9]
" " Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<c-c>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"


" [10] make YCM compatible with UltiSnips (using supertab)
"let g:SuperTabDefaultCompletionType = '<C-n>'
autocmd FileType cs let g:deoplete#enable_at_startup = 1


if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


" omnifuncs
augroup omnifuncs
	autocmd!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
 autocmd FileType javascript,javascript.jsx setlocal omnifunc=syntaxcomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
augroup end

 " tern
 
if exists('g:plugs["tern_for_vim"]')
	let g:tern_show_argument_hints = 'on_hold'
      	let g:tern_show_signature_in_pum = 1
        let g:tern_map_keys = 1
  			let g:tern#command = ["node", expand('<sfile>:h') . '/./.vim/plugged/tern_for_vim/node_modules/tern/bin/tern', '--no-port-file']

				let g:tern#arguments=["--persistent"]
       autocmd FileType javascript,javascript.jsx setlocal omnifunc=tern#Complete
endif

"vim-hug-neovim-rpc
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
let $NVIM_PYTHON_LOG_LEVEL="DEBUG"


"ycm ycm extra global
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
autocmd FileType cpp setlocal keywordprg=cppman

" deoplete
" ---

call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', 'deoplete.log')<CR>
 call deoplete#custom#source('tern', 'debug_enabled', 1)

" General settings " {{{
" ---

let g:ycm_filetype_blacklist={'vim':1,'cs':1}
call deoplete#custom#option({
	\ 'auto_refresh_delay': 10,
	\ 'camel_case': v:true,
	\ 'skip_multibyte': v:true,
	\ 'prev_completion_mode': 'none',
	\ 'min_pattern_length': 1,
	\ 'max_list': 10000,
	\ 'skip_chars': ['(', ')', '<', '>'],
	\ })
	"\ 'prev_completion_mode': 'filter',

" Deoplete Jedi (python) settings
let g:deoplete#sources#jedi#statement_length = 30
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#short_types = 1

" Deoplete TernJS settings

"let g:deoplete#sources#ternjs#tern_bin = expand('<sfile>:h') . '/./.vim/plugged/tern_for_vim/node_modules/tern/bin/tern'
let g:deoplete#sources#ternjs#filetypes = [
\ 'jsx',
\ 'javascript',
\ 'javascript.jsx',
\ 'vue',
\ ]

let g:deoplete#sources#ternjs#timeout = 3


" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0



"  }}}
" Limit Sources " {{{
" ---

"  }}}
" Omni functions and patterns " {{{
" ---
if ! exists('g:context_filetype#same_filetypes')
	let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte = [
	\   { 'filetype': 'css', 'start': '<style>', 'end': '</style>' },
	\ ]

call deoplete#custom#var('omni', 'functions', {
	\   'css': [ 'csscomplete#CompleteCSS' ],'cs': ['Omnisharp#Complete'],'javascript':['tern#Complete']
	\ })

call deoplete#custom#option('omni_patterns', {
	\ 'go': '[^. *\t]\.\w*',
	\})

" }}}
"
"  Ranking and Marks " {{{
" Default rank is 100, higher is better.
call deoplete#custom#source('omni',          'mark', '<omni>')
call deoplete#custom#source('flow',          'mark', '<flow>')
call deoplete#custom#source('padawan',       'mark', '<php>')
call deoplete#custom#source('tern',          'mark', '<tern>')
"
call deoplete#custom#source('go',            'mark', '<go>')
call deoplete#custom#source('jedi',          'mark', '<jedi>')
call deoplete#custom#source('vim',           'mark', '<vim>')
call deoplete#custom#source('neosnippet',    'mark', '<snip>')
call deoplete#custom#source('tag',           'mark', '<tag>')
call deoplete#custom#source('around',        'mark', '<around>')
call deoplete#custom#source('buffer',        'mark', '<buf>')
call deoplete#custom#source('tmux-complete', 'mark', '<tmux>')
call deoplete#custom#source('syntax',        'mark', '<syntax>')
call deoplete#custom#source('member',        'mark', '<member>')

call deoplete#custom#source('padawan',       'rank', 660)
call deoplete#custom#source('go',            'rank', 650)
call deoplete#custom#source('vim',           'rank', 640)
call deoplete#custom#source('flow',          'rank', 630)
call deoplete#custom#source('TernJS',        'rank', 620)
call deoplete#custom#source('jedi',          'rank', 610)
call deoplete#custom#source('omni',          'rank', 600)
call deoplete#custom#source('neosnippet',    'rank', 510)
call deoplete#custom#source('member',        'rank', 500)
call deoplete#custom#source('file_include',  'rank', 420)
call deoplete#custom#source('file',          'rank', 410)
call deoplete#custom#source('tag',           'rank', 400)
call deoplete#custom#source('around',        'rank', 330)
call deoplete#custom#source('buffer',        'rank', 320)
call deoplete#custom#source('dictionary',    'rank', 310)
call deoplete#custom#source('tmux-complete', 'rank', 300)
call deoplete#custom#source('syntax',        'rank', 50)

" }}}
" Matchers and Converters " {{{
" ---

" Default sorters: ['sorter/rank']
" Default matchers: ['matcher/length', 'matcher/fuzzy']

call deoplete#custom#source('_', 'matchers',
	\ [ 'matcher_fuzzy', 'matcher_length' ])

call deoplete#custom#source('_', 'converters', [
	\   'converter_remove_paren',
	\   'converter_remove_overlap',
	\   'converter_truncate_abbr',
	\   'converter_truncate_menu',
	\ ])

call deoplete#custom#source('denite', 'matchers',
	\ ['matcher_full_fuzzy', 'matcher_length'])

" }}}
" Key-mappings and Events " {{{
" ---
augroup user_plugin_deoplete
	autocmd!
	autocmd CompleteDone * silent! pclose!
augroup END

"Omnisharp commands
nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
" Builds can also run asynchronously with vim-dispatch installed
nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
" automatic syntax check on events (TextChanged requires Vim 7.4)
autocmd BufWritePost *.cs SyntasticCheck
autocmd BufWritePost *.cs SyntasticSetLoclist

" Automatically add new cs files to the nearest project on save
autocmd BufWritePost *.cs call OmniSharp#AddToProject()

"The following commands are contextual, based on the current cursor position.
nnoremap gd :OmniSharpGotoDefinition<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
"finds members in the current buffer
nnoremap <leader>fm :OmniSharpFindMembers<cr>
"cursor can be anywhere on the line containing an issue
nnoremap <leader>x  :OmniSharpFixIssue<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>

nnoremap <leader>rt :OmniSharpRunTests<cr>
nnoremap <leader>rf :OmniSharpRunTestFixture<cr>
nnoremap <leader>ra :OmniSharpRunAllTests<cr>
nnoremap <leader>rl :OmniSharpRunLastTests<cr>
nnoremap <leader>u <nop>

" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader>ca :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader>ca :call OmniSharp#GetCodeActions('visual')<cr>
"Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)

" Movement within 'ins-completion-menu'
imap <expr><C-j>   pumvisible() ? "\<Down>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<Up>" : "\<C-k>"

" Scroll pages in menu
inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>" : "\<C-u>"

" Undo completion
" inoremap <expr><C-g> deoplete#undo_completion()

" Redraw candidates
inoremap <expr><C-g> deoplete#manual_complete()
inoremap <expr><C-e> deoplete#cancel_popup()
inoremap <silent><expr><C-l> deoplete#complete_common_string()

" <CR>: If popup menu visible, expand snippet or close popup with selection,
"       Otherwise, check if within empty pair and use delimitMate.
"inoremap <silent><expr><CR> pumvisible() ? deoplete#close_popup()"
"	\ : (delimitMate#WithinEmptyPair() ? \<C-R>=delimitMate#ExpandReturn()\<CR>" : \<CR>")

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
"
imap <C-b>     <Plug>(neosnippet_expand_or_jump)
smap <C-b>     <Plug>(neosnippet_expand_or_jump)
xmap <C-b>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
     \ "\<Plug>(neosnippet_expand_or_jump)"
     \: "\<TAB>"

"imap <expr><silent><CR> pumvisible() ? deoplete#close_popup()."\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
"smap <silent><CR> <Plug>(neosnippet_expand_or_jump)


" inoremap <expr><S-Tab>  pumvisible() ? \<Up> : \<C-h>

"su
function! s:is_whitespace() "{{{
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~ '\s'
endfunction "}}}
" }}}

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
"

