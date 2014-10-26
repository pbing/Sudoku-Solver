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
the debugging version and performs 1.5 times faster than the original
Python program.


### Easy Puzzles (easy50.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.20          | 0.0034          |
| maximum   |  0.01  | 0.24          | 0.0041          |
| frequency |  199   | 4.98          | 290             |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 0.68          | 0.011           |
| maximum   |  0.09  | 3.2           | 0.048           |
| frequency |  56    | 1.46          | 93.1            |


### Hardest Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.26          | 0.0046          |
| maximum   |  0.01  | 0.34          | 0.0058          |
| frequency |  151   | 3.87          | 217             |
