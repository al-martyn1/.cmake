include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/functions_base.cmake")

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
function(umba_math_eval EVAL_EXPRESSION)
    math(EXPR evalRes "${EVAL_EXPRESSION}")
    umba_return(${evalRes})
endfunction()

#----------------------------------------------------------------------------
