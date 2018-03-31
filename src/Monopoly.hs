module Monopoly where

import Graphics.Gloss.Juicy
import Graphics.Gloss.Data.Vector()
import Graphics.Gloss.Interface.Pure.Game
import Const
import Model
import Debug.Trace()

--import System.Random

-- | Запустить моделирование с заданным начальным состоянием вселенной.
startGame :: Images -> IO ()
startGame images
  = play display bgColor fps initGame (drawGameState images) handleGame updateGameState
  where
    display = FullScreen -- InWindow "Монополия"
    bgColor = white      -- Цвет фона
    fps     = 100        -- Кол-во кадров в секунду

-- | Загрузить изображения из файлов.
loadImages :: IO Images
loadImages = do
  Just pieceRed     <- loadJuicyPNG "images/pieceRed.png"
  Just pieceBlue    <- loadJuicyPNG "images/pieceBlue.png"
  Just pieceGreen   <- loadJuicyPNG "images/pieceGreen.png"
  Just pieceYellow  <- loadJuicyPNG "images/pieceYellow.png"
  Just playingField <- loadJuicyPNG "images/field.png"
  Just payMenu <- loadJuicyPNG "images/payMenu.png"
  Just endWindow <- loadJuicyPNG "images/end.png"
  return Images
    { imagePieceRed    = scale 0.1 0.1 pieceRed
    , imagePieceBlue   = scale 0.1 0.1 pieceBlue
    , imagePieceGreen  = scale 0.1 0.1 pieceGreen
    , imagePieceYellow = scale 0.1 0.1 pieceYellow
    , imagePlayingField = playingField
    , imagePayMenu = scale 0.6 0.6 payMenu
    , imageWinnerWindow = scale 0.8 0.8 endWindow
    }


-- | Сгенерировать начальное состояние игры.
initGame :: GameState
initGame = GameState
  { players = 
      [ Player 
        { colour = 1
        , money = 500
        , property = []
        , playerCell = 0
        , playerPosition = getPlayerPosition 1 0
        }
      ,  Player 
        { colour = 2
        , money = 500
        , property = []
        , playerCell = 0
        , playerPosition = getPlayerPosition 2 0
        }
      , Player 
        { colour = 3
        , money = 500
        , property = []
        , playerCell = 0
        , playerPosition = getPlayerPosition 3 0
        }
      , Player 
        { colour = 4
        , money = 500
        , property = []
        , playerCell = 0
        , playerPosition = getPlayerPosition 4 0
        }
      , Player -- Fictitious player
        { colour = 5
        , money = 0
        , property = []
        , playerCell = 0
        , playerPosition = getPlayerPosition 4 1
        }
      ]
  , cubes = Cubes 
      { firstCube = 1
      , secondCube = 0
      }
  , gamePlayer = 0
  , typeStep = stepGo
  , land = 
    [ Street 
      { name ="Старт"
      , price = 0
      , isRent = True
      , priceRent = 0
      , owner = 4
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
  }

canBuy :: GameState -> Bool
canBuy gameState = not (isRent ((land gameState) !! (playerCell player)))
    where
        player = (players gameState) !! (gamePlayer gameState)

-- =========================================
-- Функции отрисовки
-- =========================================

-- | Отобразить состояние игры.
drawGameState :: Images -> GameState -> Picture
drawGameState images gameState
    | (haveWinner gameState) = pictures
        [ drawPlayingField (imagePlayingField images)
        , drawEnd (imageWinnerWindow images)
        , drawWinnerWindow gameState
        , drawPiece (imagePieceRed images) player1
        , drawPiece (imagePieceBlue  images) player2
        , drawPiece (imagePieceGreen  images) player3
        , drawPiece (imagePieceYellow  images) player4
        , drawMoney player1
        , drawMoney player2
        , drawMoney player3
        , drawMoney player4
        ]
    | (typeStep gameState) == stepGo = pictures
        [ drawPlayingField (imagePlayingField images)
        , drawPiece (imagePieceRed images) player1
        , drawPiece (imagePieceBlue  images) player2
        , drawPiece (imagePieceGreen  images) player3
        , drawPiece (imagePieceYellow  images) player4
        , drawMoney player1
        , drawMoney player2
        , drawMoney player3
        , drawMoney player4
        ]
    | (typeStep gameState) == stepPay = pictures
        [ drawPlayingField (imagePlayingField images)
        , drawPayMenu (imagePayMenu images)
        , drawPiece (imagePieceRed images) player1
        , drawPiece (imagePieceBlue  images) player2
        , drawPiece (imagePieceGreen  images) player3
        , drawPiece (imagePieceYellow  images) player4
        , drawMoney player1
        , drawMoney player2
        , drawMoney player3
        , drawMoney player4
        ]    
    | otherwise = pictures
        [ drawPlayingField (imagePlayingField images)
        , drawPiece (imagePieceRed images) player1
        , drawPiece (imagePieceBlue  images) player2
        , drawPiece (imagePieceGreen  images) player3
        , drawPiece (imagePieceYellow  images) player4
        , drawMoney player1
        , drawMoney player2
        , drawMoney player3
        , drawMoney player4
        ]
  where
    player1 = ((players gameState) !! 0)
    player2 = ((players gameState) !! 1)
    player3 = ((players gameState) !! 2)
    player4 = ((players gameState) !! 3)

drawMoney :: Player -> Picture
drawMoney player
    | (money player >= 0) = translate x y (scale r r (text money_str))
    | otherwise = translate x y (scale r r (color red (text no_money_str)))
      where
        (x, y) = (-630, 400 - 50 * (fromIntegral (colour player)))
        money_str = "Player " ++ colour_str ++ ": " ++ show (money player)
        r = 1 / fromIntegral 5
        colour_str = show (colour player)
        no_money_str = "Player " ++ colour_str ++ ": lost"

drawPayMenu :: Picture -> Picture
drawPayMenu image = translate 0 0 image

drawEnd :: Picture -> Picture
drawEnd image = translate 0 0  image

drawWinnerWindow :: GameState -> Picture
drawWinnerWindow gameState = translate x y (scale r r (text str))
  where
    (x, y) = (-130, -150)
    r = 1 / fromIntegral 2
    colour_str = show ((gamePlayer gameState) + 1)
    str = "Player " ++ colour_str

-- | Отобразить фишки.
drawPiece :: Picture -> Player -> Picture
drawPiece image player 
  | (money player >= 0) = translate x y (scale r r image)
  | otherwise = Blank
    where
      (x, y) = (playerPosition player)
      r = 2

drawPlayingField :: Picture -> Picture
drawPlayingField image = translate 0 0 image --(scale r r image)

nextPlayer :: GameState -> Int
nextPlayer gameState
    | (money ((players gameState) !! nextNum)) >= 0 = nextNum
    | otherwise = nextPlayer (gameState {gamePlayer = nextNum})

  where
    nextNum = mod ((gamePlayer gameState) + 1) playersNumber

-- =========================================
-- Обработка событий
-- =========================================

handleGame :: Event -> GameState -> GameState
handleGame (EventKey (MouseButton LeftButton) Down _ mouse) gameState
    | (typeStep gameState) == stepGo = doStep gameState
    | ((typeStep gameState) == stepPay) = case (isPay mouse) of
        Just True -> makePay gameState
        Just False -> gameState
          { typeStep = stepGo
          , gamePlayer = nextPlayer gameState
          }
        Nothing -> gameState
    | otherwise = gameState
handleGame _ gameState = gameState

gameNextPlayer :: GameState -> GameState
gameNextPlayer gameState = gameState { gamePlayer = nextPlayer gameState }

isPay :: Point -> Maybe Bool
isPay (x, y) | x < 0 && x > -100 && y > -50 && y < 50 = Just True
             | x > 0 && x < 100 && y > -50 && y < 50 = Just False
             | otherwise = Nothing

doStep :: GameState -> GameState
doStep gameState 
  | (haveWinner gameState) = gameState
  | (money ((players gameState) !! (mod ((gamePlayer gameState) - 1) playersNumber))) < 0 = makeMove (returnBoughtPlace gameState)
  | otherwise = makeMove gameState

haveWinner :: GameState -> Bool
haveWinner gameState 
  | (length (filter haveMoney (players gameState))) >= 2 = False
  | otherwise = True

haveMoney :: Player -> Bool
haveMoney player = (money player) > 0

returnBoughtPlace :: GameState -> GameState 
returnBoughtPlace gameState = gameState {land = deletePlace (land gameState) (mod ((gamePlayer gameState) - 1) playersNumber)}

deletePlace :: [Street] -> Int -> [Street]
deletePlace [] _ = []
deletePlace (x:xs) num | (owner x) == num = (x {isRent = False} : (deletePlace xs num))
                       | otherwise = (x : (deletePlace xs num))
{--
canGo :: GameState -> Bool
canGo gameState = True
--}

makeMove :: GameState -> GameState
makeMove gameState = (makeStepFeatures (changePlayerCell (throwCubes gameState)))

makeStepFeatures :: GameState -> GameState
makeStepFeatures gameState
    -- Если поле нельзя купить => нужно отдать налоги и дать деньги владельцу
    -- и перейти к следующему игроку
    | not (canBuy gameState) = gameNextPlayer (getPriceRent (payPriceRent gameState))
    | otherwise = gameState

payPriceRent :: GameState -> GameState
payPriceRent gameState = gameState 
    { players = firstPlayers ++ [(changeBalance player rent_value)] ++ lastPlayers
    }
  where
    firstPlayers = take (gamePlayer gameState) (players gameState)
    player = (players gameState) !! (gamePlayer gameState)
    lastPlayers = reverse (take ((length (players gameState)) - (length firstPlayers) - 1) (reverse (players gameState)))
    rent_value = (priceRent ((land gameState) !! (playerCell player))) * (-1)

getPriceRent :: GameState -> GameState
getPriceRent gameState = gameState
    { players = firstPlayers ++ [(changeBalance player rent_value)] ++ lastPlayers
    }
  where
    player = (players gameState) !! (owner ((land gameState) !! (playerCell ((players gameState) !! (gamePlayer gameState)))))
    firstPlayers = take ((colour player) - 1) (players gameState)
    lastPlayers = reverse (take (length (players gameState) - (colour player)) (reverse (players gameState)))
    rent_value = (priceRent ((land gameState) !! (playerCell player)))

changeBalance :: Player -> Int -> Player
changeBalance player value = player
    { money = (money player) + value }

{--
data ChanceCard = ChanceCard
    { num :: Int
    , price2 :: Int
    , text2 :: String
    }

type Cards = [ChanceCard]

initCards :: Cards -> Cards
initCards cards =
  [ ChanceCard
    { num = 0
        , price2 = 100
        , text2 = "Вам подарок 100 баллов!"
    }
  , ChanceCard
    { num = 1
    , price2 = -100
    , text2 = "Штраф 100 баллов!"
    }
  , ChanceCard
    { num = 2
    , price2 = 200
    , text2 = "С днем рождения! Вам подарок 200 баллов"
    }
  , ChanceCard
    { num = 3
    , price2 = -200
    , text2 = "Штраф 200 баллов!"
    }
  , ChanceCard
    { num = 4
    , price2 = 0
    , text2 = "Живите спокойно!"
    }
  ]

chanceCard :: GameState -> GameState
chanceCard gameState = gameState
--}

payTax :: GameState -> Int -> GameState
payTax gameState count = gameState
    { players = firstPlayers ++ [(player) { money = (money (player)) - count}]
        ++ lastPlayers
    , gamePlayer = nextPlayer gameState
    }
  where
    firstPlayers = take (gamePlayer gameState) (players gameState)
    player = (players gameState) !! (gamePlayer gameState)
    lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))

throwCubes :: GameState -> GameState
throwCubes gameState = gameState
    { cubes = Cubes
        { firstCube = 1
        , secondCube = 0
        }
    }

makePay :: GameState -> GameState
makePay gameState = gameState 
    { typeStep = stepGo
    , players = firstPlayers ++ [changeBalance player price_value] ++ lastPlayers
    , gamePlayer = nextPlayer gameState
    , land = firstLands ++ [changeOwner current_land (gamePlayer gameState) ] ++ lastLands
    }
  where
    firstPlayers = take (gamePlayer gameState) (players gameState)
    player = (players gameState) !! (gamePlayer gameState)
    lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
    price_value = (price ((land gameState) !! (playerCell player))) * (-1)
    firstLands = take (playerCell player) (land gameState)
    current_land = (land gameState) !! (playerCell player)
    lastLands = reverse (take (length (land gameState) - length(firstLands) - 1) (reverse (land gameState)))

changeOwner :: Street -> Int -> Street
changeOwner prev_street owner_id = prev_street { owner = owner_id, isRent = True }

changePlayerCell :: GameState -> GameState
changePlayerCell gameState = gameState
    { players = firstPlayers ++ [player_after_move] ++ lastPlayers
    , typeStep = getTypeByCell (playerCell player_after_move) gameState
    }
  where
    firstPlayers = take (gamePlayer gameState) (players gameState)
    player = (players gameState) !! (gamePlayer gameState)
    lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
    cubesSum = (firstCube (cubes gameState)) + (secondCube (cubes gameState))
    player_after_move = (movePlayer player cubesSum)

-- Если кафедра свободна, переходим в состояние "предложить покупку"
-- Иначе просто совершаем шаг
getTypeByCell :: Int -> GameState -> Int
getTypeByCell index gameState
  | isRent ((land gameState) !! index) == False = stepPay
  | otherwise = stepGo

movePlayer :: Player -> Int -> Player
movePlayer player cubesSum = player 
    { playerCell = newPlayerCell
    , playerPosition = getPlayerPosition (colour player) newPlayerCell
    }
    where
        newPlayerCell = (mod ((playerCell player) + cubesSum) fieldsNumber)

getPlayerPosition :: Int -> Int -> Point
getPlayerPosition player_number cell_num
    | (cell_num >= 0  && cell_num <= 10) = (fromIntegral (-375 + 15 + player_number * 15), fromIntegral (-305 + 15 + (cell_num) * 60))
    | (cell_num >= 11 && cell_num <= 20) = (fromIntegral (-305 + (cell_num - 10) * 60), fromIntegral (375 - 15 - player_number * 15))
    | (cell_num >= 21 && cell_num <= 30) = (fromIntegral (375 - 15 - player_number * 15), fromIntegral (305 - (cell_num - 20) * 60))
    | otherwise = (fromIntegral(305 - (cell_num - 30) * 60), fromIntegral(-375 + 15 + player_number * 15))


-- =========================================
-- Функции обновления
-- =========================================

-- | Обновить состояние игры
updateGameState :: Float -> GameState -> GameState
updateGameState _ = id
