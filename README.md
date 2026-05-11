# vim-obsidian-wikilinks

This plugin intends to mimic the wikilinks functionality that Obsidian has, where you can link to other files (notes) by writing their filename inside double brackets.

## Usage

To make use of the wikilinks, first you need to be at a markdown file. Then, when in insert mode, you can type `[[` and a completion menu will display all files inside the default directory recursively, that is, not only the files in that directory but also the ones in its subdirectories. By default, that default directory is your current working directory (which you can see in Vim with `:pwd`).

For better experience, it is recommended to turn on Vim's built-in fuzzy autocompletion with:

```vimscript
set completeopt+=fuzzy
```

Similar to Obsidian, you can also open the file for the wikilink under your cursor with `:ObsidianWikilinkOpen` or with a mapping (the default is `<leader>ow`).

If, however, the wikilink your trying to open is an "unresolved link" (i.e. refers to an uncreated note) a new markdown file will be created with the name of the wikilink. By default, the new file is created inside a subdirectory of your default directory. By default, that subdirectory is called '+' (a plus symbol).

You can also "create" a wiki by surrounding the selected text with double brackets with `:ObsidianWikilinkCreate` (currently this only works well through a mapping and not by typing the command).

## Requirements

- Vim >= 9.0 (plugin is written in vim9script, Vim 9+ required, Neovim not supported);
- No other dependancies need since the plugin uses Vim's built-in `find`.

## Configuration

You can change the following option as you see fit and add them to your `.vimrc`.

```vimscript
" directory where this plugin searches for files
let g:obsidian_wikilinks_default_dir = '/my/default/dir/'

" directory where new files are created
let g:obsidian_wikilinks_newfile_dir = '/my/newfile/dir/'

" mapping to open wikilink under the cursor
nmap {your_mapping} <Plug>ObsidianWikilinkOpen

" mapping to surround selected text with double brackets
vmap {your_mapping} <Plug>ObsidianWikilinkCreate
```

## Instalation

Install using your favorite package manager, or use Vim's built-in package support:

```
 git clone https://github.com/suitablebeard/vim-obsidian-wikilinks ~/.vim/pack/plugins/start/obsidianwikilinks
```
