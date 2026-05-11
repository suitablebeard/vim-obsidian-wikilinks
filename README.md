# Usage

This plugin intends to mimic the wikilinks functionality that Obsidian has, where you can link to other files (notes) by writing their filename inside double brackets.

To make use of the wikilinks, first you need to be at a markdown file. Then, when in insert mode, you can type `[[` and a completion menu will display all files in the default directory recursively, that is, not only the files in that directory but also the ones in its subdirectories.

By default, the directory this plugin uses to find files is your current working directory, which you can see in Vim with `:pwd`.

You can change the default directory by setting a path to `g:obsidian_wikilinks_default_dir` in your `.vimrc`. Example bellow:

```vim9script
let g:obsidian_wikilinks_default_dir = '~/Documents/MyNotes/'
```
