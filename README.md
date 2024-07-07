# UMBA CMake

  - [Замечания по использованию внешних библиотек](#user-content-замечания-по-использованию-внешних-библиотек)
    - [Boost](#user-content-boost)
      - [Boost в режиме header-only](#user-content-boost-в-режиме-header-only)
      - [Настройка системы для использования Boost в режиме header-only](#user-content-настройка-системы-для-использования-boost-в-режиме-header-only)
    - [Справка по использованию подмодулей](#user-content-справка-по-использованию-подмодулей)


Добавление в проект: `git submodule add https://github.com/al-martyn1/.cmake.git`


# Замечания по использованию внешних библиотек

## Boost

Для использования библиотек `Boost` надо перед подключением данного файла включить использование `Boost`:

```cmake
set(UMBA_USE_BOOST       ON)
```

### Boost в режиме header-only

При включении использования библиотеки `Boost` по умолчанию включается режим
использования header-only библиотек.

Для указания месторасположения библиотеки Boost следует задать переменную `Boost_INCLUDE_DIR`:
```cmake
set(Boost_INCLUDE_DIR "Path/to/boost")
```

Можно один раз задать в системе переменную окружения `BOOST_ROOT`, и если 
переменная `Boost_INCLUDE_DIR` явно не задаётся, то её значение будет получено из
переменной окружения `BOOST_ROOT`.


### Настройка системы для использования Boost в режиме header-only

Для использования библиотек `Boost` в режиме header-only требуется скачать 
архив оффициального релиза - [boost_1_85_0.zip](https://archives.boost.io/release/1.85.0/source/boost_1_85_0.zip)
(или в любом другом формате архива [отсюда](https://www.boost.org/users/history/version_1_85_0.html)).

Скачанный архив следует разархивировать, например, в каталог `D:\boost_1_85_0`.

После этого следует установить переменную окружения `BOOST_ROOT`:
```
BOOST_ROOT=D:\boost_1_85_0
```




```cmake
set(UMBA_USE_BOOST       ON)
set(UMBA_USE_BOOST_FETCH ON)
set(UMBA_STATIC_RUNTIME  ON)
set(UMBA_BOOST_CMAKE_FETCH_URL D:/boost-1.84.0.tar.xz) # https://github.com/boostorg/boost/releases/download/boost-1.84.0/boost-1.84.0.tar.xz #URL_MD5 893b5203b862eb9bbd08553e24ff146a
```



## Справка по использованию подмодулей

Pro Git : [Инструменты Git - Подмодули](https://git-scm.com/book/ru/v2/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D1%8B-Git-%D0%9F%D0%BE%D0%B4%D0%BC%D0%BE%D0%B4%D1%83%D0%BB%D0%B8)


При клонировании проекта надо выполнить:
```
# для инициализации локального конфигурационного файла
git submodule init
# для получения всех данных этого проекта и извлечения соответствующего коммита, указанного в основном проекте.
git submodule update 
```

Для автоматической инициализации и подтягивания подмодулей при клонировании проекта можно выполнить:
```
git clone --recurse-submodules YOU_PROJECT_ORIGIN
```

При обновлении существующего проекта до версии с подмодулями выполняем:
```
git submodule update --init
# или
git submodule update --init --recursive
```

Обновляем проект с подмодулями так:
```
git submodule update --remote
# или
git submodule update --recursive --remote
# или
git submodule update --init --recursive --remote --merge
```



