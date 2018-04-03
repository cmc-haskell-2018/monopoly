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
  , imageCubesOne :: Picture
  , imageCubesTwo :: Picture
  , imageCubesThree :: Picture
  , imageCubesFour :: Picture
  , imageCubesFive :: Picture
  , imageCubesSix :: Picture
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

getLand :: [Street]
getLand =
    [ Street
      { name ="Старт"
      , price = 0 
      , isRent = True     -- Для специальных полей, которые нельзя купить - всегда True
      , priceRent = 0
      , owner = 4         -- Для специальных  полей - фиктивный пятый игрок
      }
    , Street
      { name = "СКИ Квантовая информатика"
      , price = 60
      , priceRent = 6
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Общественная казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street 
      { name = "СКИ Параллельные вычисления"
      , price = 60
      , priceRent = 7
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Налог" -- Смотреть описание для "Сверхналога"
      , priceRent = 200
      , price = 0
      , owner = 4
      , isRent = True
      }
    , Street 
      { name = "Машзал 1"
      , price = 200
      , priceRent = 20
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "СП ПЦД"
      , price = 100
      , priceRent = 12
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street 
      { name = "СП УДИС"
      , price = 100
      , priceRent = 10
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "СП Корректность программ"
      , price = 120
      , priceRent = 14
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Академ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "МатКиб ДММК"
      , price = 140
      , priceRent = 15
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Потеряшки"
      , price = 150
      , priceRent = 15
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "МатКиб ДФСА"
      , price = 140
      , priceRent = 14
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Маткиб Дискретный анализ"
      , price = 160
      , priceRent = 18
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Машзал 2"
      , price = 200
      , priceRent = 25
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "ИО Морозов"
      , price = 180
      , priceRent = 20
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Общественная казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "ИО Новикова"
      , price = 180
      , priceRent = 19
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "ИО Денисов"
      , price = 200
      , priceRent = 23
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Бесплатная курилка"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "МАТСТАТ Теория рисков"
      , price = 220
      , priceRent = 22
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "МАТСТАТ ДГМС"
      , price = 220
      , priceRent = 24
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "МАТСТАТ МОТВЫ"
      , price = 240
      , priceRent = 25
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Машзал 3"
      , price = 200
      , priceRent = 22
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "АСВК ЛБИС"
      , price = 260
      , priceRent = 28
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "АСВК ЛВК"
      , price = 260
      , priceRent = 29
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Техносфера"
      , price = 150
      , priceRent = 16
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "АСВК Медиалаб"
      , price = 280
      , priceRent = 30
      , isRent = False
      , owner = 0
      }
    , Street 
      { name = "Отправляйся в академ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street 
      { name = "АЯ Парадигмы программирования"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "АЯ Компьютерная лингвистика"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Общественая казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "АЯ Искусственный интеллект"
      , price = 320
      , priceRent = 32
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Машзал 4"
      , price = 200
      , priceRent = 21
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
      }
    , Street
      { name = "ММП МАТ"
      , price = 350
      , priceRent = 37
      , isRent = False
      , owner = 0
      }
    , Street
      { name = "Сверхналог"
      , priceRent = 100
      , price = 0
      , owner = 4 -- По алгоритму работы никто не сможет купить, потому что isRent = True
      , isRent = True -- Но при этом все будут платить мнимому 5ому игроку 100$
      }
    , Street
      { name = "ММП БММО"
      , price = 400
      , priceRent = 40
      , isRent = False
      , owner = 0
      }
    ]

