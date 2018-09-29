module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map)
import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = Right nucleotideCountsMap
  where
    nucleotideCountsMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

valid :: Char -> Either String Nucleotide
valid c = case c of
  'A' -> Right A
  'C' -> Right C
  'G' -> Right G
  'T' -> Right T
  _   -> Left $ "Invalid nucleotide " ++ show c
