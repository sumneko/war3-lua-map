//TESH.scrollpos=0
//TESH.alwaysfold=0
native EXExecuteScript     takes string script returns string

library Base initializer Init
    
    private function Init takes nothing returns nothing
        call EXExecuteScript("(function () package.path = package.path .. [[;scripts\\?.lua;scripts\\?\\init.lua]] end)()")
        call Cheat("exec-lua:runtime")
        call Cheat("exec-lua:main")
    endfunction
    
endlibrary
