" This activates pathogen.vim which helps manage plugin bundles in 
" the bundles/ directory.
call pathogen#infect()
syntax on
filetype plugin indent on

let mapleader=" "
let maplocalleader=","

" This changes often, still searching for the perfect color scheme.
colorscheme darkspectrum

" I like the cursorline.
set cursorline

" I forget what this is for.
set nocompatible

" Line numbers.
set number

" Tabs and such.
set expandtab
set tabstop=8
set softtabstop=4
set shiftwidth=4

" These things often piss me off.
set smartindent
set autoindent

set comments=s1:/**,mb:\ *,ex:\ */,://,b:#,:%,:XCOMM,n:>,fb:-
set formatoptions=tcroq

" This causes the current search to be highlighted throughout the file.
set hlsearch

" Omni completion
set ofu=syntaxcomplete#Complete

function! DoPrettyXML()
    " save the filetype so we can restore it later
    let l:origft = &ft
    set ft=
    " delete the xml header if it exists. This will
    " permit us to surround the document with fake tags
    " without creating invalid xml.
    1s/<?xml .*?>//e
    " insert fake tags around the entire document.
    " This will permit us to pretty-format excerpts of
    " XML that may contain multiple top-level elements.
    0put ='<PrettyXML>'
    $put ='</PrettyXML>'
    silent %!xmllint --format -
    " xmllint will insert an <?xml?> header. it's easy enough to delete
    " if you don't want it.
    " delete the fake tags
    2d
    $d
    " restore the 'normal' indentation, which is one extra level
    " too deep due to the extra tags we wrapped around the document.
    silent %<
    " back to home
    1
    " restore the filetype
    exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = $HOME . "/.vim/lib/vimclojure-nailgun-client/ng"

