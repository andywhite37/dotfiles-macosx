" awhite neovim init.vim
"-------------------------------------------------------------------------------- 
" Vim Plug
"-------------------------------------------------------------------------------- 

call plug#begin()

" General stuff
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'

" Color schemes
"Plug 'crusoexia/vim-monokai'
Plug 'patstockwell/vim-monokai-tasty'
"Plug 'sainnhe/sonokai'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Completion/language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status/tag line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Buffer closer
Plug 'moll/vim-bbye'

" Neomux
" Didn't really like this - plain old tmux is better
"Plug 'nikvdp/neomux'

" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'

" vim-buffergator
Plug 'jeetsukumaran/vim-buffergator'

call plug#end()

"-------------------------------------------------------------------------------- 
" NERDTree
"-------------------------------------------------------------------------------- 

" Open NERDTree when starting vim
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Synchronize NERDTree with open buffer (i.e. find the file in NERDTree)
nnoremap <silent> <leader>s :NERDTreeFind<cr>

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
  inoremap <silent><expr> <c-@> coc#refresh()
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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
map  <C-Space>   <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
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

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" awhite Coc additions

" coc-prettier
command! -nargs=0 Prettier   :CocCommand prettier.formatFile
vmap              <leader>f  <Plug>(coc-format-selection)
nmap              <leader>f  <Plug>(coc-format-selection)

" coc-eslint

" coc-tsserver
"
" coc-jest
command!          JestInit    :call CocAction('runCommand', 'jest.init')
command! -nargs=0 Jest        :call CocAction('runCommand', 'jest.projectTest')
command! -nargs=0 JestFile    :call CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap          <leader>jf  :call CocAction('runCommand', 'jest.fileTest')<CR>
command! -nargs=0 JestTest    :call CocAction('runCommand', 'jest.singleTest')
nnoremap          <leader>jt  :call CocAction('runCommand', 'jest.singleTest')<CR>

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

nnoremap <silent> <Leader>B :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
"nnoremap <silent> <Leader>f :Ag<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>c :Commands<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

"-------------------------------------------------------------------------------- 
" vim-bbye
"-------------------------------------------------------------------------------- 

" Close current buffer
nnoremap <Leader>q :Bdelete<CR>

" Close all buffers
"nnoremap <Leader>Q :bufdo Bdelete<CR>

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

" Font
set guifont=Fira\ Code:h11

" Mouse support
set mouse=a

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
