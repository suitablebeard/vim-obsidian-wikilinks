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

export def OpenWikilink(): void
    var currentLine = getline('.')
    var cursor_pos = col('.') - 1

    var wikilink: string = GetWikilinkUnderCursor(currentLine, cursor_pos)
    if wikilink ==# ''
        echom 'Your cursor must be inside a wikilink to open the file.'
        return
    endif

    echom wikilink
enddef

export def GetWikilinkUnderCursor(str: string, cursor_pos: number): string
    var cursor_char: string = str[cursor_pos]
    var openBracketsIndex: number
    var closeBracketsIndex: number

    # Searches backwards for '[[' from the cursor
    for i in range(cursor_pos, 0, -1)
        var char: string = str[i]
        if char !~# '\[\|\]' | continue | endif
        if char ==# ']' | return '' | endif

        var doubleBrackets = GetDoubleBrackets(char, str, i)
        openBracketsIndex = doubleBrackets != -1 ? doubleBrackets : v:null
        break
    endfor

    # Searches forwards for ']]' from the cursor
    for i in range(cursor_pos, strchars(str) - 1, 1)
        var char: string = str[i]
        if char !~# '\[\|\]' | continue | endif
        if char ==# '[' | return '' | endif

        var doubleBrackets = GetDoubleBrackets(char, str, i)
        closeBracketsIndex = doubleBrackets != -1 ? doubleBrackets : v:null
        break
    endfor

    var wikilink = (openBracketsIndex >= 0 && closeBracketsIndex > 0) ? str[openBracketsIndex : closeBracketsIndex + 1] : ''

    return wikilink
enddef

def GetDoubleBrackets(bracket: string, str: string, position: number): number
    var nextBracket = str[position + 1] ==# bracket
    var previousBracket = str[position - 1] ==# bracket
    var result: number = nextBracket ? position : previousBracket ? position - 1 : -1
    return result
enddef
