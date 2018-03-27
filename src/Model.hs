module Model where

import Graphics.Gloss.Juicy
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Interface.Pure.Game
-- =========================================
-- Модель
-- =========================================

-- | Изображения объектов.

data Images = Images
  { imagePieceRed    :: Picture   -- ^ Изображение фишек.
  , imagePieceBlue   :: Picture
  , imagePieceGreen  :: Picture
  , imagePieceYellow :: Picture
  , imagePlayingField :: Picture
  , imagePayMenu :: Picture
  }

data GameState = GameState
  { players :: [Player]
  , gamePlayer :: Int
  , haveWinner :: Maybe Int
  , cubes :: Cubes
  , land :: [Street]
  , typeStep :: Int
  }

data Player = Player
  { colour :: Int
  --, name :: String
  , money :: Int
  , property :: [Street]
  , playerCell :: Int
  , playerPosition :: Point
  --, position :: Int
  }

data Street = Street
  { name :: String
  , price :: Int
  , isRent :: Bool
  , priceRent :: Int
  , owner :: Int
  }

data Cubes = Cubes
  { firstCube :: Int
  , secondCube :: Int
  }

