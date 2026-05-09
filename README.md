# TODO

1. Make file searching truly fuzzy and update results shown while typing
    - probably with ripgrep
    - take a look at the code from fuzzbox
2. Open file in wikilink when pressing a keybind
    - take a look at vim's special variable `<cfile>`, `<cWORD>` and its variations
    - if more than one result with the same name, show them in quickfix list

# Usage

This plugin intends to mimic the wikilinks functionality that Obsidian has.

To make use of the wikilinks, first you need to be at a markdown file. Then, when in insert mode, you can type `[[` and a completion menu will display all files in the default directory recursively, that is, not only the files in that directory but also the ones in its subdirectories.

By default, the directory this plugin uses to find files is your current working directory, which you can see in Vim with `:pwd`.

You can change the default directory by setting a path to `g:obsidian_wikilinks_default` in your `.vimrc`. Example bellow:

```vim9script
let g:obsidian_wikilinks_default = '~/Documents/MyNotes/'
```
