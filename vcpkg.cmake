include_guard(GLOBAL)

include("${CMAKE_CURRENT_LIST_DIR}/pathlib.cmake")

#[===[.md:
# Переменные инициализации: Все переменные управления vcpkg (например, VCPKG_TARGET_TRIPLET, VCPKG_MANIFEST_MODE) должны быть установлены до вызова include.

- VCPKG_HOST_TRIPLET: определяет триплет для инструментов, которые должны запускаться на вашей текущей машине (например, генераторы кода, такие как protobuf или bison).

- VCPKG_TARGET_TRIPLET

- VCPKG_INSTALLED_DIR: задает путь, куда vcpkg будет устанавливать библиотеки. В режиме манифеста по умолчанию это ${CMAKE_BINARY_DIR}/vcpkg_installed.

- VCPKG_CHAINLOAD_TOOLCHAIN_FILE: критически важна для кросс-компиляции. Позволяет vcpkg загрузить ваш основной файл тулчейна (с компиляторами) после настройки своей среды. 

- VCPKG_MANIFEST_DIR: позволяет указать альтернативный путь к папке с файлом vcpkg.json, если он лежит не в корне проекта.

- VCPKG_MANIFEST_FEATURES: список дополнительных функций (features) из манифеста, которые нужно включить (например, set(VCPKG_MANIFEST_FEATURES "tests;examples")).

- VCPKG_OVERLAY_PORTS: список путей к вашим собственным (кастомным) портам библиотек.

- VCPKG_OVERLAY_TRIPLETS: список путей к вашим кастомным триплетам.

- VCPKG_INSTALL_OPTIONS: дополнительные флаги командной строки, которые будут переданы команде vcpkg install (например, для настройки бинарного кэширования).

- VCPKG_USE_HOST_TOOLS: при значении ON автоматически добавляет исполняемые файлы, собранные под HOST_TRIPLET, в путь поиска CMAKE_PROGRAM_PATH. 

#]===]


if(DEFINED ENV{VCPKG_ROOT})

    set(UMBA_VCPKG_ROOT $ENV{VCPKG_ROOT})
    umba_path_normalize(${UMBA_VCPKG_ROOT})
    set(UMBA_VCPKG_ROOT ${umbaResult})

    set(UMBA_VCPKG_CMAKE "${UMBA_VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

    if(EXISTS "${UMBA_VCPKG_CMAKE}")
        set(UMBA_VCPKG_FOUND ON)
    endif()
  
    if (UMBA_VCPKG_FOUND)
        if (UMBA_CMAKE_VERBOSE)
                message(STATUS "Found vcpkg: ${UMBA_VCPKG_ROOT}") # NOTICE
                message(STATUS "vcpkg.cmake: ${UMBA_VCPKG_CMAKE}") # NOTICE
        endif()
    endif()
endif()

if (UMBA_VCPKG_FOUND)

    #"${UMBA_VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

endif() # UMBA_VCPKG_FOUND


# set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE /path/to/arm-linux.cmake)
#VCPKG_HOST_TRIPLET
#C:\work\tools\vcpkg\scripts\buildsystems\
#C:\work\tools\vcpkg\scripts\buildsystems\


# if (BUILD_SHARED_LIBS)
#    set(UMBA_)
# BUILD_SHARED_LIBS

# arm arm64 x86 x64

# if (WIN32)


# if (CMAKE_HOST_WIN32)

# message(STATUS "VCPKG_TARGET_TRIPLET: ${VCPKG_TARGET_TRIPLET}")


# set(VCPKG_TARGET_ARCHITECTURE arm64)
# set(VCPKG_CRT_LINKAGE static)
# set(VCPKG_LIBRARY_LINKAGE static)
# 
# set(VCPKG_BUILD_TYPE release)
