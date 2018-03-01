# monopoly

[![Build Status](https://travis-ci.org/cmc-haskell-2018/monopoly.svg?branch=master)](https://travis-ci.org/cmc-haskell-2018/monopoly)

Настольная игра «Монополия».

## Сборка и запуск

Соберите проект при помощи [утилиты Stack](https://www.haskellstack.org):

```
stack setup
stack build
```

Собрать и запустить проект можно при помощи команды

```
stack build && stack exec monopoly
```

Запустить тесты можно при помощи команды

```
stack test
```

Чтобы запустить интепретатор GHCi и автоматически подгрузить все модули проекта, используйте команду

```
stack ghci
```

