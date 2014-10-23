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

/* Parse a file into a list of strings, separated by separator. */
func fromFile(fileName: String, separator: String = "\n") -> [String] {
    var res = [String]()
    
    if let data = NSData(contentsOfFile: fileName) {
        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
            let res = str.componentsSeparatedByString(separator) as [String]
            return res.filter { !$0.isEmpty }
        }
    }
    return res
}

let grid1 = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
let grid = Grid(grid: grid1)
println(grid)