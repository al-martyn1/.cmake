include_guard(GLOBAL)

function(umba_fix_windres)

# Фиксим проблему с MINGW windres - он передаёт инклюды в препроцессор не экранируя, из-за этого
# пути, которые содержат пробелы, разбиваются на отдельные аргументы, и препроцессор выдаёт ошибки
# https://cmake.org/cmake/help/latest/command/find_program.html

find_program(UMBA_WINDRES "umba-windres")

message("CMAKE_RC_COMPILE_OBJECT: ${CMAKE_RC_COMPILE_OBJECT}")
# Если тулчейн MINGW'шный и утилита umba-windres найдена, то фиксим, иначе пусть работает, как работало
if(MINGW AND UMBA_WINDRES)
    enable_language(RC)
    message("MINGW AND UMBA_WINDRES fires")
    message("UMBA_WINDRES: ${UMBA_WINDRES}")
    # https://man7.org/linux/man-pages/man1/windres.1.html
    set(CMAKE_RC_COMPILE_OBJECT 
        # "<CMAKE_RC_COMPILER> --use-temp-file -O coff <DEFINES> <INCLUDES> <FLAGS> -i <SOURCE> -o <OBJECT>"

        # Вызов прокси umba-windres. Первым аргументом (опционально) передаётя полный путь к оригинальному windres
        # Если не передан путь к windres, то вызывается windres(.exe) без пути
        # Прокси umba-windres проверяет каждый аргумент. Если родительский каталог элемента является существующим путём
        # (сам элемент может не существовать, так как выходной файл, например), то производится его конвертация
        # в короткое имя 8.3 (но в системе это может быть отключено, по умолчанию - включено)
        # UNC/сетевые пути не поддерживаются, но кто в здравом уме их использует при сборке проекта?
        "<UMBA_WINDRES> <CMAKE_RC_COMPILER> --use-temp-file <FLAGS> -O coff <DEFINES> <INCLUDES> <SOURCE> <OBJECT>"

        PARENT_SCOPE
        )
endif()
message("CMAKE_RC_COMPILE_OBJECT: ${CMAKE_RC_COMPILE_OBJECT}")

endfunction()
