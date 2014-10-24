//
//  main.swift
//  Sudoku Solver
//
//  Constraint based solver by Peter Norvig (see http://norvig.com/sudoku.html )
//
//  Created by Bernd Beuster on 23.10.14.
//  Copyright (c) 2014 Bernd Beuster. All rights reserved.
//

import Foundation


let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
let grid2 = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
let file3 = fromFile("easy50.txt", separator: "========")[1]
let grid4 = fromFile("top95.txt")[94]

var grid = Grid(grid: grid2)
println(grid)
