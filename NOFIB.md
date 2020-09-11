## Summary of`nofib` programs

The `nofib` repository contains 3 main subdirectories: `real` (realistic programs),
`spectral` (slightly less realistic programs), and `imaginary` (rather trivial programs).
Here are some brief notes on the various programs contained in those directories.

### real

*   anna
     *	Strictness analyser.  9591 lines



*   bspt
     *	Binary space partitioning trees.  2173 lines of hs and lhs
	Has its own implementation of Rationals (quotients of Ints).



*   cacheprof
     *	x86 assembly code annotator for cache profiling.  2158 lines.



*   compress
     *	LZW compression.  Lots of source files.  773 lines.


*   compress2
     * A simpler compression algorithm, smaller. 237 lines.


*   eff
      * Seems to be lots of benchmarks for state monads.
        Seven source code directories with different benchmark programs, 436 lines.


*   fem
      *  Finite Element Module.  1321 lines of hs.  Uses Float.


*   fluid
     * I think this is a fluid dynamics simulation.  Lots of linear algebra,
	including stuff about Choleski decompositions. 2439 lines. Uses Float.


*   fulsom
     * Solid modeller, produces graphic output (although you could just produce
           binary output).  Uses Float/Double. 1418 lines.


*   gamteb
     * Monte Carlo code for transportation of gamma rays in a carbon cylinder.
	Uses Double.  731 lines.


*   gg
     * Graphs for statistics for spark pool allocation in GRIP(?)  Uses Float. 844 lines.


*   grep
     * Grep, using NFAs.  Quite complicated.  392 lines.


*   hidden
     * Looks like hidden line elimination.  Uses Float.  543 lines.


*   hpg
     *	Haskell Program Generator.  Uses Float, but that could be removed. 2102 lines.


*   infer
     * Hindley-Milner type inference. 623 lines.


*   lift
     *	Lazy lambda-lift generator.  2060 lines.


*   linear
     *	Linear algebra functions.  Uses Float. 2168 lines.


*    maillist
     * Mailing list generator.  Single file, 174 lines.  Uses files a lot.


*   mkhprog
     * Haskell program skeletons.  838 lines.


*   parser
     *	Partial Haskell parser.  1412 lines.


*   pic
     *	Particle in Cell. Electrodynamics simulation: particles moving in mutually-induced
	electric fields in a toroidal space. Uses Double.  559 lines.


*   prolog
     *	Mini-Prolog interpreter. 678 lines.


*   reptile
     *	Escher tiling program.  1557 lines.


*   rsa
     *	RSA encoding/decoding. 110 lines.


*   scs
     * Set Circuit Simulator (resistors, capacitors, etc.).  Uses Double.  586 lines.


*   symalg
     * Algebraic expressions.  Uses reals (approximation?). 1178 lines.


*  veritas
     * Theorem prover.  11164 lines.


### spectral

*   ansi
     * Simple program using escape sequences to do stuff on a terminal.


*   atom
     * Simulation of movement of an atom (I think).  Uses Float.


*   awards
      * Simple program calculating awards based on scores in a number of events.


*   banner
      * ASCII banner: a very small program.


*   boyer
     * Gabriel suite 'boyer' benchmark.  Term rewriting.


*    boyer2
     *  Another version of boyer.  Larger examples.


*   calendar
     * Calendar generator.


*   cichelli
     * Perfect hashing function.


*   circsim
     * Circuit simulator.


*   clausify
     * Propositions to clausal form.


*   constraints
     * Constraint solver solving nxn queens problem.  This is quite
       sophisticated: it has a generic constraint solver which can
       be fed five different algorithms for solving the problem.
       These each have different time and space requirements.


*   cryptarithm1
     * Cryptarithm solver (THIRTY+FIVE*TWELVE = NINETY)


*   cryptarithm2
     * Cryptarithm again


*   cse
     * Common subexpression elimination.  Produces no output.
          You have to run it thousands of times for it to take any
          appreciable time (in Haskell).  Cycles through 6 inputs.


*   dom-lt
     * Calculate dominators in graphs.  Takes a reasonable amount of time.

*   eliza
     * Eliza


*   exact-reals
     * Exact real arithmetic.


*   expert
     * Small expert system.  Does unification and inference.


*    fft2
     * Fast Fourier transform.  Uses Double.


*    fibheaps
     * Fibonacci heap implementation. Data structures, folds, etc.


*    fish
     * Draws Escher's fish.  No output.


*    gcd
     * Calculates GCDs, using Int and Integer.


*    hartel
     * Not really sure. Converting another language to Haskell?


*    integer
     * Simple Integer benchmarks.  Perhaps actually interesting.


*    knights
     * Knight's tour.  886 lines.


*    lambda
     * "This program contrasts the cost of direct and state-monadic style of computation.
           Experiments with Higher-Order mappings over terms."


*   last-piece
     * "Last piece puzzle."  Apparently solving a tricky jigsaw puzzle. Lots of lists.


*    lcss
     * Longest common subsequence algorithm.


*    life
     * Game of Life.


*    mandel
     * Mandelbrot sets.  Uses Doubles.


*    mandel2
     * Mandelbrot sets.  Uses Doubles.


*    mate
     * Chess endgame problem solver.  425 lines. Quite a lot of data structures.


*    minimax
     * Noughts and crosses.


*    multiplier
     * Binary multiplier simulator. Lots of lists.


*    para
     * Paragraph formatting.


*    power
     * Operations on power series.


*    pretty
     * Prettyprinter.  Heavy on character sequence operations, as you'd expect.


*    primetest
     * Probablistic primality testing.  305 lines of lhs.


*    puzzle
     * Solving some puzzle.


*    rewrite
     * Rewriting system.  636 lines of lhs.  Unification etc.


       
*   scc
     * Strongly-connected components of digraphs.  Tiny.


*    secretary
     * Small probability calculation: 75 lines of lhs, uses Doubles.


*    simple
     * Physics computations.  Extensive use of Double.


*    sorting
     * Implementations of multiple sorting algorithms.  Needs a big input.


*    sphere
     * Ray tracer for spheres.  Lots of Doubles.


*    treejoin
     * Tree operations.  Needs big input.
          

       
### imaginary

*   bernouilli
     * Bernoulli numbers.


*    digits-of-e1
     * Continued fraction calculations.
          

*    digits-of-e2
     * Another version, using lazy lists.


*    exp3_8
     * Calculates 3^ using Peano numbers.  Quickly starts to take a long time.


*    gen_regexps
     * "Generate all the expansions of a generalised regular expression.".
             Very fast.

      
*    integrate
     *    Numeric integration of xy over an 8x8 grid. Uses Doubles.

       

*   kahan
     * "Implementation of Kahan summation algorithm that tests performance
             of tight loops involving unboxed arrays and floating point arithmetic."
          

*   paraffins
     * "The Paraffins problem is to generate all distinct paraffins of a given size.
            It is essentially an unrooted-tree isomorphism problem."
          

*   primes
     * The Sieve of Eratosthenes as a lazy list.  Sixteen lines.
          

*    queens
     * Count the number of solutions to th n queens problem.  Nineteen lines.


*    rfib
     * Recursive calculation of Fibonacci numbers.
          

*    tak
     * "Code of unknown provenance."
        tak x y z = if y >= x then z else tak (tak (x-1) y z) (tak (y-1) z x) (tak (z-1) x y).
        See https://en.wikipedia.org/wiki/Tak_(function)


*   wheel-sieve1
     * Wheel sieves for primes, mark I.


*    wheel-sieve2
     * Wheel sieves for primes, mark II.


*    x2n1
     * Summing up roots of unity.
