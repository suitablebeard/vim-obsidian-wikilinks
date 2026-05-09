vim9script

# obsidian-wikilinks: adds wikilinks to vim similiar to Obsidian's
# Last Change: 09-May-2026
# Maintainer: suitablebeard
# License:

if exists('g:loaded_obsidian_wikilinks') 
    finish 
endif
g:loaded_obsidian_wikilinks = 1

def CreateWikilink(): string
    var col = col('.')

    # searches files using Vim's built-in 'find'
    var files = globpath('.', '**/*', 0, 1)

    var completion_items = files->mapnew((_, file) => {
        var filename = fnamemodify(file, ':t:r')
        var parentDir = fnamemodify(file, ':h:t')
        if parentDir == '.' || parentDir == ''
            parentDir = fnamemodify(getcwd(), ':t')
        endif

        var display_text = $"{parentDir}/{filename}"

        var item = {
        \   word: filename .. ']]',
        \   abbr: $"{display_text}",
        \ }

        return item
    })
    
    if !empty(completion_items)
        complete(col, completion_items)
    endif

    return ''
enddef

augroup obsidianWikilinks
    autocmd!
    autocmd FileType markdown {
        command! -nargs=0 -buffer ObsidianWikilink CreateWikilink()
        inoremap <buffer> <silent> [[ [[<cmd>ObsidianWikilink<CR>
    }
augroup END
