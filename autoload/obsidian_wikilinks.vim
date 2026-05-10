vim9script

export def CreateWikilink(): string
    var col = col('.')

    # searches files using Vim's built-in 'find'
    var files = globpath(g:obsidian_wikilinks_default, '**/*', 0, 1)
        ->filter((_, path) => !isdirectory(path))

    var completion_items = files->mapnew((_, file) => {
        var filename = fnamemodify(file, ':t:r')
        var fileextension = fnamemodify(file, ':e')
        fileextension = fileextension != '' ? $'.{fileextension}' : ''
        var parentDir = fnamemodify(file, ':h:t')
        parentDir = (parentDir == '.' || parentDir == '') ? fnamemodify(getcwd(), ':t') : parentDir

        var display_text = $"{parentDir}/{filename}{fileextension}"

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

