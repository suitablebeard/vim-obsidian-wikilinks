vim9script

export def NormalizePath(path: string): string
    return expand(simplify(fnameescape(path)))
enddef

