include_guard(GLOBAL)


if(NOT PRJ_ROOT)
    set(PRJ_ROOT "${CMAKE_CURRENT_LIST_DIR}/..")
endif()

if(PRJ_ROOT)
    if(NOT LIB_ROOT)
        set(LIB_ROOT "${PRJ_ROOT}/_libs")
    endif()
    if(NOT SRC_ROOT)
        set(SRC_ROOT "${PRJ_ROOT}/_src")
    endif()
endif()


# GCC specific global options
if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # using GCC
    # Наелся говна с GCC, когда забыт return и падает хрен знает где. 
    # Варнинги GCC в VSCode как-то незаметны, если вообще есть, аналогичные в MSVC как-то сразу видно даже без особых приседаний
    # Поэтому для GCC данный варнинг включается как ошибка всегда
    # https://stackoverflow.com/questions/42760220/how-can-i-enforce-an-error-when-a-function-doesnt-have-any-return-in-gcc
    add_compile_options("-Werror=return-type" ) # Force error if no return statement in non-void function
endif()



# set(UMBA_USE_BOOST       ON)
# set(UMBA_USE_BOOST_FETCH ON)
# set(UMBA_STATIC_RUNTIME  ON)
# set(UMBA_BOOST_CMAKE_FETCH_URL D:/boost-1.84.0.tar.xz) # https://github.com/boostorg/boost/releases/download/boost-1.84.0/boost-1.84.0.tar.xz #URL_MD5 893b5203b862eb9bbd08553e24ff146a
# https://github.com/boostorg/boost/releases/download/boost-1.85.0/boost-1.85.0-cmake.tar.xz

if (UMBA_USE_BOOST_FETCH)
    set(UMBA_USE_BOOST ON)
    set(UMBA_USE_BOOST ON PARENT_SCOPE)
endif()

if(UMBA_USE_BOOST)

    add_compile_definitions("UMBA_USE_BOOST")

    if(UMBA_USE_BOOST_FETCH)

        if(NOT UMBA_BOOST_CMAKE_FETCH_URL)
            if(DEFINED ENV{BOOST_CMAKE_FETCH_URL})
                set(UMBA_BOOST_CMAKE_FETCH_URL "$ENV{BOOST_CMAKE_FETCH_URL}")
            endif()
        endif()

        if(NOT UMBA_BOOST_CMAKE_FETCH_URL) # https://github.com/boostorg/boost/releases/download/boost-1.84.0/boost-1.84.0.tar.xz
            set(UMBA_BOOST_CMAKE_FETCH_URL  "https://github.com/boostorg/boost/releases/download/boost-1.85.0/boost-1.85.0-cmake.tar.xz")
        endif()

        if(NOT UMBA_BOOST_CMAKE_FETCH_URL)
            message(FATAL_ERROR "UMBA_USE_BOOST_FETCH is set, but UMBA_BOOST_CMAKE_FETCH_URL is not set, nor BOOST_CMAKE_FETCH_URL environment variable. See .cmake/README.md for details how to set up Boost")
        endif()
        
        include(FetchContent)
        FetchContent_Declare(
          Boost
          URL ${UMBA_BOOST_CMAKE_FETCH_URL}
          DOWNLOAD_EXTRACT_TIMESTAMP ON
        )
        FetchContent_MakeAvailable(Boost)
    
    else() # Use local lightweight boost
    
        if(NOT Boost_INCLUDE_DIR)
            if(DEFINED ENV{BOOST_ROOT})
                set(Boost_INCLUDE_DIR "$ENV{BOOST_ROOT}")
            endif()
        endif()

        if(NOT Boost_INCLUDE_DIR)
            message(FATAL_ERROR "UMBA_USE_BOOST is set, but Boost_INCLUDE_DIR is not set, nor BOOST_ROOT environment variable. See .cmake/README.md for details how to set up Boost")
        endif()
    
        if(Boost_INCLUDE_DIR)
            find_package(Boost)
            include_directories(${Boost_INCLUDE_DIRS})
        endif()
    
    endif()

endif()


# https://stackoverflow.com/questions/10113017/setting-the-msvc-runtime-in-cmake
# https://cmake.org/cmake/help/latest/prop_tgt/MSVC_RUNTIME_LIBRARY.html
# set_property(TARGET foo PROPERTY
#  MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# https://cmake.org/cmake/help/git-stage/variable/CMAKE_MSVC_RUNTIME_LIBRARY.html
# https://cmake.org/cmake/help/git-stage/manual/cmake-generator-expressions.7.html#manual:cmake-generator-expressions(7)
# set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# MultiThreaded$<$<CONFIG:Debug>:Debug>DLL

# linux
# https://stackoverflow.com/questions/35994339/link-linux-c-application-statically-via-cmake-2-8
if(UMBA_STATIC_RUNTIME)
    # For use as ${UMBA_STATIC_RUNTIME} when calling umba_add_target_options
    set(UMBA_STATIC_RUNTIME "UMBA_STATIC_RUNTIME")
    set(STATIC_RUNTIME      "STATIC_RUNTIME")
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
else()
    message("Default Dynamic runtime used")
endif()


### Boost
# Defaults for Boost
# set(Boost_USE_STATIC_LIBS OFF) 
#set(Boost_USE_MULTITHREADED ON)  
#set(Boost_USE_STATIC_RUNTIME OFF) 


# D:\CMake\share\cmake-3.29\Modules\FindBoost.cmake
# https://cmake.org/cmake/help/latest/module/FindBoost.html
# https://stackoverflow.com/questions/6646405/how-do-you-add-boost-libraries-in-cmakelists-txt

# Install
# https://www.youtube.com/watch?v=D640-ZJmBWM
# How to link C++ program with Boost using CMake - https://stackoverflow.com/questions/3897839/how-to-link-c-program-with-boost-using-cmake
# Using Boost with CMake - https://discourse.cmake.org/t/using-boost-with-cmake/6299
# Работа с Boost и CMake под Windows - https://zhitenev.ru/rabota-s-boost-i-cmake-pod-windows/
# Boost CMake support infrastructure - https://github.com/boostorg/cmake
#   git clone --recurse-submodules https://github.com/boostorg/boost  
# Building and Installing the Library - https://www.boost.org/doc/libs/1_85_0/libs/regex/doc/html/boost_regex/install.html

# Cross-compilation - https://www.boost.org/build/doc/html/bbv2/tasks/crosscompile.html
# Builtin tools - https://www.boost.org/build/doc/html/bbv2/reference/tools.html
# Or, Build Custom Binaries - https://www.boost.org/doc/libs/1_56_0/more/getting_started/unix-variants.html#or-build-custom-binaries

# How do I use a different compiler - https://gitlab.kitware.com/cmake/community/-/wikis/FAQ#how-do-i-use-a-different-compiler
# #set(CMAKE_CXX_LINK_EXECUTABLE ${CMAKE_CXX}) # не нужно
# set(CMAKE_LINKER ${CMAKE_CXX})



# STATIC_LIBS
# MULTITHREADED - no mean, option is set to ON by default
# SINGLETHREADED - single threaded not supported by MSVC?
# STATIC_RUNTIME
function(umba_configure_boost)

    math(EXPR maxArgN "${ARGC} - 1")

    foreach(_index RANGE 0 ${maxArgN} 1)

        set(CURARG ${ARGV${_index}})

        if(NOT CURARG)
            message("umba_configure_boost: NULL Argument at pos: ${_index} (${CURARG}) (1)")
            continue()
        endif()

        if(${CURARG} STREQUAL "")
            message("umba_configure_boost: NULL Argument at pos: ${_index} (${CURARG}) (2)")
            continue()
        endif()

        if(${CURARG} STREQUAL "STATIC_LIBS" OR ${CURARG} STREQUAL "UMBA_STATIC_LIBS")
            set(Boost_USE_STATIC_LIBS ON) 
        elseif(${CURARG} STREQUAL "MULTITHREADED")
            # no mean, option is set to ON by default
        elseif(${CURARG} STREQUAL "SINGLETHREADED")
            set(Boost_USE_MULTITHREADED OFF)  
        elseif(${CURARG} STREQUAL "STATIC_RUNTIME" OR ${CURARG} STREQUAL "UMBA_STATIC_RUNTIME")
            set(Boost_USE_STATIC_RUNTIME ON) 
        endif()

    endforeach()

endfunction()


### Trees

function(umba_make_sources_tree SRC_ROOT SRCS HDRS RCSRCS)

    if(SRCS)
        source_group(TREE ${SRC_ROOT} PREFIX "Sources" FILES ${SRCS})
    endif()

    if(HDRS)
        source_group(TREE ${SRC_ROOT} PREFIX "Headers" FILES ${HDRS})
    endif()

    if(RCSRCS)
        source_group(TREE ${SRC_ROOT} PREFIX "Resources" FILES ${RCSRCS})
    endif()

endfunction()




### Target options

# UNICODE/MBCS/DBCS
# https://learn.microsoft.com/ru-ru/cpp/text/support-for-multibyte-character-sets-mbcss?view=msvc-170
# https://learn.microsoft.com/ru-ru/cpp/text/mbcs-support-in-visual-cpp?view=msvc-170
# https://learn.microsoft.com/ru-ru/cpp/text/mbcs-programming-tips?view=msvc-170

# "UNICODE" "CONSOLE" "WINDOWS" "BIGOBJ" "UTF8"
# "SRCUTF8"/"UTF8SRC"/"SRC_UTF8"/"UTF8_SRC"
# "STATIC_RUNTIME"
function(umba_add_target_options TARGET)

    # https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html

    # https://jeremimucha.com/2021/02/cmake-functions-and-macros/

    #math(EXPR indices "${ARGC} - 1")
    #foreach(_index RANGE ${indices})

    math(EXPR maxArgN "${ARGC} - 1")
    foreach(_index RANGE 1 ${maxArgN} 1)

        set(CURARG ${ARGV${_index}})

        if(NOT CURARG)
            message("umba_add_target_options: NULL Argument at pos: ${_index} (${CURARG}) (1)")
            continue()
        endif()

        if(${CURARG} STREQUAL "")
            message("umba_add_target_options: NULL Argument at pos: ${_index} (${CURARG}) (2)")
            continue()
        endif()

        if(${CURARG} STREQUAL "UNICODE")
            if(WIN32)

                # Common for all
                target_compile_definitions(${TARGET} PRIVATE "UNICODE" "_UNICODE")

                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add UNICODE options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    target_compile_options(${TARGET} PRIVATE "-municode")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add UNICODE options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    #message(NOTICE "Add UNICODE options for MSVC")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "SRCUTF8" OR ${CURARG} STREQUAL "UTF8SRC" OR ${CURARG} STREQUAL "UTF8_SRC" OR ${CURARG} STREQUAL "SRC_UTF8")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add SRCUTF8 options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # !!! conversion from UTF-8 to UTF-8 -finput-charset=UTF-8 not supported by iconv
                    # target_compile_options(${TARGET} PRIVATE "-finput-charset=UTF-8")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add SRCUTF8 options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    # /utf-8, that sets both /source-charset:utf-8 and /execution-charset:utf-8.
                    target_compile_options(${TARGET} PRIVATE "/source-charset:utf-8")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "UTF8")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add UTF8 options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # !!! conversion from UTF-8 to UTF-8 -finput-charset=UTF-8 not supported by iconv
                    # target_compile_options(${TARGET} PRIVATE "-fexec-charset=UTF-8 -finput-charset=UTF-8")  # https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add UTF8 options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    target_compile_options(${TARGET} PRIVATE "/utf-8")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "CONSOLE")
            if(WIN32)

                # Common for all
                target_compile_definitions(${TARGET} PRIVATE "CONSOLE" "_CONSOLE")

                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add CONSOLE options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    target_compile_options(${TARGET} PRIVATE "-mconsole")
                    target_link_options(${TARGET} PRIVATE "-Wl,--subsystem,console")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add CONSOLE options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    target_link_options(${TARGET} PRIVATE "/SUBSYSTEM:CONSOLE")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "WINDOWS")
            if(WIN32)

                # Common for all
                target_compile_definitions(${TARGET} PRIVATE "WINDOWS" "_WINDOWS")

                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add WINDOWS options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    target_compile_options(${TARGET} PRIVATE "-mwindows")
                    target_link_options(${TARGET} PRIVATE "-Wl,--subsystem,windows")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add WINDOWS options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    target_link_options(${TARGET} PRIVATE "/SUBSYSTEM:WINDOWS")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "BIGOBJ")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    message(NOTICE "Add BIGOBJ options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    target_compile_options(${TARGET} PRIVATE "-Wa,-mbig-obj")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    message(NOTICE "Add BIGOBJ options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    target_compile_options(${TARGET} PRIVATE "/bigobj")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "WALL")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    #message(NOTICE "Add BIGOBJ options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
                    target_compile_options(${TARGET} PRIVATE "-Wall" "-Wextra")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    #message(NOTICE "Add BIGOBJ options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    # https://devblogs.microsoft.com/cppblog/broken-warnings-theory/
                    # https://habr.com/ru/companies/pvs-studio/articles/347686/
                    # https://learn.microsoft.com/en-us/cpp/build/reference/compiler-option-warning-level?view=msvc-170
                    target_compile_options(${TARGET} PRIVATE "/Wall" "/external:anglebrackets" "/external:W1")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "PEDANTIC")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    #message(NOTICE "Add BIGOBJ options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
                    target_compile_options(${TARGET} PRIVATE "-Wpedantic" "-pedantic" "-Werror=pedantic" "-pedantic-errors" "-Wall" "-Wextra")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    #message(NOTICE "Add BIGOBJ options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    # https://devblogs.microsoft.com/cppblog/broken-warnings-theory/
                    # https://habr.com/ru/companies/pvs-studio/articles/347686/
                    # https://learn.microsoft.com/en-us/cpp/build/reference/compiler-option-warning-level?view=msvc-170
                    # https://learn.microsoft.com/en-us/cpp/build/reference/za-ze-disable-language-extensions?view=msvc-160
                    # https://learn.microsoft.com/en-us/cpp/build/reference/zc-conformance?view=msvc-170
                    # https://stackoverflow.com/questions/69575307/microsoft-c-c-what-is-the-definition-of-strict-conformance-w-r-t-implement
                    target_compile_options(${TARGET} PRIVATE "/Wall" "/permissive-" "/external:anglebrackets" "/external:W0")
                    # Вопрос - внешние варнинги будут как ошибки при /WX?
                endif()
            endif()

        elseif(${CURARG} STREQUAL "PERMISSIVE")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    #message(NOTICE "Add BIGOBJ options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
                    target_compile_options(${TARGET} PRIVATE "-fpermissive" )
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    #message(NOTICE "Add BIGOBJ options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    # https://devblogs.microsoft.com/cppblog/broken-warnings-theory/
                    # https://habr.com/ru/companies/pvs-studio/articles/347686/
                    # https://learn.microsoft.com/en-us/cpp/build/reference/compiler-option-warning-level?view=msvc-170
                    target_compile_options(${TARGET} PRIVATE "/W2" "/permissive" "/external:anglebrackets" "/external:W0")
                endif()
            endif()

        elseif(${CURARG} STREQUAL "WERR" OR ${CURARG} STREQUAL "WERROR")
            if(WIN32)
                if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                    #message(NOTICE "Add BIGOBJ options for Clang")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
                    target_compile_options(${TARGET} PRIVATE "-Werror")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                    #message(NOTICE "Add BIGOBJ options for Intel")
                elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                    # https://learn.microsoft.com/ru-ru/cpp/build/reference/permissive-standards-conformance?view=msvc-170
                    # https://learn.microsoft.com/en-us/cpp/build/reference/permissive-standards-conformance?view=msvc-170
                    # https://learn.microsoft.com/en-us/cpp/build/reference/compiler-option-warning-level?view=msvc-170

                    target_compile_options(${TARGET} PRIVATE "/WX" "/external:anglebrackets" "/external:W1")

                    # !!! Надо разобратся со всеми этими варнингами. Пока дизаблим

                    # warning C4464: exclude warning "relative include path contains '..'"
                    target_compile_options(${TARGET} PRIVATE "/wd4464")

                    # warning C4820: N bytes padding added after data member 'memberName'
                    target_compile_options(${TARGET} PRIVATE "/wd4820")

                    # warning C4626: 'TYPE': assignment operator was implicitly defined as deleted
                    target_compile_options(${TARGET} PRIVATE "/wd4626")

                    # warning C5027: 'TYPE': move assignment operator was implicitly defined as deleted
                    target_compile_options(${TARGET} PRIVATE "/wd5027")

                    # warning C4435: 'TYPE': Object layout under /vd2 will change due to virtual base 'TYPE_BASE'
                    target_compile_options(${TARGET} PRIVATE "/wd4435")

                    # https://learn.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-4-c4710?view=msvc-170
                    # warning C4710: function not inlined
                    target_compile_options(${TARGET} PRIVATE "/wd4710")

                    # warning C4711: function selected for automatic inline expansion
                    target_compile_options(${TARGET} PRIVATE "/wd4711")

                    # warning C4738: storing 32-bit float result in memory, possible loss of performance
                    target_compile_options(${TARGET} PRIVATE "/wd4738")

                endif()
            endif()

        elseif(${CURARG} STREQUAL "STATIC_RUNTIME" OR ${CURARG} STREQUAL "UMBA_STATIC_RUNTIME")
            if(WIN32)
                # Под винду разве не все компиляторы используют MSVC ABI?
                set_property(TARGET ${TARGET} PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

                #if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
                #    message(NOTICE "Add BIGOBJ options for Clang")
                #elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
                #    target_compile_options(${TARGET} PRIVATE "-Wa,-mbig-obj")
                #elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
                #    message(NOTICE "Add BIGOBJ options for Intel")
                #elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
                #    set_property(TARGET ${TARGET} PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
                #endif()
            endif()

        endif() # if(${CURARG}

    endforeach()

endfunction()


