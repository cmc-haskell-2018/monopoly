module Monopoly where
import Graphics.Gloss.Juicy
import Graphics.Gloss.Data.Vector()
import Graphics.Gloss.Interface.Pure.Game
import Const
import Model
import Debug.Trace()
import System.Random

-- | Запустить моделирование с заданным начальным состоянием вселенной.
startGame :: Images -> IO ()
startGame images = do
  gen <- getStdGen
  play display bgColor fps (initGame gen) (drawGameState images) handleGame updateGameState
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
  Just currPlayer <- loadJuicyPNG "images/currPlayer.png"
  Just cubesPic <- loadJuicyPNG "images/cubes.png"
  return Images
    { imagePieceRed    = scale 0.1 0.1 pieceRed
    , imagePieceBlue   = scale 0.1 0.1 pieceBlue
    , imagePieceGreen  = scale 0.1 0.1 pieceGreen
    , imagePieceYellow = scale 0.1 0.1 pieceYellow
    , imagePlayingField = playingField
    , imagePayMenu = scale 0.6 0.6 payMenu
    , imageWinnerWindow = scale 0.8 0.8 endWindow
    , imageCurrPlayer = scale 0.2 0.2 currPlayer
    , imageCubes = scale 0.6 0.6 cubesPic
    }


-- | Сгенерировать начальное состояние игры.
initGame :: StdGen -> GameState
initGame gen = GameState
  { players =
    [ Player
      { colour = 1
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 1 0
      }
    , Player 
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
    , secondCube = 1
    }
  , gamePlayer = 0 -- Чей сейчас ход
  , typeStep = stepGo -- Тип текущего шага
  , land =
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
  , intSeq = randomRs (1,6) gen
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
  | (haveWinner gameState) = pictures        -- Если игра закончена и есть победитель
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
    , drawCurrPlayer (imageCurrPlayer images) gameState
    , drawCubesPic (imageCubes images)
    , drawCubes gameState
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
    , drawCurrPlayer (imageCurrPlayer images) gameState
    , drawCubesPic (imageCubes images)
    , drawCubes gameState
    ]
  | (typeStep gameState) == stepPay = pictures      -- Меню для совершения покупки
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
    , drawCurrPlayer (imageCurrPlayer images) gameState
    , drawCubesPic (imageCubes images)
    , drawCubes gameState
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
    , drawCurrPlayer (imageCurrPlayer images) gameState
    , drawCubesPic (imageCubes images)
    , drawCubes gameState
    ]
  where
    player1 = ((players gameState) !! 0)
    player2 = ((players gameState) !! 1)
    player3 = ((players gameState) !! 2)
    player4 = ((players gameState) !! 3)

-- | Показать, чей сейчас ход
drawCurrPlayer :: Picture -> GameState -> Picture
drawCurrPlayer image gameState = translate x y image
  where
    (x, y) = (-510, 420 - 50 * (fromIntegral (colour player)))
    player = (players gameState) !! (gamePlayer gameState)

-- | Вывод баланса игрока
drawMoney :: Player -> Picture
drawMoney player
  | (money player > 0) = translate x y (scale r r (text moneyStr))
  | otherwise = translate x y (scale r r (color red (text noMoneyStr)))
    where
      (x, y) = (-630, 400 - 50 * (fromIntegral (colour player)))
      moneyStr = "Player " ++ colourStr ++ ": " ++ show (money player)
      r = 1 / fromIntegral 5
      colourStr = show (colour player)
      noMoneyStr = "Player " ++ colourStr ++ ": lost"

-- | Вывод меню покупки
drawPayMenu :: Picture -> Picture
drawPayMenu image = translate 0 0 image

-- | Вывод сообщения о победе
drawEnd :: Picture -> Picture
drawEnd image = translate 0 0  image

drawWinnerWindow :: GameState -> Picture
drawWinnerWindow gameState = translate x y (scale r r (text str))
  where
    (x, y) = (-130, -150)
    r = 1 / fromIntegral 2
    colourStr = show ((nextPlayer gameState) + 1)
    str = "Player " ++ colourStr

-- | Отобразить фишки.
drawPiece :: Picture -> Player -> Picture
drawPiece image player 
  | (money player >= 0) = translate x y (scale r r image)
  | otherwise = Blank
    where
      (x, y) = (playerPosition player)
      r = 2

-- | Отобразить цифры кубиков.
drawCubes :: GameState -> Picture
drawCubes gameState = translate x y (scale r r (text str))
  where
    (x, y) = (-573, -360)
    cubeOne = show (firstCube (cubes gameState))
    cubeTwo = show (secondCube (cubes gameState))
    str = cubeOne ++ " " ++ cubeTwo
    r = 1 / fromIntegral 4

-- | Отобразить форму кубиков.
drawCubesPic :: Picture -> Picture
drawCubesPic image = translate x y image
  where
    (x, y) = (-550, -350)

-- | Отобразить игровое поле
drawPlayingField :: Picture -> Picture
drawPlayingField image = translate 0 0 image

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

-- | Смена текущего игрока в gameState
nextPlayer :: GameState -> Int
nextPlayer gameState
  | (money ((players gameState) !! nextNum)) >= 0 = nextNum
  | otherwise = nextPlayer (gameState {gamePlayer = nextNum})
    where
      nextNum = mod ((gamePlayer gameState) + 1) playersNumber

gameNextPlayer :: GameState -> GameState
gameNextPlayer gameState = gameState { gamePlayer = nextPlayer gameState }

-- | Проверка, закончена игра или нет
haveWinner :: GameState -> Bool
haveWinner gameState
  | (length (filter haveMoney (players gameState))) >= 2 = False
  | otherwise = True

haveMoney :: Player -> Bool
haveMoney player = (money player) > 0

-- | Меню покупки: что выбрал игрок
isPay :: Point -> Maybe Bool
isPay (x, y) | x < 0 && x > -100 && y > -50 && y < 50 = Just True
             | x > 0 && x < 100 && y > -50 && y < 50 = Just False
             | otherwise = Nothing

-- =======================================
-- Совершение хода
-- =======================================
doStep :: GameState -> GameState
doStep gameState | (haveWinner gameState) = gameState
                 | (money prevPlayer) < 0 = makeMove (returnBoughtPlace gameState)
                 | otherwise = makeMove gameState
  where
    prevPlayer = (players gameState) !! (mod ((gamePlayer gameState) - 1) playersNumber)

-- | Возврат имущества проигравшего игрока
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

-- | Переместиться и выполнить действия
makeMove :: GameState -> GameState
makeMove gameState = (makeStepFeatures (changePlayerCell (throwCubes gameState)))

makeStepFeatures :: GameState -> GameState
makeStepFeatures gameState
    -- Если поле нельзя купить => нужно отдать налоги и дать деньги владельцу
    -- и перейти к следующему игроку
  | not (canBuy gameState) = gameNextPlayer (getPriceRent (payPriceRent gameState))
  | otherwise = gameState

-- | Заплатить ренту хозяину
payPriceRent :: GameState -> GameState
payPriceRent gameState = gameState 
  { players = firstPlayers ++ [(changeBalance player rentValue)] ++ lastPlayers
  }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take ((length (players gameState)) - (length firstPlayers) - 1) (reverse (players gameState)))
      rentValue = (priceRent ((land gameState) !! (playerCell player))) * (-1)

-- | Получить ренту от другого игрока
getPriceRent :: GameState -> GameState
getPriceRent gameState = gameState
  { players = firstPlayers ++ [(changeBalance player rentValue)] ++ lastPlayers
  }
    where
      player = (players gameState) !! (owner ((land gameState) !! (playerCell ((players gameState) !! (gamePlayer gameState)))))
      firstPlayers = take ((colour player) - 1) (players gameState)
      lastPlayers = reverse (take (length (players gameState) - (colour player)) (reverse (players gameState)))
      rentValue = (priceRent ((land gameState) !! (playerCell player)))

-- | Изменить баланс игрока
changeBalance :: Player -> Int -> Player
changeBalance player value = player
  { money = (money player) + value
  }

-- | Уплата налогов
payTax :: GameState -> Int -> GameState
payTax gameState count = gameState
  { players = firstPlayers ++ [(player) { money = (money (player)) - count}] ++ lastPlayers
  , gamePlayer = nextPlayer gameState
  }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))

-- | Кинуть кубики
throwCubes :: GameState -> GameState
throwCubes gameState =
  let
    list = intSeq gameState
    first = head list
    second = head (tail list)
    nextList = drop 2 list
  in gameState
    { cubes = Cubes
      { firstCube = first
      , secondCube = second
      }
    , intSeq = nextList
    }

-- | Совершение покупки спецсеминара
makePay :: GameState -> GameState
makePay gameState = gameState 
  { typeStep = stepGo
  , players = firstPlayers ++ [changeBalance player priceValue] ++ lastPlayers
  , gamePlayer = nextPlayer gameState
  , land = firstLands ++ [changeOwner currentLand (gamePlayer gameState) ] ++ lastLands
  }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
      priceValue = (price ((land gameState) !! (playerCell player))) * (-1)
      firstLands = take (playerCell player) (land gameState)
      currentLand = (land gameState) !! (playerCell player)
      lastLands = reverse (take (length (land gameState) - length(firstLands) - 1) (reverse (land gameState)))

-- | Смена владельца у спецсеминара
changeOwner :: Street -> Int -> Street
changeOwner prevStreet ownerId = prevStreet { owner = ownerId, isRent = True }

-- | Изменить поле, на котором находится текущий игрок
changePlayerCell :: GameState -> GameState
changePlayerCell gameState = gameState
  { players = firstPlayers ++ [playerAfterMove] ++ lastPlayers
  , typeStep = getTypeByCell (playerCell playerAfterMove) gameState
  }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
      cubesSum = (firstCube (cubes gameState)) + (secondCube (cubes gameState))
      playerAfterMove = (movePlayer player cubesSum)

-- | Если кафедра свободна, переходим в состояние "предложить покупку"
-- | Иначе просто совершаем шаг
getTypeByCell :: Int -> GameState -> Int
getTypeByCell index gameState
  | isRent ((land gameState) !! index) == False = stepPay
  | otherwise = stepGo

-- | Переместить игрока на заданное число клеток
movePlayer :: Player -> Int -> Player
movePlayer player cubesSum = player 
  { playerCell = newPlayerCell
  , playerPosition = getPlayerPosition (colour player) newPlayerCell
  }
    where
      newPlayerCell = (mod ((playerCell player) + cubesSum) fieldsNumber)

-- | Для игрока получить местоположение его фишки на игровом поле по номеру клетки
getPlayerPosition :: Int -> Int -> Point
getPlayerPosition playerNumber cellNum
    | (cellNum >= 0  && cellNum <= 10) = (fromIntegral (-375 + 15 + playerNumber * 15), fromIntegral (-305 + 15 + (cellNum) * 60))
    | (cellNum >= 11 && cellNum <= 20) = (fromIntegral (-305 + (cellNum - 10) * 60), fromIntegral (375 - 15 - playerNumber * 15))
    | (cellNum >= 21 && cellNum <= 30) = (fromIntegral (375 - 15 - playerNumber * 15), fromIntegral (305 - (cellNum - 20) * 60))
    | otherwise = (fromIntegral(305 - (cellNum - 30) * 60), fromIntegral(-375 + 15 + playerNumber * 15))


-- =========================================
-- Функции обновления
-- =========================================

-- | Обновить состояние игры
updateGameState :: Float -> GameState -> GameState
updateGameState _ = id
