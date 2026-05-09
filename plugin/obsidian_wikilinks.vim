vim9script

# obsidian-wikilinks: adds wikilinks to vim similiar to Obsidian's
# Last Change: 09-May-2026
# Maintainer: suitablebeard
# License:

if exists('g:loaded_obsidian_wikilinks')
    finish 
endif
g:loaded_obsidian_wikilinks = 1

import autoload '../autoload/obsidian_wikilinks.vim' as wikilinks

augroup obsidianWikilinksConfig
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianWikilink wikilinks.CreateWikilink()
        inoremap <buffer> <silent> [[ [[<scriptcmd>ObsidianWikilink<CR>
    }
augroup END
