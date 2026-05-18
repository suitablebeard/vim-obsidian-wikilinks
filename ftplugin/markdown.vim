" obsidian: adds wikilinks to vim similiar to Obsidian's
" Last Change: 17-May-2026
" Maintainer: suitablebeard
" License:

if !has('vim9script') ||  v:version < 900
    finish
endif

vim9script

if exists('b:loaded_obsidian')
    finish
endif
b:loaded_obsidian = 1

import '../utils/utils.vim'
import autoload '../autoload/obsidian.vim'

# Directory to search for files (default is the current directory)
g:obsidian_default_dir = utils.NormalizePath(get(g:, 'obsidian_default_dir', '.'))
g:obsidian_newfile_dir = utils.NormalizePath(get(g:, 'obsidian_newfile_dir', g:obsidian_default_dir .. '/+'))

if !hasmapto('<Plug>ObsidianOpenWikilink')
    nmap <unique> <leader>ow <Plug>ObsidianOpenWikilink 
endif

if !hasmapto('<Plug>ObsidianCreateWikilink')
    vmap <unique> <leader>os <Plug>ObsidianCreateWikilink
endif

command! -nargs=0 -buffer ObsidianOpenWikilink obsidian#OpenWikilink()
nnoremap <buffer> <silent> <Plug>ObsidianOpenWikilink <scriptcmd>ObsidianOpenWikilink<CR>

command! -nargs=0 -buffer ObsidianCreateWikilink obsidian#CreateWikilink()
noremap <buffer> <silent> <Plug>ObsidianCreateWikilink <scriptcmd>ObsidianCreateWikilink<CR>

inoremap <buffer> <silent> [[ <scriptcmd>obsidian.InsertWikilink()<CR>

