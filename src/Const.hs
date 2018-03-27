module Const where

-- | Некоторые константы для игры

-- Кол-во игроков
playersNumber :: Int
playersNumber = 4

-- Кол-во полей
fieldsNumber :: Int
fieldsNumber = 40

-- Состояние игры, в котором игрок делает ход
stepGo :: Int
stepGo = 0

-- Состояние игры, в котором игрок совершает покупку
stepPay :: Int
stepPay = 1
