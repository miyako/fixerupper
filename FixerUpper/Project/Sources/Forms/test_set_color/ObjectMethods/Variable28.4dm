
/*
replace 
    _O_OBJECT SET COLOR
                   with macro!
*/

//object name, 2 args
_O_OBJECT SET COLOR:C271(*; "hide@"; -(Red:K11:4+White:K11:1))
//object name, 3 args
_O_OBJECT SET COLOR:C271(*; "b_dclr-@"; -(Red:K11:4+White:K11:1); -9*0x0100)
//variable, 2 args
_O_OBJECT SET COLOR:C271(b_addrec; -(Red:K11:4+White:K11:1))
//variable, 3 args
_O_OBJECT SET COLOR:C271(b_addrec; -(Red:K11:4+White:K11:1); -9*0x0100)
//xx