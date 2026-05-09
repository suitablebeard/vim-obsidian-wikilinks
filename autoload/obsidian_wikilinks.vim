vim9script

export def CreateWikilink(): string
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

