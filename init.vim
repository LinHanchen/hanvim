scriptencoding utf-8

" Vim-Plug [[[1
let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif
" ]]]

" 插件管理[[[1
call plug#begin('~/.local/share/nvim/plugged')
Plug 'keenwon/vimcdoc'
" themes
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'icymind/NeoSolarized'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" View and search LSP symbols, tags
Plug 'liuchengxu/vista.vim'

" Async run command
Plug 'skywind3000/asyncrun.vim'
call plug#end()
"]]]
" set 相关[[[1
" 一般设置[[[2
set nobackup " 不生成备份文件即~文件
set winminheight=0
set switchbuf+=usetab,newtab

" 设置python
if has("nvim")
    let g:python3_host_prog = '/usr/bin/python3'
endif

syntax on "语法高亮
if !has("nvim")
    set nocompatible
endif
set number "显示行号
set relativenumber
set incsearch "输入搜索命令时，显示目前输入的模式的匹配位置
set hlsearch "高亮搜索结果
set ignorecase "搜索忽略大小写
set smartcase " 搜索包含大写时关闭ignorecase,只有开启ignorecase时才生效
set smarttab "根据文件中其他地方的缩进空格个数来确定一个tab是多少个空格
set expandtab "将tab扩展成空格
set visualbell t_vb= "禁止出错发声和闪屏
set ttyfast "表明使用的是快速终端连接,若为远程连接或慢速连接则建议关闭

" 不要包含标准错误，但允许 vim 初始化其默认值
"autocmd VimEnter * set shellredir=> " 完成所有初始化步骤后执行。用于把过滤命令输出存到临时文件的字符串，将其缺省设为 '>'

if has('nvim')
    set shada='100,:10000,<50,s10,h,!
else
    set viminfo='100,:10000,<50,s10,h,! "配置viminfo文件保存内容
endif
set history=10000 " “：”命令的历史和最近的搜索模式的历史会被记住，最大值为10000
set wildmenu "增强命令行补全
"set delcombine "如果编辑 Unicode 时打开本选项，退格和普通模式的 'x' 删除单个组合用字符。即组合字符一个个地删除
set laststatus=2 "本选项的值影响最后一个窗口何时有状态行：0-永不，1-至少有2个窗口时，2-总是
" ------------------ check here
"set wildmode=longest:full,full " 用 'widechar' 指定的字符所用的补全模式。
if has("unix")
    set ambiwidth=single
else
set ambiwidth=double "使用 US-ASCII字符两倍的宽度处理东亚二义性宽度字符类，使用cjk字体的应该设为double, 处理unicode编码格式有效
endif

set shiftround " 缩进取整到 'shiftwidth' 的倍数。应用于 > 和 < 命令。
"set diffopt+=vertical,context:3,foldcolumn:0 "比较模式的设置选项
set fileencodings=ucs-bom,utf-8,gb18030,cp936,latin1 "字符编码列表，开始编辑已存在的文件时，参考此选项
set fileformats=unix,dos,mac "给出换行符的格式
set formatoptions=qn2mB1 "描述自动排版如何进行的字母序列，参数见fo-table

try
  "Vim 7.4
  set formatoptions+=j "在合适的场合，连接行时删除注释前导符。
catch /.*/
endtry

"set nojoinspaces "使用连接命令时取消在 '.'、'?' 和 '!' 之后插入两个空格。
set virtualedit=block "允许可视块模式的虚拟编辑,虚拟编辑意味光标可定位在没有实际字符的地方
set nostartofline "使用gg、G、C-D等移动操作符时，光标尽可能保持在同一列上
if has("nvim")
    set guioptions=aci
else
    set guioptions=acit "描述GUI应该使用的部件和选项，参数详情见:h guioptions
endif
"set isfname-== "文件名和路径名由此选项指定的字符组成，很多时候 = 表示赋值，所以没有必要
set nolinebreak "在屏幕上可以显示的最后一个字符上回绕长行
set nowrapscan "搜索在文件末不回绕回文件首，即n跳转导底部即停止
set scrolloff=5 "光标上下两侧最少保留的屏幕行数
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,slash,unix,resize "选择session保存的信息
set shiftwidth=4 "缩进每一步使用的空白数目
set winaltkeys=no "不用 ALT 键访问菜单。ALT 键组合可以被映射，但不会自动处理
set noequalalways "所有窗口在分割或关闭某窗口时自动使用相同的尺寸
set listchars=eol:$,tab:>-,nbsp:~ "'list'模式和:list命令使用的字符串,行尾显示$,制表符显示>-,不可间断的空格显示~
set display=lastline " 窗口末行显示尽量多的内容，无法完全显示则会在末行末尾放上"@@@"指示该行还有剩余内容
set completeopt+=longest,menuone "插入模式中，只插入匹配的最长公共文本
set completeopt-=preview " 不显示补全的额外信息
"set maxcombine=4 "最大支持的显示用组合字符的数目
set cedit=<C-Y> "用于命令行模式打开命令行窗口的键,默认<C-F>
set whichwrap=b,s,[,] "使指定的左右移动光标的键在行首或行尾可以移动到前一行或后一行，设定为<BS><Space><Left><Right>
"set tags+=./../tags,./../../tags,./../../../tags "标签命令所用的多个文件名，空格或逗号分隔。我也不知道在讲啥。。

try
  "形成配对的字符，可以使用%命令跳转的
  set matchpairs=(:),{:},[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”,':',":"
catch /^Vim\%((\a\+)\)\=:E474/
endtry
"]]]
" 路径相关[[[2
"定义一个全局变量vimfiles,保存第一个运行时文件所用目录
let g:vimfiles = split(&runtimepath, ',')[0]
"临时文件目录
if exists('$VIMTMP')
    let g:mytmpdir = $VIMTMP
else
    let g:mytmpdir = expand("~/tmpfs")
endif
"undo文件位置
let g:undodir = g:mytmpdir . "/.vimundo"
"错误文件位置
let &errorfile = g:mytmpdir . "/.error"
" 命令行映射 ctrl+t = ~/tmpfs/
" cmap <C-T> ~/tmpfs/
" cron 的目录不要备份. cron:计划任务。在Linux中，我们经常用到 cron 服务器来
" 完成这项工作。cron服务器可以根据配置文件约定的时间来执行特定的作务。
set backupskip+=/etc/cron.*/*
set backupskip+=*/HTTPSEverywhereUserRules/*
set backupdir=.,/var/tmp,/tmp
" ]]]
" 语言相关[[[2
"设置状态行 can be replaced
" if $LANGUAGE =~ '^zh' || ($LANGUAGE == '' && v:lang =~ '^zh')
"   " 缓冲区号 文件名 行数 修改 帮助 只读 代码检测结果 编码 换行符 BOM ======= 字符编码 位置 百分比位置
"   set statusline=%n\ %<%f\ %L行\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r\ %{LinterStatus()}%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%{&diff?'[diff]':''}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P
" else
"   set statusline=%n\ %<%f\ %LL\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r\ %{LinterStatus()}%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%{&diff?'[diff]':''}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P
" endif
" ]]]
" 图形与终端[[[2
" 依旧很多不明所以的设置
if has("termguicolors")
        " 256 colors
        set termguicolors
endif
"set background=dark
"let g:solarized_termcolors=256
"let g:molokai_original = 1
"colorscheme NeoSolarized
"colorscheme monokai
colorscheme onedark
"colorscheme gruvbox
"let g:rehash256 = 1
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

set cursorline "高亮当前行


" delete Setting [[[3
"if has("gui_running")
"  set mousemodel=popup "鼠标右键弹出菜单
"  set columns=88 "设置屏幕列数
"  set lines=38 "设置屏幕行数
"  set cursorline "高亮当前行
"elseif has("unix")
"  set ambiwidth=single
"  "防止退出时终端乱码
"  "这里两者都需要。只前者标题会重复，只后者会乱码
"  set t_fs=^[(B^G "设置窗口标题
"  set t_IE=^[(B^G "结束设置图标文本
"  if &term =~ '256color\|nvim'
"    set cursorline
"  else
"    " 在Linux文本终端下非插入模式显示块状光标
"    if &term == \"linux" || &term == \"fbterm"
"      set t_ve+=^[[?6c
"      autocmd InsertEnter * set t_ve-=^[[?6c
"      autocmd InsertLeave * set t_ve+=^[[?6c
"    endif
"    if &term == \"fbterm"
"      set cursorline
"    elseif $TERMCAP =~ 'Co#256'
"      set t_Co=256 "颜色数目
"      set cursorline
"    endif
"  endif
"endif

"" bracketed paste mode support for tmux
"if &term =~ '^screen\|^tmux' && exists('&t_BE')
"  let &t_BE = \"\033[?2004h" "打开括号内粘贴模式
"  let &t_BD = \"\033[?2004l" "关闭括号内粘贴模式
"  " t_PS and t_PE are key code options and they are special
"  exec \"set t_PS=" . \"\033[200~"
"  exec \"set t_PE=" . \"\033[201~"
"endif
" 不同的vim版本
"if has("conceal")
"  " 'i' is for neosnippet
"  set concealcursor=nci "设置也能隐藏光标所在行的文本的模式
"  set conceallevel=2 \"指定如何显示使用"conceal"语法属性，2为完全不显示隐藏文本，除非它定义了自己的替换字符
"endif
"]]]
if has("persistent_undo")
  let &undodir=g:undodir
  set undofile
endif
unlet g:undodir

" Function [[[2
" add command mapping
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" ]]]
"]]]
" map 相关[[[1
" normal setting [[[2
let mapleader=" "
" ctrl-s 保存文件
"nnoremap <silent> <C-s> :update<CR>
"inoremap <silent> <C-s> <ESC>:update<CR>
"vnoremap <silent> <C-S> <ESC>:update<CR>
" ctrl-d 关闭窗口
" nmap <C-D> <C-W>q
" 强制保存只读文件
command! -nargs=0 Sw w !sudo tee % > null
" 终端模式下<ESC>退出插入模式
tnoremap <ESC> <C-\><C-n>
" To use ALT+{h, j, k, l} to navigate windows from any mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"]]]
" coc map [[[2
" format code
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)
" code jump
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gl <Plug>(coc-declaration)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
" 
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" ALE [[[2
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" ]]]
" Defx [[[2
nmap <silent> <Leader>e :Defx <cr>
function! s:defx_mappings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ defx#is_directory() ?
    \ defx#do_action('open_or_close_tree') :
    \ defx#do_action('drop',)
    nnoremap <silent><buffer> h :call defx#call_action('cd', ['..'])<CR>:call defx#call_action('change_vim_cwd')<CR>
    nnoremap <silent><buffer> i :call defx#call_action('cd', defx#get_candidate()['action__path'])<CR>:call defx#call_action('change_vim_cwd')<CR>
    nnoremap <silent><buffer><expr> s defx#async_action('drop', 'split')
    nnoremap <silent><buffer><expr> v defx#async_action('drop', 'vsplit')
    nnoremap <silent><buffer><expr> t defx#async_action('drop', 'tabe')
    nnoremap <silent><buffer><expr> o defx#async_action('open_tree')
    nnoremap <silent><buffer><expr> O defx#async_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> C defx#async_action('copy')
    nnoremap <silent><buffer><expr> P defx#async_action('paste')
    nnoremap <silent><buffer><expr> M defx#async_action('rename')
    nnoremap <silent><buffer><expr> D defx#async_action('remove_trash')
    nnoremap <silent><buffer><expr> A defx#async_action('new_multiple_files')
    nnoremap <silent><buffer><expr> . defx#async_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <Space> defx#async_action('toggle_select')
    nnoremap <silent><buffer><expr> R defx#async_action('redraw')
endfunction
" ]]]
" Vista.vim [[[2
nmap <silent> <Leader>l :Vista!!<cr>
" ]]]
" Asyncrun [[[2
fun! Asyncrun_cpp()
    nnoremap <buffer><silent> <F4> :AsyncRun -cwd=<root>/build cmake .. && make <cr>
endfun
autocmd FileType cpp,cxx,h,hpp,c :call Asyncrun_cpp()
" ]]]
" ]]]
" 插件设置[[[1
" coc.vim[[[2
" required extensions
call coc#add_extension(
            \'coc-json',
            \'coc-yank',
            \'coc-translator',
            \'coc-pairs',
            \'coc-marketplace',
            \'coc-snippets',
            \'coc-highlight',
            \'coc-python'
            \)
" Correct JSON comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" translator text color
hi CocTranslatorExplain ctermfg=145 guifg=#ABB2BF

" ]]]
" airline[[[2
let g:airline_powerline_fonts = 1
let g:airline_theme = "onedark"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#vista#enabled = 0
" ]]]
" ALE [[[2
"let g:ale_sign_error = "✖"
"let g:ale_sign_warning = "⚠"
let g:ale_sign_error = "❌"
let g:ale_sign_warning = "⚠️"
"highlight ALEErrorSign cterm=bold ctermfg=197 gui=bold,italic guifg=#F92772
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s [%linter%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
            \ 'go': ['gopls'],
            \ 'cpp': ['ccls', 'clang'],
            \}
let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['Debug','.']
"let g:ale_open_list = 1
" ]]]
" Defx [[[2
call defx#custom#option('_',{
    \ 'columns'   : 'git:indent:icons:filename:type:size',
    \ 'split'     : 'vertical',
    \ 'direction' : 'topleft',
    \ 'winwidth'  : 30,
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '[defx]',
    \ 'auto_cd': 0,
    \ 'toggle': 1,
    \ 'resume': 1,
    \ })
autocmd FileType defx call s:defx_mappings()

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })


"let g:defx_icons_enable_syntax_highlight = 0
" ]]]
" indentLine [[[2
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_char = '│'
" ]]]
" Vista.vim [[[2
"
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

let g:vista_highlight_whole_line = 1

let g:vista_default_executive = 'coc'

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" ]]]
" Asyncrun [[[2
let g:asyncrun_open = 12
let g:asyncrun_rootmarks = ['.git', '.ccls', 'compile_commands.json', '.root']
" ]]]
" ]]]
" vim:fdm=marker:fmr=[[[,]]]
