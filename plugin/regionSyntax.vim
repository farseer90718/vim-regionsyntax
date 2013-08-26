command! -range -nargs=1 -complete=filetype RegionSyntax call regionSyntax#fromSelection(<f-args>)
if !exists('g:regionsyntax_enabled_extension')
    let g:regionsyntax_enabled_extension = ['wiki', 'md', 'mkd', 'markdown']
endif

if !exists('g:regionsyntax_map')
    let g:regionsyntax_map = {}
    let g:regionsyntax_map["vimwiki"] = [{
                \ 'start' : '\m^[ \t]*{{{class[ \t]*=[ \t]*.[ \t]*<syntax>[ \t]*.[ \t]*$',
                \ 'end' : '^[ \t]*}}}[ \t]*$'
                \ },
                \{'start' : '\m^[ \t]*{{\$[ \t]*$',
                \ 'ft' : 'tex',
                \ 'end' : '\m^[ \t]*}}\$[ \t]*$'
                \}
                \ ]
    let g:regionsyntax_map["mkd"] = [{
                \ 'start' : '\m^[ \t]*{%[ \t]*highlight[ \t]\+<syntax>.*%}[ \t]*$',
                \ 'end' : '^[ \t]*{%[ \t]*endhighlight[ \t]*%}[ \t]*$',
                \ },
                \ {'start' : '\m^[ \t]*```[ \t]*<syntax>[ \t]*$',
                \ 'end' : '^[ \t]*```[ \t]*$'
                \ }]
endif

for s:ex in g:regionsyntax_enabled_extension
    execute "autocmd InsertLeave,BufWritePost *.".s:ex." call regionSyntax#CodeRegionSyntax(&syntax)"
endfor
for s:syn in keys(g:regionsyntax_map)
    execute "autocmd Syntax ".s:syn." let b:oldft=[]|call regionSyntax#CodeRegionSyntax(&syntax)"
endfor
" vim:ts=4:sw=4:tw=78:ft=vim:fdm=indent:fdl=99
