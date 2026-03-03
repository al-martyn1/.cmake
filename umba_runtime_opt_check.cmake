include_guard(GLOBAL)

#----------------------------------------------------------------------------
# Если тип рантайма не настроен, задаём его

# Проверяем настройки типа рантайма
if (UMBA_DYNAMIC_RUNTIME AND UMBA_STATIC_RUNTIME)
    message(FATAL_ERROR "Option UMBA_DYNAMIC_RUNTIME conflicts with option UMBA_STATIC_RUNTIME")
endif()

if (UMBA_DYNAMIC_RUNTIME)
    set(UMBA_STATIC_RUNTIME FALSE)
    message(STATUC "UMBA: Option UMBA_DYNAMIC_RUNTIME is ON, clear UMBA_STATIC_RUNTIME")
endif()

if (UMBA_STATIC_RUNTIME)
    set(UMBA_DYNAMIC_RUNTIME FALSE)
    message(STATUC "UMBA: Option UMBA_STATIC_RUNTIME is ON, clear UMBA_DYNAMIC_RUNTIME")
endif()

#----------------------------------------------------------------------------
