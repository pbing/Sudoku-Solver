# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


# Benchmarks

The original Python program will be compared with the Swift debug and release version.


## Easy Puzzles (easy50.txt)


|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.73          | 0.06            |
| maximum   |  0.01  | 0.86          | 0.075           |
| frequency |  199   | 1.37          | 15.5            |


## Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 2.4           | 0.24            |
| maximum   |  0.09  | 11            | 1.2             |
| frequency |  56    | 0.41          | 4.1             |


## Hardes Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.94          | 0.08            |
| maximum   |  0.01  | 1.2           | 0.14            |
| frequency |  151   | 1.1           | 11              |
