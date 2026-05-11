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

# Usage

This plugin intends to mimic the wikilinks functionality that Obsidian has, where you can link to other files (notes) by writing their filename inside double brackets.

To make use of the wikilinks, first you need to be at a markdown file. Then, when in insert mode, you can type `[[` and a completion menu will display all files in the default directory recursively, that is, not only the files in that directory but also the ones in its subdirectories.

By default, the directory this plugin uses to find files is your current working directory, which you can see in Vim with `:pwd`.

You can change the default directory by setting a path to `g:obsidian_wikilinks_default_dir` in your `.vimrc`. Example bellow:

```vim9script
let g:obsidian_wikilinks_default_dir = '~/Documents/MyNotes/'
```
