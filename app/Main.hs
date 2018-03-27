module Main where

import Monopoly

main :: IO ()
main = do
  images <- loadImages
  startGame images
