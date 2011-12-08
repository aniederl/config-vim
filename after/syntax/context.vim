
unlet b:current_syntax
syn include @LUATop syntax/lua.vim

syn match  contextLuaDelim display '\\\%(\%(start\|stop\)luacode\|ctxlua\)'
                           \ contains=@NoSpell
syn region contextLuatex transparent matchgroup=contextLuaDelim
                         \ start='\\startluacode'
                         \ end='\\stopluacode'
                         \ contains=@LUATop
syn region contextCtxLua transparent matchgroup=contextLuaDelim
                         \ start='\\ctxlua{'
                         \ end='}'
                         \ contains=@LUATop


hi def link contextLuaDelim Keyword

let b:current_syntax = "context"
