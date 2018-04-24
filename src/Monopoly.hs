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
  Just payMenu <- loadJuicyPNG "images/payMenu2.png"
  Just endWindow <- loadJuicyPNG "images/end.png"
  Just currPlayer <- loadJuicyPNG "images/currPlayer.png"
  Just startMenu <- loadJuicyPNG "images/startMenu.png"
  Just moveAcadem <- loadJuicyPNG "images/moveAcadem.png"
  Just left2 <- loadJuicyPNG "images/left2.png"
  Just left1 <- loadJuicyPNG "images/left1.png"
  Just left0 <- loadJuicyPNG "images/left0.png"
  Just pledgeMenu <- loadJuicyPNG "images/pledgeMenu.png"
  Just cubesOne <- loadJuicyPNG "images/1dot.png"
  Just cubesTwo <- loadJuicyPNG "images/2dot.png"
  Just cubesThree <- loadJuicyPNG "images/3dot.png"
  Just cubesFour <- loadJuicyPNG "images/4dot.png"
  Just cubesFive <- loadJuicyPNG "images/5dot.png"
  Just cubesSix <- loadJuicyPNG "images/6dot.png"
  Just pledgeButton <- loadJuicyPNG "images/pledgeButton.png"
  Just empty <- loadJuicyPNG "images/empty.png"
  Just field0Yellow <- loadJuicyPNG "images/0.png"
  Just field1Yellow <- loadJuicyPNG "images/1.png"
  Just field2Yellow <- loadJuicyPNG "images/2.png"
  Just field3Yellow <- loadJuicyPNG "images/3.png"
  Just field4Yellow <- loadJuicyPNG "images/4.png"
  Just field5Yellow <- loadJuicyPNG "images/5.png"
  Just field6Yellow <- loadJuicyPNG "images/6.png"
  Just field7Yellow <- loadJuicyPNG "images/7.png"
  Just field8Yellow <- loadJuicyPNG "images/8.png"
  Just field9Yellow <- loadJuicyPNG "images/9.png"
  Just field10Yellow <- loadJuicyPNG "images/10.png"
  Just field11Yellow <- loadJuicyPNG "images/11.png"
  Just field12Yellow <- loadJuicyPNG "images/12.png"
  Just field13Yellow <- loadJuicyPNG "images/13.png"
  Just field14Yellow <- loadJuicyPNG "images/14.png"
  Just field15Yellow <- loadJuicyPNG "images/15.png"
  Just field16Yellow <- loadJuicyPNG "images/16.png"
  Just field17Yellow <- loadJuicyPNG "images/17.png"
  Just field18Yellow <- loadJuicyPNG "images/18.png"
  Just field19Yellow <- loadJuicyPNG "images/19.png"
  Just field20Yellow <- loadJuicyPNG "images/20.png"
  Just field21Yellow <- loadJuicyPNG "images/21.png"
  Just field22Yellow <- loadJuicyPNG "images/22.png"
  Just field23Yellow <- loadJuicyPNG "images/23.png"
  Just field24Yellow <- loadJuicyPNG "images/24.png"
  Just field25Yellow <- loadJuicyPNG "images/25.png"
  Just field26Yellow <- loadJuicyPNG "images/26.png"
  Just field27Yellow <- loadJuicyPNG "images/27.png"
  Just field28Yellow <- loadJuicyPNG "images/28.png"
  Just field29Yellow <- loadJuicyPNG "images/29.png"
  Just field30Yellow <- loadJuicyPNG "images/30.png"
  Just field31Yellow <- loadJuicyPNG "images/31.png"
  Just field32Yellow <- loadJuicyPNG "images/32.png"
  Just field33Yellow <- loadJuicyPNG "images/33.png"
  Just field34Yellow <- loadJuicyPNG "images/34.png"
  Just field35Yellow <- loadJuicyPNG "images/35.png"
  Just field36Yellow <- loadJuicyPNG "images/36.png"
  Just field37Yellow <- loadJuicyPNG "images/37.png"
  Just field38Yellow <- loadJuicyPNG "images/38.png"
  Just field39Yellow <- loadJuicyPNG "images/39.png"
  Just field0 <- loadJuicyPNG "images/0g.png"
  Just field1 <- loadJuicyPNG "images/1g.png"
  Just field2 <- loadJuicyPNG "images/2g.png"
  Just field3 <- loadJuicyPNG "images/3g.png"
  Just field4 <- loadJuicyPNG "images/4g.png"
  Just field5 <- loadJuicyPNG "images/5g.png"
  Just field6 <- loadJuicyPNG "images/6g.png"
  Just field7 <- loadJuicyPNG "images/7g.png"
  Just field8 <- loadJuicyPNG "images/8g.png"
  Just field9 <- loadJuicyPNG "images/9g.png"
  Just field10 <- loadJuicyPNG "images/10g.png"
  Just field11 <- loadJuicyPNG "images/11g.png"
  Just field12 <- loadJuicyPNG "images/12g.png"
  Just field13 <- loadJuicyPNG "images/13g.png"
  Just field14 <- loadJuicyPNG "images/14g.png"
  Just field15 <- loadJuicyPNG "images/15g.png"
  Just field16 <- loadJuicyPNG "images/16g.png"
  Just field17 <- loadJuicyPNG "images/17g.png"
  Just field18 <- loadJuicyPNG "images/18g.png"
  Just field19 <- loadJuicyPNG "images/19g.png"
  Just field20 <- loadJuicyPNG "images/20g.png"
  Just field21 <- loadJuicyPNG "images/21g.png"
  Just field22 <- loadJuicyPNG "images/22g.png"
  Just field23 <- loadJuicyPNG "images/23g.png"
  Just field24 <- loadJuicyPNG "images/24g.png"
  Just field25 <- loadJuicyPNG "images/25g.png"
  Just field26 <- loadJuicyPNG "images/26g.png"
  Just field27 <- loadJuicyPNG "images/27g.png"
  Just field28 <- loadJuicyPNG "images/28g.png"
  Just field29 <- loadJuicyPNG "images/29g.png"
  Just field30 <- loadJuicyPNG "images/30g.png"
  Just field31 <- loadJuicyPNG "images/31g.png"
  Just field32 <- loadJuicyPNG "images/32g.png"
  Just field33 <- loadJuicyPNG "images/33g.png"
  Just field34 <- loadJuicyPNG "images/34g.png"
  Just field35 <- loadJuicyPNG "images/35g.png"
  Just field36 <- loadJuicyPNG "images/36g.png"
  Just field37 <- loadJuicyPNG "images/37g.png"
  Just field38 <- loadJuicyPNG "images/38g.png"
  Just field39 <- loadJuicyPNG "images/39g.png"
  Just auctionPic <- loadJuicyPNG "images/auction.png"
  Just questionPic <- loadJuicyPNG "images/question.png"
  Just help1Pic <- loadJuicyPNG "images/help1.png"
  Just help2Pic <- loadJuicyPNG "images/help2.png"
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
    , imagePayMenu = scale 1.1 1.1 payMenu
    , imageWinnerWindow = scale 0.8 0.8 endWindow
    , imageCurrPlayer = scale 0.2 0.2 currPlayer
    , imageMoveAcadem = moveAcadem
    , imagesAcademLeft =
      [ left0
      , left1
      , left2
      ]
    , imagePledgeMenu = pledgeMenu
    , imagesCube =
      [ scale 0.3 0.3 cubesOne
      , scale 0.3 0.3 cubesTwo
      , scale 0.3 0.3 cubesThree
      , scale 0.3 0.3 cubesFour
      , scale 0.3 0.3 cubesFive
      , scale 0.3 0.3 cubesSix
      ]
    , imagePledgeButton = pledgeButton
    , imageEmpty = empty
    , imagesFieldYellow =
      [ field0Yellow
      , field1Yellow
      , field2Yellow
      , field3Yellow
      , field4Yellow
      , field5Yellow
      , field6Yellow
      , field7Yellow
      , field8Yellow
      , field9Yellow
      , field10Yellow
      , field11Yellow
      , field12Yellow
      , field13Yellow
      , field14Yellow
      , field15Yellow
      , field16Yellow
      , field17Yellow
      , field18Yellow
      , field19Yellow
      , field20Yellow
      , field21Yellow
      , field22Yellow
      , field23Yellow
      , field24Yellow
      , field25Yellow
      , field26Yellow
      , field27Yellow
      , field28Yellow
      , field29Yellow
      , field30Yellow
      , field31Yellow
      , field32Yellow
      , field33Yellow
      , field34Yellow
      , field35Yellow
      , field36Yellow
      , field37Yellow
      , field38Yellow
      , field39Yellow
      ]
    , imagesFieldGreen =
      [ field0
      , field1
      , field2
      , field3
      , field4
      , field5
      , field6
      , field7
      , field8
      , field9
      , field10
      , field11
      , field12
      , field13
      , field14
      , field15
      , field16
      , field17
      , field18
      , field19
      , field20
      , field21
      , field22
      , field23
      , field24
      , field25
      , field26
      , field27
      , field28
      , field29
      , field30
      , field31
      , field32
      , field33
      , field34
      , field35
      , field36
      , field37
      , field38
      , field39
      ]

    , imageAuction = scale 1 1 auctionPic
    , imageQuestion = scale 0.2 0.2 questionPic
    , imageHelp1 = scale 1 1 help1Pic
    , imageHelp2 = scale 1 1 help2Pic
    }

-- | Сгенерировать начальное состояние игры.
initGame :: StdGen -> GameState
initGame gen = GameState
  { players =
    [ Player
      { number = 1
      , colour = 1
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 1 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 2
      , colour = 2
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 2 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 3
      , colour = 3
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 3 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 4
      , colour = 4
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 4 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 5
      , colour = 5
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 5 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 6
      , colour = 6
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 6 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player -- Фиктивный игрок
      { number = 7
      , colour = 7
      , money = 0
      , playerCell = 0
      , playerPosition = getPlayerPosition 7 1
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    ]
  , cubes = Cubes
    { firstCube = 1
    , secondCube = 1
    }
  , gamePlayer = 0 -- Чей сейчас ход
  , typeStep = stepGo -- Тип текущего шага
  , prevTypeStep = -1
  , land = getLand
  , intSeq = randomRs (1,6) gen
  , chanceCards = getChanceCards
  , intSeqChanceCards = randomRs (0, сhanceCardsCount) gen
  , currentChanceCard = 0
  , isStartMenu = True
  , countPlayers = 4
  , isIncorrectColours = False
  , isMoveToAcadem = False
  , isPledgeMenu = False
  , isAuction = False
  , menuPledgeState = MenuPledgeState
    { numCurrentStreet = 0
    }
  }

updateGame :: GameState -> GameState
updateGame gameState = gameState
  { players =
    [ Player
      { number = 1
      , colour = 1
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 1 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 2
      , colour = 2
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 2 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 3
      , colour = 3
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 3 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 4
      , colour = 4
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 4 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 5
      , colour = 5
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 5 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player
      { number = 6
      , colour = 6
      , money = 500
      , playerCell = 0
      , playerPosition = getPlayerPosition 6 0
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False
      , noProperty = True
      , auctionPrice = 0
      }
    , Player -- Фиктивный игрок
      { number = 7
      , colour = 7
      , money = 0
      , playerCell = 0
      , playerPosition = getPlayerPosition 7 1
      , inAcadem = False
      , missSteps = 0
      , hasAntiAcademCard = False 
      , noProperty = True
      , auctionPrice = 0
      }
    ]
  , cubes = Cubes
    { firstCube = 1
    , secondCube = 1
    }
  , gamePlayer = 0 -- Чей сейчас ход
  , typeStep = stepGo -- Тип текущего шага
  , land = getLand
  , chanceCards = getChanceCards
  , currentChanceCard = 0
  , isStartMenu = True
  , countPlayers = 4
  , isIncorrectColours = False
  , isMoveToAcadem = False
  , isPledgeMenu = False
  , isAuction = False
  , menuPledgeState = MenuPledgeState
    { numCurrentStreet = 0
    }
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
  | (isStartMenu gameState) && (isIncorrectColours gameState) = pictures(
    [ drawStartMenu (imageStartMenu images) gameState
    , drawPlayersPieces (imagesPiece images) (imageEmpty images) gameState
    , drawMessageAboutIncorrectColours
    , drawNet
    ])
  | (isStartMenu gameState) = pictures (
    [ drawStartMenu (imageStartMenu images) gameState
    , drawPlayersPieces (imagesPiece images) (imageEmpty images) gameState
    , drawNet
    ])
  | (isPledgeMenu gameState) = pictures(
    [ (imagePledgeMenu images)
    , drawStreetInfo (imagesFieldYellow images) (imagesFieldGreen images) gameState
    , drawNet
    ]) 
  | (isAuction gameState) = pictures (
    [ drawAuction (imageAuction images) 
    , drawAuctionInfo gameState
    , drawNet] ++ moneys)
  | (haveWinner gameState) = pictures (      -- Если игра закончена и есть победитель
    common ++
    [ drawEnd (imageWinnerWindow images)
    , drawWinnerWindow gameState
    ] )
  | (isMoveToAcadem gameState) = pictures (
    common ++
    [ drawPledgeButton (imagePledgeButton images) gameState
    , drawMoveAcademMessage (imageMoveAcadem images)
    ] )
  | (isInAcadem gameState) = pictures (
    common ++
    [ drawPledgeButton (imagePledgeButton images) gameState
    , drawAcademMessage (imagesAcademLeft images) gameState
    ] )
  | (typeStep gameState) == stepGo = pictures (
    common ++
    [ drawPledgeButton (imagePledgeButton images) gameState ]
    )
  | (typeStep gameState) == stepPay = pictures (    -- Меню для совершения покупки
    common ++ 
    [ drawPayMenu (imagePayMenu images)
    , drawInfoPic gameState (imagesFieldGreen images)
    , drawPledgeButton (imagePledgeButton images) gameState
    ]
    )
  | (typeStep gameState) == stepShowChanceCard = pictures (
    common
    ++ [ drawChanceCard gameState ]
    )
  | (typeStep gameState) == stepShowAntiAcademCard = pictures (
    common
    ++ [ drawAntiAcademCard ] 
    )
  | (typeStep gameState) == stepShowHelp1 = pictures (
    common
    ++ [ drawHelpMessage1 (imageHelp1 images) ]
  )
  | (typeStep gameState) == stepShowHelp2 = pictures (
    common
    ++ [ drawHelpMessage2 (imageHelp2 images) ]
  )
  | otherwise = pictures (
    common
    ++ [ drawPledgeButton (imagePledgeButton images) gameState ]
  )
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
    common = 
      [ drawPlayingField (imagePlayingField images)
      , drawCurrPlayer (imageCurrPlayer images) gameState
      , drawLeftCube gameState (imagesCube images)
      , drawRightCube gameState (imagesCube images)
      , drawNet 
      ] ++ moneys ++ pieces ++ help
    help = [ drawQuestion (imageQuestion images) ]

drawInfoPic :: GameState -> [Picture] -> Picture
drawInfoPic gameState pictures_list = translate 100 20 (scale 0.4 0.4 image)
  where
    player = (players gameState) !! (gamePlayer gameState)
    num = (playerCell player)
    image = pictures_list !! num

drawQuestion :: Picture -> Picture
drawQuestion image = translate 660 400 image

drawHelpMessage1 :: Picture -> Picture
drawHelpMessage1 image = translate 0 0 image

drawHelpMessage2 :: Picture -> Picture
drawHelpMessage2 image = translate 0 0 image

drawNet :: Picture
drawNet = pictures
  [ line [(0, -300), (0, 300)]
  , line [(-50, -300), (-50, 300)]
  , line [(-100, -300), (-100, 300)]
  , line [(-150, -300), (-150, 300)]
  , line [(-200, -300), (-200, 300)]
  , line [(-250, -300), (-250, 300)]
  , line [(-300, -300), (-300, 300)]
  , line [(-350, -300), (-350, 300)]
  , line [(350, -300), (350, 300)]
  , line [(300, -300), (300, 300)]
  , line [(250, -300), (250, 300)]
  , line [(200, -300), (200, 300)]
  , line [(150, -300), (150, 300)]
  , line [(100, -300), (100, 300)]
  , line [(50, -300), (50, 300)]
  , line [(-400, -300), (-400, 300)]
  , line [(400, -300), (400, 300)]
  , line [(-450, -300), (-450, 300)]
  , line [(450, -300), (450, 300)]
  , line [(-500, -300), (-500, 300)]
  , line [(500, -300), (500, 300)]
  , line [(-550, -300), (-550, 300)]
  , line [(550, -300), (550, 300)]
  , line [(-600, -300), (-600, 300)]
  , line [(600, -300), (600, 300)]
  , line [(-500, -300), (500, -300)]
  , line [(-500, -250), (500, -250)]
  , line [(-500, -200), (500, -200)]
  , line [(-500, -150), (500, -150)]
  , line [(-500, -100), (500, -100)]
  , line [(-500, -50), (500, -50)]
  , line [(-500, 0), (500, 0)]
  , line [(-500, 50), (500, 50)]
  , line [(-500, 100), (500, 100)]
  , line [(-500, 150), (500, 150)]
  , line [(-500, 200), (500, 200)]
  , line [(-500, 250), (500, 250)]
  , line [(-500, 300), (500, 300)]
  ]

drawAuction :: Picture -> Picture
drawAuction image = translate 0 0 image
  
-- | Ставки игроков на аукционе
drawAuctionInfo :: GameState -> Picture
drawAuctionInfo gameState = pictures
    [ translate x1 y1 (scale r r (text info1))
    , translate x2 y2 (scale r r (text info2))
    , translate x3 y3 (scale r r (text info3))
    , translate x4 y4 (scale r r (text info4))
    , translate x5 y5 (scale r r (text info5))
    , translate x6 y6 (scale r r (text info6))
    ]
  where
    (x1, y1) = (25, 46)
    (x2, y2) = (25, 6)
    (x3, y3) = (25, -34)
    (x4, y4) = (25, -74)
    (x5, y5) = (25, -114)
    (x6, y6) = (25, -154)
    info1 = show (auctionPrice ((players gameState) !! 0))
    info2 = show (auctionPrice ((players gameState) !! 1))
    info3 = show (auctionPrice ((players gameState) !! 2))
    info4 = show (auctionPrice ((players gameState) !! 3))
    info5 = show (auctionPrice ((players gameState) !! 4))
    info6 = show (auctionPrice ((players gameState) !! 5))
    r = 1 / 4.5

-- | Проверка, находится ли текущий игрок в академе, чтобы вывести сообщение о том, сколько осталось пропустить
isInAcadem :: GameState -> Bool
isInAcadem gameState
  | (inAcadem player) = True
  | otherwise = False
    where
      player = (players gameState) !! (gamePlayer gameState)

-- | В меню для совершения залога вывести информацию о кафедре
drawStreetInfo :: [Picture] -> [Picture] -> GameState -> Picture
drawStreetInfo imagesY imagesG gameState
  | (isPledge ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) = pictures
    [ translate x y (scale 0.8 0.8 streetInfoY)--(scale 0.6 0.6 (color red (text nameStreet)))
    , translate x2 y2 (scale r r (text pledgePrice))
    , translate x3 y3 (scale r r (text cancelPledgePrice))
    , translate x4 y4 (scale r r (text balance))
    ]
  | otherwise = pictures
    [ translate x y (scale 0.8 0.8 streetInfoG) --(scale 0.6 0.6 (color green (text nameStreet)))
    , translate x2 y2 (scale r r (text pledgePrice))
    , translate x3 y3 (scale r r (text cancelPledgePrice))
    , translate x4 y4 (scale r r (text balance))
    ]
    where
      (x, y) = (-150, 182)
      (x2, y2) = (-120, -220)
      (x3, y3) = (-130, -280)
      (x4, y4) = (0, -340)
      r = 0.2
      pledgePrice = show (div (price ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) 2)
      cancelPledgePrice = show ((div (price ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) 4) * 3)
      balance = show (money ((players gameState) !! (gamePlayer gameState)))
      --nameStreet = (name ((land gameState) !! (numCurrentStreet (menuPledgeState gameState))))
      streetInfoY = imagesY !! (numCurrentStreet (menuPledgeState gameState))
      streetInfoG = imagesG !! (numCurrentStreet (menuPledgeState gameState))


drawPledgeButton :: Picture -> GameState -> Picture
drawPledgeButton image gameState
  | not (noProperty player) = translate x y (scale r r image)
  | otherwise = Blank
    where
      (x, y) = (-500, -300)
      r = 1
      player = (players gameState) !! (gamePlayer gameState)

-- | Прорисовка левого кубика
drawLeftCube :: GameState -> [Picture] -> Picture
drawLeftCube gameState pics = translate x y image
  where
    (x, y) = (fromIntegral (100 + 15 * oneCube + 5 * twoCube), fromIntegral (-120 + 20 * oneCube + 10 * twoCube))
    image = pics !! ((firstCube (cubes gameState)) - 1)
    oneCube = (firstCube (cubes gameState))
    twoCube = (secondCube (cubes gameState))

-- | Прорисовка правого кубика
drawRightCube :: GameState -> [Picture] -> Picture
drawRightCube gameState pics = translate x y image
  where
    (x, y) = (fromIntegral (-120 - 5 * oneCube - 15 * twoCube), fromIntegral (120 - 10 * oneCube - 20 * twoCube))
    image = pics !! ((secondCube (cubes gameState)) - 1) 
    oneCube = (firstCube (cubes gameState))
    twoCube = (secondCube (cubes gameState))

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

-- | Вывести сообщение, сколько осталось пропустить ходов, если игрок находится в академе
drawAcademMessage :: [Picture] -> GameState -> Picture
drawAcademMessage images gameState = translate x y image
    where
      (x, y) = (0, 0)
      image = images !! (missSteps player)
      player = (players gameState) !! (gamePlayer gameState)

-- | Вывести сообщение, что игрок отправляется в академ, если он попал на соответствующую клетку
drawMoveAcademMessage :: Picture -> Picture
drawMoveAcademMessage image = translate x y (scale r r image)
  where
    (x, y) = (0, 0)
    r = 1

-- | Вывести фишки для их выбора игрокам
drawPlayersPieces :: [Picture] -> Picture -> GameState -> Picture
drawPlayersPieces images empty gameState = pictures
  [ translate x1 y1 (scale 2 2 (images !! ((colour ((players gameState) !! 0)) - 1)))
  , translate x2 y2 (scale 2 2 (images !! ((colour ((players gameState) !! 1)) - 1)))
  , if ((countPlayers gameState) > 2)
      then translate x3 y3 (scale 2 2 (images !! ((colour ((players gameState) !! 2)) - 1)))
      else translate (x3 - 150) y3 (scale 0.8 0.6 empty)
  , if ((countPlayers gameState) > 3)
      then translate x4 y4 (scale 2 2 (images !! ((colour ((players gameState) !! 3)) - 1)))
      else translate (x4 - 150) y4 (scale 0.8 0.6 empty)
  , if ((countPlayers gameState) > 4)
      then translate x5 y5 (scale 2 2 (images !! ((colour ((players gameState) !! 4)) - 1)))
      else translate (x5 - 150) y5 (scale 0.8 0.6 empty)
  , if ((countPlayers gameState) > 5)
      then translate x6 y6 (scale 2 2 (images !! ((colour ((players gameState) !! 5)) - 1)))
      else translate (x6 - 150) y6 (scale 0.8 0.6 empty)
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
    (x, y) = (40, 12)
    r = 1 / fromIntegral 3
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
  | (showHelp mouse) = (changeStateToHelp gameState)
  | (typeStep gameState) == stepShowHelp1 && (nextHelp mouse) = (changeToNextHelp gameState)
  | (typeStep gameState) == stepShowHelp2 && (nextHelp mouse) = (changeToPrevHelp gameState)
  | ((typeStep gameState) == stepShowHelp1 || (typeStep gameState) == stepShowHelp2) && (closeHelp mouse) = (gameCloseHelp gameState)
  | (haveWinner gameState) && (isAgainPlay mouse) = (updateGame gameState)
  | (typeStep gameState) == stepShowChanceCard = gameNextPlayer (changeChanceCardNumber (applyChance (gameState { typeStep = stepGo })))
  | (typeStep gameState) == stepShowAntiAcademCard = gameNextPlayer (gameState { typeStep = stepGo })
  | (isStartMenu gameState) = menuHandle gameState mouse
  | (isPledgeMenu gameState) = pledgeHandle gameState mouse
  | (isAuction gameState) = auctionHandle gameState mouse
  | (isMoveToAcadem gameState) = gameNextPlayer (gameState { isMoveToAcadem = False })
  | (typeStep gameState) == stepGo && (not (isPledgeFeature mouse)) = doStep gameState
  | (isPledgeFeature mouse) && not (noProperty player) && not(haveWinner gameState) = nextPledgeStreet (gameState { isPledgeMenu = True })
  | (typeStep gameState) == stepGo = doStep gameState
  | (typeStep gameState) == stepPay = case (isPay mouse) of
    Just True -> makePay gameState
    Just False -> gameState
      { players = setAuctionPrice (players gameState) field 0 (countPlayers gameState) (gamePlayer gameState)
      , typeStep = stepGo
      , isAuction = True
      }
    Nothing -> gameState
  | otherwise = gameState
    where
      player = (players gameState) !! (gamePlayer gameState)
      field = (land gameState) !! (playerCell player)
handleGame _ gameState = gameState

closeHelp :: Point -> Bool
closeHelp (x, y) = 327 < x && x < 368 && 192 < y && y < 233

showHelp :: Point -> Bool
showHelp (x, y) = 610 < x && x < 670 && 350 < y && y < 450

nextHelp :: Point -> Bool
nextHelp (x, y) = 330 < x && x < 370 && -225 < y && y < -182

changeToNextHelp :: GameState -> GameState
changeToNextHelp gameState = gameState { typeStep = stepShowHelp2 }

changeToPrevHelp :: GameState -> GameState
changeToPrevHelp gameState = gameState { typeStep = stepShowHelp1 }

gameCloseHelp :: GameState -> GameState
gameCloseHelp gameState = gameState { typeStep = (prevTypeStep gameState), prevTypeStep = -1 }

-- Изменить состояние игры на "Показать помощь" (надо вернуться в тоже состояние, в котором мы были до(!))
changeStateToHelp :: GameState -> GameState
changeStateToHelp gameState
    | (prevTypeStep gameState) == -1 = gameState { prevTypeStep = lastStep, typeStep = stepShowHelp1 }
    | otherwise = gameState
    where
      lastStep = (typeStep gameState)

isAgainPlay :: Point -> Bool
isAgainPlay (x, y) = y < -30 && y > -130 && x > -160 && x < 145

-- | Состояние игры при аукционе
auctionHandle :: GameState -> Point -> GameState
auctionHandle gameState mouse | (isNextSumPress mouse) > 0 = nextSum gameState (isNextSumPress mouse)
                              | (isPrevSumPress mouse) > 0 = prevSum gameState (isPrevSumPress mouse)
                              | (isExitFromAuction mouse) && (buyer /= 0) = (makePayAuction gameState buyer)
                              | (isExitFromAuction mouse) && (buyer == 0) = gameState {typeStep = stepGo, isAuction = False, gamePlayer = nextPlayer gameState}
                              | otherwise = gameState
                                where
                                  buyer = (findBuyer (players gameState) 0 1 0)
                                  --curr = (players gameState) !! (buyer - 1)

-- | Находим игрока, стака которого является первой наибольшей
findBuyer :: [Player] -> Int -> Int -> Int -> Int
findBuyer [] _ _ buyer = buyer 
findBuyer (player : other) maxSum num buyer | (auctionPrice player) > maxSum = findBuyer other (auctionPrice player) (num + 1) (num)
                                           | otherwise = findBuyer other maxSum (num + 1) buyer

-- | Кнопка нажатия на уменьшение ставки
isPrevSumPress :: Point -> Int
isPrevSumPress (x, y) | (x >= -100) && (x <= -50) && (y > 50) && (y <= 75) = 1
                      | (x >= -100) && (x <= -50) && (y > 0) && (y <= 45) = 2
                      | (x >= -100) && (x <= -50) && (y > -45) && (y < 5) = 3
                      | (x >= -100) && (x <= -50) && (y > -75) && (y < -50) = 4
                      | (x >= -100) && (x <= -50) && (y > -125) && (y < -75) = 5
                      | (x >= -100) && (x <= -50) && (y > -150) && (y < -125) = 6
                      | otherwise = 0

-- | Кнопка нажатия на увеличение ставки
isNextSumPress :: Point -> Int
isNextSumPress (x, y) | (x >= 150) && (x <= 200) && (y > 50) && (y <= 75) = 1
                      | (x >= 150) && (x <= 200) && (y > 0) && (y <= 45) = 2
                      | (x >= 150) && (x <= 200) && (y > -45) && (y < 5) = 3
                      | (x >= 150) && (x <= 200) && (y > -75) && (y < -50) = 4
                      | (x >= 150) && (x <= 200) && (y > -125) && (y < -75) = 5
                      | (x >= 150) && (x <= 200) && (y > -150) && (y < -125) = 6
                      | otherwise = 0

-- | Кнопка выхода из аукциона
isExitFromAuction :: Point -> Bool
isExitFromAuction (x, y) | (x >= 250) && (x <= 350) && (y >= -100) && (y <= 0) = True
                         | otherwise = False

-- | Настраиваем первоначальные ставки, равными стоимости участка (исключая не играющих игроков)
setAuctionPrice :: [Player] -> Street -> Int -> Int -> Int -> [Player]
setAuctionPrice [] _ _ _ _ = []
setAuctionPrice (player : other) street numPlayer countPlayer currPlayer | (numPlayer /= currPlayer) && (numPlayer < countPlayer) && ((money player) >= (price street)) = (player {auctionPrice = (price street)} : (setAuctionPrice other street (numPlayer + 1) countPlayer currPlayer)) 
                                                                         | otherwise = (player {auctionPrice = 0} : (setAuctionPrice other street (numPlayer + 1) countPlayer currPlayer))

-- | Увеличиваем сумму ставки на следующую +10
nextSum :: GameState -> Int -> GameState
nextSum gameState num 
  | ((num - 1) /= currPlayer) && ((money player) >= ((auctionPrice player) + 10)) && (num <= (countPlayers gameState)) 
    = gameState 
      { players = firstPlayers ++ [player {auctionPrice = changeAuctionPricePlus gameState num}] ++ lastPlayers} 
  | otherwise = gameState
    where
      player = (players gameState) !! (num - 1)
      firstPlayers = take (num - 1) (players gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
      currPlayer = (gamePlayer gameState)
      --currPlayer = (players gameState) !! (gamePlayer gameState)
      --field = (land gameState) !! (playerCell currPlayer)

-- | Уменьшаем сумму ставки на следующую -10
prevSum :: GameState -> Int -> GameState
prevSum gameState num 
  | ((num - 1) /= currPlayer) && ((money player) >= (auctionPrice player)) && ((auctionPrice player) >= 10) && (num <= (countPlayers gameState)) 
    = gameState {players = firstPlayers ++ [player {auctionPrice = changeAuctionPriceMinus gameState num}] ++ lastPlayers} 
  | otherwise = gameState
    where
      player = (players gameState) !! (num - 1)
      firstPlayers = take (num - 1) (players gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
      currPlayer = (gamePlayer gameState)

changeAuctionPriceMinus :: GameState -> Int -> Int
changeAuctionPriceMinus gameState num 
  | ((auctionPrice player)  == (price field)) = 0
    | otherwise = (auctionPrice player) - 10
        where
            player = (players gameState) !! (num - 1)
            currPlayer = (players gameState) !! (gamePlayer gameState)
            field = (land gameState) !! (playerCell currPlayer)

changeAuctionPricePlus :: GameState -> Int -> Int
changeAuctionPricePlus gameState num 
    | (auctionPrice player) == 0 = (price field) 
    | otherwise = (auctionPrice player) + 10
        where
            player = (players gameState) !! (num - 1)
            currPlayer = (players gameState) !! (gamePlayer gameState)
            field = (land gameState) !! (playerCell currPlayer)
-- | Осуществляем платеж после совершения аукциона
makePayAuction :: GameState -> Int -> GameState
makePayAuction gameState num = gameState
  { typeStep = stepGo
  , players = firstPlayers ++ [setNoProperty (changeBalance player priceValue)] ++ lastPlayers
  , land = firstLands ++ [changeOwner currentLand (num - 1) ] ++ lastLands
  , isAuction = False
  , gamePlayer = nextPlayer gameState
  }
    where
      currPlayer = (players gameState) !! (gamePlayer gameState)
      firstPlayers = take (num - 1) (players gameState)
      player = (players gameState) !! (num - 1)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))
      priceValue = (auctionPrice player) * (-1)
      firstLands = take (playerCell currPlayer) (land gameState)
      currentLand = (land gameState) !! (playerCell currPlayer)
      lastLands = reverse (take (length (land gameState) - length(firstLands) - 1) (reverse (land gameState)))


-- | Если во время хода игрок нажал на клавишу, чтобы совершить залог
isPledgeFeature :: Point -> Bool
isPledgeFeature (x, y) = x < -400 && y < -220

pledgeHandle :: GameState -> Point -> GameState
pledgeHandle gameState mouse
  | (isNextStreetPress mouse) = nextPledgeStreet gameState
  | (isPrevStreetPress mouse) = prevPledgeStreet gameState
  | (pledgeStreetPress mouse) = doPledgeStreet gameState
  | (exitFromPledgeMenu mouse) = gameState { isPledgeMenu = False }
  | otherwise = gameState

-- | Проверки, какие клавишу нажимаются
isNextStreetPress :: Point -> Bool
isNextStreetPress (x, y) = x > 200 && x < 250 && y > 150 && y < 250

isPrevStreetPress :: Point -> Bool
isPrevStreetPress (x, y) = x < -520 && x > -575 && y > 150 && y < 250


-- | Совершить действие залога и вернуться в игру
pledgeStreetPress :: Point -> Bool
pledgeStreetPress (x, y) = y > -75 && y < 75 && x < 100 && x > -350

exitFromPledgeMenu :: Point -> Bool
exitFromPledgeMenu (x, y) = x > 0 && y < 0

doPledgeStreet :: GameState -> GameState
doPledgeStreet gameState
  | (isPledge ((land gameState) !! (numCurrentStreet (menuPledgeState gameState))))
    && (hasMoney player (div (price ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) 4 * (3))) = gameState
      { land = changePledgeStatus (land gameState) (numCurrentStreet (menuPledgeState gameState))
      , players = firstPlayers ++ [changeBalance player (div (price ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) 4 * (-3))] ++ lastPlayers
      }
  | (isPledge ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) = gameState
  | otherwise = gameState
    { land = changePledgeStatus (land gameState) (numCurrentStreet (menuPledgeState gameState))
    , players = firstPlayers ++ [changeBalance player (div (price ((land gameState) !! (numCurrentStreet (menuPledgeState gameState)))) 2)] ++ lastPlayers
    }
    where
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take (length (players gameState) - (length firstPlayers) - 1) (reverse (players gameState)))

hasMoney :: Player -> Int -> Bool
hasMoney player summ = (money player) > summ

changePledgeStatus :: [Street] -> Int -> [Street]
changePledgeStatus streets num = firstStreets ++ [street {isPledge = not (isPledge street)}] ++ lastStreets
  where
    firstStreets = take num streets
    street  = streets !! num
    lastStreets = reverse (take ((length streets) - num - 1) (reverse streets))

nextPledgeStreet :: GameState -> GameState
nextPledgeStreet gameState = gameState
    { menuPledgeState = MenuPledgeState
      { numCurrentStreet = getNextStreetWithOwner (land gameState) (numCurrentStreet (menuPledgeState gameState)) (gamePlayer gameState)
      }
    }

prevPledgeStreet :: GameState -> GameState
prevPledgeStreet gameState = gameState
  { menuPledgeState = MenuPledgeState
    { numCurrentStreet = getPrevStreetWithOwner (land gameState) (numCurrentStreet (menuPledgeState gameState)) (gamePlayer gameState)
    }
  }

getNextStreetWithOwner :: [Street] -> Int -> Int -> Int
getNextStreetWithOwner streets currStreet playerNum
  | (owner (streets !! (mod (currStreet + 1) 40))) == playerNum = mod (currStreet + 1) 40
  | otherwise = getNextStreetWithOwner streets (mod (currStreet + 1) 40) playerNum

getPrevStreetWithOwner :: [Street] -> Int -> Int -> Int
getPrevStreetWithOwner streets currStreet playerNum
  | (owner (streets !! (mod (currStreet - 1 + 40) 40))) == playerNum = mod (currStreet - 1 + 40) 40
  | otherwise = getPrevStreetWithOwner streets (mod (currStreet - 1 + 40) 40) playerNum

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
      firstPlayers = take num (take (countPlayers gameState) (players gameState))
      lastPlayers = reverse (take ((countPlayers gameState) - (length firstPlayers) - 1) (reverse (take (countPlayers gameState) (players gameState))))
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
  | (length (filter haveMoney (take (countPlayers gameState) (players gameState)))) >= 2 = False
  | otherwise = True

haveMoney :: Player -> Bool
haveMoney player = (money player) > 0

-- | Меню покупки: что выбрал игрок
isPay :: Point -> Maybe Bool
isPay (x, y) | x < -50 && x > -200 && y > -85 && y < -35 = Just True
             | x > 50 && x < 200 && y > -85 && y < -35 = Just False
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
makeMove gameState = makeStepFeatures (changePlayerCell (startMoney (throwCubes gameState)))

makeStepFeatures :: GameState -> GameState
makeStepFeatures gameState
    -- Если поле нельзя купить => нужно отдать налоги и дать деньги владельцу
    -- и перейти к следующему игроку
  | currentField == 30 = doAcadem gameState
  | not (canBuy gameState) && not (isChanceLand currentStreet) = gameNextPlayer (getPriceRent (payPriceRent gameState))
  | otherwise = gameState
    where
      currentField = (playerCell player)
      currentStreet = (land gameState) !! (currentField)
      player = (players gameState) !! (gamePlayer gameState)

doAcadem :: GameState -> GameState
doAcadem gameState 
    | (hasAntiAcademCard player) = showAntiAcademCard gameState 
    | otherwise = (changeIsMoveToAcadem (moveToAcadem gameState))
      where
        player = (players gameState) !! (gamePlayer gameState)

showAntiAcademCard :: GameState -> GameState
showAntiAcademCard gameState = gameState
  { typeStep = stepShowAntiAcademCard }

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

-- | True, если текущее поле - "Шанс"
isChanceLand :: Street -> Bool
isChanceLand street = (name street)  == "Шанс"

drawAntiAcademCard :: Picture
drawAntiAcademCard = translate x y (scale r r (color red (text "Player has antiacadem card! :))))")))
    where
      x = -200
      y = 400
      r = 0.3

-- | Нарисовать сообщение у карточки Шанс
drawChanceCard :: GameState -> Picture
drawChanceCard gameState = translate x y (scale r r (text chanceCardTitle))
    where
      x = -200
      y = 400
      r = 0.3
      chanceCardTitle = (title ((chanceCards gameState) !! (currentChanceCard gameState)))

-- | Применить карточку Шанс
applyChance :: GameState -> GameState
applyChance gameState 
    | chanceCardNumber == 2 = doAcadem gameState 
    | chanceCardNumber == 4 = gameState 
      { players = firstPlayers ++ [ player { hasAntiAcademCard = True } ] ++ lastPlayers }
    | otherwise = gameState
      { players = firstPlayers ++ [(movePlayerNewPosition (changeBalance player balanceFromCard) newPositionFromCard)] ++ lastPlayers
      , typeStep = stepGo
      }
    where
      chanceCardNumber = (currentChanceCard gameState)
      firstPlayers = take (gamePlayer gameState) (players gameState)
      player = (players gameState) !! (gamePlayer gameState)
      lastPlayers = reverse (take ((length (players gameState)) - (length firstPlayers) - 1) (reverse (players gameState)))
      balanceFromCard = (balanceChange ((chanceCards gameState) !! chanceCardNumber))
      newPositionFromCard = (newPosition ((chanceCards gameState) !! chanceCardNumber))

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

changeChanceCardNumber :: GameState -> GameState
changeChanceCardNumber gameState =
  let
    list = intSeqChanceCards gameState
    next_number = head list
    nextList = drop 1 list
  in gameState
    { currentChanceCard = next_number
    , intSeqChanceCards = nextList
    }

-- | Совершение покупки спецсеминара
makePay :: GameState -> GameState
makePay gameState = gameState
  { typeStep = stepGo
  , players = firstPlayers ++ [setNoProperty (changeBalance player priceValue)] ++ lastPlayers
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

-- | Установка флага, что у игрока есть имущество
setNoProperty :: Player -> Player
setNoProperty player = player {noProperty = False}

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

-- | Переходим различные состояния, в зависимости от клетки
getTypeByCell :: Int -> GameState -> Int
getTypeByCell index gameState
  | isChanceLand ((land gameState) !! index) == True = stepShowChanceCard
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

movePlayerNewPosition :: Player -> Int -> Player
movePlayerNewPosition player newPlayerPosition
    | newPlayerPosition == -1 = player
    | otherwise = player 
      { playerCell = newPlayerPosition
      , playerPosition = getPlayerPosition (number player) newPlayerPosition
      }

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
