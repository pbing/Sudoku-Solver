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
let grid2 = fromFile("easy50.txt", separator: "========")[1]
let grid3 = fromFile("top95.txt")[94]

let grid = Grid(grid: grid1)
println(grid)

//println(grid.assign(grid.values, s: (2*9 + 1), d: Square(0b000000001)))
