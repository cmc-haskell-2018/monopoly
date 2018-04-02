module Model where

import Graphics.Gloss.Interface.Pure.Game
-- =========================================
-- Модель
-- =========================================

-- | Изображения объектов.

data Images = Images
  { imagePieceRed    :: Picture 
  , imagePieceBlue   :: Picture
  , imagePieceGreen  :: Picture
  , imagePieceYellow :: Picture
  , imagePlayingField :: Picture 
  , imagePayMenu :: Picture
  , imageWinnerWindow :: Picture
  , imageCurrPlayer :: Picture
  , imageCubes :: Picture
  }

-- | Состояние игры
data GameState = GameState
  { players :: [Player] -- Все игроки
  , gamePlayer :: Int   -- Текущий игрок
  , cubes :: Cubes      -- Значения кубиков
  , land :: [Street]    -- Информация о полях
  , typeStep :: Int     -- Тип текущего действия
  , intSeq :: [Int]
  }

-- | Данные об одном игроке
data Player = Player
  { colour :: Int      -- Номер игрока
  --, name :: String
  , money :: Int       -- Баланс
  , property :: [Street]  -- Чем владеет
  , playerCell :: Int     -- На какой клетке поле находится
  , playerPosition :: Point  -- Где на поле нарисована его фишка (координаты)
  }

-- | Информация о клетке поля
data Street = Street
  { name :: String  -- Название
  , price :: Int    -- Стоимость для покупки
  , isRent :: Bool   -- Куплена ли кем-то
  , priceRent :: Int  -- Стоимость аренды
  , owner :: Int      -- Кто владеет
  }

-- | Значения кубиков
data Cubes = Cubes
  { firstCube :: Int
  , secondCube :: Int
  }

