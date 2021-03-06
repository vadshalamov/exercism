module Bob (responseFor) where

import Data.String.Utils (strip, endswith)
import Data.Char

responseFor :: String -> String
responseFor xs
  | isSilence strippedInput = "Fine. Be that way!"
  | isYell strippedInput && isQuestion strippedInput = "Calm down, I know what I'm doing!"
  | isYell strippedInput = "Whoa, chill out!"
  | isQuestion strippedInput = "Sure."
  | otherwise = "Whatever."
  where
    strippedInput = strip xs

isSilence :: String -> Bool
isSilence = null

isYell :: String -> Bool
isYell xs = all(\x -> toUpper x == x) xs && any(\x -> toLower x /= x) xs

isQuestion :: String -> Bool
isQuestion = endswith "?"
