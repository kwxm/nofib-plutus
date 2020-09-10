{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE NamedFieldPuns      #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE RecordWildCards     #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}
{-# OPTIONS_GHC -fno-ignore-interface-pragmas #-}

module Test
where

import           Language.PlutusCore.Universe
import qualified Language.PlutusTx            as PlutusTx
import           Language.PlutusTx.Prelude    hiding (Semigroup (..), foldMap)

f :: Integer -> String
f n = "This is a test: n is " ++ (if n < 0 then "negative" else if n==0 then "zero" else "positive")

y :: PlutusTx.CompiledCode DefaultUni (Integer -> String)
y = $$(PlutusTx.compile [||f||])

g :: () -> Integer
g () = 5

z :: PlutusTx.CompiledCode DefaultUni (() -> Integer)
z = $$(PlutusTx.compile [||g||])
