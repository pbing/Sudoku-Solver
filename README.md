# Sudoku-Solver

Swift implementation of Peter Norvig's [constraint based solver](http://norvig.com/sudoku.html).


## Benchmarks

The original Python program will be compared with the Swift debug and release version.


### Easy Puzzles (easy50.txt)


|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.73          | 0.06            |
| maximum   |  0.01  | 0.86          | 0.075           |
| frequency |  199   | 1.37          | 15.5            |


### Hard Puzzles (top95.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.02  | 2.4           | 0.24            |
| maximum   |  0.09  | 11            | 1.2             |
| frequency |  56    | 0.41          | 4.1             |


### Hardes Puzzles (hardest.txt)

|           | Python | Swift (Debug) | Swift (Release) |
|-----------|--------|---------------|-----------------|
| average   |  0.01  | 0.94          | 0.08            |
| maximum   |  0.01  | 1.2           | 0.14            |
| frequency |  151   | 1.1           | 11              |


## Profiling

The profiler shows, that 69.3 % of the time is spent in search() and
therefore in the double recursive functions eliminate() and assign().

The function eliminate() uses units() and peers() wherein most time is
spent in the Array.append() methods.


### top_level_code():

| Running Time | Symbol Name       |
|--------------|-------------------|
| 99.9 %       | solveAll()        |


### solveAll()

| Running Time | Symbol Name         |
|--------------|---------------------|
| 69.3 %       | search()            |
| 30.6 %       | __allocating_init() |


#### search()

| Running Time | Symbol Name       |
|--------------|-------------------|
| 69.1 %       | assign()          |


#### assign()

| Running Time | Symbol Name       |
|--------------|-------------------|
| 68.9 %       | eliminate()       |

#### eliminate()

| Running Time | Symbol Name                                          |
|--------------|------------------------------------------------------|
| 49.9 %       | assign()                                             |
|  6.9 %       | units()                                              |
|  5.3 %       | Swift._ContiguousArrayStorage.__dealocating_deinit() |
|  4.3 %       | peers()                                              |
|  1.6 %       | \<Swift Int\>: Swift.Array.append()                    |
