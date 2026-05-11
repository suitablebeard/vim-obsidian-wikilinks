# TODO

1. Learn about <SID>, <PLUG> and others
2. Get a LICENSE
3. Maybe allow opening other filetypes inside wikilinks, though this would require to open them is other apps
4. Create documentation and help tags
5. Make file searching truly fuzzy and update results shown while typing
    - this might not be needed with the since I have the 'completeopt' with the 'fuzzy' option
    - probably with ripgrep
    - take a look at the code from [fuzzbox](https://github.com/vim-fuzzbox/fuzzbox.vim) and [minifuzzy](https://github.com/chrispane11/minifuzzy.vim/)
    - take a look at 'completefunc' and 'complete-functions'

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
