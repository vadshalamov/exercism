module Bob (responseFor) where

import Data.String.Utils
import Data.Char

responseFor :: String -> String
responseFor xs
  | isSilence strippedInput = "Fine. Be that way!"
  | isYell strippedInput = handleYell xs
  | isQuestion strippedInput = "Sure."
  | otherwise = "Whatever."
  where
    strippedInput = strip xs

isSilence :: String -> Bool
isSilence "" = True
isSilence _ = False

isYell :: String -> Bool
isYell xs = map toUpper xs == xs && map toLower xs /= xs

isQuestion :: String -> Bool
isQuestion = endswith "?"

handleYell :: String -> String
handleYell xs = if isQuestion xs then "Calm down, I know what I'm doing!" else "Whoa, chill out!"
