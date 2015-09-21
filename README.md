# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


## Benchmarks (master branch)

The original Python program has been compared with the Swift debug and
release version.

The average time and the maximum time (in seconds) of solving a Sudoku
grid will be measured. Also, the number of solutions per second is
calculated from the average time, this shows a better resolution for
very short solving times.

The release version of the Swift program is about 13 times faster than
the debugging version and performs seven times faster than the original
Python program.


### Easy Puzzles (easy50.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.011         | 0.00094         |
| maximum   |  0.01  | 0.011         | 0.00100         |
| frequency |  216   | 113           | 1348            |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 0.136         | 0.0103          |
| maximum   |  0.08  | 0.137         | 0.0105          |
| frequency |  61    | 34.1          | 455             |


### Hardest Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.0151        | 0.00115         |
| maximum   |  0.01  | 0.0154        | 0.00117         |
| frequency |  167   | 88.7          | 1124            |


### Averaged Frequencies

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| frequency |  111   | 60.7          | 783             |
