"--------------------------------------------------------------------
"Configure vim properties.

let g:mapleader="\\"

syntax enable "Color code.
set backspace=indent,eol,start
set laststatus=1
set showcmd "Show number of seleced lines in visual mode.
set showmatch "Show pair of parenthesis/square brackets/braces.
set sw=4 "Establish number of spaces to indent.
set tabstop=4 "Establish tab length (4 spaces).
set noexpandtab "Set spaces as a set of tabs.
:%retab! "Retabulate the whole file.
set relativenumber "Enumerate lines according to cursor position.
set foldenable "Folds code lines.
set foldmethod=indent "Folds code lines depending on the indentation.
set foldlevelstart=0 "Folds code lines from indent 0.
set foldnestmax=4 "Folds code lines until indent 4.
set encoding=utf-8
set updatetime=100
"Modify pop up window background color to white.
"highlight Pmenu ctermbg=white guibg=white.
set incsearch "Highlight match on cursor when searching.
set hlsearch "Highlight all matches when searching.
set laststatus=2                             " always show statusbar
set statusline=
set statusline+=%-10.3n\                     " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position
"Press \\* to count the number of occurrences given the selected pattern.
map <leader>* *<C-O>:%s///gn<CR>
"Press <leader>hl to toggle highlighting on/off, and show current value.
:noremap <leader>hl :set hlsearch! hlsearch?<CR>
function GetVisualSelection()
  let raw_search = @"
  let @/=substitute(escape(raw_search, '\/.*$^~[]'), "\n", '\\n', "g")
endfunction
xnoremap // ""y:call GetVisualSelection()<bar>:set hls<cr>
xnoremap /s ""y:call GetVisualSelection()<cr><bar>:%s//
"--------------------------------------------------------------------
"Plugins installed.

"File where plugins are saved.
call plug#begin('~/.vim/plugged')
	"File system explorer
	Plug 'preservim/nerdtree'
	"Show customize status line (requires set laststatus=2).
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	"Show line changes in a file (oinly for git repositories).
	Plug 'airblade/vim-gitgutter'
	"You can use . command for plugin maps.
	Plug 'tpope/vim-repeat'
	"You can comment multiple lines easily.
	Plug 'tomtom/tcomment_vim'
	"Surround expressions with "",'',(),[],{}.
	Plug 'jiangmiao/auto-pairs'
	""Use Git commands in Vim.
	"Plug 'tpope/vim-fugitive'
	"Tabularize lines around a character.
	Plug 'godlygeek/tabular'
	"Markdown plugin.
	Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
	"Look for syntax errors.
	Plug 'vim-syntastic/syntastic'
	Plug 'syngan/vim-vimlint' "For vim
	Plug 'vim-jp/vim-vimlparser' "For vim
	"CP2K
	Plug 'cp2k/vim-cp2k'
	" LAMMPS
	Plug 'tommason14/lammps.vim'
call plug#end()
"--------------------------------------------------------------------
"Configuring NerdTree

"To open the file explorer, write the command :NERDTree or \ + t
nnoremap <leader>t :NERDTree<CR>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"--------------------------------------------------------------------
"Configuring syntastic

let g:syntastic_sh_checkers = ['sh']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_fortran_checkers = ['gfortran']
let g:syntastic_vim_checkers = ['vimlint']
let g:syntastic_python_checkers = ['pyflakes']
"Enable window of errors. You can open it with the command :lopen
"or \ + e
nnoremap <leader>e :lopen<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
"--------------------------------------------------------------------
"Configuring vim-airline

"Enable line of buffers.
let g:airline#extensions#tabline#enabled = 1
"Show complete buffer's names.
let g:airline#extensions#tabline#formatter = 'jsformatter'
"Don't show file format.
let g:airline_section_y = ''
"Customize vim airline.
let g:airline_theme='luna'
"--------------------------------------------------------------------
"Configuring git-gutter.

highlight! link SignColumn LineNr
"Line number highlighting by default.
let g:gitgutter_highlight_linenrs = 1
"Always show sign column.
"set signcolumn=yes
"Set colors to signs.
let g:gitgutter_set_sign_backgrounds = 1
highlight GitGutterAdd    guifg=#54fc00 ctermfg=2
highlight GitGutterChange guifg=#f8fc00 ctermfg=3
highlight GitGutterDelete guifg=#fc0000 ctermfg=1
"Customise symbols.
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^-'
let g:gitgutter_sign_removed_above_and_below = '--'
let g:gitgutter_sign_modified_removed = '>-'
"Open a window to show the list of changes.
nmap <Leader>hw :GitGutterQuickFix
"Activate Git-Gutter.
nmap <Leader>gd :GitGutterDisable<CR>
"Deactivate Git-Gutter.
nmap <Leader>ge :GitGutterEnable<CR>
"Show only changes.
nmap <Leader>gf :GitGutterFold<CR>
"Show line changes in a pop up window.
let g:gitgutter_preview_win_floating = 1
"Instructions:
"For every change you make in a file, you'll see marked lines to the
"left.
"To preview the line changes:
"1. Move cursor to modified line
"2. Press <Leader>hp
"To undo line changes:
" 1. Press <Leader>hu
"To move to the preview window:
"1. Press :wincmd P
"--------------------------------------------------------------------
"Configuring Tcomment.

"Add space after commenting.
let g:tcomment_types={'lammps': '# %s'}
let g:tcomment_types={'cp2k': '! %s'}
"Instructions:
"gcc: Comments the line.
"gc<Count>c{motion}: Toggles comment with count argument.
"gc<Count>c{motion}: Uncomment all the line.
"gc{motion}: Toggles the comment (Only first one)
"In visual mode:
"gc: Toggles comment.
"g> Comment selected text.
"--------------------------------------------------------------------
"Configuring auto-pairs.

let g:AutoPairsShortcutJump='<C-Down>'
let g:AutoPairsShortcutFastWrap='<C-Right>'
let g:AutoPairsShortcutToggle='p<ESC>'
let g:AutoPairsShortcutBackInsert='<C-Left>'
let g:AutoPairs = {'(':')','[':']','{':'}',"'":"'",'"':'"','```':'```','"""':'"""',"'''":"'''","`":"`",'<':'>'}
au FileType markdown let b:AutoPairs = AutoPairsDefine({'--':'--','*':'*','**':'**','__':'__','_':'_','***':'***','___':'___'})
au FileType cpp let b:AutoPairs = AutoPairsDefine({'<<':''})

"--------------------------------------------------------------------
"Configuring git-fugitive-

"Instructions:
":Git commit/:Git rebase -i	- Same as git commit.
":Git diff/:Git log		- Same as git diff.
":Git blame			- Displays lines status (git status for each line).
":Git				- Similar to git status.
":Gdiffsplit			- Displays side-by-side window to compare changes.
":Gread				- Variant of git checkout --<file:name>
"--------------------------------------------------------------------
"Configuring tabular.

"Instructions:
":Tab/<char>	-It aligns lines around the character <char>.
"--------------------------------------------------------------------
"Vimdiff.

"Instructions:
"diffupdate (to remove leftover spacing issues).
":only (once you’re done reviewing all conflicts, this shows only the middle/merged file).
":wq (save and quit).
"git add .
"git commit -m “Merge resolved”

"vimdiff commands:
"]c :        - next difference.
"[c :        - previous difference.
"do          - diff obtain.
"dp          - diff put.
"zo          - open folded text.
"zc          - close folded text.
"za	     - fold or unfold text.
":diffupdate - re-scan the files for differences.

"If you were trying to do a git pull when you ran into merge conflicts, type git rebase –continue
"CTRL+W W lets you toggle between the diff columns
