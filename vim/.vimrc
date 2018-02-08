"Iains global vim configuration file
" IMPORTANT: Dont put comments on same line as command eg set someting "setting stuff

"Default settings from http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim
" reset to vim-defaults
if &compatible       
   " use vim-defaults instead of vi-defaults (easier, more user friendly)
  set nocompatible   
endif

"""""""""""""""""""""""""""""""" DEFINE PLUGINS USING VUNDLE """""""""""""""""""""""""""""""""""""""""
"Need this line for package manager Vundle
set nocompatible
filetype plugin indent off
syntax off

"Bundle stuff 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'sjl/gundo.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()

filetype plugin indent on
syntax on

"""""""""""""""""""""""""""""""" EDITOR SPECIFIC SETTINGSS """""""""""""""""""""""""""""""""""""""""
set guifont=consolas
set nowrap              
" 2 lines above/below cursor when scrolling:
set scrolloff=2         
" show line numbers:
set number              
" show matching bracket (briefly jump):
set showmatch           
"set showmode           
set showcmd             
" show cursor position in status bar:
set ruler               
set title               
set wildmenu            
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2       
" show matching bracket for 0.2 seconds:
set matchtime=2         
" specially for htm:
set matchpairs+=<:>     
" map missed escape sequences (enables keypad keys):
set esckeys             
" case insensitive searching:
set ignorecase          
" but become case sensitive if you type uppercase characters:
set smartcase           
"set smartindent         
"set smarttab           
" change the way backslashes are used in search patterns:
set magic               
" Allow backspacing over everything in insert mode:
set bs=indent,eol,start 
" Visual representation of whitespace with unicode
"exec "set listchars=tab:\uBB\uBB,nbsp:~,trail:\uB7" 
"set list                
set relativenumber
set whichwrap+=<,>,[,]
set tabstop=4          
set shiftwidth=4        
"set expandtab        

set fileformat=unix
"set fileformats=unix,dos 
"set custom spell dictionary


" system settings
set lazyredraw      
set confirm         
set nobackup         
 " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines' 
set viminfo='20,\"500 
set hidden            
set history=50        
set mouse=v            
set verbose=0
set verbosefile=

" Folding = za to open close
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Backup dirs - keep in one place instead of leaving files scattered
set directory=~/.vim/tmp
set backupdir=~/.vim/backup

" Persistent undo
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000



if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return '~/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

""""""""""""""""""""""""""""""""" COLOUR SETTINGS  """""""""""""""""""""""""""""""""""""""""""""

" enable colors
syntax enable	
" highlight search (very useful!)
set hlsearch      
" search incremently (search while typing)
set incsearch     

if has('gui_running')
	
	set t_Co=16
	colorscheme desert
	"colorscheme solarized

	set background=dark
	" Highlight Line on current cursor AFTER colorscheme
	set cursorline							
	hi CursorLine  guibg=#404040
	" Popup code complete menu
	hi Pmenu guibg=#555555					
	" Popup menu selction line font color
	hi PmenuSel guifg=#000000				

	if has("gui_win32")
		set guifont=Consolas:h10:cANSI
	endif
else
	set t_Co=16
	colorscheme desert
endif




""""""""""""""""""""""""""" FILE SPECIFIC SETTINGSS """""""""""""""""""""""""""""""""""""""""
" Use of the filetype plugins, auto completion and indentation support
filetype plugin indent on
" Nerdcommenter needs this
filetype plugin on

" file type specific settings
if has("autocmd")
  " For debugging
  "set verbose=9

  " if bash is sh.
  let bash_is_sh=1

  " change to directory of current file automatically 
  " Causes issues with zip files, can get round that but then this runs when
  " nav files enclosed and gives error.  Just ignore error message
  autocmd BufEnter * lcd %:p:h

  " Iains File Specific setings.  Use setlocal as otherwise it affects all buffers 
  augroup mysettings
    autocmd BufEnter,BufRead *.xslt,*.xml setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
    autocmd BufEnter,BufRead *.html,*.xhtml setlocal omnifunc=htmlcomplete#CompleteTags tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
    autocmd BufEnter,BufRead *.css setlocal omnifunc=csscomplete#CompleteCSS tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
    autocmd BufEnter,BufRead *.js setlocal omnifunc=javascriptcomplete#CompleteJS tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	
	"Txt files
	autocmd BufEnter,BufRead *.txt  setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab textwidth=125 spell spelllang=en_gb
	
	"Vimwiki files
	autocmd BufEnter,BufRead *.wiki,*.md setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab 
	autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
   
    "C type files
    autocmd BufEnter,BufRead *.c,*.cpp,*.cs,*.java setlocal omnifunc=ccomplete#CompleteCpp tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab cinwords=if,else,for,while,try,except,finally,def,class
    
	" Icon fge type files
	autocmd BufEnter,BufRead *.fge,*.FGE setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab cinwords=FIELD,SUBPAGE

	" Icon ddd type files
	autocmd BufEnter,BufRead *.ddd setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab cinwords=
	
	" Python Settings - 2nd line trims trailing whitespace when write to file,3rd file permissions to +x
    autocmd BufEnter,BufRead *.py,*.PY setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab omnifunc=pythoncomplete#Complete cinwords=if,elif,else,for,while,try,except,finally,def,class
	autocmd BufWritePre *.py,*.PY  normal m`:%s/\s\+$//e ``
	" autocmd BufWritePost *.py,*.PY !chmod +x %

	" Perl - prob never use
    au BufReadPre,BufNewFile *.pl,*.pm setlocal formatoptions=croq shiftwidth=2 softtabstop=2 cinkeys='0{,0},!^F,o,O,e' " tags=./tags,tags,~/devel/tags,~/devel/C
	" autocmd BufWritePost *.pl,*.pm !chmod +x %

	" Shell Scripts
    autocmd BufEnter,BufRead *.sh setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
	" autocmd BufWritePost *.sh !chmod +x %

	" Treat files as zip files (so can navigate/edit without unzipping)
	autocmd BufReadCmd *.ods,*.rar,*.jar call zip#Browse(expand("<amatch>"))
  augroup END


  " Always jump to the last known cursor position. 
  " Don't do it when the position is invalid or when inside
  " an event handler (happens when dropping a file on gvim). 
  autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") | 
    \   exe "normal g`\"" | 
    \ endif 

endif 


""""""""""""""""""""""""""" PLUG IN SETTINGS  """""""""""""""""""""""""""""""""""""""""

" Plugin Custom CtrlP settings
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|flv|pdf|mp3|mp4|torrent|avi)$',
\}
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0


" delimitMate workaround for Python triple-quotes.
autocmd FileType python let b:delimitMate_nesting_quotes=['"', '''']

" Plugin Airline settings
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set laststatus=2

" Nerdcommmenter bug issue 134 workaround.  C files already with comments
let g:NERDLPlace='/*'
let g:NERDRPlace='*/'

" Gundo 
let g:gundo_prefer_python3 = 1
let g:gundo_width=90

" Location of VimWiki files, launch with ,ww
let g:vimwiki_ext2syntax = {'.md':'markdown','.markdown':'markdown','.mdown':'markdown'}
"let g:vimwiki_list = [{'path': '$HOME/Documents/Notes'}]
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext':'.md'}]
"
" Syntasic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1

" Save Screen Position
let g:screen_size_restore_pos = 1



""""""""""""""""""""""""""""""""""""" FUNCTIONS """""""""""""""""""""""""""""""""""""""""

" Damian Conway's Die Blinkënmatchen: highlight matches
function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>


""""""""""""""""""""""""""""""""""""" MAPPINGS """""""""""""""""""""""""""""""""""""""""
" paste mode toggle (needed when using autoindent/smartindent)
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" F3: Toggle list (display unprintable characters).
nnoremap <F3> :set list!<CR>

""""""Iains mappings
"let mapleader=","
let mapleader="\<Space>"

" Quicker Escape
" Use NOREmap perferable as otherwise pauses to see what next char is 
inoremap jj <esc>
"
"clear highlight after search
nnoremap <leader>/ :nohl<CR>
"cs is a nice stye comment too. ci inverts.
nnoremap <leader>ct :call NERDComment(0,"Toggle")<CR>
vnoremap <leader>ct :call NERDComment(0,"Toggle")<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>u :GundoToggle<CR>
"silver searcher to grep, defaults to curr dir
"nnoremap <leader>a :Ag 

" Navigation for splits/buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" This mappiong might not work as conflicts with terminals that have same mapping
nmap <C-PageDown> :bprev<CR>
nmap <C-PageUp> :bnext<CR>

" Easymotion to use Enter as use frequent;y
map <Enter> <Plug>(easymotion-bd-w)
map <leader><Enter> <Plug>(easymotion-bd-e)
" Enable in insert mode too C-o lets us run cmd from insert mode.
"imap <leader>f <C-o><om iPlug>(easymotion-bd-w)

"Other common so don't need to press shift
nnoremap <leader>6 ^
nnoremap <leader>4 $
nnoremap <leader>8 *
nnoremap <leader>g G

" Underline line 
nnoremap <leader>= yypVr=

" Use circluar list to cycle beffers for cliboard/vim copy/paste
nnoremap <Leader>s :let @a=@" \| let @"=@+ \| let @+=@a<CR>

" Whitespace before paste.  Note ^[ is escape
let @p='a p'


""""""""""""""""""""""""""""""""""""" OTHER  """""""""""""""""""""""""""""""""""""""""
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %



