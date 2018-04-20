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
  Just piece1 <- loadJuicyPNG "images/piece1.png"
  Just piece2 <- loadJuicyPNG "images/piece2.png"
  Just piece3 <- loadJuicyPNG "images/piece3.png"
  Just piece4 <- loadJuicyPNG "images/piece4.png"
  Just piece5 <- loadJuicyPNG "images/piece5.png"
  Just piece6 <- loadJuicyPNG "images/piece6.png"
  Just playingField <- loadJuicyPNG "images/field.png"
  Just payMenu <- loadJuicyPNG "images/payMenu.png"
  Just endWindow <- loadJuicyPNG "images/end.png"
  Just currPlayer <- loadJuicyPNG "images/currPlayer.png"
  Just startMenu <- loadJuicyPNG "images/startMenu.png"
  Just moveAcadem <- loadJuicyPNG "images/moveAcadem.png"
  Just left2 <- loadJuicyPNG "images/left2.png"
  Just left1 <- loadJuicyPNG "images/left1.png"
  Just left0 <- loadJuicyPNG "images/left0.png"
  Just cubesOne <- loadJuicyPNG "images/1.png"
  Just cubesTwo <- loadJuicyPNG "images/2.png"
  Just cubesThree <- loadJuicyPNG "images/3.png"
  Just cubesFour <- loadJuicyPNG "images/4.png"
  Just cubesFive <- loadJuicyPNG "images/5.png"
  Just cubesSix <- loadJuicyPNG "images/6.png"
  return Images
    { imageStartMenu = startMenu
    , imagesPiece =
      [ scale 0.2 0.2 piece1
      , scale 0.2 0.2 piece2
      , scale 0.2 0.2 piece3
      , scale 0.2 0.2 piece4
      , scale 0.2 0.2 piece5
      , scale 0.2 0.2 piece6
      ]
    , imagePlayingField = playingField
    , imagePayMenu = scale 0.6 0.6 payMenu
    , imageWinnerWindow = scale 0.8 0.8 endWindow
    , imageCurrPlayer = scale 0.2 0.2 currPlayer
    , imageMoveAcadem = moveAcadem
    , imagesAcademLeft =
      [ left0
      , left1
      , left2
      ]
    , imageCubesOne = scale 0.3 0.3 cubesOne
    , imageCubesTwo = scale 0.3 0.3 cubesTwo
    , imageCubesThree = scale 0.3 0.3 cubesThree
    , imageCubesFour = scale 0.3 0.3 cubesFour
    , imageCubesFive = scale 0.3 0.3 cubesFive
    , imageCubesSix = scale 0.3 0.3 cubesSix
    }


-- | Сгенерировать начальное состояние игры.
initGame :: StdGen -> GameState
initGame gen = GameState
  { players =
    [ Player
      { number = 1
      , colour = 1
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 1 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player
      { number = 2
      , colour = 2
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 2 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player
      { number = 3
      , colour = 3
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 3 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player
      { number = 4
      , colour = 4
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 4 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player
      { number = 5
      , colour = 5
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 5 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player
      { number = 6
      , colour = 6
      , money = 500
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 6 0
      , inAcadem = False
      , missSteps = 0
      }
    , Player -- Фиктивный игрок
      { number = 7
      , colour = 7
      , money = 0
      , property = []
      , playerCell = 0
      , playerPosition = getPlayerPosition 7 1
      , inAcadem = False
      , missSteps = 0
      }
    ]
  , cubes = Cubes
    { firstCube = 1
    , secondCube = 1
    }
  , gamePlayer = 0 -- Чей сейчас ход
  , typeStep = stepGo -- Тип текущего шага
  , land = getLand
  , intSeq = randomRs (1,6) gen
  , isStartMenu = True
  , countPlayers = 4
  , isIncorrectColours = False
  , isMoveToAcadem = False
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
  | (isStartMenu gameState) && (isIncorrectColours gameState) = pictures
    [ drawStartMenu (imageStartMenu images) gameState
    , drawPlayersPieces (imagesPiece images) gameState
    , drawMessageAboutIncorrectColours
    ]
  | (isStartMenu gameState) = pictures
    [ drawStartMenu (imageStartMenu images) gameState
    , drawPlayersPieces (imagesPiece images) gameState
    ]
  | (haveWinner gameState) = pictures (      -- Если игра закончена и есть победитель
    [ drawPlayingField (imagePlayingField images)
    , drawEnd (imageWinnerWindow images)
    , drawWinnerWindow gameState
    ]
    ++ pieces ++ moneys ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  | (isMoveToAcadem gameState) = pictures (
    [ drawPlayingField (imagePlayingField images) ]
    ++ moneys ++ pieces ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawMoveAcademMessage (imageMoveAcadem images)
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  | (isInAcadem gameState) = pictures (
    [ drawPlayingField (imagePlayingField images) ]
    ++ moneys ++ pieces ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawAcademMessage (imagesAcademLeft images) gameState
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  | (typeStep gameState) == stepGo = pictures (
    [ drawPlayingField (imagePlayingField images) ]
    ++ moneys ++ pieces ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  | (typeStep gameState) == stepPay = pictures (    -- Меню для совершения покупки
    [ drawPlayingField (imagePlayingField images)
    , drawPayMenu (imagePayMenu images)
    ]
    ++ moneys ++ pieces ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images)), drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  | otherwise = pictures (
    [ drawPlayingField (imagePlayingField images) ]
    ++ moneys ++ pieces ++
    [ drawCurrPlayer (imageCurrPlayer images) gameState
    , drawLeftCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    , drawRightCube gameState (makeListCube (imageCubesOne images) (imageCubesTwo images) (imageCubesThree images) (imageCubesFour images) (imageCubesFive images) (imageCubesSix images))
    ] )
  where
      moneys =
        [ drawMoney (players gameState) 0 (countPlayers gameState)
        , drawMoney (players gameState) 1 (countPlayers gameState)
        , drawMoney (players gameState) 2 (countPlayers gameState)
        , drawMoney (players gameState) 3 (countPlayers gameState)
        , drawMoney (players gameState) 4 (countPlayers gameState)
        , drawMoney (players gameState) 5 (countPlayers gameState)
        ]
      pieces =
        [ drawPiece (imagesPiece images) gameState 0
        , drawPiece (imagesPiece images) gameState 1
        , drawPiece (imagesPiece images) gameState 2
        , drawPiece (imagesPiece images) gameState 3
        , drawPiece (imagesPiece images) gameState 4
        , drawPiece (imagesPiece images) gameState 5
        ]
-- | Проверка, находится ли текущий игрок в академе, чтобы вывести сообщение о том, сколько осталось пропустить
isInAcadem :: GameState -> Bool
isInAcadem gameState
  | (inAcadem player) = True
  | otherwise = False
    where
      player = (players gameState) !! (gamePlayer gameState)

-- | Создаем список из изображений граней кубика, чтобы было удобнее с этим работать
makeListCube :: Picture -> Picture -> Picture -> Picture -> Picture -> Picture -> [Picture]
makeListCube one two three four five six = [one, two, three, four, five, six] 

-- | Прорисовка левого кубика
drawLeftCube :: GameState -> [Picture] -> Picture
drawLeftCube gameState pics = translate x y image
  where
    (x, y) = (150, -200)
    image = pics !! ((firstCube (cubes gameState)) - 1)

-- | Прорисовка правого кубика
drawRightCube :: GameState -> [Picture] -> Picture
drawRightCube gameState pics = translate x y image
  where
    (x, y) = (-150, 200)
    image = pics !! ((secondCube (cubes gameState)) - 1) 

-- | Вывести стартовое меню для выбора количества игроков и фишек
drawStartMenu :: Picture -> GameState -> Picture
drawStartMenu image gameState = pictures
  [ translate 0 0 image
  , translate x y (scale r r (text countStr))
  ]
    where
      (x, y) = (310, 280)
      r = 1 / fromIntegral 2
      countStr = show (countPlayers gameState)

-- | Вывести сообщение об ошибке, если есть одинаковые цвета у фишек
drawMessageAboutIncorrectColours :: Picture
drawMessageAboutIncorrectColours = translate x y (scale r r (color red (text errorStr)))
  where
    (x, y) = (150, 0)
    errorStr = "Please, choose different colors!"
    r = 0.2

drawAcademMessage :: [Picture] -> GameState -> Picture
drawAcademMessage images gameState = translate x y image
    where
      (x, y) = (0, 0)
      image = images !! (missSteps player)
      player = (players gameState) !! (gamePlayer gameState)

drawMoveAcademMessage :: Picture -> Picture
drawMoveAcademMessage image = translate x y (scale r r image)
  where
    (x, y) = (0, 0)
    r = 1


-- | Вывести фишки для их выбора игрокам
drawPlayersPieces :: [Picture] -> GameState -> Picture
drawPlayersPieces images gameState = pictures
  [ translate x1 y1 (scale 2 2 (images !! ((colour ((players gameState) !! 0)) - 1)))
  , translate x2 y2 (scale 2 2 (images !! ((colour ((players gameState) !! 1)) - 1)))
  , translate x3 y3 (scale 2 2 (images !! ((colour ((players gameState) !! 2)) - 1)))
  , translate x4 y4 (scale 2 2 (images !! ((colour ((players gameState) !! 3)) - 1)))
  , translate x5 y5 (scale 2 2 (images !! ((colour ((players gameState) !! 4)) - 1)))
  , translate x6 y6 (scale 2 2 (images !! ((colour ((players gameState) !! 5)) - 1)))
  ]
    where
      (x1, y1) = (-30, 110)
      (x2, y2) = (-30, 25)
      (x3, y3) = (-30, -65)
      (x4, y4) = (-30, -150)
      (x5, y5) = (-30, -235)
      (x6, y6) = (-30, -320)

-- | Показать, чей сейчас ход
drawCurrPlayer :: Picture -> GameState -> Picture
drawCurrPlayer image gameState = translate x y image
  where
    (x, y) = (-510, 420 - 50 * (fromIntegral (number player)))
    player = (players gameState) !! (gamePlayer gameState)

-- | Вывод баланса игрока
drawMoney :: [Player] -> Int -> Int -> Picture
drawMoney allPlayers num maxCount
  | (money player > 0) && (num < maxCount) = translate x y (scale r r (text moneyStr))
  | (num >= maxCount) = Blank
  | otherwise = translate x y (scale r r (color red (text noMoneyStr)))
    where
      (x, y) = (-630, 400 - 50 * (fromIntegral (number player)))
      moneyStr = "Player " ++ numberStr ++ ": " ++ show (money player) ++ "-" ++ show (missSteps player) -- !!!  отладочный вывод missSteps для академа - убрать потом
      r = 1 / fromIntegral 5
      numberStr = show (number player)
      noMoneyStr = "Player " ++ numberStr ++ ": lost"
      player = allPlayers !! num

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
    numberStr = show ((nextPlayer gameState) + 1)
    str = "Player " ++ numberStr

-- | Отобразить фишки на игровом поле.
drawPiece :: [Picture] -> GameState -> Int -> Picture
drawPiece images gameState num
  | (money player >= 0) && (countPlayers gameState) > num = translate x y (scale r r image)
  | otherwise = Blank
    where
      image = images !! ((colour player) - 1)
      (x, y) = (playerPosition player)
      player = (players gameState) !! num 
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
  | (isStartMenu gameState) = menuHandle gameState mouse
  | (isMoveToAcadem gameState) = gameNextPlayer( gameState { isMoveToAcadem = False })
  | (typeStep gameState) == stepGo = doStep gameState
  | (typeStep gameState) == stepPay = case (isPay mouse) of
    Just True -> makePay gameState
    Just False -> gameState
      { typeStep = stepGo
      , gamePlayer = nextPlayer gameState
      }
    Nothing -> gameState
  | otherwise = gameState
handleGame _ gameState = gameState

menuHandle :: GameState -> Point -> GameState
menuHandle gameState mouse
  | (isPlayersCountPlus mouse) && (countPlayers gameState) <= 5 = changePlayersCount gameState 1
  | (isPlayersCountMinus mouse) && (countPlayers gameState) >= 3 = changePlayersCount gameState (-1)
  | (isExitFromMenu mouse) && (correctColours gameState 0) = gameState
    { isStartMenu = False
    , isIncorrectColours = False
    }
  | (isExitFromMenu mouse) = gameState
    { isIncorrectColours = True }
  | not ((colourPlus mouse) == 0) = gameState
    { players = firstPlayersPlus ++ [(changePlayerColour playerPlus 1)] ++ lastPlayersPlus }
  | not ((colourMinus mouse) == 0) = gameState
    { players = firstPlayersMinus ++ [(changePlayerColour playerMinus (-1))] ++ lastPlayersMinus }
  | otherwise = gameState
    where
      firstPlayersPlus = take ((colourPlus mouse) - 1) (players gameState)
      playerPlus = (players gameState) !! ((colourPlus mouse) - 1)
      lastPlayersPlus = reverse (take ((length (players gameState)) - (length firstPlayersPlus) - 1) (reverse (players gameState)))
      firstPlayersMinus = take ((colourMinus mouse) - 1) (players gameState)
      playerMinus = (players gameState) !! ((colourMinus mouse) - 1)
      lastPlayersMinus = reverse (take ((length (players gameState)) - (length firstPlayersMinus) - 1) (reverse (players gameState)))

-- | У игрока сменить цвет его фишки на следующий
changePlayerColour :: Player -> Int -> Player
changePlayerColour player num = player { colour = (mod ((colour player) - 1 + num) 6) + 1 }

-- | Изменить количество игроков на заданное значение (на +1 или -1)
changePlayersCount :: GameState -> Int -> GameState
changePlayersCount gameState n = gameState { countPlayers = oldCountPlayers + n }
  where
    oldCountPlayers = (countPlayers gameState)

-- | Проверка, корректно ли выбраны цвета для фишек игроков (нет ли повторяющихся)
correctColours :: GameState -> Int -> Bool
correctColours gameState num
  | num == (countPlayers gameState) - 1 = True
  | (haveSame (firstPlayers ++ lastPlayers) player) = False
  | otherwise = correctColours gameState (num + 1)
    where
      firstPlayers = take num (players gameState)
      lastPlayers = reverse (take ((length (players gameState)) - (length firstPlayers) - 1) (reverse (players gameState)))
      player = (players gameState) !! num

-- | Проверка, что в списке игроков нет игрока, с таким же цветом фишки
haveSame :: [Player] -> Player -> Bool
haveSame [] _ = False
haveSame (pl:pls) player
  | (colour pl) == (colour player) = True
  | otherwise = haveSame pls player

-- | Проверка, была ли нажата клавиша для увелечения количества игроков
isPlayersCountPlus :: Point -> Bool
isPlayersCountPlus (x, y)
  | x > 465 && x < 495 && y > 235 && y < 340 = True
  | otherwise = False

-- | ------||------- для уменьшения количества игроков
isPlayersCountMinus :: Point -> Bool
isPlayersCountMinus (x, y)
  | x > 180 && x < 212 && y > 235 && y < 340 = True
  | otherwise = False

-- |-------||------- для выхода из меню
isExitFromMenu :: Point -> Bool
isExitFromMenu (x, y)
   | x > 220 && x < 450 && y < -50 && y > -150 = True
   | otherwise = False

-- | Возвращает номер игрока, для которого меняется цвет, или 0
colourPlus :: Point -> Int
colourPlus (x, y)
  | x > 75 && x < 100 && y > 90 && y < 130 = 1
  | x > 75 && x < 100 && y > 5 && y < 45 = 2
  | x > 75 && x < 100 && y > -85 && y < -45 = 3
  | x > 75 && x < 100 && y > -170 && y < -130 = 4
  | x > 75 && x < 100 && y > -255 && y < -215 = 5
  | x > 75 && x < 100 && y > -340 && y < -300 = 6
  | otherwise = 0

colourMinus :: Point -> Int
colourMinus (x, y)
  | x > -165 && x < -140 && y > 90 && y < 130 = 1
  | x > -165 && x < -140 && y > 5 && y < 45 = 2
  | x > -165 && x < -140 && y > -85 && y < -45 = 3
  | x > -165 && x < -140 && y > -170 && y < -130 = 4
  | x > -165 && x < -140 && y > -255 && y < -215 = 5
  | x > -165 && x < -140 && y > -340 && y < -300 = 6
  | otherwise = 0

-- | Смена текущего игрока в gameState
nextPlayer :: GameState -> Int
nextPlayer gameState
  | (money ((players gameState) !! nextNum)) >= 0 = nextNum
  | otherwise = nextPlayer (gameState {gamePlayer = nextNum})
    where
      nextNum = mod ((gamePlayer gameState) + 1) (countPlayers gameState)

gameNextPlayer :: GameState -> GameState
gameNextPlayer gameState = gameState
  { gamePlayer = nextPlayer gameState }


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
                 | (inAcadem player) = gameNextPlayer (changeAcademStatus gameState)
                 | (money prevPlayer) < 0 = makeMove (returnBoughtPlace gameState)
                 | otherwise = makeMove gameState
  where
    prevPlayer = (players gameState) !! (mod ((gamePlayer gameState) - 1) (countPlayers gameState))
    player = (players gameState) !! (gamePlayer gameState)

changeAcademStatus :: GameState -> GameState
changeAcademStatus gameState
  | (missSteps player) == 0 = gameState {players = firstPlayers ++ [(player) { inAcadem = False }] ++ lastPlayers }
  | otherwise = gameState { players = firstPlayers ++ [(player) { missSteps = (missSteps player) - 1}] ++ lastPlayers }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))


-- | Возврат имущества проигравшего игрока
returnBoughtPlace :: GameState -> GameState 
returnBoughtPlace gameState = gameState {land = deletePlace (land gameState) (mod ((gamePlayer gameState) - 1) (countPlayers gameState))}

deletePlace :: [Street] -> Int -> [Street]
deletePlace [] _ = []
deletePlace (x:xs) num | (owner x) == num = (x {isRent = False} : (deletePlace xs num))
                       | otherwise = (x : (deletePlace xs num))

-- | Деньги за проход через ячейку "Старт"
startMoney :: GameState -> GameState
startMoney gameState | (cell + cubesSum) >= 40 = gameState { players = firstPlayers ++ [(changeBalance player 200)] ++ lastPlayers}
                     | otherwise = gameState
  where
    player = (players gameState) !! (gamePlayer gameState)
    cell = (playerCell player)
    cubesSum = (firstCube (cubes gameState)) + (secondCube (cubes gameState))    
    firstPlayers = take (gamePlayer gameState) (players gameState)
    lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))

-- | Переместиться и выполнить действия
makeMove :: GameState -> GameState
makeMove gameState = (makeStepFeatures (changePlayerCell (startMoney (throwCubes gameState))))

makeStepFeatures :: GameState -> GameState
makeStepFeatures gameState
    -- Если поле нельзя купить => нужно отдать налоги и дать деньги владельцу
    -- и перейти к следующему игроку
  | currField == 30 =  (changeIsMoveToAcadem (moveToAcadem gameState))
  | not (canBuy gameState) = gameNextPlayer (getPriceRent (payPriceRent gameState))
  | otherwise = gameState
    where
      currField = (playerCell player)
      player = (players gameState) !! (gamePlayer gameState)

changeIsMoveToAcadem :: GameState -> GameState
changeIsMoveToAcadem gameState = gameState { isMoveToAcadem = True }

moveToAcadem :: GameState -> GameState
moveToAcadem gameState = gameState
  { players = firstPlayers ++ [(setAcademStatus (setPlayerCell player 10))] ++ lastPlayers
  }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take ((length (players gameState)) - (length firstPlayers) - 1) (reverse (players gameState)))

setPlayerCell :: Player -> Int -> Player
setPlayerCell player cell = player
  { playerCell = cell
  , playerPosition = getPlayerPosition (number player) cell
  }

setAcademStatus :: Player -> Player
setAcademStatus player = player
  { inAcadem = True
  , missSteps = 2
  }


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
      firstPlayers = take ((number player) - 1) (players gameState)
      lastPlayers = reverse (take (length (players gameState) - (number player)) (reverse (players gameState)))
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
  , playerPosition = getPlayerPosition (number player) newPlayerCell
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
