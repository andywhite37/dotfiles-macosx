" awhite neovim init.vim

" Map leader to <space>
" Do this first because it only affects mappings that are initialized after it
nnoremap <Space> <Nop>
let mapleader=" "

"-------------------------------------------------------------------------------- 
" Vim Plug
"-------------------------------------------------------------------------------- 

call plug#begin()

" General stuff
Plug 'tpope/vim-sensible'

" Commenting
Plug 'preservim/nerdcommenter'

" Color schemes
"Plug 'crusoexia/vim-monokai'
Plug 'patstockwell/vim-monokai-tasty'
"Plug 'sainnhe/sonokai'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Unicode
Plug 'arthurxavierx/vim-unicoder'

" Completion/language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status/tag line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Buffer closer/deleter
Plug 'moll/vim-bbye'

" Neomux
" Didn't really like this - plain old tmux is better
"Plug 'nikvdp/neomux'

" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

" vim-buffergator
" Disabling because it's causing the left-most pane to keep expanding when opening and closing.
" The fzf :Buffers seems to accomplish the same thing as this and is arguably more usable.
"Plug 'jeetsukumaran/vim-buffergator'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'knsh14/vim-github-link'

" Markdown preview (in the browser)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" File nav
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Indent guides
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

"-------------------------------------------------------------------------------- 
" NERDTree
"-------------------------------------------------------------------------------- 

" Show hidden files
let NERDTreeShowHidden = 1

" UI
let g:NERDTreeWinSize=50

" Open NERDTree when starting vim and put the cursor in the other window
"autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    "\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Toggle NERDTree
nnoremap <silent> <leader>nt :NERDTreeToggle<cr>

" Synchronize NERDTree with open buffer (i.e. find the file in NERDTree)
nnoremap <silent> <leader>nf :NERDTreeFind<cr>

"-------------------------------------------------------------------------------- 
" CoC
" Mostly copied from CoC README
"-------------------------------------------------------------------------------- 

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@>     coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Find references
nmap <leader>fr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a   <Plug>(coc-codeaction-selected)
nmap <leader>a   <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" These are operator mappings (which are entered after an initial movement). I haven't figured out
" what these are for yet...
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Format buffer
command! -nargs=0  Format :call CocAction('format')

" Fold buffer
command! -nargs=?  Fold   :call CocAction('fold', <f-args>)

" Organize imports
command! -nargs=0  OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
nmap               <leader>o      :OrganizeImports<cr>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" These are fzf-like searchable lists of CoC-related things

" Show all diagnostics.
nnoremap <silent><nowait> <leader>cd  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>

" awhite CoC additions

" coc-prettier
command! -nargs=0  Prettier   :CocCommand prettier.formatFile

" coc-eslint

" coc-tsserver

" coc-jest
command!           JestInit    :call CocAction('runCommand', 'jest.init')
command! -nargs=0  Jest        :call CocAction('runCommand', 'jest.projectTest')
command! -nargs=0  JestFile    :call CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap           <leader>jf  :call CocAction('runCommand', 'jest.fileTest')<CR>
command! -nargs=0  JestTest    :call CocAction('runCommand', 'jest.singleTest')
nnoremap           <leader>jt  :call CocAction('runCommand', 'jest.singleTest')<CR>

" coc-json

" coc-html

" coc-css

"-------------------------------------------------------------------------------- 
" Airline
"-------------------------------------------------------------------------------- 

let g:airline_powerline_fonts = 1

" Tab line
let g:airline#extensions#tabline#enabled = 1

" CoC integration
let g:airline#extensions#coc#enabled = 1

" Monokai tasty
let g:airline_theme='monokai_tasty'

"-------------------------------------------------------------------------------- 
" fzf
"-------------------------------------------------------------------------------- 

" Buffer search and selection
nnoremap <silent>  <leader>fb   :Buffers<CR>

" File path search and selection
"nnoremap <silent>  <C-p>       :Files<CR>
nnoremap <silent>  <leader>ff      :Files<CR>

" File contents search and navigation
" Ripgrep seems to be the standard now (compared to Ack and Ag)
"nnoremap <silent>  <leader>fs   :Ag<CR>
" Rg default command (from fzf)
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, s:p(), <bang>0)
" Rg command that ignores file paths in match
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <silent>  <leader>fs   :Rg<CR>

" Buffer content search and navigation (search current buffer and go to line)
nnoremap <silent>  <leader>fl   :BLines<CR>

" Mark search and navigation
nnoremap <silent>  <leader>f'   :Marks<CR>

" Git commit/log search
nnoremap <silent>  <leader>fg   :Commits<CR>

" Vim recent command search
nnoremap <silent>  <leader>fc   :Commands<CR>

" Vim recent help tag search
nnoremap <silent>  <leader>ft   :Helptags<CR>

" Recent file/buffer history
nnoremap <silent>  <leader>fh  :History<CR>

" Recent vim command history (:)
nnoremap <silent>  <leader>f:  :History:<CR>

" Recent search history (/)
nnoremap <silent>  <leader>f/  :History/<CR>

"-------------------------------------------------------------------------------- 
" vim-bbye
"-------------------------------------------------------------------------------- 

" Close current buffer
nnoremap <leader>q :Bdelete<CR>
nnoremap <leader>qa :bufdo Bdelete<CR>

" Close all buffers
" This seems to struggle with non-text buffers like NERDTree, quick fix, etc.,
" so avoid using it. Could probably tweak this to only close text buffers?
"nnoremap <leader>Q :bufdo Bdelete<CR>

"-------------------------------------------------------------------------------- 
" Other custom configs
"-------------------------------------------------------------------------------- 

" Colors
"colorscheme monokai
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty
"let g:sonokai_style = 'atlantis'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai

" Color customizations
set termguicolors
"hi CursorLine cterm=bold ctermfg=235 ctermbg=148 gui=bold guifg=#eeeeee guibg=#193300
hi CursorLine ctermbg=148 guibg=#193300
hi CocWarningHighlight gui=undercurl term=undercurl cterm=undercurl ctermfg=11 guifg=yellow
hi CocErrorHighlight gui=undercurl term=undercurl cterm=undercurl ctermfg=257 guifg=red
" undercurl and guisp not currently working in tmux/nvim - probably terminal issues (?)
"hi CocWarningHighlight gui=undercurl term=undercurl cterm=undercurl guisp=yellow
"hi CocErrorHighlight gui=undercurl term=undercurl cterm=undercurl guisp=red

" Font
" Install on mac, set as terminal font for nvim:
" brew tap homebrew/cask-fonts
" brew install --cask font-hack-nerd-font
" brew install font-fira-code-nerd-font
set guifont=FiraCode\ Nerd\ Font:h11

" Mouse support
set mouse=a

" Arcane incantation to make the cursor blink
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" General settings
noswapfile
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set ignorecase
set smartcase
set incsearch
set number
set relativenumber

" Don't continue comments on the next line
"set formatoptions-=cro
"autocmd FileType * set fo-=c fo-=r fo-=o

" Clipboard stuff - not sure if this is working yet within iTerm2+tmux+nvim
set clipboard+=unnamedplus

" Use Ctrl-h/j/k/l for window navigation
" These are now handled by vim-tmux-navigator
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Show the cursor line in the active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Disable cursor line while in insert mode
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
augroup END
