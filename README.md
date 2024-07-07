# UMBA CMake

Справка: [Инструменты Git - Подмодули](https://git-scm.com/book/ru/v2/%D0%98%D0%BD%D1%81%D1%82%D1%80%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D1%8B-Git-%D0%9F%D0%BE%D0%B4%D0%BC%D0%BE%D0%B4%D1%83%D0%BB%D0%B8)

Добавление в проект: `git submodule add https://github.com/al-martyn1/.cmake.git`

При клонировании проекта надо выполнить:
```
# для инициализации локального конфигурационного файла
git submodule init
# для получения всех данных этого проекта и извлечения соответствующего коммита, указанного в основном проекте.
git submodule update 
```

Для автоматической инициализации и подтягивания сабмодулей при клонировании проекта можно выполнить:
```
git clone --recurse-submodules YOU_PROJECT_ORIGIN
```

При обновлении существующего проекта до версии с сабмодулями выполняем:
```
git submodule update --init
# или
git submodule update --init --recursive
```

Обновляем так:
```
git submodule update --remote
```

