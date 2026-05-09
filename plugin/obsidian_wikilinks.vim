" obsidian-wikilinks: adds wikilinks to vim similiar to Obsidian's
" Last Change: 09-May-2026
" Maintainer: suitablebeard
" License:

if !has('vim9script') ||  v:version < 900
    finish
endif

vim9script

if exists('g:loaded_obsidian_wikilinks')
    finish 
endif
g:loaded_obsidian_wikilinks = 1

# Default fault directory to search for files
g:obsidian_wikilinks_default = exists('g:obsidian_wikilinks_default') ? g:obsidian_wikilinks_default : '.'

import autoload '../autoload/obsidian_wikilinks.vim' as wikilinks

augroup obsidianWikilinksConfig
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianWikilink wikilinks.CreateWikilink()
        inoremap <buffer> <silent> [[ [[<scriptcmd>ObsidianWikilink<CR>
    }
augroup END
