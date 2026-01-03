include_guard(GLOBAL)

#----------------------------------------------------------------------------
set(umbaResult)

#----------------------------------------------------------------------------
macro(umba_return RET_VAL)
    set(umbaResult ${RET_VAL} PARENT_SCOPE)
endmacro()

