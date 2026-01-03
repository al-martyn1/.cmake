include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/functions_base.cmake")

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
function(umba_path_normalize PATH)
    cmake_path(SET normalizedRes NORMALIZE ${PATH})
    umba_return(${normalizedRes})
endfunction()

#----------------------------------------------------------------------------
