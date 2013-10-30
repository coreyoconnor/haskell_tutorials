module Main where

import Regex

import Test.Framework.Runners.Console
import Test.Framework.Providers.SmallCheck
import Test.SmallCheck
import Test.SmallCheck.Series

main = defaultMain
    [ testProperty "simple strings match" $ \(prefix,string,suffix) -> True == match (regex string) ]
