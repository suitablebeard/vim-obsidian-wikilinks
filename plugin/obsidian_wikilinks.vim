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

# Directory to search for files (default is the current directory)
g:obsidian_wikilinks_default_directory = get(g:, 'obsidian_wikilinks_default_directory', '.')

import autoload '../autoload/obsidian_wikilinks.vim' as wikilinks

augroup obsidianWikilinksConfig
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianWikilink wikilinks.CreateWikilink()
        inoremap <buffer> <silent> [[ [[<scriptcmd>ObsidianWikilink<CR>
        command! -nargs=0 -buffer ObsidianWikilinkOpen wikilinks.OpenWikilink()
        nnoremap <buffer> <silent> <leader>ow <scriptcmd>ObsidianWikilinkOpen<CR>
    }
augroup END

