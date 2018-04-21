module Model where

import Graphics.Gloss.Interface.Pure.Game
-- =========================================
-- Модель
-- =========================================

-- | Изображения объектов.

data Images = Images
  { imageStartMenu :: Picture
  , imagesPiece :: [Picture]
  , imagePlayingField :: Picture
  , imagePayMenu :: Picture
  , imageWinnerWindow :: Picture
  , imageCurrPlayer :: Picture
  , imageMoveAcadem :: Picture
  , imagesAcademLeft :: [Picture]
  , imagePledgeMenu :: Picture
  , imagesCube :: [Picture]
  , imagePledgeButton :: Picture
  }

-- | Состояние игры
data GameState = GameState
  { players :: [Player] -- Все игроки
  , gamePlayer :: Int   -- Текущий игрок
  , cubes :: Cubes      -- Значения кубиков
  , land :: [Street]    -- Информация о полях
  , isStartMenu :: Bool
  , typeStep :: Int     -- Тип текущего действия
  , intSeq :: [Int]
  , countPlayers :: Int
  , isIncorrectColours :: Bool
  , isMoveToAcadem :: Bool
  , menuPledgeState :: MenuPledgeState
  , isPledgeMenu :: Bool
  }

data MenuPledgeState = MenuPledgeState
  { numCurrentStreet :: Int
  }

-- | Данные об одном игроке
data Player = Player
  { number :: Int
  , colour :: Int      -- Номер игрока
  --, name :: String
  , money :: Int       -- Баланс
  , property :: [Street]  -- Чем владеет
  , playerCell :: Int     -- На какой клетке поле находится
  , playerPosition :: Point  -- Где на поле нарисована его фишка (координаты)
  , inAcadem :: Bool -- Находится ли в академе
  , missSteps :: Int -- Сколько ходов осталось пропустить
  }

-- | Информация о клетке поля
data Street = Street
  { name :: String  -- Название
  , price :: Int    -- Стоимость для покупки
  , isRent :: Bool   -- Куплена ли кем-то
  , priceRent :: Int  -- Стоимость аренды
  , owner :: Int      -- Кто владеет
  , isPledge :: Bool
  }

-- | Значения кубиков
data Cubes = Cubes
  { firstCube :: Int
  , secondCube :: Int
  }

getLand :: [Street]
getLand =
    [ Street
      { name = "start" --"Старт"
      , price = 0
      , isRent = True     -- Для специальных полей, которые нельзя купить - всегда True
      , priceRent = 0
      , owner = 6         -- Для специальных  полей - фиктивный седьмой игрок
      , isPledge = False
      }
    , Street
      { name = "ski kvant" --"СКИ Квантовая информатика"
      , price = 60
      , priceRent = 6
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "kazna" --"Общественная казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "ski parall" --"СКИ Параллельные вычисления"
      , price = 60
      , priceRent = 7
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Налог" -- Смотреть описание для "Сверхналога"
      , priceRent = 200
      , price = 0
      , owner = 6
      , isRent = True
      , isPledge = False
      }
    , Street 
      { name = "mz1" --"Машзал 1"
      , price = 200
      , priceRent = 20
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "sp pdc" --"СП ПЦД"
      , price = 100
      , priceRent = 12
      , isRent = False
      , owner = 6
      }
    , Street 
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "sp udis" --"СП УДИС"
      , price = 100
      , priceRent = 10
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "sp corr" --"СП Корректность программ"
      , price = 120
      , priceRent = 14
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "Академ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "MatKib dmmk" --"МатКиб ДММК"
      , price = 140
      , priceRent = 15
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "Poteryashki"
      , price = 150
      , priceRent = 15
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "MatKib dfca" --"МатКиб ДФСА"
      , price = 140
      , priceRent = 14
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "MatKib diskr" --"Маткиб Дискретный анализ"
      , price = 160
      , priceRent = 18
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "mz2" --"Машзал 2"
      , price = 200
      , priceRent = 25
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street 
      { name = "io morozov" --"ИО Морозов"
      , price = 180
      , priceRent = 20
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Общественная казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "io novikova" --"ИО Новикова"
      , price = 180
      , priceRent = 19
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "io denisov" --"ИО Денисов"
      , price = 200
      , priceRent = 23
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Бесплатная курилка"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "matstat teor riskov" --"МАТСТАТ Теория рисков"
      , price = 220
      , priceRent = 22
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "matstat dgmc" --"МАТСТАТ ДГМС"
      , price = 220
      , priceRent = 24
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "matstat motvi" --"МАТСТАТ МОТВЫ"
      , price = 240
      , priceRent = 25
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "mz3" --"Машзал 3"
      , price = 200
      , priceRent = 22
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "asvk lbis" --"АСВК ЛБИС"
      , price = 260
      , priceRent = 28
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "asvk lvk" --"АСВК ЛВК"
      , price = 260
      , priceRent = 29
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "technosphera" --"Техносфера"
      , price = 150
      , priceRent = 16
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "asvk medialab" --"АСВК Медиалаб"
      , price = 280
      , priceRent = 30
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Отправляйся в академ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "aya paradigma" --"АЯ Парадигмы программирования"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "aya comp ling" --"АЯ Компьютерная лингвистика"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Общественая казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "aya II" --"АЯ Искусственный интеллект"
      , price = 320
      , priceRent = 32
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "mz4" --"Машзал 4"
      , price = 200
      , priceRent = 21
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Шанс"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "mmp mat" --"ММП МАТ"
      , price = 350
      , priceRent = 37
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    , Street
      { name = "Сверхналог"
      , priceRent = 100
      , price = 0
      , owner = 6 -- По алгоритму работы никто не сможет купить, потому что isRent = True
      , isRent = True -- Но при этом все будут платить мнимому 5ому игроку 100$
      , isPledge = False
      }
    , Street
      { name = "mmp bmmo" --"ММП БММО"
      , price = 400
      , priceRent = 40
      , isRent = False
      , owner = 6
      , isPledge = False
      }
    ]
