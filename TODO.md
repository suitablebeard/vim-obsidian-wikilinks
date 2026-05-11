# TODO

1. Get a LICENSE
2. Learn about <SID>, <PLUG> and others
3. Make file searching truly fuzzy and update results shown while typing
    - this might not be needed with the since I have the 'completeopt' with the 'fuzzy' option
    - probably with ripgrep
    - take a look at the code from fuzzbox
    - take a look at 'completefunc' and 'complete-functions'
4. Open file in wikilink when pressing a keybind
    - [x] take a look at vim's special variable `<cfile>`, `<cWORD>` and its variations
    - [x] open file from wikilink
    - [x] if more than one result with the same name, show them in quickfix list
    - [ ] also maybe allow opening other filetypes, though this would require to open them is other apps
5. Create documentation and help tags

- [x] Filter out directories from pum results
    - [x] currently, the method used for finding files for some reason also adds directories to the pum
    - [x] maybe also only allow .md files (see 3.3)

# My questions

4. What is <Plug>, <unique>, <script>, <buffer>, and <scriptcmd>? How to use them when mapping a keybind?
   and <SID> ?

5. can you help me write a small function that parses the text under the cursor, strips the [[and]], and searches your vault for that filename?

command! -nargs=0 MyAction logic.PerformAction()

if !hasmapto('<Plug>MyPluginAction')
nmap <unique> <leader>z <Plug>MyPluginAction
endif

nnoremap <script> <Plug>MyPluginAction <scriptcmd>logic.PerformAction()<cr>

<leader>z => <Plug>MyPluginAction => <scriptcmd>logic.PerformAction()<cr>

nnoremap <script> <Plug>MyPluginAction <scriptcmd>logic.PerformAction()<cr>

====================================================================

====================================================================

5. Go find the [[thing you know and]], and searches your vault for that filename?
