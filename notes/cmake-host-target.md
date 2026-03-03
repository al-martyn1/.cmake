# Определение платформ в CMake

## **Корректное различие:**

### **Целевая платформа** (target - где будет запускаться программа):
```cmake
WIN32      # Целевая ОС Windows
APPLE      # Целевая ОС Apple (macOS, iOS, tvOS, watchOS)
UNIX       # Целевая ОС UNIX-подобная (Linux, macOS, BSD и т.д.)
ANDROID    # Целевая ОС Android
IOS        # Целевая ОС iOS
CYGWIN     # Целевая ОС Cygwin
MSYS       # Целевая ОС MSYS
```

### **Хостовая платформа** (host - где запущен CMake):
```cmake
CMAKE_HOST_WIN32    # Хостовая ОС Windows
CMAKE_HOST_APPLE    # Хостовая ОС Apple
CMAKE_HOST_UNIX     # Хостовая ОС UNIX-подобная
CMAKE_HOST_SYSTEM_NAME  # Имя хостовой ОС (строка)
```

## **Полный список переменных для определения платформ:**

```cmake
message(STATUS "=== Целевая платформа (target) ===")
if(DEFINED WIN32)
    message(STATUS "WIN32: ${WIN32}")
endif()
if(DEFINED APPLE)
    message(STATUS "APPLE: ${APPLE}")
endif()
if(DEFINED UNIX)
    message(STATUS "UNIX: ${UNIX}")
endif()
if(DEFINED ANDROID)
    message(STATUS "ANDROID: ${ANDROID}")
endif()
if(DEFINED IOS)
    message(STATUS "IOS: ${IOS}")
endif()
if(DEFINED CMAKE_SYSTEM_NAME)
    message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
endif()
if(DEFINED CMAKE_SYSTEM_VERSION)
    message(STATUS "CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION}")
endif()
if(DEFINED CMAKE_SYSTEM_PROCESSOR)
    message(STATUS "CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

message(STATUS "=== Хостовая платформа (host) ===")
if(DEFINED CMAKE_HOST_WIN32)
    message(STATUS "CMAKE_HOST_WIN32: ${CMAKE_HOST_WIN32}")
endif()
if(DEFINED CMAKE_HOST_APPLE)
    message(STATUS "CMAKE_HOST_APPLE: ${CMAKE_HOST_APPLE}")
endif()
if(DEFINED CMAKE_HOST_UNIX)
    message(STATUS "CMAKE_HOST_UNIX: ${CMAKE_HOST_UNIX}")
endif()
if(DEFINED CMAKE_HOST_SYSTEM_NAME)
    message(STATUS "CMAKE_HOST_SYSTEM_NAME: ${CMAKE_HOST_SYSTEM_NAME}")
endif()
if(DEFINED CMAKE_HOST_SYSTEM_VERSION)
    message(STATUS "CMAKE_HOST_SYSTEM_VERSION: ${CMAKE_HOST_SYSTEM_VERSION}")
endif()
if(DEFINED CMAKE_HOST_SYSTEM_PROCESSOR)
    message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR: ${CMAKE_HOST_SYSTEM_PROCESSOR}")
endif()

message(STATUS "=== Прочие важные переменные ===")
if(DEFINED CMAKE_CROSSCOMPILING)
    message(STATUS "CMAKE_CROSSCOMPILING: ${CMAKE_CROSSCOMPILING}")
endif()
if(DEFINED MSVC)
    message(STATUS "MSVC: ${MSVC} (компилятор Microsoft Visual C++)")
endif()
if(DEFINED CMAKE_CXX_COMPILER_ID)
    message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
endif()
```

## **Правильные примеры проверки:**

```cmake
# Проверка целевой платформы
if(WIN32)
    # Целевая ОС - Windows
    add_definitions(-DTARGET_WINDOWS)
endif()

if(APPLE)
    # Целевая ОС - Apple (macOS, iOS и т.д.)
    add_definitions(-DTARGET_APPLE)
endif()

if(UNIX AND NOT APPLE)
    # Целевая ОС - UNIX, но не Apple (скорее всего Linux)
    add_definitions(-DTARGET_LINUX)
endif()

# Проверка хостовой платформы
if(CMAKE_HOST_WIN32)
    message(STATUS "CMake запущен на Windows")
endif()

if(CMAKE_HOST_APPLE)
    message(STATUS "CMake запущен на macOS")
endif()

if(CMAKE_HOST_UNIX AND NOT CMAKE_HOST_APPLE)
    message(STATUS "CMake запущен на UNIX-системе (не Apple)")
endif()
```

## **Кросс-компиляция:**

```cmake
# Проверка, компилируем ли мы для другой платформы
if(CMAKE_CROSSCOMPILING)
    message(STATUS "Кросс-компиляция!")
    message(STATUS "Хост: ${CMAKE_HOST_SYSTEM_NAME}")
    message(STATUS "Цель: ${CMAKE_SYSTEM_NAME}")
endif()

# Пример: проверка, что мы компилируем на Windows для Linux
if(CMAKE_HOST_WIN32 AND CMAKE_SYSTEM_NAME STREQUAL "Linux")
    message(STATUS "Кросс-компиляция с Windows на Linux")
endif()
```


# Вопрос

> В твоём списке отсутствует и хостовая и целевая платформа MINGW.
> Выведи полные списки хостовых и целевых платформ CMake, и укажи, где их искать в онлайн документации CMake.

Вы абсолютно правы, в CMake есть специальные переменные для определения MinGW. Вот полные списки:

## **1. Целевая платформа (Target Platform)**

### **Булевы переменные** (автоматически устанавливаются CMake):
```cmake
WIN32      # Целевая ОС Windows (включая MSVC, MinGW, Cygwin)
APPLE      # Целевая ОС Apple (macOS, iOS, tvOS, watchOS)
UNIX       # Целевая ОС UNIX-подобная (Linux, macOS, BSD, Android, QNX, iOS, tvOS, watchOS)
ANDROID    # Целевая ОС Android
IOS        # Целевая ОС iOS
CYGWIN     # Целевая ОС Cygwin
MSYS       # Целевая ОС MSYS2/MSYS
MINGW      # Компилятор MinGW (Windows)
MSVC       # Компилятор Microsoft Visual C++
```

### **Строковые переменные**:
```cmake
CMAKE_SYSTEM_NAME        # Имя целевой ОС (Windows, Linux, Darwin, iOS, Android и т.д.)
CMAKE_SYSTEM_VERSION     # Версия целевой ОС
CMAKE_SYSTEM_PROCESSOR   # Целевая архитектура процессора (x86_64, ARM, aarch64 и т.д.)
```

## **2. Хостовая платформа (Host Platform)**

### **Булевы переменные**:
```cmake
CMAKE_HOST_WIN32    # Хостовая ОС Windows
CMAKE_HOST_APPLE    # Хостовая ОС Apple
CMAKE_HOST_UNIX     # Хостовая ОС UNIX-подобная
CMAKE_HOST_SYSTEM_NAME    # Имя хостовой ОС (строка)
CMAKE_HOST_SYSTEM_VERSION # Версия хостовой ОС
CMAKE_HOST_SYSTEM_PROCESSOR # Архитектура хоста
```

## **3. Полный скрипт для вывода всех переменных**

```cmake
cmake_minimum_required(VERSION 3.10)
project(PlatformDetector)

message("")
message("=== Целевая платформа (target) ===")
message("WIN32: ${WIN32}")
message("APPLE: ${APPLE}")
message("UNIX: ${UNIX}")
message("ANDROID: ${ANDROID}")
message("IOS: ${IOS}")
message("CYGWIN: ${CYGWIN}")
message("MSYS: ${MSYS}")
message("MINGW: ${MINGW}")
message("MSVC: ${MSVC}")
message("CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
message("CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION}")
message("CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")

message("")
message("=== Хостовая платформа (host) ===")
message("CMAKE_HOST_WIN32: ${CMAKE_HOST_WIN32}")
message("CMAKE_HOST_APPLE: ${CMAKE_HOST_APPLE}")
message("CMAKE_HOST_UNIX: ${CMAKE_HOST_UNIX}")
message("CMAKE_HOST_SYSTEM_NAME: ${CMAKE_HOST_SYSTEM_NAME}")
message("CMAKE_HOST_SYSTEM_VERSION: ${CMAKE_HOST_SYSTEM_VERSION}")
message("CMAKE_HOST_SYSTEM_PROCESSOR: ${CMAKE_HOST_SYSTEM_PROCESSOR}")

message("")
message("=== Состояние компиляции ===")
message("CMAKE_CROSSCOMPILING: ${CMAKE_CROSSCOMPILING}")
message("CMAKE_C_COMPILER_ID: ${CMAKE_C_COMPILER_ID}")
message("CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
message("CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message("CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")

message("")
message("=== Специальные переменные для Windows ===")
message("CMAKE_CL_64: ${CMAKE_CL_64}")  # Для MSVC, если используется 64-bit
message("WIN32 (старое поведение): ${WIN32}")
```

## **4. Где искать в документации**

### **Официальная документация CMake:**

1. **Variables that Provide Information** - основной раздел:
   - https://cmake.org/cmake/help/latest/manual/cmake-variables.7.html#variables-that-provide-information

2. **Системно-специфичные переменные**:
   - `WIN32`, `APPLE`, `UNIX`: https://cmake.org/cmake/help/latest/variable/WIN32.html
   - `MINGW`: https://cmake.org/cmake/help/latest/variable/MINGW.html
   - `MSYS`: https://cmake.org/cmake/help/latest/variable/MSYS.html
   - `CYGWIN`: https://cmake.org/cmake/help/latest/variable/CYGWIN.html

3. **Хост-специфичные переменные**:
   - `CMAKE_HOST_SYSTEM_NAME`: https://cmake.org/cmake/help/latest/variable/CMAKE_HOST_SYSTEM_NAME.html
   - `CMAKE_HOST_WIN32`: https://cmake.org/cmake/help/latest/variable/CMAKE_HOST_WIN32.html

4. **Переменные компилятора**:
   - `CMAKE_C_COMPILER_ID`, `CMAKE_CXX_COMPILER_ID`: https://cmake.org/cmake/help/latest/variable/CMAKE_LANG_COMPILER_ID.html

## **5. Практическое использование для MinGW**

```cmake
if(WIN32)
    if(MINGW)
        message(STATUS "Целевая платформа: Windows (MinGW)")
        # MinGW-специфичные настройки
        add_definitions(-DMINGW)
    elseif(MSVC)
        message(STATUS "Целевая платформа: Windows (MSVC)")
        # MSVC-специфичные настройки
        add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    elseif(CYGWIN)
        message(STATUS "Целевая платформа: Cygwin")
    endif()
endif()

# Проверка хостовой платформы
if(CMAKE_HOST_WIN32)
    if(CMAKE_HOST_SYSTEM_NAME MATCHES "MINGW" OR CMAKE_HOST_SYSTEM_NAME MATCHES "MSYS")
        message(STATUS "CMake запущен в MinGW/MSYS окружении")
    endif()
endif()
```

## **6. Определение конкретных MinGW/MSYS окружений**

```cmake
# Более точное определение окружения
if(MINGW)
    # Проверка версии MinGW
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        execute_process(
            COMMAND ${CMAKE_CXX_COMPILER} -dumpversion
            OUTPUT_VARIABLE MINGW_VERSION
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        message(STATUS "MinGW GCC version: ${MINGW_VERSION}")
    endif()
    
    # Определение архитектуры
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
        set(MINGW_ARCH "x86_64")
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "i[3456]86")
        set(MINGW_ARCH "i686")
    endif()
endif()

if(MSYS)
    message(STATUS "Сборка в MSYS окружении")
    # MSYS-specific settings
endif()
```

**Важное замечание**: `MINGW` устанавливается в TRUE, когда используется компилятор GNU на Windows, но НЕ в Cygwin или MSYS. Для Cygwin и MSYS есть отдельные переменные `CYGWIN` и `MSYS`.

Документацию также можно найти локально в CMake, используя команду:
```bash
cmake --help-variable-list | grep -i "host\|win\|unix\|apple\|mingw"
```


# Вопрос

> Как определить архитектуру как хостового процессора, так и целевого - arm, arm64, x86, x64, riscv32, riscv64, s390x, wasm32 и тп?


Для определения архитектуры процессора в CMake используются переменные `CMAKE_SYSTEM_PROCESSOR` (целевая) и `CMAKE_HOST_SYSTEM_PROCESSOR` (хостовая). Вот полный список способов:

## **1. Основные переменные для архитектуры**

```cmake
# Целевая архитектура (target)
CMAKE_SYSTEM_PROCESSOR

# Хостовая архитектура (build host)
CMAKE_HOST_SYSTEM_PROCESSOR

# Размер указателя (для различения 32/64 бит)
CMAKE_SIZEOF_VOID_P  # 4 = 32-bit, 8 = 64-bit
```

## **2. Полный скрипт для определения архитектуры**

```cmake
cmake_minimum_required(VERSION 3.18)
project(ArchitectureDetector)

# Функция для нормализации названий архитектур
function(detect_architecture processor_var result_var)
    string(TOLOWER "${${processor_var}}" processor_lower)
    
    if(processor_lower MATCHES "^(x86_64|amd64|x64|em64t|intel64)$")
        set(${result_var} "x64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(i[3456]86|x86|i86pc|ia32)$")
        set(${result_var} "x86" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(aarch64|arm64|armv8|armv8-a|armv9)$")
        set(${result_var} "arm64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(armv7|armv7l|armv7-a|arm)$")
        set(${result_var} "arm" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(riscv64|riscv64gc)$")
        set(${result_var} "riscv64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(riscv32)$")
        set(${result_var} "riscv32" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(s390x)$")
        set(${result_var} "s390x" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(ppc64le|powerpc64le)$")
        set(${result_var} "ppc64le" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(ppc64|powerpc64)$")
        set(${result_var} "ppc64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(ppc|powerpc)$")
        set(${result_var} "ppc" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(mips64)$")
        set(${result_var} "mips64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(mips)$")
        set(${result_var} "mips" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(wasm32)$")
        set(${result_var} "wasm32" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(wasm64)$")
        set(${result_var} "wasm64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(loongarch64)$")
        set(${result_var} "loongarch64" PARENT_SCOPE)
    elseif(processor_lower MATCHES "^(sparc64)$")
        set(${result_var} "sparc64" PARENT_SCOPE)
    else()
        set(${result_var} "${${processor_var}}" PARENT_SCOPE)
    endif()
endfunction()

# Определяем хост и целевую архитектуру
detect_architecture(CMAKE_HOST_SYSTEM_PROCESSOR HOST_ARCH)
detect_architecture(CMAKE_SYSTEM_PROCESSOR TARGET_ARCH)

message(STATUS "=== Архитектура хоста ===")
message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR: ${CMAKE_HOST_SYSTEM_PROCESSOR}")
message(STATUS "Нормализованная: ${HOST_ARCH}")

message(STATUS "")
message(STATUS "=== Целевая архитектура ===")
message(STATUS "CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "Нормализованная: ${TARGET_ARCH}")

message(STATUS "")
message(STATUS "=== Размер указателя ===")
message(STATUS "CMAKE_SIZEOF_VOID_P: ${CMAKE_SIZEOF_VOID_P}")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "Разрядность: 64-битная")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    message(STATUS "Разрядность: 32-битная")
endif()

message(STATUS "")
message(STATUS "=== Проверки архитектур ===")
# Устанавливаем булевы переменные для удобства
set(ARCH_X86 OFF)
set(ARCH_X64 OFF)
set(ARCH_ARM OFF)
set(ARCH_ARM64 OFF)
set(ARCH_RISCV32 OFF)
set(ARCH_RISCV64 OFF)
set(ARCH_S390X OFF)
set(ARCH_WASM32 OFF)
set(ARCH_WASM64 OFF)

if(TARGET_ARCH STREQUAL "x86")
    set(ARCH_X86 ON)
    message(STATUS "Целевая архитектура: x86 (32-bit)")
elseif(TARGET_ARCH STREQUAL "x64")
    set(ARCH_X64 ON)
    message(STATUS "Целевая архитектура: x64 (64-bit)")
elseif(TARGET_ARCH STREQUAL "arm")
    set(ARCH_ARM ON)
    message(STATUS "Целевая архитектура: ARM (32-bit)")
elseif(TARGET_ARCH STREQUAL "arm64")
    set(ARCH_ARM64 ON)
    message(STATUS "Целевая архитектура: ARM64")
elseif(TARGET_ARCH STREQUAL "riscv32")
    set(ARCH_RISCV32 ON)
    message(STATUS "Целевая архитектура: RISC-V 32-bit")
elseif(TARGET_ARCH STREQUAL "riscv64")
    set(ARCH_RISCV64 ON)
    message(STATUS "Целевая архитектура: RISC-V 64-bit")
elseif(TARGET_ARCH STREQUAL "s390x")
    set(ARCH_S390X ON)
    message(STATUS "Целевая архитектура: IBM S/390 64-bit")
elseif(TARGET_ARCH STREQUAL "wasm32")
    set(ARCH_WASM32 ON)
    message(STATUS "Целевая архитектура: WebAssembly 32-bit")
elseif(TARGET_ARCH STREQUAL "wasm64")
    set(ARCH_WASM64 ON)
    message(STATUS "Целевая архитектура: WebAssembly 64-bit")
endif()
```

## **3. Дополнительные способы определения**

### **Проверка через компилятор**
```cmake
# Для кросс-компиляции или точного определения
include(CheckTypeSize)
check_type_size("void*" SIZEOF_VOID_P)
message(STATUS "Размер указателя через check_type_size: ${SIZEOF_VOID_P}")

# Использование try_compile для определения возможностей
try_compile(
    HAVE_SSE2
    ${CMAKE_BINARY_DIR}/temp
    SOURCES ${CMAKE_SOURCE_DIR}/check_sse2.cpp
    COMPILE_DEFINITIONS -msse2
)
```

### **Файл check_sse2.cpp**
```cpp
// Простой файл для проверки возможностей процессора
#if defined(__SSE2__)
int main() { return 0; }
#else
#error "SSE2 not supported"
#endif
```

## **4. Определение эндрианности (byte order)**

```cmake
# Проверка эндрианности (big/little endian)
include(TestBigEndian)
test_big_endian(IS_BIG_ENDIAN)

if(IS_BIG_ENDIAN)
    message(STATUS "Система с big-endian порядком байт (PowerPC, SPARC, s390x)")
    add_definitions(-DBIG_ENDIAN=1)
else()
    message(STATUS "Система с little-endian порядком байт (x86, x64, ARM)")
    add_definitions(-DLITTLE_ENDIAN=1)
endif()
```

## **5. Кросс-компиляция и конкретные архитектуры**

```cmake
# Для кросс-компиляции можно явно указать архитектуру
set(CMAKE_SYSTEM_PROCESSOR "armv7-a" CACHE STRING "Целевая архитектура процессора")

# Или через toolchain файл:
# В toolchain-arm.cmake:
# set(CMAKE_SYSTEM_PROCESSOR "arm")
# set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
```

## **6. CMakePresets.json для разных архитектур**

```json
{
  "version": 3,
  "configurePresets": [
    {
      "name": "linux-x64",
      "hidden": true,
      "generator": "Ninja",
      "binaryDir": "${sourceDir}/build/${presetName}",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Release"
      }
    },
    {
      "name": "linux-arm64",
      "inherits": "linux-x64",
      "architecture": {
        "value": "arm64",
        "strategy": "external"
      },
      "cacheVariables": {
        "CMAKE_SYSTEM_PROCESSOR": "aarch64",
        "CMAKE_C_COMPILER": "aarch64-linux-gnu-gcc"
      }
    },
    {
      "name": "windows-x64",
      "generator": "Visual Studio 17 2022",
      "architecture": {
        "value": "x64",
        "strategy": "external"
      }
    }
  ]
}
```

## **7. Современный CMake (3.20+) с CMAKE_OSX_ARCHITECTURES**

```cmake
# Для macOS Universal Binaries
if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Build architectures for OSX")
endif()

# Проверка поддержки AVX, AVX2 и т.д.
if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86" OR CMAKE_SYSTEM_PROCESSOR MATCHES "amd64")
    check_cxx_compiler_flag("-mavx" COMPILER_SUPPORTS_AVX)
    check_cxx_compiler_flag("-mavx2" COMPILER_SUPPORTS_AVX2)
    if(COMPILER_SUPPORTS_AVX2)
        add_compile_options(-mavx2)
    elseif(COMPILER_SUPPORTS_AVX)
        add_compile_options(-mavx)
    endif()
endif()
```

## **8. Где смотреть в документации**

1. **CMAKE_SYSTEM_PROCESSOR**: https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_PROCESSOR.html
2. **CMAKE_HOST_SYSTEM_PROCESSOR**: https://cmake.org/cmake/help/latest/variable/CMAKE_HOST_SYSTEM_PROCESSOR.html
3. **CMAKE_SIZEOF_VOID_P**: https://cmake.org/cmake/help/latest/variable/CMAKE_SIZEOF_VOID_P.html
4. **CheckCXXCompilerFlag**: https://cmake.org/cmake/help/latest/module/CheckCXXCompilerFlag.html
5. **TestBigEndian**: https://cmake.org/cmake/help/latest/module/TestBigEndian.html

**Важно**: Значения `CMAKE_SYSTEM_PROCESSOR` и `CMAKE_HOST_SYSTEM_PROCESSOR` могут отличаться между компиляторами и системами. Например, на Windows x64 это может быть "AMD64", а на Linux - "x86_64". Поэтому всегда лучше нормализовать значения.

