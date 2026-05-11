vim9script

export def CreateWikilink(): string
    InsertStartingBrackets()

    # searches files using Vim's built-in 'find'
    var files = globpath(g:obsidian_wikilinks_default_dir, '**/*', 0, 1)
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
        complete(col('.'), completion_items)
    endif

    return ''
enddef

def InsertStartingBrackets(): void
    var line = getline('.')
    var col_num = col('.')
    var new_line = line->strpart(0, col_num - 1) .. "[[" .. line->strpart(col_num - 1)
    setline('.', new_line)
    var new_col = col_num + 2
    cursor(line('.'), new_col)
enddef


export def OpenWikilink(): void
    var currentLine = getline('.')
    var cursorPos = col('.') - 1
    var wikilink: string = GetWikilinkUnderCursor(currentLine, cursorPos)
    if wikilink ==# ''
        echom 'Your cursor must be inside a wikilink to open the file.'
        return
    endif

    var filename = wikilink->matchstr('\[\[\zs.\{-}\ze\]\]')->fnameescape()
    var files = globpath(g:obsidian_wikilinks_default_dir, $'**/*{filename}*', 0, 1)
        ->filter((_, path) => !isdirectory(path))

    var numOfFiles = len(files)
    if numOfFiles == 0 
        var filePath = $'{g:obsidian_wikilinks_default_dir}/+/{filename}.md'
        execute $'edit {fnameescape(simplify(filePath))}' 
    endif
    if numOfFiles == 1 | execute $'edit {files[0]}' | endif
    if numOfFiles >= 2
        var qfItems = files->map((_, filePath) => ({
                filename: fnamemodify(filePath, ':p:~'),
                text: fnamemodify(filePath, ':t'),
                lnum: 1,
                col: 1
            }))

        var qflistOpts = {
            items: qfItems,
        }

        setqflist([], 'r', qflistOpts)
        copen
    endif
enddef

export def GetWikilinkUnderCursor(str: string, cursorPos: number): string
    if strchars(getline('.')) == 0 | return '' | endif

    var cursorChar = str[cursorPos]
    var openBracketsIndex: number
    var closeBracketsIndex: number

    # Searches backwards for '[[' from the cursor
    var backwardsStartPos = (cursorChar ==# ']') ? cursorPos - 2 : cursorPos
    for i in range(backwardsStartPos, 0, -1)
        var char: string = str[i]
        if char !~# '\[\|\]' | continue | endif
        if char ==# ']' | return '' | endif

        var doubleBrackets = GetDoubleBrackets(char, str, i)
        openBracketsIndex = doubleBrackets != -1 ? doubleBrackets : -1
        if openBracketsIndex != -1 | break | endif
    endfor

    # Searches forwards for ']]' from the cursor
    var forwardStarPos = (openBracketsIndex != -1 && cursorChar !=# ']') ? cursorPos + 2 : cursorPos
    for i in range(forwardStarPos, strchars(str) - 1, 1)
        var char: string = str[i]
        if char !~# '\[\|\]' | continue | endif
        if char ==# '[' | return '' | endif

        var doubleBrackets = GetDoubleBrackets(char, str, i)
        closeBracketsIndex = doubleBrackets != -1 ? doubleBrackets : -1
        if closeBracketsIndex != -1 | break | endif
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
