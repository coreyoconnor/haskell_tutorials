module Regex where

import Data.List (isInfixOf)

data Regex = Regex String

match :: String -> Regex -> Bool
match in_str (Regex match_str) = match_str `isInfixOf` in_str

regex :: String -> Regex
regex str = Regex str

