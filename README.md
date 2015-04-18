# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


## Benchmarks (master branch)

The original Python program has been compared with the Swift debug and
release version.

The average time and the maximum time (in seconds) of solving a Sudoku
grid will be measured. Also, the number of solutions per second is
calculated from the average time, this shows a better resolution for
very short solving times.

The release version of the Swift program is about 15 times faster than
the debugging version and performs seven times faster than the original
Python program.


### Easy Puzzles (easy50.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.011         | 0.00073         |
| maximum   |  0.01  | 0.014         | 0.00086         |
| frequency |  199   | 93.7          | 1367            |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 0.036         | 0.0023          |
| maximum   |  0.09  | 0.17          | 0.011           |
| frequency |  56    | 27.7          | 437             |


### Hardest Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.014         | 0.00092         |
| maximum   |  0.01  | 0.018         | 0.0012          |
| frequency |  151   | 73.1          | 1088            |


### Averaged Frequencies

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| frequency |  102   | 49.6          | 762             |
