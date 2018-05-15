module Model where

import Graphics.Gloss.Interface.Pure.Game
-- =========================================
-- Модель
-- =========================================

-- | Изображения объектов.

data Images = Images
  { imageStartMenu :: Picture
  , imagePause :: Picture
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
  , imageEmpty :: Picture
  , imagesFieldYellow :: [Picture]
  , imageAuction :: Picture
  , imageQuestion :: Picture
  , imagesFieldGreen :: [Picture]
  , imageHelp1 :: Picture
  , imageHelp2 :: Picture
  --, imageFieldOwner :: Picture
  , imageCurField :: Picture
  , imageShowStreets :: Picture
  , imageInfoAboutStreets :: Picture
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
  , chanceCards :: [ChanceCard]
  , intSeqChanceCards :: [Int] 
  , currentChanceCard :: Int
  , countPlayers :: Int
  , isIncorrectColours :: Bool
  , isMoveToAcadem :: Bool
  , menuPledgeState :: MenuPledgeState
  , isPledgeMenu :: Bool
  , isAuction :: Bool
  , prevTypeStep :: Int
  , isPauseEnd :: Bool
  , isShowStreets :: Bool
  , streetsToShow :: [Street]
  , wantToRestart :: Bool
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
  , playerCell :: Int     -- На какой клетке поле находится
  , playerPosition :: Point  -- Где на поле нарисована его фишка (координаты)
  , inAcadem :: Bool -- Находится ли в academе
  , missSteps :: Int -- Сколько ходов осталось пропустить
  , hasAntiAcademCard :: Bool
  , noProperty :: Bool -- Есть ли имущество
  , auctionPrice :: Int
  }

-- | Информация о клетке поля
data Street = Street
  { name :: String  -- Название
  , price :: Int    -- Стоимость для покупки
  , isRent :: Bool   -- Куплена ли кем-то
  , priceRent :: Int  -- Стоимость аренды
  , owner :: Int      -- Кто владеет
  , isPledge :: Bool
  , streetId :: Int
  , streetGroup :: Int
  , amGroup :: Int
  }

-- | Значения кубиков
data Cubes = Cubes
  { firstCube :: Int
  , secondCube :: Int
  }

data ChanceCard = ChanceCard
  { title :: String
  , balanceChange :: Int
  , newPosition :: Int -- Куда переместиться относительно начала карты (если -1, то никуда)
  }

getChanceCards :: [ChanceCard]
getChanceCards = 
    [ ChanceCard -- id = 0
      { title = "Lucky boy! Get 200$"
      , balanceChange = 200
      , newPosition = -1
      }
    , ChanceCard -- id = 1
      { title = "Sorry, your 200$ have been disappeared :("
      , balanceChange = -200
      , newPosition = -1
      }
    , ChanceCard -- id = 2
      { title = "You have been arested! Go to the academ"
      , balanceChange = 0
      , newPosition = 10
      }
    , ChanceCard -- id = 3
      { title = "Go to Start!" -- возможно тут надо сделать -200
      , balanceChange = 0
      , newPosition = 0
      }
    , ChanceCard -- id = 4
      { title = "Get antiacadem card!"
      , balanceChange = 0
      , newPosition = -1
      }
    ]

getLand :: [Street]
getLand =
    [ Street -- id = 0
      { name = "start" --"Старт"
      , price = 0
      , isRent = True     -- Для специальных полей, которые нельзя купить - всегда True
      , priceRent = 0
      , owner = 6         -- Для специальных  полей - фиктивный седьмой игрок
      , isPledge = False
      , streetId = 0
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 1
      { name = "ski kvant" --"СКИ Квантовая информатика"
      , price = 60
      , priceRent = 6
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 1
      , streetGroup = 1
      , amGroup = 2
      }
    , Street -- id = 2 
      { name = "kazna" --"Общественная казна"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 2
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 3 
      { name = "ski parall" --"СКИ Параллельные вычисления"
      , price = 60
      , priceRent = 7
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 3
      , streetGroup = 1
      , amGroup = 2
      }
    , Street -- id = 4
      { name = "nalog" -- Смотреть описание для "Сверхnalogа"
      , priceRent = 200
      , price = 0
      , owner = 6
      , isRent = True
      , isPledge = False
      , streetId = 4
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 5 
      { name = "mz1" --"Машзал 1"
      , price = 200
      , priceRent = 20
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 5
      , streetGroup = 2
      , amGroup = 4
      }
    , Street -- id = 6 
      { name = "sp pdc" --"СП ПЦД"
      , price = 100
      , priceRent = 12
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 6
      , streetGroup = 3
      , amGroup = 3
      }
    , Street -- id = 7 
      { name = "chance"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 7
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 8 
      { name = "sp udis" --"СП УДИС"
      , price = 100
      , priceRent = 10
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 8
      , streetGroup = 3
      , amGroup = 3
      }
    , Street -- id = 9 
      { name = "sp corr" --"СП Корректность программ"
      , price = 120
      , priceRent = 14
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 9
      , streetGroup = 3
      , amGroup = 3
      }
    , Street -- id = 10
      { name = "academ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 10
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 11
      { name = "MatKib dmmk" --"МатКиб ДММК"
      , price = 140
      , priceRent = 15
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 11
      , streetGroup = 4
      , amGroup = 3
      }
    , Street -- id = 12
      { name = "Poteryashki"
      , price = 150
      , priceRent = 15
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 12
      , streetGroup = 5
      , amGroup = 2
      }
    , Street -- id = 13
      { name = "MatKib dfca" --"МатКиб ДФСА"
      , price = 140
      , priceRent = 14
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 13
      , streetGroup = 4
      , amGroup = 3
      }
    , Street -- id = 14
      { name = "MatKib diskr" --"Маткиб Дискретный анализ"
      , price = 160
      , priceRent = 18
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 14
      , streetGroup = 4
      , amGroup = 3
      }
    , Street -- id = 15
      { name = "mz2" --"Машзал 2"
      , price = 200
      , priceRent = 25
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 15
      , streetGroup = 2
      , amGroup = 4
      }
    , Street -- id = 16
      { name = "io morozov" --"ИО Морозов"
      , price = 180
      , priceRent = 20
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 16
      , streetGroup = 6
      , amGroup = 3
      }
    , Street -- id = 17
      { name = "kazna"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 17
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 18
      { name = "io novikova" --"ИО Новикова"
      , price = 180
      , priceRent = 19
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 18
      , streetGroup = 6
      , amGroup = 3
      }
    , Street -- id = 19
      { name = "io denisov" --"ИО Денисов"
      , price = 200
      , priceRent = 23
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 19
      , streetGroup = 6
      , amGroup = 3
      }
    , Street -- id = 20
      { name = "free kurilka"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 20
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 21
      { name = "matstat teor riskov" --"МАТСТАТ Теория рисков"
      , price = 220
      , priceRent = 22
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 21
      , streetGroup = 7
      , amGroup = 3
      }
    , Street -- id = 22
      { name = "chance"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 22
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 23
      { name = "matstat dgmc" --"МАТСТАТ ДГМС"
      , price = 220
      , priceRent = 24
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 23
      , streetGroup = 7
      , amGroup = 3
      }
    , Street -- id = 24
      { name = "matstat motvi" --"МАТСТАТ МОТВЫ"
      , price = 240
      , priceRent = 25
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 24
      , streetGroup = 7
      , amGroup = 3
      }
    , Street -- id = 25
      { name = "mz3" --"Машзал 3"
      , price = 200
      , priceRent = 22
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 25
      , streetGroup = 2
      , amGroup = 4
      }
    , Street -- id = 26
      { name = "asvk lbis" --"АСВК ЛБИС"
      , price = 260
      , priceRent = 28
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 26
      , streetGroup = 8
      , amGroup = 3
      }
    , Street -- id = 27
      { name = "asvk lvk" --"АСВК ЛВК"
      , price = 260
      , priceRent = 29
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 27
      , streetGroup = 8
      , amGroup = 3
      }
    , Street -- id = 28
      { name = "technosphera" --"Техносфера"
      , price = 150
      , priceRent = 16
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 28
      , streetGroup = 5
      , amGroup = 2
      }
    , Street -- id = 29
      { name = "asvk medialab" --"АСВК Медиалаб"
      , price = 280
      , priceRent = 30
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 29
      , streetGroup = 8
      , amGroup = 3
      }
    , Street -- id = 30
      { name = "go to academ"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 30
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 31
      { name = "aya paradigma" --"АЯ Парадигмы программирования"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 31
      , streetGroup = 9
      , amGroup = 3
      }
    , Street -- id = 32
      { name = "aya comp ling" --"АЯ Компьютерная лингвистика"
      , price = 300
      , priceRent = 35
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 32
      , streetGroup = 9
      , amGroup = 3
      }
    , Street -- id = 33
      { name = "kazna"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 33
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 34
      { name = "aya II" --"АЯ Искусственный интеллект"
      , price = 320
      , priceRent = 32
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 34
      , streetGroup = 9
      , amGroup = 3
      }
    , Street -- id = 35
      { name = "mz4" --"Машзал 4"
      , price = 200
      , priceRent = 21
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 35
      , streetGroup = 2
      , amGroup = 4
      }
    , Street -- id = 36
      { name = "chance"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 6
      , isPledge = False
      , streetId = 36
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 37
      { name = "mmp mat" --"ММП МАТ"
      , price = 350
      , priceRent = 37
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 37
      , streetGroup = 10
      , amGroup = 2
      }
    , Street -- id = 38
      { name = "Сверхnalog"
      , priceRent = 100
      , price = 0
      , owner = 6 -- По алгоритму работы никто не сможет купить, потому что isRent = True
      , isRent = True -- Но при этом все будут платить мнимому 5ому игроку 100$
      , isPledge = False
      , streetId = 38
      , streetGroup = 0
      , amGroup = 11
      }
    , Street -- id = 39
      { name = "mmp bmmo" --"ММП БММО"
      , price = 400
      , priceRent = 40
      , isRent = False
      , owner = 6
      , isPledge = False
      , streetId = 39
      , streetGroup = 10
      , amGroup = 2
      }
    ]
