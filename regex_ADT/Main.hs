{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Regex

import Test.Framework.Runners.Console
import Test.Framework.Providers.SmallCheck
import Test.SmallCheck
import Test.SmallCheck.Series

class DataSet set_id where
    data_set :: set_id -> [String]

data Set0

instance DataSet Set0 where
    data_set _ = [ "A"
                 , "AB"
                 , "B"
                 , ""
                 ]

data Set1

instance DataSet Set1 where
    data_set _ = [ "X"
                 , "XY"
                 , "Y"
                 , ""
                 ]

newtype SmallString set_id = SmallString String
    deriving (Show)

instance (DataSet set_id, Monad m) => Serial m (SmallString set_id) where
    series = generate $ \n -> take n $ map SmallString $ data_set (undefined :: set_id)

small_string_match :: SmallString Set0 -> SmallString Set1 -> SmallString Set0 -> Bool
small_string_match (SmallString prefix) (SmallString s) (SmallString suffix)
    = (prefix ++ s ++ suffix) `match` (regex s)

main = defaultMain
    [ testProperty "simple strings match" small_string_match
    ]
