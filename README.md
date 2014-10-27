# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


## Benchmarks (master branch)

The original Python program has been compared with the Swift debug and
release version.

The average time and the maximum time (in seconds) of solving a Sudoku
grid will be measured. Also, the number of solutions per second is
calculated from the average time, this shows a better resolution for
very short solving times.

The release version of the Swift program is about 60 times faster than
the debugging version and performs three times faster than the original
Python program.


### Easy Puzzles (easy50.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.099         | 0.0017          |
| maximum   |  0.01  | 0.12          | 0.0022          |
| frequency |  199   | 10.1          | 595             |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 0.34          | 0.0053          |
| maximum   |  0.09  | 1.6           | 0.024           |
| frequency |  56    | 2.95          | 189             |


### Hardest Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.13          | 0.0022          |
| maximum   |  0.01  | 0.17          | 0.0030          |
| frequency |  151   | 7.82          | 445             |


### Averaged Frequencies

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| frequency |  102   | 5.30          | 325             |
