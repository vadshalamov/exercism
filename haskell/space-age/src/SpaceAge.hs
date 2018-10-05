module SpaceAge (Planet(..), ageOn) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune
            deriving (Eq)

earthYearLength :: Float
earthYearLength = 31557600

mercuryYearLength :: Float
mercuryYearLength = earthYearLength * 0.2408467

venusYearLength :: Float
venusYearLength = earthYearLength * 0.61519726

marsYearLength :: Float
marsYearLength = earthYearLength * 1.8808158

jupiterYearLength :: Float
jupiterYearLength = earthYearLength * 11.862615

saturnYearLength :: Float
saturnYearLength = earthYearLength * 29.447498

uranusYearLength :: Float
uranusYearLength = earthYearLength * 84.016846

neptuneYearLength :: Float
neptuneYearLength = earthYearLength * 164.79132

ageOn :: Planet -> Float -> Float
ageOn planet seconds
  | planet == Mercury = seconds / mercuryYearLength
  | planet == Venus = seconds / venusYearLength
  | planet == Earth = seconds / earthYearLength
  | planet == Mars = seconds / marsYearLength
  | planet == Jupiter = seconds / jupiterYearLength
  | planet == Saturn = seconds / saturnYearLength
  | planet == Uranus = seconds / uranusYearLength
  | planet == Neptune = seconds / neptuneYearLength
  | otherwise = error "unknown planet"
