include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/functions_base.cmake")

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
function(umba_math_eval OUTPUT_VAR EVAL_EXPRESSION)
    math(EXPR umbaRes "${EVAL_EXPRESSION}")
    set(${OUTPUT_VAR} "${umbaRes}" PARENT_SCOPE)
endfunction()

#----------------------------------------------------------------------------
