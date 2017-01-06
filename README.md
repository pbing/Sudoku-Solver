# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


## Benchmarks (master branch)

The original Python program has been compared with the Swift debug and
release version.

The average time and the maximum time (in seconds) of solving a Sudoku
grid will be measured. Also, the number of solutions per second is
calculated from the average time, this shows a better resolution for
very short solving times.

The release version of the Swift program is about seven times faster than
the debugging version and the original Python program.


### Easy Puzzles (easy50.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.0042        | 0.00066         |
| maximum   |  0.01  | 0.0060        | 0.00086         |
| frequency |  216   | 236           | 1517            |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 0.015         | 0.0022          |
| maximum   |  0.08  | 0.068         | 0.0115          |
| frequency |  61    | 68.6          | 460             |


### Hardest Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.0057        | 0.00082         |
| maximum   |  0.01  | 0.0079        | 0.00109         |
| frequency |  167   | 175           | 1227            |


### Averaged Frequencies

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| frequency |  111   | 122           | 822             |
