"act similar to mswin applications, Control+C, Control+P, etc.
behave mswin

runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

"its ok to not be vi compatibale
set nocompatible

"don't create ~filename backups, very annoying to leave this on and find dozens of extra files scattered about
set nobackup

"if xterm, assume color is OK
if &term =~ "xterm" || &term =~ "color"
	set t_Co=8
	"Tell vim it's ok to send color
	if &term =~ "xterm"
		set term=xterm-color
	endif

	"All around well balanced colorscheme
	colorscheme ron

	"For med-dark monitors 'ron' or 'koehler' colorschemes are great
	"colorscheme koehler
endif

"if terminal supports 256 coloring
if &term =~ "256color"
	"For bright monitors, 'ir-black' is nice to the eyes, enable 256 mode and set colorscheme to 'ir-black'
	"set t_Co=256
	"colorscheme ir-black
endif

"Turn on syntax highlighting, this works regardless of color settings
syntax on

"enable the mouse & features
set mouse=a
set selectmode-=mouse "Use the mouse just like visual mode, so you can use vim commands on mouse selections, eg. 'x' to cut and 'y' to yank

"This is if you have a dark background in your terminal, light is another option
set background=dark
"set background=light


set backspace=2 "backspace works in insert mode, much more user-friendly
set tabstop=2 "set tab width to 4 spaces
set shiftwidth=2 "set (auto)tab's to width of 4 spaces
set expandtab "spaces instead of tabs
"Neither of the above actually puts spaces into a file when tabbing, they simply display 4 spaces when a \t is read
set ignorecase "ignore case when searching
set hlsearch "highlight searchs
set smartcase "override ignorecase if any search character is uppercase
set autoindent "turn on auto indent
set smartindent "turn on smart indent
set number "show line numbers
set nowrap "don't wrap lines longer than the screen's width
"set wrapmargin=80
set guioptions+=b "show bottom scrollbar when in gvim
set foldmethod=indent "fold code based on indents
set nofoldenable "makes sure the code is not folded when first opened, used zi to toggle
set ruler "Show line statistics in bottom left corner
set scrolloff=4 "Keep 4 lines at minimum above & below the cursor when scrolling around a file

"These options are personal preference
"set cursorline "Underline the current line the cursor is on.
"set incsearch "highlight search matches as typed, may jar your mind while jumping around the file

"Upgrade the status line to give more usefull information
set statusline=%F\ %m%r%w%y\ %=(%L\ loc)\ [#\%03.3b\ 0x\%02.2B]\ \ %l,%v\ \ %P
set laststatus=2 "Make statusline always on
set cmdheight=2 "default command line number of lines, 2 makes it easier to read

"Printing (:hardcopy) options
set printoptions=paper:letter,syntax:y,number:y,duplex:off,left:5pc

"Enable filetype's
filetype on
filetype indent on
filetype plugin on

"Wrap visual selections with chars
:vnoremap ( "zdi(<C-R>z)<ESC>
:vnoremap { "zdi{<C-R>z}<ESC>
:vnoremap [ "zdi[<C-R>z]<ESC>
:vnoremap ' "zdi'<C-R>z'<ESC>
:vnoremap " "zdi"<C-R>z"<ESC>

"If your having trouble with the backspace character, try uncommenting these
"imap <C-?> <BS>
"imap <C-H> <BS>
"inoremap <BS>


" Autocompletion using the TAB key
" This function determines, whether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction

" Remap the tab key to select action with InsertTabWrapper
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>

if has("autocmd")
    " Have Vim jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

	" Support mips.asm files
	autocmd BufNewFile,BufRead *.mips.asm set syntax=mips.vim

  " Support crontab files
  autocmd BufNewFile,BufRead,BufReadPost *.cron,*.crontab set filetype=crontab

    " Trim Trailing white space on general files
    autocmd FileType c,cpp,java,php,js,css,xml,xsl,s autocmd BufWritePre * :%s/[ \t\r]\+$//e
endif

"Support for Gundo, a visual & mini tree structure of document changes
nnoremap <F5> :GundoToggle<CR>

set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
