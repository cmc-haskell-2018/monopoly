module Const where

-- | Некоторые константы для игры

-- Кол-во полей
fieldsNumber :: Int
fieldsNumber = 40

-- Кол-во карточек Шанс (начиная с 0)
сhanceCardsCount :: Int
сhanceCardsCount = 4

-- Состояние игры, в котором игрок делает ход
stepGo :: Int
stepGo = 0

-- Состояние игры, в котором игрок совершает покупку
stepPay :: Int
stepPay = 1

-- Состояние игры, в котором происходит аукцион для следующих игроков
stepAuction :: Int
stepAuction = 2

-- Состояние игры, к котором показываем название карточки Шанс
stepShowChanceCard :: Int
stepShowChanceCard = 3

-- Состояние игры, к котором показываем карточку "анти академ"
stepShowAntiPrisonCard :: Int
stepShowAntiPrisonCard = 4
