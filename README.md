## `nofib` benchmarks for Plutus

The [nofib](https://github.com/ghc/nofib) benchmark suite contains
a number of "realistic" Haskell progams used for benchmarking.
See [this paper](https://downloads.haskell.org/ghc/papers/nofib.ps.gz) (ps.gz)
for more information.  Brief notes on all of the programs can be found
in [nofib.md](./nofib.md).

This repository contains versions of some of these programs as
Plutus programs.  The nofib programs are generally quite old
(mostly written in the early 1990s) and don't bear much resemblance
to typical modenr Haskell programs (which may be an advantage,
since they should be more acceptable to the Plutus compiler).
I've resisted the tempation to modernise the programs, except
that most of them have no type signatures for functions and
I've added signatures (sometimes less general than they could be).

The programs that I've ported so far are

  * clausify
  * knights
  * lastpiece
  * primetest

Apart from `knights` these all consist of a single source file.
The `primetest` program originally consisted of several Literate
Haskell source files, but I converted it into a single file
and removed most of the literate stuff.  All of the source
files are contained in the relevant `app` subdirectory.

The programs have all been converted into standalone programs which it should be
possible to run by typing `stack run` in the relcevant directory: this produces
textual PLC output which I've been running via the `plc` command, but it would
be straightforward to have the CEK machine execute the code directly.  Paths to
various `plutus-*` libraries will need to be updated in `stack.yaml`.

**WARNING** The `lastpiece` program solves a fixed-size puzzzle.  The Haskell
version runs quite quickly, but on the CEK machine the Plutus Core version
quickly runs out of memory. It may be possible to fix this, but in the meantime
`lastpiece` shouldn't be used for benchmarking.

With the exception of `lastpiece`, each program is supplied with some arguments
in `Main.hs` which makes the program run in a few seconds and use 2 or 3 GB of
memory.  These inputs could be changed if required.  Most programs also
can also be run directly as Haskell programs with suitable modifications (often
already contained in the source file, possibly commented out).


### Problems
A number of problems arose while I was porting the programs.

  * **Compilation flags.**  I had quite a lot of trouble getting
  the compilation flags right, particularly in programs involving
  multiple files.  You generally seem to be able to get away with

      * -fno-strictness
      * -fno-specialise
      * -fno-spec-constr
  
  *  but may also need some or all of 

      * -fexpose-all-unfoldings
      * -fno-ignore-interface-pragmas
      * -fno-omit-interface-pragmas
      * -fno-worker-wrapper

   especially if there are multiple source files (in that case I found it best
   to put the flags in the cabal file since it was impossible to get them right
   in several different files, but it was OK (and possibly easier) to put them
   in pragmas at the top of the file if there was only one source file).

  * **Ints**.  The `Int` type is used extensively.  Plutus Core
  doesn't support this type, so I've converted all of these
  to `Integer`.  This has involved re-implementing some functions (see below).

  * **Floats.**  Many of the programs use the `Float` and `Double` types
  (see [nofib.md](./nofib.md)).  Plutus Core doesn't support these types
  at all, so I've ignored all of these programs.

  * **Characters.** Quite a few of the programs use the `Char` type
  quite extensively.  Plutus Core currently provides only limited
  support for characters, so these programs also mostly have had
  to be ignored (except for the `clausify` program, which used
  characters for variable IDs; I've replaced these with `Integer`
  IDs).  Some more support for characters might be usesful, in particular

     * Instances of `Eq` and `Ord` for `Char`.
     * Conversions to and from `Integer` (ie, `chr` and `ord`).
     * Perhaps easier access to individual characters within strings.

   See SCP-1163.

  * **Laziness.** A number of the programs use laziness, in particular
      infinite lists.  This has necessitated some rewriting.

  * **Operator precedence.** Implementations of `==`, `<=` and so on
    are provided for `Integer` in `PlutusTx.Prelude`.  These don't
    have any precedence declarations, so sometimes they're not parsed
    as you'd expect.  For instance, it was necessary to insert some brackets
    in guards in function definitions.  **We should fix this in Prelude.hs**: see SCP-1159.

  * **Literal patterns.** The compiler can't handle matches on (at least)
    literal integers (`f x 1 = ... | f y 3 = ...`), so these have had to be replaced with
    chains of `if...then...else` expressions.

  * **Lazy let-bindings.** Some let-bindings are evaluated lazily, in particular
    ones of the form `let (a, b) = f(...)`.  The problem with this is that `f`
    is evaluated when you use `a` and again when you use `b`.  This led to a
    slowdown by a factor of four in the `primality` program (which has the state
    for a random number generator threaded through it, requiring several
    functions to return pairs).  This was quite difficult to diagnose, but could
    be solved by using `case` to deconstruct the pairs.

  * **Library functions.** The `PlutusTx` prelude exports new definitions for
    many standard library functions, but not all (for instance `take`, `init`,
    `divMod`).  Several programs provide their own replacements for these: we
    should probably collect all of these in one place where they can be shared
    amongst benchmarks.


  * **Unexpected error messages.** Several of the programs use library functions
  such as `div` and `divMod` which are not redefined by the PlutusTx prelude.
  trying to compile these gives the unexpected error message `GHC Core to PLC
  plugin: Error: Unsupported feature: Use of Haskell Integer equality, possibly
  via the Haskell Eq typeclass`.  It turns out that this is because the functions
  are inlined and use matches on literal values internally.  The program does contain
  uses of `Eq`, but they don't appear in the source.