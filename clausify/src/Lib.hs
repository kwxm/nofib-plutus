{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeApplications      #-}
{-# OPTIONS_GHC -fexpose-all-unfoldings       #-}
{-# OPTIONS_GHC -fno-ignore-interface-pragmas #-}
{-# OPTIONS_GHC -fno-spec-constr              #-}
{-# OPTIONS_GHC -fno-warn-unused-imports      #-}
{-# OPTIONS_GHC -fno-warn-unused-matches      #-}

module Lib
where

import qualified Language.PlutusCore.Pretty as PLC
import qualified Language.PlutusTx.Prelude  as Tx hiding (init, last)
-- We have to define our own versions of last and init,
-- but the standard ones are re-exported from PlutusTx.Prelude


{- A very simple example. Calling `Tx.compile [|| Lib.incrIThing ||]`
   in Main.hs causes an "Unsupported feature" error. -}


data IThing = IThing Tx.Integer

{-# INLINABLE incrThing #-}
incrThing :: IThing -> IThing
incrThing (IThing n) = IThing (n Tx.+ 1)

data Thing = Thing Tx.Integer [Tx.Integer]


{-  A more complicated example, closer to the actual program I'm trying to build.. -}

{-# INLINABLE last #-}
last :: [a] -> a
last []     = Tx.error ()
last [a]    = a
last (_:as) = last as

{-# INLINABLE init1 #-}
init1 :: [a] -> [a]
init1 []                 =  Tx.error ()
init1 (x:xs)             =  aux x xs
  where aux _ []     = []
        aux y (z:zs) = y : aux z zs

{-# INLINABLE init2 #-}
init2 :: [a] -> [a]
init2 l =
    case Tx.reverse l of
      []  -> Tx.error ()
      _:t -> Tx.reverse t

{-# INLINABLE secondLast #-}
secondLast :: [a] -> a
secondLast l =
    case Tx.reverse l of
      []    -> Tx.error ()
      [_]   -> Tx.error ()
      _:a:_ -> a

{-# INLINABLE deleteFirst #-}
deleteFirst :: Thing -> Thing
deleteFirst (Thing f ts) =
    Thing f' ts'
        where ts' = init2 ts  -- OK with init1
              f' = last ts'   -- OK with secondLast ts

{- If you run the main program (modified to compile `deleteFirst`) with this
   definition of deleteFirst then you get a message

     tx-problem-exe: Error: Unsupported feature: Kind: *
             -> *
             -> TYPE
                  ('GHC.Types.TupleRep
                     '[ 'GHC.Types.LiftedRep, 'GHC.Types.LiftedRep])


   If you put  Thing f ts'  instead of  Thing f' ts'  then it works.
   If you change the definition of init2 to be the identity function or
   something similar then it also works.

   You can also change the definition of 'Thing' to 'Thing [Tx.Integer]'
   (or 'Thing [Tx.Bool]') and deleteFirst to

     deleteFirst (Thing ts) =
       Thing (f:ts')
        where ts' = init2 ts
              f   = last ts'

   and it still fails.

   The fact that the various list functions are polymorphic doesn't matter:
   you can change all the 'a's to Tx.Integer and the problem still occurs.

   If you put all this stuff into Main then the problem (apparently) goes
   away.  I don't think I can do this with the real program though: I need
   an instance of Eq for (the real version of) Thing, and the compiler
   insists that that should be imported because of staging restrictions
   due to Template Haskell.

-}

