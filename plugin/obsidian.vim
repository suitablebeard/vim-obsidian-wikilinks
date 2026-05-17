" obsidian: adds wikilinks to vim similiar to Obsidian's
" Last Change: 11-May-2026
" Maintainer: suitablebeard
" License:

if !has('vim9script') ||  v:version < 900
    finish
endif

vim9script

if exists('g:loaded_obsidian')
    finish 
endif
g:loaded_obsidian = 1

def NormalizePath(path: string): string
    return expand(simplify(fnameescape(path)))
enddef

# Directory to search for files (default is the current directory)
g:obsidian_default_dir = NormalizePath(get(g:, 'obsidian_default_dir', '.'))
g:obsidian_newfile_dir = NormalizePath(get(g:, 'obsidian_newfile_dir', g:obsidian_default_dir .. '/+'))

if !hasmapto('<Plug>ObsidianOpenWikilink')
    nmap <unique> <leader>ow <Plug>ObsidianOpenWikilink 
endif

if !hasmapto('<Plug>ObsidianCreateWikilink')
    vmap <unique> <leader>os <Plug>ObsidianCreateWikilink
endif

import autoload '../autoload/obsidian.vim' as obsidian

augroup obsidianWikilinksConfig
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianOpenWikilink obsidian.OpenWikilink()
        nnoremap <buffer> <silent> <Plug>ObsidianOpenWikilink <scriptcmd>ObsidianOpenWikilink<CR>

        command! -nargs=0 -buffer ObsidianCreateWikilink obsidian.CreateWikilink()
        noremap <buffer> <silent> <Plug>ObsidianCreateWikilink <scriptcmd>ObsidianCreateWikilink<CR>

        inoremap <buffer> <silent> [[ <scriptcmd>obsidian.InsertWikilink()<CR>
    }
augroup END

