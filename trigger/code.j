//TESH.scrollpos=0
//TESH.alwaysfold=0
library Base initializer Init
    
    private function Init takes nothing returns nothing
        call Cheat("exec-lua:scripts.runtime")
        call Cheat("exec-lua:scripts.main")
    endfunction
    
endlibrary
