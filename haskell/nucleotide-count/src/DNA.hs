module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map)
import qualified Data.Map as Map

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs =
  countNucleotide xs nucleotideCountsMap
  where
    nucleotideCountsMap = Map.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]

countNucleotide :: String -> Map Nucleotide Int -> Either String (Map Nucleotide Int)
countNucleotide "" nucleotideCountsMap = Right nucleotideCountsMap

countNucleotide (x:xs) nucleotideCountsMap =
  handleNucleotide (toNucleotide x) xs nucleotideCountsMap

handleNucleotide :: Either String Nucleotide -> String -> Map Nucleotide Int -> Either String (Map Nucleotide Int)
handleNucleotide (Right nucleotide) xs nucleotideCountsMap =
  countNucleotide xs (Map.adjust (1 +) nucleotide nucleotideCountsMap)
handleNucleotide (Left message) _ _ = Left message


toNucleotide :: Char -> Either String Nucleotide
toNucleotide c = case c of
  'A' -> Right A
  'C' -> Right C
  'G' -> Right G
  'T' -> Right T
  _   -> Left $ "Invalid nucleotide " ++ show c
