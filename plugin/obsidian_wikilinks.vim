" obsidian-wikilinks: adds wikilinks to vim similiar to Obsidian's
" Last Change: 11-May-2026
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

def NormalizePath(path: string): string
    return expand(simplify(fnameescape(path)))
enddef

# Directory to search for files (default is the current directory)
g:obsidian_wikilinks_default_dir = NormalizePath(get(g:, 'obsidian_wikilinks_default_dir', '.'))
g:obsidian_wikilinks_newfile_dir = NormalizePath(get(g:, 'obsidian_wikilinks_newfile_dir', g:obsidian_wikilinks_default_dir .. '/+'))

if !hasmapto('<Plug>ObsidianWikilinkOpen')
    nmap <unique> <leader>ow <Plug>ObsidianWikilinkOpen 
endif

if !hasmapto('<Plug>ObsidianWikilinkCreate')
    vmap <unique> <leader>os <Plug>ObsidianWikilinkCreate
endif

import autoload '../autoload/obsidian_wikilinks.vim' as wikilinks

augroup obsidianWikilinksConfig
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianWikilinkOpen wikilinks.OpenWikilink()
        nnoremap <buffer> <silent> <Plug>ObsidianWikilinkOpen <scriptcmd>ObsidianWikilinkOpen<CR>

        command! -nargs=0 -buffer ObsidianWikilinkCreate wikilinks.CreateWikilink()
        noremap <buffer> <silent> <Plug>ObsidianWikilinkCreate <scriptcmd>ObsidianWikilinkCreate<CR>

        inoremap <buffer> <silent> [[ <scriptcmd>wikilinks.InsertWikilink()<CR>
    }
augroup END

