include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/functions_base.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/mathlib.cmake")

#----------------------------------------------------------------------------


#----------------------------------------------------------------------------

# function(umba_str_len STR)
# function(umba_str_get_first_char STR)
# function(umba_str_get_last_char STR)
# function(umba_str_strip_first_char STR)
# function(umba_str_strip_last_char STR)

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------

# https://cmake.org/cmake/help/latest/command/string.html
# 
# Search and Replace
#   string(FIND <string> <substring> <out-var> [...])
#   string(REPLACE <match-string> <replace-string> <out-var> <input>...)
#   string(REGEX MATCH <match-regex> <out-var> <input>...)
#   string(REGEX MATCHALL <match-regex> <out-var> <input>...)
#   string(REGEX REPLACE <match-regex> <replace-expr> <out-var> <input>...)
# 
# Manipulation
#   string(APPEND <string-var> [<input>...])
#   string(PREPEND <string-var> [<input>...])
#   string(CONCAT <out-var> [<input>...])
#   string(JOIN <glue> <out-var> [<input>...])
#   string(TOLOWER <string> <out-var>)
#   string(TOUPPER <string> <out-var>)
#   string(LENGTH <string> <out-var>)
#   string(SUBSTRING <string> <begin> <length> <out-var>)
#   string(STRIP <string> <out-var>)
#   string(GENEX_STRIP <string> <out-var>)
#   string(REPEAT <string> <count> <out-var>)
#   string(REGEX QUOTE <out-var> <input>...)
# 
# Comparison
#   string(COMPARE <op> <string1> <string2> <out-var>)
# 
# Hashing
#   string(<HASH> <out-var> <input>)
# 
# Generation
#   string(ASCII <number>... <out-var>)
#   string(HEX <string> <out-var>)
#   string(CONFIGURE <string> <out-var> [...])
#   string(MAKE_C_IDENTIFIER <string> <out-var>)
#   string(RANDOM [<option>...] <out-var>)
#   string(TIMESTAMP <out-var> [<format string>] [UTC])
#   string(UUID <out-var> ...)

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
function(umba_str_len STR)
    string(LENGTH "${STR}" LENRES)
    umba_return(${LENRES})
endfunction()

#----------------------------------------------------------------------------
function(umba_str_substr_be STR BEGIN END)

    umba_str_len(${STR})
    set(strLen ${umbaResult})

    if (${BEGIN} GREATER_EQUAL ${strLen})

        umba_return("")

    else()
        
        if(${END} GREATER ${strLen})
            set(END_ ${strLen})
        else()
            set(END_ ${END})
        endif()

        umba_math_eval("${END_} - ${BEGIN}")
        set(SLEN ${umbaResult})

        if (${SLEN} LESS 1)
            umba_return("")
        else()
            string(SUBSTRING ${STR} ${BEGIN} ${SLEN} res)
            umba_return("${res}")
        endif()

    endif()

endfunction()

#----------------------------------------------------------------------------
function(umba_str_substr_len STR POS LEN)

    umba_math_eval("${POS} + ${LEN}")
    set(END ${umbaResult})

    umba_str_substr_be(${STR} ${POS} ${END} res)
    umba_return("${res}")

endfunction()

#----------------------------------------------------------------------------
function(umba_str_get_first_char STR)

    if(NOT STR)
        umba_return("")
    else()
        # string(SUBSTRING <string> <begin> <length> <out-var>)
        string(SUBSTRING ${STR} 0 1 res)
        umba_return("${res}")
    endif()

endfunction()

#----------------------------------------------------------------------------
function(umba_str_get_last_char STR)

    umba_str_len(${STR})
    set(strLen ${umbaResult})
    umba_math_eval("${strLen} - 1")
    set(startPos ${umbaResult})

    umba_str_substr_be(${STR} ${startPos} ${strLen})
    set(res ${umbaResult})
    umba_return("${res}")

endfunction()

#----------------------------------------------------------------------------
function(umba_str_strip_first_char STR)

    umba_str_len(${STR})
    set(strLen ${umbaResult})
    umba_str_substr_be(${STR} 1 ${strLen})
    set(res ${umbaResult})
    umba_return("${res}")

endfunction()

#----------------------------------------------------------------------------
function(umba_str_strip_last_char STR)

    umba_str_len(${STR})
    set(strLen ${umbaResult})
    umba_math_eval("${strLen} - 1")
    set(lenMinus1 ${umbaResult})
    umba_str_substr_be(${STR} 0 ${lenMinus1})
    set(res ${umbaResult})
    umba_return("${res}")

endfunction()

#----------------------------------------------------------------------------
function(umba_str_first_char_equ STR CH)

    umba_str_get_first_char(${STR})
    if(${umbaResult} STREQUAL ${CH})
        umba_return(TRUE)
    else()
        umba_return(FALSE)
    endif()

endfunction()

#----------------------------------------------------------------------------
function(umba_str_last_char_equ STR CH)

    umba_str_get_last_char(${STR})
    if(${umbaResult} STREQUAL ${CH})
        umba_return(TRUE)
    else()
        umba_return(FALSE)
    endif()

endfunction()

#----------------------------------------------------------------------------
function(umba_str_split_to_chars STR)

    set(res "")
    umba_str_len(${STR})

    while(NOT "${STR}" STREQUAL "")

        umba_str_get_first_char(${STR})
        list(APPEND res ${umbaResult})

        # message(STATUS "FC1: ${umbaResult}")

        umba_str_strip_first_char(${STR})
        set(STR ${umbaResult})

        # message(STATUS "FC2: ${umbaResult}")

    endwhile()

    umba_return("${res}")

endfunction()

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------
function(test_umba_str_get_strip_first_last_char STR)

    message(STATUS "=== test_umba_str_get_strip_first_last_char ===")
    message(STATUS "Input  : ${STR}")
    message(STATUS "As chars:")

    umba_str_split_to_chars(${STR})
    foreach(CH ${umbaResult})
        message(STATUS "  ${CH}")
    endforeach()

    umba_str_len(${STR})
    message(STATUS "Len    : ${umbaResult}")

    umba_str_get_first_char(${STR})
    message(STATUS "FirstCh: ${umbaResult}")

    umba_str_get_last_char(${STR})
    message(STATUS "LastCh : ${umbaResult}")

    umba_str_strip_first_char(${STR})
    message(STATUS "First char stripped: ${umbaResult}")

    umba_str_strip_last_char(${STR})
    message(STATUS "Last char stripped : ${umbaResult}")

    umba_str_first_char_equ(${STR} "0")
    message(STATUS "First char == 0 : ${umbaResult}")

    umba_str_first_char_equ(${STR} "1")
    message(STATUS "First char == 1 : ${umbaResult}")

    umba_str_last_char_equ(${STR} "9")
    message(STATUS "First char == 9 : ${umbaResult}")

    umba_str_last_char_equ(${STR} "1")
    message(STATUS "Last char == 1  : ${umbaResult}")

endfunction()

#----------------------------------------------------------------------------



#----------------------------------------------------------------------------




# if("${STR}" STREQUAL "")
















# function(umba_math_eval EVAL_EXPRESSION)



